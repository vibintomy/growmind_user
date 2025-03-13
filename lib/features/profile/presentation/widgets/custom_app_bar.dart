
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        
        title: const Text(
          'My Courses',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        background: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            'https://images.joseartgallery.com/100736/what-kind-of-art-is-popular-right-now.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      floating: false,
      pinned: true,
      snap: false,
      elevation: 10.0,
      backgroundColor: Colors.transparent,
    
    );
  }
}
