import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/BlocEvent/06-01-GASVIC001.dart';
import '../../bloc/BlocEvent/06-02-TrickGASVIC001.dart';
import '../../bloc/BlocEvent/ChangePageEvent.dart';
import '../../bloc/cubit/NotificationEvent.dart';
import '../../data/global.dart';
import '../../mainBody.dart';
import '../../widget/QCWIDGET/W1SINGLESHOT/SINGLESHOTwidget.dart';
import '../../widget/common/Loading.dart';
import '../../widget/onlyINqcui/popup.dart';
import '../P1FIRSTUI/FIRSTuiVAR.dart';
import '../page1.dart';
import 'GASVIC001var.dart';

class MICROVICKER_GASVIC001main extends StatelessWidget {
  MICROVICKER_GASVIC001main({Key? key, this.data}) : super(key: key);
  GASVIC001SCHEMA? data;
  @override
  Widget build(BuildContext context) {
    return _TRICKER_GASVIC001_BlocBuffer(
      data: data,
    );
  }
}

class _TRICKER_GASVIC001_BlocBuffer extends StatelessWidget {
  _TRICKER_GASVIC001_BlocBuffer({
    Key? key,
    this.data,
  }) : super(key: key);
  GASVIC001SCHEMA? data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TRICKER_GASVIC001_Bloc(),
        child: BlocBuilder<TRICKER_GASVIC001_Bloc, String>(
          builder: (context, trick) {
            return GASVIC001body(data: data);
          },
        ));
  }
}

class GASVIC001body extends StatefulWidget {
  GASVIC001body({Key? key, this.data}) : super(key: key);
  GASVIC001SCHEMA? data;

  @override
  State<GASVIC001body> createState() => _GASVIC001bodyState();
}

class _GASVIC001bodyState extends State<GASVIC001body> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    context.read<GASVIC001_Bloc>().add(GASVIC001_READ());
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
    GASVIC001var.DHtimer.cancel();
    FIRSTUI.SEARCH = FIRSTUI.POACTIVE;
    GASVIC001var.ItemPickSELECT = '';
    context.read<TRICKER_GASVIC001_Bloc>().add(TRICKER_GASVIC001SETZERO());
    CuPage = Page1();
    MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
  }

  @override
  Widget build(BuildContext context) {
    PageMemory = 5;
    if (widget.data?.UPDATE == 'OK') {
      setState(() {
        GASVIC001var.PO = widget.data?.PO ?? '';
        GASVIC001var.CP = widget.data?.CP ?? '';
        GASVIC001var.QTY = widget.data?.QTY ?? '';
        GASVIC001var.PROCESS = widget.data?.PROCESS ?? '';
        GASVIC001var.CUSLOT = widget.data?.CUSLOT ?? '';
        GASVIC001var.TPKLOT = widget.data?.TPKLOT ?? '';
        GASVIC001var.FG = widget.data?.FG ?? '';
        GASVIC001var.CUSTOMER = widget.data?.CUSTOMER ?? '';
        GASVIC001var.PART = widget.data?.PART ?? '';
        GASVIC001var.PARTNAME = widget.data?.PARTNAME ?? '';
        GASVIC001var.MATERIAL = widget.data?.MATERIAL ?? '';
        //
        GASVIC001var.ItemPick = widget.data?.ItemPick ?? [''];
        GASVIC001var.PCS = widget.data?.PCS ?? '';
        // GASVIC001var.PCS = '10';
        GASVIC001var.PCSleft = widget.data?.PCSleft ?? '';
        // GASVIC001var.PCSleft = '10';
        GASVIC001var.POINTs = widget.data?.POINTs ?? '';
        // GASVIC001var.POINTs = '10';
        // if (GASVIC001var.ItemPickSELECT != "") {
        //   //
        //   if (GASVIC001var.POINTs == "") {
        //     //
        //     GASVIC001var.POINTs == "0";
        //   }
        // }
        GASVIC001var.UNIT = widget.data?.UNIT ?? '';
        // GASVIC001var.UNIT = 'pcs/lots';
        GASVIC001var.INTERSEC = widget.data?.INTERSEC ?? '';
        //
        GASVIC001var.RESULTFORMAT = widget.data?.RESULTFORMAT ?? '';
        GASVIC001var.GRAPHTYPE = widget.data?.GRAPHTYPE ?? '';
        GASVIC001var.GAP = widget.data?.GAP ?? '';
        GASVIC001var.GAPnameList = widget.data?.GAPnameList ?? [''];
        //
        GASVIC001var.preview = widget.data?.preview ?? [];
        GASVIC001var.confirmdata = widget.data?.confirmdata ?? [];
        GASVIC001var.ITEMleftUNIT = widget.data?.ITEMleftUNIT ?? [];
        GASVIC001var.ITEMleftVALUE = widget.data?.ITEMleftVALUE ?? [];

        GASVIC001var.PICs = widget.data?.Pic ?? '';

        if (GASVIC001var.PCSleft == '0') {
          BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
              "ITEM STATUS", "COMPLETE DATA", enumNotificationlist.Success);
        }

        widget.data?.UPDATE = '-';
      });

      Timer timer = Timer(const Duration(seconds: 1), () {
        context.read<GASVIC001_Bloc>().add(GASVIC001_READ());
      });
      GASVIC001var.DHtimer = timer;
    }
    return SINGLESHOTmain(
      //------ Left
      LABEL: "GAS-VIC-001",
      PO: GASVIC001var.PO,
      CP: GASVIC001var.CP,
      QTY: GASVIC001var.QTY,
      PROCESS: GASVIC001var.PROCESS,
      CUSLOT: GASVIC001var.CUSLOT,
      TPKLOT: GASVIC001var.TPKLOT,
      FG: GASVIC001var.FG,
      CUSTOMER: GASVIC001var.CUSTOMER,
      PART: GASVIC001var.PART,
      PARTNAME: GASVIC001var.PARTNAME,
      MATERIAL: GASVIC001var.MATERIAL,
      //------- Top
      ItemPickres: (v) {
        print(v);
        GASVIC001var.ItemPickSELECT = v;
        //
        context
            .read<TRICKER_GASVIC001_Bloc>()
            .add(TRICKER_GASVIC001geteachITEM());
      },
      ItemPick: GASVIC001var.ItemPick,
      PCS: GASVIC001var.PCS,
      PCSleft: GASVIC001var.PCSleft,
      POINTs: GASVIC001var.POINTs,
      UNIT: GASVIC001var.UNIT,
      INTERSEC: GASVIC001var.INTERSEC,
      RESULTFORMAT: GASVIC001var.RESULTFORMAT,
      Ghtype: GASVIC001var.GRAPHTYPE,
      GAP: GASVIC001var.GAP,
      GAPnameList: GASVIC001var.GAPnameList,
      GAPname: GASVIC001var.GAPname,
      GAPnamePick: (v) {
        GASVIC001var.GAPname = v;
        context
            .read<TRICKER_GASVIC001_Bloc>()
            .add(TRICKER_GASVIC001geteachGRAPH());
      },
      //------- Bottom
      ACCEPT: (v) {
        if ((GASVIC001var.RESULTFORMAT == 'Graph' &&
                GASVIC001var.GAPname != '') ||
            GASVIC001var.RESULTFORMAT != 'Graph') {
          if (GASVIC001var.PCS != '' &&
              GASVIC001var.POINTs != '' &&
              GASVIC001var.ItemPickSELECT != '') {
            if (int.parse(GASVIC001var.POINTs) >
                GASVIC001var.confirmdata.length) {
              context
                  .read<TRICKER_GASVIC001_Bloc>()
                  .add(TRICKER_GASVIC001confirmdata());
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
        if (GASVIC001var.PCS != '' &&
            GASVIC001var.POINTs != '' &&
            GASVIC001var.ItemPickSELECT != '') {
          if (int.parse(GASVIC001var.POINTs) ==
              GASVIC001var.confirmdata.length) {
            if (int.parse(GASVIC001var.PCSleft) > 0) {
              onLoadingFAKE(context);
              context
                  .read<TRICKER_GASVIC001_Bloc>()
                  .add(TRICKER_GASVIC001FINISH());
            }
          } else {
            WORNINGpop(context, "POINTs are not complete");
          }
        } else {
          WORNINGpop(context, "Please select item");
        }
      },
      preview: GASVIC001var.preview,
      confirmdata: GASVIC001var.confirmdata.reversed.toList(),
      //------- Right
      CLEAR: (v) {
        context.read<TRICKER_GASVIC001_Bloc>().add(TRICKER_GASVIC001CLEAR());
      },
      BACKPAGE: (v) {
        GASVIC001var.DHtimer.cancel();
        FIRSTUI.SEARCH = FIRSTUI.POACTIVE;
        GASVIC001var.ItemPickSELECT = '';
        context.read<TRICKER_GASVIC001_Bloc>().add(TRICKER_GASVIC001SETZERO());
        CuPage = Page1();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
      },
      RESETVALUE: (v) {
        context
            .read<TRICKER_GASVIC001_Bloc>()
            .add(TRICKER_GASVIC001RESETVALUE());
      },
      ITEMleftUNIT: GASVIC001var.ITEMleftUNIT,
      ITEMleftVALUE: GASVIC001var.ITEMleftVALUE,
      PICB64: GASVIC001var.PICs,
    );
  }
}
