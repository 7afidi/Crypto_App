import 'package:bloc/bloc.dart';
import 'package:crypto_app/models/coin_model.dart';
import 'package:crypto_app/models/failure_model.dart';
import 'package:crypto_app/repositories/crypto_repository.dart';
import 'package:equatable/equatable.dart';
part 'crypto_event.dart';
part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final CryptoRepository _cryptoRepository;
  CryptoBloc({required CryptoRepository cryptoRepository})
      : _cryptoRepository = cryptoRepository,
        super(CryptoState.initial());

  @override
  Stream<CryptoState> mapEventToState(CryptoEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedState();
    } else if (event is RefreshCoins) {
      yield* _getCoins();
    } else if (event is LoadMoreCoins) {
      yield* _mapLoadMoreCoins();
    }
  }

  Stream<CryptoState> _mapAppStartedState() async* {
   yield state.copyWith(status: CryptoStatus.loading);
    yield* _getCoins();
    // request to get coins
   
  }

  Stream<CryptoState> _mapLoadMoreCoins() async* {
    final nextPage = state.coinList.length ~/ CryptoRepository.perPage;
    yield* _getCoins(page: nextPage);
  }

  Stream<CryptoState> _getCoins({int page = 0}) async* {
    

     try {
      final coins = state.coinList + await _cryptoRepository.getTopCoins(page: page);
      yield state.copyWith(coins: coins, status: CryptoStatus.loaded);
    } on Failure catch (err) {
      yield state.copyWith(failure: err, status: CryptoStatus.error);
    }
  }
}

