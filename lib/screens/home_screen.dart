import 'package:crypto_app/models/coin_model.dart';
import 'package:crypto_app/repositories/crypto_repository.dart';
import 'package:flutter/material.dart';

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
        child: FutureBuilder(
          future: CryptoRepository().getTopCoins(),
          builder:
              (BuildContext context, AsyncSnapshot<List<CoinModel>> snapShot) {
            if (!snapShot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.tealAccent),
              ));
            }
            return ListView.builder(
                itemCount: snapShot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  final coin = snapShot.data![index];
                  return ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (index + 1).toString(),
                          style: TextStyle(
                              color: Colors.tealAccent,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    title: Text(
                      "${coin.fullName}",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "${coin.name}",
                      style: TextStyle(color: Colors.white70),
                    ),
                    trailing: Text(
                      "${coin.price}\$",
                      style: TextStyle(color: Colors.tealAccent),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
