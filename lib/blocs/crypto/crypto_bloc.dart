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
    } else if (event is LoadMoreCoins) {}
  }

  Stream<CryptoState> _mapAppStartedState() async* {
    yield state.copyWith(status: CryptoStatus.loading);

    // request to get coins
    try {
      final coins = await _cryptoRepository.getTopCoins();
      yield state.copyWith(coins: coins, status: CryptoStatus.loaded);
    } on Failure catch (err) {
      yield state.copyWith(failure: err, status: CryptoStatus.error);
    }
  }
}
