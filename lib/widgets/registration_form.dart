import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../models/trial_day_registration.model.dart';

class RegistrationForm extends StatefulWidget {
  final List<DateTime> dates;
  final String infoText;
  final void Function(TrialDayRegistration) onSubmit;

  const RegistrationForm({
    super.key,
    required this.dates,
    required this.infoText,
    required this.onSubmit,
  });

  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _schoolController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  late DateTime dropdownValue = widget.dates.first;

  @override
  void dispose() {
    _schoolController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField2<DateTime>(
                    value: dropdownValue,
                    decoration: const InputDecoration(
                      labelText: "Datum",
                      border: OutlineInputBorder(),
                    ),
                    items: widget.dates.map((date) {
                      return DropdownMenuItem<DateTime>(
                        value: date,
                        child: Text("${date.day}.${date.month}.${date.year}"),
                      );
                    }).toList(),
                    onChanged: (DateTime? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                _buildTextFormField(
                  "Schule",
                  FormBuilderValidators.required(
                    errorText: "Dieses Feld darf nicht leer sein!",
                  ),
                  _schoolController,
                ),
                _buildTextFormField(
                  "Name",
                  FormBuilderValidators.required(
                    errorText: "Dieses Feld darf nicht leer sein!",
                  ),
                  _nameController,
                ),
                _buildTextFormField(
                  "Email",
                  FormBuilderValidators.email(
                    errorText: "Bitte geben Sie eine valide Email ein!",
                  ),
                  _emailController,
                  TextInputType.emailAddress,
                ),
                _buildTextFormField(
                  "Tel",
                  FormBuilderValidators.phoneNumber(
                    errorText: "Bitte geben Sie eine valide Telefonnummer ein!",
                  ),
                  _phoneController,
                  TextInputType.phone,
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xE43FA9D3),
                        Color(0xFF003BA9),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () => _submitForm(context),
                    child: const Text(
                      'Anmelden',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 32.0),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Wichtig!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  widget.infoText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(
    String label, [
    String? Function(String?)? validator,
    TextEditingController? controller,
    TextInputType? keyboardType,
  ]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Stack(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final registration = TrialDayRegistration(
        date: dropdownValue,
        school: _schoolController.text,
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
      );

      widget.onSubmit(registration);
    }
  }
}
