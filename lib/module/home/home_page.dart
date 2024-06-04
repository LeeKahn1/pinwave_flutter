import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes_pinwave/api/endpoint/home/home_pin_response.dart';
import 'package:tubes_pinwave/api/endpoint/home/home_pin_response_pin.dart';
import 'package:tubes_pinwave/helper/formats.dart';
import 'package:tubes_pinwave/module/home/home_bloc.dart';
import 'package:tubes_pinwave/widgets/custom_shimmer.dart';
import 'package:tubes_pinwave/widgets/no_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  HomePinResponse? homePinResponse;

  @override
  void initState() {
    super.initState();

    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeGetDataLoading) {
          setState(() {
            loading = true;
            homePinResponse = null;
          });
        } else if (state is HomeGetDataSuccess) {
          setState(() {
            homePinResponse = state.homePinResponse;
          });
        } else if (state is HomeGetDataFinished) {
          setState(() {
            loading = false;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('HomePage'),
        ),
        body: body(),
      ),
    );
  }

  Widget body() {
    if (loading) {
      return CustomShimmer();
    }

    if (homePinResponse == null) {
      return NoData();
    }

    return RefreshIndicator(
      onRefresh: () async => refresh(),
      child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            homePinResponse!.pins.length,
                (index) {
              HomePinResponsePin item = homePinResponse!.pins[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.grey[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(item.imageUrl!),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          Formats.coalesce(item.title),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
    );
  }

  void refresh() {
    context.read<HomeBloc>().add(HomeGetData());
  }
}
