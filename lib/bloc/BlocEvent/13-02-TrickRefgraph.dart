import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/global.dart';

import '../../page/P13Refgraph/Refgraphvar.dart';
import '../../page/P1FIRSTUI/FIRSTuiVAR.dart';

//-------------------------------------------------
String server = GLOserver;

abstract class TRICKER_Event {}

//--------------------------------

class TRICKER_GETINtoRefgraph extends TRICKER_Event {}

//-------------------------------- non returnfunction

class TRICKER_RefgraphgeteachITEM extends TRICKER_Event {}

class TRICKER_RefgraphgeteachGRAPH extends TRICKER_Event {}

class TRICKER_Refgraphconfirmdata extends TRICKER_Event {}

class TRICKER_RefgraphCLEAR extends TRICKER_Event {}

class TRICKER_RefgraphRESETVALUE extends TRICKER_Event {}

class TRICKER_RefgraphSETZERO extends TRICKER_Event {}

//-------------------------------- FINISH

class TRICKER_RefgraphFINISH extends TRICKER_Event {}

//-------------------------------- no request

class TRICKER_FLUSH extends TRICKER_Event {}

class TRICKER_Refgraph_Bloc extends Bloc<TRICKER_Event, String> {
  TRICKER_Refgraph_Bloc() : super('') {
    //--------------------------------
    on<TRICKER_GETINtoRefgraph>((event, emit) {
      return _TRICKER_GETINtoRefgraph('', emit);
    });

    //-------------------------------- non returnfunction

    on<TRICKER_RefgraphgeteachITEM>((event, emit) {
      return _TRICKER_RefgraphgeteachITEM('', emit);
    });

    on<TRICKER_RefgraphgeteachGRAPH>((event, emit) {
      return _TRICKER_RefgraphgeteachGRAPH('', emit);
    });

    on<TRICKER_Refgraphconfirmdata>((event, emit) {
      return _TRICKER_Refgraphconfirmdata('', emit);
    });

    on<TRICKER_RefgraphCLEAR>((event, emit) {
      return _TRICKER_RefgraphCLEAR('', emit);
    });

    on<TRICKER_RefgraphRESETVALUE>((event, emit) {
      return _TRICKER_RefgraphRESETVALUE('', emit);
    });

    on<TRICKER_RefgraphSETZERO>((event, emit) {
      return _TRICKER_RefgraphSETZERO('', emit);
    });

    //-------------------------------- FINISH

    on<TRICKER_RefgraphFINISH>((event, emit) {
      return _TRICKER_RefgraphFINISH('', emit);
    });

    //-------------------------------- no request

    on<TRICKER_FLUSH>((event, emit) {
      return _TRICKER_FLUSH('', emit);
    });
  }

  Future<void> _TRICKER_GETINtoRefgraph(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'GETINtoRefgraph',
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

  Future<void> _TRICKER_RefgraphgeteachITEM(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'Refgraph-geteachITEM',
      data: {
        "ITEMs": Refgraphvar.ItemPickSELECT,
      },
    );
    emit('');
  }

  Future<void> _TRICKER_RefgraphgeteachGRAPH(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'Refgraph-geteachGRAPH',
      data: {
        "GAPname": Refgraphvar.GAPname,
      },
    );
    emit('');
  }

  Future<void> _TRICKER_Refgraphconfirmdata(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'Refgraph-confirmdata',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_RefgraphCLEAR(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'Refgraph-CLEAR',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_RefgraphRESETVALUE(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'Refgraph-RESETVALUE',
      data: {},
    );
    emit('');
  }

  Future<void> _TRICKER_RefgraphSETZERO(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'Refgraph-SETZERO',
      data: {},
    );
    emit('');
  }

  //-------------------------------- FINISH
  //TRICKER_RefgraphFINISH

  Future<void> _TRICKER_RefgraphFINISH(
      String toAdd, Emitter<String> emit) async {
    final response = await Dio().post(
      server + 'Refgraph-FINISH',
      data: {},
    );
    emit('');
  }

  //-------------------------------- no request

  Future<void> _TRICKER_FLUSH(String toAdd, Emitter<String> emit) async {
    emit('');
  }
}
