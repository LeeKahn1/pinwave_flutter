import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tubes_pinwave/api/endpoint/edit_profile/edit_profile_request.dart';
import 'package:tubes_pinwave/helper/generals.dart';
import 'package:tubes_pinwave/helper/navigators.dart';
import 'package:tubes_pinwave/module/edit_profile/edit_profile_bloc.dart';

class EditProfilePage extends StatefulWidget {
  final String? imageUrl;
  final String username;
  final String email;

  const EditProfilePage({super.key, this.imageUrl, required this.username, required this.email});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecEmail = TextEditingController();

  XFile? _imageFile;

  @override
  void initState() {
    super.initState();

    tecUsername.text = widget.username;
    tecEmail.text = widget.email;
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedFile;
    });
  }

  void postData() {
    context.read<EditProfileBloc>().add(
        EditProfileClicked(
          editProfileRequest: EditProfileRequest(imagePath: _imageFile?.path, username: tecUsername.text, email: tecEmail.text)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileClickedLoading) {
          context.loaderOverlay.show();
        } else if (state is EditProfileClickedSuccess) {
          Navigators.pop(context);

          Generals.showSnackBar(context, state.message);
        } else if (state is EditProfileClickedFinished) {
          context.loaderOverlay.hide();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            title: const Text("Edit Profile"),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    height: MediaQuery.of(context).size.width*0.5,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.redAccent, Colors.black]),
                      shape: BoxShape.circle
                    ),
                    child: Stack(
                      alignment: const Alignment(1, 1),
                      children: [
                        SizedBox.square(
                          dimension: MediaQuery.of(context).size.width*0.5,
                          child: ClipOval(
                            child: image(),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _pickImage,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: const CircleBorder(),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white
                          ),
                          child: const Icon(Icons.edit)
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: tecUsername,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: tecEmail,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (tecUsername.text.isNotEmpty || tecEmail.text.isNotEmpty) {
                        postData();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  Widget image() {
    if (_imageFile != null) {
      return Image.file(
        File(_imageFile!.path),
        fit: BoxFit.cover,
      );
    }

    if (widget.imageUrl != null) {
      return Image.network(
        widget.imageUrl!,
        fit: BoxFit.cover,
      );
    }

    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: Text(
        widget.username[0],
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.width*0.2
        ),
      )
    );
  }
}
