import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tubes_pinwave/api/endpoint/account/account_response.dart';
import 'package:tubes_pinwave/api/endpoint/account/account_response_pin.dart';
import 'package:tubes_pinwave/api/endpoint/album/name/album_name_request.dart';
import 'package:tubes_pinwave/api/endpoint/album/name/album_name_response_item.dart';
import 'package:tubes_pinwave/api/endpoint/album/thumbnail/album_thumbnail_response.dart';
import 'package:tubes_pinwave/api/endpoint/album/thumbnail/album_thumbnail_response_item.dart';
import 'package:tubes_pinwave/api/endpoint/change_password/change_password_request.dart';
import 'package:tubes_pinwave/helper/dialogs.dart';
import 'package:tubes_pinwave/helper/generals.dart';
import 'package:tubes_pinwave/helper/navigators.dart';
import 'package:tubes_pinwave/module/album/album_page.dart';
import 'package:tubes_pinwave/module/edit_profile/edit_profile_page.dart';
import 'package:tubes_pinwave/module/pin_detail/pin_detail_page.dart';
import 'package:tubes_pinwave/module/profile/profile_bloc.dart';
import 'package:tubes_pinwave/widgets/custom_shimmer.dart';
import 'package:tubes_pinwave/widgets/no_data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loading = true;
  AccountResponse? accountResponse;
  AlbumThumbnailResponse? albumThumbnailResponse;
  List<AlbumNameResponseItem> albumNameResponseItemList = [];

  @override
  void initState() {
    super.initState();

    refresh();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) async {
        if (state is ProfileLoading) {
          context.loaderOverlay.show();
        } else if (state is ProfileFinished) {
          context.loaderOverlay.hide();
        } else if (state is ProfileAccountLoading) {
          setState(() {
            loading = true;
            albumNameResponseItemList.clear();
          });
        } else if (state is ProfileAccountSuccess) {
          setState(() {
            accountResponse = state.accountResponse;
            albumThumbnailResponse = state.albumThumbnailResponse;
          });
        } else if (state is ProfileAccountFinished) {
          setState(() {
            loading = false;
          });
        } else if (state is ProfileAlbumNameSuccess) {

        } else if (state is ProfileAddAlbumNameSuccess) {
          Generals.showSnackBar(context, "Berhasil menambahkan data");

          refresh();
        } else if (state is ProfileChangePasswordSuccess) {
          Navigators.pop(context);

          Generals.showSnackBar(context, state.message);
        } else if (state is ProfileLogoutSuccess) {
          Generals.signOut();
        }
      },
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                PopupMenuButton(
                  iconColor: Colors.black,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text("Tambah Album"),
                        onTap: () {
                          Dialogs.tec(
                            buildContext: context,
                            title: "Tambah Album",
                            positiveCallback: (text) {
                              addAlbum(
                                AlbumNameRequest(name: text)
                              );
                            },
                          );
                        },
                      ),
                      PopupMenuItem(
                        child: Text("Ganti Password"),
                        onTap: () {
                          Dialogs.changePassword(
                            buildContext: context,
                            positiveCallback: (oldPassword, newPassword, conPassword) {
                              changePassword(
                                ChangePasswordRequest(
                                  oldPassword: oldPassword,
                                  newPassword: newPassword,
                                  newPasswordConfirmation: conPassword
                                )
                              );
                            },
                          );
                        },
                      ),
                      PopupMenuItem(
                        child: Text("Logout"),
                        onTap: () {
                          Dialogs.confirmation(
                            context: context,
                            title: "Yakin ingin keluar dari akun Anda?",
                            positiveCallback: () {
                              logout();
                            },
                          );
                        },
                      ),
                    ];
                  },
                ),
              ],
            ),
            body: body(context),
          ),
        ),
    );
  }

  Widget body(BuildContext context) {
    if (loading) {
      return CustomShimmer();
    }

    if (accountResponse == null && albumThumbnailResponse == null) {
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
        physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: accountResponse!.user.imageUrl != null ? ClipOval(
                  child: Image.network(
                    accountResponse!.user.imageUrl!,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                ) : Center(
                  child: Text(accountResponse!.user.username[0], textAlign: TextAlign.center, style: TextStyle(fontSize: 40, color: Colors.white),)
                ),
              ),
              const SizedBox(height: 20),
              Text(
                accountResponse!.user.username,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(accountResponse!.user.email),
              Text('${accountResponse!.user.followersCount} Pengikut · ${accountResponse!.user.followingCount} Mengikuti'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await Navigators.push(context, EditProfilePage(
                    imageUrl: accountResponse!.user.imageUrl,
                    username: accountResponse!.user.username,
                    email: accountResponse!.user.email,
                  ));

                  refresh();
                },
                child: const Text('Edit Profil'),
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const TabBar(
                      physics: NeverScrollableScrollPhysics(),
                      isScrollable: false,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.black,
                      indicatorWeight: 3.0,
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      tabs: [
                        Tab(text: 'Dibuat'),
                        Tab(text: 'Disimpan'),
                      ],
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: TabBarView(
                        children: [
                          create(),
                          save(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }

  Widget create() {
    if (accountResponse!.pins.isEmpty) {
      return SingleChildScrollView(child: NoData());
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: accountResponse!.pins.length,
      itemBuilder: (context, index) {
        AccountResponsePin item = accountResponse!.pins[index];

        return InkWell(
          onTap: () async {
            await Navigators.push(context, PinDetailPage(pinId: item.id));

            refresh();
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              item.imageUrl != null ? Image.network(
                item.imageUrl!,
              ) : Image.asset(
                "assets/logo.jpeg",
                fit: BoxFit.contain,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white.withOpacity(0.5),
                child: Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget save() {
    if (albumThumbnailResponse!.albumThumbnails.isEmpty) {
      return SingleChildScrollView(child: NoData());
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: albumThumbnailResponse!.albumThumbnails.length,
      itemBuilder: (context, index) {
        AlbumThumbnailResponseItem item = albumThumbnailResponse!.albumThumbnails[index];

        return InkWell(
          onTap: () async {
            await Navigators.push(context, AlbumPage(albumId: item.id, name: item.name,));

            refresh();
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              item.thumbnail != null ? Image.network(
                  item.thumbnail!,
              ) : Image.asset(
                "assets/logo.jpeg",
                fit: BoxFit.fill,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white.withOpacity(0.5),
                child: Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }


  void addAlbum(AlbumNameRequest albumNameRequest) {
    context.read<ProfileBloc>().add(ProfileAddAlbumName(albumNameRequest: albumNameRequest));
  }

  void logout() {
    context.read<ProfileBloc>().add(ProfileLogout());
  }

  void refresh() {
    context.read<ProfileBloc>().add(ProfileAccount());
  }

  void changePassword(ChangePasswordRequest changePasswordRequest) {
    context.read<ProfileBloc>().add(ProfileChangePassword(
        changePasswordRequest: changePasswordRequest
    ));
  }
}