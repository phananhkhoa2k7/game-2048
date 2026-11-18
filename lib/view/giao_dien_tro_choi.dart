import '../controller/quan_ly_tro_choi.dart';

/// Hop dong chung cho cac giao dien khong dung widget (vi du: console).
/// Giao dien Flutter la cay widget quan sat Controller nen khong can implement lop nay.
abstract class GiaoDienTroChoi {
  void hienThi(QuanLyTroChoi quanLy);
  void chay(QuanLyTroChoi quanLy);
}
