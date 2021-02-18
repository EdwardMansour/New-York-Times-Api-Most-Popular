import 'package:equatable/equatable.dart';

import 'media-metadata.dart';

class Media extends Equatable {
  final String type;
  final String subtype;
  final String caption;
  final String copyright;
  final int approvedForSyndication;
  final List<MediaMetadata> mediaMetadata;

  Media({
    this.type,
    this.subtype,
    this.caption,
    this.copyright,
    this.approvedForSyndication,
    this.mediaMetadata,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        type: json["type"],
        subtype: json["subtype"],
        caption: json["caption"],
        copyright: json["copyright"],
        approvedForSyndication: json["approved_for_syndication"],
        mediaMetadata: List<MediaMetadata>.from(
            json["media-metadata"].map((x) => MediaMetadata.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "subtype": subtype,
        "caption": caption,
        "copyright": copyright,
        "approved_for_syndication": approvedForSyndication,
        "media-metadata":
            List<dynamic>.from(mediaMetadata.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [
        type,
        subtype,
        caption,
        copyright,
        approvedForSyndication,
        mediaMetadata,
      ];
}
