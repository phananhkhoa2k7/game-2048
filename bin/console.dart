// Chay ban console:  dart run bin/console.dart
// Dung chung Model + Controller voi ban Flutter, chi khac View.
import '../lib/controller/quan_ly_tro_choi.dart';
import '../lib/view/console/giao_dien_console.dart';

void main() {
  GiaoDienConsole().chay(QuanLyTroChoi());
}
