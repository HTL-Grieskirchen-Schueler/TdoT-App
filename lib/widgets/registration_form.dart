import 'package:flutter/cupertino.dart';
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

  bool _validateForm = false;

  late DateTime dropdownValue = widget.dates.first;

  void reset() {
    _schoolController.clear();
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();

    setState(() {
      _validateForm = false;
    });
  }

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
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Datum",
                        style: TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) => Container(
                              height: 216,
                              padding: const EdgeInsets.only(top: 6.0),
                              margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              color: CupertinoColors.systemBackground
                                  .resolveFrom(context),
                              child: SafeArea(
                                top: false,
                                child: CupertinoPicker(
                                  magnification: 1.22,
                                  squeeze: 1.2,
                                  useMagnifier: true,
                                  itemExtent: 32.0,
                                  scrollController: FixedExtentScrollController(
                                    initialItem:
                                        widget.dates.indexOf(dropdownValue),
                                  ),
                                  onSelectedItemChanged: (int selectedItem) {
                                    setState(() {
                                      dropdownValue =
                                          widget.dates[selectedItem];
                                    });
                                  },
                                  children: widget.dates.map((date) {
                                    return Center(
                                      child: Text(
                                        "${date.day}.${date.month}.${date.year}",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CupertinoColors.systemGrey4,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${dropdownValue.day}.${dropdownValue.month}.${dropdownValue.year}",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Icon(
                                CupertinoIcons.calendar,
                                color: CupertinoColors.systemGrey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                  child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 24.0,
                    ),
                    onPressed: () => _submitForm(context),
                    color: CupertinoColors.transparent,
                    child: const Text(
                      'Anmelden',
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 16.0,
                      ),
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
                    color: CupertinoColors.systemRed,
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: CupertinoColors.systemGrey,
            ),
          ),
          const SizedBox(height: 8.0),
          CupertinoTextField(
            controller: controller,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: CupertinoColors.systemGrey4,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            keyboardType: keyboardType,
            onChanged: (value) {
              if (validator != null && _validateForm) {
                // Only force validation on change if we're in validation mode
                setState(() {});
              }
            },
          ),
          if (validator != null)
            Builder(
              builder: (context) {
                final errorText = validator(controller?.text);
                if ((_validateForm || controller?.text.isNotEmpty == true) &&
                    errorText != null) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      errorText,
                      style: const TextStyle(
                        color: CupertinoColors.systemRed,
                        fontSize: 12.0,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
        ],
      ),
    );
  }

  void _submitForm(BuildContext context) {
    setState(() {
      _validateForm = true;
    });

    final schoolError = FormBuilderValidators.required(
      errorText: "Dieses Feld darf nicht leer sein!",
    )(_schoolController.text);

    final nameError = FormBuilderValidators.required(
      errorText: "Dieses Feld darf nicht leer sein!",
    )(_nameController.text);

    final emailError = FormBuilderValidators.email(
      errorText: "Bitte geben Sie eine valide Email ein!",
    )(_emailController.text);

    final phoneError = FormBuilderValidators.phoneNumber(
      errorText: "Bitte geben Sie eine valide Telefonnummer ein!",
    )(_phoneController.text);

    if (schoolError == null &&
        nameError == null &&
        emailError == null &&
        phoneError == null) {
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
