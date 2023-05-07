import 'package:advice_clean_arch/presentation/core/service/theme_service.dart';
import 'package:advice_clean_arch/presentation/pages/advice/bloc/advice_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
// import 'package:provider/provider.dart';

class AdvicePageWrapper extends StatelessWidget {
  const AdvicePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdviceBloc>(),
      child: const AdvicerPage(),
    );
  }
}

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Advice",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
        actions: [
          Switch(
            value: context.read<ThemeService>().isDarkModeOn,
            onChanged: (_) => context.read<ThemeService>().toggleTheme(),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: BlocBuilder<AdviceBloc, AdviceState>(
                    builder: (context, state) {
                      if (state is AdviceRequestLoading) {
                        return const CircularProgressIndicator(
                          color: Colors.white,
                        );
                      } else if (state is AdviceRequestLoaded) {
                        return Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge,
                        );
                      } else if (state is AdviceRequestFailed) {
                        return Text(
                          "Something went wrong",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge,
                        );
                      }
                      return Text(
                        "Your Advice is Waiting for you",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineLarge,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              MaterialButton(
                color: Colors.indigo,
                onPressed: () => {
                  BlocProvider.of<AdviceBloc>(context)
                      .add(AdviceRequestEvent()),
                },
                child: Text(
                  'Get Advice',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
