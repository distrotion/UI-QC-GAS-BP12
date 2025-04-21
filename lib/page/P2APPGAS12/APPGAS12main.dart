import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/BlocEvent/02-01-APPGAS12.dart';
import '../../bloc/BlocEvent/02-02-TrickAPPGAS12.dart';
import '../../bloc/BlocEvent/ChangePageEvent.dart';
import '../../bloc/cubit/NotificationEvent.dart';
import '../../data/global.dart';
import '../../mainBody.dart';
import '../../widget/QCWIDGET/W1SINGLESHOT/SINGLESHOTwidget.dart';
import '../../widget/QCWIDGET/W1SINGLESHOTAPR/SINGLESHOTAPRwidget.dart';
import '../../widget/common/Loading.dart';
import '../../widget/onlyINqcui/popup.dart';
import '../P1FIRSTUI/FIRSTuiVAR.dart';
import '../page1.dart';
import 'APPGAS12var.dart';

class APPEARANCE_APPGAS12main extends StatelessWidget {
  APPEARANCE_APPGAS12main({Key? key, this.data}) : super(key: key);
  APPGAS12SCHEMA? data;
  @override
  Widget build(BuildContext context) {
    return _TRICKER_APPGAS12_BlocBuffer(
      data: data,
    );
  }
}

class _TRICKER_APPGAS12_BlocBuffer extends StatelessWidget {
  _TRICKER_APPGAS12_BlocBuffer({
    Key? key,
    this.data,
  }) : super(key: key);
  APPGAS12SCHEMA? data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TRICKER_APPGAS12_Bloc(),
        child: BlocBuilder<TRICKER_APPGAS12_Bloc, String>(
          builder: (context, trick) {
            return ROCKWELL_APPGAS12body(data: data, trick: trick);
          },
        ));
  }
}

class ROCKWELL_APPGAS12body extends StatefulWidget {
  ROCKWELL_APPGAS12body({Key? key, this.data, this.trick}) : super(key: key);
  APPGAS12SCHEMA? data;
  String? trick;

  @override
  State<ROCKWELL_APPGAS12body> createState() => _ROCKWELL_APPGAS12bodyState();
}

class _ROCKWELL_APPGAS12bodyState extends State<ROCKWELL_APPGAS12body> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    context.read<APPGAS12_Bloc>().add(APPGAS12_READ());
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
    APPGAS12var.DHtimer.cancel();
    FIRSTUI.SEARCH = FIRSTUI.POACTIVE;
    APPGAS12var.ItemPickSELECT = '';
    context.read<TRICKER_APPGAS12_Bloc>().add(TRICKER_APPGAS12SETZERO());
    CuPage = Page1();
    MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
  }

  @override
  Widget build(BuildContext context) {
    PageMemory = 8;
    // print(widget.data?.UPDATE);

    if (widget.data?.UPDATE == 'OK') {
      setState(() {
        APPGAS12var.PO = widget.data?.PO ?? '';
        APPGAS12var.CP = widget.data?.CP ?? '';
        APPGAS12var.QTY = widget.data?.QTY ?? '';
        APPGAS12var.PROCESS = widget.data?.PROCESS ?? '';
        APPGAS12var.CUSLOT = widget.data?.CUSLOT ?? '';
        APPGAS12var.TPKLOT = widget.data?.TPKLOT ?? '';
        APPGAS12var.FG = widget.data?.FG ?? '';
        APPGAS12var.CUSTOMER = widget.data?.CUSTOMER ?? '';
        APPGAS12var.PART = widget.data?.PART ?? '';
        APPGAS12var.PARTNAME = widget.data?.PARTNAME ?? '';
        APPGAS12var.MATERIAL = widget.data?.MATERIAL ?? '';
        //
        APPGAS12var.ItemPick = widget.data?.ItemPick ?? [''];
        APPGAS12var.PCS = widget.data?.PCS ?? '';
        // APPGAS12var.PCS = '10';
        APPGAS12var.PCSleft = widget.data?.PCSleft ?? '';
        // APPGAS12var.PCSleft = '10';
        APPGAS12var.POINTs = widget.data?.POINTs ?? '';
        // APPGAS12var.POINTs = '10';
        // if (APPGAS12var.ItemPickSELECT != "") {
        //   //
        //   if (APPGAS12var.POINTs == "") {
        //     //
        //     APPGAS12var.POINTs == "0";
        //   }
        // }
        APPGAS12var.UNIT = widget.data?.UNIT ?? '';
        // APPGAS12var.UNIT = 'pcs/lots';
        APPGAS12var.INTERSEC = widget.data?.INTERSEC ?? '';
        //
        APPGAS12var.RESULTFORMAT = widget.data?.RESULTFORMAT ?? '';
        APPGAS12var.GRAPHTYPE = widget.data?.GRAPHTYPE ?? '';
        APPGAS12var.GAP = widget.data?.GAP ?? '';
        //
        APPGAS12var.preview = widget.data?.preview ?? [];
        APPGAS12var.confirmdata = widget.data?.confirmdata ?? [];
        APPGAS12var.ITEMleftUNIT = widget.data?.ITEMleftUNIT ?? [];
        APPGAS12var.ITEMleftVALUE = widget.data?.ITEMleftVALUE ?? [];

        APPGAS12var.PICs = widget.data?.Pic ?? '';

        if (APPGAS12var.PCSleft == '0') {
          BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
              "ITEM STATUS", "COMPLETE DATA", enumNotificationlist.Success);
        }

        widget.data?.UPDATE = '-';
      });

      // if (widget.trick == 'OK' &&
      //     APPGAS12var.PCSleft != '0' &&
      //     APPGAS12var.PCS != '' &&
      //     APPGAS12var.PCSleft != '' &&
      //     (int.parse(APPGAS12var.PCSleft) < int.parse(APPGAS12var.PCS))) {
      //   widget.trick = '';
      //   context.read<TRICKER_APPGAS12_Bloc>().add(TRICKER_APPGAS12FINISH());
      // }

      Timer timer = Timer(const Duration(seconds: 1), () {
        context.read<APPGAS12_Bloc>().add(APPGAS12_READ());
      });
      APPGAS12var.DHtimer = timer;
    }
    return SINGLESHOTAPRmain(
      //------ Left
      LABEL: "APP-INSHES",
      PO: APPGAS12var.PO,
      CP: APPGAS12var.CP,
      QTY: APPGAS12var.QTY,
      PROCESS: APPGAS12var.PROCESS,
      CUSLOT: APPGAS12var.CUSLOT,
      TPKLOT: APPGAS12var.TPKLOT,
      FG: APPGAS12var.FG,
      CUSTOMER: APPGAS12var.CUSTOMER,
      PART: APPGAS12var.PART,
      PARTNAME: APPGAS12var.PARTNAME,
      MATERIAL: APPGAS12var.MATERIAL,
      //------- Top
      ItemPickres: (v) {
        print(v);
        APPGAS12var.ItemPickSELECT = v;

        context
            .read<TRICKER_APPGAS12_Bloc>()
            .add(TRICKER_APPGAS12geteachITEM());
      },
      ItemPick: APPGAS12var.ItemPick,
      PCS: APPGAS12var.PCS,
      PCSleft: APPGAS12var.PCSleft,
      POINTs: APPGAS12var.POINTs,
      UNIT: APPGAS12var.UNIT,
      INTERSEC: APPGAS12var.INTERSEC,
      RESULTFORMAT: APPGAS12var.RESULTFORMAT,
      Ghtype: APPGAS12var.GRAPHTYPE,
      //------- Bottom
      GOOD: (v) {
        if (APPGAS12var.PCS != '') {
          APPGAS12var.APPEARANCE = 'Good';
          if (APPGAS12var.PCS != '' &&
              APPGAS12var.POINTs != '' &&
              APPGAS12var.ItemPickSELECT != '') {
            if (int.parse(APPGAS12var.PCSleft) > 0) {
              onLoadingFAKE(context);
              context
                  .read<TRICKER_APPGAS12_Bloc>()
                  .add(TRICKER_APPGAS12FINISH());
            }
          } else {
            WORNINGpop(context, "Please select item");
          }
        }
      },
      NOGOOD: (v) {
        if (APPGAS12var.PCS != '') {
          if (APPGAS12var.PCS != '' &&
              APPGAS12var.POINTs != '' &&
              APPGAS12var.ItemPickSELECT != '') {
            if (int.parse(APPGAS12var.PCSleft) > 0) {
              APPGAS12var.APPEARANCE = 'no Good';
            }
          } else {
            WORNINGpop(context, "Please select item");
          }
        }
      },
      preview: APPGAS12var.preview,
      confirmdata: APPGAS12var.confirmdata.reversed.toList(),
      //------- Right
      CLEAR: (v) {
        context.read<TRICKER_APPGAS12_Bloc>().add(TRICKER_APPGAS12CLEAR());
      },
      BACKPAGE: (v) {
        APPGAS12var.DHtimer.cancel();
        FIRSTUI.SEARCH = FIRSTUI.POACTIVE;
        APPGAS12var.ItemPickSELECT = '';
        context.read<TRICKER_APPGAS12_Bloc>().add(TRICKER_APPGAS12SETZERO());
        CuPage = Page1();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
      },
      RESETVALUE: (v) {
        context.read<TRICKER_APPGAS12_Bloc>().add(TRICKER_APPGAS12RESETVALUE());
      },
      ITEMleftUNIT: APPGAS12var.ITEMleftUNIT,
      ITEMleftVALUE: APPGAS12var.ITEMleftVALUE,
      PICB64: APPGAS12var.PICs,
    );
  }
}
