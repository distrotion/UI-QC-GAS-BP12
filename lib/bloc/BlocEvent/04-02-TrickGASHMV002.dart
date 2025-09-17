import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/global.dart';
import '../../page/P1FIRSTUI/FIRSTuiVAR.dart';
import '../../page/P4GASHMV002/GASHMV002var.dart';

//-------------------------------------------------
String server = GLOserver;
String serverAUTO = GLOserver;

abstract class TRICKER_Event {}

//--------------------------------

class TRICKER_GETINtoGASHMV002 extends TRICKER_Event {}

//-------------------------------- non returnfunction

class TRICKER_GASHMV002geteachITEM extends TRICKER_Event {}

class TRICKER_GASHMV002geteachGRAPH extends TRICKER_Event {}

class TRICKER_GASHMV002confirmdata extends TRICKER_Event {}

class TRICKER_GASHMV002confirmdata1 extends TRICKER_Event {}

class TRICKER_GASHMV002confirmdata2 extends TRICKER_Event {}

class TRICKER_GASHMV002confirmdata3 extends TRICKER_Event {}

class TRICKER_GASHMV002CLEAR extends TRICKER_Event {}

class TRICKER_GASHMV002RESETVALUE extends TRICKER_Event {}

class TRICKER_GASHMV002SETZERO extends TRICKER_Event {}

//-------------------------------- FINISH

class TRICKER_GASHMV002FINISH extends TRICKER_Event {}

//-------------------------------- no request

class TRICKER_FLUSH extends TRICKER_Event {}

class TRICKER_GASHMV002_Bloc extends Bloc<TRICKER_Event, String> {
  TRICKER_GASHMV002_Bloc() : super('') {
    //--------------------------------
    on<TRICKER_GETINtoGASHMV002>((event, emit) {
      return _TRICKER_GETINtoGASHMV002('', emit);
    });

    //-------------------------------- non returnfunction

    on<TRICKER_GASHMV002geteachITEM>((event, emit) {
      return _TRICKER_GASHMV002geteachITEM('', emit);
    });

    on<TRICKER_GASHMV002geteachGRAPH>((event, emit) {
      return _TRICKER_GASHMV002geteachGRAPH('', emit);
    });

    on<TRICKER_GASHMV002confirmdata>((event, emit) {
      return _TRICKER_GASHMV002confirmdata('', emit);
    });

    on<TRICKER_GASHMV002confirmdata1>((event, emit) {
      return _TRICKER_GASHMV002confirmdata1('', emit);
    });

    on<TRICKER_GASHMV002confirmdata2>((event, emit) {
      return _TRICKER_GASHMV002confirmdata2('', emit);
    });
    //
    on<TRICKER_GASHMV002confirmdata3>((event, emit) {
      return _TRICKER_GASHMV002confirmdata3('', emit);
    });

    on<TRICKER_GASHMV002CLEAR>((event, emit) {
      return _TRICKER_GASHMV002CLEAR('', emit);
    });

    on<TRICKER_GASHMV002RESETVALUE>((event, emit) {
      return _TRICKER_GASHMV002RESETVALUE('', emit);
    });

    on<TRICKER_GASHMV002SETZERO>((event, emit) {
      return _TRICKER_GASHMV002SETZERO('', emit);
    });

    //-------------------------------- FINISH

    on<TRICKER_GASHMV002FINISH>((event, emit) {
      return _TRICKER_GASHMV002FINISH('', emit);
    });

    //-------------------------------- no request

    on<TRICKER_FLUSH>((event, emit) {
      return _TRICKER_FLUSH('', emit);
    });
  }

  Future<void> _TRICKER_GETINtoGASHMV002(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GETINtoGASHMV002',
      data: {
        "PO": FIRSTUI.POACTIVE,
        "CP": FIRSTUI.CPACTIVE,
        "USER": USERDATA.NAME,
        "USERID": USERDATA.ID,
      },
    );
    String output = '';
    if (response.statusCode == 200) {
      var databuff = response.data;
      if (databuff.toString() == 'OK') {
        output = 'OK';
      } else {
        output = 'NOK';
      }
    } else {
      //
    }
    emit(output);
  }

  Future<void> _TRICKER_GASHMV002geteachITEM(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV002-geteachITEM',
      data: {
        "ITEMs": GASHMV002var.ItemPickSELECT,
      },
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV002geteachGRAPH(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV002-geteachGRAPH',
      data: {
        "GAPname": GASHMV002var.GAPname,
      },
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV002confirmdata(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV002-confirmdata',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV002confirmdata1(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      'http://172.23.10.40:1885/' + 'deptmv02',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV002confirmdata2(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      'http://172.23.10.40:1885/' + 'surfacemv02',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV002confirmdata3(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      'http://172.23.10.40:1885/' + 'surfacemv02',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV002CLEAR(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV002-CLEAR',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV002RESETVALUE(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV002-RESETVALUE',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV002SETZERO(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV002-SETZERO',
      data: {},
    );
    emit('');
  }

  //-------------------------------- FINISH
  //TRICKER_GASHMV002FINISH

  Future<void> _TRICKER_GASHMV002FINISH(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV002-FINISH',
      data: {},
    );
    emit('');
  }

  //-------------------------------- no request

  Future<void> _TRICKER_FLUSH(String toAdd, Emitter<String> emit) async {
    emit('');
  }
}
