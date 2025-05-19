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
import '../page303.dart';
import 'ReportPDFASIvar.dart';

late BuildContext ReportPDFASIcontext;

class ReportPDFASI extends StatefulWidget {
  ReportPDFASI({
    Key? key,
    this.dataCommon,
  }) : super(key: key);
  CommonReportOutput? dataCommon;
  @override
  State<ReportPDFASI> createState() => _ReportPDFASIState();
}

class _ReportPDFASIState extends State<ReportPDFASI> {
  @override
  void initState() {
    ReportPDFASIvar.TPKLOTEDIT = '';
    print("ma rel");
    if (ReportPDFASIvar.PO != '') {
      ReportPDFASIvar.canf = false;
      context
          .read<ReportPDFCommon_Cubit>()
          .ReportPDFCommonCubit(ReportPDFASIvar.PO, "covs");
    }
    super.initState();
  }

  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ReportPDFASIcontext = context;

    CommonReportOutput _dataCOMMON = widget.dataCommon ??
        CommonReportOutput(
          databasic: BasicCommonDATA(),
        );
    int HardnessNO = 1;
    int CoreNO = 1;
    int GraphNO = 1;
    int CompoundNO = 1;
    int RoughnessNO = 1;
    if (_dataCOMMON.datain.isNotEmpty) {
      //
      ReportPDFASIvar.STATUS = 'REPORT READY';
      ReportPDFASIvar.CUSTOMER = _dataCOMMON.databasic.CUSTOMER;
      ReportPDFASIvar.PROCESS = _dataCOMMON.databasic.PROCESS;
      ReportPDFASIvar.PARTNAME = _dataCOMMON.databasic.PARTNAME;
      ReportPDFASIvar.PARTNO = _dataCOMMON.databasic.PARTNO;
      ReportPDFASIvar.CUSLOT = _dataCOMMON.databasic.CUSLOT;
      ReportPDFASIvar.TPKLOT = _dataCOMMON.databasic.TPKLOT;
      ReportPDFASIvar.MATERIAL = _dataCOMMON.databasic.MATERIAL;
      if (_dataCOMMON.databasic.UNITSAP.toUpperCase() != 'KG') {
        ReportPDFASIvar.QTY =
            '${double.parse(ConverstStr(_dataCOMMON.databasic.QTY)).toStringAsFixed(0)} ${_dataCOMMON.databasic.UNITSAP}';
      } else {
        ReportPDFASIvar.QTY =
            '${double.parse(ConverstStr(_dataCOMMON.databasic.QTY)).toStringAsFixed(1)} ${_dataCOMMON.databasic.UNITSAP}';
      }

      ReportPDFASIvar.PIC01 = _dataCOMMON.databasic.PIC01;
      ReportPDFASIvar.PIC02 = _dataCOMMON.databasic.PIC02;
      ReportPDFASIvar.PICstd = _dataCOMMON.databasic.PICstd;

      ReportPDFASIvar.PASS = _dataCOMMON.databasic.PASS;
      ReportPDFASIvar.remark = '';
      if (_dataCOMMON.databasic.PARTNAMEref != '') {
        ReportPDFASIvar.remark =
            'Reference data from\n${_dataCOMMON.databasic.PARTNAMEref}\n${_dataCOMMON.databasic.PARTref}';
      }

      ReportPDFASIvar.INC01 = _dataCOMMON.databasic.INC01;
      ReportPDFASIvar.INC02 = _dataCOMMON.databasic.INC02;
//remark

      // print(_dataCOMMON.datain[0]);
      // print(_dataCOMMON.datain.length);
      ReportPDFASIvar.rawlistHardness = [];
      ReportPDFASIvar.rawlistCompound = [];
      ReportPDFASIvar.rawlistRoughness = [];
      ReportPDFASIvar.rawlistCORE = [];

      ReportPDFASIvar.graphupper = [];
      ReportPDFASIvar.graphdata = [];
      ReportPDFASIvar.graphdata2 = [];
      ReportPDFASIvar.graphdata3 = [];
      ReportPDFASIvar.graphdata4 = [];
      ReportPDFASIvar.graphunder = [];

      for (var i = 0; i < _dataCOMMON.datain.length; i++) {
        String Loadin = '';
        if (_dataCOMMON.datain[i].LOAD != '' &&
            _dataCOMMON.datain[i].LOAD != '-') {
          Loadin = "( Load ${_dataCOMMON.datain[i].LOAD} )";
        }
        ReportPDFASIvar.datalist[i].ITEMname =
            " ${_dataCOMMON.datain[i].ITEMname} ${Loadin}";
        ReportPDFASIvar.datalist[i].SCMARK = _dataCOMMON.datain[i].SCMARK;
        ReportPDFASIvar.datalist[i].METHODname =
            _dataCOMMON.datain[i].METHODname;
        ReportPDFASIvar.datalist[i].FREQ = _dataCOMMON.datain[i].FREQ;
        ReportPDFASIvar.datalist[i].SPECIFICATIONname =
            _dataCOMMON.datain[i].SPECIFICATION;
        ReportPDFASIvar.datalist[i].RESULT = _dataCOMMON.datain[i].RESULT;
        ReportPDFASIvar.datalist[i].REMARK = _dataCOMMON.datain[i].Remark;
        //print(ReportPDFASIvar.datalist[i].RESULT.length);
        //Surface Hardness

        if (_dataCOMMON.datain[i].TYPE == 'Number') {
          if (_dataCOMMON.datain[i].ITEMname
                  .toUpperCase()
                  .contains('HARDNESS') &&
              _dataCOMMON.datain[i].ITEMname.toUpperCase().contains('CORE') ==
                  false) {
            for (var li = 0;
                li < _dataCOMMON.datain[i].datapackset.length;
                li++) {
              // print(_dataCOMMON.datain[i].datapackset[li].dimensionX);

              if (_dataCOMMON.datain[i].datapackset[li].dimensionX == 0) {}
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 1) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '1',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA01,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA01c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 2) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '2',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA02,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA02c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 3) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '3',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA03,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA03c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 4) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '4',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA04,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA04c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 5) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '5',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA05,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA05c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 6) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '6',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA06,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA06c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 7) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '7',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA07,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA07c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 8) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '8',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA08,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA08c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 9) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '9',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA09,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA09c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 10) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '10',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA10,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA10c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 11) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '11',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA11,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA11c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 12) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '12',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA12,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA12c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 13) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '13',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA13,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA13c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 14) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '14',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA14,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA14c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 15) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '15',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA15,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA15c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 16) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '16',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA16,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA16c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 17) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '17',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA17,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA17c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 18) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '18',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA18,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA18c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 19) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '19',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA19,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA19c,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 20) {
                ReportPDFASIvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '20',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA20,
                  DATA2: _dataCOMMON.datain[i].datapackset[li].DATA20c,
                ));
              }
              HardnessNO++;
              // print('>>${HardnessNO}');
            }
          } else if (_dataCOMMON.datain[i].ITEMname
              .toUpperCase()
              .contains('CORE')) {
            for (var li = 0;
                li < _dataCOMMON.datain[i].datapackset.length;
                li++) {
              // print(_dataCOMMON.datain[i].datapackset[li].dimensionX);

              if (_dataCOMMON.datain[i].datapackset[li].dimensionX == 0) {}
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 1) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '1',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA01,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 2) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '2',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA02,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 3) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '3',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA03,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 4) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '4',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA04,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 5) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '5',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA05,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 6) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '6',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA06,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 7) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '7',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA07,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 8) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '8',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA08,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 9) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '9',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA09,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 10) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '10',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA10,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 11) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '11',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA11,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 12) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '12',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA12,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 13) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '13',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA13,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 14) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '14',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA14,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 15) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '15',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA15,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 16) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '16',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA16,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 17) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '17',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA17,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 18) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '18',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA18,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 19) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '19',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA19,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 20) {
                ReportPDFASIvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '20',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA20,
                ));
              }
              CoreNO++;
              // print('>>${CoreNO}');
            }
          }
          //  CoreNO++;
        }

        if (_dataCOMMON.datain[i].TYPE == 'Graph') {
          ReportPDFASIvar.rawlistGraph = [];
          if (_dataCOMMON.datain[i].ITEMname.contains('Hardness') ||
                  _dataCOMMON.datain[i].ITEMname.contains('hardness') ||
                  _dataCOMMON.datain[i].ITEMname.contains('Total') ||
                  _dataCOMMON.datain[i].ITEMname.contains('(Graph)')

              //
              ) {
            for (var li = 0;
                li < _dataCOMMON.datain[i].datapackset.length;
                li++) {
              // print(_dataCOMMON.datain[i].datapackset[li].dimensionX);

              if (_dataCOMMON.datain[i].datapackset[li].dimensionX == 0) {}
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 1) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA01p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA01,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA01p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA01))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 2) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA02p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA02,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA02p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA02))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 3) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA03p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA03,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA03p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA03))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 4) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA04p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA04,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA04p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA04))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 5) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA05p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA05,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA05p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA05))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 6) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA06p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA06,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA06p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA06))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 7) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA07p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA07,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA07p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA07))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 8) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA08p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA08,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA08p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA08))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 9) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA09p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA09,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA09p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA09))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 10) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA10p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA10,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA10p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA10))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 11) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA11p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA11,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA11p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA11))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 12) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA12p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA12,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA12p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA12))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 13) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA13p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA13,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA13p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA13))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 14) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA14p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA14,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA14p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA14))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 15) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA15p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA15,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA15p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA15))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 16) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA16p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA16,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA16p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA16))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 17) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA17p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA17,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA17p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA17))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 18) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA18p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA18,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA18p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA18))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 19) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA19p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA19,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA19p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA19))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 20) {
                ReportPDFASIvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA20p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA20,
                ));

                ReportPDFASIvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA20p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA20))),
                );
              }
              GraphNO++;
              // print('>>${HardnessNO}');
            }
          }

          // ReportPDFASIvar.rawlistGraphCore = rawlist(
          //   DATAPCS: "Core",
          //   DATA: ReportPDFASIvar
          //       .rawlistGraph[ReportPDFASIvar.rawlistGraph.length - 1].DATA,
          // );
          // print(">>>${ReportPDFASIvar.rawlistGraph.length}");
          // ReportPDFASIvar.rawlistGraph.removeLast();
          if (ReportPDFASIvar.rawlistGraph.length > 2) {
            ReportPDFASIvar.rawlistGraphCore = rawlist(
              DATAPCS: "Core",
              DATA: ReportPDFASIvar
                  .rawlistGraph[ReportPDFASIvar.rawlistGraph.length - 1].DATA,
            );
            // print(">>>${ReportPDFASIvar.rawlistGraph.length}");

            ReportPDFASIvar.rawlistGraph
                .removeAt(ReportPDFASIvar.rawlistGraph.length - 1);
          }

          ReportPDFASIvar.graphupper = [
            FlSpot(ReportPDFASIvar.graphdata[0].x, 1000),
            FlSpot(
                ReportPDFASIvar
                    .graphdata[ReportPDFASIvar.graphdata.length - 2].x,
                1000)
          ];

          ReportPDFASIvar.graphdata2 = [
            FlSpot(ReportPDFASIvar.graphdata[0].x,
                double.parse(ConverstStr(_dataCOMMON.datain[i].Cross))),
            FlSpot(double.parse(ConverstStr(_dataCOMMON.datain[i].RESULT)),
                double.parse(ConverstStr(_dataCOMMON.datain[i].Cross)))
          ];

          ReportPDFASIvar.graphdata3 = [
            FlSpot(double.parse(ConverstStr(_dataCOMMON.datain[i].RESULT)),
                double.parse(ConverstStr(_dataCOMMON.datain[i].Cross))),
            FlSpot(double.parse(ConverstStr(_dataCOMMON.datain[i].RESULT)), 0)
          ];

          ReportPDFASIvar.graphdata4 = [
            FlSpot(ReportPDFASIvar.graphdata[0].x, 1000),
            FlSpot(ReportPDFASIvar.graphdata[0].x, 0)
          ];

          ReportPDFASIvar.graphunder = [
            FlSpot(ReportPDFASIvar.graphdata[0].x, 0),
            FlSpot(
                ReportPDFASIvar
                    .graphdata[ReportPDFASIvar.graphdata.length - 2].x,
                0)
          ];
        }

        if (ReportPDFASIvar.graphupper.length > 1) {
          ReportPDFASIvar.graphupper;
        }

        if (ReportPDFASIvar.graphdata2.length > 1) {
          ReportPDFASIvar.graphdata2;
        }
        if (ReportPDFASIvar.graphdata3.length > 1) {
          ReportPDFASIvar.graphdata3;
        }
        if (ReportPDFASIvar.graphdata4.length > 1) {
          ReportPDFASIvar.graphdata4;
        }
        if (ReportPDFASIvar.graphunder.length > 1) {
          ReportPDFASIvar.graphunder;
        }

        //Compound Layer

        // Roughness
      }
      if (ReportPDFASIvar.graphdata.length > 1) {
        ReportPDFASIvar.graphdata.removeLast();
        //     .removeAt(ReportPDFASIvar.graphdata.length - 1);
      }

      // print(ReportPDFASIvar.datalist);
    } else {
      ReportPDFASIvar.STATUS = 'WATTING or NO-DATA';

      ReportPDFASIvar.CUSTOMER = '';
      ReportPDFASIvar.PROCESS = '';
      ReportPDFASIvar.PARTNAME = '';
      ReportPDFASIvar.PARTNO = '';
      ReportPDFASIvar.CUSLOT = '';
      ReportPDFASIvar.TPKLOT = '';
      ReportPDFASIvar.MATERIAL = '';
      ReportPDFASIvar.QTY = '';

      ReportPDFASIvar.PICstd = '';
      ReportPDFASIvar.PIC01 = '';
      ReportPDFASIvar.PIC02 = '';

      ReportPDFASIvar.rawlistHardness = [];
      ReportPDFASIvar.rawlistCompound = [];
      ReportPDFASIvar.rawlistRoughness = [];
      ReportPDFASIvar.rawlistCORE = [];
      ReportPDFASIvar.INC01 = '';
      ReportPDFASIvar.INC02 = '';

      ReportPDFASIvar.datalist = [
        ReportPDFASIlist(),
        ReportPDFASIlist(),
        ReportPDFASIlist(),
        ReportPDFASIlist(),
        ReportPDFASIlist(),
        ReportPDFASIlist(),
        ReportPDFASIlist(),
        ReportPDFASIlist(),
        ReportPDFASIlist(),
        ReportPDFASIlist(),
        ReportPDFASIlist(),
        ReportPDFASIlist(),
        ReportPDFASIlist(),
      ];

      ReportPDFASIvar.rawlistGraphCore = rawlist();

      ReportPDFASIvar.rawlistGraph = [];
      ReportPDFASIvar.graphupper = [];
      ReportPDFASIvar.graphdata = [];
      ReportPDFASIvar.graphdata2 = [];
      ReportPDFASIvar.graphdata3 = [];
      ReportPDFASIvar.graphdata4 = [];
      ReportPDFASIvar.graphunder = [];
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: ComInputText(
                  height: 40,
                  width: 200,
                  isContr: ReportPDFASIvar.iscontrol,
                  fnContr: (input) {
                    setState(() {
                      ReportPDFASIvar.iscontrol = input;
                    });
                  },
                  isEnabled: ReportPDFASIvar.canf,
                  sValue: ReportPDFASIvar.PO,
                  returnfunc: (String s) {
                    ReportPDFASIvar.PO = s;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: () {
                    if (ReportPDFASIvar.PO != '') {
                      context
                          .read<ReportPDFCommon_Cubit>()
                          .ReportPDFCommonCubit(ReportPDFASIvar.PO, "covs");
                    }
                  },
                  child: Container(
                    color: Colors.black,
                    height: 40,
                    width: 40,
                    child: const Center(
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: () {
                    context.read<ReportPDFCommon_Cubit>().Flush();
                    ReportPDFASIvar.canf = true;
                    ReportPDFASIvar.iscontrol = true;
                    ReportPDFASIvar.PO = '';
                    setState(() {});
                  },
                  child: Container(
                    color: Colors.red,
                    height: 40,
                    width: 100,
                    child: const Center(
                      child: Text("CLEAR"),
                    ),
                  ),
                ),
              ),
              InkWell(
                onDoubleTap: () {
                  //  ReportPDFCommonvar.HIDEDATAPIC
                  if (ReportPDFASIvar.HIDEDATAPIC) {
                    ReportPDFASIvar.HIDEDATAPIC = false;
                  } else {
                    ReportPDFASIvar.HIDEDATAPIC = true;
                  }
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(
                    color: ReportPDFASIvar.STATUS == 'REPORT READY'
                        ? Colors.green
                        : Colors.yellow,
                    height: 40,
                    width: 200,
                    child: Center(
                      child: Text(ReportPDFASIvar.STATUS),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: SizedBox(
                  height: 40,
                  width: 150,
                  child: AdvanceDropDown(
                    imgpath: 'assets/icons/icon-down_4@3x.png',
                    listdropdown: const [
                      MapEntry("-", "-"),
                      MapEntry("General", "1"),
                      MapEntry("JTEKT", "2"),
                      MapEntry("NTN122-4-7", "3"),
                      MapEntry("TBKK", "4"),
                      MapEntry("GKN", "5"),
                      MapEntry("SIAMADVANCE", "6"),
                      MapEntry("NTN500T850T", "7"),
                    ],
                    onChangeinside: (d, v) {
                      // print(d);
                      ReportPDFASIvar.TYPE = d;
                      if (d == '1') {
                        setState(() {
                          ReportPDFASIvar.SCMASKTYPE = imgGeneral;
                          ReportPDFASIvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '2') {
                        setState(() {
                          ReportPDFASIvar.SCMASKTYPE = imgJTEKT;
                          ReportPDFASIvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '3') {
                        setState(() {
                          ReportPDFASIvar.SCMASKTYPE = imgNTN;
                          ReportPDFASIvar.SCMASKTYPEonTop = imgNTNonH;
                        });
                      } else if (d == '4') {
                        setState(() {
                          ReportPDFASIvar.SCMASKTYPE = imgTBKK;
                          ReportPDFASIvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '5') {
                        setState(() {
                          ReportPDFASIvar.SCMASKTYPE = imgGKN;
                          ReportPDFASIvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '6') {
                        setState(() {
                          ReportPDFASIvar.SCMASKTYPE = SIAMADVANCE;
                          ReportPDFASIvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '7') {
                        setState(() {
                          ReportPDFASIvar.SCMASKTYPE = NTN500T850T;
                          ReportPDFASIvar.SCMASKTYPEonTop = NTN500T850T;
                        });
                      } else {
                        setState(() {
                          ReportPDFASIvar.SCMASKTYPE = imgGeneral;
                          ReportPDFASIvar.SCMASKTYPEonTop = '';
                        });
                      }
                    },
                    value: ReportPDFASIvar.TYPE,
                    height: 40,
                    width: 100,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: ComInputText(
                  height: 40,
                  width: 200,
                  isContr: ReportPDFASIvar.iscontrol,
                  fnContr: (input) {
                    setState(() {
                      ReportPDFASIvar.iscontrol = input;
                    });
                  },
                  sPlaceholder: "Inspected By",
                  sValue: ReportPDFASIvar.SignInsBy,
                  returnfunc: (String s) {
                    setState(() {
                      ReportPDFASIvar.SignInsBy = s;
                    });
                  },
                ),
              ),
              const Spacer(),
              if (ReportPDFASIvar.PASS == "PASSED") ...[
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: InkWell(
                    onTap: () {
                      PDFloader(context);
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        // capture(
                        captureToback(
                          // capture(
                          _globalKey,
                          ReportPDFASIvar.PO,
                        ).then((value) {
                          print(value);

                          Navigator.pop(context);
                        });
                      });
                    },
                    child: Container(
                      color: Colors.yellow,
                      height: 50,
                      width: 100,
                      child: const Center(
                        child: Text("Print"),
                      ),
                    ),
                  ),
                ),
              ] else ...[
                if (USERDATA.UserLV > 5 &&
                    _dataCOMMON.databasic.USER_STATUS == 'QCFN') ...[
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: InkWell(
                      onTap: () {
                        PDFloader(context);
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          // capture(
                          captureToback(
                            // capture(
                            _globalKey,
                            ReportPDFASIvar.PO,
                          ).then((value) {
                            print(value);

                            Navigator.pop(context);
                          });
                        });
                      },
                      child: Container(
                        color: Colors.yellow,
                        height: 50,
                        width: 100,
                        child: const Center(
                          child: Text("Print"),
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            ],
          ),
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: InkWell(
                onTap: () {
                  P303QMMASTERQCVAR.SETDAY = 'OK';
                  P303QMMASTERQCVAR.SEARCH = ReportPDFASIvar.PO;
                  var now = DateTime.now().subtract(Duration(days: 25));
                  P303QMMASTERQCVAR.day = DateFormat('dd').format(now);
                  P303QMMASTERQCVAR.month = DateFormat('MM').format(now);
                  P303QMMASTERQCVAR.year = DateFormat('yyyy').format(now);
                  STDreport2(context);
                },
                child: Container(
                  color: Colors.yellow,
                  height: 50,
                  width: 100,
                  child: const Center(
                    child: Text("UD and QCFN"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: InkWell(
                onTap: () {
                  //ReportPDFASIvar.PO
                  QCFN(context);
                },
                child: Container(
                  color: Colors.yellow,
                  height: 50,
                  width: 100,
                  child: const Center(
                    child: Text("QCFN"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: InkWell(
                onTap: () {
                  //ReportPDFASIvar.PO
                  String server = 'http://172.23.10.40:1885/';
                  String sap = "sap_GASHES_GB";

                  Dio().post(
                    server + sap,
                    data: {},
                  ).then((v) {
                    //
                    var databuff = v.data;
                    for (var i = 0; i < databuff.length; i++) {
                      //

                      if (databuff[i]['PO'] == ReportPDFASIvar.PO) {
                        print(
                            databuff[i]['PO'] + ':' + databuff[i]['FG_CHARG']);
                        // print(databuff[i]);
                        ReportPDFASIvar.TPKLOTEDIT = databuff[i]['FG_CHARG'];
                        setState(() {});
                      }
                    }
                  });
                },
                child: Container(
                  color: Colors.orange,
                  height: 50,
                  width: 100,
                  child: const Center(
                    child: Text("Re Lot"),
                  ),
                ),
              ),
            ),
          ]),

//QCFN
          //STDreport2
          // Row(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(left: 60),
          //       child: ComInputText(
          //         sLabel: "Remark",
          //         height: 40,
          //         width: 500,
          //         nLimitedChar: 500,
          //         isContr: ReportPDFASIvar.iscontrol,
          //         fnContr: (input) {
          //           setState(() {
          //             ReportPDFASIvar.iscontrol = input;
          //           });
          //         },
          //         // isEnabled: ReportPDFASIvar.canf,
          //         sValue: ReportPDFASIvar.remark,
          //         returnfunc: (String s) {
          //           setState(() {
          //             ReportPDFASIvar.remark = s;
          //           });
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                RepaintBoundary(
                  key: _globalKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // const SizedBox(
                          //   width: 50,
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              height: 2000,
                              width: 1364,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 3),
                                // color: Colors.red,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(0)),
                              ),
                              child: Column(
                                children: [
                                  headerreport(
                                    CUSTOMER: ReportPDFASIvar.CUSTOMER,
                                    PROCESS: ReportPDFASIvar.PROCESS,
                                    PARTNAME: ReportPDFASIvar.PARTNAME,
                                    PARTNO: ReportPDFASIvar.PARTNO,
                                    CUSLOT: ReportPDFASIvar.CUSLOT,
                                    TPKLOT: ReportPDFASIvar.TPKLOT,
                                    MATERIAL: ReportPDFASIvar.MATERIAL,
                                    QTY: ReportPDFASIvar.QTY,
                                  ),
                                  HEAD1SLOT(
                                    widget01: const Center(
                                      child: Text(
                                        "INCOMING INSPECTION",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  HEAD7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: const Center(
                                      child: Text(
                                        "ITEM",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget02: const Center(
                                      child: Text(
                                        "SC",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget03: const Center(
                                      child: Text(
                                        "Check Method",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget04: const Center(
                                      child: Text(
                                        "Frequency",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget05: const Center(
                                      child: Text(
                                        "Specification",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget06: const Center(
                                      child: Text(
                                        "Result",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget07: const Center(
                                      child: Text(
                                        "Remark",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  BODY7SLOT(
                                    ListFlex: const [6, 1, 4, 2, 2, 2, 2],
                                    widget01: Center(
                                      child: Text(
                                        ReportPDFASIvar.INC01 != ''
                                            ? "Appearance for Rust"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: const Center(
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFASIvar.INC01 != ''
                                            ? "Visual"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFASIvar.INC01 != ''
                                            ? "10 pcs/rcv.Lot"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFASIvar.INC01 != ''
                                            ? "No Rust"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFASIvar.INC01 != ''
                                            ? "No Rust"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget07: const Center(
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  BODY7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: Center(
                                      child: Text(
                                        ReportPDFASIvar.INC02 != ''
                                            ? "Appearance for scratch"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: Text(
                                        ReportPDFASIvar.INC02 != '' ? "" : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFASIvar.INC02 != ''
                                            ? "Visual"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFASIvar.INC02 != ''
                                            ? "10 pcs/rcv.Lot"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFASIvar.INC02 != ''
                                            ? "No Scratch"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFASIvar.INC02 != ''
                                            ? "No Scratch"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget07: const Center(
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  HEAD1SLOT(
                                    widget01: const Center(
                                      child: Text(
                                        "FINAL INSPECTION",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  HEAD7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: const Center(
                                      child: Text(
                                        "ITEM",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget02: const Center(
                                      child: Text(
                                        "SC",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget03: const Center(
                                      child: Text(
                                        "Check Method",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget04: const Center(
                                      child: Text(
                                        "Frequency",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget05: const Center(
                                      child: Text(
                                        "Specification",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget06: const Center(
                                      child: Text(
                                        "Result",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    widget07: const Center(
                                      child: Text(
                                        "Remark",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  BODY7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[0].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFASIvar
                                                  .datalist[0].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFASIvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[0].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[0].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFASIvar
                                            .datalist[0].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar
                                                      .datalist[0]
                                                      .SPECIFICATIONname
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[0].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar.datalist[0]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[0].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar.datalist[0]
                                                      .REMARK.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  BODY7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[1].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFASIvar
                                                  .datalist[1].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFASIvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[1].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[1].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFASIvar
                                            .datalist[1].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar
                                                      .datalist[1]
                                                      .SPECIFICATIONname
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[1].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar.datalist[1]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[1].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar.datalist[1]
                                                      .REMARK.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  BODY7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[2].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFASIvar
                                                  .datalist[2].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFASIvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[2].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[2].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFASIvar
                                            .datalist[2].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar
                                                      .datalist[2]
                                                      .SPECIFICATIONname
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[2].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar.datalist[2]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[2].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar.datalist[2]
                                                      .REMARK.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  BODY7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[3].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFASIvar
                                                  .datalist[3].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFASIvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[3].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[3].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFASIvar
                                            .datalist[3].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar
                                                      .datalist[3]
                                                      .SPECIFICATIONname
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[3].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar.datalist[3]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[3].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar.datalist[3]
                                                      .REMARK.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  BODY7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[4].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFASIvar
                                                  .datalist[4].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFASIvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[4].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[4].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFASIvar
                                            .datalist[4].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar
                                                      .datalist[4]
                                                      .SPECIFICATIONname
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[4].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar.datalist[4]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[4].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar.datalist[4]
                                                      .REMARK.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  BODY7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[5].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFASIvar
                                                  .datalist[5].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFASIvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[5].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[5].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFASIvar
                                            .datalist[5].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar
                                                      .datalist[5]
                                                      .SPECIFICATIONname
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[5].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar.datalist[5]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[5].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar.datalist[5]
                                                      .REMARK.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  BODY7SLOT(
                                    ListFlex: [6, 1, 4, 2, 2, 2, 2],
                                    widget01: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[6].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFASIvar
                                                  .datalist[6].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFASIvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[6].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[6].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFASIvar
                                            .datalist[6].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar
                                                      .datalist[6]
                                                      .SPECIFICATIONname
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[6].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar.datalist[6]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFASIvar.datalist[7].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFASIvar.datalist[7]
                                                      .REMARK.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          children: [
                                            HEAD16SLOT(
                                              ListFlex: S16slot,
                                              widget01: const Center(
                                                child: Text(
                                                  "SAMPLE NO.",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget02: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          1
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[0]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget03: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          2
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[1]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget04: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          3
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[2]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget05: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          4
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[3]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget06: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          5
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[4]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget07: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          6
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[5]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget08: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          7
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[6]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget09: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          8
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[7]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget10: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          9
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[8]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget11: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          10
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[9]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget12: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          11
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[10]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget13: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          12
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[11]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget14: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          13
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[12]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget15: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          14
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[13]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget16: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          15
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[14]
                                                          .DATANO
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            BODY16SLOT(
                                              ListFlex: S16slot,
                                              widget01: const Center(
                                                child: Text(
                                                  "POINT NO.",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget02: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          1
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[0]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget03: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          2
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[1]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget04: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          3
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[2]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget05: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          4
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[3]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget06: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          5
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[4]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget07: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          6
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[5]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget08: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          7
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[6]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget09: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          8
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[7]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget10: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          9
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[8]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget11: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          10
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[9]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget12: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          11
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[10]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget13: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          12
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[11]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget14: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          13
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[12]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget15: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          14
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[13]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget16: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          15
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[14]
                                                          .DATAPCS
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            BODY16SLOT(
                                              ListFlex: S16slot,
                                              widget01: const Center(
                                                child: Text(
                                                  "Surface Hardness (HRC)",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget02: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          1
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[0]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget03: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          2
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[1]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget04: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          3
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[2]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget05: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          4
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[3]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget06: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          5
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[4]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget07: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          6
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[5]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget08: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          7
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[6]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget09: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          8
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[7]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget10: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          9
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[8]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget11: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          10
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[9]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget12: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          11
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[10]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget13: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          12
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[11]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget14: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          13
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[12]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget15: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          14
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[13]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget16: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          15
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[14]
                                                          .DATA
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            BODY16SLOT(
                                              ListFlex: S16slot,
                                              widget01: const Center(
                                                child: Text(
                                                  "Surface Hardness (HRA)",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget02: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          1
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[0]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget03: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          2
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[1]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget04: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          3
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[2]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget05: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          4
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[3]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget06: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          5
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[4]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget07: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          6
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[5]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget08: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          7
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[6]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget09: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          8
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[7]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget10: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          9
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[8]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget11: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          10
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[9]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget12: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          11
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[10]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget13: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          12
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[11]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget14: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          13
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[12]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget15: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          14
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[13]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget16: Center(
                                                child: Text(
                                                  ReportPDFASIvar
                                                              .rawlistHardness
                                                              .length >=
                                                          15
                                                      ? ReportPDFASIvar
                                                          .rawlistHardness[14]
                                                          .DATA2
                                                      : '',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Expanded(
                                      //   flex: 2,
                                      //   child: Column(
                                      //     children: [
                                      //       HEAD2SLOT(
                                      //         ListFlex: [2, 1, 1, 1, 1, 1],
                                      //         widget01: const Center(
                                      //           child: Text(
                                      //             "SAMPLE NO.",
                                      //             style: TextStyle(
                                      //               fontSize: 16,
                                      //               fontWeight: FontWeight.bold,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         widget02: Center(
                                      //           child: Text(
                                      //             ReportPDFASIvar
                                      //                         .rawlistCORE.length >=
                                      //                     1
                                      //                 ? ReportPDFASIvar
                                      //                     .rawlistCORE[0].DATANO
                                      //                 : '',
                                      //             style: const TextStyle(
                                      //               fontSize: 16,
                                      //               fontWeight: FontWeight.bold,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //       BODY2SLOT(
                                      //         ListFlex: [2, 1, 1, 1, 1, 1],
                                      //         widget01: const Center(
                                      //           child: Text(
                                      //             "POINT NO.",
                                      //             style: TextStyle(
                                      //               fontSize: 16,
                                      //               fontWeight: FontWeight.bold,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         widget02: Center(
                                      //           child: Text(
                                      //             ReportPDFASIvar
                                      //                         .rawlistCORE.length >=
                                      //                     1
                                      //                 ? ReportPDFASIvar
                                      //                     .rawlistCORE[0].DATAPCS
                                      //                 : '',
                                      //             style: const TextStyle(
                                      //               fontSize: 16,
                                      //               fontWeight: FontWeight.bold,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         // widget03: Center(
                                      //         //   child: Text(
                                      //         //     ReportPDFASIvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             2
                                      //         //         ? ReportPDFASIvar
                                      //         //             .rawlistCORE[1].DATAPCS
                                      //         //         : '',
                                      //         //     style: const TextStyle(
                                      //         //       fontSize: 16,
                                      //         //       fontWeight: FontWeight.bold,
                                      //         //     ),
                                      //         //   ),
                                      //         // ),
                                      //         // widget04: Center(
                                      //         //   child: Text(
                                      //         //     ReportPDFASIvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             3
                                      //         //         ? ReportPDFASIvar
                                      //         //             .rawlistCORE[2].DATAPCS
                                      //         //         : '',
                                      //         //     style: const TextStyle(
                                      //         //       fontSize: 16,
                                      //         //       fontWeight: FontWeight.bold,
                                      //         //     ),
                                      //         //   ),
                                      //         // ),
                                      //         // widget05: Center(
                                      //         //   child: Text(
                                      //         //     ReportPDFASIvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             4
                                      //         //         ? ReportPDFASIvar
                                      //         //             .rawlistCORE[3].DATAPCS
                                      //         //         : '',
                                      //         //     style: const TextStyle(
                                      //         //       fontSize: 16,
                                      //         //       fontWeight: FontWeight.bold,
                                      //         //     ),
                                      //         //   ),
                                      //         // ),
                                      //         // widget06: Center(
                                      //         //   child: Text(
                                      //         //     ReportPDFASIvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             5
                                      //         //         ? ReportPDFASIvar
                                      //         //             .rawlistCORE[4].DATAPCS
                                      //         //         : '',
                                      //         //     style: const TextStyle(
                                      //         //       fontSize: 16,
                                      //         //       fontWeight: FontWeight.bold,
                                      //         //     ),
                                      //         //   ),
                                      //         // ),
                                      //       ),
                                      //       BODY2SLOT(
                                      //         ListFlex: [2, 1, 1, 1, 1, 1],
                                      //         widget01: const Center(
                                      //           child: Text(
                                      //             "CORE",
                                      //             style: TextStyle(
                                      //               fontSize: 16,
                                      //               fontWeight: FontWeight.bold,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         widget02: Center(
                                      //           child: Text(
                                      //             ReportPDFASIvar
                                      //                         .rawlistCORE.length >=
                                      //                     1
                                      //                 ? ReportPDFASIvar
                                      //                     .rawlistCORE[0].DATA
                                      //                 : '',
                                      //             style: const TextStyle(
                                      //               fontSize: 16,
                                      //               fontWeight: FontWeight.bold,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         // widget03: Center(
                                      //         //   child: Text(
                                      //         //     ReportPDFASIvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             2
                                      //         //         ? ReportPDFASIvar
                                      //         //             .rawlistCORE[1].DATA
                                      //         //         : '',
                                      //         //     style: const TextStyle(
                                      //         //       fontSize: 16,
                                      //         //       fontWeight: FontWeight.bold,
                                      //         //     ),
                                      //         //   ),
                                      //         // ),
                                      //         // widget04: Center(
                                      //         //   child: Text(
                                      //         //     ReportPDFASIvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             3
                                      //         //         ? ReportPDFASIvar
                                      //         //             .rawlistCORE[2].DATA
                                      //         //         : '',
                                      //         //     style: const TextStyle(
                                      //         //       fontSize: 16,
                                      //         //       fontWeight: FontWeight.bold,
                                      //         //     ),
                                      //         //   ),
                                      //         // ),
                                      //         // widget05: Center(
                                      //         //   child: Text(
                                      //         //     ReportPDFASIvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             4
                                      //         //         ? ReportPDFASIvar
                                      //         //             .rawlistCORE[3].DATA
                                      //         //         : '',
                                      //         //     style: const TextStyle(
                                      //         //       fontSize: 16,
                                      //         //       fontWeight: FontWeight.bold,
                                      //         //     ),
                                      //         //   ),
                                      //         // ),
                                      //         // widget06: Center(
                                      //         //   child: Text(
                                      //         //     ReportPDFASIvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             5
                                      //         //         ? ReportPDFASIvar
                                      //         //             .rawlistCORE[4].DATA
                                      //         //         : '',
                                      //         //     style: const TextStyle(
                                      //         //       fontSize: 16,
                                      //         //       fontWeight: FontWeight.bold,
                                      //         //     ),
                                      //         //   ),
                                      //         // ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // )
                                    ],
                                  ),
                                  PICSLO2SIDEGRAPH(
                                    // PIC01: _dataCOMMON.databasic.PIC01,
                                    // PIC02: _dataCOMMON.databasic.PIC02 == wpic
                                    //     ? _dataCOMMON.databasic.PIC03
                                    //     : _dataCOMMON.databasic.PIC02,
                                    // PIC01: "",
                                    // PIC02: "",
                                    PIC01: ReportPDFASIvar.HIDEDATAPIC
                                        ? ""
                                        : _dataCOMMON.databasic.PIC01,
                                    PIC02: ReportPDFASIvar.HIDEDATAPIC
                                        ? ""
                                        : _dataCOMMON.databasic.PIC02,
                                    widget01: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          child: Container(
                                            height: 320,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 3),
                                            ),
                                            child: ReportPDFASIvar
                                                    .graphdata.isNotEmpty
                                                ? ControlChart01(
                                                    upper: ReportPDFASIvar
                                                        .graphupper,
                                                    data: ReportPDFASIvar
                                                        .graphdata,
                                                    data2: ReportPDFASIvar
                                                        .graphdata2,
                                                    data3: ReportPDFASIvar
                                                        .graphdata3,
                                                    data4: ReportPDFASIvar
                                                        .graphdata4,
                                                    under: ReportPDFASIvar
                                                        .graphunder,
                                                  )
                                                : SizedBox(
                                                    height: 320,
                                                    width: 2000,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    widget02: Column(
                                      children: [
                                        HEAD16SLOT(
                                          ListFlex: S16slot,
                                          widget01: const Center(
                                            child: Text(
                                              "Depth (mm.)",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget02: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      1
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[0].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget03: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      2
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[1].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget04: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      3
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[2].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget05: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      4
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[3].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget06: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      5
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[4].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget07: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      6
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[5].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget08: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      7
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[6].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget09: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      8
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[7].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget10: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      9
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[8].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget11: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      10
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[9].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget12: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      11
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[10].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget13: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      12
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[11].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget14: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      13
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[12].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget15: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      14
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[13].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget16: const Center(
                                            child: Text(
                                              "CORE",
                                              // ReportPDFASIvar
                                              //     .rawlistGraphCore.DATAPCS,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        BODY16SLOT(
                                          ListFlex: S16slot,
                                          widget01: const Center(
                                            child: Text(
                                              "Hardness",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget02: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      1
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[0].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget03: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      2
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[1].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget04: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      3
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[2].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget05: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      4
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[3].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget06: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      5
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[4].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget07: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      6
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[5].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget08: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      7
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[6].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget09: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      8
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[7].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget10: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      9
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[8].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget11: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      10
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[9].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget12: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      11
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[10].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget13: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      12
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[11].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget14: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      13
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[12].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget15: Center(
                                            child: Text(
                                              ReportPDFASIvar.rawlistGraph
                                                          .length >=
                                                      14
                                                  ? ReportPDFASIvar
                                                      .rawlistGraph[13].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget16: Center(
                                            child: Text(
                                              ReportPDFASIvar
                                                  .rawlistGraphCore.DATA,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TAILSLOT(
                                    PASS: ReportPDFASIvar.PASS,
                                    PICS: _dataCOMMON.databasic.PICstd,
                                    Remark: ReportPDFASIvar.remark,
                                    signs: true,
                                    NAME01:
                                        _dataCOMMON.databasic.Inspected_sign,
                                    NAME02: _dataCOMMON.databasic.Check_sign,
                                    NAME03: _dataCOMMON.databasic.Approve_sign,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    if ((USERDATA.UserLV) > 1) ...[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            Dio().post(
                              GLOserver + "Inspected-sign",
                              data: {
                                "ID": USERDATA.ID,
                                "PO": ReportPDFASIvar.PO,
                              },
                            ).then((v) {
                              var databuff = v.data;
                              context
                                  .read<ReportPDFCommon_Cubit>()
                                  .ReportPDFCommonCubit(ReportPDFASIvar.PO, "");
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            color: Colors.blue,
                            child: Center(
                              child: Text("Inspected"),
                            ),
                          ),
                        ),
                      ),
                    ],
                    if ((USERDATA.UserLV) > 20) ...[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            Dio().post(
                              GLOserver + "Check-sign",
                              data: {
                                "ID": USERDATA.ID,
                                "PO": ReportPDFASIvar.PO,
                              },
                            ).then((v) {
                              var databuff = v.data;
                              context
                                  .read<ReportPDFCommon_Cubit>()
                                  .ReportPDFCommonCubit(ReportPDFASIvar.PO, "");
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            color: Colors.blue,
                            child: Center(
                              child: Text("Check"),
                            ),
                          ),
                        ),
                      ),
                    ],
                    if ((USERDATA.UserLV) > 30) ...[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            Dio().post(
                              GLOserver + "Approve-sign",
                              data: {
                                "ID": USERDATA.ID,
                                "PO": ReportPDFASIvar.PO,
                              },
                            ).then((v) {
                              var databuff = v.data;
                              context
                                  .read<ReportPDFCommon_Cubit>()
                                  .ReportPDFCommonCubit(ReportPDFASIvar.PO, "");
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            color: Colors.blue,
                            child: Center(
                              child: Text("Approve"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 50,
          ),
        ],
      ),
    );
  }
}

List<int> S16slot = const [
  3,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1
];

void STDreport2(
  BuildContext contextin,
) {
  showDialog(
    context: contextin,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        child: SizedBox(
          height: 1000,
          width: 1500,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Page303(),
            ),
          ),
        ),
      );
    },
  );
}

void QCFN(BuildContext contextin) {
  showDialog(
    context: contextin,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        child: QCFNWD(),
      );
    },
  );
}

class QCFNWD extends StatefulWidget {
  const QCFNWD({super.key});

  @override
  State<QCFNWD> createState() => QCFNWDState();
}

class QCFNWDState extends State<QCFNWD> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 600,
      child: Center(
        child: SizedBox(
          child: InkWell(
            onTap: () {
              print("00" + ReportPDFASIvar.PO);
              Dio().post(
                "${server2}10GETDATAFROMJOBBINGAQC/QCFN",
                // "${'http://127.0.0.1:14094/'}10GETDATAFROMJOBBINGAQC/QCFN",
                data: {
                  "BAPI_NAME": "ZFMPPQCFN_IN",
                  "ORDERID": ReportPDFASIvar.PO,
                  "PERNR_ID": USERDATA.ID
                },
              ).then((v) {
                Navigator.pop(context);

                //
                print(v.data);
                if (v.data['ExportParameter'] != null) {
                  if (v.data['ExportParameter']['INACT_NEW'].toString() ==
                      'E') {
                    showErrorPopup(context, v.data.toString());
                  } else {
                    showGoodPopup(context, v.data.toString());
                  }
                } else {
                  showErrorPopup(context, v.data.toString());
                }
              });
            },
            child: Container(
              width: 400,
              height: 100,
              color: Colors.blue,
              child: Center(
                child: Text("QCFN"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
