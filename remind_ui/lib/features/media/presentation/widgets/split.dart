class SplitDate {
  String splitdate(String date) {
    var cur = '';
    for (int i = 0; i < 10; i++) {
      cur += date[i];
    }
    return cur;
  }

  String splittime(String date) {
    var cur = '';
    for (int i = 11; i < 19; i++) {
      cur += date[i];
    }
    return cur;
  }
}

SplitDate split = SplitDate();
