import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackReviewPage extends StatefulWidget {
  const FeedbackReviewPage({super.key});

  @override
  State<FeedbackReviewPage> createState() => _FeedbackReviewPageState();
}

class _FeedbackReviewPageState extends State<FeedbackReviewPage> {
  final TextEditingController flightSearchController = TextEditingController();
  SharedPreferences? pref;

  // Example data: Flight reviews
  final Map<String, List<Map<String, String>>> flightReviews = {
    '810m': [
      {'review': 'Great flight!', 'adminResponse': ''},
      {'review': 'Comfortable and on time.', 'adminResponse': ''},
    ],
  };

  List<String> flightIds = [];
  List<Map<String, String>>? selectedFlightReviews;

  @override
  void initState() {
    super.initState();
    _loadFlightIds();
  }

  Future<void> _loadFlightIds() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      flightIds = pref!.getStringList('UniqueFlightId') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flight search
            TypeAheadField(
              controller: flightSearchController,
              builder: (context, controller, focusNode) {
                return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter FLight Id',
                    ));
              },
              suggestionsCallback: (query) {
                return flightIds
                    .where(
                        (id) => id.toLowerCase().contains(query.toLowerCase()))
                    .toList();
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              onSelected: (String suggestion) {
                setState(() {
                  flightSearchController.text = suggestion;
                  selectedFlightReviews = flightReviews[suggestion];
                });
              },
              hideOnLoading: true,
              hideOnError: true,
              loadingBuilder: (context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: const CircularProgressIndicator(),
              ),
              errorBuilder: (context, error) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  error.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Display reviews
            if (selectedFlightReviews != null)
              Expanded(
                child: ListView.builder(
                  itemCount: selectedFlightReviews!.length,
                  itemBuilder: (context, index) {
                    final review = selectedFlightReviews![index];
                    final TextEditingController adminResponseController =
                        TextEditingController(
                            text: review['adminResponse'] ?? '');

                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "User Review: ${review['review']}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: adminResponseController,
                              decoration: const InputDecoration(
                                labelText: 'Admin Response',
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 2,
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  review['adminResponse'] =
                                      adminResponseController.text;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Response saved!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: const Text('Save Response'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
