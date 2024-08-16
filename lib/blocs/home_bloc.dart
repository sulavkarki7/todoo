import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todoo/models/task_list.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<TaskTileTapped>(_taskTileTapped);
    on<RemoveTask>(_removeTask);
    on<EditTask>(_editTask);
  }
}

FutureOr<void> _taskTileTapped(TaskTileTapped event, Emitter<HomeState> emit) {}

FutureOr<void> _removeTask(RemoveTask event, Emitter<HomeState> emit) {}

FutureOr<void> _editTask(EditTask event, Emitter<HomeState> emit) {}
