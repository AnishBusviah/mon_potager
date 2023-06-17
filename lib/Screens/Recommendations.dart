import 'package:flutter/material.dart';

class RecScreen extends StatelessWidget {
  const RecScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommendation',
            style: TextStyle(color: Colors.black, fontSize: 25)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(164, 93, 219, 185),
              Color.fromARGB(240, 54, 57, 51),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 200,
                  width: 600,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://cdn.shopify.com/s/files/1/0622/8508/6951/articles/Watering_Herbs_700x.jpg?v=1648149528"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'HERBS',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 200,
                  width: 600,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://cdn.shopify.com/s/files/1/0569/9675/7697/files/how-to-garden-indoors_1024x1024.jpg?v=1648041414"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'INDOOR GARDENING',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 200,
                  width: 600,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://gardeners-perth.com.au/wp-content/uploads/2022/09/gardening-tools-garden-fork-plant-1024x675-1.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'GARDENING TIPS',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 200,
                  width: 600,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://cdn.shopify.com/s/files/1/0047/9730/0847/products/nurserylive-seeds-strawberry-fruit-seeds-16969353068684.jpg?v=1634204967"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'FRUITS',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class RecScreen2 extends StatelessWidget {
  const RecScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recommendation',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(227, 198, 235, 198),
              Color.fromARGB(180, 57, 54, 92),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildRecommendationContainer(
                imageUrl:
                "https://cdn.shopify.com/s/files/1/0622/8508/6951/articles/Watering_Herbs_700x.jpg?v=1648149528",
                title: 'HERBS',
              ),
              buildRecommendationContainer(
                imageUrl:
                "https://cdn.shopify.com/s/files/1/0569/9675/7697/files/how-to-garden-indoors_1024x1024.jpg?v=1648041414",
                title: 'INDOOR GARDENING',
              ),
              buildRecommendationContainer(
                imageUrl:
                "https://gardeners-perth.com.au/wp-content/uploads/2022/09/gardening-tools-garden-fork-plant-1024x675-1.jpg",
                title: 'GARDENING TIPS',
              ),
              buildRecommendationContainer(
                imageUrl:
                "https://cdn.shopify.com/s/files/1/0047/9730/0847/products/nurserylive-seeds-strawberry-fruit-seeds-16969353068684.jpg?v=1634204967",
                title: 'FRUITS',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildRecommendationContainer({
    required String imageUrl,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 35.0,
            ),
          ),
        ),
      ),
    );
  }
}



