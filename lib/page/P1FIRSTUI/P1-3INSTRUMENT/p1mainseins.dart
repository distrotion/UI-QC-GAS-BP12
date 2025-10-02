import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/BlocEvent/01-03-SELECTINS.dart';

import '../../../bloc/BlocEvent/ChangePageEvent.dart';
import '../../../data/global.dart';
import '../../../mainBody.dart';
import '../../../styles/TextStyle.dart';
import '../../../widget/onlyINqcui/popup.dart';
import '../../page12.dart';
import '../../page13.dart';
import '../../page14.dart';
import '../../page2.dart';
import '../../page3.dart';

import '../../page4.dart';
import '../../page5.dart';
import '../../page6.dart';
import '../../page7.dart';
import '../../page8.dart';
import '../../page9.dart';
import '../FIRSTuiMAIN.dart';
import '../FIRSTuiVAR.dart';
import 'p1instrument.dart';

class SELECtINSTRUMENT extends StatelessWidget {
  SELECtINSTRUMENT({
    Key? key,
    this.INSlist,
  }) : super(key: key);
  List<String>? INSlist;
  @override
  Widget build(BuildContext context) {
    return TRICKER_BlocBuffer(
      INSlist: INSlist,
    );
  }
}

class TRICKER_BlocBuffer extends StatelessWidget {
  TRICKER_BlocBuffer({
    Key? key,
    this.INSlist,
  }) : super(key: key);
  List<String>? INSlist;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TRICKERMASTER_Bloc(),
        child: BlocBuilder<TRICKERMASTER_Bloc, String>(
          builder: (context, trick) {
            return SELECtINSTRUMENTbody(
              INSlist: INSlist,
              trick: trick,
            );
          },
        ));
  }
}

class SELECtINSTRUMENTbody extends StatelessWidget {
  SELECtINSTRUMENTbody({
    Key? key,
    this.INSlist,
    this.trick,
  }) : super(key: key);
  List<String>? INSlist;
  String? trick;

  @override
  Widget build(BuildContext context) {
    List<String> _INSlist = INSlist ?? [];
    print("-----------------");
    print(INSlist);
    print(FIRSTUI.SECLECTins);
    print("-----------------");

    if (trick == 'OK') {
      trick = '';
      context.read<TRICKERMASTER_Bloc>().add(TRICKERMASTER_FLUSH());

      if (FIRSTUI.SECLECTins == 'APP-GAS12') {
        CuPage = Page2();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
        FIRSTUI.INSnotREADY[0] = 0;
      } else if (FIRSTUI.SECLECTins == 'GAS-HMV-001') {
        CuPage = Page3();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
      } else if (FIRSTUI.SECLECTins == 'GAS-HMV-002') {
        CuPage = Page4();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
      } else if (FIRSTUI.SECLECTins == 'GAS-HMV-003') {
        CuPage = Page5();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
      } else if (FIRSTUI.SECLECTins == 'GAS-VIC-001') {
        CuPage = Page6();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
      } else if (FIRSTUI.SECLECTins == 'GAS-MCS-002') {
        CuPage = Page7();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
      } else if (FIRSTUI.SECLECTins == 'GAS-RHT-001') {
        CuPage = Page8();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
      } else if (FIRSTUI.SECLECTins == 'GAS-OHR-001') {
        CuPage = Page12();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
      } else if (FIRSTUI.SECLECTins == 'Ref-graph') {
        CuPage = Page13();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
      } else if (FIRSTUI.SECLECTins == 'Total-Nitriding') {
        CuPage = Page14();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
      }
    } else {
      if (FIRSTUI.SECLECTins != '') {
        if (FIRSTUI.SECLECTins == 'APP-GAS12') {
          FIRSTUI.INSnotREADY[FIRSTUI.INSint] = 1;
        } else if (FIRSTUI.SECLECTins == 'GAS-HMV-001') {
          FIRSTUI.INSnotREADY[FIRSTUI.INSint] = 1;
        } else if (FIRSTUI.SECLECTins == 'GAS-HMV-002') {
          FIRSTUI.INSnotREADY[FIRSTUI.INSint] = 1;
        } else if (FIRSTUI.SECLECTins == 'GAS-HMV-003') {
          FIRSTUI.INSnotREADY[FIRSTUI.INSint] = 1;
        } else if (FIRSTUI.SECLECTins == 'GAS-VIC-001') {
          FIRSTUI.INSnotREADY[FIRSTUI.INSint] = 1;
        } else if (FIRSTUI.SECLECTins == 'GAS-MCS-002') {
          FIRSTUI.INSnotREADY[FIRSTUI.INSint] = 1;
        } else if (FIRSTUI.SECLECTins == 'GAS-RHT-001') {
          FIRSTUI.INSnotREADY[FIRSTUI.INSint] = 1;
        } else if (FIRSTUI.SECLECTins == 'GAS-OHR-001') {
          FIRSTUI.INSnotREADY[FIRSTUI.INSint] = 1;
        } else if (FIRSTUI.SECLECTins == 'GAS-OHR-001') {
          FIRSTUI.INSnotREADY[FIRSTUI.INSint] = 1;
        } else if (FIRSTUI.SECLECTins == 'Ref-graph') {
          FIRSTUI.INSnotREADY[FIRSTUI.INSint] = 1;
        } else if (FIRSTUI.SECLECTins == 'Total-Nitriding') {
          FIRSTUI.INSnotREADY[FIRSTUI.INSint] = 1;
        }

        FIRSTUI.SECLECTins = '';
      } else {
        FIRSTUI.INSnotREADY = [
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
        ];
      }
    }

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                child: Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                          child: Row(
                            children: [
                              const Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      "PO",
                                      style: TxtStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Text(
                                      FIRSTUI.POACTIVE,
                                    ),
                                  ))
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                          child: Row(
                            children: [
                              const Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      "CP",
                                      style: TxtStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Text(FIRSTUI.CPACTIVE),
                                  ))
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 320,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 450,
                  child: Column(
                    children: [
                      for (int i = 0; i < _INSlist.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: InkWell(
                            onTap: () {
                              FIRSTUI.SECLECTins = _INSlist[i];
                              FIRSTUI.INSint = i;
                              print(i);
                              print(FIRSTUI.SECLECTins);
                              if (_INSlist[i] == 'APP-GAS12') {
                                context
                                    .read<TRICKERMASTER_Bloc>()
                                    .add(TRICKERMASTER_GETINtoAPPGAS12());
                              }
                              if (_INSlist[i] == 'GAS-HMV-001') {
                                context
                                    .read<TRICKERMASTER_Bloc>()
                                    .add(TRICKERMASTER_GETINtoGASHMV001());
                              }
                              if (_INSlist[i] == 'GAS-HMV-002') {
                                context
                                    .read<TRICKERMASTER_Bloc>()
                                    .add(TRICKERMASTER_GETINtoGASHMV002());
                              }
                              if (_INSlist[i] == 'GAS-HMV-003') {
                                context
                                    .read<TRICKERMASTER_Bloc>()
                                    .add(TRICKERMASTER_GETINtoGASHMV003());
                              }
                              if (_INSlist[i] == 'GAS-VIC-001') {
                                context
                                    .read<TRICKERMASTER_Bloc>()
                                    .add(TRICKERMASTER_GETINtoGASVIC001());
                              }
                              if (_INSlist[i] == 'GAS-MCS-002') {
                                context
                                    .read<TRICKERMASTER_Bloc>()
                                    .add(TRICKERMASTER_GETINtoGASMCS002());
                              }
                              if (_INSlist[i] == 'GAS-RHT-001') {
                                context
                                    .read<TRICKERMASTER_Bloc>()
                                    .add(TRICKERMASTER_GETINtoGASRHT001());
                              }
                              if (_INSlist[i] == 'GAS-OHR-001') {
                                context
                                    .read<TRICKERMASTER_Bloc>()
                                    .add(TRICKERMASTER_GETINtoGASOHR001());
                              }

                              if (_INSlist[i] == 'Ref-graph') {
                                context
                                    .read<TRICKERMASTER_Bloc>()
                                    .add(TRICKERMASTER_GETINtoRefgraph());
                              }
                              //Total-Nitriding
                              if (_INSlist[i] == 'Total-Nitriding') {
                                context
                                    .read<TRICKERMASTER_Bloc>()
                                    .add(TRICKERMASTER_GETINtoTotalNitriding());
                              }
                            },
                            child: INSBOX(
                              INS: _INSlist[i],
                              inuse: FIRSTUI.INSnotREADY[i] == 1,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SELECTins extends StatelessWidget {
//   SELECTins({Key? key, this.ins}) : super(key: key);
//   String? ins;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       color: Colors.blue,
//       child: Center(
//         child: Text(ins ?? '',style: TxtStyle(
//                         color: Colors.black, fontWeight: FontWeight.bold)),
//       ),
//     );
//   }
// }


// for (int i = 0; i < maxins; i++) {
//       INSOUTPUT.add(Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: InkWell(
//           onTap: () {
//             // INSConsoleBox();
//             CuPage = Page2();
//             CuPageLV = 1;
//             MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
//           },
//           child: INSBOX(
//             INS: ' INS ${i + 1}',
//           ),
//         ),
//       ));
//     }


