import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes_pinwave/api/endpoint/pin/album_list/pin_album_list_response.dart';
import 'package:tubes_pinwave/api/endpoint/pin/album_list/pin_album_list_response_item.dart';
import 'package:tubes_pinwave/helper/formats.dart';
import 'package:tubes_pinwave/helper/navigators.dart';
import 'package:tubes_pinwave/module/album/album_bloc.dart';
import 'package:tubes_pinwave/module/pin_detail/pin_detail_page.dart';
import 'package:tubes_pinwave/widgets/custom_shimmer.dart';
import 'package:tubes_pinwave/widgets/no_data.dart';

class AlbumPage extends StatefulWidget {
  final int albumId;
  final String name;

  const AlbumPage({super.key, required this.albumId, required this.name});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  bool loading = true;
  PinAlbumListResponse? pinAlbumListResponse;

  @override
  void initState() {
    super.initState();

    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AlbumBloc, AlbumState>(
      listener: (context, state) {
        if (state is AlbumGetDataLoading) {
          setState(() {
            loading = true;
            pinAlbumListResponse = null;
          });
        } else if (state is AlbumGetDataSuccess) {
          setState(() {
            pinAlbumListResponse = state.pinAlbumListResponse;
          });
        } else if (state is AlbumGetDataFinished) {
          setState(() {
            loading = false;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: Text(widget.name),
        ),
        body: body(),
      ),
    );
  }

  Widget body() {
    if (loading) {
      return CustomShimmer();
    }

    if (pinAlbumListResponse == null || pinAlbumListResponse!.pinAlbumPhotos.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async => refresh(),
        child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: NoData()
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => refresh(),
      child: GridView.count(
        crossAxisCount: 2,
        physics: AlwaysScrollableScrollPhysics(),
        children: List.generate(
          pinAlbumListResponse!.pinAlbumPhotos.length,
              (index) {
            PinAlbumListResponseItem item = pinAlbumListResponse!.pinAlbumPhotos[index];

            String photos = item.imageUrl ?? "https://via.placeholder.com/150";

            return InkWell(
              onTap: () {
                Navigators.push(context, PinDetailPage(pinId: item.id));
              },
              child: Padding(
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
                              image: NetworkImage(photos),
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
              ),
            );
          },
        ),
      ),
    );
  }

  void refresh() {
    context.read<AlbumBloc>().add(AlbumGetData(albumId: widget.albumId));
  }
}
