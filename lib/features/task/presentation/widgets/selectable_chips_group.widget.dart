import 'package:flutter/material.dart';

class SelectableChipsGroup extends StatelessWidget {
  final List<String> items;
  final bool multiSelect;
  final List<String>? selectedItems;
  final String? selectedItem;
  final void Function(String) onItemTap;
  final Color? selectedColor;

  const SelectableChipsGroup({
    super.key,
    required this.items,
    required this.onItemTap,
    this.multiSelect = false,
    this.selectedItems,
    this.selectedItem,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      children: items.map((item) {
        final bool isSelected = multiSelect
            ? selectedItems?.contains(item) ?? false
            : item == selectedItem;

        return InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () => onItemTap(item),
          child: Chip(
            label: Text(item),
            backgroundColor: isSelected
                ? (selectedColor ??
                    Theme.of(context).colorScheme.primaryContainer)
                : null,
          ),
        );
      }).toList(),
    );
  }
}
