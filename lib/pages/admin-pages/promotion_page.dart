import 'package:flightly/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({super.key});

  @override
  State<PromotionPage> createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  SharedPreferences? pref;
  List<String> UniqueFlightId = [];
  List<String> DepartCity = [];
  List<String> ArrivalCity = [];
  List<String> DepartTime = [];
  List<String> DepartDate = [];
  var sid;
  final formKey = GlobalKey<FormState>();
  var coupon_code_controller = TextEditingController();
  var discount_controller = TextEditingController();

  Future<void> loadSharedPrefrence() async {
    pref = await SharedPreferences.getInstance();

    setState(() {
      UniqueFlightId = pref!.getStringList('UniqueFlightId') ?? ['hello'];
      DepartCity = pref!.getStringList('DepartCity') ?? [];
      ArrivalCity = pref!.getStringList('ArrivalCity') ?? [];
      DepartTime = pref!.getStringList('DepartTime') ?? [];
      DepartDate = pref!.getStringList('DepartDate') ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    loadSharedPrefrence();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 380,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButtonFormField<String>(
                        value: sid,
                        hint: Text("Select a Flight"),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                        ),
                        items: UniqueFlightId.asMap().entries.map((entry) {
                          int index = entry.key;
                          String flightId = entry.value;

                          return DropdownMenuItem<String>(
                            value: flightId,
                            child: Text(
                                '${DepartCity[index]} To ${ArrivalCity[index]} \nOn ${DepartDate[index]} Id ${UniqueFlightId[index]}'),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            sid = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a flight';
                          }
                          return null;
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    width: 350,
                    child: TextFormField(
                      controller: coupon_code_controller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Coupon Code',
                          helperText: 'Enter Coupon Code'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Coupon Code';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Container(
                    width: 350,
                    child: TextFormField(
                      controller: discount_controller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Discount Percentage',
                          helperText: 'Enter Discount Percentage'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Discount Percentage';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Promotion Added successfully"),
                            backgroundColor: AppColors.primary,
                            duration: Duration(seconds: 4),
                          ),
                        );
                        // setState(() {
                        //   UniqueFlightId.add(uuid.v4());
                        //   DepartCity.add(departurecity_contol.text);
                        //   ArrivalCity.add(arrivalcity_contol.text);
                        //   DepartTime.add(departure_time_contol.text);
                        //   DepartDate.add(departure_date_contol.text);
                        // });

                        // await pref!.setStringList('UniqueFlightId', UniqueFlightId);
                        // await pref!.setStringList('DepartCity', DepartCity);
                        // await pref!.setStringList('ArrivalCity', ArrivalCity);
                        // await pref!.setStringList('DepartTime', DepartTime);
                        // await pref!.setStringList('DepartDate', DepartDate);
                      }
                    },
                    child: Text('Add Promotion')),
              ],
            ),
          ),
        ])));
  }
}
