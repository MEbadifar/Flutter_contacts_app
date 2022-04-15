class Contact {
  Contact({
    required this.phone,
    required this.fllname,
  });

  late final String phone;
  late final String fllname;

  Contact.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    fllname = json['fllname'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['phone'] = phone;
    _data['fllname'] = fllname;
    return _data;
  }
}
