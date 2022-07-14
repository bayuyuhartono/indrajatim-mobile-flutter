// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, use_key_in_widget_constructors, must_be_immutable, file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:indrajatim/model/news.dart';
import 'package:indrajatim/screens/detailNewsScreen.dart';

class SliderNewsWidget extends StatelessWidget {
  SliderNewsWidget(this.listNews);
  List listNews;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width / 1.7,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: listNews.length,
          itemBuilder: (BuildContext context, int index) {
            List tempList = listNews[index];
            if (tempList.isEmpty) {
              return SizedBox();
            } else {
              ListNews news = listNews[index][0];
              return Row(
                children: [
                  _sliderWidget(context, news.gambar, news.judul, news.slug,
                      news.kategori),
                  (listNews.length - 1 == index)
                      ? SizedBox(width: 0)
                      : SizedBox(width: 15),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  _sliderWidget(BuildContext context, String gambar, String judul, String slug,
      String kategori) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.width / 1.7,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(gambar), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 0, right: 15, bottom: 15, top: 15),
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailNewsScreen(slug, gambar, judul)),
        );
      },
    );
  }
}
