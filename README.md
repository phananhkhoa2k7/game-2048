<<<<<<< HEAD
# 2048 – Nhóm 4 (Lập Trình Hướng Đối Tượng)

Trò chơi 2048 (bảng 4×4) viết bằng Flutter/Dart theo mô hình **MVC**.
=======
# Trò Chơi 2048

Dự án Flutter đơn giản cho học phần lập Trình Hướng Đối Tượng
>>>>>>> 21ebb7a21209180f588e652e9c18a1ced29c29ea

## Cấu trúc

```
lib/
├── main.dart                       điểm vào của bản Flutter
├── model/                          MODEL – Dart thuần, không import Flutter
│   ├── o_so.dart                   OSo: một ô số
│   ├── bang_dau.dart               BangDau: bảng 4×4, luật trượt/gộp ô
│   ├── cai_dat.dart                CaiDat: bật/tắt nhạc & âm thanh
│   ├── huong_di.dart               enum HuongDi
│   ├── trang_thai_tro_choi.dart    enum TrangThaiTroChoi
│   └── doi_tuong_quan_sat.dart     cơ chế Observer
├── controller/                     CONTROLLER – Dart thuần
│   └── quan_ly_tro_choi.dart       QuanLyTroChoi: lượt đi, điểm, tạm dừng, Game Over
└── view/                           VIEW
    ├── giao_dien_tro_choi.dart     interface cho giao diện không dùng widget
    ├── console/giao_dien_console.dart
    ├── ung_dung.dart, dich_vu_am_thanh.dart
    ├── man_hinh/                   màn hình Flutter (chính, trò chơi, cài đặt, giới thiệu)
    ├── thanh_phan/                 widget dùng lại (bảng, ô, nút, lớp phủ…)
    └── theme/                      màu sắc, kiểu chữ
bin/console.dart                    điểm vào của bản console
```

## Chạy

```bash
flutter pub get
flutter run -d chrome          # bản Flutter (web)
dart run bin/console.dart      # bản console
```
