import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wire_viewer/form_event/form_submission_status.dart';
import 'package:wire_viewer/models/Item.dart';
import 'package:wire_viewer/screens/home/bloC/home_event.dart';
import 'package:wire_viewer/screens/home/bloC/home_state.dart';
import 'package:wire_viewer/screens/home/repository/home_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository? repo = new HomeRepository();

  HomeBloc() : super(HomeState()) {
    on<HomeEvent>((event, emit) async {
      await mapEventToState(event, emit);
    });
  }

  Future mapEventToState(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is LoadData) {
      await loadData(emit);
    }
  }

  Future<void> loadData(Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(formStatus: FormSubmitting()));
      var type = "the+wire+characters";
      String? response = await repo?.getCharacters(type);
      print(response);
      var responseData = jsonDecode(response!);
      if (responseData['RelatedTopics'].length > 0) {
        print(responseData['RelatedTopics']);
        for (var data in responseData['RelatedTopics']) {
          var image = '';
          var title = '';
          if (data['Icon']['URL'].toString() != '') {
            image = "https://duckduckgo.com" + data['Icon']['URL'].toString();
          }
          if (data['FirstURL'].toString() != '') {
            var temp_title = data['FirstURL'].toString().split('/');
            title = temp_title[temp_title.length - 1];
            title = title.replaceAll(RegExp('_'), ' ');
          }
          items.add(
            Item(
              title: title,
              description: data['Text'].toString(),
              image: image,
            ),
          );
        }
      }
      emit(state.copyWith(formStatus: SubmissionSuccess()));
    } catch (e) {
      print('Message: ' + e.toString());
      emit(state.copyWith(
          formStatus:
              SubmissionFailed("Something went wrong " + e.toString())));
    }
  }
}
