class LandModel {
  int? count;
  List<BaseLandModel>? results;

  String? errorMsg;

  LandModel.fromJson(List json) {
    results = [];
    count = json.length;
    if (json.isEmpty) {
      return;
    }
    for (List i in json) {
      results!.add(
        BaseLandModel(
          id: i[0].toString(),
          location: i[1].toString(),
          area: i[2].toString(),
          pricePerArea: i[3].toString(),
          owner: i[4].toString(),
          isListed: i[5],
        ),
      );
    }
  }

  LandModel.withError(String errorMessage) {
    errorMsg = errorMessage;
  }
}

class BaseLandModel {
  final String id;
  final String location;
  final String area;
  String pricePerArea;
  final String owner;
  bool isListed;
  bool isLoading;

  BaseLandModel({
    required this.id,
    required this.location,
    required this.area,
    required this.pricePerArea,
    required this.owner,
    required this.isListed,
    this.isLoading = false,
  });
}
