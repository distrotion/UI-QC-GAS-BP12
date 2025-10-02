import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qc_ui_isn_hes/widget/common/Safty.dart';

import '../../bloc/BlocEvent/14-01-TotalNitriding.dart';
import '../../bloc/BlocEvent/14-02-TrickTotalNitriding.dart';
import '../../bloc/BlocEvent/ChangePageEvent.dart';
import '../../bloc/cubit/NotificationEvent.dart';
import '../../data/global.dart';
import '../../mainBody.dart';
import '../../widget/QCWIDGET/W1SINGLESHOT/SINGLESHOTwiHGdget.dart';
import '../../widget/QCWIDGET/W1SINGLESHOT/SINGLESHOTwidget.dart';
import '../../widget/common/Advancedropdown.dart';
import '../../widget/common/Loading.dart';
import '../../widget/onlyINqcui/popup.dart';
import '../P1FIRSTUI/FIRSTuiVAR.dart';
import '../page1.dart';
import 'TotalNitridingvar.dart';

class MICROVICKER_TotalNitridingmain extends StatelessWidget {
  MICROVICKER_TotalNitridingmain({Key? key, this.data}) : super(key: key);
  TotalNitridingSCHEMA? data;
  @override
  Widget build(BuildContext context) {
    return _TRICKER_TotalNitriding_BlocBuffer(
      data: data,
    );
  }
}

class _TRICKER_TotalNitriding_BlocBuffer extends StatelessWidget {
  _TRICKER_TotalNitriding_BlocBuffer({
    Key? key,
    this.data,
  }) : super(key: key);
  TotalNitridingSCHEMA? data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TRICKER_TotalNitriding_Bloc(),
        child: BlocBuilder<TRICKER_TotalNitriding_Bloc, String>(
          builder: (context, trick) {
            return ROCKWELL_TotalNitridingbody(data: data);
          },
        ));
  }
}

class ROCKWELL_TotalNitridingbody extends StatefulWidget {
  ROCKWELL_TotalNitridingbody({Key? key, this.data}) : super(key: key);
  TotalNitridingSCHEMA? data;

  @override
  State<ROCKWELL_TotalNitridingbody> createState() =>
      _ROCKWELL_TotalNitridingbodyState();
}

class _ROCKWELL_TotalNitridingbodyState
    extends State<ROCKWELL_TotalNitridingbody> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    context.read<TotalNitriding_Bloc>().add(TotalNitriding_READ());
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    backpage_fn(); // Do some stuff.
    return true;
  }

  backpage_fn() {
    TotalNitridingvar.DHtimer.cancel();
    FIRSTUI.SEARCH = FIRSTUI.POACTIVE;
    TotalNitridingvar.ItemPickSELECT = '';
    context
        .read<TRICKER_TotalNitriding_Bloc>()
        .add(TRICKER_TotalNitridingSETZERO());
    CuPage = Page1();
    MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
  }

  @override
  Widget build(BuildContext context) {
    PageMemory = 5;
    if (widget.data?.UPDATE == 'OK') {
      setState(() {
        TotalNitridingvar.PO = widget.data?.PO ?? '';
        TotalNitridingvar.CP = widget.data?.CP ?? '';
        TotalNitridingvar.QTY = widget.data?.QTY ?? '';
        TotalNitridingvar.PROCESS = widget.data?.PROCESS ?? '';
        TotalNitridingvar.CUSLOT = widget.data?.CUSLOT ?? '';
        TotalNitridingvar.TPKLOT = widget.data?.TPKLOT ?? '';
        TotalNitridingvar.FG = widget.data?.FG ?? '';
        TotalNitridingvar.CUSTOMER = widget.data?.CUSTOMER ?? '';
        TotalNitridingvar.PART = widget.data?.PART ?? '';
        TotalNitridingvar.PARTNAME = widget.data?.PARTNAME ?? '';
        TotalNitridingvar.MATERIAL = widget.data?.MATERIAL ?? '';
        //
        TotalNitridingvar.ItemPick = widget.data?.ItemPick ?? [''];
        TotalNitridingvar.PCS = widget.data?.PCS ?? '';
        // TotalNitridingvar.PCS = '10';
        TotalNitridingvar.PCSleft = widget.data?.PCSleft ?? '';
        // TotalNitridingvar.PCSleft = '10';
        TotalNitridingvar.POINTs = widget.data?.POINTs ?? '';
        // TotalNitridingvar.POINTs = '10';
        // if (TotalNitridingvar.ItemPickSELECT != "") {
        //   //
        //   if (TotalNitridingvar.POINTs == "") {
        //     //
        //     TotalNitridingvar.POINTs == "0";
        //   }
        // }
        TotalNitridingvar.UNIT = widget.data?.UNIT ?? '';
        // TotalNitridingvar.UNIT = 'pcs/lots';
        TotalNitridingvar.INTERSEC = widget.data?.INTERSEC ?? '';
        //
        TotalNitridingvar.RESULTFORMAT = widget.data?.RESULTFORMAT ?? '';
        TotalNitridingvar.GRAPHTYPE = widget.data?.GRAPHTYPE ?? '';
        TotalNitridingvar.GAP = widget.data?.GAP ?? '';
        TotalNitridingvar.GAPnameList = widget.data?.GAPnameList ?? [''];
        //
        TotalNitridingvar.preview = widget.data?.preview ?? [];
        TotalNitridingvar.confirmdata = widget.data?.confirmdata ?? [];
        TotalNitridingvar.ITEMleftUNIT = widget.data?.ITEMleftUNIT ?? [];
        TotalNitridingvar.ITEMleftVALUE = widget.data?.ITEMleftVALUE ?? [];

        TotalNitridingvar.PICs = widget.data?.Pic ?? '';

        if (TotalNitridingvar.PCSleft == '0') {
          BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
              "ITEM STATUS", "COMPLETE DATA", enumNotificationlist.Success);
        }

        widget.data?.UPDATE = '-';
      });

      Timer timer = Timer(const Duration(seconds: 1), () {
        context.read<TotalNitriding_Bloc>().add(TotalNitriding_READ());
      });
      TotalNitridingvar.DHtimer = timer;
    }
    return SINGLESHOTHGmain(
      //------ Left
      LABEL: "Ref-graph",
      PO: TotalNitridingvar.PO,
      CP: TotalNitridingvar.CP,
      QTY: TotalNitridingvar.QTY,
      PROCESS: TotalNitridingvar.PROCESS,
      CUSLOT: TotalNitridingvar.CUSLOT,
      TPKLOT: TotalNitridingvar.TPKLOT,
      FG: TotalNitridingvar.FG,
      CUSTOMER: TotalNitridingvar.CUSTOMER,
      PART: TotalNitridingvar.PART,
      PARTNAME: TotalNitridingvar.PARTNAME,
      MATERIAL: TotalNitridingvar.MATERIAL,
      //------- Top
      ItemPickres: (v) {
        print(v);
        TotalNitridingvar.ItemPickSELECT = v;
        //
        context
            .read<TRICKER_TotalNitriding_Bloc>()
            .add(TRICKER_TotalNitridinggeteachITEM());
      },
      ItemPick: TotalNitridingvar.ItemPick,
      PCS: TotalNitridingvar.PCS,
      PCSleft: TotalNitridingvar.PCSleft,
      POINTs: TotalNitridingvar.POINTs,
      UNIT: TotalNitridingvar.UNIT,
      INTERSEC: TotalNitridingvar.INTERSEC,
      RESULTFORMAT: TotalNitridingvar.RESULTFORMAT,
      Ghtype: TotalNitridingvar.GRAPHTYPE,
      GAP: TotalNitridingvar.GAP,
      GAPnameList: TotalNitridingvar.GAPnameList,
      GAPname: TotalNitridingvar.GAPname,
      GAPnamePick: (v) {
        TotalNitridingvar.GAPname = v;
        context
            .read<TRICKER_TotalNitriding_Bloc>()
            .add(TRICKER_TotalNitridinggeteachGRAPH());
      },
      //------- Bottom
      // dropdown: SizedBox(
      //   height: 40,
      //   width: 400,
      //   child: AdvanceDropDown(
      //     imgpath: 'assets/icons/icon-down_4@3x.png',
      //     listdropdown: const [
      //       MapEntry("", ""),
      //       MapEntry("GAS-HMV-001", "GAS-HMV-001"),
      //       MapEntry("GAS-HMV-002", "GAS-HMV-002"),
      //       MapEntry("GAS-HMV-003", "GAS-HMV-003"),
      //     ],
      //     onChangeinside: (d, v) {
      //       setState(() {
      //         TotalNitridingvar.dropdown = d;
      //       });
      //     },
      //     value: TotalNitridingvar.dropdown,
      //     height: 40,
      //     width: 400,
      //   ),
      // ),
      GET: (v) {
        Dio().post(
          GLOserver + 'CHECK-TotalNitriding-order',
          data: {},
        ).then((v) {
          // print(v.data[0]['FINAL']['GAS-MCS-002']
          //     ['ITEMs-670ca39db086b8384cc4fcfd']['PSC1'][0]['PIC1data']);
          if (v.statusCode == 200) {
            try {
              if (v.data[0]['FINAL']['GAS-MCS-002']
                      ['ITEMs-670ca39db086b8384cc4fcfd'] !=
                  null) {
                print(v.data[0]['FINAL']['GAS-MCS-002']
                    ['ITEMs-670ca39db086b8384cc4fcfd']['PSC1'][0]['PIC1data']);
              }
              String datalast = (double.parse(ConverstStr(v.data[0]['FINAL']
                              ['GAS-MCS-002']['ITEMs-670ca39db086b8384cc4fcfd']
                              ['PSC1'][0]['PIC1data']
                          .toString())) *
                      2)
                  .toStringAsFixed(2);

              Dio().post(
                GLOserver + 'TotalNitriding-preview',
                data: [
                  {
                    "V1": "TotalNitridingX2",
                    "V2": datalast,
                  }
                ],
              );
            } catch (e) {}
          }
        });
      },
      ACCEPT: (v) {
        if ((TotalNitridingvar.RESULTFORMAT == 'Graph' &&
                TotalNitridingvar.GAPname != '') ||
            TotalNitridingvar.RESULTFORMAT != 'Graph') {
          if (TotalNitridingvar.PCS != '' &&
              TotalNitridingvar.POINTs != '' &&
              TotalNitridingvar.ItemPickSELECT != '') {
            if (int.parse(TotalNitridingvar.POINTs) >
                TotalNitridingvar.confirmdata.length) {
              context
                  .read<TRICKER_TotalNitriding_Bloc>()
                  .add(TRICKER_TotalNitridingconfirmdata());
            } else {
              WORNINGpop(context, "Have completed POINTs");
            }
          } else {
            WORNINGpop(context, "Please select item");
          }
        } else {
          WORNINGpop(context, "Please select GRAPH");
        }
      },
      FINISH: (v) {
        if (TotalNitridingvar.PCS != '' &&
            TotalNitridingvar.POINTs != '' &&
            TotalNitridingvar.ItemPickSELECT != '') {
          if (int.parse(TotalNitridingvar.POINTs) ==
              TotalNitridingvar.confirmdata.length) {
            if (int.parse(TotalNitridingvar.PCSleft) > 0) {
              onLoadingFAKE(context);
              context
                  .read<TRICKER_TotalNitriding_Bloc>()
                  .add(TRICKER_TotalNitridingFINISH());
            }
          } else {
            WORNINGpop(context, "POINTs are not complete");
          }
        } else {
          WORNINGpop(context, "Please select item");
        }
      },
      preview: TotalNitridingvar.preview,
      confirmdata: TotalNitridingvar.confirmdata.reversed.toList(),
      //------- Right
      CLEAR: (v) {
        context
            .read<TRICKER_TotalNitriding_Bloc>()
            .add(TRICKER_TotalNitridingCLEAR());
      },
      BACKPAGE: (v) {
        TotalNitridingvar.DHtimer.cancel();
        FIRSTUI.SEARCH = FIRSTUI.POACTIVE;
        TotalNitridingvar.ItemPickSELECT = '';
        context
            .read<TRICKER_TotalNitriding_Bloc>()
            .add(TRICKER_TotalNitridingSETZERO());
        CuPage = Page1();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
      },
      RESETVALUE: (v) {
        context
            .read<TRICKER_TotalNitriding_Bloc>()
            .add(TRICKER_TotalNitridingRESETVALUE());
      },
      ITEMleftUNIT: TotalNitridingvar.ITEMleftUNIT,
      ITEMleftVALUE: TotalNitridingvar.ITEMleftVALUE,
      PICB64: TotalNitridingvar.PICs,
    );
  }
}
