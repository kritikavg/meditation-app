import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_memoir/constants.dart';
import 'package:fit_memoir/models/diet_model.dart';
import 'package:fit_memoir/models/excersise_model.dart';
import 'package:fit_memoir/providers/page_details_provider.dart';
import 'package:fit_memoir/screens/youtube_viewer_screen.dart';
import 'package:fit_memoir/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class DietScreen extends ConsumerWidget {
  const DietScreen({
    super.key,
    required this.pageData,
    required this.image,
  });

  final PageData pageData;
  final String image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          ColoredBox(
            color: kBlueLightColor,
            child: SizedBox(
              height: size.height * .45,
              width: double.infinity,
            ),
          ),
          Positioned(
            right: 0,
            top: size.height * 0.1,
            child: SvgPicture.asset(
              image,
              height: size.height * 0.15,
              width: size.width * 0.3,
            ),
          ),
          DietPage(
            pageData: pageData,
          ),
        ],
      ),
    );
  }
}

class DietPage extends ConsumerStatefulWidget {
  const DietPage({
    super.key,
    required this.pageData,
  });
  final PageData pageData;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DietPageState();
}

class _DietPageState extends ConsumerState<DietPage> {
  int idx = 0;

  @override
  Widget build(BuildContext context) {
    void changeDietPage(int index) {
      setState(() {
        idx = index;
      });
    }

    Stream<QuerySnapshot<Map<String, dynamic>>> firebasedata = FirebaseFirestore
        .instance
        .collection("diet")
        .snapshots(includeMetadataChanges: true);
    double height = MediaQuery.of(context).size.height;
    print(height);
    return StreamBuilder<QuerySnapshot>(
        stream: firebasedata,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          List<String> allAdminIds = [];
          List<DietModel> excerciseData = snapshot.data!.docs.map(
            (eachElement) {
              allAdminIds.add(eachElement.id);
              return DietModel.fromMap(
                eachElement.data() as Map<String, dynamic>,
              );
            },
          ).toList();

          print("data $excerciseData");
          var size = MediaQuery.of(context).size;
          return Stack(
            children: <Widget>[
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Text(
                          widget.pageData.title,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.pageData.courseDuration,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: size.width *
                              .6, // it just take 60% of total width
                          child: Text(
                            widget.pageData.description,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: size.height * 0.2,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return DietCategoryCard(
                                color: idx == index ? kBlueColor : Colors.white,
                                title: allAdminIds[index],
                                svgSrc: widget.pageData.image,
                                press: () {
                                  changeDietPage(index);
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: size.height * 0.5,
                          child: ListView.builder(
                            itemCount: excerciseData[idx].daysData.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Day ${index + 1}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DietTextData(
                                        data:
                                            excerciseData[idx].daysData[index],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}

class DietTextData extends ConsumerWidget {
  const DietTextData({
    super.key,
    required this.data,
  });

  final String data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> textData = data.split(")");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (int i = 0; i < textData.length; i++)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${i + 1}. ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Flexible(
                  child: Text(
                    textData[i],
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class DietCategoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Function press;
  final Color color;
  const DietCategoryCard({
    Key? key,
    required this.svgSrc,
    required this.title,
    required this.press,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: kShadowColor,
            ),
          ],
        ),
        child: Material(
          color: color,
          child: InkWell(
            onTap: () {
              press();
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  SvgPicture.asset(svgSrc),
                  Spacer(),
                  Text(
                    title.replaceRange(0, 1, title[0].toUpperCase()),
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontSize: 20),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SeassionCard extends StatelessWidget {
  final int seassionNum;
  final bool isDone;
  final Function press;
  const SeassionCard({
    Key? key,
    required this.seassionNum,
    this.isDone = false,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: constraint.maxWidth / 2 -
              10, // constraint.maxWidth provide us the available with for this widget
          // padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 23,
                spreadRadius: -13,
                color: kShadowColor,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                press();
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 42,
                      width: 43,
                      decoration: BoxDecoration(
                        color: isDone ? kBlueColor : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: kBlueColor),
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: isDone ? Colors.white : kBlueColor,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Session $seassionNum",
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
