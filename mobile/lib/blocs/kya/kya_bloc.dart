import 'dart:async';

import 'package:app/models/models.dart';
import 'package:app/services/services.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'kya_bloc.g.dart';
part 'kya_event.dart';
part 'kya_state.dart';

class KyaBloc extends HydratedBloc<KyaEvent, KyaState> {
  KyaBloc() : super(const KyaState(lessons: [], quizzes: [])) {
    on<UpdateKyaProgress>(_onUpdateKyaProgress);
    on<ClearKya>(_onClearKya);
    on<FetchKya>(_onFetchKya);
    on<FetchQuizzes>(_onFetchQuizzes);
    on<UpdateQuizProgress>(_onUpdateQuizProgress);
    on<ShuffleQuizQuestions>(_onShuffleQuizQuestions);
    on<ClearQuizzes>(_onClearQuizzes);
  }

  void _onShuffleQuizQuestions(
    ShuffleQuizQuestions shuffleQuizQuestions,
    Emitter<KyaState> emit,
  ) {
    Quiz quiz = shuffleQuizQuestions.quiz;
    quiz.questions.shuffle();

    // update quiz in state
    List<Quiz> quizzes = state.quizzes;
    quizzes.removeWhere((element) => element.id == quiz.id);
    quizzes.add(quiz);
    //

    emit(state.copyWith(quizzes: quizzes));
  }

  Future<void> _onFetchQuizzes(
    FetchQuizzes _,
    Emitter<KyaState> emit,
  ) async {
    final userId = CustomAuth.getUserId();
    List<Quiz> quizzes = await AirqoApiClient().fetchQuizzes(userId);
    emit(state.copyWith(quizzes: quizzes));
  }

  Future<void> _onFetchKya(
    FetchKya _,
    Emitter<KyaState> emit,
  ) async {
    final userId = CustomAuth.getUserId();
    List<KyaLesson> lessons = await AirqoApiClient().fetchKyaLessons(userId);
    emit(state.copyWith(lessons: lessons));
  }

  Future<void> _onClearKya(ClearKya _, Emitter<KyaState> emit) async {
    final userId = CustomAuth.getUserId();
    List<KyaLesson> kyaLessons = await AirqoApiClient().fetchKyaLessons(userId);
    if (kyaLessons.isEmpty) {
      kyaLessons = state.lessons
          .map((e) => e.copyWith(
                status: KyaLessonStatus.todo,
                activeTask: 1,
              ))
          .toList();
    }

    emit(KyaState(lessons: kyaLessons, quizzes: const []));
  }

  Future<void> _onUpdateKyaProgress(
    UpdateKyaProgress event,
    Emitter<KyaState> emit,
  ) async {
    KyaLesson kyaLesson = event.kyaLesson;
    Set<KyaLesson> kyaLessons = state.lessons.toSet();
    kyaLessons.remove(kyaLesson);
    kyaLessons.add(kyaLesson);
    emit(state.copyWith(lessons: kyaLessons.toList()));
    if (event.updateRemote) {
      final userId = CustomAuth.getUserId();
      if ((userId.isNotEmpty)) {
        await AirqoApiClient().syncKyaProgress(kyaLessons.toList(), userId);
      }
    }
  }

  Future<void> _onClearQuizzes(ClearQuizzes _, Emitter<KyaState> emit) async {
    final userId = CustomAuth.getUserId();
    List<Quiz> quizzes = await AirqoApiClient().fetchQuizzes(userId);
    if (quizzes.isEmpty) {
      quizzes = state.quizzes
          .map((e) => e.copyWith(
                status: QuizStatus.todo,
                activeQuestion: 1,
              ))
          .toList();
    }

    emit(KyaState(quizzes: quizzes, lessons: const []));
  }

  Future<void> _onUpdateQuizProgress(
    UpdateQuizProgress event,
    Emitter<KyaState> emit,
  ) async {
    Quiz quiz = event.quiz;
    Set<Quiz> quizzes = state.quizzes.toSet();
    quizzes.remove(quiz);
    quizzes.add(quiz);
    emit(state.copyWith(quizzes: quizzes.toList()));
    if (event.updateRemote) {
      final userId = CustomAuth.getUserId();
      if ((userId.isNotEmpty)) {
        await AirqoApiClient().syncQuizProgress(quizzes.toList(), userId);
      }
    }
  }

  @override
  KyaState? fromJson(Map<String, dynamic> json) {
    return KyaState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(KyaState state) {
    return state.toJson();
  }
}
