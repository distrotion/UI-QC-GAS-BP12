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
import '../../widget/common/popup.dart';
import '../../widget/function/helper.dart';
import '../P303QMMASTERQC/P303QMMASTERQCVAR.dart';
import '../page303.dart';
import 'ReportPDF2GPvar.dart';

late BuildContext ReportPDF2GPcontext;

class ReportPDF2GP extends StatefulWidget {
  ReportPDF2GP({
    Key? key,
    this.dataCommon,
  }) : super(key: key);
  CommonReportOutput? dataCommon;
  @override
  State<ReportPDF2GP> createState() => _ReportPDF2GPState();
}

class _ReportPDF2GPState extends State<ReportPDF2GP> {
  @override
  void initState() {
    ReportPDF2GPvar.TPKLOTEDIT = '';

    if (ReportPDF2GPvar.PO != '') {
      ReportPDF2GPvar.canf = false;
      context
          .read<ReportPDFCommon_Cubit>()
          .ReportPDFCommonCubit(ReportPDF2GPvar.PO, "cov");
    }
    super.initState();
  }

  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ReportPDF2GPcontext = context;
    ReportPDF2GPvar.graphset = 0;

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
      ReportPDF2GPvar.STATUS = 'REPORT READY';
      ReportPDF2GPvar.CUSTOMER = _dataCOMMON.databasic.CUSTOMER;
      ReportPDF2GPvar.PROCESS = _dataCOMMON.databasic.PROCESS;
      ReportPDF2GPvar.PARTNAME = _dataCOMMON.databasic.PARTNAME;
      ReportPDF2GPvar.PARTNO = _dataCOMMON.databasic.PARTNO;
      ReportPDF2GPvar.PARTNO_s = _dataCOMMON.databasic.PARTNO_s;
      ReportPDF2GPvar.CUSLOT = _dataCOMMON.databasic.CUSLOT;
      ReportPDF2GPvar.TPKLOT = _dataCOMMON.databasic.TPKLOT;
      ReportPDF2GPvar.MATERIAL = _dataCOMMON.databasic.MATERIAL;
      if (_dataCOMMON.databasic.UNITSAP.toUpperCase() != 'KG') {
        ReportPDF2GPvar.QTY =
            '${double.parse(ConverstStr(_dataCOMMON.databasic.QTY)).toStringAsFixed(0)} ${_dataCOMMON.databasic.UNITSAP}';
      } else {
        ReportPDF2GPvar.QTY =
            '${double.parse(ConverstStr(_dataCOMMON.databasic.QTY)).toStringAsFixed(1)} ${_dataCOMMON.databasic.UNITSAP}';
      }

      ReportPDF2GPvar.PIC01 = _dataCOMMON.databasic.PIC01;
      ReportPDF2GPvar.PIC02 = _dataCOMMON.databasic.PIC02;
      ReportPDF2GPvar.PICstd = _dataCOMMON.databasic.PICstd;

      ReportPDF2GPvar.PASS = _dataCOMMON.databasic.PASS;
      // ReportPDF2GPvar.remark = '';
      ReportPDF2GPvar.remark = _dataCOMMON.databasic.remark;
      if (_dataCOMMON.databasic.PARTNAMEref != '') {
        ReportPDF2GPvar.remark =
            'Reference data from\n${_dataCOMMON.databasic.PARTNAMEref}\n${_dataCOMMON.databasic.PARTref}';
      }

      ReportPDF2GPvar.INC01 = _dataCOMMON.databasic.INC01;
      ReportPDF2GPvar.INC02 = _dataCOMMON.databasic.INC02;
//remark

      // print(_dataCOMMON.datain[0]);
      // print(_dataCOMMON.datain.length);
      ReportPDF2GPvar.rawlistHardness = [];
      ReportPDF2GPvar.rawlistCompound = [];
      ReportPDF2GPvar.rawlistRoughness = [];
      ReportPDF2GPvar.rawlistCORE = [];

      ReportPDF2GPvar.graphupper = [];
      ReportPDF2GPvar.graphdata = [];
      ReportPDF2GPvar.graphdata2 = [];
      ReportPDF2GPvar.graphdata3 = [];
      ReportPDF2GPvar.graphdata4 = [];
      ReportPDF2GPvar.graphunder = [];

      for (var i = 0; i < _dataCOMMON.datain.length; i++) {
        String Loadin = '';
        if (_dataCOMMON.datain[i].LOAD != '' &&
            _dataCOMMON.datain[i].LOAD != '-') {
          Loadin = "( Load ${_dataCOMMON.datain[i].LOAD} )";
        }
        ReportPDF2GPvar.datalist[i].ITEMname =
            " ${_dataCOMMON.datain[i].ITEMname} ${Loadin}";
        ReportPDF2GPvar.datalist[i].SCMARK = _dataCOMMON.datain[i].SCMARK;
        ReportPDF2GPvar.datalist[i].METHODname =
            _dataCOMMON.datain[i].METHODname;
        ReportPDF2GPvar.datalist[i].FREQ = _dataCOMMON.datain[i].FREQ;
        ReportPDF2GPvar.datalist[i].SPECIFICATIONname =
            _dataCOMMON.datain[i].SPECIFICATION;
        ReportPDF2GPvar.datalist[i].RESULT = _dataCOMMON.datain[i].RESULT;
        ReportPDF2GPvar.datalist[i].REMARK = _dataCOMMON.datain[i].Remark;
        //print(ReportPDF2GPvar.datalist[i].RESULT.length);
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
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '1',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA01,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 2) {
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '2',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA02,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 3) {
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '3',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA03,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 4) {
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '4',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA04,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 5) {
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '5',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA05,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 6) {
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '6',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA06,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 7) {
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '7',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA07,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 8) {
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '8',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA08,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 9) {
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '9',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA09,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 10) {
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '10',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA10,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 11) {
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '11',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA11,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 12) {
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '12',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA12,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 13) {
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '13',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA13,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 14) {
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '14',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA14,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 15) {
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '15',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA15,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 16) {
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '16',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA16,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 17) {
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '17',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA17,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 18) {
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '18',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA18,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 19) {
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
                  DATANO: HardnessNO.toString(),
                  DATAPCS: '19',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA19,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 20) {
                ReportPDF2GPvar.rawlistHardness.add(rawlist(
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
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '1',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA01,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 2) {
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '2',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA02,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 3) {
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '3',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA03,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 4) {
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '4',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA04,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 5) {
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '5',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA05,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 6) {
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '6',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA06,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 7) {
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '7',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA07,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 8) {
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '8',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA08,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 9) {
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '9',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA09,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 10) {
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '10',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA10,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 11) {
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '11',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA11,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 12) {
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '12',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA12,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 13) {
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '13',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA13,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 14) {
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '14',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA14,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 15) {
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '15',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA15,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 16) {
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '16',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA16,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 17) {
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '17',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA17,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 18) {
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '18',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA18,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 19) {
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
                  DATANO: CoreNO.toString(),
                  DATAPCS: '19',
                  DATA: _dataCOMMON.datain[i].datapackset[li].DATA19,
                ));
              }
              if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 20) {
                ReportPDF2GPvar.rawlistCORE.add(rawlist(
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

        if (ReportPDF2GPvar.graphset == 0) {
          if (_dataCOMMON.datain[i].TYPE == 'Graph') {
            ReportPDF2GPvar.rawlistGraph = [];
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
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA01p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA01,
                  ));

                  ReportPDF2GPvar.graphdata.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA01p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA01))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 2) {
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA02p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA02,
                  ));

                  ReportPDF2GPvar.graphdata.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA02p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA02))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 3) {
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA03p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA03,
                  ));

                  ReportPDF2GPvar.graphdata.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA03p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA03))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 4) {
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA04p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA04,
                  ));

                  ReportPDF2GPvar.graphdata.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA04p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA04))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 5) {
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA05p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA05,
                  ));

                  ReportPDF2GPvar.graphdata.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA05p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA05))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 6) {
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA06p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA06,
                  ));

                  ReportPDF2GPvar.graphdata.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA06p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA06))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 7) {
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA07p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA07,
                  ));

                  ReportPDF2GPvar.graphdata.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA07p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA07))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 8) {
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA08p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA08,
                  ));

                  ReportPDF2GPvar.graphdata.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA08p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA08))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 9) {
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA09p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA09,
                  ));

                  ReportPDF2GPvar.graphdata.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA09p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA09))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 10) {
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA10p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA10,
                  ));

                  ReportPDF2GPvar.graphdata.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA10p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA10))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 11) {
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA11p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA11,
                  ));

                  ReportPDF2GPvar.graphdata.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA11p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA11))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 12) {
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA12p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA12,
                  ));

                  ReportPDF2GPvar.graphdata.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA12p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA12))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 13) {
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA13p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA13,
                  ));

                  ReportPDF2GPvar.graphdata.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA13p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA13))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 14) {
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA14p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA14,
                  ));

                  ReportPDF2GPvar.graphdata.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA14p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA14))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 15) {
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA15p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA15,
                  ));

                  ReportPDF2GPvar.graphdata.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA15p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA15))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 16) {
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA16p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA16,
                  ));

                  ReportPDF2GPvar.graphdata.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA16p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA16))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 17) {
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA17p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA17,
                  ));

                  ReportPDF2GPvar.graphdata.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA17p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA17))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 18) {
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA18p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA18,
                  ));

                  ReportPDF2GPvar.graphdata.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA18p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA18))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 19) {
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA19p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA19,
                  ));

                  ReportPDF2GPvar.graphdata.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA19p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA19))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 20) {
                  ReportPDF2GPvar.rawlistGraph.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA20p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA20,
                  ));

                  ReportPDF2GPvar.graphdata.add(
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

            // ReportPDF2GPvar.rawlistGraphCore = rawlist(
            //   DATAPCS: "Core",
            //   DATA: ReportPDF2GPvar
            //       .rawlistGraph[ReportPDF2GPvar.rawlistGraph.length - 1].DATA,
            // );
            // print(">>>${ReportPDF2GPvar.rawlistGraph.length}");
            // ReportPDF2GPvar.rawlistGraph.removeLast();
            if (ReportPDF2GPvar.rawlistGraph.length > 2) {
              ReportPDF2GPvar.rawlistGraphCore = rawlist(
                DATAPCS: "Core",
                DATA: ReportPDF2GPvar
                    .rawlistGraph[ReportPDF2GPvar.rawlistGraph.length - 1].DATA,
              );
              // print(">>>${ReportPDF2GPvar.rawlistGraph.length}");

              ReportPDF2GPvar.rawlistGraph
                  .removeAt(ReportPDF2GPvar.rawlistGraph.length - 1);
            }

            ReportPDF2GPvar.graphupper = [
              FlSpot(ReportPDF2GPvar.graphdata[0].x, 1000),
              FlSpot(
                  ReportPDF2GPvar
                      .graphdata[ReportPDF2GPvar.graphdata.length - 2].x,
                  1000)
            ];

            ReportPDF2GPvar.graphdata2 = [
              FlSpot(ReportPDF2GPvar.graphdata[0].x,
                  double.parse(ConverstStr(_dataCOMMON.datain[i].Cross))),
              FlSpot(double.parse(ConverstStr(_dataCOMMON.datain[i].RESULT)),
                  double.parse(ConverstStr(_dataCOMMON.datain[i].Cross)))
            ];

            ReportPDF2GPvar.graphdata3 = [
              FlSpot(double.parse(ConverstStr(_dataCOMMON.datain[i].RESULT)),
                  double.parse(ConverstStr(_dataCOMMON.datain[i].Cross))),
              FlSpot(double.parse(ConverstStr(_dataCOMMON.datain[i].RESULT)), 0)
            ];

            ReportPDF2GPvar.graphdata4 = [
              FlSpot(ReportPDF2GPvar.graphdata[0].x, 1000),
              FlSpot(ReportPDF2GPvar.graphdata[0].x, 0)
            ];

            ReportPDF2GPvar.graphunder = [
              FlSpot(ReportPDF2GPvar.graphdata[0].x, 0),
              FlSpot(
                  ReportPDF2GPvar
                      .graphdata[ReportPDF2GPvar.graphdata.length - 2].x,
                  0)
            ];
            ReportPDF2GPvar.graphset = 1;
          } else {
            //
          }

          // if (ReportPDF2GPvar.graphupper.length > 1) {
          //   ReportPDF2GPvar.graphupper;
          // }

          // if (ReportPDF2GPvar.graphdata2.length > 1) {
          //   ReportPDF2GPvar.graphdata2;
          // }
          // if (ReportPDF2GPvar.graphdata3.length > 1) {
          //   ReportPDF2GPvar.graphdata3;
          // }
          // if (ReportPDF2GPvar.graphdata4.length > 1) {
          //   ReportPDF2GPvar.graphdata4;
          // }
          // if (ReportPDF2GPvar.graphunder.length > 1) {
          //   ReportPDF2GPvar.graphunder;
          // }
        } else {
          //
          if (_dataCOMMON.datain[i].TYPE == 'Graph') {
            ReportPDF2GPvar.rawlistGraphs = [];
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
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA01p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA01,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA01p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA01))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 2) {
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA02p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA02,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA02p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA02))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 3) {
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA03p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA03,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA03p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA03))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 4) {
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA04p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA04,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA04p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA04))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 5) {
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA05p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA05,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA05p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA05))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 6) {
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA06p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA06,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA06p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA06))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 7) {
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA07p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA07,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA07p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA07))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 8) {
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA08p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA08,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA08p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA08))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 9) {
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA09p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA09,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA09p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA09))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 10) {
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA10p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA10,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA10p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA10))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 11) {
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA11p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA11,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA11p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA11))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 12) {
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA12p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA12,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA12p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA12))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 13) {
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA13p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA13,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA13p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA13))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 14) {
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA14p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA14,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA14p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA14))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 15) {
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA15p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA15,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA15p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA15))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 16) {
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA16p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA16,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA16p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA16))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 17) {
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA17p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA17,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA17p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA17))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 18) {
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA18p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA18,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA18p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA18))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 19) {
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA19p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA19,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
                    FlSpot(
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA19p)),
                        double.parse(ConverstStr(
                            _dataCOMMON.datain[i].datapackset[li].DATA19))),
                  );
                }
                if (_dataCOMMON.datain[i].datapackset[li].dimensionX >= 20) {
                  ReportPDF2GPvar.rawlistGraphs.add(rawlist(
                    DATANO: GraphNO.toString(),
                    DATAPCS: _dataCOMMON.datain[i].datapackset[li].DATA20p,
                    DATA: _dataCOMMON.datain[i].datapackset[li].DATA20,
                  ));

                  ReportPDF2GPvar.graphdataS.add(
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

            // ReportPDF2GPvar.rawlistGraphCore = rawlist(
            //   DATAPCS: "Core",
            //   DATA: ReportPDF2GPvar
            //       .rawlistGraph[ReportPDF2GPvar.rawlistGraph.length - 1].DATA,
            // );
            // print(">>>${ReportPDF2GPvar.rawlistGraph.length}");
            // ReportPDF2GPvar.rawlistGraph.removeLast();
            if (ReportPDF2GPvar.rawlistGraphs.length > 2) {
              ReportPDF2GPvar.rawlistGraphCoreS = rawlist(
                DATAPCS: "Core",
                DATA: ReportPDF2GPvar
                    .rawlistGraphs[ReportPDF2GPvar.rawlistGraphs.length - 1]
                    .DATA,
              );
              // print(">>>${ReportPDF2GPvar.rawlistGraph.length}");

              ReportPDF2GPvar.rawlistGraphs
                  .removeAt(ReportPDF2GPvar.rawlistGraphs.length - 1);
            }

            ReportPDF2GPvar.graphupperS = [
              FlSpot(ReportPDF2GPvar.graphdataS[0].x, 1000),
              FlSpot(
                  ReportPDF2GPvar
                      .graphdataS[ReportPDF2GPvar.graphdataS.length - 2].x,
                  1000)
            ];

            ReportPDF2GPvar.graphdata2S = [
              FlSpot(ReportPDF2GPvar.graphdataS[0].x,
                  double.parse(ConverstStr(_dataCOMMON.datain[i].Cross))),
              FlSpot(double.parse(ConverstStr(_dataCOMMON.datain[i].RESULT)),
                  double.parse(ConverstStr(_dataCOMMON.datain[i].Cross)))
            ];

            ReportPDF2GPvar.graphdata3S = [
              FlSpot(double.parse(ConverstStr(_dataCOMMON.datain[i].RESULT)),
                  double.parse(ConverstStr(_dataCOMMON.datain[i].Cross))),
              FlSpot(double.parse(ConverstStr(_dataCOMMON.datain[i].RESULT)), 0)
            ];

            ReportPDF2GPvar.graphdata4S = [
              FlSpot(ReportPDF2GPvar.graphdataS[0].x, 1000),
              FlSpot(ReportPDF2GPvar.graphdataS[0].x, 0)
            ];

            ReportPDF2GPvar.graphunderS = [
              FlSpot(ReportPDF2GPvar.graphdataS[0].x, 0),
              FlSpot(
                  ReportPDF2GPvar
                      .graphdataS[ReportPDF2GPvar.graphdataS.length - 2].x,
                  0)
            ];
          } else {
            //
          }

          // if (ReportPDF2GPvar.graphupperS.length > 1) {
          //   ReportPDF2GPvar.graphupperS;
          // }

          // if (ReportPDF2GPvar.graphdata2S.length > 1) {
          //   ReportPDF2GPvar.graphdata2S;
          // }
          // if (ReportPDF2GPvar.graphdata3S.length > 1) {
          //   ReportPDF2GPvar.graphdata3S;
          // }
          // if (ReportPDF2GPvar.graphdata4S.length > 1) {
          //   ReportPDF2GPvar.graphdata4S;
          // }
          // if (ReportPDF2GPvar.graphunderS.length > 1) {
          //   ReportPDF2GPvar.graphunderS;
          // }
        }

        //Compound Layer

        // Roughness
      }
      if (ReportPDF2GPvar.graphdata.length > 1) {
        ReportPDF2GPvar.graphdata.removeLast();
        //     .removeAt(ReportPDF2GPvar.graphdata.length - 1);
      }
      if (ReportPDF2GPvar.graphdataS.length > 1) {
        ReportPDF2GPvar.graphdataS.removeLast();
        //     .removeAt(ReportPDF2GPvar.graphdata.length - 1);
      }

      // print(ReportPDF2GPvar.datalist);
    } else {
      ReportPDF2GPvar.STATUS = 'WATTING or NO-DATA';

      ReportPDF2GPvar.CUSTOMER = '';
      ReportPDF2GPvar.PROCESS = '';
      ReportPDF2GPvar.PARTNAME = '';
      ReportPDF2GPvar.PARTNO = '';
      ReportPDF2GPvar.PARTNO_s = '';
      ReportPDF2GPvar.CUSLOT = '';
      ReportPDF2GPvar.TPKLOT = '';
      ReportPDF2GPvar.MATERIAL = '';
      ReportPDF2GPvar.QTY = '';

      ReportPDF2GPvar.PICstd = '';
      ReportPDF2GPvar.PIC01 = '';
      ReportPDF2GPvar.PIC02 = '';

      ReportPDF2GPvar.rawlistHardness = [];
      ReportPDF2GPvar.rawlistCompound = [];
      ReportPDF2GPvar.rawlistRoughness = [];
      ReportPDF2GPvar.rawlistCORE = [];
      ReportPDF2GPvar.INC01 = '';
      ReportPDF2GPvar.INC02 = '';

      ReportPDF2GPvar.datalist = [
        ReportPDF2GPlist(),
        ReportPDF2GPlist(),
        ReportPDF2GPlist(),
        ReportPDF2GPlist(),
        ReportPDF2GPlist(),
        ReportPDF2GPlist(),
        ReportPDF2GPlist(),
        ReportPDF2GPlist(),
        ReportPDF2GPlist(),
        ReportPDF2GPlist(),
        ReportPDF2GPlist(),
        ReportPDF2GPlist(),
        ReportPDF2GPlist(),
      ];

      ReportPDF2GPvar.rawlistGraphCore = rawlist();

      ReportPDF2GPvar.rawlistGraph = [];
      ReportPDF2GPvar.graphupper = [];
      ReportPDF2GPvar.graphdata = [];
      ReportPDF2GPvar.graphdata2 = [];
      ReportPDF2GPvar.graphdata3 = [];
      ReportPDF2GPvar.graphdata4 = [];
      ReportPDF2GPvar.graphunder = [];

      ReportPDF2GPvar.rawlistGraphCoreS = rawlist();

      ReportPDF2GPvar.rawlistGraphs = [];
      ReportPDF2GPvar.graphupperS = [];
      ReportPDF2GPvar.graphdataS = [];
      ReportPDF2GPvar.graphdata2S = [];
      ReportPDF2GPvar.graphdata3S = [];
      ReportPDF2GPvar.graphdata4S = [];
      ReportPDF2GPvar.graphunderS = [];
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
                  isContr: ReportPDF2GPvar.iscontrol,
                  fnContr: (input) {
                    setState(() {
                      ReportPDF2GPvar.iscontrol = input;
                    });
                  },
                  isEnabled: ReportPDF2GPvar.canf,
                  sValue: ReportPDF2GPvar.PO,
                  returnfunc: (String s) {
                    ReportPDF2GPvar.PO = s;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: () {
                    if (ReportPDF2GPvar.PO != '') {
                      context
                          .read<ReportPDFCommon_Cubit>()
                          .ReportPDFCommonCubit(ReportPDF2GPvar.PO, "cov");
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
                    ReportPDF2GPvar.canf = true;
                    ReportPDF2GPvar.iscontrol = true;
                    ReportPDF2GPvar.PO = '';
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
                  color: ReportPDF2GPvar.STATUS == 'REPORT READY'
                      ? Colors.green
                      : Colors.yellow,
                  height: 40,
                  width: 200,
                  child: Center(
                    child: Text(ReportPDF2GPvar.STATUS),
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
                      ReportPDF2GPvar.TYPE = d;
                      if (d == '1') {
                        setState(() {
                          ReportPDF2GPvar.SCMASKTYPE = imgGeneral;
                          ReportPDF2GPvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '2') {
                        setState(() {
                          ReportPDF2GPvar.SCMASKTYPE = imgJTEKT;
                          ReportPDF2GPvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '3') {
                        setState(() {
                          ReportPDF2GPvar.SCMASKTYPE = imgNTN;
                          ReportPDF2GPvar.SCMASKTYPEonTop = imgNTNonH;
                        });
                      } else if (d == '4') {
                        setState(() {
                          ReportPDF2GPvar.SCMASKTYPE = imgTBKK;
                          ReportPDF2GPvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '5') {
                        setState(() {
                          ReportPDF2GPvar.SCMASKTYPE = imgGKN;
                          ReportPDF2GPvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '6') {
                        setState(() {
                          ReportPDF2GPvar.SCMASKTYPE = SIAMADVANCE;
                          ReportPDF2GPvar.SCMASKTYPEonTop = '';
                        });
                      } else if (d == '7') {
                        setState(() {
                          ReportPDF2GPvar.SCMASKTYPE = NTN500T850T;
                          ReportPDF2GPvar.SCMASKTYPEonTop = NTN500T850T;
                        });
                      } else {
                        setState(() {
                          ReportPDF2GPvar.SCMASKTYPE = imgGeneral;
                          ReportPDF2GPvar.SCMASKTYPEonTop = '';
                        });
                      }
                    },
                    value: ReportPDF2GPvar.TYPE,
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
                  isContr: ReportPDF2GPvar.iscontrol,
                  fnContr: (input) {
                    setState(() {
                      ReportPDF2GPvar.iscontrol = input;
                    });
                  },
                  sPlaceholder: "Inspected By",
                  sValue: ReportPDF2GPvar.SignInsBy,
                  returnfunc: (String s) {
                    setState(() {
                      ReportPDF2GPvar.SignInsBy = s;
                    });
                  },
                ),
              ),
              const Spacer(),
              // if (ReportPDF2GPvar.PASS == "PASSED") ...[
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
                        ReportPDF2GPvar.PO,
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
              //               ReportPDF2GPvar.PO,
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
                  P303QMMASTERQCVAR.SEARCH = ReportPDF2GPvar.PO;
                  var now = DateTime.now().subtract(Duration(days: 25));
                  P303QMMASTERQCVAR.day = DateFormat('dd').format(now);
                  P303QMMASTERQCVAR.month = DateFormat('MM').format(now);
                  P303QMMASTERQCVAR.year = DateFormat('yyyy').format(now);
                  P303QMMASTERQCVAR.BATCH = _dataCOMMON.databasic.TPKLOT;
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
                  //ReportPDF2GPvar.PO
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
                  //ReportPDF2GPvar.PO
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

                      if (databuff[i]['PO'] == ReportPDF2GPvar.PO) {
                        print(
                            databuff[i]['PO'] + ':' + databuff[i]['FG_CHARG']);
                        // print(databuff[i]);
                        ReportPDF2GPvar.TPKLOTEDIT = databuff[i]['FG_CHARG'];
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
          //         isContr: ReportPDF2GPvar.iscontrol,
          //         fnContr: (input) {
          //           setState(() {
          //             ReportPDF2GPvar.iscontrol = input;
          //           });
          //         },
          //         // isEnabled: ReportPDF2GPvar.canf,
          //         sValue: ReportPDF2GPvar.remark,
          //         returnfunc: (String s) {
          //           setState(() {
          //             ReportPDF2GPvar.remark = s;
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
                                    CUSTOMER: ReportPDF2GPvar.CUSTOMER,
                                    PROCESS: ReportPDF2GPvar.PROCESS,
                                    PARTNAME: ReportPDF2GPvar.PARTNAME,
                                    PARTNO: ReportPDF2GPvar.PARTNO.contains("|")
                                        ? ReportPDF2GPvar.PARTNO.split("|")[1]
                                        : ReportPDF2GPvar.PARTNO == ''
                                            ? ReportPDF2GPvar.PARTNO_s
                                            : ReportPDF2GPvar.PARTNO,
                                    CUSLOT: ReportPDF2GPvar.CUSLOT,
                                    TPKLOT: ReportPDF2GPvar.TPKLOT,
                                    MATERIAL: ReportPDF2GPvar.MATERIAL,
                                    QTY: ReportPDF2GPvar.QTY,
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
                                        ReportPDF2GPvar.INC01 != ''
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
                                        ReportPDF2GPvar.INC01 != ''
                                            ? "Visual"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDF2GPvar.INC01 != ''
                                            ? "10 pcs/rcv.Lot"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDF2GPvar.INC01 != ''
                                            ? "No Rust"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDF2GPvar.INC01 != ''
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
                                        ReportPDF2GPvar.INC02 != ''
                                            ? "Appearance for scratch"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: Text(
                                        ReportPDF2GPvar.INC02 != '' ? "" : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDF2GPvar.INC02 != ''
                                            ? "Visual"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDF2GPvar.INC02 != ''
                                            ? "10 pcs/rcv.Lot"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDF2GPvar.INC02 != ''
                                            ? "No Scratch"
                                            : "",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget06: Center(
                                      child: Text(
                                        ReportPDF2GPvar.INC02 != ''
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
                                        ReportPDF2GPvar.datalist[0].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDF2GPvar
                                                  .datalist[0].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDF2GPvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[0].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[0].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDF2GPvar
                                            .datalist[0].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar
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
                                        ReportPDF2GPvar.datalist[0].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar.datalist[0]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[0].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar.datalist[0]
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
                                        ReportPDF2GPvar.datalist[1].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDF2GPvar
                                                  .datalist[1].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDF2GPvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[1].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[1].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDF2GPvar
                                            .datalist[1].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar
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
                                        ReportPDF2GPvar.datalist[1].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar.datalist[1]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[1].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar.datalist[1]
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
                                        ReportPDF2GPvar.datalist[2].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDF2GPvar
                                                  .datalist[2].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDF2GPvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[2].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[2].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDF2GPvar
                                            .datalist[2].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar
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
                                        ReportPDF2GPvar.datalist[2].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar.datalist[2]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[2].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar.datalist[2]
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
                                        ReportPDF2GPvar.datalist[3].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDF2GPvar
                                                  .datalist[3].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDF2GPvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[3].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[3].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDF2GPvar
                                            .datalist[3].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar
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
                                        ReportPDF2GPvar.datalist[3].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar.datalist[3]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[3].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar.datalist[3]
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
                                        ReportPDF2GPvar.datalist[4].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDF2GPvar
                                                  .datalist[4].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDF2GPvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[4].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[4].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDF2GPvar
                                            .datalist[4].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar
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
                                        ReportPDF2GPvar.datalist[4].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar.datalist[4]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[4].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar.datalist[4]
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
                                        ReportPDF2GPvar.datalist[5].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDF2GPvar
                                                  .datalist[5].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDF2GPvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[5].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[5].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDF2GPvar
                                            .datalist[5].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar
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
                                        ReportPDF2GPvar.datalist[5].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar.datalist[5]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[5].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar.datalist[5]
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
                                        ReportPDF2GPvar.datalist[6].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDF2GPvar
                                                  .datalist[6].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDF2GPvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[6].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[6].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDF2GPvar
                                            .datalist[6].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar
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
                                        ReportPDF2GPvar.datalist[6].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar.datalist[6]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[6].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar.datalist[6]
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
                                        ReportPDF2GPvar.datalist[7].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDF2GPvar
                                                  .datalist[7].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDF2GPvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[7].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[7].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDF2GPvar
                                            .datalist[7].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar
                                                      .datalist[7]
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
                                        ReportPDF2GPvar.datalist[7].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar.datalist[7]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[7].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar.datalist[7]
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
                                        ReportPDF2GPvar.datalist[8].ITEMname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget02: Center(
                                      child: ReportPDF2GPvar
                                                  .datalist[8].SCMARK ==
                                              'YES'
                                          ? PicShow(
                                              width: 42,
                                              height: 42,
                                              base64:
                                                  ReportPDF2GPvar.SCMASKTYPE)
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                    widget03: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[8].METHODname,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget04: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[8].FREQ,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    widget05: Center(
                                      child: Text(
                                        ReportPDF2GPvar
                                            .datalist[8].SPECIFICATIONname,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar
                                                      .datalist[8]
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
                                        ReportPDF2GPvar.datalist[8].RESULT,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar.datalist[8]
                                                      .RESULT.length >
                                                  30
                                              ? 12
                                              : 16,
                                        ),
                                      ),
                                    ),
                                    widget07: Center(
                                      child: Text(
                                        ReportPDF2GPvar.datalist[8].REMARK,
                                        style: TextStyle(
                                          fontSize: ReportPDF2GPvar.datalist[8]
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
                                              His: 35,
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          1
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          2
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          3
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          4
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          5
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          6
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          7
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          8
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          9
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          10
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          11
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          12
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          13
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          14
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          15
                                                      ? ReportPDF2GPvar
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
                                              His: 35,
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          1
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          2
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          3
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          4
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          5
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          6
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          7
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          8
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          9
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          10
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          11
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          12
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          13
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          14
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          15
                                                      ? ReportPDF2GPvar
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
                                              His: 35,
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          1
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          2
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          3
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          4
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          5
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          6
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          7
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          8
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          9
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          10
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          11
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          12
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          13
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          14
                                                      ? ReportPDF2GPvar
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
                                                  ReportPDF2GPvar
                                                              .rawlistHardness
                                                              .length >=
                                                          15
                                                      ? ReportPDF2GPvar
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
                                      //             ReportPDF2GPvar
                                      //                         .rawlistCORE.length >=
                                      //                     1
                                      //                 ? ReportPDF2GPvar
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
                                      //             ReportPDF2GPvar
                                      //                         .rawlistCORE.length >=
                                      //                     1
                                      //                 ? ReportPDF2GPvar
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
                                      //         //     ReportPDF2GPvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             2
                                      //         //         ? ReportPDF2GPvar
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
                                      //         //     ReportPDF2GPvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             3
                                      //         //         ? ReportPDF2GPvar
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
                                      //         //     ReportPDF2GPvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             4
                                      //         //         ? ReportPDF2GPvar
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
                                      //         //     ReportPDF2GPvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             5
                                      //         //         ? ReportPDF2GPvar
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
                                      //             ReportPDF2GPvar
                                      //                         .rawlistCORE.length >=
                                      //                     1
                                      //                 ? ReportPDF2GPvar
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
                                      //         //     ReportPDF2GPvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             2
                                      //         //         ? ReportPDF2GPvar
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
                                      //         //     ReportPDF2GPvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             3
                                      //         //         ? ReportPDF2GPvar
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
                                      //         //     ReportPDF2GPvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             4
                                      //         //         ? ReportPDF2GPvar
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
                                      //         //     ReportPDF2GPvar
                                      //         //                 .rawlistCORE.length >=
                                      //         //             5
                                      //         //         ? ReportPDF2GPvar
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
                                  GRAPH2SIDEGRAPH(
                                    HIs: 290,
                                    // PIC01: _dataCOMMON.databasic.PIC01,
                                    // PIC02: _dataCOMMON.databasic.PIC02 == wpic
                                    //     ? _dataCOMMON.databasic.PIC03
                                    //     : _dataCOMMON.databasic.PIC02,
                                    widget01: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          child: Container(
                                            height: 280,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 3),
                                            ),
                                            child: ReportPDF2GPvar
                                                    .graphdata.isNotEmpty
                                                ? ControlChart01(
                                                    upper: ReportPDF2GPvar
                                                        .graphupper,
                                                    data: ReportPDF2GPvar
                                                        .graphdata,
                                                    data2: ReportPDF2GPvar
                                                        .graphdata2,
                                                    data3: ReportPDF2GPvar
                                                        .graphdata3,
                                                    data4: ReportPDF2GPvar
                                                        .graphdata4,
                                                    under: ReportPDF2GPvar
                                                        .graphunder,
                                                  )
                                                : SizedBox(
                                                    height: 280,
                                                    width: 2000,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    widget02: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          child: Container(
                                            height: 280,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 3),
                                            ),
                                            child: ReportPDF2GPvar
                                                    .graphdataS.isNotEmpty
                                                ? ControlChart01(
                                                    upper: ReportPDF2GPvar
                                                        .graphupperS,
                                                    data: ReportPDF2GPvar
                                                        .graphdataS,
                                                    data2: ReportPDF2GPvar
                                                        .graphdata2S,
                                                    data3: ReportPDF2GPvar
                                                        .graphdata3S,
                                                    data4: ReportPDF2GPvar
                                                        .graphdata4S,
                                                    under: ReportPDF2GPvar
                                                        .graphunderS,
                                                  )
                                                : SizedBox(
                                                    height: 280,
                                                    width: 2000,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    widget03: Column(
                                      children: [
                                        HEAD16SLOT(
                                          His: 35,
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      1
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      2
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      3
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      4
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      5
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      6
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      7
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      8
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      9
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      10
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      11
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      12
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      13
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      14
                                                  ? ReportPDF2GPvar
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
                                              // ReportPDF2GPvar
                                              //     .rawlistGraphCore.DATAPCS,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        BODY16SLOT(
                                          His: 35,
                                          ListFlex: S16slot,
                                          widget01: const Center(
                                            child: Text(
                                              "Hardness P1",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget02: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      1
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      2
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      3
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      4
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      5
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      6
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      7
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      8
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      9
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      10
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      11
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      12
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      13
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar.rawlistGraph
                                                          .length >=
                                                      14
                                                  ? ReportPDF2GPvar
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
                                              ReportPDF2GPvar
                                                  .rawlistGraphCore.DATA,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        HEAD16SLOT(
                                          His: 35,
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
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      1
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[0].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget03: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      2
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[1].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget04: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      3
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[2].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget05: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      4
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[3].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget06: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      5
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[4].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget07: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      6
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[5].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget08: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      7
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[6].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget09: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      8
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[7].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget10: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      9
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[8].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget11: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      10
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[9].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget12: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      11
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[10].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget13: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      12
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[11].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget14: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      13
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[12].DATAPCS
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget15: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      14
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[13].DATAPCS
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
                                              // ReportPDF2GPvar
                                              //     .rawlistGraphCore.DATAPCS,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        BODY16SLOT(
                                          His: 35,
                                          ListFlex: S16slot,
                                          widget01: const Center(
                                            child: Text(
                                              "Hardness P2",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget02: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      1
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[0].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget03: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      2
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[1].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget04: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      3
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[2].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget05: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      4
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[3].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget06: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      5
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[4].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget07: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      6
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[5].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget08: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      7
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[6].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget09: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      8
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[7].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget10: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      9
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[8].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget11: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      10
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[9].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget12: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      11
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[10].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget13: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      12
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[11].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget14: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      13
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[12].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget15: Center(
                                            child: Text(
                                              ReportPDF2GPvar.rawlistGraphs
                                                          .length >=
                                                      14
                                                  ? ReportPDF2GPvar
                                                      .rawlistGraphs[13].DATA
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          widget16: Center(
                                            child: Text(
                                              ReportPDF2GPvar
                                                  .rawlistGraphCoreS.DATA,
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
                                    PASS: ReportPDF2GPvar.PASS,
                                    PICS: _dataCOMMON.databasic.PICstd,
                                    Remark: ReportPDF2GPvar.remark,
                                    signs: true,
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
                                  "PO": ReportPDF2GPvar.PO,
                                },
                              ).then((v) {
                                var databuff = v.data;
                                context
                                    .read<ReportPDFCommon_Cubit>()
                                    .ReportPDFCommonCubit(
                                        ReportPDF2GPvar.PO, "");
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
                                  "PO": ReportPDF2GPvar.PO,
                                },
                              ).then((v) {
                                var databuff = v.data;
                                context
                                    .read<ReportPDFCommon_Cubit>()
                                    .ReportPDFCommonCubit(
                                        ReportPDF2GPvar.PO, "");
                              });
                            } else {
                              if (_dataCOMMON.databasic.Inspected == '') {
                                WORNINGpop(
                                    context,
                                    ["", "Please Inspected first", ""],
                                    60,
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
                                  "PO": ReportPDF2GPvar.PO,
                                },
                              ).then((v) {
                                var databuff = v.data;
                                context
                                    .read<ReportPDFCommon_Cubit>()
                                    .ReportPDFCommonCubit(
                                        ReportPDF2GPvar.PO, "");
                              });
                            } else {
                              if (_dataCOMMON.databasic.Inspected == '') {
                                WORNINGpop(
                                    context,
                                    ["", "Please Inspected first", ""],
                                    60,
                                    200);
                              } else if (_dataCOMMON.databasic.Check == '') {
                                WORNINGpop(context,
                                    ["", "Please Check first", ""], 60, 200);
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
              print("00" + ReportPDF2GPvar.PO);
              Dio().post(
                "${server2}10GETDATAFROMJOBBINGAQC/QCFN",
                // "${'http://127.0.0.1:14094/'}10GETDATAFROMJOBBINGAQC/QCFN",
                data: {
                  "BAPI_NAME": "ZFMPPQCFN_IN",
                  "ORDERID": ReportPDF2GPvar.PO,
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
