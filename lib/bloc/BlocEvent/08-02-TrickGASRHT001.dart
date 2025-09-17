import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/global.dart';
import '../../page/P1FIRSTUI/FIRSTuiVAR.dart';
import '../../page/P8GASRHT001/GASRHT001var.dart';

//-------------------------------------------------
String server = GLOserver;

abstract class TRICKER_Event {}

//--------------------------------

class TRICKER_GETINtoGASRHT001 extends TRICKER_Event {}

//-------------------------------- non returnfunction

class TRICKER_GASRHT001geteachITEM extends TRICKER_Event {}

class TRICKER_GASRHT001geteachGRAPH extends TRICKER_Event {}

class TRICKER_GASRHT001preview extends TRICKER_Event {}

class TRICKER_GASRHT001confirmdata extends TRICKER_Event {}

class TRICKER_GASRHT001CLEAR extends TRICKER_Event {}

class TRICKER_GASRHT001RESETVALUE extends TRICKER_Event {}

class TRICKER_GASRHT001SETZERO extends TRICKER_Event {}

//-------------------------------- FINISH

class TRICKER_GASRHT001FINISH extends TRICKER_Event {}

//-------------------------------- no request

class TRICKER_FLUSH extends TRICKER_Event {}

class TRICKER_GASRHT001_Bloc extends Bloc<TRICKER_Event, String> {
  TRICKER_GASRHT001_Bloc() : super('') {
    //--------------------------------
    on<TRICKER_GETINtoGASRHT001>((event, emit) {
      return _TRICKER_GETINtoGASRHT001('', emit);
    });

    //-------------------------------- non returnfunction

    on<TRICKER_GASRHT001geteachITEM>((event, emit) {
      return _TRICKER_GASRHT001geteachITEM('', emit);
    });

    on<TRICKER_GASRHT001geteachGRAPH>((event, emit) {
      return _TRICKER_GASRHT001geteachGRAPH('', emit);
    });

    on<TRICKER_GASRHT001preview>((event, emit) {
      return _TRICKER_GASRHT001preview('', emit);
    });

    on<TRICKER_GASRHT001confirmdata>((event, emit) {
      return _TRICKER_GASRHT001confirmdata('', emit);
    });

    on<TRICKER_GASRHT001CLEAR>((event, emit) {
      return _TRICKER_GASRHT001CLEAR('', emit);
    });

    on<TRICKER_GASRHT001RESETVALUE>((event, emit) {
      return _TRICKER_GASRHT001RESETVALUE('', emit);
    });

    on<TRICKER_GASRHT001SETZERO>((event, emit) {
      return _TRICKER_GASRHT001SETZERO('', emit);
    });

    //-------------------------------- FINISH

    on<TRICKER_GASRHT001FINISH>((event, emit) {
      return _TRICKER_GASRHT001FINISH('', emit);
    });

    //-------------------------------- no request

    on<TRICKER_FLUSH>((event, emit) {
      return _TRICKER_FLUSH('', emit);
    });
  }

  Future<void> _TRICKER_GETINtoGASRHT001(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GETINtoGASRHT001',
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

  Future<void> _TRICKER_GASRHT001geteachITEM(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASRHT001-geteachITEM',
      data: {
        "ITEMs": GASRHT001var.ItemPickSELECT,
      },
    );
    emit('');
  }

  Future<void> _TRICKER_GASRHT001geteachGRAPH(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASRHT001-geteachGRAPH',
      data: {
        "GAPname": GASRHT001var.GAPname,
      },
    );
    emit('');
  }

  Future<void> _TRICKER_GASRHT001preview(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASRHT001-preview',
      data: [
        {"V1": "LCRUVS", "V2": GASRHT001var.SINGLEINPUT}
      ],
    );
    if (response.statusCode == 200) {
      final response = await Dio().post(
        server + 'GASRHT001-confirmdata',
        data: {},
      );
    }
    emit('');
  }

  Future<void> _TRICKER_GASRHT001confirmdata(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASRHT001-confirmdata',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASRHT001CLEAR(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASRHT001-CLEAR',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASRHT001RESETVALUE(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASRHT001-RESETVALUE',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_GASRHT001SETZERO(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASRHT001-SETZERO',
      data: {},
    );
    emit('');
  }

  //-------------------------------- FINISH
  //TRICKER_GASRHT001FINISH

  Future<void> _TRICKER_GASRHT001FINISH(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GASRHT001-FINISH',
      data: {},
    );
    emit('');
  }

  //-------------------------------- no request

  Future<void> _TRICKER_FLUSH(String toAdd, Emitter<String> emit) async {
    emit('');
  }
}
