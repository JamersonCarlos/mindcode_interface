import 'package:flutter/material.dart';
import 'dart:io' as io;

import 'package:mindcode_interface/pages/initial_page.dart';
import 'package:mindcode_interface/services/llama_api.dart';

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
  final service = ServiceLlamaApi();
  Future<String> dados_do_modelo = Future.value('');
  TextEditingController boxDialog = TextEditingController();
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
  receberdados(String dados) async{  
  return await service.methodName(question: dados);
  }
  @override
  void initState() {
    super.initState();
    // Inicialização de variáveis ou configuração de estado aqui
    dados_do_modelo = service.methodName(question: 'escreva as boas vindas ao projeto mindcode');
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
                    child: const Text('MindCode',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFD1C6FF),
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ))),
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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.search,
                          ),
                        ),
                        Text(
                          'Search File',
                          style: TextStyle(
                              color: Color(0xFFD1C6FF),
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
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
                      const Text(
                        'Arquivos Ocultos   ',
                        style: TextStyle(
                          color: Color(0xFFD1C6FF),
                          fontSize: 15,
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
                            // setState(() {
                            //   isHoverContainer = true;
                            // });
                          },
                          onExit: (event) {
                            // setState(() {
                            //   isHoverContainer = false;
                            // });
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
                                    style: const TextStyle(
                                        color: Color(0xFFD1C6FF))),
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
                          top: 10,
                          bottom: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'DashBoard ',
                              style: TextStyle(
                                color: Color(0xFFD1C6FF),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            DropdownMenu<String>(
                              initialSelection: options.first,
                              textStyle: const TextStyle(
                                color: Color(0xFFD1C6FF),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
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
                                  .map<DropdownMenuEntry<String>>(
                                      (String value) {
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
                          child: Container(
                            child: Center(
                                child:FutureBuilder(
                                future: dados_do_modelo,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Erro ao carregar os dados',
                                    style: TextStyle(color: Colors.red));
                                  } else {
                                    return Text(snapshot.data.toString() ?? 'Sem dados',
                                    style: TextStyle(color: Colors.white));
                                  }
                                },
                             ),
                                ),
                          )),
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
                                style: const TextStyle(
                                  color: Color(0xFFD1C6FF),
                                ),
                                onSubmitted: (String value) {
                                  receberdados(value);
                                  setState(() {});
                                  boxDialog.clear();
                                },
                                controller: boxDialog,
                                decoration: const InputDecoration(
                                  hintText: '   Message MindCode',
                                  hintStyle:
                                      TextStyle(color: Color(0xFFD1C6FF)),
                                  suffixIcon: Icon(
                                    Icons.next_week,
                                    size: 30,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
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
          ),
        ],
      ),
    );
  }
}
