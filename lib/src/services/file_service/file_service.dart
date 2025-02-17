// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/custom_toast.dart';

class FileServiceX {
  static List<String> images = ["jpg", "jpeg", "png", "gif", "bmp", "tiff", "heif", "heic", "webp"];
  static List<String> videos = ["mp4", "avi", "mkv", "mov", "wmv", "webm", "3gp", "m4v"];
  static List<String> pdf = ["pdf"];

  static Future<PickedFile?> pickFile({List<String>? extensions = const ["jpg", "png", "jpeg", "pdf"]}) async {
    try {
      if (!kIsWeb) await FilePicker.platform.clearTemporaryFiles();
      final picked = await FilePicker.platform.pickFiles(
        type: extensions == null ? FileType.any : FileType.custom,
        allowedExtensions: extensions,
      );
      if (picked == null || picked.files.isEmpty) return null;

      if (picked.files.first.size > 20 * 1024 * 1024) {
        Toast.failure("File size is too large");
      } else {
        final file = picked.files.map((e) => e.bytes).toList().first;
        return file == null ? null : PickedFile(file, picked.files.first.name, null);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future<PickedFile?> pickImage() async {
    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked == null) return null;
      final bytes = await picked.readAsBytes();
      return PickedFile(bytes, picked.name, picked.path);
    } catch (e) {
      return null;
    }
  }
}

class PickedFile {
  final Uint8List file;
  final String filename;
  final String? path;

  const PickedFile(this.file, this.filename, this.path);

  PickedFile copyWith({
    Uint8List? file,
    String? filename,
    String? path,
  }) {
    return PickedFile(
      file ?? this.file,
      filename ?? this.filename,
      path ?? this.path,
    );
  }

  @override
  String toString() => 'PickedFile(file: $file, filename: $filename, path: $path)';
}
