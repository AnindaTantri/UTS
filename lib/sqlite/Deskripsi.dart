class Deskripsi {
  int _id;
  String _name;
  int _serialnumber;
  String _keterangan;

  get id => this._id;

  get serialnumber => this._serialnumber;
  set serialnumber(value) => this._serialnumber = value;

  get name => this._name;
  set name(value) => this._name = value;

  get keterangan => this._keterangan;
  set keterangan(value) => this._keterangan = value;

  // konstruktor versi 1
  Deskripsi(this._name, this._serialnumber, this._keterangan);

  // konstruktor versi 2: konversi dari Map ke Item
  Deskripsi.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._serialnumber = map['serialnumber'];
    this._keterangan = map['keterangan'];
  }

  // konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = name;
    map['serialnumber'] = serialnumber; // memanggil set get
    map['keterangan'] = _keterangan;
    return map;
  }
}
