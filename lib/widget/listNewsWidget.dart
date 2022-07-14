// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, use_key_in_widget_constructors, must_be_immutable, file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:indrajatim/model/news.dart';
import 'package:indrajatim/screens/detailNewsScreen.dart';
import 'package:shimmer/shimmer.dart';

class ListNewsWidget extends StatelessWidget {
  ListNewsWidget(this.listNews);
  List<ListNews> listNews = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: listNews.length,
      itemBuilder: (context, index) {
        ListNews news = listNews[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: InkWell(
            highlightColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            child: SizedBox(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                news.kategori,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(news.judul,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    news.tanggal,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Text(
                                      news.tag,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: CachedNetworkImage(
                              imageUrl: news.gambar,
                              fit: BoxFit.cover,
                              placeholder: (BuildContext context, String val) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[50],
                                  highlightColor: Colors.grey[200],
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailNewsScreen(news.slug)),
              );
            },
          ),
        );
      },
    );
  }
}
