// class UserList {
//   UserList({
//     required this.data,
//   });
//   late final List<User> data;
//
//   UserList.fromJson(Map<String, dynamic> json){
//     data = List.from(json['data']).map((e)=>User.fromJson(e)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['data'] = data.map((e)=>e.toJson()).toList();
//     return _data;
//   }
// }

class UserList {
  List<User> userList=[];

  UserList({required this.userList});

  /// Parse the server response
  UserList.fromJsonMap(List<dynamic> responseMap) {
    if (null != responseMap && responseMap.isNotEmpty) {
      for (dynamic result in responseMap) {
        User _employee = new User.fromJson(result);
        if (null != _employee) {
          userList.add(_employee);
        }
      }
    }
  }
}


class User {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });
  late final int id;
  late final String name;
  late final String username;
  late final String email;
  late final Address address;
  late final String phone;
  late final String website;
  late final Company company;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    address = Address.fromJson(json['address']);
    phone = json['phone'];
    website = json['website'];
    company = Company.fromJson(json['company']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['username'] = username;
    _data['email'] = email;
    _data['address'] = address.toJson();
    _data['phone'] = phone;
    _data['website'] = website;
    _data['company'] = company.toJson();
    return _data;
  }
}

class Address {
  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });
  late final String street;
  late final String suite;
  late final String city;
  late final String zipcode;
  late final Geo geo;

  Address.fromJson(Map<String, dynamic> json){
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
    geo = Geo.fromJson(json['geo']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['street'] = street;
    _data['suite'] = suite;
    _data['city'] = city;
    _data['zipcode'] = zipcode;
    _data['geo'] = geo.toJson();
    return _data;
  }
}

class Geo {
  Geo({
    required this.lat,
    required this.lng,
  });
  late final String lat;
  late final String lng;

  Geo.fromJson(Map<String, dynamic> json){
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}

class Company {
  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });
  late final String name;
  late final String catchPhrase;
  late final String bs;

  Company.fromJson(Map<String, dynamic> json){
    name = json['name'];
    catchPhrase = json['catchPhrase'];
    bs = json['bs'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['catchPhrase'] = catchPhrase;
    _data['bs'] = bs;
    return _data;
  }
}