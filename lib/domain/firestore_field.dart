class FirestoreField {
  static const String profile = "profile";
  static const String business_profile = "business_profile";
  static const String exchange_rate = "exchange_rate";

  static const String mobile_phone = "mobile_phone";

  static const String dealer = "dealer";

  static const String user_uid = "user_uid";
  static const String uid = "uid";
  static const String first_name = "first_name";
  static const String last_name = "last_name";
  static const String role = "role";

  static const String address = "address";
  static const String street = "street";
  static const String city = "city";
  static const String country = "country";

  static const String number = "number";
  static const String code = "code";

  static const String member_since = "member_since";
  static const String twitter = "twitter";
  static const String facebook = "facebook";
  static const String instagram = "instagram";
  static const String account = "account";
  static const String email = "email";
  static const String image_url = "image_url";

  static const String profile_complete = "profile_complete";

  static const String website = "website";

  static const String verified = "verified";

  static const String sort_code = "sort_code";
  static const String account_number = "account_number";
  static const String account_name = "account_name";
  static const String bank = "bank";

  static const String iso = "iso";
  static const String name = "name";
  static const String icon = "icon";

  static const String business_name = "business_name";

  static const String currency = "currency";

  static const String date = "date";

  static const String base_currency = "base_currency";
  static const String term_currency = "term_currency";
  static const String buy_rate = "buy_rate";
  static const String sell_rate = "sell_rate";

  static const String buy_country = "buy_country";
  static const String sell_country = "sell_country";

  static const String notes = "notes";
  static const String direction = "direction";
  static const String status = "status";

  static const String buy_amount = "buy_amount";
  static const String sell_amount = "sell_amount";

  static const String payment_account = "payment_account";

  static const String user_payment_account = "user_payment_account";
  static const String dealer_payment_account = "dealer_payment_account";

  static const String sort = "sort";

  static const String fee = "fee";
  static const String rate = "rate";

  static String singleNestedPath(String firstObject, String variable) {
    return firstObject + "." + variable;
  }

  static String doubleNestedPath(
      String firstObject, String secondObject, String variable) {
    return firstObject + "." + secondObject + "." + variable;
  }
}
