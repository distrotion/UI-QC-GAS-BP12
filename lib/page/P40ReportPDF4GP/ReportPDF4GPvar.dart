import 'package:fl_chart/fl_chart.dart';

import '../../widget/common/imgset.dart';

class ReportPDF4GPvar {
  static bool iscontrol = false;
  static bool canf = true;
  static String PO = '';

  static String STATUS = '';

  static String CUSTOMER = '';
  static String PROCESS = '';
  static String PARTNAME = '';
  static String PARTNO = '';
  static String PARTNO_s = '';
  static String CUSLOT = '';
  static String TPKLOT = '';
  static String MATERIAL = '';
  static String QTY = '';

  static String TPKLOTEDIT = '';

  static String PICstd = '';
  static String PIC01 = '';
  static String PIC02 = '';
  static String TYPE = '-';
  static String SCMASKTYPE = SCMASK03;
  static String SCMASKTYPEonTop = '';
  static List<rawlist> rawlistHardness = [];
  static List<rawlist> rawlistCompound = [];
  static List<rawlist> rawlistRoughness = [];
  static List<rawlist> rawlistCORE = [];

  //rawlistCORE

  static List<String> ListItemGraph = [];
  static List<String> ListItemNumber = [];

  static List<rawlist> rawlistGraph = [];
  static List<rawlist> rawlistGraphs = [];
  static List<rawlist> rawlistGraphss = [];
  static List<rawlist> rawlistGraphsss = [];
  static rawlist rawlistGraphCore = rawlist();
  static rawlist rawlistGraphCoreS = rawlist();
  static rawlist rawlistGraphCoreSS = rawlist();
  static rawlist rawlistGraphCoreSSS = rawlist();

  static String remark = '';

  static String PASS = '';

  static String commp = 'Compound layer';

  static String INC01 = '';
  static String INC02 = '';

  static String SignInsBy = '';

  static List<ReportPDF4GPlist> datalist = [
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
  ];
//
  static int graphset = 0;
  static List<FlSpot> graphupper = [];
  static List<FlSpot> graphdata = [];
  static List<FlSpot> graphdata2 = [];
  static List<FlSpot> graphdata3 = [];
  static List<FlSpot> graphdata4 = [];
  static List<FlSpot> graphunder = [];
//
  // static List<FlSpot> graphupperS = [];
  static List<FlSpot> graphdataS = [];
  static List<FlSpot> graphdata2S = [];
  static List<FlSpot> graphdata3S = [];
  // static List<FlSpot> graphdata4S = [];
  // static List<FlSpot> graphunderS = [];
//
  // static List<FlSpot> graphupperSS = [];
  static List<FlSpot> graphdataSS = [];
  static List<FlSpot> graphdata2SS = [];
  static List<FlSpot> graphdata3SS = [];
  // static List<FlSpot> graphdata4SS = [];
  // static List<FlSpot> graphunderSS = [];
//
  // static List<FlSpot> graphupperSSS = [];
  static List<FlSpot> graphdataSSS = [];
  static List<FlSpot> graphdata2SSS = [];
  static List<FlSpot> graphdata3SSS = [];
  // static List<FlSpot> graphdata4SSS = [];
  // static List<FlSpot> graphunderSSS = [];
//
}

class ReportPDF4GPlist {
  ReportPDF4GPlist({
    this.ITEM = '',
    this.ITEMname = '',
    this.METHOD = '',
    this.METHODname = '',
    this.SCMARK = '',
    this.FREQ = '',
    this.SPECIFICATION = '',
    this.SPECIFICATIONname = '',
    this.SPECIFICATIONve = '',
    this.RESULT = '',
    this.CONTROLlimmit = '',
    this.DATA01 = '',
    this.DATA02 = '',
    this.DATA03 = '',
    this.DATAAVG = '',
    this.REMARK = '',
  });
  String ITEM;
  String ITEMname = '';
  String METHOD = '';
  String METHODname = '';
  String SCMARK = '';
  String FREQ = '';
  String SPECIFICATION = '';
  String SPECIFICATIONname = '';
  String SPECIFICATIONve = '';
  String RESULT = '';
  String CONTROLlimmit = '';
  String DATA01 = '';
  String DATA02 = '';
  String DATA03 = '';
  String DATAAVG = '';
  String REMARK = '';
}

class rawlist {
  rawlist({
    this.DATANO = '',
    this.DATAPCS = '',
    this.DATA = '',
  });
  String DATANO;
  String DATAPCS = '';
  String DATA = '';
}

ReportPDFACTclear() {
  ReportPDF4GPvar.PO = '';

  ReportPDF4GPvar.CUSTOMER = '';
  ReportPDF4GPvar.PROCESS = '';
  ReportPDF4GPvar.PARTNAME = '';
  ReportPDF4GPvar.PARTNO = '';
  ReportPDF4GPvar.CUSLOT = '';
  ReportPDF4GPvar.TPKLOT = '';
  ReportPDF4GPvar.MATERIAL = '';
  ReportPDF4GPvar.QTY = '';

  ReportPDF4GPvar.PICstd = '';
  ReportPDF4GPvar.PIC01 = '';
  ReportPDF4GPvar.PIC02 = '';

  ReportPDF4GPvar.SignInsBy = '';
  ReportPDF4GPvar.datalist = [
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
    ReportPDF4GPlist(),
  ];
}
