// ignore_for_file: non_constant_identifier_names

import 'package:banner_listtile/banner_listtile.dart';
import 'package:flutter/material.dart';

import 'package:vedic_heals/constants/global_variables.dart';

class RemidieWidget extends StatefulWidget {
  final String material;
  final String image;
  final String alternatives;
  final String dir_for_use;
  final List precautions;
  const RemidieWidget({
    Key? key,
    required this.material,
    required this.image,
    required this.alternatives,
    required this.dir_for_use,
    required this.precautions,
  }) : super(key: key);

  @override
  State<RemidieWidget> createState() => _RemidieWidgetState();
}

class _RemidieWidgetState extends State<RemidieWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          BannerListTile(
            backgroundColor: textColor,
            borderRadius: BorderRadius.circular(8),
            imageContainer: Image(
              image: NetworkImage(widget.image),
              fit: BoxFit.cover,
            ),
            title: Text(
              widget.material,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            subtitle: Text(
              widget.alternatives,
              style: const TextStyle(fontSize: 13),
            ),
            showBanner: false,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Direction for use:-',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.dir_for_use,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          const Text(
            'Precautions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: widget.precautions.length,
              itemBuilder: (context, index) {
                return points(widget.precautions[index]);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget points(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w900,
          color: Colors.grey,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
