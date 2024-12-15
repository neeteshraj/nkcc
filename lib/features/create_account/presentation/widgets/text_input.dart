import 'package:flutter/material.dart';
import 'package:support/core/theme/app_colors.dart';
import 'package:support/core/utils/size_utils.dart';
import 'package:support/core/utils/translation_utils.dart';
import 'package:support/core/utils/validators.dart';

class TextInputFieldsWidget extends StatefulWidget {
  const TextInputFieldsWidget({super.key});

  @override
  _TextInputFieldsWidgetState createState() => _TextInputFieldsWidgetState();
}

class _TextInputFieldsWidgetState extends State<TextInputFieldsWidget> {
  late Future<Map<String, String>> _translationsFuture;
  bool _isPasswordVisible = false;

  // Controllers for each text field
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _translationsFuture = _loadTranslations(context);
  }

  Future<Map<String, String>> _loadTranslations(BuildContext context) async {
    try {
      final translations = await loadTranslations(context);
      return translations;
    } catch (error) {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _translationsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Error loading translations'));
        }

        final translations = snapshot.data!;
        return SingleChildScrollView(
          child: Padding(
            padding: SizeUtils.getPadding(context, 0.01, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: SizeUtils.getPadding(context, 0, 0.05),
                  child: TextField(
                    cursorColor: Colors.white,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: translations['enterFullName'] ?? 'Enter full name',
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.4),
                        fontSize: 18,
                        height: 2.5,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.buttonBackground, width: 2),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Padding(
                  padding: SizeUtils.getPadding(context, 0, 0.05),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _emailController,
                      cursorColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        hintText: translations['enterEmailAddress'] ?? 'Enter email address',
                        hintStyle: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.4),
                          fontSize: 18,
                          height: 2.5,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.buttonBackground, width: 2),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: validateEmail,
                    ),
                  ),
                ),
                Padding(
                  padding: SizeUtils.getPadding(context, 0, 0.05),
                  child: TextField(
                    cursorColor: Colors.white,
                    obscureText: !_isPasswordVisible,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: translations['password'] ?? 'Enter password',
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.4),
                        fontSize: 18,
                        height: 2.5,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.buttonBackground, width: 2),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
