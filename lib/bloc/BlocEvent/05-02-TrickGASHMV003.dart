import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/global.dart';
import '../../page/P1FIRSTUI/FIRSTuiVAR.dart';
import '../../page/P5GASHMV003/GASHMV003var.dart';

//-------------------------------------------------
String server = GLOserver;
String serverAUTO = GLOserver;

abstract class TRICKER_Event {}

//--------------------------------

class TRICKER_GETINtoGASHMV003 extends TRICKER_Event {}

//-------------------------------- non returnfunction

class TRICKER_GASHMV003geteachITEM extends TRICKER_Event {}

class TRICKER_GASHMV003geteachGRAPH extends TRICKER_Event {}

class TRICKER_GASHMV003confirmdata extends TRICKER_Event {}

class TRICKER_GASHMV003confirmdata1 extends TRICKER_Event {}

class TRICKER_GASHMV003confirmdata2 extends TRICKER_Event {}

class TRICKER_GASHMV003confirmdata3 extends TRICKER_Event {}

class TRICKER_GASHMV003CLEAR extends TRICKER_Event {}

class TRICKER_GASHMV003RESETVALUE extends TRICKER_Event {}

class TRICKER_GASHMV003SETZERO extends TRICKER_Event {}

//-------------------------------- FINISH

class TRICKER_GASHMV003FINISH extends TRICKER_Event {}

//-------------------------------- no request

class TRICKER_FLUSH extends TRICKER_Event {}

class TRICKER_GASHMV003_Bloc extends Bloc<TRICKER_Event, String> {
  TRICKER_GASHMV003_Bloc() : super('') {
    //--------------------------------
    on<TRICKER_GETINtoGASHMV003>((event, emit) {
      return _TRICKER_GETINtoGASHMV003('', emit);
    });

    //-------------------------------- non returnfunction

    on<TRICKER_GASHMV003geteachITEM>((event, emit) {
      return _TRICKER_GASHMV003geteachITEM('', emit);
    });

    on<TRICKER_GASHMV003geteachGRAPH>((event, emit) {
      return _TRICKER_GASHMV003geteachGRAPH('', emit);
    });

    on<TRICKER_GASHMV003confirmdata>((event, emit) {
      return _TRICKER_GASHMV003confirmdata('', emit);
    });

    on<TRICKER_GASHMV003confirmdata1>((event, emit) {
      return _TRICKER_GASHMV003confirmdata1('', emit);
    });

    on<TRICKER_GASHMV003confirmdata2>((event, emit) {
      return _TRICKER_GASHMV003confirmdata2('', emit);
    });
    //
    on<TRICKER_GASHMV003confirmdata3>((event, emit) {
      return _TRICKER_GASHMV003confirmdata3('', emit);
    });

    on<TRICKER_GASHMV003CLEAR>((event, emit) {
      return _TRICKER_GASHMV003CLEAR('', emit);
    });

    on<TRICKER_GASHMV003RESETVALUE>((event, emit) {
      return _TRICKER_GASHMV003RESETVALUE('', emit);
    });

    on<TRICKER_GASHMV003SETZERO>((event, emit) {
      return _TRICKER_GASHMV003SETZERO('', emit);
    });

    //-------------------------------- FINISH

    on<TRICKER_GASHMV003FINISH>((event, emit) {
      return _TRICKER_GASHMV003FINISH('', emit);
    });

    //-------------------------------- no request

    on<TRICKER_FLUSH>((event, emit) {
      return _TRICKER_FLUSH('', emit);
    });
  }

  Future<void> _TRICKER_GETINtoGASHMV003(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GETINtoGASHMV003',
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

  Future<void> _TRICKER_GASHMV003geteachITEM(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV003-geteachITEM',
      data: {
        "ITEMs": GASHMV003var.ItemPickSELECT,
      },
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV003geteachGRAPH(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV003-geteachGRAPH',
      data: {
        "GAPname": GASHMV003var.GAPname,
      },
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV003confirmdata(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV003-confirmdata',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV003confirmdata1(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      'http://172.23.10.40:1885/' + 'deptmv03',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV003confirmdata2(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      'http://172.23.10.40:1885/' + 'surfacemv03',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV003confirmdata3(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      'http://172.23.10.40:1885/' + 'surfacemv03',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV003CLEAR(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV003-CLEAR',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV003RESETVALUE(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV003-RESETVALUE',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV003SETZERO(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV003-SETZERO',
      data: {},
    );
    emit('');
  }

  //-------------------------------- FINISH
  //TRICKER_GASHMV003FINISH

  Future<void> _TRICKER_GASHMV003FINISH(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV003-FINISH',
      data: {},
    );
    emit('');
  }

  //-------------------------------- no request

  Future<void> _TRICKER_FLUSH(String toAdd, Emitter<String> emit) async {
    emit('');
  }
}
