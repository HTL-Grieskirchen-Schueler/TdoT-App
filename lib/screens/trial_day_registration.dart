import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class TrialDayRegistrationScreen extends StatefulWidget {
  const TrialDayRegistrationScreen({super.key});

  @override
  State<TrialDayRegistrationScreen> createState() =>
      _TrialDayRegistrationScreenState();
}

class _TrialDayRegistrationScreenState
    extends State<TrialDayRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
                      _telController,
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
                          borderRadius: BorderRadius.circular(30.0)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            debugPrint("Schule: ${_schoolController.text}");
                            debugPrint("Name: ${_nameController.text}");
                            debugPrint("Email: ${_emailController.text}");
                            debugPrint("Tel: ${_telController.text}");
                          }
                        },
                        child: const Text(
                          'Anmelden',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      )),
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
      ),
    );
  }

  Widget _buildTextFormField(String label,
      [String? Function(String?)? validator,
      TextEditingController? controller,
      TextInputType? keyboardType]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        autovalidateMode: AutovalidateMode.onUnfocus,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
      ),
    );
  }

  @override
  void dispose() {
    _schoolController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _telController.dispose();
    super.dispose();
  }
}
