import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/BlocEvent/09-CLEARroom.dart';
import '../../styles/TextStyle.dart';

class ClearRoomMAIN extends StatelessWidget {
  ClearRoomMAIN({Key? key, this.data}) : super(key: key);
  CLEARroomENV? data;
  @override
  Widget build(BuildContext context) {
    return ClearRoomBODY(
      data: data,
    );
  }
}

class ClearRoomBODY extends StatefulWidget {
  ClearRoomBODY({Key? key, this.data}) : super(key: key);
  CLEARroomENV? data;

  @override
  State<ClearRoomBODY> createState() => _ClearRoomBODYState();
}

class _ClearRoomBODYState extends State<ClearRoomBODY> {
  // String? PO1;
  void initState() {
    super.initState();
    context.read<CLEARroom_Bloc>().add(CLEARroom_READ());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 700,
      height: 500,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(0)),
      ),
      child: SizedBox(
        width: 700,
        height: 500,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: const Center(
                          child: Text(
                            "PO",
                            style: TxtStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: const Center(
                          child: Text(
                            "CLEAR",
                            style: TxtStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Center(
                          child: Text(
                            "APP-GAS12 : ${widget.data?.PO1 ?? ""}",
                            style: TxtStyle(
                              fontWeight: FontWeight.bold,
                              color: widget.data!.PO1 == ''
                                  ? Colors.black
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.all(5),
                          child: InkWell(
                            onTap: () {
                              //
                              CLEARroomdata.room = 'PO1';
                              context
                                  .read<CLEARroom_Bloc>()
                                  .add(CLEARroom_CLEAR());
                            },
                            child: Container(
                              color: Colors.blue,
                              child: const Center(
                                child: Text(
                                  "CLEAR",
                                  style: TxtStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Center(
                          child: Text(
                            "GAS-HMV-001 : ${widget.data?.PO2 ?? ""}",
                            style: TxtStyle(
                              fontWeight: FontWeight.bold,
                              color: widget.data!.PO2 == ''
                                  ? Colors.black
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.all(5),
                          child: InkWell(
                            onTap: () {
                              //
                              CLEARroomdata.room = 'PO2';
                              context
                                  .read<CLEARroom_Bloc>()
                                  .add(CLEARroom_CLEAR());
                            },
                            child: Container(
                              color: Colors.blue,
                              child: const Center(
                                child: Text(
                                  "CLEAR",
                                  style: TxtStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Center(
                          child: Text(
                            "GAS-HMV-002 : ${widget.data?.PO3 ?? ""}",
                            style: TxtStyle(
                              fontWeight: FontWeight.bold,
                              color: widget.data!.PO3 == ''
                                  ? Colors.black
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.all(5),
                          child: InkWell(
                            onTap: () {
                              //
                              CLEARroomdata.room = 'PO3';
                              context
                                  .read<CLEARroom_Bloc>()
                                  .add(CLEARroom_CLEAR());
                            },
                            child: Container(
                              color: Colors.blue,
                              child: const Center(
                                child: Text(
                                  "CLEAR",
                                  style: TxtStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Center(
                          child: Text(
                            "GAS-HMV-003 : ${widget.data?.PO4 ?? ""}",
                            style: TxtStyle(
                              fontWeight: FontWeight.bold,
                              color: widget.data!.PO4 == ''
                                  ? Colors.black
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.all(5),
                          child: InkWell(
                            onTap: () {
                              //
                              CLEARroomdata.room = 'PO4';
                              context
                                  .read<CLEARroom_Bloc>()
                                  .add(CLEARroom_CLEAR());
                            },
                            child: Container(
                              color: Colors.blue,
                              child: const Center(
                                child: Text(
                                  "CLEAR",
                                  style: TxtStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Center(
                          child: Text(
                            "GAS-VIC-001 : ${widget.data?.PO5 ?? ""}",
                            style: TxtStyle(
                              fontWeight: FontWeight.bold,
                              color: widget.data!.PO5 == ''
                                  ? Colors.black
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.all(5),
                          child: InkWell(
                            onTap: () {
                              //
                              CLEARroomdata.room = 'PO5';
                              context
                                  .read<CLEARroom_Bloc>()
                                  .add(CLEARroom_CLEAR());
                            },
                            child: Container(
                              color: Colors.blue,
                              child: const Center(
                                child: Text(
                                  "CLEAR",
                                  style: TxtStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Center(
                          child: Text(
                            "GAS-MCS-002 : ${widget.data?.PO6 ?? ""}",
                            style: TxtStyle(
                              fontWeight: FontWeight.bold,
                              color: widget.data!.PO6 == ''
                                  ? Colors.black
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.all(5),
                          child: InkWell(
                            onTap: () {
                              //
                              CLEARroomdata.room = 'PO6';
                              context
                                  .read<CLEARroom_Bloc>()
                                  .add(CLEARroom_CLEAR());
                            },
                            child: Container(
                              color: Colors.blue,
                              child: const Center(
                                child: Text(
                                  "CLEAR",
                                  style: TxtStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Center(
                          child: Text(
                            "GAS-RHT-001 : ${widget.data?.PO7 ?? ""}",
                            style: TxtStyle(
                              fontWeight: FontWeight.bold,
                              color: widget.data!.PO7 == ''
                                  ? Colors.black
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.all(5),
                          child: InkWell(
                            onTap: () {
                              //
                              CLEARroomdata.room = 'PO7';
                              context
                                  .read<CLEARroom_Bloc>()
                                  .add(CLEARroom_CLEAR());
                            },
                            child: Container(
                              color: Colors.blue,
                              child: const Center(
                                child: Text(
                                  "CLEAR",
                                  style: TxtStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Center(
                          child: Text(
                            "GAS-OHR-001 : ${widget.data?.PO8 ?? ""}",
                            style: TxtStyle(
                              fontWeight: FontWeight.bold,
                              color: widget.data!.PO8 == ''
                                  ? Colors.black
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.all(5),
                          child: InkWell(
                            onTap: () {
                              //
                              CLEARroomdata.room = 'PO8';
                              context
                                  .read<CLEARroom_Bloc>()
                                  .add(CLEARroom_CLEAR());
                            },
                            child: Container(
                              color: Colors.blue,
                              child: const Center(
                                child: Text(
                                  "CLEAR",
                                  style: TxtStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Center(
                          child: Text(
                            "REF-GRAPH : ${widget.data?.PO9 ?? ""}",
                            style: TxtStyle(
                              fontWeight: FontWeight.bold,
                              color: widget.data!.PO9 == ''
                                  ? Colors.black
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.all(5),
                          child: InkWell(
                            onTap: () {
                              //
                              CLEARroomdata.room = 'PO9';
                              context
                                  .read<CLEARroom_Bloc>()
                                  .add(CLEARroom_CLEAR());
                            },
                            child: Container(
                              color: Colors.blue,
                              child: const Center(
                                child: Text(
                                  "CLEAR",
                                  style: TxtStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
