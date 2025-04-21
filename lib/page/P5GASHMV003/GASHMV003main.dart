import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/BlocEvent/05-01-GASHMV003.dart';
import '../../bloc/BlocEvent/05-02-TrickGASHMV003.dart';
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
import 'GASHMV003var.dart';

class MICROVICKER_GASHMV003main extends StatelessWidget {
  MICROVICKER_GASHMV003main({Key? key, this.data}) : super(key: key);
  GASHMV003SCHEMA? data;
  @override
  Widget build(BuildContext context) {
    return _TRICKER_GASHMV003_BlocBuffer(
      data: data,
    );
  }
}

class _TRICKER_GASHMV003_BlocBuffer extends StatelessWidget {
  _TRICKER_GASHMV003_BlocBuffer({
    Key? key,
    this.data,
  }) : super(key: key);
  GASHMV003SCHEMA? data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TRICKER_GASHMV003_Bloc(),
        child: BlocBuilder<TRICKER_GASHMV003_Bloc, String>(
          builder: (context, trick) {
            return ROCKWELL_GASHMV003body(data: data);
          },
        ));
  }
}

class ROCKWELL_GASHMV003body extends StatefulWidget {
  ROCKWELL_GASHMV003body({Key? key, this.data}) : super(key: key);
  GASHMV003SCHEMA? data;

  @override
  State<ROCKWELL_GASHMV003body> createState() => _ROCKWELL_GASHMV003bodyState();
}

class _ROCKWELL_GASHMV003bodyState extends State<ROCKWELL_GASHMV003body> {
  @override
  void initState() {
    super.initState();
    context.read<GASHMV003_Bloc>().add(GASHMV003_READ());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data?.UPDATE == 'OK') {
      setState(() {
        GASHMV003var.PO = widget.data?.PO ?? '';
        GASHMV003var.CP = widget.data?.CP ?? '';
        GASHMV003var.QTY = widget.data?.QTY ?? '';
        GASHMV003var.PROCESS = widget.data?.PROCESS ?? '';
        GASHMV003var.CUSLOT = widget.data?.CUSLOT ?? '';
        GASHMV003var.TPKLOT = widget.data?.TPKLOT ?? '';
        GASHMV003var.FG = widget.data?.FG ?? '';
        GASHMV003var.CUSTOMER = widget.data?.CUSTOMER ?? '';
        GASHMV003var.PART = widget.data?.PART ?? '';
        GASHMV003var.PARTNAME = widget.data?.PARTNAME ?? '';
        GASHMV003var.MATERIAL = widget.data?.MATERIAL ?? '';
        //
        GASHMV003var.ItemPick = widget.data?.ItemPick ?? [''];
        GASHMV003var.PCS = widget.data?.PCS ?? '';
        // GASHMV003var.PCS = '10';
        GASHMV003var.PCSleft = widget.data?.PCSleft ?? '';
        // GASHMV003var.PCSleft = '10';
        GASHMV003var.POINTs = widget.data?.POINTs ?? '';
        // GASHMV003var.POINTs = '10';
        // if (GASHMV003var.ItemPickSELECT != "") {
        //   //
        //   if (GASHMV003var.POINTs == "") {
        //     //
        //     GASHMV003var.POINTs == "0";
        //   }
        // }
        GASHMV003var.UNIT = widget.data?.UNIT ?? '';
        // GASHMV003var.UNIT = 'pcs/lots';
        GASHMV003var.INTERSEC = widget.data?.INTERSEC ?? '';
        //
        GASHMV003var.RESULTFORMAT = widget.data?.RESULTFORMAT ?? '';
        GASHMV003var.GRAPHTYPE = widget.data?.GRAPHTYPE ?? '';
        GASHMV003var.GAP = widget.data?.GAP ?? '';
        GASHMV003var.GAPnameList = widget.data?.GAPnameList ?? [''];
        //
        GASHMV003var.preview = widget.data?.preview ?? [];
        GASHMV003var.confirmdata = widget.data?.confirmdata ?? [];
        GASHMV003var.ITEMleftUNIT = widget.data?.ITEMleftUNIT ?? [];
        GASHMV003var.ITEMleftVALUE = widget.data?.ITEMleftVALUE ?? [];

        GASHMV003var.PICs = widget.data?.Pic ?? '';

        if (GASHMV003var.PCSleft == '0') {
          BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
              "ITEM STATUS", "COMPLETE DATA", enumNotificationlist.Success);
        }

        widget.data?.UPDATE = '-';
      });

      Timer timer = Timer(const Duration(seconds: 1), () {
        context.read<GASHMV003_Bloc>().add(GASHMV003_READ());
      });
      GASHMV003var.DHtimer = timer;
    }
    return MULTISHOTmain(
      //------ Left
      LABEL: "GAS-HMV-003",
      PO: GASHMV003var.PO,
      CP: GASHMV003var.CP,
      QTY: GASHMV003var.QTY,
      PROCESS: GASHMV003var.PROCESS,
      CUSLOT: GASHMV003var.CUSLOT,
      TPKLOT: GASHMV003var.TPKLOT,
      FG: GASHMV003var.FG,
      CUSTOMER: GASHMV003var.CUSTOMER,
      PART: GASHMV003var.PART,
      PARTNAME: GASHMV003var.PARTNAME,
      MATERIAL: GASHMV003var.MATERIAL,
      //------- Top
      ItemPickres: (v) {
        print(v);
        GASHMV003var.ItemPickSELECT = v;
        //
        context
            .read<TRICKER_GASHMV003_Bloc>()
            .add(TRICKER_GASHMV003geteachITEM());
      },
      ItemPick: GASHMV003var.ItemPick,
      PCS: GASHMV003var.PCS,
      PCSleft: GASHMV003var.PCSleft,
      POINTs: GASHMV003var.POINTs,
      UNIT: GASHMV003var.UNIT,
      INTERSEC: GASHMV003var.INTERSEC,
      RESULTFORMAT: GASHMV003var.RESULTFORMAT,
      Ghtype: GASHMV003var.GRAPHTYPE,
      GAP: GASHMV003var.GAP,
      GAPnameList: GASHMV003var.GAPnameList,
      GAPname: GASHMV003var.GAPname,
      GAPnamePick: (v) {
        GASHMV003var.GAPname = v;
        context
            .read<TRICKER_GASHMV003_Bloc>()
            .add(TRICKER_GASHMV003geteachGRAPH());
      },
      //------- Bottom
      DATA1: (v) {
        context
            .read<TRICKER_GASHMV003_Bloc>()
            .add(TRICKER_GASHMV003confirmdata1());
      },
      DATA2: (v) {
        context
            .read<TRICKER_GASHMV003_Bloc>()
            .add(TRICKER_GASHMV003confirmdata2());
      },
      DATA3: (v) {
        context
            .read<TRICKER_GASHMV003_Bloc>()
            .add(TRICKER_GASHMV003confirmdata3());
      },
      FINISH: (v) {
        if (GASHMV003var.PCS != '' &&
            GASHMV003var.POINTs != '' &&
            GASHMV003var.ItemPickSELECT != '') {
          if (int.parse(GASHMV003var.POINTs) ==
              GASHMV003var.confirmdata.length) {
            if (int.parse(GASHMV003var.PCSleft) > 0) {
              onLoadingFAKE(context);
              context
                  .read<TRICKER_GASHMV003_Bloc>()
                  .add(TRICKER_GASHMV003FINISH());
            }
          } else {
            WORNINGpop(context, "POINTs are not complete");
          }
        } else {
          WORNINGpop(context, "Please select item");
        }
      },
      preview: GASHMV003var.preview,
      confirmdata: GASHMV003var.confirmdata.reversed.toList(),
      //------- Right
      CLEAR: (v) {
        context.read<TRICKER_GASHMV003_Bloc>().add(TRICKER_GASHMV003CLEAR());
      },
      BACKPAGE: (v) {
        GASHMV003var.DHtimer.cancel();
        FIRSTUI.SEARCH = FIRSTUI.POACTIVE;
        GASHMV003var.ItemPickSELECT = '';
        context.read<TRICKER_GASHMV003_Bloc>().add(TRICKER_GASHMV003SETZERO());
        CuPage = Page1();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
      },
      RESETVALUE: (v) {
        context
            .read<TRICKER_GASHMV003_Bloc>()
            .add(TRICKER_GASHMV003RESETVALUE());
      },
      ITEMleftUNIT: GASHMV003var.ITEMleftUNIT,
      ITEMleftVALUE: GASHMV003var.ITEMleftVALUE,
      PICB64: GASHMV003var.PICs,
    );
  }
}
