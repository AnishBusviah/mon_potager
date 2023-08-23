class DataModel {
  final String title;
  final String imageName;
  final String price;
  DataModel(
    this.title,
    this.imageName,
    this.price,
  );
}

List<DataModel> dataList = [
  DataModel("Step 1", "assets/careGuides/Mint/1.jpg",
      "Choose a well-draining soil mix for planting mint."),
  DataModel("Step 2", "assets/careGuides/Mint/2.png",
      "Plant mint in a sunny to partially shaded location with regular watering."),
  DataModel("Step 3", "assets/careGuides/Mint/3.png",
      "Water mint consistently to keep the soil evenly moist, but not waterlogged."),
  DataModel("Step 4", "assets/careGuides/Mint/4.jpeg",
      "Apply a balanced fertilizer every 4-6 weeks during the growing season."),
  DataModel("Step 5", "assets/careGuides/Mint/5.jpg",
      "Trim mint regularly to promote bushy growth and prevent it from becoming too leggy."),
  DataModel("Step 6", "assets/careGuides/Mint/6.jpg",
      "Watch for pests like aphids or spider mites and treat as needed."),
  DataModel("Step 7", "assets/careGuides/Mint/7.jpg",
      "Consider planting mint in containers to control its spread in the garden."),
  DataModel("Step 8", "assets/careGuides/Mint/8.jpg",
      "Divide and replant mint every 2 - 3 years to maintain its vigor."),
  DataModel("Step 9", "assets/careGuides/Mint/9.jpg",
      "Harvest mint leaves for culinary use by pinching off stems just above a pair of leaves."),
  DataModel("Step 10", "assets/careGuides/Mint/10.jpeg",
      "Enjoy the fresh flavor of your homegrown mint in various dishes and drinks."),
];
