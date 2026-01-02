
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/utils/routes/routes_name.dart';
import 'package:provide/widgets/text_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provide/services/user_service.dart';
import 'package:provide/model/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provide/utils/routes/utils.dart';
import 'package:flutter/foundation.dart';

class ProfileSetupView extends StatefulWidget {
  const ProfileSetupView({super.key});

  @override
  State<ProfileSetupView> createState() => _ProfileSetupViewState();
}

class _ProfileSetupViewState extends State<ProfileSetupView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genreTagsController = TextEditingController();
  
  String? _selectedGenre;
  Uint8List? _imageBytes;
  String? _imageFileName;
  bool _isLoading = false;
  UserModel? _currentUser;

  final List<String> _genres = [
    'Hip Hop',
    'R&B',
    'Pop',
    'Rock',
    'Electronic',
    'Jazz',
    'Blues',
    'Country',
    'Reggae',
    'Latin',
    'Classical',
    'Metal',
    'Folk',
    'Soul',
    'Funk',
    'Disco',
    'House',
    'Techno',
    'Dubstep',
    'Trap',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId != null) {
        final user = await _userService.getUserById(userId);
        if (user != null) {
          setState(() {
            _currentUser = user;
            _nameController.text = user.name;
          });
        }
      }
    } catch (e) {
      debugPrint('Error loading user: $e');
    }
  }

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _imageBytes = result.files.first.bytes;
          _imageFileName = result.files.first.name;
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      Utils.tosatMassage('Failed to pick image');
    }
  }

  Future<String?> _uploadImage() async {
    if (_imageBytes == null) return null;

    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return null;

      final fileName = 'profile_$userId${_imageFileName != null ? '_$_imageFileName' : '.jpg'}';
      final ref = FirebaseStorage.instance.ref().child('profile_images/$fileName');
      
      await ref.putData(_imageBytes!);
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint('Error uploading image: $e');
      Utils.tosatMassage('Failed to upload image');
      return null;
    }
  }

  Future<void> _saveProfile() async {
    if (_isLoading) return;

    // Validation
    if (_nameController.text.trim().isEmpty) {
      Utils.tosatMassage('Please enter your full name');
      return;
    }

    if (_selectedGenre == null || _selectedGenre!.isEmpty) {
      Utils.tosatMassage('Please select a genre');
      return;
    }

    if (_genreTagsController.text.trim().isEmpty) {
      Utils.tosatMassage('Please enter genre tags');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null || _currentUser == null) {
        throw Exception('User not authenticated');
      }

      // Upload image if selected
      String? profileImageUrl;
      if (_imageBytes != null) {
        profileImageUrl = await _uploadImage();
      }

      // Parse genre tags (comma-separated)
      final genreTags = _genreTagsController.text
          .split(',')
          .map((tag) => tag.trim())
          .where((tag) => tag.isNotEmpty)
          .toList();

      // Update user profile
      final updatedUser = _currentUser!.copyWith(
        name: _nameController.text.trim(),
        genre: _selectedGenre,
        genreTags: genreTags,
        profileImage: profileImageUrl ?? _currentUser!.profileImage,
        updatedAt: DateTime.now(),
      );

      await _userService.updateUser(updatedUser);

      if (!mounted) return;
      
      Utils.tosatMassage('Profile updated successfully!');
      Navigator.pushReplacementNamed(context, RoutesName.subscription);
    } catch (e) {
      debugPrint('Error saving profile: $e');
      Utils.tosatMassage('Failed to save profile: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _genreTagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.w(5),
            vertical: Responsive.h(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SvgPicture.asset("assets/icons/Arrowback.svg"),
              ),
              SizedBox(height: Responsive.h(1)),
              TextWidget(text: "Profile Setup", fontSize: 35),
              SizedBox(height: Responsive.h(2)),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Profile Image Picker
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: Responsive.w(30),
                          height: Responsive.w(30),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.textColor.withValues(alpha: 0.10),
                            border: Border.all(
                              color: AppColor.seconadryColor,
                              width: 2,
                            ),
                          ),
                          child: _imageBytes != null
                              ? ClipOval(
                                  child: Image.memory(
                                    _imageBytes!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_a_photo,
                                      color: AppColor.textColor,
                                      size: Responsive.sp(30),
                                    ),
                                    SizedBox(height: Responsive.h(0.5)),
                                    TextWidget(
                                      text: "Add Photo",
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      SizedBox(height: Responsive.h(2)),
                      
                      // Full Name
                      TextFormField(
                        controller: _nameController,
                        style: TextStyle(color: AppColor.textColor),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          label: TextWidget(text: "Full Name"),
                          filled: true,
                          fillColor: AppColor.textColor.withValues(alpha: 0.10),
                        ),
                      ),
                      SizedBox(height: Responsive.h(2)),
                      
                      // Pick Genre Dropdown
                      DropdownButtonFormField<String>(
                        dropdownColor: AppColor.darkGray,
                        focusColor: AppColor.whiteColor.withValues(alpha: 0.10),
                        value: _selectedGenre,
                        iconEnabledColor: AppColor.whiteColor,
                        onChanged: (String? newValue) {
                          setState(() => _selectedGenre = newValue);
                        },
                        items: _genres.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: TextWidget(text: value),
                          );
                        }).toList(),
                        style: TextStyle(color: AppColor.textColor),
                        decoration: InputDecoration(
                          fillColor: AppColor.textColor.withValues(alpha: 0.10),
                          filled: true,
                          labelText: 'Pick Genre',
                          labelStyle: TextStyle(
                            fontSize: Responsive.textScaleFactor * 14,
                            height: 1.0,
                            color: AppColor.textColor,
                            fontWeight: FontWeight.w400,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                      ),
                      SizedBox(height: Responsive.h(2)),
                      
                      // Genre Tags
                      TextFormField(
                        controller: _genreTagsController,
                        style: TextStyle(color: AppColor.textColor),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          label: TextWidget(text: "Genre Tags (comma-separated)"),
                          hintText: "e.g., rap, trap, beats",
                          hintStyle: TextStyle(
                            color: AppColor.textColor.withValues(alpha: 0.4),
                            fontSize: Responsive.textScaleFactor * 12,
                          ),
                          filled: true,
                          fillColor: AppColor.textColor.withValues(alpha: 0.10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: Responsive.h(2)),
              
              // Save & Continue Button
              GestureDetector(
                onTap: _isLoading ? null : _saveProfile,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.seconadryColor),
                    borderRadius: BorderRadius.circular(18),
                    color: _isLoading 
                        ? AppColor.seconadryColor.withValues(alpha: 0.5)
                        : AppColor.seconadryColor,
                  ),
                  child: Padding(
                    padding: Responsive.padding(
                      left: 2,
                      right: 2,
                      top: 1.5,
                      bottom: 1.5,
                    ),
                    child: Center(
                      child: _isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColor.textColor,
                                ),
                              ),
                            )
                          : TextWidget(text: "Save & continue"),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Responsive.h(1)),
            ],
          ),
        ),
      ),
    );
  }
}
