import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerComponent extends StatefulWidget {
  final String label;
  final ValueChanged<String?> onFilePicked;

  const FilePickerComponent({
    super.key,
    required this.label,
    required this.onFilePicked,
  });

  @override
  _FilePickerComponentState createState() => _FilePickerComponentState();
}

class _FilePickerComponentState extends State<FilePickerComponent> {
  String? _fileName;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      setState(() {
        _fileName = file.name;
      });
      widget.onFilePicked(file.path);
    } else {
      widget.onFilePicked(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickFile,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _fileName ?? 'No file selected',
                  style: const TextStyle(color: Colors.grey),
                ),
                const Icon(Icons.attach_file, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
