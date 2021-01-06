class FirestoreCollection {
  static const String users = "users";
  static const String profile = "profile";
  static const String orders = "orders";
  static const String exchange_rates = "exchange_rates";
  static const String exchange_rates_time_series = "exchange_rates_time_series";

  static const String businesses = "businesses";

  static String getUserBankAccountsCollectionPath(String uid) {
    String bankAccounts = "bank_accounts";
    return users + '/' + uid + '/' + bankAccounts;
  }

  static String getBusinessBankAccountsCollectionPath(String uid) {
    String bankAccounts = "business_bank_accounts";
    return businesses + '/' + uid + '/' + bankAccounts;
  }
}
