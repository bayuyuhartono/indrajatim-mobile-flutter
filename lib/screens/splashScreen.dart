// ignore_for_file: file_names, use_key_in_widget_constructors, avoid_unnecessary_containers, avoid_print, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:indrajatim/model/news.dart';
import 'package:http/http.dart' as http;
import 'package:indrajatim/screens/homepage.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List categoryNews = [];
  List<List<ListNews>> listNews = [];

  getCategory() async {
    final response =
        await http.get(Uri.parse("https://indrajatim.com/api/category"));

    List temp = [];

    for (var data in jsonDecode(response.body) as List) {
      temp.add(data['kategori_slug']);
    }
    setState(() {
      categoryNews = temp;
      loopNews();
    });
  }

  loopNews() async {
    setState(() {
      listNews = List.generate(categoryNews.length, (i) => []);
    });
    for (var i = 0; i < categoryNews.length; i++) {
      await getNews(categoryNews[i]).then((value) {
        listNews[i] = value;
      });
    }
    goToNextPage();
  }

  getNews(String category) async {
    final response = await http.get(Uri.parse(
        "https://indrajatim.com/api/list?page=1&category=" + category));

    List<ListNews> temp = [];
    for (var data in jsonDecode(response.body)['data'] as List) {
      temp.add(
        ListNews(
          data['id_berita'],
          data['slug'],
          data['gambar'],
          data['judul'],
          data['caption'],
          data['tag'],
          data['tanggal'],
          data['kategori'],
          data['detail'],
        ),
      );
    }
    return temp;
  }

  goToNextPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => HomePageScreen(categoryNews, listNews)),
    );
  }

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
        children: [
          Center(
            child: Container(
              height: 100,
              width: 100,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Image.asset("assets/images/logoijt.png"),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: LinearProgressIndicator(
                      backgroundColor: Color.fromARGB(255, 146, 35, 27),
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 0, 94, 170)),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
