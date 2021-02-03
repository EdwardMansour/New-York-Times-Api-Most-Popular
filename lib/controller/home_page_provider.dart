import 'package:flutter/cupertino.dart';
import 'package:ny_times/core/dependency-injection.dart';
import 'package:ny_times/model/data/most_popular_news.dart';
import 'package:ny_times/model/data/results.dart';
import 'package:ny_times/model/repositories/ny_times_most_popular_repo.dart';

class HomeProvider extends ChangeNotifier {
  //todo: initialise variables
  //! loading variable
  bool isLoading = false;
  MostPopularData data;
  String errorMessage;
  List<Result> results = [];
  List<Result> searchList = [];
  bool onSearchClick = false;
  int datePicker = 0;
  int indexResult;
  bool openSectionBellow = false;
  List<String> chooseDate = [
    'Daily',
    'Weekly',
    'Monthly',
  ];

  //todo: set loading value
  setLoadingValue(bool value) {
    isLoading = value;
    notifyListeners();
  }

  //todo: set opended value
  setIsOpenedValue(bool value, int index) {
    openSectionBellow = value;
    indexResult = index;
    notifyListeners();
  }

  //todo: set error value
  setErrorMessage(String value) {
    errorMessage = value;
    notifyListeners();
  }

  //todo: set loading value
  setSearchIsClickedOrNot(bool value) {
    onSearchClick = value;
    notifyListeners();
  }

  //todo: set date value
  setDateValue(String value) {
    datePicker = chooseDate.indexWhere((element) => element == value);
    notifyListeners();
    getNews(
      'all-sections',
      datePicker == 0
          ? 1
          : datePicker == 1
              ? 7
              : 30,
    );
  }

  //todo: search function
  setChangeTypingWords(String value) {
    RegExp exp = new RegExp(
      "\\b" + value + "\\b",
      caseSensitive: false,
    );
    searchList = results.where(
      (element) {
        bool containe = exp.hasMatch(element.title);
        return containe;
      },
    ).toList();
    notifyListeners();
  }

  //todo: get news list
  Future<void> getNews(String section, int time) async {
    setLoadingValue(true);
    try {
      data = await sl<NyTimesMostPopularRepo>().fetchNews(section, time);
      if (data != null) {
        data.results.sort((a, b) => a.publishedDate.compareTo(b.publishedDate));
        results = data.results;
      }
      notifyListeners();
      setLoadingValue(false);
    } catch (e) {
      setErrorMessage('$e');
      setLoadingValue(false);
    }
  }
}
