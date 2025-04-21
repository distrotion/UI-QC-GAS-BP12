import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/BlocEvent/03-01-GASHMV001.dart';
import '../../bloc/BlocEvent/03-02-TrickGASHMV001.dart';
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
import 'GASHMV001var.dart';

class MICROVICKER_GASHMV001main extends StatelessWidget {
  MICROVICKER_GASHMV001main({Key? key, this.data}) : super(key: key);
  GASHMV001SCHEMA? data;
  @override
  Widget build(BuildContext context) {
    return _TRICKER_GASHMV001_BlocBuffer(
      data: data,
    );
  }
}

class _TRICKER_GASHMV001_BlocBuffer extends StatelessWidget {
  _TRICKER_GASHMV001_BlocBuffer({
    Key? key,
    this.data,
  }) : super(key: key);
  GASHMV001SCHEMA? data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TRICKER_GASHMV001_Bloc(),
        child: BlocBuilder<TRICKER_GASHMV001_Bloc, String>(
          builder: (context, trick) {
            return ROCKWELL_GASHMV001body(data: data);
          },
        ));
  }
}

class ROCKWELL_GASHMV001body extends StatefulWidget {
  ROCKWELL_GASHMV001body({Key? key, this.data}) : super(key: key);
  GASHMV001SCHEMA? data;

  @override
  State<ROCKWELL_GASHMV001body> createState() => _ROCKWELL_GASHMV001bodyState();
}

class _ROCKWELL_GASHMV001bodyState extends State<ROCKWELL_GASHMV001body> {
  @override
  void initState() {
    super.initState();
    context.read<GASHMV001_Bloc>().add(GASHMV001_READ());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data?.UPDATE == 'OK') {
      setState(() {
        GASHMV001var.PO = widget.data?.PO ?? '';
        GASHMV001var.CP = widget.data?.CP ?? '';
        GASHMV001var.QTY = widget.data?.QTY ?? '';
        GASHMV001var.PROCESS = widget.data?.PROCESS ?? '';
        GASHMV001var.CUSLOT = widget.data?.CUSLOT ?? '';
        GASHMV001var.TPKLOT = widget.data?.TPKLOT ?? '';
        GASHMV001var.FG = widget.data?.FG ?? '';
        GASHMV001var.CUSTOMER = widget.data?.CUSTOMER ?? '';
        GASHMV001var.PART = widget.data?.PART ?? '';
        GASHMV001var.PARTNAME = widget.data?.PARTNAME ?? '';
        GASHMV001var.MATERIAL = widget.data?.MATERIAL ?? '';
        //
        GASHMV001var.ItemPick = widget.data?.ItemPick ?? [''];
        GASHMV001var.PCS = widget.data?.PCS ?? '';
        // GASHMV001var.PCS = '10';
        GASHMV001var.PCSleft = widget.data?.PCSleft ?? '';
        // GASHMV001var.PCSleft = '10';
        GASHMV001var.POINTs = widget.data?.POINTs ?? '';
        // GASHMV001var.POINTs = '10';
        // if (GASHMV001var.ItemPickSELECT != "") {
        //   //
        //   if (GASHMV001var.POINTs == "") {
        //     //
        //     GASHMV001var.POINTs == "0";
        //   }
        // }
        GASHMV001var.UNIT = widget.data?.UNIT ?? '';
        // GASHMV001var.UNIT = 'pcs/lots';
        GASHMV001var.INTERSEC = widget.data?.INTERSEC ?? '';
        //
        GASHMV001var.RESULTFORMAT = widget.data?.RESULTFORMAT ?? '';
        GASHMV001var.GRAPHTYPE = widget.data?.GRAPHTYPE ?? '';
        GASHMV001var.GAP = widget.data?.GAP ?? '';
        GASHMV001var.GAPnameList = widget.data?.GAPnameList ?? [''];
        //
        GASHMV001var.preview = widget.data?.preview ?? [];
        GASHMV001var.confirmdata = widget.data?.confirmdata ?? [];
        GASHMV001var.ITEMleftUNIT = widget.data?.ITEMleftUNIT ?? [];
        GASHMV001var.ITEMleftVALUE = widget.data?.ITEMleftVALUE ?? [];
        //

        GASHMV001var.PICs = widget.data?.Pic ?? '';

        if (GASHMV001var.PCSleft == '0') {
          BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
              "ITEM STATUS", "COMPLETE DATA", enumNotificationlist.Success);
        }

        widget.data?.UPDATE = '-';
      });

      Timer timer = Timer(const Duration(seconds: 1), () {
        context.read<GASHMV001_Bloc>().add(GASHMV001_READ());
      });
      GASHMV001var.DHtimer = timer;
    }
    return MULTISHOTmain(
      //------ Left
      LABEL: "GAS-HMV-001",
      PO: GASHMV001var.PO,
      CP: GASHMV001var.CP,
      QTY: GASHMV001var.QTY,
      PROCESS: GASHMV001var.PROCESS,
      CUSLOT: GASHMV001var.CUSLOT,
      TPKLOT: GASHMV001var.TPKLOT,
      FG: GASHMV001var.FG,
      CUSTOMER: GASHMV001var.CUSTOMER,
      PART: GASHMV001var.PART,
      PARTNAME: GASHMV001var.PARTNAME,
      MATERIAL: GASHMV001var.MATERIAL,
      //------- Top
      ItemPickres: (v) {
        print(v);
        GASHMV001var.ItemPickSELECT = v;
        //
        context
            .read<TRICKER_GASHMV001_Bloc>()
            .add(TRICKER_GASHMV001geteachITEM());
      },
      ItemPick: GASHMV001var.ItemPick,
      PCS: GASHMV001var.PCS,
      PCSleft: GASHMV001var.PCSleft,
      POINTs: GASHMV001var.POINTs,
      UNIT: GASHMV001var.UNIT,
      INTERSEC: GASHMV001var.INTERSEC,
      RESULTFORMAT: GASHMV001var.RESULTFORMAT,
      Ghtype: GASHMV001var.GRAPHTYPE,
      GAP: GASHMV001var.GAP,
      GAPnameList: GASHMV001var.GAPnameList,
      GAPname: GASHMV001var.GAPname,
      GAPnamePick: (v) {
        GASHMV001var.GAPname = v;
        context
            .read<TRICKER_GASHMV001_Bloc>()
            .add(TRICKER_GASHMV001geteachGRAPH());
      },
      //------- Bottom
      DATA1: (v) {
        context
            .read<TRICKER_GASHMV001_Bloc>()
            .add(TRICKER_GASHMV001confirmdata1());
      },
      DATA2: (v) {
        context
            .read<TRICKER_GASHMV001_Bloc>()
            .add(TRICKER_GASHMV001confirmdata2());
      },
      DATA3: (v) {
        print("----");
        context
            .read<TRICKER_GASHMV001_Bloc>()
            .add(TRICKER_GASHMV001confirmdata3());
      },
      FINISH: (v) {
        if (GASHMV001var.PCS != '' &&
            GASHMV001var.POINTs != '' &&
            GASHMV001var.ItemPickSELECT != '') {
          if (int.parse(GASHMV001var.POINTs) ==
              GASHMV001var.confirmdata.length) {
            if (int.parse(GASHMV001var.PCSleft) > 0) {
              onLoadingFAKE(context);
              context
                  .read<TRICKER_GASHMV001_Bloc>()
                  .add(TRICKER_GASHMV001FINISH());
            }
          } else {
            WORNINGpop(context, "POINTs are not complete");
          }
        } else {
          WORNINGpop(context, "Please select item");
        }
      },
      preview: GASHMV001var.preview,
      confirmdata: GASHMV001var.confirmdata.reversed.toList(),
      //------- Right
      CLEAR: (v) {
        context.read<TRICKER_GASHMV001_Bloc>().add(TRICKER_GASHMV001CLEAR());
      },
      BACKPAGE: (v) {
        GASHMV001var.DHtimer.cancel();
        FIRSTUI.SEARCH = FIRSTUI.POACTIVE;
        GASHMV001var.ItemPickSELECT = '';
        context.read<TRICKER_GASHMV001_Bloc>().add(TRICKER_GASHMV001SETZERO());
        CuPage = Page1();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
      },
      RESETVALUE: (v) {
        context
            .read<TRICKER_GASHMV001_Bloc>()
            .add(TRICKER_GASHMV001RESETVALUE());
      },
      ITEMleftUNIT: GASHMV001var.ITEMleftUNIT,
      ITEMleftVALUE: GASHMV001var.ITEMleftVALUE,
      //
      PICB64: GASHMV001var.PICs,
    );
  }
}
