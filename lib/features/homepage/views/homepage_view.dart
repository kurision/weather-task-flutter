import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_task/features/homepage/state/weather_state.dart';
import 'package:weather_task/features/splash/help_screen.dart';

class HomePageView extends ConsumerWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController cityController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HelpScreen(),
                ),
              );
            },
            icon: const Icon(Icons.help_center),
          )
        ],
        elevation: 10,
        centerTitle: true,
        title: const Text('Weather Task'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: cityController,
              decoration: const InputDecoration(
                hintText: 'Enter City Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //dynamic button to save or update city
          ElevatedButton(
            onPressed: () {
              ref
                  .watch(weatherProvider.notifier)
                  .fetchWeather(cityController.text);
            },
            child: const Text('Save or Update'),
          ),
          const SizedBox(
            height: 40,
          ),
          // Here show a dynamix Container to show weather info
          Consumer(builder: (context, ref, child) {
            WeatherState state = ref.watch(weatherProvider);
            if (state is InitalState) {
              return Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                child: const Column(
                  children: [
                    Text('No Data'),
                  ],
                ),
              );
            }
            if (state is WeatherLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is WeatherLoadedState) {
              return Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      '${state.weatherModel.temperatureInCelsius.toString()} C',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(state.weatherModel.waetherCondition),
                    const SizedBox(height: 10),
                    Image.network("https:${state.weatherModel.iconUrl}"),
                  ],
                ),
              );
            }
            if (state is ErrorSate) {
              return Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('Error : ${state.message}'),
                  ],
                ),
              );
            }
            return Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              child: const Column(
                children: [
                  Text('No Data'),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
