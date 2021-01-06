import 'package:classbe/domain/firestore_field.dart';

import 'address.dart';
import 'mobile_number.dart';

class BusinessProfile {
  String uid,
      businessName,
      email,
      firstName,
      lastName,
      twitter,
      instagram,
      website;

  MobilePhone mobilePhone;
  Address address;
  DateTime memberSince;

  bool verified = false;
  bool profileComplete = false;

  BusinessProfile({this.address, this.mobilePhone});

  void init() {
    mobilePhone = MobilePhone();
    address = Address();
  }

  String getFullAddress() {
    String fullAdresss = "";
    if (address != null) {
      if (address.street != null) {
        fullAdresss = fullAdresss + address.street + ", ";
      }
      if (address.city != null) {
        fullAdresss = fullAdresss + address.city + ", ";
      }
      if (address.country != null) {
        fullAdresss = fullAdresss + address.country;
      }
    }
    return fullAdresss;
  }

  BusinessProfile.fromFirestore(Map<String, dynamic> data) {
    // init
    init();

    uid = data[FirestoreField.business_profile][FirestoreField.uid];
    businessName =
        data[FirestoreField.business_profile][FirestoreField.business_name];
    firstName =
        data[FirestoreField.business_profile][FirestoreField.first_name];
    lastName = data[FirestoreField.business_profile][FirestoreField.last_name];
    email = data[FirestoreField.business_profile][FirestoreField.email];

    if (data[FirestoreField.business_profile][FirestoreField.mobile_phone] !=
        null) {
      mobilePhone.iso = data[FirestoreField.business_profile]
          [FirestoreField.mobile_phone][FirestoreField.iso];
      mobilePhone.code = data[FirestoreField.business_profile]
          [FirestoreField.mobile_phone][FirestoreField.code];
      mobilePhone.number = data[FirestoreField.business_profile]
          [FirestoreField.mobile_phone][FirestoreField.number];
    }

    if (data[FirestoreField.business_profile][FirestoreField.address] != null) {
      address.street = data[FirestoreField.business_profile]
          [FirestoreField.address][FirestoreField.street];
      address.city = data[FirestoreField.business_profile]
          [FirestoreField.address][FirestoreField.city];
      address.country = data[FirestoreField.business_profile]
          [FirestoreField.address][FirestoreField.country];
    }
    memberSince = getMemberSince(data);
    twitter = data[FirestoreField.business_profile][FirestoreField.twitter];
    instagram = data[FirestoreField.business_profile][FirestoreField.instagram];
    website = data[FirestoreField.business_profile][FirestoreField.website];
    verified = data[FirestoreField.business_profile][FirestoreField.verified];

    profileComplete =
        data[FirestoreField.business_profile][FirestoreField.profile_complete];
  }

  Map<String, dynamic> toFirestore() {
    return ({
      FirestoreField.business_profile: {
        FirestoreField.uid: uid,
        FirestoreField.business_name: businessName,
        FirestoreField.first_name: firstName,
        FirestoreField.last_name: lastName,
        FirestoreField.email: email,
        FirestoreField.mobile_phone: {
          FirestoreField.iso: mobilePhone.iso,
          FirestoreField.code: mobilePhone.code,
          FirestoreField.number: mobilePhone.number,
        },
        FirestoreField.address: {
          FirestoreField.street: address.street,
          FirestoreField.city: address.city,
          FirestoreField.country: address.country,
        },
        FirestoreField.member_since: memberSince,
        FirestoreField.twitter: twitter,
        FirestoreField.instagram: instagram,
        FirestoreField.website: website,
        FirestoreField.verified: verified,
        FirestoreField.profile_complete: profileComplete,
      }
    });
  }

  DateTime getMemberSince(Map<String, dynamic> data) {
    if (data[FirestoreField.business_profile][FirestoreField.member_since] !=
        null) {
      return DateTime.parse(data[FirestoreField.business_profile]
              [FirestoreField.member_since]
          .toDate()
          .toString());
    }
    return null;
  }

  String getFullName() {
    return firstName + " " + lastName;
  }
}
