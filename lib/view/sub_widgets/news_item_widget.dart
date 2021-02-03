import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsItemWidget extends StatelessWidget {
  final int index;
  final double height;
  final double width;
  final bool openSectionBellow;
  final String title;
  final String abstracT;
  final String byLine;
  final String section;
  final DateTime date;
  final Function showingDetails;
  final String image;
  NewsItemWidget({
    Key key,
    this.height = 0,
    this.width = 0,
    this.title,
    this.byLine,
    this.date,
    this.image,
    this.showingDetails,
    this.section,
    this.openSectionBellow = false,
    this.index,
    this.abstracT,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return GestureDetector(
      onTap: () => showingDetails(index, openSectionBellow),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //todo: spacing
                spacing(null, width * 0.05),
                //Todo: image
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: image != null
                        ? FadeInImage.assetNetwork(
                            placeholder: 'lib/assets/image.png',
                            image: image,
                          )
                        : Image(
                            image: AssetImage('lib/assets/image.png'),
                          ),
                  ),
                ),
                //todo: column on texts and date
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.only(left: 11.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //todo: spacing
                        spacing(height * 0.1, null),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: width * 0.04,
                                ),
                              ),
                            ),
                          ],
                        ),
                        //todo: spacinge
                        spacing(height * 0.1, null),
                        // todo: byLine text
                        Text(
                          byLine,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                        //todo: spacing
                        spacing(height * 0.05, null),
                        //todo: section and date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            //todo: section name
                            Expanded(
                              child: Text(
                                section,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            //todo: calendar and date
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: height * 0.15,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    formattedDate,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // todo: arrow of showing details
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      openSectionBellow
                          ? Icons.keyboard_arrow_down
                          : Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
            spacing(height * 0.1, null),
            openSectionBellow
                ? Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 80.0,
                            right: 20,
                          ),
                          child: Text(
                            abstracT,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  // spacing function
  Widget spacing(height, width) {
    return SizedBox(
      height: height != null ? height : 0,
      width: width != null ? width : 0,
    );
  }
}
