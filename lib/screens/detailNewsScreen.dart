// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, use_key_in_widget_constructors, must_be_immutable, file_names, avoid_print

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

class DetailNewsScreen extends StatefulWidget {
  DetailNewsScreen(
    this.slug,
  );
  String slug;

  @override
  State<DetailNewsScreen> createState() => _DetailNewsScreenState();
}

class _DetailNewsScreenState extends State<DetailNewsScreen> {
  bool loadContent = true;
  String wSlug;

  String id_berita = '';
  String slug = '';
  String gambar;
  String judul = '';
  String tag = '';
  String caption = '';
  String tanggal = '';
  String kategori = '';
  String content = '';

  getDetailNews() async {
    final response = await http
        .get(Uri.parse("https://indrajatim.com/api/detail?slug=$wSlug"));

    setState(() {
      id_berita = jsonDecode(response.body)['id_berita'];
      slug = jsonDecode(response.body)['slug'];
      gambar = "https://indrajatim.com/assets/admin/upload/berita/" +
          jsonDecode(response.body)['gambar'];
      judul = jsonDecode(response.body)['judul'];
      tag = jsonDecode(response.body)['tag'];
      caption = jsonDecode(response.body)['caption'];
      tanggal = jsonDecode(response.body)['tanggal'];
      kategori = jsonDecode(response.body)['kategori'];
      content = jsonDecode(response.body)['content'];
      loadContent = false;
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).scaffoldBackgroundColor,
                      Colors.transparent
                    ],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: (loadContent)
                    ? SizedBox()
                    : CachedNetworkImage(
                        imageUrl: gambar,
                        fit: BoxFit.cover,
                        placeholder: (context, val) {
                          return SizedBox();
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 30, right: 30, top: 15, bottom: 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tanggal,
                              style: TextStyle(
                                  fontSize: 10,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    kategori,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 30, right: 30, top: 15, bottom: 15),
                      child: Text(
                        judul,
                        maxLines: 99,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Html(
                        data: content,
                        onLinkTap: (url, _, __, ___) {
                          if (url.contains('https:') || url.contains('http:')) {
                            print(url);
                          } else {
                            var newSlug =
                                url.replaceAll(RegExp('\\/.*?\\/'), '');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailNewsScreen(newSlug)),
                            );
                          }
                        },
                      ),
                    ),
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
