import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/BlocEvent/07-01-GASMCS002.dart';
import '../../bloc/BlocEvent/07-02-TrickGASMCS002.dart';
import '../../bloc/BlocEvent/ChangePageEvent.dart';
import '../../bloc/cubit/NotificationEvent.dart';
import '../../data/global.dart';
import '../../mainBody.dart';
import '../../widget/QCWIDGET/W1SINGLESHOT/SINGLESHOTwidget.dart';
import '../../widget/QCWIDGET/W1SINGLESHOTIMG/SINGLESHOTIMGwidget.dart';
import '../../widget/common/ComInputText.dart';
import '../../widget/common/Loading.dart';
import '../../widget/common/imgset.dart';
import '../../widget/onlyINqcui/popup.dart';
import '../P1FIRSTUI/FIRSTuiVAR.dart';
import '../page1.dart';
import 'GASMCS002var.dart';

late BuildContext MICROSCOPEGASMCS002_CONTEXT;

class MICROSCOPE_GASMCS002main extends StatelessWidget {
  MICROSCOPE_GASMCS002main({Key? key, this.data}) : super(key: key);
  GASMCS002SCHEMA? data;
  @override
  Widget build(BuildContext context) {
    return _TRICKER_GASMCS002_BlocBuffer(
      data: data,
    );
  }
}

class _TRICKER_GASMCS002_BlocBuffer extends StatelessWidget {
  _TRICKER_GASMCS002_BlocBuffer({
    Key? key,
    this.data,
  }) : super(key: key);
  GASMCS002SCHEMA? data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TRICKER_GASMCS002_Bloc(),
        child: BlocBuilder<TRICKER_GASMCS002_Bloc, String>(
          builder: (context, trick) {
            return ROCKWELL_GASMCS002body(data: data);
          },
        ));
  }
}

class ROCKWELL_GASMCS002body extends StatefulWidget {
  ROCKWELL_GASMCS002body({Key? key, this.data}) : super(key: key);
  GASMCS002SCHEMA? data;

  @override
  State<ROCKWELL_GASMCS002body> createState() => _ROCKWELL_GASMCS002bodyState();
}

class _ROCKWELL_GASMCS002bodyState extends State<ROCKWELL_GASMCS002body> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    context.read<GASMCS002_Bloc>().add(GASMCS002_READ());
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
    GASMCS002var.base64pic01 = imgw;
    GASMCS002var.base64pic02 = imgw;
    GASMCS002var.base64pic03 = imgw;
    GASMCS002var.base64pic04 = imgw;
    GASMCS002var.base64pic01data = '';
    GASMCS002var.base64pic02data = '';
    GASMCS002var.base64pic03data = '';
    GASMCS002var.base64pic04data = '';
    // GASMCS002var.DHtimer.cancel();
    FIRSTUI.SEARCH = FIRSTUI.POACTIVE;
    GASMCS002var.ItemPickSELECT = '';
    context.read<TRICKER_GASMCS002_Bloc>().add(TRICKER_GASMCS002SETZERO());
    CuPage = Page1();
    MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
  }

  @override
  Widget build(BuildContext context) {
    PageMemory = 6;

    MICROSCOPEGASMCS002_CONTEXT = context;

    if (widget.data?.UPDATE == 'OK') {
      setState(() {
        GASMCS002var.PO = widget.data?.PO ?? '';
        GASMCS002var.CP = widget.data?.CP ?? '';
        GASMCS002var.QTY = widget.data?.QTY ?? '';
        GASMCS002var.PROCESS = widget.data?.PROCESS ?? '';
        GASMCS002var.CUSLOT = widget.data?.CUSLOT ?? '';
        GASMCS002var.TPKLOT = widget.data?.TPKLOT ?? '';
        GASMCS002var.FG = widget.data?.FG ?? '';
        GASMCS002var.CUSTOMER = widget.data?.CUSTOMER ?? '';
        GASMCS002var.PART = widget.data?.PART ?? '';
        GASMCS002var.PARTNAME = widget.data?.PARTNAME ?? '';
        GASMCS002var.MATERIAL = widget.data?.MATERIAL ?? '';
        //
        GASMCS002var.ItemPick = widget.data?.ItemPick ?? [''];
        GASMCS002var.PCS = widget.data?.PCS ?? '';
        // GASMCS002var.PCS = '10';
        GASMCS002var.PCSleft = widget.data?.PCSleft ?? '';
        // GASMCS002var.PCSleft = '10';
        GASMCS002var.POINTs = widget.data?.POINTs ?? '';
        // GASMCS002var.POINTs = '10';
        GASMCS002var.UNIT = widget.data?.UNIT ?? '';
        // GASMCS002var.UNIT = 'pcs/lots';
        GASMCS002var.INTERSEC = widget.data?.INTERSEC ?? '';
        //
        GASMCS002var.RESULTFORMAT = widget.data?.RESULTFORMAT ?? '';
        GASMCS002var.GRAPHTYPE = widget.data?.GRAPHTYPE ?? '';
        GASMCS002var.GAP = widget.data?.GAP ?? '';
        //
        GASMCS002var.preview = widget.data?.preview ?? [];
        GASMCS002var.confirmdata = widget.data?.confirmdata ?? [];
        GASMCS002var.ITEMleftUNIT = widget.data?.ITEMleftUNIT ?? [];
        GASMCS002var.ITEMleftVALUE = widget.data?.ITEMleftVALUE ?? [];

        if (GASMCS002var.PCSleft == '0') {
          BlocProvider.of<BlocNotification>(contextGB).UpdateNotification(
              "ITEM STATUS", "COMPLETE DATA", enumNotificationlist.Success);
        }

        widget.data?.UPDATE = '-';
      });

      // Timer timer = Timer(const Duration(seconds: 1), () {
      //   context.read<GASMCS002_Bloc>().add(GASMCS002_READ());
      // });
      // GASMCS002var.DHtimer = timer;
    }

    return SINGLESHOTIMGmain(
      //------ Left
      LABEL: "GAS-MCS-002",
      PO: GASMCS002var.PO,
      CP: GASMCS002var.CP,
      QTY: GASMCS002var.QTY,
      PROCESS: GASMCS002var.PROCESS,
      CUSLOT: GASMCS002var.CUSLOT,
      TPKLOT: GASMCS002var.TPKLOT,
      FG: GASMCS002var.FG,
      CUSTOMER: GASMCS002var.CUSTOMER,
      PART: GASMCS002var.PART,
      PARTNAME: GASMCS002var.PARTNAME,
      MATERIAL: GASMCS002var.MATERIAL,
      //------- Top
      ItemPickres: (v) {
        print(v);

        GASMCS002var.ItemPickSELECT = v;
        //----

        context
            .read<TRICKER_GASMCS002_Bloc>()
            .add(TRICKER_GASMCS002geteachITEM());
        GASMCS002var.base64pic01 = imgw;
        GASMCS002var.base64pic02 = imgw;
        GASMCS002var.base64pic03 = imgw;
        GASMCS002var.base64pic04 = imgw;
        GASMCS002var.iscontrol = true;
        GASMCS002var.base64pic01data = '';
        GASMCS002var.base64pic02data = '';
        GASMCS002var.base64pic03data = '';
        GASMCS002var.base64pic04data = '';
        context.read<GASMCS002_Bloc>().add(GASMCS002_READ());
      },
      ItemPick: GASMCS002var.ItemPick,
      PCS: GASMCS002var.PCS,
      PCSleft: GASMCS002var.PCSleft,
      POINTs: GASMCS002var.POINTs,
      UNIT: GASMCS002var.UNIT,
      INTERSEC: GASMCS002var.INTERSEC,
      RESULTFORMAT: GASMCS002var.RESULTFORMAT,
      Ghtype: GASMCS002var.GRAPHTYPE,

      //------- Bottom
      ACCEPT: (v) {
        // print(checkpic());
        if (checkpic()) {
          // if (pointpic()) {
          if (GASMCS002var.PCS != '' &&
              GASMCS002var.POINTs != '' &&
              GASMCS002var.ItemPickSELECT != '') {
            onLoadingFAKEintTIME(context, 3);
            if (int.parse(GASMCS002var.PCSleft) > 0) {
              context
                  .read<TRICKER_GASMCS002_Bloc>()
                  .add(TRICKER_GASMCS002FINISH());
              Timer(const Duration(seconds: 3), () {
                context.read<GASMCS002_Bloc>().add(GASMCS002_READ());
              });
            }
          } else {
            WORNINGpop(context, "Please select item");
          }
          // } else {
          //   WORNINGpop(context, "Please insert data");
          // }
        } else {
          WORNINGpop(context, "Please upload picture for Compound Layer");
        }
      },
      //-------------
      INSdd: (v, s) {
        GASMCS002var.selectINS = v;
      },
      INSddData: GASMCS002var.selectINS,
      PRread: (v) {
        if (GASMCS002var.ItemPickSELECT.contains("Compound")) {
          GASMCS002var.iscontrol = true;
          context.read<TRICKER_GASMCS002_Bloc>().add(TRICKER_GASMCS002getCP());
        } else if (GASMCS002var.ItemPickSELECT.contains("Porous")) {
          WORNINGpop(context, "ITEM Porous");
        } else {
          GASMCS002var.iscontrol = true;
          context.read<TRICKER_GASMCS002_Bloc>().add(TRICKER_GASMCS002getCP());
        }
      },
      CPreadbool: GASMCS002var.ItemPickSELECT.contains("Compound") ||
          !(GASMCS002var.ItemPickSELECT.contains("Compound") &&
              GASMCS002var.ItemPickSELECT.contains("Porous")),
      CPread: (v) {
        if (GASMCS002var.ItemPickSELECT.contains("Porous")) {
          GASMCS002var.iscontrol = true;
          context.read<TRICKER_GASMCS002_Bloc>().add(TRICKER_GASMCS002getPR());
        } else if (GASMCS002var.ItemPickSELECT.contains("Compound")) {
          //Porous
          WORNINGpop(context, "ITEM Compound");
        } else {
          GASMCS002var.iscontrol = true;
          context.read<TRICKER_GASMCS002_Bloc>().add(TRICKER_GASMCS002getPR());
        }
      },
      PRreadbool: GASMCS002var.ItemPickSELECT.contains("Porous") ||
          !(GASMCS002var.ItemPickSELECT.contains("Compound") &&
              GASMCS002var.ItemPickSELECT.contains("Porous")),
      //-------------
      FINISH: (v) {},
      preview: GASMCS002var.preview,
      confirmdata: GASMCS002var.confirmdata.reversed.toList(),
      //------- Right
      CLEAR: (v) {},
      BACKPAGE: (v) {
        GASMCS002var.base64pic01 = imgw;
        GASMCS002var.base64pic02 = imgw;
        GASMCS002var.base64pic03 = imgw;
        GASMCS002var.base64pic04 = imgw;
        GASMCS002var.base64pic01data = '';
        GASMCS002var.base64pic02data = '';
        GASMCS002var.base64pic03data = '';
        GASMCS002var.base64pic04data = '';
        // GASMCS002var.DHtimer.cancel();
        FIRSTUI.SEARCH = FIRSTUI.POACTIVE;
        GASMCS002var.ItemPickSELECT = '';
        context.read<TRICKER_GASMCS002_Bloc>().add(TRICKER_GASMCS002SETZERO());
        CuPage = Page1();
        MainBodyContext.read<ChangePage_Bloc>().add(ChangePage_nodrower());
      },
      RESETVALUE: (v) {},
      ITEMleftUNIT: GASMCS002var.ITEMleftUNIT,
      ITEMleftVALUE: GASMCS002var.ITEMleftVALUE,
      wchild: Column(
        children: [
          FileUploadButton01(),
          FileUploadButton02(),
          FileUploadButton03(),
          FileUploadButton04(),
        ],
      ),
    );
  }
}

class FileUploadButton01 extends StatefulWidget {
  const FileUploadButton01({Key? key}) : super(key: key);

  @override
  State<FileUploadButton01> createState() => _FileUploadButton01State();
}

class _FileUploadButton01State extends State<FileUploadButton01> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 1000,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ComInputText(
            sLabel: "value",
            height: 40,
            // isEnabled: false,
            isContr: GASMCS002var.iscontrol,
            fnContr: (input) {
              setState(() {
                GASMCS002var.iscontrol = input;
              });
            },
            sValue: GASMCS002var.base64pic01data,
            returnfunc: (String s) {
              GASMCS002var.base64pic01data = s;
            },
          ),
          PicShow(
            width: 200,
            height: 100,
            base64: GASMCS002var.base64pic01,
          ),
          IMGbutton(
            base64pic: GASMCS002var.base64pic01,
            setimg: (img) {
              GASMCS002var.base64pic01 = img;
              context.read<GASMCS002_Bloc>().add(GASMCS002_READ());
            },
          ),
        ],
      ),
    );
  }
}

class FileUploadButton02 extends StatefulWidget {
  const FileUploadButton02({Key? key}) : super(key: key);

  @override
  State<FileUploadButton02> createState() => _FileUploadButton02State();
}

class _FileUploadButton02State extends State<FileUploadButton02> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 1000,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ComInputText(
            sLabel: "value",
            height: 40,
            // isEnabled: false,
            isContr: GASMCS002var.iscontrol,
            fnContr: (input) {
              setState(() {
                GASMCS002var.iscontrol = input;
              });
            },
            sValue: GASMCS002var.base64pic02data,
            returnfunc: (String s) {
              GASMCS002var.base64pic02data = s;
            },
          ),
          PicShow(
            width: 200,
            height: 100,
            base64: GASMCS002var.base64pic02,
          ),
          IMGbutton(
            base64pic: GASMCS002var.base64pic02,
            setimg: (img) {
              GASMCS002var.base64pic02 = img;
              context.read<GASMCS002_Bloc>().add(GASMCS002_READ());
            },
          ),
        ],
      ),
    );
  }
}

class FileUploadButton03 extends StatefulWidget {
  const FileUploadButton03({Key? key}) : super(key: key);

  @override
  State<FileUploadButton03> createState() => _FileUploadButton03State();
}

class _FileUploadButton03State extends State<FileUploadButton03> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 1000,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ComInputText(
            sLabel: "value",
            height: 40,
            // isEnabled: false,
            isContr: GASMCS002var.iscontrol,
            fnContr: (input) {
              setState(() {
                GASMCS002var.iscontrol = input;
              });
            },
            sValue: GASMCS002var.base64pic03data,
            returnfunc: (String s) {
              GASMCS002var.base64pic03data = s;
            },
          ),
          PicShow(
            width: 200,
            height: 100,
            base64: GASMCS002var.base64pic03,
          ),
          IMGbutton(
            base64pic: GASMCS002var.base64pic03,
            setimg: (img) {
              GASMCS002var.base64pic03 = img;
              context.read<GASMCS002_Bloc>().add(GASMCS002_READ());
            },
          ),
        ],
      ),
    );
  }
}

class FileUploadButton04 extends StatefulWidget {
  const FileUploadButton04({Key? key}) : super(key: key);

  @override
  State<FileUploadButton04> createState() => _FileUploadButton04State();
}

class _FileUploadButton04State extends State<FileUploadButton04> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 1000,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ComInputText(
            sLabel: "value",
            height: 40,
            // isEnabled: false,
            isContr: GASMCS002var.iscontrol,
            fnContr: (input) {
              setState(() {
                GASMCS002var.iscontrol = input;
              });
            },
            sValue: GASMCS002var.base64pic04data,
            returnfunc: (String s) {
              GASMCS002var.base64pic04data = s;
            },
          ),
          PicShow(
            width: 200,
            height: 100,
            base64: GASMCS002var.base64pic04,
          ),
          IMGbutton(
            base64pic: GASMCS002var.base64pic04,
            setimg: (img) {
              GASMCS002var.base64pic04 = img;
              context.read<GASMCS002_Bloc>().add(GASMCS002_READ());
            },
          ),
        ],
      ),
    );
  }
}

bool pointpic() {
  bool out = false;
  if (GASMCS002var.POINTs == '1') {
    if (GASMCS002var.base64pic01data != '' &&
        (GASMCS002var.base64pic02data == '' ||
            GASMCS002var.base64pic02data == '0') &&
        (GASMCS002var.base64pic03data == '' ||
            GASMCS002var.base64pic03data == '0') &&
        (GASMCS002var.base64pic04data == '' ||
            GASMCS002var.base64pic04data == '0')) {
      out = true;
    }
  } else if (GASMCS002var.POINTs == '2') {
    if (GASMCS002var.base64pic01data != '' &&
        GASMCS002var.base64pic02data != '' &&
        (GASMCS002var.base64pic03data == '' ||
            GASMCS002var.base64pic03data == '0') &&
        (GASMCS002var.base64pic04data == '' ||
            GASMCS002var.base64pic04data == '0')) {
      out = true;
    }
  } else if (GASMCS002var.POINTs == '3') {
    if (GASMCS002var.base64pic01data != '' &&
        GASMCS002var.base64pic02data != '' &&
        GASMCS002var.base64pic03data != '' &&
        (GASMCS002var.base64pic04data == '' ||
            GASMCS002var.base64pic04data == '0')) {
      out = true;
    }
  } else if (GASMCS002var.POINTs == '4') {
    if (GASMCS002var.base64pic01data != '' &&
        GASMCS002var.base64pic02data != '' &&
        GASMCS002var.base64pic03data != '' &&
        GASMCS002var.base64pic04data != '') {
      out = true;
    }
  }

  return out;
}

bool checkpic() {
  bool out = false;
  if (GASMCS002var.ItemPickSELECT == 'Compound Layer') {
    if (GASMCS002var.base64pic01 != imgw) {
      out = true;
    }
  } else {
    out = true;
  }
  return out;
}
