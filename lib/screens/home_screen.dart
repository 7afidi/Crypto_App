import 'package:crypto_app/blocs/crypto/crypto_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Top Coins"),
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.grey[900]!])),
          child:
              BlocBuilder<CryptoBloc, CryptoState>(builder: (context, state) {
            switch (state.status) {
              case CryptoStatus.loaded:
                return Text(
                  state.coinList.length.toString(),
                  style: TextStyle(color: Colors.white),
                );

              case CryptoStatus.error:
                return Center(
                  child: Text(
                    "Error",
                    style: TextStyle(color: Colors.red),
                  ),
                );

              default:
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.tealAccent),
                ));
            }
          })),
    );
  }
}
