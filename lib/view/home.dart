import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ny_times/controller/home_page_provider.dart';
import 'package:ny_times/core/gloable_variables.dart';
import 'package:ny_times/view/sub_widgets/news_item_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeProvider homeProvider;
  final TextEditingController searchTextCntrlr = TextEditingController();
  final FocusNode _searchTextFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getMethods(context));
  }

  getMethods(context) {
    homeProvider.getNews('all-sections', 1);
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return Consumer<HomeProvider>(builder: (context, prov, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        //todo : the drawer => empty
        drawer: Drawer(
            child: Container(
          color: Colors.white,
        ) // Populate the Drawer in the next step.
            ),
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          //todo: title text
          title: prov.onSearchClick
              ? Container(
                  child: TextFormField(
                    onChanged: (value) {
                      prov.setChangeTypingWords(value);
                    },
                    focusNode: _searchTextFocus,
                    onFieldSubmitted: (value) {
                      _searchTextFocus.unfocus();
                    },
                    onTap: null,
                    controller: searchTextCntrlr,
                    decoration: InputDecoration(
                      hintText: ' Search for Article',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : Text(
                  'NY Times Most Popular',
                  overflow: TextOverflow.fade,
                ),
          actions: [
            //todo: search icon
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(right: 19.0),
                child: Icon(
                  prov.onSearchClick ? Icons.close : Icons.search,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              onTap: () {
                prov.setSearchIsClickedOrNot(!prov.onSearchClick);
                searchTextCntrlr.text = '';
              },
            ),
            // todo: more icon that I want to use for changing the date
            GestureDetector(
              child: PopupMenuButton<String>(
                captureInheritedThemes: true,
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                initialValue: prov.chooseDate[prov.datePicker],
                itemBuilder: (BuildContext context) {
                  return prov.chooseDate.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
                onCanceled: () {
                  print('You have not chossed anything');
                },
                onSelected: (value) {
                  //todo : Set the value of date that I want to choose
                  prov.setDateValue(value);
                },
              ),
            ),
          ],
        ),
        body: GestureDetector(
          // onTap: () => _searchTextFocus.unfocus(),
          child: Center(
            child: prov.results.isEmpty || prov.isLoading
                // todo: loading view
                ? prov.errorMessage != null
                    ? Text(
                        prov.errorMessage,
                      )
                    : CircularProgressIndicator(
                        backgroundColor: Colors.greenAccent,
                      )
                : prov.results.isNotEmpty
                    //todo: list of news
                    ? ListView.builder(
                        itemCount: prov.searchList.isEmpty
                            ? prov.data.results.length
                            : prov.searchList.length,
                        itemBuilder: (BuildContext context, int index) {
                          //todo: widget of the item
                          return NewsItemWidget(
                            index: index,
                            openSectionBellow: prov.indexResult != null &&
                                index == prov.indexResult &&
                                prov.openSectionBellow,
                            showingDetails: (index, openSectionBellow) =>
                                prov.setIsOpenedValue(
                              !openSectionBellow,
                              index,
                            ),
                            height: height * 0.15,
                            width: width,
                            title: prov.searchList.isEmpty
                                ? prov.results[index].title
                                : prov.searchList[index].title,
                            date: prov.searchList.isEmpty
                                ? prov.results[index].publishedDate
                                : prov.searchList[index].publishedDate,
                            byLine: prov.searchList.isEmpty
                                ? prov.results[index].byline
                                : prov.searchList[index].byline,
                            image: prov.searchList.isEmpty
                                ? prov.results[index].media.isEmpty
                                    ? null
                                    : prov.results[index].media[0]
                                        .mediaMetadata[0].url
                                : prov.searchList[index].media[0]
                                    .mediaMetadata[0].url,
                            section: prov.searchList.isEmpty
                                ? prov.results[index].section
                                : prov.searchList[index].section,
                            abstracT: prov.searchList.isEmpty
                                ? prov.results[index].resultAbstract
                                : prov.searchList[index].resultAbstract,
                          );
                        },
                      )
                    : Container(),
          ),
        ),
      );
    });
  }
}
