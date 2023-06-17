class plantDetailsDisplay{
  late String name;
  late String latinName;
  late String image;
  late String description;

  late String waterDetails;
  late String fertilizationDetails;
  late String pruningDetails;
  late String soilDetails;
  late String sunlightDetails;

  plantDetailsDisplay(){
    this.name = "Loading Data...";
    this.latinName = "Loading Data...";
    this.image = "Loading Data...";
    this.description = "Loading Data...";
    this.waterDetails = "Loading Data...";
    this.fertilizationDetails = "Loading Data...";
    this.pruningDetails = "Loading Data...";
    this.soilDetails = "Loading Data...";
    this.sunlightDetails = "Loading Data...";
  }



  //Setters
  void setName(var name){
    this.name = name;
  }

  void setLatinName(var latinName){
    this.latinName = latinName;
  }

  void setImage(var image){
    this.image = image;
  }

  void setDescription(var description){
    this.description = description;
  }

  void setWaterDetails(var waterDetails){
    this.waterDetails = waterDetails;
  }

  void setFertilizationDetails(var fertilizationDetails){
    this.fertilizationDetails = fertilizationDetails;
  }

  void setPruningDetails(var pruningDetails){
    this.pruningDetails = pruningDetails;
  }

  void setSoilDetails(var soilDetails){
    this.soilDetails = soilDetails;
  }

  void setSunlightDetails(var sunlightDetails){
    this.sunlightDetails = sunlightDetails;
  }
}