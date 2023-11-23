import 'package:el_karooz/model/user_interface.dart';
import 'package:el_karooz/widgets/original.button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
    required this.onRegisterSubmit,
    required this.toggleForm,
  }) : super(key: key);

  final Function(UserModel) onRegisterSubmit;
  final Function toggleForm;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final fullName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  final education = TextEditingController();
  bool showPassword = false;
  TextEditingController birthday = TextEditingController();
  String? gender;

  static const List<Map<String, String>> list = [
    {"value": "Male", "label": "ذكر"},
    {"value": "Female", "label": "انثى"}
  ];

  @override
  void initState() {
    super.initState();
    birthday.text = ""; // Set the initial value of the text field
    gender = "Male"; // Set a default gender value
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 50),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'ادخل اسم المستخدم',
              hintText: 'ex: اندرو حليم',
            ),
            controller: fullName,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'ادخل البريد الالكترونى',
              hintText: 'ex: andrew@gmail.com',
            ),
            controller: email,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'ادخل رقم الهاتف',
              hintText: 'ex: 01000000000',
            ),
            controller: phoneNumber,
          ),
          const SizedBox(height: 16),
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              TextField(
                  controller: birthday,
                  decoration: const InputDecoration(
                    labelText: 'ادخل تاريخ الميلاد',
                    hintText: 'yyyy-MM-dd',
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1940),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        birthday.text = formattedDate;
                      });
                    }
                  }),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1940),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        birthday.text = formattedDate;
                      });
                    }
                  }
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'ادخل المؤهل الدراسى',
              hintText: 'ex: طالب جامعى',
            ),
            controller: education,
          ),
          const SizedBox(height: 16),
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: const Color.fromRGBO(238, 238, 238, 0.963),
              ),
            ),
            child: DropdownButton<String>(
              value: gender,
              onChanged: (String? value) {
                setState(() {
                  gender = value;
                });
              },
              items: list.map<DropdownMenuItem<String>>(
                (Map<String, String> item) {
                  return DropdownMenuItem<String>(
                    value: item['value'],
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        item['label']!,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          const SizedBox(height: 16),
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              IconButton(
                icon: const Icon(Icons.lock),
                onPressed: () {},
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'ادخل كلمة المرور', hintText: 'ex: 123456'),
                obscureText: !showPassword,
                controller: password,
              ),
              IconButton(
                icon: showPassword
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () {
                  setState(() => showPassword = !showPassword);
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          OriginalButton(
            text: 'إنشاء حساب',
            textColor: Colors.white,
            bgColor: const Color(0xFF003554),
            onPressed: () {
              widget.onRegisterSubmit(UserModel(
                  fullName.text,
                  email.text,
                  password.text,
                  phoneNumber.text,
                  birthday.text,
                  education.text,
                  gender!));
            },
          ),
          const SizedBox(height: 5),
          TextButton(
            onPressed: () {
              widget.toggleForm();
            },
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 236, 240, 242),
              ),
            ),
            child: const Text(
              'تسجيل الدخول',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 17,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
