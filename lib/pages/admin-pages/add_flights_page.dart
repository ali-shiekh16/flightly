import 'package:flightly/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';

class AddFlightsPage extends StatefulWidget {
  const AddFlightsPage({super.key});

  @override
  State<AddFlightsPage> createState() => _AddFlightspagerPage();
}

class _AddFlightspagerPage extends State<AddFlightsPage> {
  final formKey = GlobalKey<FormState>();
  final arrivalcity_contol = TextEditingController();
  final departurecity_contol = TextEditingController();
  final departure_time_contol = TextEditingController();
  final departure_date_contol = TextEditingController();
  // var uuid = Uuid();
  List<String> UniqueFlightId = [];
  List<String> DepartCity = [];
  List<String> ArrivalCity = [];
  List<String> DepartTime = [];
  List<String> DepartDate = [];

  SharedPreferences? pref;

  Future<void> loadSharedPrefrence() async {
    pref = await SharedPreferences.getInstance();

    setState(() {
      UniqueFlightId = pref!.getStringList('UniqueFlightId') ?? [];
      DepartCity = pref!.getStringList('DepartCity') ?? [];
      ArrivalCity = pref!.getStringList('ArrivalCity') ?? [];
      DepartTime = pref!.getStringList('DepartTime') ?? [];
      DepartDate = pref!.getStringList('DepartDate') ?? [];
      // UniqueFlightId.clear();
      // DepartCity.clear();
      // ArrivalCity.clear();
      // DepartTime.clear();
      // DepartDate.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    loadSharedPrefrence();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 15));
    if (picked != null) {
      setState(() {
        // Update the TextFormField with the selected date
        departure_date_contol.text = "${picked.toLocal()}".split(' ')[0];
        // selected_date = picked;
      });
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        // Format the time as a string and set it to the TextEditingController
        // print('helo time is $pickedTime');
        departure_time_contol.text = pickedTime.format(context);
        // print(departure_time_contol.text);
        // selected_time = pickedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 350,
              child: TextFormField(
                controller: arrivalcity_contol,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: 'Arrival City',
                    helperText: 'Enter Arrival City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Arrival City';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Container(
                width: 350,
                child: TextFormField(
                  controller: departurecity_contol,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Departure City',
                      helperText: 'Enter Departure City'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Departure City';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
            Container(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TextFormField(
                  readOnly: true,
                  controller: departure_date_contol,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Date', helperText: 'Enter Date'),
                  onTap: () {
                    selectDate(context);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Date';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
            Container(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TextFormField(
                    readOnly: true,
                    controller: departure_time_contol,
                    decoration: InputDecoration(
                        labelText: 'Time', helperText: 'Enter Time'),
                    onTap: () {
                      selectTime(context);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter time';
                      } else {
                        return null;
                      }
                    }),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Flight Added successfully"),
                        backgroundColor: AppColors.primary,
                        duration: Duration(seconds: 4),
                      ),
                    );
                    setState(() {
                      UniqueFlightId.add(randomAlphaNumeric(4));
                      DepartCity.add(departurecity_contol.text);
                      ArrivalCity.add(arrivalcity_contol.text);
                      DepartTime.add(departure_time_contol.text);
                      DepartDate.add(departure_date_contol.text);
                      // UniqueFlightId.clear();
                      // DepartCity.clear();
                      // ArrivalCity.clear();
                      // DepartTime.clear();
                      // DepartDate.clear();
                    });

                    await pref!.setStringList('UniqueFlightId', UniqueFlightId);
                    await pref!.setStringList('DepartCity', DepartCity);
                    await pref!.setStringList('ArrivalCity', ArrivalCity);
                    await pref!.setStringList('DepartTime', DepartTime);
                    await pref!.setStringList('DepartDate', DepartDate);
                  }
                },
                child: Text('Add Flight')),
          ],
        ),
      ),
    );
  }
}
