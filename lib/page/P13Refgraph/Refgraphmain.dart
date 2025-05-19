import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/BlocEvent/13-01-Refgraph.dart';
import '../../bloc/BlocEvent/13-02-TrickRefgraph.dart';
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
import 'Refgraphvar.dart';

class MICROVICKER_Refgraphmain extends StatelessWidget {
  MICROVICKER_Refgraphmain({Key? key, this.data}) : super(key: key);
  RefgraphSCHEMA? data;
  @override
  Widget build(BuildContext context) {
    return _TRICKER_Refgraph_BlocBuffer(
      data: data,
    );
  }
}

class _TRICKER_Refgraph_BlocBuffer extends StatelessWidget {
  _TRICKER_Refgraph_BlocBuffer({
    Key? key,
    this.data,
  }) : super(key: key);
  RefgraphSCHEMA? data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TRICKER_Refgraph_Bloc(),
        child: BlocBuilder<TRICKER_Refgraph_Bloc, String>(
          builder: (context, trick) {
            return ROCKWELL_Refgraphbody(data: data);
          },
        ));
  }
}

class ROCKWELL_Refgraphbody extends StatefulWidget {
  ROCKWELL_Refgraphbody({Key? key, this.data}) : super(key: key);
  RefgraphSCHEMA? data;

  @override
  State<ROCKWELL_Refgraphbody> createState() => _ROCKWELL_RefgraphbodyState();
}

class _ROCKWELL_RefgraphbodyState extends State<ROCKWELL_Refgraphbody> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    context.read<Refgraph_Bloc>().add(Refgraph_READ());
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
    Refgraphvar.DHtimer.cancel();
    FIRSTUI.SEARCH = FIRSTUI.POACTIVE;
    Refgraphvar.ItemPickSELECT = '';
    context.read<TRICKER_Refgraph_Bloc>().add(TRICKER_RefgraphSETZERO());
    CuPage = Page1();
    MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
  }

  @override
  Widget build(BuildContext context) {
    PageMemory = 5;
    if (widget.data?.UPDATE == 'OK') {
      setState(() {
        Refgraphvar.PO = widget.data?.PO ?? '';
        Refgraphvar.CP = widget.data?.CP ?? '';
        Refgraphvar.QTY = widget.data?.QTY ?? '';
        Refgraphvar.PROCESS = widget.data?.PROCESS ?? '';
        Refgraphvar.CUSLOT = widget.data?.CUSLOT ?? '';
        Refgraphvar.TPKLOT = widget.data?.TPKLOT ?? '';
        Refgraphvar.FG = widget.data?.FG ?? '';
        Refgraphvar.CUSTOMER = widget.data?.CUSTOMER ?? '';
        Refgraphvar.PART = widget.data?.PART ?? '';
        Refgraphvar.PARTNAME = widget.data?.PARTNAME ?? '';
        Refgraphvar.MATERIAL = widget.data?.MATERIAL ?? '';
        //
        Refgraphvar.ItemPick = widget.data?.ItemPick ?? [''];
        Refgraphvar.PCS = widget.data?.PCS ?? '';
        // Refgraphvar.PCS = '10';
        Refgraphvar.PCSleft = widget.data?.PCSleft ?? '';
        // Refgraphvar.PCSleft = '10';
        Refgraphvar.POINTs = widget.data?.POINTs ?? '';
        // Refgraphvar.POINTs = '10';
        // if (Refgraphvar.ItemPickSELECT != "") {
        //   //
        //   if (Refgraphvar.POINTs == "") {
        //     //
        //     Refgraphvar.POINTs == "0";
        //   }
        // }
        Refgraphvar.UNIT = widget.data?.UNIT ?? '';
        // Refgraphvar.UNIT = 'pcs/lots';
        Refgraphvar.INTERSEC = widget.data?.INTERSEC ?? '';
        //
        Refgraphvar.RESULTFORMAT = widget.data?.RESULTFORMAT ?? '';
        Refgraphvar.GRAPHTYPE = widget.data?.GRAPHTYPE ?? '';
        Refgraphvar.GAP = widget.data?.GAP ?? '';
        Refgraphvar.GAPnameList = widget.data?.GAPnameList ?? [''];
        //
        Refgraphvar.preview = widget.data?.preview ?? [];
        Refgraphvar.confirmdata = widget.data?.confirmdata ?? [];
        Refgraphvar.ITEMleftUNIT = widget.data?.ITEMleftUNIT ?? [];
        Refgraphvar.ITEMleftVALUE = widget.data?.ITEMleftVALUE ?? [];

        Refgraphvar.PICs = widget.data?.Pic ?? '';

        if (Refgraphvar.PCSleft == '0') {
          BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
              "ITEM STATUS", "COMPLETE DATA", enumNotificationlist.Success);
        }

        widget.data?.UPDATE = '-';
      });

      Timer timer = Timer(const Duration(seconds: 1), () {
        context.read<Refgraph_Bloc>().add(Refgraph_READ());
      });
      Refgraphvar.DHtimer = timer;
    }
    return SINGLESHOTHGmain(
      //------ Left
      LABEL: "Ref-graph",
      PO: Refgraphvar.PO,
      CP: Refgraphvar.CP,
      QTY: Refgraphvar.QTY,
      PROCESS: Refgraphvar.PROCESS,
      CUSLOT: Refgraphvar.CUSLOT,
      TPKLOT: Refgraphvar.TPKLOT,
      FG: Refgraphvar.FG,
      CUSTOMER: Refgraphvar.CUSTOMER,
      PART: Refgraphvar.PART,
      PARTNAME: Refgraphvar.PARTNAME,
      MATERIAL: Refgraphvar.MATERIAL,
      //------- Top
      ItemPickres: (v) {
        print(v);
        Refgraphvar.ItemPickSELECT = v;
        //
        context
            .read<TRICKER_Refgraph_Bloc>()
            .add(TRICKER_RefgraphgeteachITEM());
      },
      ItemPick: Refgraphvar.ItemPick,
      PCS: Refgraphvar.PCS,
      PCSleft: Refgraphvar.PCSleft,
      POINTs: Refgraphvar.POINTs,
      UNIT: Refgraphvar.UNIT,
      INTERSEC: Refgraphvar.INTERSEC,
      RESULTFORMAT: Refgraphvar.RESULTFORMAT,
      Ghtype: Refgraphvar.GRAPHTYPE,
      GAP: Refgraphvar.GAP,
      GAPnameList: Refgraphvar.GAPnameList,
      GAPname: Refgraphvar.GAPname,
      GAPnamePick: (v) {
        Refgraphvar.GAPname = v;
        context
            .read<TRICKER_Refgraph_Bloc>()
            .add(TRICKER_RefgraphgeteachGRAPH());
      },
      //------- Bottom
      dropdown: SizedBox(
        height: 40,
        width: 400,
        child: AdvanceDropDown(
          imgpath: 'assets/icons/icon-down_4@3x.png',
          listdropdown: const [
            MapEntry("", ""),
            MapEntry("GAS-HMV-001", "GAS-HMV-001"),
            MapEntry("GAS-HMV-002", "GAS-HMV-002"),
            MapEntry("GAS-HMV-003", "GAS-HMV-003"),
          ],
          onChangeinside: (d, v) {
            setState(() {
              Refgraphvar.dropdown = d;
            });
          },
          value: Refgraphvar.dropdown,
          height: 40,
          width: 400,
        ),
      ),
      GET: (v) {
        print(Refgraphvar.PO);
        print(Refgraphvar.ItemPickSELECT);
        print((Refgraphvar.ItemPickSELECT).contains("0.15") ? "2" : "0");

        Dio().post(
          GLOserver + 'GETHMVATPOINT',
          data: {
            "PO": Refgraphvar.PO,
            "NAME_INS": Refgraphvar.dropdown,
            "POINT": (Refgraphvar.ItemPickSELECT).contains("0.15") ? "2" : "0"
          },
        );
      },
      ACCEPT: (v) {
        if ((Refgraphvar.RESULTFORMAT == 'Graph' &&
                Refgraphvar.GAPname != '') ||
            Refgraphvar.RESULTFORMAT != 'Graph') {
          if (Refgraphvar.PCS != '' &&
              Refgraphvar.POINTs != '' &&
              Refgraphvar.ItemPickSELECT != '') {
            if (int.parse(Refgraphvar.POINTs) >
                Refgraphvar.confirmdata.length) {
              context
                  .read<TRICKER_Refgraph_Bloc>()
                  .add(TRICKER_Refgraphconfirmdata());
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
        if (Refgraphvar.PCS != '' &&
            Refgraphvar.POINTs != '' &&
            Refgraphvar.ItemPickSELECT != '') {
          if (int.parse(Refgraphvar.POINTs) == Refgraphvar.confirmdata.length) {
            if (int.parse(Refgraphvar.PCSleft) > 0) {
              onLoadingFAKE(context);
              context
                  .read<TRICKER_Refgraph_Bloc>()
                  .add(TRICKER_RefgraphFINISH());
            }
          } else {
            WORNINGpop(context, "POINTs are not complete");
          }
        } else {
          WORNINGpop(context, "Please select item");
        }
      },
      preview: Refgraphvar.preview,
      confirmdata: Refgraphvar.confirmdata.reversed.toList(),
      //------- Right
      CLEAR: (v) {
        context.read<TRICKER_Refgraph_Bloc>().add(TRICKER_RefgraphCLEAR());
      },
      BACKPAGE: (v) {
        Refgraphvar.DHtimer.cancel();
        FIRSTUI.SEARCH = FIRSTUI.POACTIVE;
        Refgraphvar.ItemPickSELECT = '';
        context.read<TRICKER_Refgraph_Bloc>().add(TRICKER_RefgraphSETZERO());
        CuPage = Page1();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
      },
      RESETVALUE: (v) {
        context.read<TRICKER_Refgraph_Bloc>().add(TRICKER_RefgraphRESETVALUE());
      },
      ITEMleftUNIT: Refgraphvar.ITEMleftUNIT,
      ITEMleftVALUE: Refgraphvar.ITEMleftVALUE,
      PICB64: Refgraphvar.PICs,
    );
  }
}
