import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/cubit/NotificationEvent.dart';
import '../../Layout/head.dart';
import '../../bloc/Cubit/31-ReportPDFCommoncubit.dart';
import '../../bloc/Cubit/32-Reportset.dart';
import '../../data/CommonTestData.dart';
import '../../data/global.dart';
import '../../widget/GRAPH/LineGraph01.dart';
import '../../widget/GRAPH/LineGraphCONTROL.dart';
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
import '../../widget/common/popup.dart';
import '../../widget/function/helper.dart';
import '../P303QMMASTERQC/P303QMMASTERQCVAR.dart';
import '../page303.dart';
import 'ReportPDFCommonvar.dart';

late BuildContext ReportPDFCommoncontext;

class ReportPDFCommon extends StatefulWidget {
  ReportPDFCommon({
    Key? key,
    this.dataCommon,
  }) : super(key: key);
  CommonReportOutput? dataCommon;
  @override
  State<ReportPDFCommon> createState() => _ReportPDFCommonState();
}

class _ReportPDFCommonState extends State<ReportPDFCommon> {
  @override
  void initState() {
    ReportPDFCommonvar.TPKLOTEDIT = '';
    print("ma rel");
    if (ReportPDFCommonvar.PO != '') {
      ReportPDFCommonvar.canf = false;
      context
          .read<ReportPDFCommon_Cubit>()
          .ReportPDFCommonCubit(ReportPDFCommonvar.PO, "");
    }
    super.initState();
  }

  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ReportPDFCommoncontext = context;

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
      ReportPDFCommonvar.STATUS = 'REPORT READY';
      ReportPDFCommonvar.CUSTOMER = _dataCOMMON.databasic.CUSTOMER;
      ReportPDFCommonvar.PROCESS = _dataCOMMON.databasic.PROCESS;
      ReportPDFCommonvar.PARTNAME = _dataCOMMON.databasic.PARTNAME;
      ReportPDFCommonvar.PARTNO = _dataCOMMON.databasic.PARTNO;
      ReportPDFCommonvar.PARTNO_s = _dataCOMMON.databasic.PARTNO_s;
      ReportPDFCommonvar.CUSLOT = _dataCOMMON.databasic.CUSLOT;
      ReportPDFCommonvar.TPKLOT = _dataCOMMON.databasic.TPKLOT;
      ReportPDFCommonvar.MATERIAL = _dataCOMMON.databasic.MATERIAL;
      if (_dataCOMMON.databasic.UNITSAP.toUpperCase() != 'KG') {
        ReportPDFCommonvar.QTY =
            '${double.parse(ConverstStr(_dataCOMMON.databasic.QTY)).toStringAsFixed(0)} ${_dataCOMMON.databasic.UNITSAP}';
      } else {
        ReportPDFCommonvar.QTY =
            '${double.parse(ConverstStr(_dataCOMMON.databasic.QTY)).toStringAsFixed(1)} ${_dataCOMMON.databasic.UNITSAP}';
      }

      ReportPDFCommonvar.PIC01 = _dataCOMMON.databasic.PIC01;
      ReportPDFCommonvar.PIC02 = _dataCOMMON.databasic.PIC02;
      ReportPDFCommonvar.PICstd = _dataCOMMON.databasic.PICstd;

      ReportPDFCommonvar.PASS = _dataCOMMON.databasic.PASS;
      ReportPDFCommonvar.remark = _dataCOMMON.databasic.remark;
      print("--->" + ReportPDFCommonvar.remark);
      if (_dataCOMMON.databasic.PARTNAMEref != '') {
        ReportPDFCommonvar.remark =
            'Reference data from\n${_dataCOMMON.databasic.PARTNAMEref}\n${_dataCOMMON.databasic.PARTref}';
      }

      ReportPDFCommonvar.INC01 = _dataCOMMON.databasic.INC01;
      ReportPDFCommonvar.INC02 = _dataCOMMON.databasic.INC02;
//remark

      // print(_dataCOMMON.datain[0]);
      // print(_dataCOMMON.datain.length);
      ReportPDFCommonvar.rawlistHardness = [];
      ReportPDFCommonvar.rawlistCompound = [];
      ReportPDFCommonvar.rawlistRoughness = [];
      ReportPDFCommonvar.rawlistCORE = [];

      ReportPDFCommonvar.graphupper = [];
      ReportPDFCommonvar.graphdata = [];
      ReportPDFCommonvar.graphdata2 = [];
      ReportPDFCommonvar.graphdata3 = [];
      ReportPDFCommonvar.graphdata4 = [];
      ReportPDFCommonvar.graphunder = [];
      ReportPDFCommonvar.GTC = '';

      for (var i = 0; i < _dataCOMMON.datain.length; i++) {
        String Loadin = '';
        if (_dataCOMMON.datain[i].LOAD != '' &&
            _dataCOMMON.datain[i].LOAD != '-') {
          Loadin = "( Load ${_dataCOMMON.datain[i].LOAD} )";
        }
        ReportPDFCommonvar.datalist[i].ITEMname =
            " ${_dataCOMMON.datain[i].ITEMname} ${Loadin}";
        ReportPDFCommonvar.datalist[i].SCMARK = _dataCOMMON.datain[i].SCMARK;
        ReportPDFCommonvar.datalist[i].METHODname =
            _dataCOMMON.datain[i].METHODname;
        ReportPDFCommonvar.datalist[i].FREQ = _dataCOMMON.datain[i].FREQ;
        ReportPDFCommonvar.datalist[i].SPECIFICATIONname =
            _dataCOMMON.datain[i].SPECIFICATION;
        ReportPDFCommonvar.datalist[i].RESULT = _dataCOMMON.datain[i].RESULT;
        ReportPDFCommonvar.datalist[i].REMARK = _dataCOMMON.datain[i].Remark;
        //print(ReportPDFCommonvar.datalist[i].RESULT.length);
        //Surface Hardness

        if (_dataCOMMON.datain[i].TYPE == 'Number') {
          if (_dataCOMMON.datain[i].SRAWDATA != 'NO') {
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
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
                    DATANO: HardnessNO.toString(),
                    DATAPCS: '1',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA01,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 2) {
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
                    DATANO: HardnessNO.toString(),
                    DATAPCS: '2',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA02,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 3) {
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
                    DATANO: HardnessNO.toString(),
                    DATAPCS: '3',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA03,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 4) {
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
                    DATANO: HardnessNO.toString(),
                    DATAPCS: '4',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA04,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 5) {
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
                    DATANO: HardnessNO.toString(),
                    DATAPCS: '5',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA05,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 6) {
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
                    DATANO: HardnessNO.toString(),
                    DATAPCS: '6',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA06,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 7) {
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
                    DATANO: HardnessNO.toString(),
                    DATAPCS: '7',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA07,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 8) {
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
                    DATANO: HardnessNO.toString(),
                    DATAPCS: '8',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA08,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 9) {
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
                    DATANO: HardnessNO.toString(),
                    DATAPCS: '9',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA09,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 10) {
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
                    DATANO: HardnessNO.toString(),
                    DATAPCS: '10',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA10,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 11) {
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
                    DATANO: HardnessNO.toString(),
                    DATAPCS: '11',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA11,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 12) {
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
                    DATANO: HardnessNO.toString(),
                    DATAPCS: '12',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA12,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 13) {
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
                    DATANO: HardnessNO.toString(),
                    DATAPCS: '13',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA13,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 14) {
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
                    DATANO: HardnessNO.toString(),
                    DATAPCS: '14',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA14,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 15) {
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
                    DATANO: HardnessNO.toString(),
                    DATAPCS: '15',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA15,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 16) {
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
                    DATANO: HardnessNO.toString(),
                    DATAPCS: '16',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA16,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 17) {
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
                    DATANO: HardnessNO.toString(),
                    DATAPCS: '17',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA17,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 18) {
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
                    DATANO: HardnessNO.toString(),
                    DATAPCS: '18',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA18,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 19) {
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
                    DATANO: HardnessNO.toString(),
                    DATAPCS: '19',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA19,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 20) {
                  ReportPDFCommonvar.rawlistHardness.add(rawlist(
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
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '1',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA01,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 2) {
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '2',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA02,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 3) {
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '3',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA03,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 4) {
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '4',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA04,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 5) {
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '5',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA05,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 6) {
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '6',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA06,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 7) {
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '7',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA07,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 8) {
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '8',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA08,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 9) {
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '9',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA09,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 10) {
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '10',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA10,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 11) {
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '11',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA11,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 12) {
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '12',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA12,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 13) {
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '13',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA13,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 14) {
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '14',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA14,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 15) {
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '15',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA15,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 16) {
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '16',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA16,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 17) {
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '17',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA17,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 18) {
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '18',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA18,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 19) {
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '19',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA19,
                  ));
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 20) {
                  ReportPDFCommonvar.rawlistCORE.add(rawlist(
                    DATANO: CoreNO.toString(),
                    DATAPCS: '20',
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA20,
                  ));
                }
                CoreNO++;
                // print('>>${CoreNO}');
              }
            }
          }
          //  CoreNO++;
        }

        if (_dataCOMMON.datain[i].TYPE == 'Graph') {
          ReportPDFCommonvar.rawlistGraph = [];
          ReportPDFCommonvar.GTC = _dataCOMMON.datain[i].GTC;

          ReportPDFCommonvar.lower = _dataCOMMON.datain[i].lower;
          ReportPDFCommonvar.upper = _dataCOMMON.datain[i].upper;

          print('GTC>' + ReportPDFCommonvar.GTC);
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
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA01p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA01,
                ));

                ReportPDFCommonvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA01p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA01))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 2) {
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA02p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA02,
                ));

                ReportPDFCommonvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA02p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA02))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 3) {
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA03p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA03,
                ));

                ReportPDFCommonvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA03p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA03))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 4) {
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA04p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA04,
                ));

                ReportPDFCommonvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA04p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA04))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 5) {
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA05p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA05,
                ));

                ReportPDFCommonvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA05p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA05))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 6) {
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA06p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA06,
                ));

                ReportPDFCommonvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA06p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA06))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 7) {
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA07p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA07,
                ));

                ReportPDFCommonvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA07p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA07))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 8) {
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA08p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA08,
                ));

                ReportPDFCommonvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA08p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA08))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 9) {
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA09p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA09,
                ));

                ReportPDFCommonvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA09p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA09))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 10) {
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA10p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA10,
                ));

                ReportPDFCommonvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA10p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA10))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 11) {
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA11p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA11,
                ));

                ReportPDFCommonvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA11p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA11))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 12) {
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA12p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA12,
                ));

                ReportPDFCommonvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA12p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA12))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 13) {
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA13p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA13,
                ));

                ReportPDFCommonvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA13p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA13))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 14) {
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA14p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA14,
                ));

                ReportPDFCommonvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA14p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA14))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 15) {
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA15p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA15,
                ));

                ReportPDFCommonvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA15p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA15))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 16) {
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA16p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA16,
                ));

                ReportPDFCommonvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA16p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA16))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 17) {
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA17p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA17,
                ));

                ReportPDFCommonvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA17p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA17))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 18) {
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA18p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA18,
                ));

                ReportPDFCommonvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA18p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA18))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 19) {
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA19p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA19,
                ));

                ReportPDFCommonvar.graphdata.add(
                  FlSpot(
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA19p)),
                      double.parse(ConverstStr(
                          _dataCOMMON.datain[i].datapackset[li].DATA19))),
                );
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 20) {
                ReportPDFCommonvar.rawlistGraph.add(rawlist(
                  DATANO: GraphNO.toString(),
                  DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA20p,
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA20,
                ));

                ReportPDFCommonvar.graphdata.add(
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

          // ReportPDFCommonvar.rawlistGraphCore = rawlist(
          //   DATAPCS: "Core",
          //   DATA: ReportPDFCommonvar
          //       .rawlistGraph[ReportPDFCommonvar.rawlistGraph.length - 1].DATA,
          // );
          // print(">>>${ReportPDFCommonvar.rawlistGraph.length}");
          // ReportPDFCommonvar.rawlistGraph.removeLast();
          if (ReportPDFCommonvar.rawlistGraph.length > 2) {
            ReportPDFCommonvar.rawlistGraphCore = rawlist(
              DATAPCS: "Core",
              DATA: ReportPDFCommonvar
                  .rawlistGraph[ReportPDFCommonvar.rawlistGraph.length - 1]
                  .DATA,
            );
            // print(">>>${ReportPDFCommonvar.rawlistGraph.length}");

            ReportPDFCommonvar.rawlistGraph
                .removeAt(ReportPDFCommonvar.rawlistGraph.length - 1);
          }

          ReportPDFCommonvar.graphupper = [
            FlSpot(ReportPDFCommonvar.graphdata[0].x, 1000),
            FlSpot(
                ReportPDFCommonvar
                    .graphdata[ReportPDFCommonvar.graphdata.length - 2].x,
                1000)
          ];

          ReportPDFCommonvar.graphdata2 = [
            FlSpot(ReportPDFCommonvar.graphdata[0].x,
                double.parse(ConverstStr(_dataCOMMON.datain[i].Cross))),
            FlSpot(double.parse(ConverstStr(_dataCOMMON.datain[i].RESULT)),
                double.parse(ConverstStr(_dataCOMMON.datain[i].Cross)))
          ];

          ReportPDFCommonvar.graphdata3 = [
            FlSpot(double.parse(ConverstStr(_dataCOMMON.datain[i].RESULT)),
                double.parse(ConverstStr(_dataCOMMON.datain[i].Cross))),
            FlSpot(double.parse(ConverstStr(_dataCOMMON.datain[i].RESULT)), 0)
          ];

          ReportPDFCommonvar.graphdata4 = [
            FlSpot(ReportPDFCommonvar.graphdata[0].x, 1000),
            FlSpot(ReportPDFCommonvar.graphdata[0].x, 0)
          ];

          ReportPDFCommonvar.graphunder = [
            FlSpot(ReportPDFCommonvar.graphdata[0].x, 0),
            FlSpot(
                ReportPDFCommonvar
                    .graphdata[ReportPDFCommonvar.graphdata.length - 2].x,
                0)
          ];
        }

        if (ReportPDFCommonvar.graphupper.length > 1) {
          ReportPDFCommonvar.graphupper;
        }

        if (ReportPDFCommonvar.graphdata2.length > 1) {
          ReportPDFCommonvar.graphdata2;
        }
        if (ReportPDFCommonvar.graphdata3.length > 1) {
          ReportPDFCommonvar.graphdata3;
        }
        if (ReportPDFCommonvar.graphdata4.length > 1) {
          ReportPDFCommonvar.graphdata4;
        }
        if (ReportPDFCommonvar.graphunder.length > 1) {
          ReportPDFCommonvar.graphunder;
        }

        //Compound Layer

        // Roughness
      }
      if (ReportPDFCommonvar.graphdata.length > 1) {
        ReportPDFCommonvar.graphdata.removeLast();
        //     .removeAt(ReportPDFCommonvar.graphdata.length - 1);
      }

      // print(ReportPDFCommonvar.datalist);
    } else {
      ReportPDFCommonvar.STATUS = 'WATTING or NO-DATA';

      ReportPDFCommonvar.CUSTOMER = '';
      ReportPDFCommonvar.PROCESS = '';
      ReportPDFCommonvar.PARTNAME = '';
      ReportPDFCommonvar.PARTNO = '';
      ReportPDFCommonvar.PARTNO_s = '';
      ReportPDFCommonvar.CUSLOT = '';
      ReportPDFCommonvar.TPKLOT = '';
      ReportPDFCommonvar.MATERIAL = '';
      ReportPDFCommonvar.QTY = '';

      ReportPDFCommonvar.PICstd = '';
      ReportPDFCommonvar.PIC01 = '';
      ReportPDFCommonvar.PIC02 = '';

      ReportPDFCommonvar.rawlistHardness = [];
      ReportPDFCommonvar.rawlistCompound = [];
      ReportPDFCommonvar.rawlistRoughness = [];
      ReportPDFCommonvar.rawlistCORE = [];
      ReportPDFCommonvar.INC01 = '';
      ReportPDFCommonvar.INC02 = '';

      ReportPDFCommonvar.datalist = [
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

      ReportPDFCommonvar.rawlistGraphCore = rawlist();

      ReportPDFCommonvar.rawlistGraph = [];
      ReportPDFCommonvar.graphupper = [];
      ReportPDFCommonvar.graphdata = [];
      ReportPDFCommonvar.graphdata2 = [];
      ReportPDFCommonvar.graphdata3 = [];
      ReportPDFCommonvar.graphdata4 = [];
      ReportPDFCommonvar.graphunder = [];
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
                  isContr: ReportPDFCommonvar.iscontrol,
                  fnContr: (input) {
                    setState(() {
                      ReportPDFCommonvar.iscontrol = input;
                    });
                  },
                  isEnabled: ReportPDFCommonvar.canf,
                  sValue: ReportPDFCommonvar.PO,
                  returnfunc: (String s) {
                    ReportPDFCommonvar.PO = s;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: () {
                    if (ReportPDFCommonvar.PO != '') {
                      context
                          .read<ReportPDFCommon_Cubit>()
                          .ReportPDFCommonCubit(ReportPDFCommonvar.PO, "cov");
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
                    ReportPDFCommonvar.canf = true;
                    ReportPDFCommonvar.iscontrol = true;
                    ReportPDFCommonvar.PO = '';
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
                  if (ReportPDFCommonvar.HIDEDATAPIC) {
                    ReportPDFCommonvar.HIDEDATAPIC = false;
                  } else {
                    ReportPDFCommonvar.HIDEDATAPIC = true;
                  }
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(
                    color: ReportPDFCommonvar.STATUS == 'REPORT READY'
                        ? Colors.green
                        : Colors.yellow,
                    height: 40,
                    width: 200,
                    child: Center(
                      child: Text(ReportPDFCommonvar.STATUS),
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
                      ReportPDFCommonvar.TYPE = d;
                      if (d == '1') {
                        setState(() {
                          ReportPDFCommonvar.SCMASKTYPE = imgGeneral;
                          ReportPDFCommonvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '2') {
                        setState(() {
                          ReportPDFCommonvar.SCMASKTYPE = imgJTEKT;
                          ReportPDFCommonvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '3') {
                        setState(() {
                          ReportPDFCommonvar.SCMASKTYPE = imgNTN;
                          ReportPDFCommonvar.SCMASKTYPEonTop = imgNTNonH;
                        });
                      } else if (d == '4') {
                        setState(() {
                          ReportPDFCommonvar.SCMASKTYPE = imgTBKK;
                          ReportPDFCommonvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '5') {
                        setState(() {
                          ReportPDFCommonvar.SCMASKTYPE = imgGKN;
                          ReportPDFCommonvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '6') {
                        setState(() {
                          ReportPDFCommonvar.SCMASKTYPE = SIAMADVANCE;
                          ReportPDFCommonvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '7') {
                        setState(() {
                          ReportPDFCommonvar.SCMASKTYPE = NTN500T850T;
                          ReportPDFCommonvar.SCMASKTYPEonTop = NTN500T850T;
                        });
                      } else {
                        setState(() {
                          ReportPDFCommonvar.SCMASKTYPE = imgGeneral;
                          ReportPDFCommonvar.SCMASKTYPEonTop = '';
                        });
                      }
                    },
                    value: ReportPDFCommonvar.TYPE,
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
                  isContr: ReportPDFCommonvar.iscontrol,
                  fnContr: (input) {
                    setState(() {
                      ReportPDFCommonvar.iscontrol = input;
                    });
                  },
                  sPlaceholder: "Inspected By",
                  sValue: ReportPDFCommonvar.SignInsBy,
                  returnfunc: (String s) {
                    setState(() {
                      ReportPDFCommonvar.SignInsBy = s;
                    });
                  },
                ),
              ),
              const Spacer(),
              // if (ReportPDFCommonvar.PASS == "PASSED") ...[
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
                        ReportPDFCommonvar.PO,
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
              // ] else ...[
              //   if (USERDATA.UserLV > 5 &&
              //       _dataCOMMON.databasic.USER_STATUS == 'QCFN') ...[
              //     Padding(
              //       padding: const EdgeInsets.all(3.0),
              //       child: InkWell(
              //         onTap: () {
              //           PDFloader(context);
              //           Future.delayed(const Duration(milliseconds: 1000), () {
              //             // capture(
              //             captureToback(
              //               // capture(
              //               _globalKey,
              //               ReportPDFCommonvar.PO,
              //             ).then((value) {
              //               print(value);

              //               Navigator.pop(context);
              //             });
              //           });
              //         },
              //         child: Container(
              //           color: Colors.yellow,
              //           height: 50,
              //           width: 100,
              //           child: const Center(
              //             child: Text("Print"),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ]
              // ],
            ],
          ),
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: InkWell(
                onTap: () {
                  P303QMMASTERQCVAR.SETDAY = 'OK';
                  P303QMMASTERQCVAR.SEARCH = ReportPDFCommonvar.PO;
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
                  //ReportPDFCommonvar.PO
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
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: SizedBox(
                        height: 40,
                        width: 150,
                        child: AdvanceDropDown(
                          imgpath: 'assets/icons/icon-down_4@3x.png',
                          listdropdown: const [
                            MapEntry("", ""),
                            MapEntry("-", "-"),
                            MapEntry("GAS-HMV-001", "GAS-HMV-001"),
                            MapEntry("GAS-HMV-002", "GAS-HMV-002"),
                            MapEntry("GAS-HMV-003", "GAS-HMV-003"),
                          ],
                          onChangeinside: (d, v) {
                            // print(d);
                            ReportPDFCommonvar.INSG = d;
                          },
                          value: ReportPDFCommonvar.INSG,
                          height: 40,
                          width: 150,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: InkWell(
                        onTap: () {
                          //ReportPDFCommonvar.PO

                          Dio().post(
                            "${GLOserver}GRAPH-recal",
                            data: {
                              "PO": ReportPDFCommonvar.PO,
                              "ITEMs": "ITEMs-5f19aaa2fe12be0020dbd3c2",
                              "MODE": "CDE",
                              "NAME_INS": ReportPDFCommonvar.INSG,
                              "INTERSEC": ""
                            },
                          ).then((v) {
                            //
                            if (v.data == 'OK1') {
                              WORNINGpop(context, ["", "OK", ""], 140, 200);

                              context
                                  .read<ReportPDFCommon_Cubit>()
                                  .ReportPDFCommonCubit(
                                      ReportPDFCommonvar.PO, "");
                            } else {
                              WORNINGpop(
                                  context, ["", "No this INS", ""], 140, 200);
                            }
                          });
                        },
                        child: Container(
                          color: Colors.orange,
                          height: 50,
                          width: 100,
                          child: const Center(
                            child: Text("Re Graph"),
                          ),
                        ),
                      ),
                    ),
                  ],
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
          //         isContr: ReportPDFCommonvar.iscontrol,
          //         fnContr: (input) {
          //           setState(() {
          //             ReportPDFCommonvar.iscontrol = input;
          //           });
          //         },
          //         // isEnabled: ReportPDFCommonvar.canf,
          //         sValue: ReportPDFCommonvar.remark,
          //         returnfunc: (String s) {
          //           setState(() {
          //             ReportPDFCommonvar.remark = s;
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
                                    CUSTOMER: ReportPDFCommonvar.CUSTOMER,
                                    PROCESS: ReportPDFCommonvar.PROCESS,
                                    PARTNAME: ReportPDFCommonvar.PARTNAME,
                                    PARTNO:
                                        ReportPDFCommonvar.PARTNO.contains("|")
                                            ? ReportPDFCommonvar.PARTNO
                                                .split("|")[1]
                                            : ReportPDFCommonvar.PARTNO == ''
                                                ? ReportPDFCommonvar.PARTNO_s
                                                : ReportPDFCommonvar.PARTNO,
                                    CUSLOT: ReportPDFCommonvar.CUSLOT,
                                    TPKLOT: ReportPDFCommonvar.TPKLOT,
                                    MATERIAL: ReportPDFCommonvar.MATERIAL,
                                    QTY: ReportPDFCommonvar.QTY,
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
                                        ReportPDFCommonvar.INC01 != ''
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
                                        ReportPDFCommonvar.INC01 != ''
                                            ? "Visual"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFCommonvar.INC01 != ''
                                            ? "10 pcs/rcv.Lot"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFCommonvar.INC01 != ''
                                            ? "No Rust"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFCommonvar.INC01 != ''
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
                                        ReportPDFCommonvar.INC02 != ''
                                            ? "Appearance for scratch"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: Text(
                                        ReportPDFCommonvar.INC02 != ''
                                            ? ""
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFCommonvar.INC02 != ''
                                            ? "Visual"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFCommonvar.INC02 != ''
                                            ? "10 pcs/rcv.Lot"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFCommonvar.INC02 != ''
                                            ? "No Scratch"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDFCommonvar.INC02 != ''
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
                                        ReportPDFCommonvar.datalist[0].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFCommonvar
                                                  .datalist[0].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFCommonvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFCommonvar
                                            .datalist[0].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFCommonvar.datalist[0].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFCommonvar
                                            .datalist[0].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
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
                                        ReportPDFCommonvar.datalist[0].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
                                                      .datalist[0]
                                                      .RESULT
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFCommonvar.datalist[0].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
                                                      .datalist[0]
                                                      .REMARK
                                                      .length >
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
                                        ReportPDFCommonvar.datalist[1].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFCommonvar
                                                  .datalist[1].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFCommonvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFCommonvar
                                            .datalist[1].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFCommonvar.datalist[1].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFCommonvar
                                            .datalist[1].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
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
                                        ReportPDFCommonvar.datalist[1].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
                                                      .datalist[1]
                                                      .RESULT
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFCommonvar.datalist[1].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
                                                      .datalist[1]
                                                      .REMARK
                                                      .length >
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
                                        ReportPDFCommonvar.datalist[2].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFCommonvar
                                                  .datalist[2].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFCommonvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFCommonvar
                                            .datalist[2].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFCommonvar.datalist[2].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFCommonvar
                                            .datalist[2].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
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
                                        ReportPDFCommonvar.datalist[2].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
                                                      .datalist[2]
                                                      .RESULT
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFCommonvar.datalist[2].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
                                                      .datalist[2]
                                                      .REMARK
                                                      .length >
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
                                        ReportPDFCommonvar.datalist[3].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFCommonvar
                                                  .datalist[3].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFCommonvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFCommonvar
                                            .datalist[3].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFCommonvar.datalist[3].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFCommonvar
                                            .datalist[3].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
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
                                        ReportPDFCommonvar.datalist[3].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
                                                      .datalist[3]
                                                      .RESULT
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFCommonvar.datalist[3].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
                                                      .datalist[3]
                                                      .REMARK
                                                      .length >
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
                                        ReportPDFCommonvar.datalist[4].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFCommonvar
                                                  .datalist[4].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFCommonvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFCommonvar
                                            .datalist[4].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFCommonvar.datalist[4].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFCommonvar
                                            .datalist[4].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
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
                                        ReportPDFCommonvar.datalist[4].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
                                                      .datalist[4]
                                                      .RESULT
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFCommonvar.datalist[4].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
                                                      .datalist[4]
                                                      .REMARK
                                                      .length >
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
                                        ReportPDFCommonvar.datalist[5].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFCommonvar
                                                  .datalist[5].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFCommonvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFCommonvar
                                            .datalist[5].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFCommonvar.datalist[5].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFCommonvar
                                            .datalist[5].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
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
                                        ReportPDFCommonvar.datalist[5].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
                                                      .datalist[5]
                                                      .RESULT
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFCommonvar.datalist[5].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
                                                      .datalist[5]
                                                      .REMARK
                                                      .length >
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
                                        ReportPDFCommonvar.datalist[6].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDFCommonvar
                                                  .datalist[6].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDFCommonvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDFCommonvar
                                            .datalist[6].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDFCommonvar.datalist[6].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDFCommonvar
                                            .datalist[6].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
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
                                        ReportPDFCommonvar.datalist[6].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
                                                      .datalist[6]
                                                      .RESULT
                                                      .length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDFCommonvar.datalist[7].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDFCommonvar
                                                      .datalist[7]
                                                      .REMARK
                                                      .length >
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          1
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          2
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          3
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          4
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          5
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          6
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          7
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          8
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          9
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          10
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          11
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          12
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          13
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          14
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          15
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          1
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          2
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          3
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          4
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          5
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          6
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          7
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          8
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          9
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          10
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          11
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          12
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          13
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          14
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          15
                                                      ? ReportPDFCommonvar
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
                                                  "Surface Hardness",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              widget02: Center(
                                                child: Text(
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          1
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          2
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          3
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          4
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          5
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          6
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          7
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          8
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          9
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          10
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          11
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          12
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          13
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          14
                                                      ? ReportPDFCommonvar
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
                                                  ReportPDFCommonvar
                                                              .rawlistHardness
                                                              .length >=
                                                          15
                                                      ? ReportPDFCommonvar
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
                                      //             ReportPDFCommonvar
                                      //                         .rawlistCORE.length >=
                                      //                     1
                                      //                 ? ReportPDFCommonvar
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
                                      //             ReportPDFCommonvar
                                      //                         .rawlistCORE.length >=
                                      //                     1
                                      //                 ? ReportPDFCommonvar
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
                                      //         //     ReportPDFCommonvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             2
                                      //         //         ? ReportPDFCommonvar
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
                                      //         //     ReportPDFCommonvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             3
                                      //         //         ? ReportPDFCommonvar
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
                                      //         //     ReportPDFCommonvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             4
                                      //         //         ? ReportPDFCommonvar
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
                                      //         //     ReportPDFCommonvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             5
                                      //         //         ? ReportPDFCommonvar
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
                                      //             ReportPDFCommonvar
                                      //                         .rawlistCORE.length >=
                                      //                     1
                                      //                 ? ReportPDFCommonvar
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
                                      //         //     ReportPDFCommonvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             2
                                      //         //         ? ReportPDFCommonvar
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
                                      //         //     ReportPDFCommonvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             3
                                      //         //         ? ReportPDFCommonvar
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
                                      //         //     ReportPDFCommonvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             4
                                      //         //         ? ReportPDFCommonvar
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
                                      //         //     ReportPDFCommonvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             5
                                      //         //         ? ReportPDFCommonvar
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
                                    PIC01: ReportPDFCommonvar.HIDEDATAPIC
                                        ? ""
                                        : _dataCOMMON.databasic.PIC01,
                                    PIC02: ReportPDFCommonvar.HIDEDATAPIC
                                        ? ""
                                        : _dataCOMMON.databasic.PIC02,
                                    widget01: Column(
                                      children: [
                                        if (ReportPDFCommonvar.GTC == '' ||
                                            ReportPDFCommonvar.GTC == '-') ...[
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
                                              child: ReportPDFCommonvar
                                                      .graphdata.isNotEmpty
                                                  ? ControlChart01(
                                                      upper: ReportPDFCommonvar
                                                          .graphupper,
                                                      data: ReportPDFCommonvar
                                                          .graphdata,
                                                      data2: ReportPDFCommonvar
                                                          .graphdata2,
                                                      data3: ReportPDFCommonvar
                                                          .graphdata3,
                                                      data4: ReportPDFCommonvar
                                                          .graphdata4,
                                                      under: ReportPDFCommonvar
                                                          .graphunder,
                                                    )
                                                  : SizedBox(
                                                      height: 320,
                                                      width: 2000,
                                                    ),
                                            ),
                                          ),
                                        ] else ...[
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
                                              child: ReportPDFCommonvar
                                                      .graphdata.isNotEmpty
                                                  ? LineGraphCONTROL(
                                                      upper: ReportPDFCommonvar
                                                          .graphupper,
                                                      data: ReportPDFCommonvar
                                                          .graphdata,
                                                      data2: ReportPDFCommonvar
                                                          .graphdata2,
                                                      data3: ReportPDFCommonvar
                                                          .graphdata3,
                                                      data4: ReportPDFCommonvar
                                                          .graphdata4,
                                                      under: ReportPDFCommonvar
                                                          .graphunder,
                                                      //----------------------
                                                      // data_2: ReportPDFCommonvar
                                                      //     .graphdataS,
                                                      // data_2: [
                                                      //   FlSpot(0.1, 800),
                                                      //   // FlSpot(0.2, 750),
                                                      //   FlSpot(0.3, 780),
                                                      //   // FlSpot(0.4, 660),
                                                      //   FlSpot(0.5, 760),
                                                      //   // FlSpot(0.6, 700),
                                                      //   // FlSpot(0.7, 550),
                                                      //   // FlSpot(0.8, 650),
                                                      //   FlSpot(0.9, 670),
                                                      //   // FlSpot(1, 500)
                                                      // ],
                                                      data_2: ReportPDFCommonvar
                                                          .lower,
                                                      // data2_2:
                                                      //     ReportPDFCommonvar
                                                      //         .graphdata2S,
                                                      // data3_2:
                                                      //     ReportPDFCommonvar
                                                      //         .graphdata3S,
                                                      //----------------------
                                                      // data_3: ReportPDFCommonvar
                                                      //     .graphdataSS,
                                                      data_3: ReportPDFCommonvar
                                                          .upper,
                                                      // data2_3:
                                                      //     ReportPDFCommonvar
                                                      //         .graphdata2SS,
                                                      // data3_3:
                                                      //     ReportPDFCommonvar
                                                      //         .graphdata3SS,
                                                      //----------------------
                                                      // data_4: ReportPDFCommonvar
                                                      //     .graphdataSSS,
                                                      // data2_4:
                                                      //     ReportPDFCommonvar
                                                      //         .graphdata2SSS,
                                                      // data3_4:
                                                      //     ReportPDFCommonvar
                                                      //         .graphdata3SSS,
                                                      //----------------------
                                                    )
                                                  : SizedBox(
                                                      height: 320,
                                                      width: 2000,
                                                    ),
                                            ),
                                          ),
                                        ],
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      1
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      2
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      3
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      4
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      5
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      6
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      7
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      8
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      9
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      10
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      11
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      12
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      13
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      14
                                                  ? ReportPDFCommonvar
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
                                              // ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      1
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      2
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      3
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      4
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      5
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      6
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      7
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      8
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      9
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      10
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      11
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      12
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      13
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar.rawlistGraph
                                                          .length >=
                                                      14
                                                  ? ReportPDFCommonvar
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
                                              ReportPDFCommonvar
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
                                    signs: true,
                                    PASS: ReportPDFCommonvar.PASS,
                                    PICS: _dataCOMMON.databasic.PICstd,
                                    Remark: ReportPDFCommonvar.remark,
                                    NAME01:
                                        _dataCOMMON.databasic.Inspected_sign,
                                    NAME02: _dataCOMMON.databasic.Check_sign,
                                    NAME03: _dataCOMMON.databasic.Approve_sign,
                                    NAME01date: _dataCOMMON
                                                .databasic.dateInspected !=
                                            ''
                                        ? DateFormat('dd/MM/yyyy').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                int.parse(ConverstStr(
                                                        _dataCOMMON.databasic
                                                            .dateInspected)) *
                                                    1))
                                        : "",
                                    NAME02date: _dataCOMMON
                                                .databasic.dateCheck !=
                                            ''
                                        ? DateFormat('dd/MM/yyyy').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                int.parse(ConverstStr(
                                                        _dataCOMMON.databasic
                                                            .dateCheck) *
                                                    1)))
                                        : "",
                                    NAME03date: _dataCOMMON
                                                .databasic.dateApprove !=
                                            ''
                                        ? DateFormat('dd/MM/yyyy').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                int.parse(ConverstStr(
                                                        _dataCOMMON.databasic
                                                            .dateApprove) *
                                                    1)))
                                        : "",
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
                            if (_dataCOMMON.databasic.Inspected == '') {
                              Dio().post(
                                options: Options(
                                  // contentType: "application/json",

                                  headers: {
                                    "server": "BP12-GAS",
                                  },
                                ),
                                GLOserverMASTER + "Inspected-sign",
                                data: {
                                  "ID": USERDATA.ID,
                                  "PO": ReportPDFCommonvar.PO,
                                },
                              ).then((v) {
                                var databuff = v.data;
                                context
                                    .read<ReportPDFCommon_Cubit>()
                                    .ReportPDFCommonCubit(
                                        ReportPDFCommonvar.PO, "");
                              });
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            color: _dataCOMMON.databasic.Inspected == ''
                                ? Colors.blue
                                : Colors.red,
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
                            if (_dataCOMMON.databasic.Check == '' &&
                                _dataCOMMON.databasic.Inspected != '') {
                              Dio().post(
                                options: Options(
                                  // contentType: "application/json",

                                  headers: {
                                    "server": "BP12-GAS",
                                  },
                                ),
                                GLOserverMASTER + "Check-sign",
                                data: {
                                  "ID": USERDATA.ID,
                                  "PO": ReportPDFCommonvar.PO,
                                },
                              ).then((v) {
                                var databuff = v.data;
                                context
                                    .read<ReportPDFCommon_Cubit>()
                                    .ReportPDFCommonCubit(
                                        ReportPDFCommonvar.PO, "");
                              });
                            } else {
                              if (_dataCOMMON.databasic.Inspected == '') {
                                WORNINGpop(
                                    context,
                                    ["", "Please Inspected first", ""],
                                    140,
                                    200);
                              }
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            color: _dataCOMMON.databasic.Check == ''
                                ? Colors.blue
                                : Colors.red,
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
                            if (_dataCOMMON.databasic.Approve == '' &&
                                _dataCOMMON.databasic.Check != '' &&
                                _dataCOMMON.databasic.Inspected != '') {
                              Dio().post(
                                options: Options(
                                  // contentType: "application/json",

                                  headers: {
                                    "server": "BP12-GAS",
                                  },
                                ),
                                GLOserverMASTER + "Approve-sign",
                                data: {
                                  "ID": USERDATA.ID,
                                  "PO": ReportPDFCommonvar.PO,
                                },
                              ).then((v) {
                                var databuff = v.data;
                                context
                                    .read<ReportPDFCommon_Cubit>()
                                    .ReportPDFCommonCubit(
                                        ReportPDFCommonvar.PO, "");
                              });
                            } else {
                              if (_dataCOMMON.databasic.Inspected == '') {
                                WORNINGpop(
                                    context,
                                    ["", "Please Inspected first", ""],
                                    140,
                                    200);
                              } else if (_dataCOMMON.databasic.Check == '') {
                                WORNINGpop(context,
                                    ["", "Please Check first", ""], 140, 200);
                              }
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            color: _dataCOMMON.databasic.Approve == ''
                                ? Colors.blue
                                : Colors.red,
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
              print("00" + ReportPDFCommonvar.PO);
              Dio().post(
                "${server2}10GETDATAFROMJOBBINGAQC/QCFN",
                // "${'http://127.0.0.1:14094/'}10GETDATAFROMJOBBINGAQC/QCFN",
                data: {
                  "BAPI_NAME": "ZFMPPQCFN_IN",
                  "ORDERID": ReportPDFCommonvar.PO,
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
