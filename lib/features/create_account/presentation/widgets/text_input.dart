import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:support/core/theme/app_colors.dart';
import 'package:support/core/utils/size_utils.dart';
import 'package:support/core/utils/validators.dart';
import 'package:support/features/create_account/presentation/bloc/create_account_cubit.dart';
import 'package:support/features/create_account/presentation/bloc/create_account_state.dart';

class TextInputFieldsWidget extends StatefulWidget {
  final Map<String, String> translations;

  const TextInputFieldsWidget({super.key, required this.translations});

  @override
  _TextInputFieldsWidgetState createState() => _TextInputFieldsWidgetState();
}

class _TextInputFieldsWidgetState extends State<TextInputFieldsWidget> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  bool _isPasswordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();

    _fullNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _phoneFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translations = widget.translations;

    return BlocBuilder<CreateAccountCubit, CreateAccountState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: SizeUtils.getPadding(context, 0.01, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: SizeUtils.getPadding(context, 0, 0.05),
                  child: TextField(
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    controller: _fullNameController,
                    focusNode: _fullNameFocusNode,
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
                    onEditingComplete: () => FocusScope.of(context).requestFocus(_emailFocusNode),
                  ),
                ),
                Padding(
                  padding: SizeUtils.getPadding(context, 0, 0.05),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      onChanged: (value) {
                        context.read<CreateAccountCubit>().updateEmail(value);
                      },
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
                        errorText: !state.isEmailValid && _emailController.text.isNotEmpty
                            ? (translations['invalidEmail'] ?? 'Invalid email address')
                            : null,
                        errorStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => FocusScope.of(context).requestFocus(_passwordFocusNode),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return translations['emailRequired'] ?? 'Email is required';
                        } else if (!validateEmail(value)) {
                          return translations['invalidEmail'] ?? 'Invalid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: SizeUtils.getPadding(context, 0, 0.05),
                  child: TextField(
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    cursorColor: Colors.white,
                    obscureText: !_isPasswordVisible,
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
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
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).requestFocus(_phoneFocusNode),
                  ),
                ),
                // Phone Number Input Field
                Padding(
                  padding: SizeUtils.getPadding(context, 0, 0.05),
                  child: TextFormField(
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    controller: _phoneController,
                    focusNode: _phoneFocusNode,
                    cursorColor: Colors.white,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: translations['enterPhoneNumber'] ?? 'Enter phone number',
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.4),
                        fontSize: 18,
                        height: 2.5,
                      ),
                      counterText: "",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.buttonBackground, width: 2),
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return translations['phoneRequired'] ?? 'Phone number is required';
                      } else if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
                        return translations['invalidPhone'] ?? 'Invalid phone number';
                      }
                      return null;
                    },
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
