import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

List<String> list = <String>[
  'Choose Image',
  'Take Photo',
];

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  XFile? image;
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('  Profile'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                ),
                Center(
                  child: Stack(
                    children: [
                      if (image != null)
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: FileImage(File(image!.path)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                height: 100,
                                width: 100,
                              ),
                            ],
                          ),
                        )
                      else
                        Container(
                          child: Image.asset("assets/profile.png"),
                          height: 100,
                          width: 100,
                        ),
                      Positioned(
                        bottom: -8,
                        right: -10,
                        child: IconButton(
                          onPressed: () {
                            _showDropdown(); // Call the function to show the dropdown
                          },
                          icon: Image.asset(
                            "assets/icon.png",
                            height: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Name", labelStyle: TextStyle(fontSize: 14)),
                ),
                SizedBox(
                  height: 24,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Username",
                      labelStyle: TextStyle(fontSize: 14)),
                ),
                SizedBox(
                  height: 24,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Phone number",
                      labelStyle: TextStyle(fontSize: 14)),
                ),
                SizedBox(
                  height: 24,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Email", labelStyle: TextStyle(fontSize: 14)),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Save"),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final img = await _picker.pickImage(source: source);
    setState(() {
      image = img;
    });
  }

  void _showDropdown() {
    // Implement the logic to show the dropdown
    // You can use a Dialog or another method to show the dropdown
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
                // Update the image based on the selected value
                if (dropdownValue == 'Choose Image') {
                  _pickImage(ImageSource.gallery);
                } else if (dropdownValue == 'Take Photo') {
                  _pickImage(ImageSource.camera);
                }
                Navigator.pop(context); // Close the dropdown
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
