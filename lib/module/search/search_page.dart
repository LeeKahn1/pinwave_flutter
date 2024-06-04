import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes_pinwave/api/endpoint/pin/search/pin_search_response.dart';
import 'package:tubes_pinwave/api/endpoint/pin/search/pin_search_response_pin.dart';
import 'package:tubes_pinwave/helper/formats.dart';
import 'package:tubes_pinwave/module/search/search_bloc.dart';
import 'package:tubes_pinwave/widgets/custom_shimmer.dart';
import 'package:tubes_pinwave/widgets/no_data.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  bool loading = true;
  PinSearchResponse? pinSearchResponse;
  bool first = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchGetDataLoading) {
          setState(() {
            loading = true;
          });
        } else if (state is SearchGetDataSuccess) {
          setState(() {
            pinSearchResponse = state.pinSearchResponse;
          });
        } else if (state is SearchGetDataFinished) {
          setState(() {
            loading = false;
            first = false;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: TextField(
            controller: _controller,
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              hintText: 'Search your Idea',
              icon: Icon(Icons.search),
              border: InputBorder.none,
            ),
            onSubmitted: (query) {
              if (StringUtils.isNotNullOrEmpty(query)) {
                refresh(query.toLowerCase());
              }
            },
          ),
        ),
        body: body(),
      ),
    );
  }

  Widget body() {
    if (first) {
      return const Center(
        child: Text("Gunakan kata kunci yang tepat untuk mencari!"),
      );
    }

    if (loading) {
      return CustomShimmer();
    }

    if (pinSearchResponse == null) {
      return NoData();
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: pinSearchResponse!.pins.length,
      itemBuilder: (context, index) {
        PinSearchResponsePin item = pinSearchResponse!.pins[index];

        return Card(
          child: Column(
            children: [
              Image.network(
                item.imageUrl!,
                fit: BoxFit.cover,
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  Formats.coalesce(item.title),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void refresh(String keyword) {
    context.read<SearchBloc>().add(SearchGetData(keyword: keyword));
  }
}