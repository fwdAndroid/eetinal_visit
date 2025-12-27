import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int _currentStep = 0;

  // Step 1 fields
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? serviceLocation;

  // Step 2 fields
  String? description;
  double? amount;

  final _formKeyStep1 = GlobalKey<FormState>();
  final _formKeyStep2 = GlobalKey<FormState>();

  void _nextStep() {
    if (_currentStep == 0) {
      if (_formKeyStep1.currentState!.validate()) {
        _formKeyStep1.currentState!.save();
        setState(() {
          _currentStep = 1;
        });
      }
    } else if (_currentStep == 1) {
      if (_formKeyStep2.currentState!.validate()) {
        _formKeyStep2.currentState!.save();
        _bookNow();
      }
    }
  }

  void _bookNow() {
    // Handle booking submission here
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Booking Confirmed"),
        content: Text(
            "Date: ${selectedDate?.toLocal()} \nTime: ${selectedTime?.format(context)} \nLocation: $serviceLocation \nDescription: $description \nAmount: \$${amount?.toStringAsFixed(2)}"),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(), child: const Text("OK"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Book a Service")),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: _nextStep,
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep--;
            });
          }
        },
        steps: [
          Step(
            title: const Text("Service Details"),
            content: Form(
              key: _formKeyStep1,
              child: Column(
                children: [
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: selectedDate == null
                            ? "Select Date"
                            : "${selectedDate?.toLocal()}".split(' ')[0]),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                    validator: (_) =>
                        selectedDate == null ? "Please select a date" : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: selectedTime == null
                            ? "Select Time"
                            : selectedTime!.format(context)),
                    onTap: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedTime = picked;
                        });
                      }
                    },
                    validator: (_) =>
                        selectedTime == null ? "Please select time" : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Service Location"),
                    onSaved: (val) => serviceLocation = val,
                    validator: (val) =>
                        val == null || val.isEmpty ? "Enter location" : null,
                  ),
                ],
              ),
            ),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: const Text("Description & Payment"),
            content: Form(
              key: _formKeyStep2,
              child: Column(
                children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Description"),
                    onSaved: (val) => description = val,
                    validator: (val) =>
                        val == null || val.isEmpty ? "Enter description" : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: "Amount"),
                    onSaved: (val) =>
                        amount = val != null ? double.tryParse(val) : null,
                    validator: (val) =>
                        val == null || val.isEmpty ? "Enter amount" : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _bookNow,
                    child: const Text("Book Now"),
                  ),
                ],
              ),
            ),
            isActive: _currentStep >= 1,
          ),
        ],
      ),
    );
  }
}
