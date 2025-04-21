import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/global.dart';
import '../../page/P1FIRSTUI/FIRSTuiVAR.dart';
import '../../page/P3GASHMV001/GASHMV001var.dart';

//-------------------------------------------------
String server = GLOserver;
String serverAUTO = GLOserver;

abstract class TRICKER_Event {}

//--------------------------------

class TRICKER_GETINtoGASHMV001 extends TRICKER_Event {}

//-------------------------------- non returnfunction

class TRICKER_GASHMV001geteachITEM extends TRICKER_Event {}

class TRICKER_GASHMV001geteachGRAPH extends TRICKER_Event {}

class TRICKER_GASHMV001confirmdata extends TRICKER_Event {}

class TRICKER_GASHMV001confirmdata1 extends TRICKER_Event {}

class TRICKER_GASHMV001confirmdata2 extends TRICKER_Event {}

class TRICKER_GASHMV001confirmdata3 extends TRICKER_Event {}

class TRICKER_GASHMV001CLEAR extends TRICKER_Event {}

class TRICKER_GASHMV001RESETVALUE extends TRICKER_Event {}

class TRICKER_GASHMV001SETZERO extends TRICKER_Event {}

//-------------------------------- FINISH

class TRICKER_GASHMV001FINISH extends TRICKER_Event {}

//-------------------------------- no request

class TRICKER_FLUSH extends TRICKER_Event {}

class TRICKER_GASHMV001_Bloc extends Bloc<TRICKER_Event, String> {
  TRICKER_GASHMV001_Bloc() : super('') {
    //--------------------------------
    on<TRICKER_GETINtoGASHMV001>((event, emit) {
      return _TRICKER_GETINtoGASHMV001('', emit);
    });

    //-------------------------------- non returnfunction

    on<TRICKER_GASHMV001geteachITEM>((event, emit) {
      return _TRICKER_GASHMV001geteachITEM('', emit);
    });

    on<TRICKER_GASHMV001geteachGRAPH>((event, emit) {
      return _TRICKER_GASHMV001geteachGRAPH('', emit);
    });

    on<TRICKER_GASHMV001confirmdata>((event, emit) {
      return _TRICKER_GASHMV001confirmdata('', emit);
    });

    on<TRICKER_GASHMV001confirmdata1>((event, emit) {
      return _TRICKER_GASHMV001confirmdata1('', emit);
    });

    on<TRICKER_GASHMV001confirmdata2>((event, emit) {
      return _TRICKER_GASHMV001confirmdata2('', emit);
    });

    on<TRICKER_GASHMV001confirmdata3>((event, emit) {
      return _TRICKER_GASHMV001confirmdata3('', emit);
    });

    on<TRICKER_GASHMV001CLEAR>((event, emit) {
      return _TRICKER_GASHMV001CLEAR('', emit);
    });

    on<TRICKER_GASHMV001RESETVALUE>((event, emit) {
      return _TRICKER_GASHMV001RESETVALUE('', emit);
    });

    on<TRICKER_GASHMV001SETZERO>((event, emit) {
      return _TRICKER_GASHMV001SETZERO('', emit);
    });

    //-------------------------------- FINISH

    on<TRICKER_GASHMV001FINISH>((event, emit) {
      return _TRICKER_GASHMV001FINISH('', emit);
    });

    //-------------------------------- no request

    on<TRICKER_FLUSH>((event, emit) {
      return _TRICKER_FLUSH('', emit);
    });
  }

  Future<void> _TRICKER_GETINtoGASHMV001(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GETINtoGASHMV001',
      data: {
        "PO": FIRSTUI.POACTIVE,
        "CP": FIRSTUI.CPACTIVE,
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

  Future<void> _TRICKER_GASHMV001geteachITEM(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV001-geteachITEM',
      data: {
        "ITEMs": GASHMV001var.ItemPickSELECT,
      },
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV001geteachGRAPH(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV001-geteachGRAPH',
      data: {
        "GAPname": GASHMV001var.GAPname,
      },
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV001confirmdata(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV001-confirmdata',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV001confirmdata1(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      'http://172.101.33.151:1880/' + 'deptmv01',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV001confirmdata2(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      'http://172.101.33.151:1880/' + 'surfacemv01',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV001confirmdata3(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      'http://172.101.33.151:1880/' + 'surfacemv01',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV001CLEAR(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV001-CLEAR',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV001RESETVALUE(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV001-RESETVALUE',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASHMV001SETZERO(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV001-SETZERO',
      data: {},
    );
    emit('');
  }

  //-------------------------------- FINISH
  //TRICKER_GASHMV001FINISH

  Future<void> _TRICKER_GASHMV001FINISH(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASHMV001-FINISH',
      data: {},
    );
    emit('');
  }

  //-------------------------------- no request

  Future<void> _TRICKER_FLUSH(String toAdd, Emitter<String> emit) async {
    emit('');
  }
}
