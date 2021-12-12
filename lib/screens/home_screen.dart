import 'package:crypto_app/blocs/crypto/crypto_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController? _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController?.dispose();
    super.dispose();
  }

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
                return RefreshIndicator(
                  color: Colors.tealAccent,
                  onRefresh: () async {
                    print("Refrec");
                    context.read<CryptoBloc>().add(RefreshCoins());
                  },
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notificaton) =>
                        _onScrollNotification(notificaton),
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: state.coinList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final coin = state.coinList[index];
                          return ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (index + 1).toString(),
                                  style: const TextStyle(
                                      color: Colors.tealAccent,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            title: Text(
                              "${coin.fullName}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "${coin.name}",
                              style: const TextStyle(color: Colors.white70),
                            ),
                            trailing: Text(
                              "${coin.price}\$",
                              style: const TextStyle(color: Colors.tealAccent),
                            ),
                          );
                        }),
                  ),
                );
              case CryptoStatus.error:
                return Center(
                  child: Text(
                    "${state.failure.message}",
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

  bool _onScrollNotification(ScrollNotification notif) {
    if (notif is ScrollNotification &&
        _scrollController!.position.extentAfter == 0) {
      context.read<CryptoBloc>().add(LoadMoreCoins());
      print("End Eached");
    }
    return false;
  }
}
