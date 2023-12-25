import 'package:Suivi_Max_It/model/models.dart';
import 'package:Suivi_Max_It/pages/welcom_screen.dart';
import 'package:Suivi_Max_It/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: ProgressScreenWidget());
  }
}

class ProgressScreenWidget extends StatefulWidget {
  const ProgressScreenWidget({super.key});

  @override
  State<ProgressScreenWidget> createState() => _ProgressScreenWidgetState();
}

class _ProgressScreenWidgetState extends State<ProgressScreenWidget> {
  late DataModel dataModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg_maxit_progress.png"),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: getdata(),
              builder: (_, data) {
                if (data.hasData) {
                  dataModel = data.data as DataModel;
                  return RefreshIndicator(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              onTap: () {
                                Get.off(WelcomScreen(),
                                    transition: Transition.rightToLeftWithFade);
                              },
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                size: 32,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const Gap(16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: RichText(
                              text: TextSpan(
                                  text: "Avancement ",
                                  style: GoogleFonts.roboto(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                TextSpan(
                                  text: "Max ",
                                  style: GoogleFonts.roboto(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: " IT",
                                  style: GoogleFonts.roboto(
                                      fontSize: 24,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold),
                                )
                              ])),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.refresh_outlined,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const Gap(4),
                              Text(
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal),
                                  "Dernière mise à jour :${formatDate(dataModel.lastUpdate)}"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListDepartment(
                              departements: dataModel.data.departement),
                        ),
                      ],
                    ),
                    onRefresh: () async {
                      return await getdata();
                    },
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.orange,
                  ));
                }
              }),
        ),
      ),
    );
  }

  Future getdata() async {
    var url = Uri.parse('https://maxit-orange.free.mockoapp.net/progress');
    late DataModel dataModel;
    try {
      var response = await http.get(url);
      print(response.statusCode);
      dataModel = dataModelFromJson(response.body);
    } catch (e) {
      print(e.toString());
    }

    return dataModel;
  }

  String formatDate(int lastUpdate) {
    var dt = DateTime.fromMillisecondsSinceEpoch(lastUpdate);
    var d24 = DateFormat('dd/MM/yyyy, HH:mm').format(dt); // 31/12/2000, 22:00
    return d24;
  }
}
