import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as Img;
import 'package:image_picker/image_picker.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _formKey = GlobalKey<FormState>();
  Uint8List? _image;

  final _picker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = await pickedFile.readAsBytes();
      var finalW = 308;
      var finalH = 432;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game'),
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
          child: ListView(
            children: [
              Container(
                height: 216,
                child: InkWell(
                  onTap: _getImage,
                  child: _image == null
                      ? Image.network(
                          'https://place-hold.it/308x432',
                        )
                      : Image.memory(_image!, scale: 2),
                ),
              ),
              TextFormField(
                maxLines: null,
                decoration: const InputDecoration(
                  icon: Icon(Icons.label_important),
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
              TextFormField(
                maxLines: null,
                decoration: const InputDecoration(
                  icon: Icon(Icons.developer_board),
                  hintText: 'Developers of the game',
                  labelText: 'Developer',
                ),
                initialValue: 'cavia inc., Toylogic',
                onTap: () {
                  Navigator.pushNamed(context, '/developer');
                },
                readOnly: true,
              ),
              TextFormField(
                maxLines: null,
                decoration: const InputDecoration(
                  icon: Icon(Icons.adjust),
                  hintText: 'Series of the game',
                  labelText: 'Series',
                ),
                initialValue: 'Drakengard, Nier',
                onTap: () {
                  Navigator.pushNamed(context, '/series');
                },
                readOnly: true,
              ),
              TextFormField(
                maxLines: null,
                decoration: const InputDecoration(
                  icon: Icon(Icons.android),
                  hintText: 'Platforms of the game',
                  labelText: 'Platform',
                ),
                initialValue: 'PC, PlayStation 3, PlayStation 4, Xbox One',
                onTap: () {
                  Navigator.pushNamed(context, '/platform');
                },
                readOnly: true,
              ),
              TextFormField(
                maxLines: null,
                decoration: const InputDecoration(
                  icon: Icon(Icons.label),
                  hintText: 'Tags of the game',
                  labelText: 'Tags',
                ),
                initialValue:
                    'PS3, Playstation 3, Upcoming, Want to play next, Wishlist 2021, Play Asia import, Pre-order, Watched: Single Player (Story)',
                onTap: () {
                  Navigator.pushNamed(context, '/tag');
                },
                readOnly: true,
              ),
              TextFormField(
                maxLines: null,
                decoration: const InputDecoration(
                  icon: Icon(Icons.description),
                  hintText: 'Description of the game',
                  labelText: 'Description',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
