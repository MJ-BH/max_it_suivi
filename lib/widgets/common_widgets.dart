import 'package:Suivi_Max_It/model/models.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timelines/timelines.dart';

class ListDepartment extends StatelessWidget {
  final List<Departement> departements;
  const ListDepartment({super.key, required this.departements});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FixedTimeline.tileBuilder(
        theme: TimelineThemeData(
          nodePosition: 0,
          color: const Color(0xff989898),
          indicatorTheme: const IndicatorThemeData(),
          connectorTheme: const ConnectorThemeData(
            thickness: 2.5,
          ),
        ),
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          itemCount: departements.length,
          contentsBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DepartmentContents(
                      department: departements[index], index: index),
                ],
              ),
            );
          },
          indicatorBuilder: (_, index) {
            return SizedBox.square(
              dimension: 32,
              child: Image.asset(
                  (departements[index].progress == 100.0)
                      ? "assets/indicator_green.png"
                      : "assets/indicator_none.png",
                  fit: BoxFit.fill),
            );
          },
          connectorBuilder: (_, index, ___) => const SolidLineConnector(
            color: Color.fromARGB(255, 106, 110, 107),
          ),
        ),
      ),
    );
  }
}

class DepartmentContents extends StatelessWidget {
  final Departement department;
  final int index;
  const DepartmentContents(
      {super.key, required this.department, required this.index});

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      theme: const ExpandableThemeData(
          animationDuration: Duration(milliseconds: 0),
          hasIcon: true,
          tapHeaderToExpand: true,
          iconColor: Colors.grey),
      header: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
            style: GoogleFonts.roboto(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            department.name),
      ),
      collapsed: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text("${department.progress} %",
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: (department.progress > 75.0)
                      ? Colors.green
                      : (department.progress == 0.0)
                          ? Colors.red
                          : Colors.orange,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LinearProgressIndicator(
              semanticsLabel: "${department.progress} %",
              borderRadius: BorderRadius.circular(4.0),
              backgroundColor: Colors.blueGrey[50],
              minHeight: 8,
              value: department.progress / 100,
              color: (department.progress > 75.0)
                  ? Colors.green
                  : (department.progress == 0.0)
                      ? Colors.grey
                      : Colors.orange,
            ),
          )
        ],
      ),
      expanded: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text("${department.progress} %",
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: (department.progress > 75.0)
                          ? Colors.green
                          : (department.progress == 0.0)
                              ? Colors.red
                              : Colors.orange,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearProgressIndicator(
                  semanticsLabel: "${department.progress} %",
                  borderRadius: BorderRadius.circular(4.0),
                  backgroundColor: Colors.blueGrey[50],
                  minHeight: 8,
                  value: department.progress / 100,
                  color: (department.progress > 75.0)
                      ? Colors.green
                      : (department.progress == 0.0)
                          ? Colors.grey
                          : Colors.orange,
                ),
              ),
              ListTasks(tasks: department.task),
            ],
          ),
        ],
      ),
    );
  }
}

class ListTasks extends StatelessWidget {
  final List<Task> tasks;
  const ListTasks({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0,
        color: const Color(0xff989898),
        indicatorTheme: const IndicatorThemeData(),
        connectorTheme: const ConnectorThemeData(
          thickness: 2.5,
        ),
      ),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemCount: tasks.length,
        contentsBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TasksContents(task: tasks[index]),
              ],
            ),
          );
        },
        indicatorBuilder: (_, index) {
          return SizedBox.square(
            dimension: 18,
            child: Image.asset(
                (tasks[index].progress == 100.0)
                    ? "assets/indicator_green.png"
                    : "assets/indicator_none.png",
                fit: BoxFit.fill),
          );
        },
        connectorBuilder: (_, index, ___) => const SolidLineConnector(
          color: Color.fromARGB(255, 106, 110, 107),
        ),
      ),
    );
  }
}

class TasksContents extends StatelessWidget {
  final Task task;
  const TasksContents({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 4.0),
      child: Row(
        children: [
          RichText(
              text: TextSpan(
                  style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                  text: "${task.description} ")),
          const Gap(8),
          Text("${task.progress} %",
              style: GoogleFonts.roboto(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: (task.progress > 50.0)
                    ? Colors.green
                    : (task.progress == 0.0)
                        ? Colors.red
                        : Colors.orange,
              ))
        ],
      ),
    );
  }
}
