// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tubes_pinwave/api/endpoint/album/name/album_name_response.dart';
import 'package:tubes_pinwave/api/endpoint/album/name/album_name_response_item.dart';
import 'package:tubes_pinwave/api/endpoint/pin/comment/pin_comment_request.dart';
import 'package:tubes_pinwave/api/endpoint/pin/detail/pin_detail_response.dart';
import 'package:tubes_pinwave/api/endpoint/pin/detail/pin_detail_response_comment.dart';
import 'package:tubes_pinwave/api/endpoint/pin/pin_save_to_album_request.dart';
import 'package:tubes_pinwave/api/endpoint/pin/report/pin_report_request.dart';
import 'package:tubes_pinwave/helper/dialogs.dart';
import 'package:tubes_pinwave/helper/formats.dart';
import 'package:tubes_pinwave/helper/generals.dart';
import 'package:tubes_pinwave/helper/navigators.dart';
import 'package:tubes_pinwave/module/pin_detail/pin_detail_bloc.dart';
import 'package:tubes_pinwave/widgets/custom_shimmer.dart';
import 'package:tubes_pinwave/widgets/no_data.dart';

class PinDetailPage extends StatefulWidget {
  final int pinId;

  const PinDetailPage({super.key, required this.pinId});

  @override
  State<PinDetailPage> createState() => _PinDetailPageState();
}

class _PinDetailPageState extends State<PinDetailPage> {
  bool loading = true;
  PinDetailResponse? pinDetailResponse;

  @override
  void initState() {
    super.initState();

    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PinDetailBloc, PinDetailState>(
      listener: (context, state) {
        if (state is PinDetailGetDataLoading) {
          setState(() {
            loading = true;
            pinDetailResponse = null;
          });
        } else if (state is PinDetailGetDataSuccess) {
          setState(() {
            pinDetailResponse = state.pinDetailResponse;
          });
        } else if (state is PinDetailGetDataFinished) {
          setState(() {
            loading = false;
          });
        } else if (state is PinDetailLoading) {
          context.loaderOverlay.show();
        } else if (state is PinDetailFinished) {
          context.loaderOverlay.hide();
        } else if (state is PinDetailFollowUserSuccess) {
          Generals.showSnackBar(context, state.message);

          refresh();
        } else if (state is PinDetailLikeSuccess) {
          Generals.showSnackBar(context, state.message);

          refresh();
        } else if (state is PinDetailReportSuccess) {
          Generals.showSnackBar(context, state.message);

          refresh();
        } else if (state is PinDetailAddCommentSuccess) {
          Generals.showSnackBar(context, state.message);

          refresh();
        } else if (state is PinDetailGetAlbumNameSuccess) {
          bottomSheetAlbum(state.albumNameResponse);
        } else if (state is PinDetailSaveToAlbumSuccess) {
          Navigators.pop(context);

          Generals.showSnackBar(context, state.message);
        } else if (state is PinDetailDownloadSuccess) {
          downloadToDirectory(state.uint8list, state.filename);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            title: Text("PinWave"),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        onTap: () {
                          getAlbumName();
                        },
                        child: Text("Simpan ke Album")
                    ),
                    PopupMenuItem(
                        onTap: () {
                          if (pinDetailResponse!.pins.reported) {
                            Dialogs.confirmation(
                              context: context,
                              title: "Yakin ingin membatalkan laporan Anda?",
                              positiveCallback: () {
                                report(
                                    pinDetailResponse!.pins.id,
                                    PinReportRequest(reason: "")
                                );
                              },
                            );
                          } else {
                            Dialogs.tec(
                              buildContext: context,
                              title: "Ketik Alasan",
                              positive: "Kirim",
                              positiveCallback: (text) {
                                report(
                                    pinDetailResponse!.pins.id,
                                    PinReportRequest(reason: text)
                                );
                              },
                            );
                          }
                        },
                        enabled: !pinDetailResponse!.pins.owned,
                        child: Text(pinDetailResponse!.pins.reported ? "Batalkan Laporkan" : "Laporkan Gambar")
                    ),
                    PopupMenuItem(
                        onTap: () {
                          download();
                        },
                        child: Text("Unduh Gambar")
                    ),
                  ];
                },
              )
            ],
          ),
          body: body(context),
        ),
    );
  }

  Widget body(BuildContext context) {
    if (loading) {
      return CustomShimmer();
    }

    if (pinDetailResponse == null) {
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
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20),
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  ClipOval(
                    child: image(
                      width: 50,
                      height: 50,
                      imageUrl: pinDetailResponse!.pins.users.imageUrl,
                      username: pinDetailResponse!.pins.users.username
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "@${pinDetailResponse!.pins.users.username}"
                        ),
                        Text(
                            "${pinDetailResponse!.pins.users.followingCount} followers"
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Visibility(
                    visible: !pinDetailResponse!.pins.owned,
                    child: SizedBox(
                      height: 35,
                      child: FilledButton(
                        onPressed: () {
                          if (pinDetailResponse!.pins.users.followed) {
                            Dialogs.confirmation(
                              context: context,
                              title: "Yakin ingin berhenti mengikuti @${pinDetailResponse!.pins.users.username}?",
                              positiveCallback: () {
                                follow(pinDetailResponse!.pins.users.id);
                              },
                            );
                          } else {
                            follow(pinDetailResponse!.pins.users.id);
                          }
                        },
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          backgroundColor: pinDetailResponse!.pins.users.followed ? Colors.grey : null
                        ),
                        child: Text(pinDetailResponse!.pins.users.followed ? "Following" : "Follow")
                      ),
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Text(
                pinDetailResponse!.pins.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),
              ),
              subtitle: pinDetailResponse!.pins.description != null ? Text(
                  pinDetailResponse!.pins.description ?? ""
              ) : null,
            ),
            Container(
              child: image(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height*0.3,
                imageUrl: pinDetailResponse!.pins.imageUrl,
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        if (pinDetailResponse!.pins.liked) {
                          Dialogs.confirmation(
                            context: context,
                            title: "Yakin ingin menghapus suka Anda?",
                            positiveCallback: () {
                              like(pinDetailResponse!.pins.id);
                            },
                          );
                        } else {
                          like(pinDetailResponse!.pins.id);
                        }
                      },
                      icon: Icon(pinDetailResponse!.pins.liked ? Icons.favorite : Icons.favorite_outline, color: pinDetailResponse!.pins.liked ? Colors.red : null,)
                  ),
                  Visibility(
                      visible: pinDetailResponse!.pins.likesCount > 0,
                      child: Text("${pinDetailResponse!.pins.likesCount} likes")
                  ),
                  SizedBox(width: 10),
                  IconButton(
                      onPressed: () {
                        Dialogs.tec(
                          buildContext: context,
                          title: "Ketik Komentar",
                          positive: "Kirim",
                          positiveCallback: (text) {
                            addComment(
                                PinCommentRequest(pinId: pinDetailResponse!.pins.id, message: text)
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.insert_comment_outlined)
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("${pinDetailResponse!.pins.comments.length} Komentar"),
                      SizedBox(width: 10),
                      Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: 10),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: pinDetailResponse!.pins.comments.length,
                    itemBuilder: (context, index) {
                      PinDetailResponseComment comment = pinDetailResponse!.pins.comments[index];

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipOval(
                            child: image(
                                width: 35,
                                height: 35,
                                imageUrl: comment.imageUrl,
                                username: comment.username
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "@${comment.username}",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    comment.content
                                ),
                                Text(
                                    Formats.convertToAgo(comment.createdAt),
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 10
                                    ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 20,),
                  )
                ],
              ),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Widget image({String? imageUrl, String? username, double? width, double? height}) {
    if (imageUrl != null) {
      return SizedBox(
        width: width,
        height: height,
        child: Image.network(imageUrl, fit: BoxFit.cover,),
      );
    } else {
      return Container(
        color: Colors.blue,
        width: width,
        height: height,
        child: Center(
          child: Text(
            username?[0] ?? "N/A",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      );
    }
  }

  void refresh() {
    context.read<PinDetailBloc>().add(PinDetailGetData(pinId: widget.pinId));
  }

  void follow(int userId) {
    context.read<PinDetailBloc>().add(PinDetailFollowUser(userId: userId));
  }

  void like(int pinId) {
    context.read<PinDetailBloc>().add(PinDetailLike(pinId: pinId));
  }

  void report(int pinId, PinReportRequest pinReportRequest) {
    context.read<PinDetailBloc>().add(PinDetailReport(pinId: pinId, pinReportRequest: pinReportRequest));
  }

  void addComment(PinCommentRequest pinCommentRequest) {
    context.read<PinDetailBloc>().add(PinDetailAddComment(pinCommentRequest: pinCommentRequest));
  }

  void getAlbumName() {
    context.read<PinDetailBloc>().add(PinDetailGetAlbumName());
  }

  void saveToAlbum(PinSaveToAlbumRequest pinSaveToAlbumRequest) {
    context.read<PinDetailBloc>().add(PinDetailSaveToAlbum(pinSaveToAlbumRequest: pinSaveToAlbumRequest));
  }

  void download() {
    context.read<PinDetailBloc>().add(PinDetailDownload(pinId: pinDetailResponse!.pins.id));
  }

  void bottomSheetAlbum(AlbumNameResponse albumNameResponse) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Pilih Album",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            albumNameResponse.albums.isEmpty ? Text("Belum ada daftar Album, silahkan tambahkan dahulu di Menu Profile") : Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                itemCount: albumNameResponse.albums.length,
                itemBuilder: (context, index) {
                  AlbumNameResponseItem item = albumNameResponse.albums[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      saveToAlbum(
                        PinSaveToAlbumRequest(albumId: item.id, pinId: pinDetailResponse!.pins.id)
                      );
                    },
                    title: Text(item.name)
                  );
                },
                separatorBuilder: (context, index) => Divider(height: 0),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> downloadToDirectory(Uint8List uint8list, String filename) async {
    String? directoryPath = await FilePicker.platform.getDirectoryPath();

    if (directoryPath != null) {
      String filePath = '$directoryPath/$filename';

      File file = File(filePath);
      await file.writeAsBytes(uint8list);

      Generals.showSnackBar(context, "Berhasil mengunduh gambar ke $filePath");
    } else {
      Generals.showSnackBar(context, "Unduhan gagal", backgroundColor: Colors.red);
    }
  }
}
