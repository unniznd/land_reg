import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_nft/wallet_connect/bloc/wallet_connect_event.dart';
import 'bloc/wallet_conncet_state.dart';

import 'bloc/wallet_conncet_bloc.dart';

class WalletConnectScreen extends StatefulWidget {
  const WalletConnectScreen({super.key});

  @override
  State<WalletConnectScreen> createState() => _WalletConnectScreenState();
}

class _WalletConnectScreenState extends State<WalletConnectScreen> {
  final WalletConnectBloc walletConnectBloc = WalletConnectBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to LandNFT Register",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            BlocListener<WalletConnectBloc, WalletConnectState>(
              bloc: walletConnectBloc,
              listener: (context, state) {
                if (state is WalletConnectSuccess) {
                  Navigator.pushReplacementNamed(
                    context,
                    '/home',
                    arguments: {
                      'address': state.address,
                    },
                  );
                }
              },
              child: BlocBuilder<WalletConnectBloc, WalletConnectState>(
                bloc: walletConnectBloc,
                builder: (context, state) {
                  if (state is WalletConnectError) {
                    return Column(
                      children: [
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              walletConnectBloc.add(ConnectToMetaMask());
                            },
                            child: const Text('Connect Metamask'),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          state.message,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    );
                  } else if (state is WalletConnectLoading) {
                    return SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else if (state is WalletConnectNotFound) {
                    return const Text(
                      "Web3 Ahead!! No wallet detected. Ready your wallet to continue.",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    );
                  }
                  return SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        walletConnectBloc.add(ConnectToMetaMask());
                      },
                      child: const Text('Connect Metamask'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
