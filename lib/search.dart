import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mon_potager/Screens/plantPage2.dart';
import 'package:mon_potager/Screens/plantPage3.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

//classes
import 'models/searchResponseItem.dart';

//Screens
import 'Screens/plantPage.dart';

// bool checkDOMReady(dom.Document document) {
//   // Check if the DOM has any div with class=pcsearch_contentblock
//   final elements = document.querySelectorAll('div.pcsearch_contentblock');
//   return elements.isNotEmpty;
// }

// final searchResults = html
//     .querySelectorAll("#pcsearchContent")
//     .map((element) => element.innerHtml.trim())
//     .toList();

// final searchResults = html.querySelectorAll("#pcsearchContent").toList();
//
// print("Count: ${searchResults.length}");
//
// for (final result in searchResults) {
//   print(result);
// }
//
// final searchResults2 = html
//     .querySelectorAll('div#pcsearchContent')
//     .map((element) => element.children)
//     .toList();
//
// print("Count: ${searchResults2.length}");
//
// for (final result in searchResults2) {
//   print(result);
//   // }
// }
//
//
// }

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }



  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(CupertinoIcons.back));
  }

  List<String> recentSearch = [];

  var resultsMap;

  Future<void> SearchWebsite(String searchKey) async {
    print(searchKey);
    var url = Uri.parse(
        "https://cms-fullsearch-service.picturethisai.com/api/v1/cmsfullsearch/cms_full_search?searchText=${searchKey}&languageCode=0&countryCode=Other");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var responseBody = response.body;
      var jsonResponse = jsonDecode(responseBody);

      resultsMap = jsonResponse["response"] as Map;
    }
  }


  Search({String hintText = "Search a plant"})
      : super(
      searchFieldLabel: hintText,
      textInputAction: TextInputAction.search);


  var searchResponse;

  @override
  Widget buildResults(BuildContext context) {
    if (query != null) {
      SearchWebsite(query);
      return ListView.builder(
          itemCount: resultsMap["indexModels"].length,
          itemBuilder: (context, index) {
            searchResponse =
                new searchResult.fromJson(resultsMap["indexModels"][index]);
            return ListTile(
                leading: Image.network(
                  "https://www.picturethisai.com/image-handle/website_cmsname/image/1080/${searchResponse.thumbnail}?x-oss-process=image/format,webp/quality,q_70/resize,l_500&v=1.1",
                  height: 50,
                  width: 50,
                ),
                title: Text(searchResponse.commonName),
                onTap: () {
                  // print(resultsMap["indexModels"][index]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => plantPage3(
                        resultsMap["indexModels"][index],
                      ),
                    ),
                  );
                });
          });
    } else if (query == "") {
      return ListTile(title: Text("No result found"));
    } else {
      return ListTile(title: Text("No result found"));
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == "" || query == " ") {
      return ListTile(title: Text("No result found"));
    }
    if (query != null) {
      //print(query);

      SearchWebsite(query);

      return Container(
        child: resultsMap == null
            ? Center(
                child: GestureDetector(
                    onTapDown: (details) {
                      SearchWebsite(query);
                    },
                    child: CircularProgressIndicator()))
            : ListView.builder(
                itemCount: resultsMap["indexModels"].length,
                itemBuilder: (context, index) {
                  searchResponse = new searchResult.fromJson(
                      resultsMap["indexModels"][index]);
                  return ListTile(
                      leading: Image.network(
                        "https://www.picturethisai.com/image-handle/website_cmsname/image/1080/${searchResponse.thumbnail}?x-oss-process=image/format,webp/quality,q_70/resize,l_500&v=1.1",
                        height: 50,
                        width: 50,
                      ),
                      title: Text(searchResponse.commonName),
                      trailing: Icon(CupertinoIcons.right_chevron),
                      onTap: () {
                        // print("here: " + resultsMap["indexModels"][index]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => plantPage3(
                              resultsMap["indexModels"][index],
                            ),
                          ),
                        );
                      });
                }),
      );
    }

    return ListTile(title: Text("No result found"));
  }
}
