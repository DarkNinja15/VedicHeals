import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vedic_heals/constants/global_variables.dart';
import 'package:vedic_heals/screens/disease_detail_page.dart';
import '../models/disease_model.dart';
import '../widgets/loading.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool isLoading = false;
  late List<DiseaseModel> diseases;

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    diseases = Provider.of<List<DiseaseModel>>(context);
    isLoading = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
        body: isLoading
            ? const Loading()
            : SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.5,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.zero,
                                bottom: Radius.circular(20),
                              ),
                              child: Container(
                                height: size.height * 0.45,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/home3.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 4,
                                    sigmaY: 4,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Where ancient Wisdom meets Modern Wellness.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showSearch(
                                  context: context,
                                  delegate: CustomSearchDelegate(
                                    searchTerms: diseases,
                                  ),
                                );
                              },
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        height: 40,
                                        width: double.infinity,
                                        color: textColor,
                                        child: const Center(
                                          child: Text(
                                            'Get Remedies',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Image(
                        image: AssetImage(
                          'assets/images/yoga.png',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Our application is a platform dedicated to providing alternative home remedies for various diseases, along with information on Ayurvedic institutions and hospitals across the country.\n We also share insightful blogs on the latest researches on diseases to help users stay informed about Ayurvedic medicine.\n Our mission is to promote natural health and wellness through the use of Ayurvedic remedies and to provide reliable information to our users.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List searchTerms;
  CustomSearchDelegate({required this.searchTerms});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.clear,
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<DiseaseModel> matchQuery = [];
    for (var dis in searchTerms) {
      if ((dis.Disease_Name).toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(dis);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DiseaseDetailPage(
                    diseaseName: matchQuery[index].Disease_Name,
                    remdies: matchQuery[index].Remidies,
                  ),
                ),
              );
            },
            child: ListTile(
              title: Text(matchQuery[index].Disease_Name),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<DiseaseModel> matchQuery = [];
    for (var dis in searchTerms) {
      if ((dis.Disease_Name).toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(dis);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DiseaseDetailPage(
                    diseaseName: matchQuery[index].Disease_Name,
                    remdies: matchQuery[index].Remidies,
                  ),
                ),
              );
            },
            child: ListTile(
              title: Text(matchQuery[index].Disease_Name),
            ),
          );
        });
  }
}
