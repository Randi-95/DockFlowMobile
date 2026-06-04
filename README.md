# Aplikasi Mobile DockFlow

DockFlow Mobile adalah aplikasi mobile cross-platform yang dibangun dengan Flutter. Aplikasi ini dirancang untuk memudahkan kru dan sopir mengelola pesanan mereka secara langsung dari lapangan, menjalankan tugas operasional, serta mengunggah Bukti Pengiriman (Proof of Delivery / POD).

## 🚀 Fitur

- **Pemesanan Logistik (Smart Order)**: Kru dapat menelusuri katalog barang, menambahkan ke keranjang, dan melakukan *checkout* pesanan dengan menentukan nama kapal dan lokasi sandar (dermaga) secara spesifik.
- **Tinjauan & Manajemen Pemesanan**: Pengguna dapat melihat pemesanan yang ditugaskan, riwayat pesanan yang mendetail, serta memperbarui progres tugas.
- **Serah Terima Digital (QR Handover)**: Menampilkan QR Code resi pesanan yang siap dipindai oleh sistem kamera Gudang (Web) untuk memvalidasi *Chain of Custody* (perpindahan tanggung jawab) secara aman dan instan.
- **Upload Bukti Pengiriman (POD)**: Integrasi langsung untuk mengambil dan mengunggah bukti foto pengiriman ketika pesanan mencapai status "on_delivery".
- **Push Notification**: Pembaruan dan peringatan real-time yang didukung oleh Firebase Cloud Messaging.
- **State Management yang Aman**: Penanganan state aplikasi yang robust menggunakan arsitektur BLoC (`flutter_bloc`).

## 🛠 Teknologi yang Digunakan

- **Framework**: [Flutter](https://flutter.dev) (SDK ^3.11.4)
- **Bahasa Pemrograman**: Dart
- **State Management**: `flutter_bloc`
- **Networking**: `dio`
- **Layanan Backend**: Firebase Core & Firebase Messaging
- **Penyimpanan Lokal**: `shared_preferences` & `flutter_secure_storage`
- **Komponen UI**: `cupertino_icons`, `art_sweetalert`
- **Media**: `image_picker`

## ⚙️ Instalasi & Persiapan

1. **Prasyarat:**
   Pastikan Anda telah [menginstal Flutter](https://docs.flutter.dev/get-started/install) dan menjalankan emulator (atau memiliki perangkat asli yang terhubung).

2. **Clone repositori:**
   ```bash
   git clone <url-repositori>
   cd dockflow_app
   ```

3. **Instal Dependensi:**
   ```bash
   flutter pub get
   ```

4. **Jalankan Aplikasi:**
   ```bash
   flutter run
   ```

## 📂 Struktur Proyek

- `lib/features/`: Berisi modul fitur inti aplikasi (misalnya Home, Booking, Auth) yang menggunakan arsitektur BLoC.
- `lib/assets/`: Menyimpan gambar dan aset statis lainnya (logo, placeholder, dll).
