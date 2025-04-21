import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/BlocEvent/12-01-GASOHR001.dart';
import '../../bloc/BlocEvent/12-02-TrickGASOHR001.dart';
import '../../bloc/BlocEvent/ChangePageEvent.dart';
import '../../bloc/cubit/NotificationEvent.dart';
import '../../data/global.dart';
import '../../mainBody.dart';
import '../../widget/QCWIDGET/W1SINGLESHOT/SINGLESHOTwidget.dart';
import '../../widget/common/Loading.dart';
import '../../widget/onlyINqcui/popup.dart';
import '../P1FIRSTUI/FIRSTuiVAR.dart';
import '../page1.dart';
import 'GASOHR001var.dart';

class MICROVICKER_GASOHR001main extends StatelessWidget {
  MICROVICKER_GASOHR001main({Key? key, this.data}) : super(key: key);
  GASOHR001SCHEMA? data;
  @override
  Widget build(BuildContext context) {
    return _TRICKER_GASOHR001_BlocBuffer(
      data: data,
    );
  }
}

class _TRICKER_GASOHR001_BlocBuffer extends StatelessWidget {
  _TRICKER_GASOHR001_BlocBuffer({
    Key? key,
    this.data,
  }) : super(key: key);
  GASOHR001SCHEMA? data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TRICKER_GASOHR001_Bloc(),
        child: BlocBuilder<TRICKER_GASOHR001_Bloc, String>(
          builder: (context, trick) {
            return ROCKWELL_GASOHR001body(data: data);
          },
        ));
  }
}

class ROCKWELL_GASOHR001body extends StatefulWidget {
  ROCKWELL_GASOHR001body({Key? key, this.data}) : super(key: key);
  GASOHR001SCHEMA? data;

  @override
  State<ROCKWELL_GASOHR001body> createState() => _ROCKWELL_GASOHR001bodyState();
}

class _ROCKWELL_GASOHR001bodyState extends State<ROCKWELL_GASOHR001body> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    context.read<GASOHR001_Bloc>().add(GASOHR001_READ());
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
    GASOHR001var.DHtimer.cancel();
    FIRSTUI.SEARCH = FIRSTUI.POACTIVE;
    GASOHR001var.ItemPickSELECT = '';
    context.read<TRICKER_GASOHR001_Bloc>().add(TRICKER_GASOHR001SETZERO());
    CuPage = Page1();
    MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
  }

  @override
  Widget build(BuildContext context) {
    PageMemory = 5;
    if (widget.data?.UPDATE == 'OK') {
      setState(() {
        GASOHR001var.PO = widget.data?.PO ?? '';
        GASOHR001var.CP = widget.data?.CP ?? '';
        GASOHR001var.QTY = widget.data?.QTY ?? '';
        GASOHR001var.PROCESS = widget.data?.PROCESS ?? '';
        GASOHR001var.CUSLOT = widget.data?.CUSLOT ?? '';
        GASOHR001var.TPKLOT = widget.data?.TPKLOT ?? '';
        GASOHR001var.FG = widget.data?.FG ?? '';
        GASOHR001var.CUSTOMER = widget.data?.CUSTOMER ?? '';
        GASOHR001var.PART = widget.data?.PART ?? '';
        GASOHR001var.PARTNAME = widget.data?.PARTNAME ?? '';
        GASOHR001var.MATERIAL = widget.data?.MATERIAL ?? '';
        //
        GASOHR001var.ItemPick = widget.data?.ItemPick ?? [''];
        GASOHR001var.PCS = widget.data?.PCS ?? '';
        // GASOHR001var.PCS = '10';
        GASOHR001var.PCSleft = widget.data?.PCSleft ?? '';
        // GASOHR001var.PCSleft = '10';
        GASOHR001var.POINTs = widget.data?.POINTs ?? '';
        // GASOHR001var.POINTs = '10';
        // if (GASOHR001var.ItemPickSELECT != "") {
        //   //
        //   if (GASOHR001var.POINTs == "") {
        //     //
        //     GASOHR001var.POINTs == "0";
        //   }
        // }
        GASOHR001var.UNIT = widget.data?.UNIT ?? '';
        // GASOHR001var.UNIT = 'pcs/lots';
        GASOHR001var.INTERSEC = widget.data?.INTERSEC ?? '';
        //
        GASOHR001var.RESULTFORMAT = widget.data?.RESULTFORMAT ?? '';
        GASOHR001var.GRAPHTYPE = widget.data?.GRAPHTYPE ?? '';
        GASOHR001var.GAP = widget.data?.GAP ?? '';
        GASOHR001var.GAPnameList = widget.data?.GAPnameList ?? [''];
        //
        GASOHR001var.preview = widget.data?.preview ?? [];
        GASOHR001var.confirmdata = widget.data?.confirmdata ?? [];
        GASOHR001var.ITEMleftUNIT = widget.data?.ITEMleftUNIT ?? [];
        GASOHR001var.ITEMleftVALUE = widget.data?.ITEMleftVALUE ?? [];

        GASOHR001var.PICs = widget.data?.Pic ?? '';

        if (GASOHR001var.PCSleft == '0') {
          BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
              "ITEM STATUS", "COMPLETE DATA", enumNotificationlist.Success);
        }

        widget.data?.UPDATE = '-';
      });

      Timer timer = Timer(const Duration(seconds: 1), () {
        context.read<GASOHR001_Bloc>().add(GASOHR001_READ());
      });
      GASOHR001var.DHtimer = timer;
    }
    return SINGLESHOTmain(
      //------ Left
      LABEL: "GAS-OHR-001",
      PO: GASOHR001var.PO,
      CP: GASOHR001var.CP,
      QTY: GASOHR001var.QTY,
      PROCESS: GASOHR001var.PROCESS,
      CUSLOT: GASOHR001var.CUSLOT,
      TPKLOT: GASOHR001var.TPKLOT,
      FG: GASOHR001var.FG,
      CUSTOMER: GASOHR001var.CUSTOMER,
      PART: GASOHR001var.PART,
      PARTNAME: GASOHR001var.PARTNAME,
      MATERIAL: GASOHR001var.MATERIAL,
      //------- Top
      ItemPickres: (v) {
        print(v);
        GASOHR001var.ItemPickSELECT = v;
        //
        context
            .read<TRICKER_GASOHR001_Bloc>()
            .add(TRICKER_GASOHR001geteachITEM());
      },
      ItemPick: GASOHR001var.ItemPick,
      PCS: GASOHR001var.PCS,
      PCSleft: GASOHR001var.PCSleft,
      POINTs: GASOHR001var.POINTs,
      UNIT: GASOHR001var.UNIT,
      INTERSEC: GASOHR001var.INTERSEC,
      RESULTFORMAT: GASOHR001var.RESULTFORMAT,
      Ghtype: GASOHR001var.GRAPHTYPE,
      GAP: GASOHR001var.GAP,
      GAPnameList: GASOHR001var.GAPnameList,
      GAPname: GASOHR001var.GAPname,
      GAPnamePick: (v) {
        GASOHR001var.GAPname = v;
        context
            .read<TRICKER_GASOHR001_Bloc>()
            .add(TRICKER_GASOHR001geteachGRAPH());
      },
      //------- Bottom
      ACCEPT: (v) {
        if ((GASOHR001var.RESULTFORMAT == 'Graph' &&
                GASOHR001var.GAPname != '') ||
            GASOHR001var.RESULTFORMAT != 'Graph') {
          if (GASOHR001var.PCS != '' &&
              GASOHR001var.POINTs != '' &&
              GASOHR001var.ItemPickSELECT != '') {
            if (int.parse(GASOHR001var.POINTs) >
                GASOHR001var.confirmdata.length) {
              context
                  .read<TRICKER_GASOHR001_Bloc>()
                  .add(TRICKER_GASOHR001confirmdata());
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
        if (GASOHR001var.PCS != '' &&
            GASOHR001var.POINTs != '' &&
            GASOHR001var.ItemPickSELECT != '') {
          if (int.parse(GASOHR001var.POINTs) ==
              GASOHR001var.confirmdata.length) {
            if (int.parse(GASOHR001var.PCSleft) > 0) {
              onLoadingFAKE(context);
              context
                  .read<TRICKER_GASOHR001_Bloc>()
                  .add(TRICKER_GASOHR001FINISH());
            }
          } else {
            WORNINGpop(context, "POINTs are not complete");
          }
        } else {
          WORNINGpop(context, "Please select item");
        }
      },
      preview: GASOHR001var.preview,
      confirmdata: GASOHR001var.confirmdata.reversed.toList(),
      //------- Right
      CLEAR: (v) {
        context.read<TRICKER_GASOHR001_Bloc>().add(TRICKER_GASOHR001CLEAR());
      },
      BACKPAGE: (v) {
        GASOHR001var.DHtimer.cancel();
        FIRSTUI.SEARCH = FIRSTUI.POACTIVE;
        GASOHR001var.ItemPickSELECT = '';
        context.read<TRICKER_GASOHR001_Bloc>().add(TRICKER_GASOHR001SETZERO());
        CuPage = Page1();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
      },
      RESETVALUE: (v) {
        context
            .read<TRICKER_GASOHR001_Bloc>()
            .add(TRICKER_GASOHR001RESETVALUE());
      },
      ITEMleftUNIT: GASOHR001var.ITEMleftUNIT,
      ITEMleftVALUE: GASOHR001var.ITEMleftVALUE,
      PICB64: GASOHR001var.PICs,
    );
  }
}
