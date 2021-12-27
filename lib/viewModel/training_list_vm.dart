// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localjsonwithfilter/model/training_model.dart';

class TrainingListVM extends ChangeNotifier {
  List<Training> allTraining = [];
  List<Training> searchTraining = [];

  List<String> name = [];
  List<String> speakerName = [];
  List<String> speakerLanguage = [];
  List<String> location = [];

  List<String> searchName = [];
  List<String> searchSpeakerName = [];
  List<String> searchSpeakerLanguage = [];
  List<String> searchLocation = [];

  List<String> filterName = [];
  List<String> filterSpeakerName = [];
  List<String> filterSpeakerLanguage = [];
  List<String> filterLocation = [];

  Future loadData() async {
    final response =
        await rootBundle.loadString('assets/json/training_json.json');

    TrainingModel trainingModel = trainingModelFromJson(response);
    List<Training>? list = trainingModel.trainings;

    allTraining = list!;
    searchTraining = list;

    allTraining.forEach((element) {
      name.add(element.name!);
    });
    searchName = name;

    allTraining.forEach((element) {
      location.add(element.deadline!.location!);
    });
    searchLocation = location;

    allTraining.forEach((element) {
      speakerName.add(element.speaker!.name!);
    });
    searchSpeakerName = speakerName;

    allTraining.forEach((element) {
      speakerLanguage.add(element.speaker!.language!);
    });
    searchSpeakerLanguage = speakerLanguage;

    notifyListeners();
  }

  filterData() {
    // check if selected list is not empty
    if (filterName.isNotEmpty ||
        filterLocation.isNotEmpty ||
        filterSpeakerName.isNotEmpty ||
        filterSpeakerLanguage.isNotEmpty) {
      searchTraining = allTraining
          .where((element) =>
              filterName.contains(element.name) ||
              filterLocation.contains(element.deadline!.location) ||
              filterSpeakerName.contains(element.speaker!.name) ||
              filterSpeakerLanguage.contains(element.speaker!.language))
          .toList();
    }

    notifyListeners();
  }

  searchData({required String filterType, required String search}) {
    if (filterType == 'location') {
      searchLocation = location
          .where(
              (element) => element.toLowerCase().contains(search.toLowerCase()))
          .toList();
    } else if (filterType == 'speakerName') {
      searchSpeakerName = speakerName
          .where(
              (element) => element.toLowerCase().contains(search.toLowerCase()))
          .toList();
    } else if (filterType == 'speakerLanguage') {
      searchSpeakerLanguage = speakerLanguage
          .where(
              (element) => element.toLowerCase().contains(search.toLowerCase()))
          .toList();
    } else {
      searchName = name
          .where(
              (element) => element.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }

    notifyListeners();
  }

  clearFilterData() {
    searchTraining = allTraining;
    notifyListeners();
  }
}
