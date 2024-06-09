import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tubes_pinwave/api/endpoint/album/name/album_name_response.dart';
import 'package:tubes_pinwave/api/endpoint/album/name/album_name_response_item.dart';
import 'package:tubes_pinwave/api/endpoint/pin/create/pin_create_request.dart';
import 'package:tubes_pinwave/helper/generals.dart';
import 'package:tubes_pinwave/module/create_pin/create_pin_bloc.dart';
import 'package:tubes_pinwave/overlay/overlays.dart';

class CreatePinPage extends StatefulWidget {
  const CreatePinPage({super.key});

  @override
  State<CreatePinPage> createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
  final _formKey = GlobalKey<FormState>();
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  TextEditingController tecTitle = TextEditingController();
  TextEditingController tecDescription = TextEditingController();
  TextEditingController tecLink = TextEditingController();
  TextEditingController tecTag = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  bool loading = true;
  AlbumNameResponse? albumNameResponse;

  int? albumId;

  @override
  void initState() {
    super.initState();

    getAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePinBloc, CreatePinState>(
      listener: (context, state) {
        if (state is CreatePinPostDataLoading) {
          context.loaderOverlay.show();
        } else if (state is CreatePinPostDataSuccess) {
          setState(() {
            tecTitle.clear();
            tecDescription.clear();
            tecLink.clear();
            tecTag.clear();
            _imageFile = null;
          });

          Generals.showSnackBar(context, state.message);
        } else if (state is CreatePinPostDataFinished) {
          context.loaderOverlay.hide();
        } else if (state is CreatePinGetAlbumLoading) {
          setState(() {
            loading = true;
          });
        } else if (state is CreatePinGetAlbumSuccess) {
          setState(() {
            albumNameResponse = state.albumNameResponse;
          });
        } else if (state is CreatePinGetAlbumFinished) {
          setState(() {
            loading = false;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
              'Create Pin', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Handle settings action
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _imageFile == null
                        ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_upload,
                              size: 50, color: Colors.grey),
                          SizedBox(height: 10),
                          Center(
                              child: Text(
                                'Choose a file or drag and drop it here',
                                textAlign: TextAlign.center,
                              )
                          ),
                          SizedBox(height: 10),
                          Center(
                              child: Text(
                                'We recommend using high quality .jpg files less than 20MB',
                                textAlign: TextAlign.center,
                              )
                          ),
                          Center(
                              child: Text(
                                'or .mp4 files less than 200MB',
                                textAlign: TextAlign.center,
                              )
                          ),
                        ],
                      ),
                    )
                        : Image.file(File(_imageFile!.path)),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: tecTitle,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Bidang ini tidak boleh kosong!";
                    }

                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: tecDescription,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: tecLink,
                  decoration: const InputDecoration(
                    labelText: 'Link',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Album',
                    border: OutlineInputBorder(),
                  ),
                  items: albumNameResponse != null && albumNameResponse!.albums.isNotEmpty ? albumNameResponse!.albums.map((AlbumNameResponseItem item) {
                    return DropdownMenuItem(
                      value: item.id.toString(),
                      child: Text(item.name),
                    );
                  }).toList() : [
                    const DropdownMenuItem(
                      value: null,
                      child: Text("Tidak ada data"),
                    )
                  ],
                  onChanged: (newValue) {
                    print(newValue);

                    setState(() {
                      if (newValue != null) {
                        albumId = int.parse(newValue);
                      }
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: tecTag,
                  decoration: const InputDecoration(
                    labelText: 'Tags',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_imageFile == null) {
                        Overlays.error(message: "Gambar tidak boleh kosong!");
                      } else {
                        postPin();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                  ),
                  child: const Text('Publish',
                      style: TextStyle(color: Colors.white)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void postPin() {
    context.read<CreatePinBloc>().add(CreatePinPostData(
      pinCreateRequest: PinCreateRequest(
        title: tecTitle.text,
        description: tecDescription.text,
        imagePath: _imageFile!.path,
        link: tecLink.text,
        tags: tecTag.text,
        albumId: albumId
      )
    ));
  }

  void getAlbum() {
    context.read<CreatePinBloc>().add(CreatePinGetAlbum());
  }
}
