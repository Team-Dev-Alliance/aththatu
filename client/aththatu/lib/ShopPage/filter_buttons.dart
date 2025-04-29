import 'package:flutter/material.dart';

class FilterButtons extends StatelessWidget {
  final String selected;
  final Function(String) onSelect;

  const FilterButtons({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFilterButton(context, 'Popular'),
        const SizedBox(width: 8),
        _buildFilterButton(context, 'Recent'),
      ],
    );
  }

  Widget _buildFilterButton(BuildContext context, String label) {
    final isSelected = selected == label;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.deepOrange : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.deepOrange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () => onSelect(label),
      child: Text(label),
    );
  }
}
