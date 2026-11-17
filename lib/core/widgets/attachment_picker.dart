import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/image_storage.dart';

/// A reusable image attachment field: shows the current image (if any) with
/// camera / gallery / remove actions. Stores the picked image locally and
/// reports the resulting path via [onChanged].
class AttachmentPicker extends StatelessWidget {
  const AttachmentPicker({
    required this.label,
    required this.path,
    required this.onChanged,
    super.key,
  });

  final String label;
  final String? path;
  final ValueChanged<String?> onChanged;

  Future<void> _pick(BuildContext context, ImageSource source) async {
    try {
      final stored = await ImageStorage.pick(source);
      if (stored != null) onChanged(stored);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Could not attach image: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = path != null && File(path!).existsSync();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasImage)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              File(path!),
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        if (hasImage) const SizedBox(height: 8),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: () => _pick(context, ImageSource.camera),
              icon: const Icon(Icons.photo_camera_outlined, size: 18),
              label: const Text('Camera'),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () => _pick(context, ImageSource.gallery),
              icon: const Icon(Icons.photo_library_outlined, size: 18),
              label: const Text('Gallery'),
            ),
            const Spacer(),
            if (hasImage)
              IconButton(
                tooltip: 'Remove',
                onPressed: () => onChanged(null),
                icon: const Icon(Icons.delete_outline),
              ),
          ],
        ),
      ],
    );
  }
}
