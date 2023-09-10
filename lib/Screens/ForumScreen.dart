import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mon_potager/Screens/ProfileScreen.dart';
import 'package:mon_potager/models/Colours.dart';

import '../Home.dart';

class ForumScreen extends StatefulWidget {
  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  List<String> _forumPosts = [];
  final TextEditingController _commentController = TextEditingController();

  Future<void> _handlePhotoUpload() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _forumPosts.add(pickedFile.path);
      });
    }
  }

  void _handleCommentSubmit() {
    String comment = _commentController.text;
    if (comment.isNotEmpty) {
      setState(() {
        _forumPosts.add(comment);
      });
      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scene(),
                ));
          },
        ),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Forum",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: pageTitleColour,
      ),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 60),
            child: Column(
              children: [IconButton(onPressed: () {}, icon: Icon(Icons.forum))],
            ),
          ),
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                        ProfileScreen()

                    ));
                  },
                  icon: Icon(Icons.person))
            ],
          )
        ],
      )),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 45 - 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 8),
                children: [
                  buildPostSection(
                      "https://cdn.britannica.com/89/126689-004-D622CD2F/Potato-leaf-blight.jpg?w=400&h=300&c=crop",
                      "https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=940",
                      "Can anyone help me with this?",
                      "Tom",
                      "I have the same problem",
                      "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=640",
                      "James"),
                  buildPostSection(
                      "https://empire-s3-production.bobvila.com/slides/43072/vertical_slide_wide/flower_pot_ideas_2.jpg?1624641156",
                      "https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=640",
                      "Look at my new little garden",
                      "Smith",
                      "OMG Gurl, Slayyy!!! ",
                      "https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=940",
                      "Tom"),
                  buildPostSection(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTczTmKxlNai6b9RZ1W6SKvr5K7oygyDi_8Pg&usqp=CAU",
                      "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=640",
                      "The leaves of my plants are turning yellow and idk why",
                      "James",
                      "Try adding some compost",
                      "https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=640",
                      "Smith"),
                ],
              ),
            )
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 60,
        child: FittedBox(
          child: FloatingActionButton(
            shape: CircleBorder(),
            onPressed: () {},
            child: Icon(
              Icons.add,
            ),
            backgroundColor: solidGreen,
            elevation: 0,
          ),
        ),
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   _selectedItemIndex = index;
        // });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        height: 45,
        child: icon != null
            ? Icon(
                icon,
                size: 25,
                // color: index == _selectedItemIndex
                //     ? Colors.black
                //     : Colors.grey[700],
              )
            : Container(),
      ),
    );
  }

  Container buildPostSection(
      String urlPost,
      String urlProfilePhoto,
      String caption,
      String name,
      String comment,
      String commenterPfp,
      commenterName) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPostFirstRow(urlProfilePhoto, name),
          SizedBox(
            height: 10,
          ),
          buildPostPicture(urlPost, comment, commenterName, commenterPfp),
          SizedBox(
            height: 5,
          ),
          Text(
            caption,
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800]),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Row buildPostFirstRow(String urlProfilePhoto, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) =>
                //         ProfilPage(url: urlProfilePhoto)));
              },
              child: Hero(
                tag: urlProfilePhoto,
                child: CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(urlProfilePhoto),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   "Iceland",
                //   style: TextStyle(
                //       fontSize: 12,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.grey[500]),
                // ),
              ],
            )
          ],
        ),
        Icon(Icons.more_vert)
      ],
    );
  }

  Stack buildPostPicture(String urlPost, String comment, String commenterName,
      String commenterPfp) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.width - 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(urlPost),
              )),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: IconButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => Padding(
                padding: const EdgeInsets.only(top: 300),
                child: AlertDialog(
                  title: const Text('Comments'),
                  content: Container(
                      width: 300,
                      height: 300,
                      child: Column(children: [
                        Row(
                          children: [
                            Hero(
                              tag:
                                  "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=640",
                              child: CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(commenterPfp),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      commenterName,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(comment),
                                    Text(
                                      "Reply",
                                      style: TextStyle(
                                          fontSize: 9, color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ])),
                  // actions: <Widget>[
                  //   TextButton(
                  //     onPressed: () => Navigator.pop(context, 'Cancel'),
                  //     child: const Text('Cancel'),
                  //   ),
                  //   TextButton(
                  //     onPressed: () => Navigator.pop(context, 'OK'),
                  //     child: const Text('OK'),
                  //   ),
                  // ],
                ),
              ),
            ),
            icon: Icon(Icons.chat,
                size: 35, color: Colors.white.withOpacity(0.7)),
          ),
        )
      ],
    );
  }

  Container buildStoryAvatar(String url) {
    return Container(
      margin: EdgeInsets.only(left: 18),
      height: 60,
      width: 60,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.red),
      child: CircleAvatar(
        radius: 18,
        backgroundImage: NetworkImage(url),
      ),
    );
  }
}
