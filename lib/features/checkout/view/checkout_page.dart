import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dockflow_app/features/cart/models/cart_item_model.dart';
import 'package:dockflow_app/features/cart/services/cart_service.dart';
import 'package:dockflow_app/features/checkout/models/vessel_model.dart';
import 'package:dockflow_app/features/checkout/services/checkout_service.dart';

class CheckoutPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const CheckoutPage({super.key, required this.cartItems});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final CheckoutService _checkoutService = CheckoutService();
  final CartService _cartService = CartService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dockLocationController = TextEditingController();
  final TextEditingController _vesselController = TextEditingController();
  
  List<Vessel> _vessels = [];
  int? _selectedVesselId;
  DateTime? _selectedDate;
  bool _isLoading = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _fetchVessels();
  }

  Future<void> _fetchVessels() async {
    setState(() => _isLoading = true);
    try {
      final vessels = await _checkoutService.getVessels();
      setState(() {
        _vessels = vessels;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load vessels: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0XFF003366),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _submitCheckout() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih estimasi tanggal pengiriman')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final itemsData = widget.cartItems.map((item) => {
        'product_id': item.productId,
        'qty': item.quantity,
        'price_at_booking': item.price,
      }).toList();

      final data = {
        'vessel_id': _selectedVesselId,
        'vessel_name': _vesselController.text,
        'dock_location': _dockLocationController.text,
        'estimated_delivery_date': DateFormat('yyyy-MM-dd').format(_selectedDate!),
        'items': itemsData,
      };

      final success = await _checkoutService.checkout(data);

      if (success) {
        await _cartService.clearCart();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Checkout berhasil!')),
          );
          // Navigate back twice to go to Home/Inventory instead of Cart
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      } else {
        throw Exception("Failed");
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal melakukan checkout: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    int totalPrice = widget.cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

    return Scaffold(
      backgroundColor: const Color(0XFFF9FBFE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0XFF003366)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: Color(0XFF003366),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0XFF003366)))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Data Pengiriman",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0XFF003366)),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Autocomplete<Vessel>(
                            optionsBuilder: (TextEditingValue textEditingValue) {
                              if (textEditingValue.text.isEmpty) {
                                return const Iterable<Vessel>.empty();
                              }
                              return _vessels.where((Vessel vessel) {
                                return vessel.name.toLowerCase().contains(textEditingValue.text.toLowerCase());
                              });
                            },
                            displayStringForOption: (Vessel option) => option.name,
                            onSelected: (Vessel selection) {
                              setState(() {
                                _selectedVesselId = selection.id;
                                _vesselController.text = selection.name;
                              });
                            },
                            fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                              // Sync controllers
                              textEditingController.addListener(() {
                                _vesselController.text = textEditingController.text;
                                // Reset vesselId if text changes
                                if (_selectedVesselId != null && textEditingController.text != _vessels.firstWhere((v) => v.id == _selectedVesselId).name) {
                                   setState(() => _selectedVesselId = null);
                                }
                              });
                              
                              return TextFormField(
                                controller: textEditingController,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  labelText: "Nama Kapal",
                                  hintText: "Cari atau masukkan nama kapal",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nama kapal tidak boleh kosong';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _dockLocationController,
                            decoration: InputDecoration(
                              labelText: "Lokasi Dock",
                              hintText: "Contoh: Dock A, Pelabuhan Tanjung Perak",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Lokasi dock tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          InkWell(
                            onTap: () => _selectDate(context),
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: "Estimasi Pengiriman",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _selectedDate == null 
                                      ? "Pilih Tanggal" 
                                      : DateFormat('dd MMMM yyyy', 'id').format(_selectedDate!),
                                    style: TextStyle(
                                      color: _selectedDate == null ? Colors.grey : Colors.black87,
                                    ),
                                  ),
                                  const Icon(Icons.calendar_today, size: 20, color: Color(0XFF003366)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Ringkasan Pesanan",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0XFF003366)),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          ...widget.cartItems.map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${item.name} (${item.quantity} ${item.unit})",
                                    style: const TextStyle(fontSize: 14),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  currencyFormatter.format(item.price * item.quantity),
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total Harga",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                currencyFormatter.format(totalPrice),
                                style: const TextStyle(
                                  color: Color(0XFF0052CC),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: _isSubmitting ? null : _submitCheckout,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0XFF0052CC),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isSubmitting 
              ? const SizedBox(
                  width: 24, 
                  height: 24, 
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                )
              : const Text(
                  "Kirim Pesanan",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
          ),
        ),
      ),
    );
  }
}
