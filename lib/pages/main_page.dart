import 'package:flutter/material.dart';
import 'dart:io' as io;

import 'package:google_fonts/google_fonts.dart';
import 'package:mindcode_interface/pages/initial_page.dart';
import 'package:mindcode_interface/widgets/navigation_tools.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.path,
    required this.listDirectory,
    required this.listFilter,
  });
  final String path;
  final List<io.FileSystemEntity> listDirectory;
  final List<io.FileSystemEntity> listFilter;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController boxDialog = TextEditingController();
  bool switchButton = false;
  bool isHoverContainer = false;
  bool barNavigation = true;

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121024),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 220,
            decoration: const BoxDecoration(
              color: Color(0xFF0A0A16),
              border: Border(
                right: BorderSide(
                  width: 1,
                  color: Colors.black,
                ),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  blurRadius: 60,
                  color: Color.fromARGB(157, 226, 236, 249),
                  offset: Offset(0, 0.60),
                )
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 25, bottom: 25, left: 0, right: 0),
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: Color(0xFFC3B4FF),
                      ),
                    ),
                  ),
                  child: Text('MindCode',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFD1C6FF),
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFC3B4FF),
                      ),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InitialPage(),
                          ),
                          (route) => false);
                    },
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                        Color(0xff473f74),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.search,
                          ),
                        ),
                        Text(
                          'Search File',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFD1C6FF),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Arquivos Ocultos   ',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFD1C6FF),
                        ),
                      ),
                      Transform.scale(
                        scale: 0.7,
                        child: Switch(
                          thumbIcon: thumbIcon,
                          value: switchButton,
                          onChanged: (bool value) {
                            setState(() {
                              switchButton = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: switchButton
                        ? widget.listDirectory.length
                        : widget.listFilter.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: MouseRegion(
                          onEnter: (event) {
                            setState(() {
                              isHoverContainer = true;
                            });
                          },
                          onExit: (event) {
                            setState(() {
                              isHoverContainer = false;
                            });
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                  right: BorderSide(color: Color(0xFFB8A12B))),
                              gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [Color(0xff452ce1), Color(0x59ffffff)],
                              ),
                            ),
                            child: SizedBox(
                              height: 22,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: const EdgeInsets.all(0),
                                ),
                                child: Text(
                                  switchButton
                                      ? widget.listDirectory[index].path
                                          .replaceAll('\\', '/')
                                          .split('/')
                                          .last
                                      : widget.listFilter[index].path
                                          .replaceAll('\\', '/')
                                          .split('/')
                                          .last,
                                  style: GoogleFonts.poppins(
                                    color: const Color(
                                      0xFFD1C6FF,
                                    ),
                                  ),
                                ),
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
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.025,
                right: MediaQuery.of(context).size.width * 0.02),
            child: Expanded(
              child: Column(
                children: [
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInExpo,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 4,
                            color: Color(0xFFF6F6FB),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'DashBoard ',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFFCCC3FF),
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      barNavigation = !barNavigation;
                                    });
                                  },
                                  icon: !barNavigation
                                      ? const Icon(
                                          Icons
                                              .keyboard_double_arrow_right_sharp,
                                          color: Color(
                                            0xFFCCC3FF,
                                          ),
                                          size: 40,
                                        )
                                      : const Icon(
                                          Icons
                                              .keyboard_double_arrow_down_sharp,
                                          color: Color(0xFFCCC3FF),
                                          size: 40,
                                        ),
                                ),
                              ],
                            ),
                            barNavigation
                                ? const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Navigation(
                                          identification:
                                              'Problemas de código'),
                                      Navigation(identification: 'Overview'),
                                      Navigation(
                                          identification: 'Funcionalidades'),
                                      Navigation(identification: 'Arquitetura'),
                                      Navigation(
                                          identification:
                                              'Requisitos Técnicos'),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      )),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF0C0825),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 30,
                            color: Color.fromARGB(157, 226, 236, 249),
                            offset: Offset(0, 0.50),
                          )
                        ],
                      ),
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(child: Container()),
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: TextField(
                                controller: boxDialog,
                                decoration: const InputDecoration(
                                  hintText: 'Message MindCode',
                                  suffixIcon: Icon(
                                    Icons.next_week,
                                    size: 30,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  errorBorder: null,
                                  focusedErrorBorder: null,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
