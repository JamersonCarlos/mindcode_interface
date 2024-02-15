import 'package:flutter/material.dart';
import 'dart:io' as io;

import 'package:google_fonts/google_fonts.dart';
import 'package:mindcode_interface/pages/initial_page.dart';
import 'package:mindcode_interface/services/check_Directory_Service.dart';
import 'package:mindcode_interface/services/read_file.dart';

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
  ReadFile serviceReadFile = ReadFile();
  ExistsDirectoryService readSonFiles = ExistsDirectoryService();
  List<List<String>> conteudos = [];
  List<String> selectConteudo = [];
  List<List<dynamic>> organizedFilesSon = [];
  bool switchButton = false;
  bool isHoverContainer = false;
  bool barNavigation = true;
  List<String> options = [
    'Overview',
    'Arquitetura',
    'Problemas de código',
    'Funcionalidades',
    'Requisitos técnicos'
  ];

  String dropdownValue = 'Overview';
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  void filesView(index, list) {
    serviceReadFile.readFiles(list[index].path).then((value) {
      setState(() {
        conteudos = value;
        if (conteudos.isNotEmpty) {
          selectConteudo = value.first;
        } else {
          selectConteudo = [];
        }
      });
    });
  }

  void createListDropFiles(int length) {
    organizedFilesSon.clear();
    for (int i = 0; i < length; i++) {
      organizedFilesSon.add([]);
    }
  }

  void addSonDirectory(index, list) {
    if (!organizedFilesSon[index].contains(list)) {
      organizedFilesSon[index].add(list);
    }
  }

  bool getSwitchButton() {
    return switchButton;
  }

  List<io.FileSystemEntity> getListDirectory() {
    return widget.listDirectory;
  }

  List<io.FileSystemEntity> getListFilter() {
    return widget.listFilter;
  }

  @override
  void initState() {
    super.initState();
    createListDropFiles(widget.listDirectory.length);
  }

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
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: switchButton
                        ? widget.listDirectory.length
                        : widget.listFilter.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                    right:
                                        BorderSide(color: Color(0xFFB8A12B))),
                                gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    Color(0xff452ce1),
                                    Color(0x59ffffff)
                                  ],
                                ),
                              ),
                              child: SizedBox(
                                height: 22,
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    switchButton
                                        ? filesView(index, widget.listDirectory)
                                        : filesView(index, widget.listFilter);
                                    switchButton
                                        ? addSonDirectory(
                                            index,
                                            readSonFiles.listDirectory(widget
                                                .listDirectory[index].path))
                                        : addSonDirectory(
                                            index,
                                            readSonFiles.listDirectory(
                                                widget.listFilter[index].path));
                                  },
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
                        ],
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
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
                        top: 10,
                        bottom: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'DashBoard ',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFCCC3FF),
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          DropdownMenu<String>(
                            initialSelection: options.first,
                            textStyle: GoogleFonts.poppins(
                              color: const Color(0xFFCCC3FF),
                            ),
                            onSelected: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            inputDecorationTheme: const InputDecorationTheme(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFCCC3FF),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white30,
                                ),
                              ),
                            ),
                            dropdownMenuEntries: options
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                  value: value, label: value);
                            }).toList(),
                          )
                        ],
                      ),
                    )),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF0C0825),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
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
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 25,
                                child: ListView.builder(
                                  itemCount: conteudos.length,
                                  scrollDirection:
                                      axisDirectionToAxis(AxisDirection.right),
                                  itemBuilder: ((context, index) {
                                    return Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: (index == 0)
                                                ? const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                  )
                                                : const BorderRadius.all(
                                                    Radius.zero),
                                            gradient: const LinearGradient(
                                              begin: Alignment.centerRight,
                                              end: Alignment.centerLeft,
                                              colors: [
                                                Color(0xff452ce1),
                                                Color(0x59ffffff)
                                              ],
                                            ),
                                          ),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              shadowColor: Colors.transparent,
                                              padding: const EdgeInsets.all(0),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                selectConteudo =
                                                    conteudos[index];
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: Text(
                                                    conteudos[index][0]
                                                        .toString()
                                                        .replaceAll('\\', '/')
                                                        .split('/')
                                                        .last,
                                                    style: GoogleFonts.poppins(
                                                      color: const Color(
                                                          0xFFCCC3FF),
                                                    ),
                                                  ),
                                                ),
                                                Transform.translate(
                                                  offset: const Offset(0, -6),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        conteudos
                                                            .removeAt(index);
                                                        if (conteudos
                                                            .isNotEmpty) {
                                                          selectConteudo =
                                                              conteudos.first;
                                                        } else {
                                                          selectConteudo = [];
                                                        }
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.cancel_rounded,
                                                      color: Color(0xFFCCC3FF),
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                              selectConteudo.isNotEmpty
                                  ? Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, left: 10),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              selectConteudo[1],
                                              textAlign: TextAlign.justify,
                                              style: GoogleFonts.poppins(
                                                color: const Color(0xFFCCC3FF),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 1,
                                color: Color(0xFFC3B4FF),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: TextField(
                              controller: boxDialog,
                              decoration: InputDecoration(
                                hintText: '   Message MindCode',
                                hintStyle: GoogleFonts.poppins(
                                  color: const Color(0xFFCCC3FF),
                                ),
                                suffixIcon: const Icon(
                                  Icons.next_week,
                                  size: 30,
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                enabledBorder: const UnderlineInputBorder(
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
        ],
      ),
    );
  }
}

Widget createListView(
    getSwitch, getListDirectory, getListFilter, addSonDirectory, filesView) {
  ExistsDirectoryService ReadSonFiles = ExistsDirectoryService();
  return ListView.builder(
    shrinkWrap: true,
    padding: const EdgeInsets.all(8),
    itemCount: getSwitch() ? getListDirectory.length : getListFilter.length,
    itemBuilder: (context, index) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: Color(0xFFB8A12B))),
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [Color(0xff452ce1), Color(0x59ffffff)],
                ),
              ),
              child: SizedBox(
                height: 22,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    getSwitch
                        ? filesView(index, getListDirectory)
                        : filesView(index, getListFilter);
                    getSwitch
                        ? addSonDirectory(
                            index,
                            ReadSonFiles.listDirectory(
                                getListDirectory[index].path))
                        : addSonDirectory(
                            index,
                            ReadSonFiles.listDirectory(
                                getListFilter[index].path));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.all(0),
                  ),
                  child: Text(
                    getSwitch
                        ? getListDirectory[index]
                            .path
                            .replaceAll('\\', '/')
                            .split('/')
                            .last
                        : getListFilter[index]
                            .path
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
        ],
      );
    },
  );
}
