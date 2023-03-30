import 'package:flutter/material.dart';

class BlogWidget extends StatefulWidget {
  final String heading;
  final String desc;
  final String image;
  const BlogWidget({
    Key? key,
    required this.heading,
    required this.desc,
    required this.image,
  }) : super(key: key);

  @override
  State<BlogWidget> createState() => _BlogWidgetState();
}

class _BlogWidgetState extends State<BlogWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  widget.heading,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Image(
                  image: NetworkImage(
                    widget.image,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.desc,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blueGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
