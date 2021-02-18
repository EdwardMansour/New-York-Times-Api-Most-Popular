import 'package:flutter_test/flutter_test.dart';
import 'package:ny_times/controller/home_page_provider.dart';
import 'package:ny_times/core/dependency-injection.dart';
import 'package:ny_times/model/data/results.dart';

main() {
  //! set up all your variables here
  init();
  final prov = sl<HomeProvider>();
  test('set the loading value to true function', () {
    prov.setLoadingValue(true);
    expect(prov.isLoading, true);
  });
  test(
      'Set the correct time to set into the request by matching the chosen value with the other in the list and get the index number',
      () {
    prov.setDateValue('Weekly');
    expect(prov.datePicker, 1);
  });

  test(
      'Set is open value as her name => true for opening and false for the closing',
      () {
    prov.setIsOpenedValue(true, 1);
    expect(prov.openSectionBellow, true);
    expect(prov.indexResult, 1);
  });

  test('Set onSearchClick is true or false and set the search list to empty',
      () {
    prov.setSearchIsClickedOrNot(true);
    expect(prov.onSearchClick, true);
    expect(prov.searchList, []);
  });
  test('Set error message', () {
    prov.setErrorMessage('Error message');
    expect(prov.errorMessage, 'Error message');
  });

  test('Fetch the list that contain that name', () {
    prov.results.addAll([
      new Result(title: 'edward go home'),
      new Result(title: 'elie go home'),
      new Result(title: 'Joseph go home'),
      new Result(title: 'go home edward')
    ]);
    prov.setChangeTypingWords('Edward');
    expect(prov.searchList, [
      new Result(title: 'edward go home'),
      new Result(title: 'go home edward')
    ]);
  });

  test('Get the Data by API request and hange in value that control the page',
      () async {
    await prov.getNews('all-sections', 1);
    expect(prov.data.status, 'OK');
  });
}
