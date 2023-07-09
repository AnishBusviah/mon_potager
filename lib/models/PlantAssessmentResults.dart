class PlantAssessmentResults {
  late bool isHealthy;
  late double isHealthyProbability;
  late List<dynamic> diseasesList;
  late List<Diseases> diseases = [];
  late List<DiseaseDetails> disease;

  PlantAssessmentResults({
    required this.isHealthy,
    required this.isHealthyProbability,
    required this.diseasesList,
  }) {
    for (Map<String, dynamic> d in diseasesList) {
      diseases.add(new Diseases.fromJson(d));
    }
  }

  factory PlantAssessmentResults.fromJson(Map<String, dynamic> json) {
    return PlantAssessmentResults(
      isHealthy: json["is_healthy"],
      isHealthyProbability: json["is_healthy_probability"],
      diseasesList: json["diseases"],
    );
  }
}

class Diseases {
  late List<Map<String, dynamic>> similarImagesList;
  late Map<String, dynamic> diseaseDetailsMap;

  // late List<SimilarImages> similarImages;
  late DiseaseDetails diseaseDetails;

  Diseases({
    // required this.similarImagesList,
    required this.diseaseDetailsMap}) {
    // for (Map<String, dynamic> s in similarImagesList) {
    //   similarImages.add(new SimilarImages.fromJson(s));
    // }

    diseaseDetails = DiseaseDetails.fromJson(diseaseDetailsMap);
  }

  // Diseases() {
  //   this.similarImages = [];
  //   this.diseaseDetails = {};
  // }

  factory Diseases.fromJson(Map<String, dynamic> json) {
    return Diseases(
      // similarImagesList: json["similar_images"],
      diseaseDetailsMap: json["disease_details"],
    );
  }
}

class SimilarImages {
  late String id;
  late String similarity;
  late String url;
  late String urlSmall;

  SimilarImages({required this.id,
    required this.similarity,
    required this.url,
    required this.urlSmall}) {}

  factory SimilarImages.fromJson(Map<String, dynamic> similar_images) {
    return SimilarImages(
        id: similar_images["id"],
        similarity: similar_images["similarity"],
        url: similar_images["url"],
        urlSmall: similar_images["url_small"]);
  }
}

class DiseaseDetails {
  late String localName;
  late String description;
  late Map<String, dynamic> treatmentMap;

  late Treatment treatment;

  // DiseaseDetails() {
  //   this.localName = "";
  //   this.description = "";
  //   this.treatment = {};
  // }

  DiseaseDetails({required this.localName,
    required this.description,
    required this.treatmentMap}) {
    treatment = new Treatment.fromJson(treatmentMap);
  }

  factory DiseaseDetails.fromJson(Map<String, dynamic> disease_details) {
    return DiseaseDetails(
        localName: disease_details["local_name"],
        description: disease_details["description"],
        treatmentMap: disease_details["treatment"]);
  }
}

class Treatment {
  late List<dynamic> chemical;
  late List<dynamic> biological;
  late List<dynamic> prevention;

  // Treatment() {
  //   this.biological = [];
  //   this.chemical = [];
  //   this.prevention = [];
  // }

  Treatment({required this.chemical,
    required this.prevention,
    required this.biological}) {}


  factory Treatment.fromJson(Map<String, dynamic> treatment) {
    try {
      return Treatment(
          chemical: treatment["chemical"],
          prevention: treatment["prevention"],
          biological: treatment["biological"]);
    } catch (Exception){
      return Treatment(chemical: [], prevention: [], biological: []);
    }
  }
}
