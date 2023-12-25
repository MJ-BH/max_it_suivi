import 'package:Suivi_Max_It/model/models.dart';
import 'package:Suivi_Max_It/pages/progress_screen.dart';
import 'package:easy_count_timer/easy_count_timer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WelcomScreen extends StatelessWidget {
  const WelcomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WelcomScreenWidget());
  }
}

class WelcomScreenWidget extends StatelessWidget {
  late GlobalProgress global;

  WelcomScreenWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg_maxit_progress.png"),
              fit: BoxFit.cover)),
      child: Flexible(
        child: FutureBuilder(
          future: getdata(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              global = snapshot.data;

              return Column(
                children: [
                  const Gap(24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        "assets/orange_logo.png",
                        width: 32,
                        height: 32,
                      ),
                    ),
                  ),
                  Gap(Get.height * 0.15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: "Max ",
                                  style: GoogleFonts.roboto(
                                      fontSize: 38,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                  children: [
                                TextSpan(
                                  text: " IT",
                                  style: GoogleFonts.roboto(
                                      fontSize: 38,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold),
                                )
                              ])),
                          SizedBox(
                            width: Get.width * 0.2,
                            child: const Divider(
                              thickness: 2,
                              color: Colors.orange,
                            ),
                          ),
                          const Gap(6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(alignment: Alignment.center, children: [
                                SizedBox.square(
                                  dimension: Get.height * 0.08,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.blueGrey[50],
                                    strokeWidth: 4,
                                    value: global.progress / 100,
                                    color: (global.progress > 75.0)
                                        ? const Color.fromARGB(255, 29, 192, 29)
                                        : (global.progress == 0.0)
                                            ? Colors.grey
                                            : Colors.orange,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "${global.progress.toInt()} %",
                                    style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        color: (global.progress / 100 > 75.0)
                                            ? const Color.fromARGB(255, 29, 192, 29)
                                            : (global.progress / 100 == 0.0)
                                                ? Colors.grey
                                                : Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ]),
                              const Gap(16),
                              Text(
                                maxLines: 2,
                                "Avancment \n Global ",
                                style: GoogleFonts.roboto(
                                    fontSize: 28,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(50),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        elevation: 0,
                        color: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.orange,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Gap(30),
                            Text(
                              "Comming Soon : ",
                              style: GoogleFonts.roboto(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                            const Gap(30),
                            CountTimer(
                              daysDescription: "Jours",
                              hoursDescription: "Heures",
                              minutesDescription: "Minutes",
                              secondsDescription: "secondes",
                              format: CountTimerFormat.daysHoursMinutesSeconds,
                              enableDescriptions: true,
                              timeTextStyle: GoogleFonts.roboto(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                              colonsTextStyle: GoogleFonts.roboto(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                              descriptionTextStyle: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.normal),
                              controller: CountTimerController(
                                  endTime: formatDate(global.dateLancement)),
                              onEnd: () {
                                // print("Timer finished");
                              },
                            ),
                            const Gap(30),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(const ProgressScreen(),
                                  transition: Transition.rightToLeftWithFade);
                            },
                            child: Text(
                              "Suivre",
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Colors.white,
                                  textStyle: const TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right_sharp,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: SizedBox(
                          width: Get.width * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Image.asset(
                                  "assets/orange_logo.png",
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                              SizedBox(
                                width: 70,
                                child: Text(
                                  maxLines: 3,
                                  "Orange              Digital Factory ",
                                  style: GoogleFonts.roboto(
                                      fontSize: 8,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Future getdata() async {
    var url =
        Uri.parse('https://maxit-orange.free.mockoapp.net/progress_global');
    late GlobalProgress dataModel;
    try {
      var response = await http.get(url);
      dataModel = globalProgressFromJson(response.body);
    } catch (e) {
    }

    return dataModel;
  }

  DateTime formatDate(int lastUpdate) {
    //var millis = 978296400000;
    var dt = DateTime.fromMillisecondsSinceEpoch(1705320000000);
    return dt;
  }
}
