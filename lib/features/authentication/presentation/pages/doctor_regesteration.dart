import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/core/components/buttons/main_button.dart';
import 'package:se7ety/core/components/inputs/main_text_form_field.dart';
import 'package:se7ety/core/constants/images.dart';
import 'package:se7ety/core/functions/show_dialoges.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/fonts.dart';
import 'package:se7ety/features/authentication/data/models/specializations.dart';
import 'package:se7ety/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:se7ety/features/authentication/presentation/bloc/auth_states.dart';

class DoctorRegistrationScreen extends StatefulWidget {
  const DoctorRegistrationScreen({super.key});

  @override
  State<DoctorRegistrationScreen> createState() =>
      _DoctorRegistrationScreenState();
}

class _DoctorRegistrationScreenState extends State<DoctorRegistrationScreen> {
  String? _imagePath;
  File? file;
  String? profileUrl;

  String? userID;

  // Database , Cloud

  // to upload image to firestore
  // 1) upload image to storage (Firebase Storage / Supabase storage / Cloudinary)
  // 2) get image url from storage
  // 3) update image url in firestore

  // doctors/729348014014912.png

  // uploadImageToFirebaseStorage(File image, String imageName) async {
  //   try {
  //     Reference ref = FirebaseStorage.instanceFor(
  //       bucket: 'gs://easy-doc-e56b4.appspot.com',
  //     ).ref().child('test/${FirebaseAuth.instance.currentUser!.uid}');

  //     SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
  //     await ref.putFile(image, metadata);
  //     String url = await ref.getDownloadURL();
  //     log(url);
  //     return url;
  //   } on Exception catch (e) {
  //     log(e.toString());
  //   }
  // }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        file = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<AuthBloc>();
    return Scaffold(
      appBar: AppBar(title: const Text('إكمال عملية التسجيل')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                key: bloc.formKey,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,

                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: AppColors.whiteColor,
                            backgroundImage: (_imagePath != null)
                                ? FileImage(File(_imagePath!))
                                : AssetImage(AppImages.emptyDocPNG),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _pickImage();
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Theme.of(
                              context,
                            ).scaffoldBackgroundColor,
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 20,
                              // color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                      child: Row(
                        children: [
                          Text(
                            'التخصص',
                            style: AppFontStyles.body.copyWith(
                              color: AppColors.darkColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                   // التخصص---------------
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cardColor.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButton<String?>(
                        isExpanded: true,
                        iconEnabledColor: AppColors.primaryColor,
                        hint: Text(
                          'اختر التخصص',
                          style: AppFontStyles.body.copyWith(
                            color: AppColors.greyColor,
                          ),
                        ),
                        icon: const Icon(Icons.expand_circle_down_outlined),
                        value: bloc.specialization,
                        onChanged: (String? newValue) {
                          setState(() {
                            bloc.specialization = newValue!;
                          });
                        },
                        items: [
                          for (var specialization in specializations)
                            DropdownMenuItem(
                              value: specialization,
                              child: Text(specialization),
                            ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'نبذة تعريفية',
                            style: AppFontStyles.body.copyWith(
                              color: AppColors.darkColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MainTextFormField(
                      controller: bloc.bioController,
                      maxTextLines: 4,
                      textFormFieldText:
                          'سجل المعلومات الطبية العامة مثل تعليمك الأكاديمي وخبراتك السابقة...',

                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل النبذة التعريفية';
                        } else {
                          return null;
                        }
                      },
                      ispassword: false,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'عنوان العيادة',
                            style: AppFontStyles.body.copyWith(
                              color: AppColors.darkColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MainTextFormField(
                      controller: bloc.addressController,
                      textFormFieldText: '5 شارع مصدق - الدقي - الجيزة',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل عنوان العيادة';
                        } else {
                          return null;
                        }
                      },
                      ispassword: false,
                    ),
                    _workHours(bloc),

                    _phoneNumbers(bloc),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(top: 25.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: MainButton(
            onPressed: () async {
              if (bloc.formKey.currentState!.validate()) {
                if (file != null) {
                  // bloc.imageUrl = await uploadImageToCloudinary(file!) ?? '';

                  // bloc.add(DoctorRegistrationEvent());
                } else {
                  showDialoges(
                    context: context,
                    message: 'من فضلك قم باختيار صورة الصفحة الشخصية',
                  );
                }
              }
            },
            buttonText: "التسجيل",
          ),
        ),
      ),
    );
  }

  Column _workHours(AuthBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'ساعات العمل من',
                      style: AppFontStyles.body.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'الي',
                      style: AppFontStyles.body.copyWith(
                        color: AppColors.darkColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            // ---------- Start Time ----------------
            Expanded(
              child: MainTextFormField(
                readOnly: true,
                controller: bloc.openHourController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'مطلوب';
                  } else {
                    return null;
                  }
                },
                suffixIcon: IconButton(
                  onPressed: () async {
                    await showStartTimePicker(bloc);
                  },
                  icon: const Icon(
                    Icons.watch_later_outlined,
                    color: AppColors.primaryColor,
                  ),
                ),

                textFormFieldText: bloc.openHourController.text,
                ispassword: false,
              ),
            ),
            const SizedBox(width: 10),

            // ---------- End Time ----------------
            Expanded(
              child: MainTextFormField(
                readOnly: true,
                controller: bloc.closeHourController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'مطلوب';
                  } else {
                    return null;
                  }
                },
                suffixIcon: IconButton(
                  onPressed: () async {
                    await showEndTimePicker(bloc);
                  },
                  icon: const Icon(
                    Icons.watch_later_outlined,
                    color: AppColors.primaryColor,
                  ),
                ),

                textFormFieldText: bloc.closeHourController.text ,
                ispassword: false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _phoneNumbers(AuthBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'رقم الهاتف 1',
                style: AppFontStyles.body.copyWith(color: AppColors.darkColor),
              ),
            ],
          ),
        ),
        MainTextFormField(
          controller: bloc.phone1Controller,
          keyboardType: TextInputType.number,
          textFormFieldText: '+20xxxxxxxxxx',

          validator: (value) {
            if (value!.isEmpty) {
              return 'من فضلك ادخل الرقم';
            } else {
              return null;
            }
          },
          ispassword: false,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'رقم الهاتف 2 (اختياري)',
                style: AppFontStyles.body.copyWith(color: AppColors.darkColor),
              ),
            ],
          ),
        ),
        MainTextFormField(
          controller: bloc.phone2Controller,
          keyboardType: TextInputType.number,
          textFormFieldText: '+20xxxxxxxxxx',
          ispassword: false,
        ),
      ],
    );
  }

  Future<void> showStartTimePicker(AuthBloc bloc) async {
    final startTimePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (startTimePicked != null) {
      bloc.openHourController.text = startTimePicked.hour.toString();
    }
  }

  Future<void> showEndTimePicker(AuthBloc bloc) async {
    final endTimePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        DateTime.now().add(const Duration(minutes: 15)),
      ),
    );

    if (endTimePicked != null) {
      bloc.closeHourController.text = endTimePicked.hour.toString();
    }
  }
}
