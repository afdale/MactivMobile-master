class Masjid{
  int masjidId;
  String name;
  int masjidType;
  String phone;
  String address;
  double longitude;
  double latitude;
  String photo;

  Masjid({
    this.masjidId,
    this.name,
    this.masjidType,
    this.phone,
    this.address,
    this.longitude,
    this.latitude,
    this.photo
  });

  Masjid.fromJson(Map<String, dynamic> json):
    masjidId = json['masjidId'],
    name = json['name'],
    masjidType = json['masjidType'],
    phone = json['phone'],
    address = json['address'],
    longitude = json['longitude'],
    latitude = json['latitude'],
    photo = json['photo'];

  Map<String, dynamic> toJson() =>{
    'masjidId' : masjidId,
    'name' : name,
    'masjidType' : masjidType,
    'phone' : phone,
    'address' : address,
    'longitude' : longitude,
    'latitude' : latitude,
    'photo' : photo
  };

  Map<String, String> toJsonString() =>{
    'masjidId' : masjidId.toString(),
    'name' : name,
    'masjidType' : masjidType.toString(),
    'phone' : phone,
    'address' : address,
    'longitude' : longitude.toString(),
    'latitude' : latitude.toString(),
    'photo' : photo
  };
}