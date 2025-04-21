import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../Layout/head.dart';

import '../../bloc/Cubit/31-ReportPDFCommoncubit.dart';
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
import '../page303.dart';
import '../page31.dart';
import '../page32.dart';
import '../page33.dart';
import '../page34.dart';
import '../page35.dart';
import 'P30SELECTReportvar.dart';

late BuildContext SELECTReportcontext;

class SELECTReport extends StatefulWidget {
  SELECTReport({
    Key? key,
    this.dataCommon,
  }) : super(key: key);
  CommonReportOutput? dataCommon;
  @override
  State<SELECTReport> createState() => _SELECTReportState();
}

class _SELECTReportState extends State<SELECTReport> {
  @override
  void initState() {
    SELECTReportvar.TPKLOTEDIT = '';
    if (SELECTReportvar.PO != '') {
      SELECTReportvar.canf = false;
      context
          .read<ReportPDFCommon_Cubit>()
          .ReportPDFCommonCubit(SELECTReportvar.PO);
    }
    super.initState();
  }

  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SELECTReportcontext = context;
    CommonReportOutput _dataCommon = widget.dataCommon ??
        CommonReportOutput(
          databasic: BasicCommonDATA(),
        );
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
    } else {
      return Page31();
    }
  }
}
