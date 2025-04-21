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
import 'ReportPDFwm3var.dart';

late BuildContext ReportPDFwm3context;

class ReportPDFwm3 extends StatefulWidget {
  ReportPDFwm3({
    Key? key,
    this.dataCommon,
  }) : super(key: key);
  CommonReportOutput? dataCommon;
  @override
  State<ReportPDFwm3> createState() => _ReportPDFwm3State();
}

class _ReportPDFwm3State extends State<ReportPDFwm3> {
  @override
  void initState() {
    ReportPDFwm3var.TPKLOTEDIT = '';
    if (ReportPDFwm3var.PO != '') {
      ReportPDFwm3var.canf = false;
      context
          .read<ReportPDFCommon_Cubit>()
          .ReportPDFCommonCubit(ReportPDFwm3var.PO);
    }
    super.initState();
  }

  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ReportPDFwm3context = context;

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
      ReportPDFwm3var.STATUS = 'REPORT READY';
      ReportPDFwm3var.CUSTOMER = _dataCOMMON.databasic.CUSTOMER;
      ReportPDFwm3var.PROCESS = _dataCOMMON.databasic.PROCESS;
      ReportPDFwm3var.PARTNAME = _dataCOMMON.databasic.PARTNAME;
      ReportPDFwm3var.PARTNO = _dataCOMMON.databasic.PARTNO;
      ReportPDFwm3var.CUSLOT = _dataCOMMON.databasic.CUSLOT;
      ReportPDFwm3var.TPKLOT = _dataCOMMON.databasic.TPKLOT;
      ReportPDFwm3var.MATERIAL = _dataCOMMON.databasic.MATERIAL;
      if (_dataCOMMON.databasic.UNITSAP.toUpperCase() != 'KG') {
        ReportPDFwm3var.QTY =
            '${double.parse(ConverstStr(_dataCOMMON.databasic.QTY)).toStringAsFixed(0)} ${_dataCOMMON.databasic.UNITSAP}';
      } else {
        ReportPDFwm3var.QTY =
            '${double.parse(ConverstStr(_dataCOMMON.databasic.QTY)).toStringAsFixed(1)} ${_dataCOMMON.databasic.UNITSAP}';
      }

      ReportPDFwm3var.PIC01 = _dataCOMMON.databasic.PIC01;
      ReportPDFwm3var.PIC02 = _dataCOMMON.databasic.PIC02;
      ReportPDFwm3var.PICstd = _dataCOMMON.databasic.PICstd;

      ReportPDFwm3var.PASS = _dataCOMMON.databasic.PASS;
      ReportPDFwm3var.remark = '';
      if (_dataCOMMON.databasic.PARTNAMEref != '') {
        ReportPDFwm3var.remark =
            'Reference data from\n${_dataCOMMON.databasic.PARTNAMEref}\n${_dataCOMMON.databasic.PARTref}';
      }

      ReportPDFwm3var.INC01 = _dataCOMMON.databasic.INC01;
      ReportPDFwm3var.INC02 = _dataCOMMON.databasic.INC02;
//remark

      // print(_dataCOMMON.datain[0]);
      // print(_dataCOMMON.datain.length);
      ReportPDFwm3var.rawlistHardness = [];
      ReportPDFwm3var.rawlistCompound = [];
      ReportPDFwm3var.rawlistRoughness = [];
      ReportPDFwm3var.rawlistCORE = [];

      ReportPDFwm3var.graphupper = [];
      ReportPDFwm3var.graphdata = [];
      ReportPDFwm3var.graphdata2 = [];
      ReportPDFwm3var.graphdata3 = [];
      ReportPDFwm3var.graphdata4 = [];
      ReportPDFwm3var.graphunder = [];

      for (var i = 0; i < _dataCOMMON.datain.length; i++) {
        String Loadin = '';
        if (_dataCOMMON.datain[i].LOAD != '' &&
            _dataCOMMON.datain[i].LOAD != '-') {
          Loadin = "( Load ${_dataCOMMON.datain[i].LOAD} )";
        }
        ReportPDFwm3var.datalist[i].ITEMname =
            " ${_dataCOMMON.datain[i].ITEMname} ${Loadin}";
        ReportPDFwm3var.datalist[i].SCMARK = _dataCOMMON.datain[i].SCMARK;
        ReportPDFwm3var.datalist[i].METHODname =
            _dataCOMMON.datain[i].METHODname;
        ReportPDFwm3var.datalist[i].FREQ = _dataCOMMON.datain[i].FREQ;
        ReportPDFwm3var.datalist[i].SPECIFICATIONname =
            _dataCOMMON.datain[i].SPECIFICATION;
        ReportPDFwm3var.datalist[i].RESULT = _dataCOMMON.datain[i].RESULT;
        ReportPDFwm3var.datalist[i].REMARK = _dataCOMMON.datain[i].Remark;
        //print(ReportPDFwm3var.datalist[i].RESULT.length);
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
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '1',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA01,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 2) {
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '2',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA02,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 3) {
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '3',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA03,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 4) {
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '4',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA04,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 5) {
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '5',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA05,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 6) {
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '6',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA06,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 7) {
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '7',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA07,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 8) {
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '8',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA08,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 9) {
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '9',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA09,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 10) {
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '10',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA10,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 11) {
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '11',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA11,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 12) {
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '12',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA12,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 13) {
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '13',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA13,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 14) {
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '14',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA14,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 15) {
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '15',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA15,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 16) {
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '16',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA16,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 17) {
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '17',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA17,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 18) {
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '18',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA18,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 19) {
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '19',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA19,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 20) {
                ReportPDFwm3var.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '20',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA20,
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
                ReportPDFwm3var.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '1',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA01,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 2) {
                ReportPDFwm3var.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '2',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA02,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 3) {
                ReportPDFwm3var.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '3',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA03,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 4) {
                ReportPDFwm3var.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '4',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA04,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 5) {
                ReportPDFwm3var.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '5',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA05,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 6) {
                ReportPDFwm3var.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '6',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA06,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 7) {
                ReportPDFwm3var.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '7',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA07,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 8) {
                ReportPDFwm3var.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '8',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA08,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 9) {
                ReportPDFwm3var.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '9',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA09,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 10) {
                ReportPDFwm3var.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '10',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA10,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 11) {
                ReportPDFwm3var.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '11',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA11,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 12) {
                ReportPDFwm3var.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '12',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA12,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 13) {
                ReportPDFwm3var.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '13',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA13,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 14) {
                ReportPDFwm3var.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '14',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA14,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 15) {
                ReportPDFwm3var.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '15',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA15,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 16) {
                ReportPDFwm3var.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '16',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA16,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 17) {
                ReportPDFwm3var.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '17',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA17,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 18) {
                ReportPDFwm3var.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '18',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA18,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 19) {
                ReportPDFwm3var.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '19',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA19,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 20) {
                ReportPDFwm3var.rawlistCORE.add(rawlist(
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
          ReportPDFwm3var.rawlistGraph = [];
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
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA01p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA01,
                ));

                ReportPDFwm3var.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA01p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA01))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 2) {
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA02p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA02,
                ));

                ReportPDFwm3var.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA02p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA02))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 3) {
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA03p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA03,
                ));

                ReportPDFwm3var.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA03p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA03))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 4) {
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA04p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA04,
                ));

                ReportPDFwm3var.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA04p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA04))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 5) {
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA05p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA05,
                ));

                ReportPDFwm3var.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA05p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA05))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 6) {
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA06p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA06,
                ));

                ReportPDFwm3var.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA06p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA06))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 7) {
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA07p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA07,
                ));

                ReportPDFwm3var.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA07p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA07))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 8) {
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA08p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA08,
                ));

                ReportPDFwm3var.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA08p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA08))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 9) {
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA09p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA09,
                ));

                ReportPDFwm3var.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA09p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA09))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 10) {
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA10p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA10,
                ));

                ReportPDFwm3var.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA10p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA10))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 11) {
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA11p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA11,
                ));

                ReportPDFwm3var.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA11p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA11))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 12) {
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA12p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA12,
                ));

                ReportPDFwm3var.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA12p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA12))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 13) {
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA13p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA13,
                ));

                ReportPDFwm3var.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA13p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA13))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 14) {
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA14p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA14,
                ));

                ReportPDFwm3var.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA14p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA14))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 15) {
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA15p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA15,
                ));

                ReportPDFwm3var.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA15p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA15))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 16) {
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA16p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA16,
                ));

                ReportPDFwm3var.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA16p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA16))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 17) {
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA17p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA17,
                ));

                ReportPDFwm3var.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA17p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA17))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 18) {
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA18p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA18,
                ));

                ReportPDFwm3var.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA18p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA18))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 19) {
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA19p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA19,
                ));

                ReportPDFwm3var.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA19p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA19))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 20) {
                ReportPDFwm3var.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA20p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA20,
                ));

                ReportPDFwm3var.graphdata.add(
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

          // ReportPDFwm3var.rawlistGraphCore = rawlist(
          //   DATAPCS: "Core",
          //   DATA: ReportPDFwm3var
          //       .rawlistGraph[ReportPDFwm3var.rawlistGraph.length - 1].DATA,
          // );
          // print(">>>${ReportPDFwm3var.rawlistGraph.length}");
          // ReportPDFwm3var.rawlistGraph.removeLast();
          if (ReportPDFwm3var.rawlistGraph.length > 2) {
            ReportPDFwm3var.rawlistGraphCore = rawlist(
              DATAPCS: "Core",
              DATA: ReportPDFwm3var
                  .rawlistGraph[ReportPDFwm3var.rawlistGraph.length - 1].DATA,
            );
            // print(">>>${ReportPDFwm3var.rawlistGraph.length}");

            ReportPDFwm3var.rawlistGraph
                .removeAt(ReportPDFwm3var.rawlistGraph.length - 1);
          }

          ReportPDFwm3var.graphupper = [
            FlSpot(ReportPDFwm3var.graphdata[0].x, 1000),
            FlSpot(
                ReportPDFwm3var
                    .graphdata[ReportPDFwm3var.graphdata.length - 2].x,
                1000)
          ];

          ReportPDFwm3var.graphdata2 = [
            FlSpot(ReportPDFwm3var.graphdata[0].x,
                double.parse(ConverstStr(_dataCOMMON.datain[i].Cross))),
            FlSpot(double.parse(ConverstStr(_dataCOMMON.datain[i].RESULT)),
                double.parse(ConverstStr(_dataCOMMON.datain[i].Cross)))
          ];

          ReportPDFwm3var.graphdata3 = [
            FlSpot(double.parse(ConverstStr(_dataCOMMON.datain[i].RESULT)),
                double.parse(ConverstStr(_dataCOMMON.datain[i].Cross))),
            FlSpot(double.parse(ConverstStr(_dataCOMMON.datain[i].RESULT)), 0)
          ];

          ReportPDFwm3var.graphdata4 = [
            FlSpot(ReportPDFwm3var.graphdata[0].x, 1000),
            FlSpot(ReportPDFwm3var.graphdata[0].x, 0)
          ];

          ReportPDFwm3var.graphunder = [
            FlSpot(ReportPDFwm3var.graphdata[0].x, 0),
            FlSpot(
                ReportPDFwm3var
                    .graphdata[ReportPDFwm3var.graphdata.length - 2].x,
                0)
          ];
        }

        if (ReportPDFwm3var.graphupper.length > 1) {
          ReportPDFwm3var.graphupper;
        }

        if (ReportPDFwm3var.graphdata2.length > 1) {
          ReportPDFwm3var.graphdata2;
        }
        if (ReportPDFwm3var.graphdata3.length > 1) {
          ReportPDFwm3var.graphdata3;
        }
        if (ReportPDFwm3var.graphdata4.length > 1) {
          ReportPDFwm3var.graphdata4;
        }
        if (ReportPDFwm3var.graphunder.length > 1) {
          ReportPDFwm3var.graphunder;
        }

        //Compound Layer

        // Roughness
      }
      if (ReportPDFwm3var.graphdata.length > 1) {
        ReportPDFwm3var.graphdata.removeLast();
        //     .removeAt(ReportPDFwm3var.graphdata.length - 1);
      }

      // print(ReportPDFwm3var.datalist);
    } else {
      ReportPDFwm3var.STATUS = 'WATTING or NO-DATA';

      ReportPDFwm3var.CUSTOMER = '';
      ReportPDFwm3var.PROCESS = '';
      ReportPDFwm3var.PARTNAME = '';
      ReportPDFwm3var.PARTNO = '';
      ReportPDFwm3var.CUSLOT = '';
      ReportPDFwm3var.TPKLOT = '';
      ReportPDFwm3var.MATERIAL = '';
      ReportPDFwm3var.QTY = '';

      ReportPDFwm3var.PICstd = '';
      ReportPDFwm3var.PIC01 = '';
      ReportPDFwm3var.PIC02 = '';

      ReportPDFwm3var.rawlistHardness = [];
      ReportPDFwm3var.rawlistCompound = [];
      ReportPDFwm3var.rawlistRoughness = [];
      ReportPDFwm3var.rawlistCORE = [];
      ReportPDFwm3var.INC01 = '';
      ReportPDFwm3var.INC02 = '';

      ReportPDFwm3var.datalist = [
        ReportPDFCommonlist(),
        ReportPDFCommonlist(),
        ReportPDFCommonlist(),
        ReportPDFCommonlist(),
        ReportPDFCommonlist(),
        ReportPDFCommonlist(),
        ReportPDFCommonlist(),
        ReportPDFCommonlist(),
        ReportPDFCommonlist(),
        ReportPDFCommonlist(),
        ReportPDFCommonlist(),
        ReportPDFCommonlist(),
        ReportPDFCommonlist(),
      ];

      ReportPDFwm3var.rawlistGraphCore = rawlist();

      ReportPDFwm3var.rawlistGraph = [];
      ReportPDFwm3var.graphupper = [];
      ReportPDFwm3var.graphdata = [];
      ReportPDFwm3var.graphdata2 = [];
      ReportPDFwm3var.graphdata3 = [];
      ReportPDFwm3var.graphdata4 = [];
      ReportPDFwm3var.graphunder = [];
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
                  isContr: ReportPDFwm3var.iscontrol,
                  fnContr: (input) {
                    setState(() {
                      ReportPDFwm3var.iscontrol = input;
                    });
                  },
                  isEnabled: ReportPDFwm3var.canf,
                  sValue: ReportPDFwm3var.PO,
                  returnfunc: (String s) {
                    ReportPDFwm3var.PO = s;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: () {
                    if (ReportPDFwm3var.PO != '') {
                      context
                          .read<ReportPDFCommon_Cubit>()
                          .ReportPDFCommonCubit(ReportPDFwm3var.PO);
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
                    ReportPDFwm3var.canf = true;
                    ReportPDFwm3var.iscontrol = true;
                    ReportPDFwm3var.PO = '';
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
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Container(
                  color: ReportPDFwm3var.STATUS == 'REPORT READY'
                      ? Colors.green
                      : Colors.yellow,
                  height: 40,
                  width: 200,
                  child: Center(
                    child: Text(ReportPDFwm3var.STATUS),
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
                      ReportPDFwm3var.TYPE = d;
                      if (d == '1') {
                        setState(() {
                          ReportPDFwm3var.SCMASKTYPE = imgGeneral;
                          ReportPDFwm3var.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '2') {
                        setState(() {
                          ReportPDFwm3var.SCMASKTYPE = imgJTEKT;
                          ReportPDFwm3var.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '3') {
                        setState(() {
                          ReportPDFwm3var.SCMASKTYPE = imgNTN;
                          ReportPDFwm3var.SCMASKTYPEonTop = imgNTNonH;
                        });
                      } else if (d == '4') {
                        setState(() {
                          ReportPDFwm3var.SCMASKTYPE = imgTBKK;
                          ReportPDFwm3var.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '5') {
                        setState(() {
                          ReportPDFwm3var.SCMASKTYPE = imgGKN;
                          ReportPDFwm3var.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '6') {
                        setState(() {
                          ReportPDFwm3var.SCMASKTYPE = SIAMADVANCE;
                          ReportPDFwm3var.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '7') {
                        setState(() {
                          ReportPDFwm3var.SCMASKTYPE = NTN500T850T;
                          ReportPDFwm3var.SCMASKTYPEonTop = NTN500T850T;
                        });
                      } else {
                        setState(() {
                          ReportPDFwm3var.SCMASKTYPE = imgGeneral;
                          ReportPDFwm3var.SCMASKTYPEonTop = '';
                        });
                      }
                    },
                    value: ReportPDFwm3var.TYPE,
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
                  isContr: ReportPDFwm3var.iscontrol,
                  fnContr: (input) {
                    setState(() {
                      ReportPDFwm3var.iscontrol = input;
                    });
                  },
                  sPlaceholder: "Inspected By",
                  sValue: ReportPDFwm3var.SignInsBy,
                  returnfunc: (String s) {
                    setState(() {
                      ReportPDFwm3var.SignInsBy = s;
                    });
                  },
                ),
              ),
              const Spacer(),
              if (ReportPDFwm3var.PASS == "PASSED") ...[
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
                          ReportPDFwm3var.PO,
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
                            ReportPDFwm3var.PO,
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
                  P303QMMASTERQCVAR.SEARCH = ReportPDFwm3var.PO;
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
                  //ReportPDFwm3var.PO
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
                  //ReportPDFwm3var.PO
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

                      if (databuff[i]['PO'] == ReportPDFwm3var.PO) {
                        print(
                            databuff[i]['PO'] + ':' + databuff[i]['FG_CHARG']);
                        // print(databuff[i]);
                        ReportPDFwm3var.TPKLOTEDIT = databuff[i]['FG_CHARG'];
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
          //         isContr: ReportPDFwm3var.iscontrol,
          //         fnContr: (input) {
          //           setState(() {
          //             ReportPDFwm3var.iscontrol = input;
          //           });
          //         },
          //         // isEnabled: ReportPDFwm3var.canf,
          //         sValue: ReportPDFwm3var.remark,
          //         returnfunc: (String s) {
          //           setState(() {
          //             ReportPDFwm3var.remark = s;
          //           });
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: RepaintBoundary(
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
                            border: Border.all(color: Colors.black, width: 3),
                            // color: Colors.red,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(0)),
                          ),
                          child: Column(
                            children: [
                              headerreport(
                                CUSTOMER: ReportPDFwm3var.CUSTOMER,
                                PROCESS: ReportPDFwm3var.PROCESS,
                                PARTNAME: ReportPDFwm3var.PARTNAME,
                                PARTNO: ReportPDFwm3var.PARTNO,
                                CUSLOT: ReportPDFwm3var.CUSLOT,
                                TPKLOT: ReportPDFwm3var.TPKLOT,
                                MATERIAL: ReportPDFwm3var.MATERIAL,
                                QTY: ReportPDFwm3var.QTY,
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
                                    ReportPDFwm3var.INC01 != ''
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
                                    ReportPDFwm3var.INC01 != '' ? "Visual" : "",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget04: Center(
                                  child: Text(
                                    ReportPDFwm3var.INC01 != ''
                                        ? "10 pcs/rcv.Lot"
                                        : "",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget05: Center(
                                  child: Text(
                                    ReportPDFwm3var.INC01 != ''
                                        ? "No Rust"
                                        : "",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget06: Center(
                                  child: Text(
                                    ReportPDFwm3var.INC01 != ''
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
                                    ReportPDFwm3var.INC02 != ''
                                        ? "Appearance for scratch"
                                        : "",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget02: Center(
                                  child: Text(
                                    ReportPDFwm3var.INC02 != '' ? "" : "",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget03: Center(
                                  child: Text(
                                    ReportPDFwm3var.INC02 != '' ? "Visual" : "",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget04: Center(
                                  child: Text(
                                    ReportPDFwm3var.INC02 != ''
                                        ? "10 pcs/rcv.Lot"
                                        : "",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget05: Center(
                                  child: Text(
                                    ReportPDFwm3var.INC02 != ''
                                        ? "No Scratch"
                                        : "",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget06: Center(
                                  child: Text(
                                    ReportPDFwm3var.INC02 != ''
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
                                    ReportPDFwm3var.datalist[0].ITEMname,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget02: Center(
                                  child: ReportPDFwm3var.datalist[0].SCMARK ==
                                          'YES'
                                      ? PicShow(
                                          width: 42,
                                          height: 42,
                                          base64: ReportPDFwm3var.SCMASKTYPE)
                                      : const Text(
                                          "",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                ),
                                widget03: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[0].METHODname,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget04: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[0].FREQ,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget05: Center(
                                  child: Text(
                                    ReportPDFwm3var
                                        .datalist[0].SPECIFICATIONname,
                                    style: TextStyle(
                                      fontSize: ReportPDFwm3var.datalist[0]
                                                  .SPECIFICATIONname.length >
                                              30
                                          ? 12
                                          : 16,
                                    ),
                                  ),
                                ),
                                widget06: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[0].RESULT,
                                    style: TextStyle(
                                      fontSize: ReportPDFwm3var
                                                  .datalist[0].RESULT.length >
                                              30
                                          ? 12
                                          : 16,
                                    ),
                                  ),
                                ),
                                widget07: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[0].REMARK,
                                    style: TextStyle(
                                      fontSize: ReportPDFwm3var
                                                  .datalist[0].REMARK.length >
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
                                    ReportPDFwm3var.datalist[1].ITEMname,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget02: Center(
                                  child: ReportPDFwm3var.datalist[1].SCMARK ==
                                          'YES'
                                      ? PicShow(
                                          width: 42,
                                          height: 42,
                                          base64: ReportPDFwm3var.SCMASKTYPE)
                                      : const Text(
                                          "",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                ),
                                widget03: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[1].METHODname,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget04: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[1].FREQ,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget05: Center(
                                  child: Text(
                                    ReportPDFwm3var
                                        .datalist[1].SPECIFICATIONname,
                                    style: TextStyle(
                                      fontSize: ReportPDFwm3var.datalist[1]
                                                  .SPECIFICATIONname.length >
                                              30
                                          ? 12
                                          : 16,
                                    ),
                                  ),
                                ),
                                widget06: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[1].RESULT,
                                    style: TextStyle(
                                      fontSize: ReportPDFwm3var
                                                  .datalist[1].RESULT.length >
                                              30
                                          ? 12
                                          : 16,
                                    ),
                                  ),
                                ),
                                widget07: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[1].REMARK,
                                    style: TextStyle(
                                      fontSize: ReportPDFwm3var
                                                  .datalist[1].REMARK.length >
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
                                    ReportPDFwm3var.datalist[2].ITEMname,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget02: Center(
                                  child: ReportPDFwm3var.datalist[2].SCMARK ==
                                          'YES'
                                      ? PicShow(
                                          width: 42,
                                          height: 42,
                                          base64: ReportPDFwm3var.SCMASKTYPE)
                                      : const Text(
                                          "",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                ),
                                widget03: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[2].METHODname,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget04: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[2].FREQ,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget05: Center(
                                  child: Text(
                                    ReportPDFwm3var
                                        .datalist[2].SPECIFICATIONname,
                                    style: TextStyle(
                                      fontSize: ReportPDFwm3var.datalist[2]
                                                  .SPECIFICATIONname.length >
                                              30
                                          ? 12
                                          : 16,
                                    ),
                                  ),
                                ),
                                widget06: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[2].RESULT,
                                    style: TextStyle(
                                      fontSize: ReportPDFwm3var
                                                  .datalist[2].RESULT.length >
                                              30
                                          ? 12
                                          : 16,
                                    ),
                                  ),
                                ),
                                widget07: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[2].REMARK,
                                    style: TextStyle(
                                      fontSize: ReportPDFwm3var
                                                  .datalist[2].REMARK.length >
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
                                    ReportPDFwm3var.datalist[3].ITEMname,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget02: Center(
                                  child: ReportPDFwm3var.datalist[3].SCMARK ==
                                          'YES'
                                      ? PicShow(
                                          width: 42,
                                          height: 42,
                                          base64: ReportPDFwm3var.SCMASKTYPE)
                                      : const Text(
                                          "",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                ),
                                widget03: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[3].METHODname,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget04: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[3].FREQ,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget05: Center(
                                  child: Text(
                                    ReportPDFwm3var
                                        .datalist[3].SPECIFICATIONname,
                                    style: TextStyle(
                                      fontSize: ReportPDFwm3var.datalist[3]
                                                  .SPECIFICATIONname.length >
                                              30
                                          ? 12
                                          : 16,
                                    ),
                                  ),
                                ),
                                widget06: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[3].RESULT,
                                    style: TextStyle(
                                      fontSize: ReportPDFwm3var
                                                  .datalist[3].RESULT.length >
                                              30
                                          ? 12
                                          : 16,
                                    ),
                                  ),
                                ),
                                widget07: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[3].REMARK,
                                    style: TextStyle(
                                      fontSize: ReportPDFwm3var
                                                  .datalist[3].REMARK.length >
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
                                    ReportPDFwm3var.datalist[4].ITEMname,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget02: Center(
                                  child: ReportPDFwm3var.datalist[4].SCMARK ==
                                          'YES'
                                      ? PicShow(
                                          width: 42,
                                          height: 42,
                                          base64: ReportPDFwm3var.SCMASKTYPE)
                                      : const Text(
                                          "",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                ),
                                widget03: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[4].METHODname,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget04: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[4].FREQ,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget05: Center(
                                  child: Text(
                                    ReportPDFwm3var
                                        .datalist[4].SPECIFICATIONname,
                                    style: TextStyle(
                                      fontSize: ReportPDFwm3var.datalist[4]
                                                  .SPECIFICATIONname.length >
                                              30
                                          ? 12
                                          : 16,
                                    ),
                                  ),
                                ),
                                widget06: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[4].RESULT,
                                    style: TextStyle(
                                      fontSize: ReportPDFwm3var
                                                  .datalist[4].RESULT.length >
                                              30
                                          ? 12
                                          : 16,
                                    ),
                                  ),
                                ),
                                widget07: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[4].REMARK,
                                    style: TextStyle(
                                      fontSize: ReportPDFwm3var
                                                  .datalist[4].REMARK.length >
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
                                    ReportPDFwm3var.datalist[5].ITEMname,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget02: Center(
                                  child: ReportPDFwm3var.datalist[5].SCMARK ==
                                          'YES'
                                      ? PicShow(
                                          width: 42,
                                          height: 42,
                                          base64: ReportPDFwm3var.SCMASKTYPE)
                                      : const Text(
                                          "",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                ),
                                widget03: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[5].METHODname,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget04: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[5].FREQ,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                widget05: Center(
                                  child: Text(
                                    ReportPDFwm3var
                                        .datalist[5].SPECIFICATIONname,
                                    style: TextStyle(
                                      fontSize: ReportPDFwm3var.datalist[5]
                                                  .SPECIFICATIONname.length >
                                              30
                                          ? 12
                                          : 16,
                                    ),
                                  ),
                                ),
                                widget06: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[5].RESULT,
                                    style: TextStyle(
                                      fontSize: ReportPDFwm3var
                                                  .datalist[5].RESULT.length >
                                              30
                                          ? 12
                                          : 16,
                                    ),
                                  ),
                                ),
                                widget07: Center(
                                  child: Text(
                                    ReportPDFwm3var.datalist[5].REMARK,
                                    style: TextStyle(
                                      fontSize: ReportPDFwm3var
                                                  .datalist[5].REMARK.length >
                                              30
                                          ? 12
                                          : 16,
                                    ),
                                  ),
                                ),
                              ),
                              // BODY7SLOT(
                              //   ListFlex: [6, 1, 4, 2, 2, 2, 2],
                              //   widget01: Center(
                              //     child: Text(
                              //       ReportPDFwm3var.datalist[6].ITEMname,
                              //       style: const TextStyle(
                              //         fontSize: 16,
                              //       ),
                              //     ),
                              //   ),
                              //   widget02: Center(
                              //     child: ReportPDFwm3var.datalist[6].SCMARK ==
                              //             'YES'
                              //         ? PicShow(
                              //             width: 42,
                              //             height: 42,
                              //             base64: ReportPDFwm3var.SCMASKTYPE)
                              //         : const Text(
                              //             "",
                              //             style: TextStyle(
                              //               fontSize: 16,
                              //             ),
                              //           ),
                              //   ),
                              //   widget03: Center(
                              //     child: Text(
                              //       ReportPDFwm3var.datalist[6].METHODname,
                              //       style: const TextStyle(
                              //         fontSize: 16,
                              //       ),
                              //     ),
                              //   ),
                              //   widget04: Center(
                              //     child: Text(
                              //       ReportPDFwm3var.datalist[6].FREQ,
                              //       style: const TextStyle(
                              //         fontSize: 16,
                              //       ),
                              //     ),
                              //   ),
                              //   widget05: Center(
                              //     child: Text(
                              //       ReportPDFwm3var
                              //           .datalist[6].SPECIFICATIONname,
                              //       style: TextStyle(
                              //         fontSize: ReportPDFwm3var.datalist[6]
                              //                     .SPECIFICATIONname.length >
                              //                 30
                              //             ? 12
                              //             : 16,
                              //       ),
                              //     ),
                              //   ),
                              //   widget06: Center(
                              //     child: Text(
                              //       ReportPDFwm3var.datalist[6].RESULT,
                              //       style: TextStyle(
                              //         fontSize: ReportPDFwm3var
                              //                     .datalist[6].RESULT.length >
                              //                 30
                              //             ? 12
                              //             : 16,
                              //       ),
                              //     ),
                              //   ),
                              //   widget07: Center(
                              //     child: Text(
                              //       ReportPDFwm3var.datalist[7].REMARK,
                              //       style: TextStyle(
                              //         fontSize: ReportPDFwm3var
                              //                     .datalist[7].REMARK.length >
                              //                 30
                              //             ? 12
                              //             : 16,
                              //       ),
                              //     ),
                              //   ),
                              // ),
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      1
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[0].DATANO
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget03: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      2
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[1].DATANO
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget04: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      3
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[2].DATANO
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget05: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      4
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[3].DATANO
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget06: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      5
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[4].DATANO
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget07: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      6
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[5].DATANO
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget08: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      7
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[6].DATANO
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget09: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      8
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[7].DATANO
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget10: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      9
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[8].DATANO
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget11: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      10
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[9].DATANO
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget12: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      11
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      12
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      13
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      14
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      15
                                                  ? ReportPDFwm3var
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
                                              "POINT 1",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget02: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      1
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      2
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      3
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      4
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      5
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      6
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      7
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      8
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      9
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      10
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      11
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      12
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      13
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      14
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      15
                                                  ? ReportPDFwm3var
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
                                              "POINT 2",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget02: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      1
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      2
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      3
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      4
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      5
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      6
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      7
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      8
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      9
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      10
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      11
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      12
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      13
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      14
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      15
                                                  ? ReportPDFwm3var
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
                                              "POINT 3",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget02: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      1
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      2
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      3
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      4
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      5
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      6
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      7
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      8
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      9
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      10
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      11
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      12
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      13
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      14
                                                  ? ReportPDFwm3var
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
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      15
                                                  ? ReportPDFwm3var
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
                                              "Avg",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget02: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      1
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[0].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget03: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      2
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[1].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget04: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      3
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[2].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget05: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      4
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[3].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget06: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      5
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[4].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget07: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      6
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[5].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget08: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      7
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[6].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget09: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      8
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[7].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget10: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      9
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[8].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget11: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      10
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[9].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget12: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      11
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[10].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget13: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      12
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[11].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget14: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      13
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[12].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget15: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      14
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[13].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget16: Center(
                                            child: Text(
                                              ReportPDFwm3var.rawlistHardness
                                                          .length >=
                                                      15
                                                  ? ReportPDFwm3var
                                                      .rawlistHardness[14].DATA
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
                                  //             ReportPDFwm3var
                                  //                         .rawlistCORE.length >=
                                  //                     1
                                  //                 ? ReportPDFwm3var
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
                                  //             ReportPDFwm3var
                                  //                         .rawlistCORE.length >=
                                  //                     1
                                  //                 ? ReportPDFwm3var
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
                                  //         //     ReportPDFwm3var
                                  //         //                 .rawlistCORE.length >=
                                  //         //             2
                                  //         //         ? ReportPDFwm3var
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
                                  //         //     ReportPDFwm3var
                                  //         //                 .rawlistCORE.length >=
                                  //         //             3
                                  //         //         ? ReportPDFwm3var
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
                                  //         //     ReportPDFwm3var
                                  //         //                 .rawlistCORE.length >=
                                  //         //             4
                                  //         //         ? ReportPDFwm3var
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
                                  //         //     ReportPDFwm3var
                                  //         //                 .rawlistCORE.length >=
                                  //         //             5
                                  //         //         ? ReportPDFwm3var
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
                                  //             ReportPDFwm3var
                                  //                         .rawlistCORE.length >=
                                  //                     1
                                  //                 ? ReportPDFwm3var
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
                                  //         //     ReportPDFwm3var
                                  //         //                 .rawlistCORE.length >=
                                  //         //             2
                                  //         //         ? ReportPDFwm3var
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
                                  //         //     ReportPDFwm3var
                                  //         //                 .rawlistCORE.length >=
                                  //         //             3
                                  //         //         ? ReportPDFwm3var
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
                                  //         //     ReportPDFwm3var
                                  //         //                 .rawlistCORE.length >=
                                  //         //             4
                                  //         //         ? ReportPDFwm3var
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
                                  //         //     ReportPDFwm3var
                                  //         //                 .rawlistCORE.length >=
                                  //         //             5
                                  //         //         ? ReportPDFwm3var
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
                                PIC01: _dataCOMMON.databasic.PIC01,
                                PIC02: _dataCOMMON.databasic.PIC02 == wpic
                                    ? _dataCOMMON.databasic.PIC03
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
                                              color: Colors.black, width: 3),
                                        ),
                                        child: ReportPDFwm3var
                                                .graphdata.isNotEmpty
                                            ? ControlChart01(
                                                upper:
                                                    ReportPDFwm3var.graphupper,
                                                data: ReportPDFwm3var.graphdata,
                                                data2:
                                                    ReportPDFwm3var.graphdata2,
                                                data3:
                                                    ReportPDFwm3var.graphdata3,
                                                data4:
                                                    ReportPDFwm3var.graphdata4,
                                                under:
                                                    ReportPDFwm3var.graphunder,
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  1
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  2
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  3
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  4
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  5
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  6
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  7
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  8
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  9
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  10
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  11
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  12
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  13
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  14
                                              ? ReportPDFwm3var
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
                                          // ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  1
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  2
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  3
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  4
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  5
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  6
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  7
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  8
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  9
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  10
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  11
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  12
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  13
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraph.length >=
                                                  14
                                              ? ReportPDFwm3var
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
                                          ReportPDFwm3var.rawlistGraphCore.DATA,
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
                                PASS: ReportPDFwm3var.PASS,
                                PICS: _dataCOMMON.databasic.PICstd,
                                Remark: ReportPDFwm3var.remark,
                                NAME01: ReportPDFwm3var.SignInsBy,
                                NAME02: "",
                                NAME03: "",
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
              print("00" + ReportPDFwm3var.PO);
              Dio().post(
                "${server2}10GETDATAFROMJOBBINGAQC/QCFN",
                // "${'http://127.0.0.1:14094/'}10GETDATAFROMJOBBINGAQC/QCFN",
                data: {
                  "BAPI_NAME": "ZFMPPQCFN_IN",
                  "ORDERID": ReportPDFwm3var.PO,
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
