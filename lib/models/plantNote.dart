class PlantNote {
  String note = "";
  String date = "";
  String image = "";


  PlantNote({
    required this.note,
    required this.date,
    required this.image,
  });


  PlantNote.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    date = json['date'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['note'] = this.note;
    data['date'] = this.date;
    data['image'] = this.image;
    return data;
  }
}
