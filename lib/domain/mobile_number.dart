class MobilePhone {
  String iso, code, number;

  MobilePhone({this.iso, this.code, this.number});

  String getFullMobilePhoneNumber() {
    return code + number;
  }
}
