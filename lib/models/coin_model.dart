import 'package:equatable/equatable.dart';

class CoinModel extends Equatable {
  final String name;
  final String fullName;
  final double price;

  CoinModel({required this.name, required this.fullName, required this.price});
  @override
  // TODO: implement props
  List<Object?> get props => [name, fullName, price];

  factory CoinModel.fromMap(Map<String, dynamic> map) {
    return CoinModel(
        name: map["CoinInfo"]["Name"] as String,
        fullName: map["CoinInfo"]["FullName"] as String,
        price: (map["RAW"]["USD"]["PRICE"] as num).toDouble());
  }
}
