import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyedge/providers/questionnaire_provider.dart';
import 'package:country_state_city/country_state_city.dart' as country;
import 'package:skyedge/theme/app_theme.dart';

class CountryPicker extends StatefulWidget {
  final int questionId;

  CountryPicker({
    Key? key,
    required this.questionId,
  }) : super(key: key);

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  List<country.Country> countries = [];
  bool isLoading = true;
  String? error;

  Future<void> loadCountries() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final dataState = await country.getAllCountries();
      setState(() {
        countries = dataState;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = "Failed to load countries. Please try again.";
        isLoading = false;
      });
      debugPrint("Error loading countries: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    loadCountries();
  }

  @override
  Widget build(BuildContext context) {
    final questionnaireProv = Provider.of<QuestionnaireProvider>(context);
    String? selectedCountry;

    try {
      selectedCountry = questionnaireProv.questionResponse.firstWhere(
        (element) => element["question_id"] == widget.questionId,
        orElse: () => {"question_id": widget.questionId, "answer_text": null},
      )["answer_text"];
    } catch (e) {
      debugPrint("Error getting selected country: $e");
      selectedCountry = null;
    }

    debugPrint("selectedCountry: $selectedCountry");

    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.grey),
      ),
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : error != null
              ? Center(
                  child: Text(
                    error!,
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text(selectedCountry ?? "Select Country"),
                    value: selectedCountry,
                    icon: Icon(Icons.arrow_drop_down),
                    items: countries.map((country.Country country) {
                      return DropdownMenuItem<String>(
                        value: country.name,
                        child: Text(country.name ?? ""),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      debugPrint("newValue: $newValue");
                      if (newValue != null) {
                        questionnaireProv.addQuestionResponse(
                            widget.questionId, newValue, false);
                      }
                    },
                  ),
                ),
    );
  }
}

//  Container(
//                             height: 50,
//                             margin: const EdgeInsets.symmetric(vertical: 10),
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             width: double.infinity,
//                             alignment: Alignment.centerLeft,
//                             decoration: BoxDecoration(
//                               color: Colors.transparent,
//                               border: Border.all(color: Colors.grey),
//                             ),
//                             child: Row(
//                               children: [
//                                 Text("Date"),
//                                 Spacer(),
//                                 Icon(Icons.calendar_month),
//                               ],
//                             ),
//                           ),
