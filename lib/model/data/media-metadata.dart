import 'package:equatable/equatable.dart';

class MediaMetadata extends Equatable {
  final String url;
  final String format;
  final int height;
  final int width;

  MediaMetadata({
    this.url,
    this.format,
    this.height,
    this.width,
  });

  factory MediaMetadata.fromJson(Map<String, dynamic> json) => MediaMetadata(
        url: json["url"],
        format: json["format"],
        height: json["height"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "format": format,
        "height": height,
        "width": width,
      };

  @override
  List<Object> get props => [
        url,
        format,
        height,
        width,
      ];
}
