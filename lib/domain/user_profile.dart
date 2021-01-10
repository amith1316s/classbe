import 'package:classbe/domain/address.dart';
import 'package:classbe/domain/business_profile.dart';
import 'package:classbe/domain/firestore_field.dart';
import 'package:classbe/domain/mobile_number.dart';

class UserProfile {
  String uid,
      email,
      firstName,
      lastName,
      twitter,
      facebook,
      instagram,
      account,
      role,
      imageUrl;

  MobilePhone mobilePhone = MobilePhone();
  Address address = Address();
  BusinessProfile businessProfile = BusinessProfile();
  DateTime memberSince;

  UserProfile();

  UserProfile.fromFirestore(Map<String, dynamic> data) {
    uid = data[FirestoreField.profile][FirestoreField.uid];
    email = data[FirestoreField.profile][FirestoreField.email];
    role = data[FirestoreField.profile][FirestoreField.role];
    firstName = data[FirestoreField.profile][FirestoreField.first_name];
    lastName = data[FirestoreField.profile][FirestoreField.last_name];
    mobilePhone.iso = data[FirestoreField.profile][FirestoreField.mobile_phone]
        [FirestoreField.iso];
    mobilePhone.code = data[FirestoreField.profile][FirestoreField.mobile_phone]
        [FirestoreField.code];
    mobilePhone.number = data[FirestoreField.profile]
        [FirestoreField.mobile_phone][FirestoreField.number];
    address.street = data[FirestoreField.profile][FirestoreField.address]
        [FirestoreField.street];
    address.city = data[FirestoreField.profile][FirestoreField.address]
        [FirestoreField.city];
    address.country = data[FirestoreField.profile][FirestoreField.address]
        [FirestoreField.country];
    memberSince = DateTime.parse(data[FirestoreField.profile]
            [FirestoreField.member_since]
        .toDate()
        .toString());
    account = data[FirestoreField.profile][FirestoreField.account];
    twitter = data[FirestoreField.profile][FirestoreField.twitter];
    instagram = data[FirestoreField.profile][FirestoreField.instagram];
    facebook = data[FirestoreField.profile][FirestoreField.facebook];
    imageUrl = data[FirestoreField.profile][FirestoreField.image_url];

    if (data[FirestoreField.business_profile] != null) {
      businessProfile = BusinessProfile.fromFirestore(data);
    }
  }

  Map<String, dynamic> toFirestore() {
    return ({
      FirestoreField.profile: {
        FirestoreField.uid: uid,
        FirestoreField.email: email,
        FirestoreField.role: role,
        FirestoreField.first_name: firstName,
        FirestoreField.last_name: lastName,
        FirestoreField.address: {
          FirestoreField.street: address.street,
          FirestoreField.city: address.city,
          FirestoreField.country: address.country,
        },
        FirestoreField.mobile_phone: {
          FirestoreField.iso: mobilePhone.iso,
          FirestoreField.code: mobilePhone.code,
          FirestoreField.number: mobilePhone.number,
        },
        FirestoreField.member_since: memberSince,
        FirestoreField.account: account,
        FirestoreField.twitter: twitter,
        FirestoreField.instagram: instagram,
        FirestoreField.facebook: facebook,
        FirestoreField.image_url: imageUrl,
      }
    });
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

  String getFullName() {
    return firstName + " " + lastName;
  }
}
