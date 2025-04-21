import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/BlocEvent/08-01-GASRHT001.dart';
import '../../bloc/BlocEvent/08-02-TrickGASRHT001.dart';
import '../../bloc/BlocEvent/ChangePageEvent.dart';
import '../../bloc/cubit/NotificationEvent.dart';
import '../../data/global.dart';
import '../../mainBody.dart';
import '../../widget/QCWIDGET/W1SINGLESHOT/SINGLESHOTwidget.dart';
import '../../widget/common/Loading.dart';
import '../../widget/onlyINqcui/popup.dart';
import '../P1FIRSTUI/FIRSTuiVAR.dart';
import '../page1.dart';
import 'GASRHT001var.dart';

class MICROVICKER_GASRHT001main extends StatelessWidget {
  MICROVICKER_GASRHT001main({Key? key, this.data}) : super(key: key);
  GASRHT001SCHEMA? data;
  @override
  Widget build(BuildContext context) {
    return _TRICKER_GASRHT001_BlocBuffer(
      data: data,
    );
  }
}

class _TRICKER_GASRHT001_BlocBuffer extends StatelessWidget {
  _TRICKER_GASRHT001_BlocBuffer({
    Key? key,
    this.data,
  }) : super(key: key);
  GASRHT001SCHEMA? data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TRICKER_GASRHT001_Bloc(),
        child: BlocBuilder<TRICKER_GASRHT001_Bloc, String>(
          builder: (context, trick) {
            return ROCKWELL_GASRHT001body(data: data);
          },
        ));
  }
}

class ROCKWELL_GASRHT001body extends StatefulWidget {
  ROCKWELL_GASRHT001body({Key? key, this.data}) : super(key: key);
  GASRHT001SCHEMA? data;

  @override
  State<ROCKWELL_GASRHT001body> createState() => _ROCKWELL_GASRHT001bodyState();
}

class _ROCKWELL_GASRHT001bodyState extends State<ROCKWELL_GASRHT001body> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    context.read<GASRHT001_Bloc>().add(GASRHT001_READ());
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
    GASRHT001var.DHtimer.cancel();
    FIRSTUI.SEARCH = FIRSTUI.POACTIVE;
    GASRHT001var.ItemPickSELECT = '';
    context.read<TRICKER_GASRHT001_Bloc>().add(TRICKER_GASRHT001SETZERO());
    CuPage = Page1();
    MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
  }

  @override
  Widget build(BuildContext context) {
    PageMemory = 5;
    if (widget.data?.UPDATE == 'OK') {
      setState(() {
        GASRHT001var.PO = widget.data?.PO ?? '';
        GASRHT001var.CP = widget.data?.CP ?? '';
        GASRHT001var.QTY = widget.data?.QTY ?? '';
        GASRHT001var.PROCESS = widget.data?.PROCESS ?? '';
        GASRHT001var.CUSLOT = widget.data?.CUSLOT ?? '';
        GASRHT001var.TPKLOT = widget.data?.TPKLOT ?? '';
        GASRHT001var.FG = widget.data?.FG ?? '';
        GASRHT001var.CUSTOMER = widget.data?.CUSTOMER ?? '';
        GASRHT001var.PART = widget.data?.PART ?? '';
        GASRHT001var.PARTNAME = widget.data?.PARTNAME ?? '';
        GASRHT001var.MATERIAL = widget.data?.MATERIAL ?? '';
        //
        GASRHT001var.ItemPick = widget.data?.ItemPick ?? [''];
        GASRHT001var.PCS = widget.data?.PCS ?? '';
        // GASRHT001var.PCS = '10';
        GASRHT001var.PCSleft = widget.data?.PCSleft ?? '';
        // GASRHT001var.PCSleft = '10';
        GASRHT001var.POINTs = widget.data?.POINTs ?? '';
        // GASRHT001var.POINTs = '10';
        // if (GASRHT001var.ItemPickSELECT != "") {
        //   //
        //   if (GASRHT001var.POINTs == "") {
        //     //
        //     GASRHT001var.POINTs == "0";
        //   }
        // }
        GASRHT001var.UNIT = widget.data?.UNIT ?? '';
        // GASRHT001var.UNIT = 'pcs/lots';
        GASRHT001var.INTERSEC = widget.data?.INTERSEC ?? '';
        //
        GASRHT001var.RESULTFORMAT = widget.data?.RESULTFORMAT ?? '';
        GASRHT001var.GRAPHTYPE = widget.data?.GRAPHTYPE ?? '';
        GASRHT001var.GAP = widget.data?.GAP ?? '';
        GASRHT001var.GAPnameList = widget.data?.GAPnameList ?? [''];
        //
        GASRHT001var.preview = widget.data?.preview ?? [];
        GASRHT001var.confirmdata = widget.data?.confirmdata ?? [];
        GASRHT001var.ITEMleftUNIT = widget.data?.ITEMleftUNIT ?? [];
        GASRHT001var.ITEMleftVALUE = widget.data?.ITEMleftVALUE ?? [];

        // GASRHT001var.PICs = widget.data?.Pic ?? '';

        if (GASRHT001var.PCSleft == '0') {
          BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
              "ITEM STATUS", "COMPLETE DATA", enumNotificationlist.Success);
        }

        widget.data?.UPDATE = '-';
      });

      Timer timer = Timer(const Duration(seconds: 1), () {
        context.read<GASRHT001_Bloc>().add(GASRHT001_READ());
      });
      GASRHT001var.DHtimer = timer;
    }
    return SINGLESHOTmain(
      //------ Left
      LABEL: "GAS-RHT-001",
      PO: GASRHT001var.PO,
      CP: GASRHT001var.CP,
      QTY: GASRHT001var.QTY,
      PROCESS: GASRHT001var.PROCESS,
      CUSLOT: GASRHT001var.CUSLOT,
      TPKLOT: GASRHT001var.TPKLOT,
      FG: GASRHT001var.FG,
      CUSTOMER: GASRHT001var.CUSTOMER,
      PART: GASRHT001var.PART,
      PARTNAME: GASRHT001var.PARTNAME,
      MATERIAL: GASRHT001var.MATERIAL,
      //------- Top
      ItemPickres: (v) {
        print(v);
        GASRHT001var.ItemPickSELECT = v;
        //
        context
            .read<TRICKER_GASRHT001_Bloc>()
            .add(TRICKER_GASRHT001geteachITEM());
      },
      ItemPick: GASRHT001var.ItemPick,
      PCS: GASRHT001var.PCS,
      PCSleft: GASRHT001var.PCSleft,
      POINTs: GASRHT001var.POINTs,
      UNIT: GASRHT001var.UNIT,
      INTERSEC: GASRHT001var.INTERSEC,
      RESULTFORMAT: GASRHT001var.RESULTFORMAT,
      Ghtype: GASRHT001var.GRAPHTYPE,
      GAP: GASRHT001var.GAP,
      GAPnameList: GASRHT001var.GAPnameList,
      GAPname: GASRHT001var.GAPname,
      GAPnamePick: (v) {
        GASRHT001var.GAPname = v;
        context
            .read<TRICKER_GASRHT001_Bloc>()
            .add(TRICKER_GASRHT001geteachGRAPH());
      },
      //------- Bottom
      ACCEPT: (v) {
        if ((GASRHT001var.RESULTFORMAT == 'Graph' &&
                GASRHT001var.GAPname != '') ||
            GASRHT001var.RESULTFORMAT != 'Graph') {
          if (GASRHT001var.PCS != '' &&
              GASRHT001var.POINTs != '' &&
              GASRHT001var.ItemPickSELECT != '') {
            if (int.parse(GASRHT001var.POINTs) >
                GASRHT001var.confirmdata.length) {
              context
                  .read<TRICKER_GASRHT001_Bloc>()
                  .add(TRICKER_GASRHT001confirmdata());
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
        if (GASRHT001var.PCS != '' &&
            GASRHT001var.POINTs != '' &&
            GASRHT001var.ItemPickSELECT != '') {
          if (int.parse(GASRHT001var.POINTs) ==
              GASRHT001var.confirmdata.length) {
            if (int.parse(GASRHT001var.PCSleft) > 0) {
              onLoadingFAKE(context);
              context
                  .read<TRICKER_GASRHT001_Bloc>()
                  .add(TRICKER_GASRHT001FINISH());
            }
          } else {
            WORNINGpop(context, "POINTs are not complete");
          }
        } else {
          WORNINGpop(context, "Please select item");
        }
      },
      preview: GASRHT001var.preview,
      confirmdata: GASRHT001var.confirmdata.reversed.toList(),
      //------- Right
      CLEAR: (v) {
        context.read<TRICKER_GASRHT001_Bloc>().add(TRICKER_GASRHT001CLEAR());
      },
      BACKPAGE: (v) {
        GASRHT001var.DHtimer.cancel();
        FIRSTUI.SEARCH = FIRSTUI.POACTIVE;
        GASRHT001var.ItemPickSELECT = '';
        context.read<TRICKER_GASRHT001_Bloc>().add(TRICKER_GASRHT001SETZERO());
        CuPage = Page1();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
      },
      RESETVALUE: (v) {
        context
            .read<TRICKER_GASRHT001_Bloc>()
            .add(TRICKER_GASRHT001RESETVALUE());
      },
      ITEMleftUNIT: GASRHT001var.ITEMleftUNIT,
      ITEMleftVALUE: GASRHT001var.ITEMleftVALUE,
      PICB64: GASRHT001var.PICs,
    );
  }
}
