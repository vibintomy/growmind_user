import 'package:flutter/material.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/home/domain/entities/section_entity.dart';
import 'package:growmind/features/home/presentation/pages/curriculum.dart';
import 'package:growmind/features/home/presentation/widgets/display_image_course.dart';
import 'package:growmind/features/home/presentation/widgets/instructor_details.dart';
import 'package:growmind/features/home/presentation/widgets/upi_payments.dart';

class DisplayCourse extends StatelessWidget {
  final String id;
  final String category;
  final String courseName;
  final String courseDescription;
  final String coursePrice;
  final String imageUrl;
  final String subCategory;
  final String createdBy;
  final String createdAt;
  final List<SectionEntity> sections;
  const DisplayCourse(
      {super.key,
      required this.id,
      required this.category,
      required this.courseName,
      required this.courseDescription,
      required this.coursePrice,
      required this.createdAt,
      required this.createdBy,
      required this.imageUrl,
      required this.sections,
      required this.subCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: textColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            displayImage(context, imageUrl),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  kheight,
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color.fromARGB(255, 229, 227, 227),
                  ),
                  kheight,
                  Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 3,
                            spreadRadius: 0,
                            color: greyColor,
                          ),
                        ],
                        color: textColor),
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Column(
                        children: [
                          kheight,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    subCategory,
                                    style: const TextStyle(
                                        color: textColor1,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  )),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            ],
                          ),
                          kheight,
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                courseName,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    overflow: TextOverflow.ellipsis),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.videocam_outlined),
                              Text(
                                '$coursePrice /-',
                                style: const TextStyle(
                                    fontSize: 20, color: mainColor),
                              )
                            ],
                          ),
                          kheight,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(145, 50),
                                      side: const BorderSide(
                                        color: mainColor,
                                      ),
                                      backgroundColor: textColor,
                                      shape: const RoundedRectangleBorder()),
                                  onPressed: () {},
                                  child: const Text(
                                    'About',
                                    style: TextStyle(color: Colors.black),
                                  )),
                              kwidth,
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(145, 50),
                                      backgroundColor: textColor,
                                      side: const BorderSide(color: mainColor),
                                      shape: const RoundedRectangleBorder()),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Curriculum(section: sections)));
                                  },
                                  child: const Text(
                                    'Curriculum',
                                    style: TextStyle(color: Colors.black),
                                  )),
                            ],
                          ),
                          kheight,
                          Expanded(
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  courseDescription,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: greyColor,
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  kheight,
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color.fromARGB(255, 229, 227, 227),
                  ),
                  kheight,
                  instructorDetails(context, subCategory, createdBy),
                  kheight,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reviews',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Row(
                        children: [
                          Text(
                            'See All',
                            style: TextStyle(
                                color: mainColor, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.arrow_right,
                            color: mainColor,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton:
          double.tryParse(coursePrice) != null && double.parse(coursePrice) > 0
              ? SizedBox(
                  width: 300,
                  height: 50,
                  child: FloatingActionButton(
                    backgroundColor: mainColor,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentScreen(courseId: id,)
                              ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Enroll Course  ₹$coursePrice/-',
                          style: const TextStyle(
                              fontSize: 20,
                              color: textColor,
                              fontWeight: FontWeight.w600),
                        ),
                        kwidth,
                        Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: textColor),
                          child: const Icon(Icons.arrow_forward),
                        )
                      ],
                    ),
                  ),
                )
              : null,
    );
  }
}
