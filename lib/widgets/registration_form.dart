import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../blocs/trial_day_registration/trial_day_registration.bloc.dart';
import '../models/trial_day_registration.model.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _schoolController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _schoolController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Widget _buildTextFormField(String label,
      [String? Function(String?)? validator,
      TextEditingController? controller,
      TextInputType? keyboardType]) {
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
        school: _schoolController.text,
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
      );

      context.read<TrialDayRegistrationBloc>().add(
            RegisterEvent(registration: registration),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "Schnuppertag Anmeldung",
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32.0),
          Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextFormField(
                    "Schule",
                    FormBuilderValidators.required(
                        errorText: "Dieses Feld darf nicht leer sein!"),
                    _schoolController),
                _buildTextFormField(
                    "Name",
                    FormBuilderValidators.required(
                        errorText: "Dieses Feld darf nicht leer sein!"),
                    _nameController),
                _buildTextFormField(
                    "Email",
                    FormBuilderValidators.email(
                        errorText: "Bitte geben Sie eine valide Email ein!"),
                    _emailController,
                    TextInputType.emailAddress),
                _buildTextFormField(
                    "Tel",
                    FormBuilderValidators.phoneNumber(
                        errorText:
                            "Bitte geben Sie eine valide Telefonnummer ein!"),
                    _phoneController,
                    TextInputType.phone),
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
                        shadowColor: Colors.transparent),
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Wichtig!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 8.0), // Add some space between the texts
                Text(
                  "Am Tag der offene Tür sind dinge zu tun. lorem ipsum doremi ",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
