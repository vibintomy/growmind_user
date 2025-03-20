// filter_sort_bar.dart
import 'package:flutter/material.dart';
import 'package:growmind/core/utils/constants.dart';
import 'package:growmind/features/home/domain/entities/course_entity.dart';

class FilterSortBar extends StatelessWidget {
  final List<CourseEntity> courses;
  final ValueNotifier<String?> selectedCategory;
  final VoidCallback onSortPressed;
  final Function(String?) onCategorySelected;

  const FilterSortBar({
    Key? key,
    required this.courses,
    required this.selectedCategory,
    required this.onSortPressed,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    final List<String> subCategories = courses
        .map((course) => course.subCategory)
        .toSet()
        .toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Sort Button
        ElevatedButton.icon(
          onPressed: onSortPressed,
          icon: const Icon(Icons.sort, color: textColor),
          label: const Text('Sort by Price', style: TextStyle(color: textColor)),
          style: ElevatedButton.styleFrom(backgroundColor: mainColor),
        ),

      
        ValueListenableBuilder<String?>(
          valueListenable: selectedCategory,
          builder: (context, value, _) {
            return DropdownButton<String>(
              hint: const Text("Filter by Category"),
              value: value,
              icon: const Icon(Icons.filter_list_rounded),
              onChanged: (String? newValue) {
                selectedCategory.value = newValue;
                onCategorySelected(newValue);
              },
              items: subCategories
                  .map<DropdownMenuItem<String>>((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}