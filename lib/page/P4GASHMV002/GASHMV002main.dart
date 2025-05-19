import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/BlocEvent/04-01-GASHMV002.dart';
import '../../bloc/BlocEvent/04-02-TrickGASHMV002.dart';
import '../../bloc/BlocEvent/ChangePageEvent.dart';
import '../../bloc/cubit/NotificationEvent.dart';
import '../../data/global.dart';
import '../../mainBody.dart';
import '../../widget/QCWIDGET/W1SINGLESHOT/SINGLESHOTwidget.dart';
import '../../widget/QCWIDGET/W2MULTISHOT/MULTISHOTwidget.dart';
import '../../widget/common/Loading.dart';
import '../../widget/onlyINqcui/popup.dart';
import '../P1FIRSTUI/FIRSTuiVAR.dart';
import '../page1.dart';
import 'GASHMV002var.dart';

class MICROVICKER_GASHMV002main extends StatelessWidget {
  MICROVICKER_GASHMV002main({Key? key, this.data}) : super(key: key);
  GASHMV002SCHEMA? data;
  @override
  Widget build(BuildContext context) {
    return _TRICKER_GASHMV002_BlocBuffer(
      data: data,
    );
  }
}

class _TRICKER_GASHMV002_BlocBuffer extends StatelessWidget {
  _TRICKER_GASHMV002_BlocBuffer({
    Key? key,
    this.data,
  }) : super(key: key);
  GASHMV002SCHEMA? data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TRICKER_GASHMV002_Bloc(),
        child: BlocBuilder<TRICKER_GASHMV002_Bloc, String>(
          builder: (context, trick) {
            return ROCKWELL_GASHMV002body(data: data);
          },
        ));
  }
}

class ROCKWELL_GASHMV002body extends StatefulWidget {
  ROCKWELL_GASHMV002body({Key? key, this.data}) : super(key: key);
  GASHMV002SCHEMA? data;

  @override
  State<ROCKWELL_GASHMV002body> createState() => _ROCKWELL_GASHMV002bodyState();
}

class _ROCKWELL_GASHMV002bodyState extends State<ROCKWELL_GASHMV002body> {
  @override
  void initState() {
    super.initState();
    context.read<GASHMV002_Bloc>().add(GASHMV002_READ());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data?.UPDATE == 'OK') {
      setState(() {
        GASHMV002var.PO = widget.data?.PO ?? '';
        GASHMV002var.CP = widget.data?.CP ?? '';
        GASHMV002var.QTY = widget.data?.QTY ?? '';
        GASHMV002var.PROCESS = widget.data?.PROCESS ?? '';
        GASHMV002var.CUSLOT = widget.data?.CUSLOT ?? '';
        GASHMV002var.TPKLOT = widget.data?.TPKLOT ?? '';
        GASHMV002var.FG = widget.data?.FG ?? '';
        GASHMV002var.CUSTOMER = widget.data?.CUSTOMER ?? '';
        GASHMV002var.PART = widget.data?.PART ?? '';
        GASHMV002var.PARTNAME = widget.data?.PARTNAME ?? '';
        GASHMV002var.MATERIAL = widget.data?.MATERIAL ?? '';
        //
        GASHMV002var.ItemPick = widget.data?.ItemPick ?? [''];
        GASHMV002var.PCS = widget.data?.PCS ?? '';
        // GASHMV002var.PCS = '10';
        GASHMV002var.PCSleft = widget.data?.PCSleft ?? '';
        // GASHMV002var.PCSleft = '10';
        GASHMV002var.POINTs = widget.data?.POINTs ?? '';
        // GASHMV002var.POINTs = '10';
        // if (GASHMV002var.ItemPickSELECT != "") {
        //   //
        //   if (GASHMV002var.POINTs == "") {
        //     //
        //     GASHMV002var.POINTs == "0";
        //   }
        // }
        GASHMV002var.UNIT = widget.data?.UNIT ?? '';
        // GASHMV002var.UNIT = 'pcs/lots';
        GASHMV002var.INTERSEC = widget.data?.INTERSEC ?? '';
        //
        GASHMV002var.RESULTFORMAT = widget.data?.RESULTFORMAT ?? '';
        GASHMV002var.GRAPHTYPE = widget.data?.GRAPHTYPE ?? '';
        GASHMV002var.GAP = widget.data?.GAP ?? '';
        GASHMV002var.GAPnameList = widget.data?.GAPnameList ?? [''];
        //
        GASHMV002var.preview = widget.data?.preview ?? [];
        GASHMV002var.confirmdata = widget.data?.confirmdata ?? [];
        GASHMV002var.ITEMleftUNIT = widget.data?.ITEMleftUNIT ?? [];
        GASHMV002var.ITEMleftVALUE = widget.data?.ITEMleftVALUE ?? [];

        GASHMV002var.PICs = widget.data?.Pic ?? '';

        if (GASHMV002var.PCSleft == '0') {
          BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
              "ITEM STATUS", "COMPLETE DATA", enumNotificationlist.Success);
        }

        widget.data?.UPDATE = '-';
      });

      Timer timer = Timer(const Duration(seconds: 1), () {
        context.read<GASHMV002_Bloc>().add(GASHMV002_READ());
      });
      GASHMV002var.DHtimer = timer;
    }
    return MULTISHOTmain(
      //------ Left
      LABEL: "GAS-HMV-002",
      PO: GASHMV002var.PO,
      CP: GASHMV002var.CP,
      QTY: GASHMV002var.QTY,
      PROCESS: GASHMV002var.PROCESS,
      CUSLOT: GASHMV002var.CUSLOT,
      TPKLOT: GASHMV002var.TPKLOT,
      FG: GASHMV002var.FG,
      CUSTOMER: GASHMV002var.CUSTOMER,
      PART: GASHMV002var.PART,
      PARTNAME: GASHMV002var.PARTNAME,
      MATERIAL: GASHMV002var.MATERIAL,
      //------- Top
      ItemPickres: (v) {
        print(v);
        GASHMV002var.ItemPickSELECT = v;
        //
        context
            .read<TRICKER_GASHMV002_Bloc>()
            .add(TRICKER_GASHMV002geteachITEM());
      },
      ItemPick: GASHMV002var.ItemPick,
      PCS: GASHMV002var.PCS,
      PCSleft: GASHMV002var.PCSleft,
      POINTs: GASHMV002var.POINTs,
      UNIT: GASHMV002var.UNIT,
      INTERSEC: GASHMV002var.INTERSEC,
      RESULTFORMAT: GASHMV002var.RESULTFORMAT,
      Ghtype: GASHMV002var.GRAPHTYPE,
      GAP: GASHMV002var.GAP,
      GAPnameList: GASHMV002var.GAPnameList,
      GAPname: GASHMV002var.GAPname,
      GAPnamePick: (v) {
        GASHMV002var.GAPname = v;
        context
            .read<TRICKER_GASHMV002_Bloc>()
            .add(TRICKER_GASHMV002geteachGRAPH());
      },
      //------- Bottom
      DATA1: (v) {
        context
            .read<TRICKER_GASHMV002_Bloc>()
            .add(TRICKER_GASHMV002confirmdata1());
      },
      DATA2: (v) {
        context
            .read<TRICKER_GASHMV002_Bloc>()
            .add(TRICKER_GASHMV002confirmdata2());
      },
      DATA3: (v) {
        context
            .read<TRICKER_GASHMV002_Bloc>()
            .add(TRICKER_GASHMV002confirmdata());
      },
      FINISH: (v) {
        if (GASHMV002var.PCS != '' &&
            GASHMV002var.POINTs != '' &&
            GASHMV002var.ItemPickSELECT != '') {
          if (int.parse(GASHMV002var.POINTs) ==
              GASHMV002var.confirmdata.length) {
            if (int.parse(GASHMV002var.PCSleft) > 0) {
              onLoadingFAKE(context);
              context
                  .read<TRICKER_GASHMV002_Bloc>()
                  .add(TRICKER_GASHMV002FINISH());
            }
          } else {
            WORNINGpop(context, "POINTs are not complete");
          }
        } else {
          WORNINGpop(context, "Please select item");
        }
      },
      preview: GASHMV002var.preview,
      confirmdata: GASHMV002var.confirmdata.reversed.toList(),
      //------- Right
      CLEAR: (v) {
        context.read<TRICKER_GASHMV002_Bloc>().add(TRICKER_GASHMV002CLEAR());
      },
      BACKPAGE: (v) {
        GASHMV002var.DHtimer.cancel();
        FIRSTUI.SEARCH = FIRSTUI.POACTIVE;
        GASHMV002var.ItemPickSELECT = '';
        context.read<TRICKER_GASHMV002_Bloc>().add(TRICKER_GASHMV002SETZERO());
        CuPage = Page1();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
      },
      RESETVALUE: (v) {
        context
            .read<TRICKER_GASHMV002_Bloc>()
            .add(TRICKER_GASHMV002RESETVALUE());
      },
      ITEMleftUNIT: GASHMV002var.ITEMleftUNIT,
      ITEMleftVALUE: GASHMV002var.ITEMleftVALUE,
      PICB64: GASHMV002var.PICs,
    );
  }
}
