import 'package:flutter/cupertino.dart';
import 'package:ny_times/model/data/most_popular_news.dart';
import 'package:ny_times/model/data/results.dart';
import 'package:ny_times/model/repositories/ny_times_most_popular_repo.dart';

class HomeProvider extends ChangeNotifier {
  final NyTimesMostPopularRepo repo;

  HomeProvider({
    @required this.repo,
  });

  //! initialise variables
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

  //! set loading value
  setLoadingValue(bool value) {
    isLoading = value;
    notifyListeners();
  }

  //! set opended value
  setIsOpenedValue(bool value, int index) {
    openSectionBellow = value;
    indexResult = index;
    notifyListeners();
  }

  //! set opended value
  setResuts(List<Result> r) {
    results = r;
    notifyListeners();
  }

  //! set error value
  setErrorMessage(String value) {
    errorMessage = value;
    notifyListeners();
  }

  //! set loading value
  setSearchIsClickedOrNot(bool value) {
    onSearchClick = value;
    searchList = [];
    notifyListeners();
  }

  //! set date value
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

  //! Search function
  setChangeTypingWords(String value) {
    if (value != '') {
      RegExp exp = new RegExp(
        r"(?<![\w\d])" + value + "(?![\w\d])",
        caseSensitive: false,
        multiLine: false,
      );
      searchList = results
          .where(
            (element) => exp.hasMatch(element.title),
          )
          .toList();
    } else
      searchList = results;

    notifyListeners();
  }

  //! get news list
  Future<void> getNews(String section, int time) async {
    setLoadingValue(true);
    try {
      searchList = [];
      results = [];
      data = await repo.fetchNews(section, time);
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
