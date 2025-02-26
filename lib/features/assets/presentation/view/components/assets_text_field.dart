import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/constants/colors_constants.dart';

class AssetsTextField extends StatelessWidget {
  final TextEditingController searchController;
  final String? labelText;
  const AssetsTextField({
    super.key,
    required this.searchController,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        labelStyle: const TextStyle(
          color: ColorsConstants.gray,
        ),
        filled: true,
        prefixIcon: const Icon(
          Icons.search,
          color: ColorsConstants.gray,
        ),
        fillColor: ColorsConstants.lightGray,
      ),
    );
  }
}
