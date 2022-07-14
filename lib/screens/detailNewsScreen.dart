// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, use_key_in_widget_constructors, must_be_immutable, file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

class DetailNewsScreen extends StatefulWidget {
  DetailNewsScreen(
    this.slug,
    this.gambar,
    this.judul,
  );
  String slug;
  String gambar;
  String judul;

  @override
  State<DetailNewsScreen> createState() => _DetailNewsScreenState();
}

class _DetailNewsScreenState extends State<DetailNewsScreen> {
  String wSlug;

  String content = '';
  String tanggal = '';

  getDetailNews() async {
    final response = await http
        .get(Uri.parse("https://indrajatim.com/api/detail?slug=$wSlug"));

    setState(() {
      tanggal = jsonDecode(response.body)['tanggal'];
      content = jsonDecode(response.body)['content'];
    });
  }

  @override
  void initState() {
    wSlug = widget.slug;
    getDetailNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 0,
            leading: InkWell(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              onTap: () => Navigator.pop(context),
            ),
            expandedHeight: MediaQuery.of(context).size.height / 2.3,
            backgroundColor: Colors.white,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Image.network(
                  widget.gambar,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                ),
              ),
              stretchModes: [
                StretchMode.fadeTitle,
                StretchMode.zoomBackground,
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 30, right: 30, top: 7, bottom: 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Text(
                            //   "Author: " + authorNews,
                            //   style: TextStyle(
                            //       fontSize: 10,
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.black),
                            // ),
                            Text(
                              tanggal,
                              style: TextStyle(
                                  fontSize: 10,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 30, right: 30, top: 15, bottom: 15),
                      child: Text(
                        widget.judul,
                        maxLines: 99,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Html(data: content)),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
