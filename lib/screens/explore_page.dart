import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vedic_heals/models/blog_model.dart';

import '../constants/global_variables.dart';
import '../widgets/blog_widget.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  late List<BlogModel> blogs;
  @override
  void didChangeDependencies() {
    blogs = Provider.of<List<BlogModel>>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Image(
          image: AssetImage(
            'assets/images/ayurLogo.png',
          ),
          fit: BoxFit.cover,
        ),
        title: const Text(
          'Blogs',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          return BlogWidget(
            heading: blogs[index].heading,
            desc: blogs[index].desc,
            image: blogs[index].image,
          );
        },
      ),
    );
  }
}
