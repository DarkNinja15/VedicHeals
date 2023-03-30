import 'package:flutter/material.dart';

import '../constants/global_variables.dart';
import '../widgets/remidie_widget.dart';

class DiseaseDetailPage extends StatefulWidget {
  final String diseaseName;
  final List remdies;
  const DiseaseDetailPage({
    Key? key,
    required this.diseaseName,
    required this.remdies,
  }) : super(key: key);

  @override
  State<DiseaseDetailPage> createState() => _DiseaseDetailPageState();
}

class _DiseaseDetailPageState extends State<DiseaseDetailPage> {
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
          'VedicHeals',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.diseaseName.toUpperCase(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 0.4,
              color: Colors.grey,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: widget.remdies.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RemidieWidget(
                        material: widget.remdies[index]['material'],
                        image: widget.remdies[index]['Image'],
                        alternatives: widget.remdies[index]['Alternatives'],
                        dir_for_use: widget.remdies[index]['dir_for_use'],
                        precautions: widget.remdies[index]['Precautions'],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
