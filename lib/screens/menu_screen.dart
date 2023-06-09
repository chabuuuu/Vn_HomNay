//let's start by our home screen
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/bancobiet_card.dart';
import '../models/news_model.dart';
import '../components/news_list_title.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //let's start with the Appbar
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "NewsApp",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ))
        ],
      ),

      //Let's now work on the body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bạn có biết?",
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //let's build our caroussel
              CarouselSlider.builder(
                  itemCount: NewsData.breakingNewsData.length,
                  itemBuilder: (context, index, id) =>
                      BreakingNewsCard(NewsData.breakingNewsData[index]),
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                  )),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "Recent News",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              //now let's create the cards for the recent news
              Column(
                children: [
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("news").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if (snapshot.hasData){
                        final snap = snapshot.data!.docs;
                        final lenght = snap.length;
                        List<NewsData> breakingNewsData = [];
                        for (int i = 0 ; i < lenght; i++){
                          
                          var index = i;
                            var title = Text(snap[i]['title']).data.toString();
                            var data = Text(snap[i]['data']).data.toString();
                            NewsData newsData = NewsData(title, "", data, "", "https://statics.vinpearl.com/du-lich-vinh-Ha-Long-hinh-anh1_1625911963.jpg");
                                breakingNewsData.add(newsData);
                             
                            
                        } 
                        
                    return Column(
                      children: breakingNewsData
                    .map((e) => NewsListTile(e))
                    .toList(),
                    );
                        

                      }else{
                        return SizedBox();
                      }
                    },

                )
                
                
                ,
                
                ]
              ),
            ],
          ),
        ),
      ),

      
      );
    
  }
}
