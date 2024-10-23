import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../blocs/trial_day_registration/trial_day_registration.bloc.dart';
import '../models/trial_day_registration.model.dart';

class RegistrationForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  RegistrationForm({super.key});

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

  void _submitForm(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final registration = TrialDayRegistration(
        school: context.read<TrialDayRegistrationBloc>().state.school,
        name: context.read<TrialDayRegistrationBloc>().state.name,
        email: context.read<TrialDayRegistrationBloc>().state.email,
        phone: context.read<TrialDayRegistrationBloc>().state.phone,
      );
      context
          .read<TrialDayRegistrationBloc>()
          .add(RegisterForTrialDay(registration: registration));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    TextEditingController(
                        text: context
                            .read<TrialDayRegistrationBloc>()
                            .state
                            .school)),
                _buildTextFormField(
                    "Name",
                    FormBuilderValidators.required(
                        errorText: "Dieses Feld darf nicht leer sein!"),
                    TextEditingController(
                        text: context
                            .read<TrialDayRegistrationBloc>()
                            .state
                            .name)),
                _buildTextFormField(
                    "Email",
                    FormBuilderValidators.email(
                        errorText: "Bitte geben Sie eine valide Email ein!"),
                    TextEditingController(
                        text: context
                            .read<TrialDayRegistrationBloc>()
                            .state
                            .email)),
                _buildTextFormField(
                    "Tel",
                    FormBuilderValidators.phoneNumber(
                        errorText:
                            "Bitte geben Sie eine valide Telefonnummer ein!"),
                    TextEditingController(
                        text: context
                            .read<TrialDayRegistrationBloc>()
                            .state
                            .phone)),
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
