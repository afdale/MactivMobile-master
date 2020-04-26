class JadwalSholat {
  final List<String> prayer;

  JadwalSholat.fromJson(Map<String, dynamic> json)
      : prayer = [
          json['fajr'],
          json['sunrise'],
          json['zuhr'],
          json['asr'],
          json['maghrib'],
          json['isya'],
        ];

  Map<String, List<String>> toJson() => {'prayer': prayer};
}
