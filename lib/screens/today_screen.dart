import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_memoir/constants.dart';
import 'package:fit_memoir/models/diet_model.dart';
import 'package:fit_memoir/models/excersise_model.dart';
import 'package:fit_memoir/providers/global_providers.dart';
import 'package:fit_memoir/screens/youtube_viewer_screen.dart';
import 'package:fit_memoir/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pagedata = ref.read(pageDataProvider).pageData;
    Stream<QuerySnapshot<Map<String, dynamic>>> firebasedata = FirebaseFirestore
        .instance
        .collection("exercise_data")
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
        List<ExcersiseModel> excerciseData = snapshot.data!.docs.map(
          (eachElement) {
            allAdminIds.add(eachElement.id);
            return ExcersiseModel.fromMap(
              eachElement.data() as Map<String, dynamic>,
            );
          },
        ).toList();
        List<String> randomExercise = [];
        List<String> randomExerciseImage = [];
        void generateRandomExercise() {
          int generateRandomInt() {
            return Random().nextInt(5);
          }

          // for first
          randomExercise.add(excerciseData[0].sessions[generateRandomInt()]);
          randomExerciseImage.add(pagedata[1].image);
          randomExercise.add(excerciseData[0].sessions[generateRandomInt()]);
          randomExerciseImage.add(pagedata[1].image);

          // for second
          randomExercise.add(excerciseData[1].sessions[generateRandomInt()]);
          randomExerciseImage.add(pagedata[2].image);
          randomExercise.add(excerciseData[1].sessions[generateRandomInt()]);
          randomExerciseImage.add(pagedata[2].image);

          // for third
          randomExercise.add(excerciseData[2].sessions[generateRandomInt()]);
          randomExerciseImage.add(pagedata[3].image);
          randomExercise.add(excerciseData[2].sessions[generateRandomInt()]);
          randomExerciseImage.add(pagedata[3].image);
        }

        generateRandomExercise();

        print("data $excerciseData");
        var size = MediaQuery.of(context).size;
        return SizedBox(
          height: size.height * 0.5,
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Text(
                "Today's Exercise".toUpperCase(),
                style: TextStyle(
                  fontFamily: "Cairo",
                  fontSize: 22,
                  wordSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: randomExercise.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => YoutubeViewerScreen(
                                    videoLink: randomExercise[index]),
                              ),
                            );
                          },
                          child: ColoredBox(
                            color: kBlueLightColor,
                            child: ListTile(
                              tileColor: Colors.white,
                              leading: SizedBox(
                                width: size.width * 0.3,
                                child: SvgPicture.asset(
                                  randomExerciseImage[index],
                                ),
                              ),
                              title: Text("Exercise ${index + 1}"),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
