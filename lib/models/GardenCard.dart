import 'package:flutter/material.dart';

class GardenCard extends StatefulWidget {
  GardenCard(
      {Key? key,
      required this.plantImage,
      required this.plantName,
      required this.sun,
      required this.water})
      : super(key: key);

  String plantImage;
  String plantName;
  String sun;
  String water;

  @override
  State<GardenCard> createState() => _GardenCardState();
}

class _GardenCardState extends State<GardenCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        padding: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Color(0xBE43A56E),
              offset: Offset(0, 2),
            )
          ],
        ),
        // padding: EdgeInsets.only(top: 10),
        // color: Colors.red,
        width: 350 + 20,
        height: 173 + 20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              // color: Colors.red,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          widget.plantImage,
                          width: 123,
                          height: 125,
                          fit: BoxFit.fill,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Container(
                      height: 100 + 10,
                      // color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.plantName,
                            style: TextStyle(
                              // fontFamily: 'Readex Pro',
                              color: Color(0xBE43A56E),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.sunny,
                                color: Colors.yellow,
                                size: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  widget.sun,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.water_drop,
                                color: Colors.blue,
                                size: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  widget.water,
                                  style: TextStyle(
                                      fontSize: 12, fontFamily: 'Readex Pro'),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.blue,
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.more_vert)))
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.all(0),
                // color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.playlist_add,
                          color: Color.fromRGBO(116, 118, 120, 1),
                        )),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
