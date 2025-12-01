class CheckboxStateManager {
  bool value1;
  bool value2;
  bool value3;
  bool value4;
  bool value5;
  bool value6;
  bool value7;
  bool value8;
  bool value9;
  bool value10;

  CheckboxStateManager({
    this.value1 = false,
    this.value2 = false,
    this.value3 = false,
    this.value4 = false,
    this.value5 = false,
    this.value6 = false,
    this.value7 = false,
    this.value8 = false,
    this.value9 = false,
    this.value10 = false,
  });

  void toggleValue(int index) {
    switch (index) {
      case 1: value1 = !value1; break;
      case 2: value2 = !value2; break;
      case 3: value3 = !value3; break;
      case 4: value4 = !value4; break;
      case 5: value5 = !value5; break;
      case 6: value6 = !value6; break;
      case 7: value7 = !value7; break;
      case 8: value8 = !value8; break;
      case 9: value9 = !value9; break;
      case 10: value10 = !value10; break;
    }
  }
}
