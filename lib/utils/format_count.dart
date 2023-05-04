String getPluralForm(int value, String one, String few, String many) {
  int mod10 = value % 10;
  int mod100 = value % 100;
  if (mod10 == 1 && mod100 != 11) {
    return one;
  } else if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) {
    return few;
  } else {
    return many;
  }
}