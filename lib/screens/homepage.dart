// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print, must_be_immutable, prefer_const_constructors, non_constant_identifier_names, unused_import

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indrajatim/model/news.dart';
import 'package:indrajatim/widget/listNewsWidget.dart';
import 'package:indrajatim/widget/sliderNewsWidget.dart';
import 'package:jiffy/jiffy.dart';
import 'package:http/http.dart' as http;

class HomePageScreen extends StatefulWidget {
  HomePageScreen(
    this.categoryNews,
    this.listNews,
  );
  List categoryNews;
  List<List<ListNews>> listNews;
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List categoryNews = [];
  List<List<ListNews>> listNews = [];

  @override
  void initState() {
    categoryNews = widget.categoryNews;
    listNews = widget.listNews;
    _tabController = TabController(length: categoryNews.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        border: Border(bottom: BorderSide(color: Colors.transparent)),
        middle: Image.asset(
          'assets/images/logoindrajatimcom.png',
          width: MediaQuery.of(context).size.width / 2,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 0, left: 30, right: 30, bottom: 0),
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 3),
                        // Text(
                        //   "Terbaru",
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        SizedBox(height: 15),
                        SliderNewsWidget(listNews),
                        SizedBox(height: 15),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: SizedBox(
                            child: TabBar(
                              physics: BouncingScrollPhysics(),
                              isScrollable: true,
                              controller: _tabController,
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.black,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black),
                              tabs: [
                                for (int i = 0;
                                    i < categoryNews.length;
                                    i++) ...[
                                  SizedBox(
                                    height: 30,
                                    child: Tab(
                                      text: categoryNews[i]
                                          .toString()
                                          .toUpperCase(),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ],
                ),
              ),
            ];
          },
          body: SizedBox(
            child: TabBarView(
              physics: BouncingScrollPhysics(),
              controller: _tabController,
              children: [
                for (int i = 0; i < categoryNews.length; i++) ...[
                  ListNewsWidget(listNews[i]),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
