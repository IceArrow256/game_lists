import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as Img;
import 'package:image_picker/image_picker.dart';

class AddingGamePage extends StatefulWidget {
  @override
  _AddingGamePageState createState() => _AddingGamePageState();
}

class _AddingGamePageState extends State<AddingGamePage> {
  final _formKey = GlobalKey<FormState>();
  Uint8List? _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = await pickedFile.readAsBytes();
    } else {
      print('No image selected.');
    }

    var finalW = 295;
    var finalH = 354;

    var image = Img.decodeImage(_image!)!;
    var coeff = finalW / image.width;
    coeff = image.height * coeff < finalH ? finalH / image.height : coeff;

    image = Img.copyResize(image,
        width: (image.width * coeff).round(),
        height: (image.height * coeff).round());
    image = Img.copyCrop(image, ((image.width - finalW) / 2).round(),
        ((image.height - finalH) / 2).round(), finalW, finalH);

    _image = Uint8List.fromList(Img.encodePng(image));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adding Game'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Processing Data')));
          }
        },
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: InkWell(
                      onTap: getImage,
                      child: _image == null
                          ? Image.network(
                              'https://place-hold.it/295x345',
                              scale: 2.5,
                            )
                          : Image.memory(_image!, scale: 2.5),
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.label),
                        hintText: 'Name of the game',
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              TextFormField(
                maxLines: null,
                decoration: const InputDecoration(
                  icon: Icon(Icons.description),
                  hintText: 'Description of the game',
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
