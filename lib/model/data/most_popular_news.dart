import 'package:equatable/equatable.dart';
import 'package:ny_times/model/data/results.dart';

class MostPopularData extends Equatable {
  final String status;
  final String copyright;
  final int numResults;
  final List<Result> results;

  MostPopularData({
    this.status,
    this.copyright,
    this.numResults,
    this.results,
  });

  factory MostPopularData.fromJson(Map<String, dynamic> json) =>
      MostPopularData(
        status: json["status"],
        copyright: json["copyright"],
        numResults: json["num_results"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))) ??
                [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "copyright": copyright,
        "num_results": numResults,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [
        status,
        copyright,
        numResults,
        results,
      ];
}
