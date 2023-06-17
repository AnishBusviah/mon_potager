class searchResult {
  late final String commonName;
  late final String thumbnail;
  late final String latinName;

  // var  response;

  searchResult({required List<String> name, required image, required otherName}) {
    commonName = name[0];
    thumbnail = image.substring(41);
    latinName = otherName.replaceAll("'", "_").replaceAll(" ", "_");


  }

  // searchResult({required response});

  // factory searchResult.fromJson(Map<String, dynamic> json){
  //   return searchResult(response: json["message"]);
  // }

  factory searchResult.fromJson(Map<String, dynamic> json) {
    var names = json["commonNames"];

    return searchResult(
      name: new List<String>.from(names),
      image: json["mainImageUrl"],
      otherName: json["latinName"],
    );
  }
}