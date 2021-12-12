part of 'crypto_bloc.dart';

enum CryptoStatus { initial, loading, loaded, error }

class CryptoState extends Equatable {
  final List<CoinModel> coinList;
  final CryptoStatus status;
  final Failure failure;

  const CryptoState(
      {required this.coinList, required this.status, required this.failure});

  @override
  List<Object> get props => [coinList, status, failure];

  factory CryptoState.initial () => CryptoState(coinList: [], status: CryptoStatus.initial, failure: Failure()); 

  CryptoState copyWith(
      {List<CoinModel>? coins, CryptoStatus? status, Failure? failure}) {
    return CryptoState(
        coinList: coins?? this.coinList,
        status: status ?? this.status,
        failure: failure ?? this.failure);
  }
}
