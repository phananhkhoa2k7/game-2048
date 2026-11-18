/// Mot o tren bang. giaTri == 0 nghia la o trong.
class OSo {
  static int _demId = 0;

  final int id = _demId++; // View dung id de lam hieu ung truot
  int giaTri;
  int dong, cot; // vi tri hien tai tren bang
  bool moi = false; // o vua duoc sinh ra

  OSo({this.giaTri = 0, this.dong = 0, this.cot = 0});

  bool laTrong() {
    return giaTri == 0;
  }

  void xoaGiaTri() {
    giaTri = 0;
  }
}
