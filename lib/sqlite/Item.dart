class Item {
  int _id;
  String _name;
  int _serialnumber;
  int _qty;

  get id => this._id;

  get serialnumber => this._serialnumber;
  set serialnumber(value) => this._serialnumber = value;

  get name => this._name;
  set name(value) => this._name = value;

  get qty => this._qty;
  set qty(value) => this._qty = value;

  // konstruktor versi 1
  Item(this._name, this._serialnumber, this._qty);

  // konstruktor versi 2: konversi dari Map ke Item
  Item.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._serialnumber = map['serialnumber'];
    this._qty = map['qty'];
  }

  // konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = name;
    map['serialnumber'] = serialnumber; // memanggil set get
    map['qty'] = qty;
    return map;
  }
}
