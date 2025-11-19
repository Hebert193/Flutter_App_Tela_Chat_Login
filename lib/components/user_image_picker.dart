import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget{
  final void Function(File pickedImage) onimagePick;

  const UserImagePicker({
    required this.onimagePick,
    super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker>{
  File? _Image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage != null) {
      setState(() {
        _Image = File(pickedImage.path);
      });
      widget.onimagePick(_Image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _Image != null ? FileImage(_Image!) : null,
        ),
        TextButton(
          onPressed: _pickImage,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: const [
          Icon( 
            Icons.image,
            ),
          SizedBox(width: 10),
          Text('Pick Image'),
          ]
          )
        ),
      ],
    );
  }
}