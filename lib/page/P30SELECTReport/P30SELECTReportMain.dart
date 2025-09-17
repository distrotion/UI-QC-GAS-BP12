import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../Layout/head.dart';

import '../../bloc/Cubit/31-ReportPDFCommoncubit.dart';
import '../../bloc/Cubit/32-Reportset.dart';
import '../../data/CommonTestData.dart';
import '../../data/global.dart';
import '../../widget/GRAPH/LineGraph01.dart';
import '../../widget/ReportComponent/CommonReport.dart';
import '../../widget/ReportComponent/PicSlot.dart';
import '../../widget/ReportComponent/SignSide.dart';
import '../../widget/common/Advancedropdown.dart';
import '../../widget/common/ComInputText.dart';
import '../../widget/common/ErrorPopup.dart';
import '../../widget/common/Error_NO_Popup.dart';
import '../../widget/common/Loading.dart';
import '../../widget/common/Safty.dart';
import '../../widget/common/imgset.dart';
import '../../widget/function/helper.dart';
import '../P303QMMASTERQC/P303QMMASTERQCVAR.dart';
import '../P31ReportPDFcommon/ReportPDFCommonMain.dart';
import '../P31ReportPDFcommon/ReportPDFCommonvar.dart';
import '../P36ReportPDFcov/ReportPDFcovvar.dart';
import '../P37ReportPDFASI/ReportPDFASIvar.dart';
import '../page303.dart';
import '../page31.dart';
import '../page32.dart';
import '../page33.dart';
import '../page34.dart';
import '../page35.dart';
import '../page36.dart';
import '../page37.dart';
import '../page40.dart';
import '../page50.dart';
import 'P30SELECTReportvar.dart';

late BuildContext SELECTReportcontext;

class SELECTReport extends StatefulWidget {
  SELECTReport({
    Key? key,
    this.dataCommon,
  }) : super(key: key);
  CommonReportSet? dataCommon;
  @override
  State<SELECTReport> createState() => _SELECTReportState();
}

class _SELECTReportState extends State<SELECTReport> {
  @override
  void initState() {
    SELECTReportvar.TPKLOTEDIT = '';
    if (SELECTReportvar.PO != '') {
      SELECTReportvar.canf = false;
      context.read<Reportset_Cubit>().ReportsetCubit(SELECTReportvar.PO, "");
    }
    super.initState();
  }

  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SELECTReportcontext = context;
    CommonReportSet _dataCommon = widget.dataCommon ??
        CommonReportSet(
          databasic: BasicCommonDATAset(),
        );
    //--------------------------------------

    //GAS12-2GP
    //GAS12-2GP-ABC
    //GAS12-3PIC
    //GAS12-3PIC-ABC
    //GAS12-3PIC-C

    //GAS12-STD
    //GAS12-STD_NoIC
    //GAS12-STD-C
    //GAS12-STD-C-NOPIC
    //GAS12-STD-N
    //GAS12-STD-N-NOPIC
    //GAS12-STD-NOPIC

    //GAS12-WM
    //GAS12-WM3

    // print(">>>>>>>>>>>>>>>>>-----+");
    // print(_dataCommon.databasic.reportset);
    // print(">>>>>>>>>>>>>>>>>-----+");ASI1-NOPIC

    if (_dataCommon.databasic.reportset != '') {
      if (_dataCommon.databasic.reportset == 'GAS12-2GP' ||
          _dataCommon.databasic.reportset == 'GAS12-2GP-ABC') {
        return Page33();
      } else if (_dataCommon.databasic.reportset == 'GAS12-3PIC' ||
          _dataCommon.databasic.reportset == 'GAS12-3PIC-ABC' ||
          _dataCommon.databasic.reportset == 'GAS12-3PIC-C') {
        return Page34();
      } else if (_dataCommon.databasic.reportset == 'GAS12-WM') {
        return Page32();
      } else if (_dataCommon.databasic.reportset == 'GAS12-WM3') {
        return Page35();
      } else if (_dataCommon.databasic.reportset == 'GAS12-STD-C-NOPIC') {
        ReportPDFcovvar.HIDEDATAPIC = true;
        return Page36();
      } else if (_dataCommon.databasic.reportset == 'GAS12-STD-C') {
        ReportPDFcovvar.HIDEDATAPIC = false;
        return Page36();
      } else if (_dataCommon.databasic.reportset == 'ASI1-NOPIC') {
        ReportPDFASIvar.HIDEDATAPIC = true;
        return Page37();
      } else if (_dataCommon.databasic.reportset == 'GAS12-STD' ||
          _dataCommon.databasic.reportset == 'GAS12-STD_NoIC' ||
          _dataCommon.databasic.reportset == 'GAS12-STD-C' ||
          _dataCommon.databasic.reportset == 'GAS12-STD-N') {
        ReportPDFCommonvar.HIDEDATAPIC = false;
        return Page31();
      }
      if (_dataCommon.databasic.reportset == 'GAS12-STD-N-NOPIC' ||
          _dataCommon.databasic.reportset == 'GAS12-STD-NOPIC') {
        ReportPDFCommonvar.HIDEDATAPIC = true;
        return Page31();
      } else if (_dataCommon.databasic.reportset == 'REPORT4GP') {
        return Page40();
      } else if (_dataCommon.databasic.reportset == 'COMMON1') {
        return Page50();
      } else {
        return SizedBox(
          height: 75,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(width: 30),
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Loading"),
            ],
          ),
        );
      }
    } else {
      return SizedBox(
        height: 75,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(width: 30),
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text("Loading"),
          ],
        ),
      );
    }
  }
}
