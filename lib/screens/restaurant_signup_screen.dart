import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class RestaurantSignupScreen extends StatefulWidget {
  const RestaurantSignupScreen({super.key});

  @override
  State<RestaurantSignupScreen> createState() => _RestaurantSignupScreenState();
}

class _RestaurantSignupScreenState extends State<RestaurantSignupScreen> {
  int _currentStep = 0;
  
  // Step 1: Owner Info
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _ownerEmailController = TextEditingController();
  final TextEditingController _ownerCnicController = TextEditingController();
  final TextEditingController _ownerPhoneController = TextEditingController();
  final TextEditingController _ownerPasswordController = TextEditingController();
  
  // Step 2: Restaurant Info
  final TextEditingController _restaurantNameController = TextEditingController();
  final TextEditingController _restaurantAddressController = TextEditingController();
  final TextEditingController _restaurantPhoneController = TextEditingController();
  final TextEditingController _cuisineTypeController = TextEditingController();
  final TextEditingController _openingTimeController = TextEditingController();
  final TextEditingController _closingTimeController = TextEditingController();
  String? _selectedStop;
  
  // Step 3: Files
  File? _restaurantLogo;
  File? _ownershipProof;
  File? _license;
  final ImagePicker _picker = ImagePicker();

  final List<String> _stopLocations = [
    'Sukheki',
    'Sial',
    'Bhera',
    'Kallar Kahar',
    'Chakri',
    'Sheikhupura',
    'Khanqah Dogran',
    'Makhdoom',
    'Kot Momin',
    'Salem',
    'Lilla',
    'Balkasar',
    'Neelah Dullah',
  ];

  Future<void> _selectTime(TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.format(context);
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _restaurantLogo = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _ownershipProof = File(result.files.single.path!);
      });
    }
  }

  Future<void> _pickLicense() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _license = File(result.files.single.path!);
      });
    }
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    } else {
      _submitForm();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _submitForm() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Restaurant registration submitted for review!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Signup'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _nextStep,
        onStepCancel: _previousStep,
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: Text(_currentStep == 2 ? 'Submit' : 'Next'),
                  ),
                ),
                if (_currentStep > 0) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: details.onStepCancel,
                      child: const Text('Back'),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('Owner Information'),
            content: _buildOwnerInfoForm(),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: const Text('Restaurant Information'),
            content: _buildRestaurantInfoForm(),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: const Text('Documents & Files'),
            content: _buildFilesForm(),
            isActive: _currentStep >= 2,
          ),
        ],
      ),
    );
  }

  Widget _buildOwnerInfoForm() {
    return Column(
      children: [
        TextFormField(
          controller: _ownerNameController,
          decoration: const InputDecoration(
            labelText: 'Owner Full Name',
            prefixIcon: Icon(Icons.person_outline),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _ownerEmailController,
          decoration: const InputDecoration(
            labelText: 'Owner Email',
            prefixIcon: Icon(Icons.email_outlined),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _ownerCnicController,
          decoration: const InputDecoration(
            labelText: 'Owner CNIC',
            prefixIcon: Icon(Icons.card_membership),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _ownerPhoneController,
          decoration: const InputDecoration(
            labelText: 'Owner Phone Number',
            prefixIcon: Icon(Icons.phone_outlined),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _ownerPasswordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock_outline),
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantInfoForm() {
    return Column(
      children: [
        TextFormField(
          controller: _restaurantNameController,
          decoration: const InputDecoration(
            labelText: 'Restaurant Name',
            prefixIcon: Icon(Icons.restaurant),
          ),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Stop Location',
            prefixIcon: Icon(Icons.location_on),
          ),
          initialValue: _selectedStop,
          items: _stopLocations.map((String location) {
            return DropdownMenuItem<String>(
              value: location,
              child: Text(location),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedStop = value;
            });
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _restaurantAddressController,
          decoration: const InputDecoration(
            labelText: 'Restaurant Address',
            prefixIcon: Icon(Icons.location_on_outlined),
          ),
          maxLines: 2,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _restaurantPhoneController,
          decoration: const InputDecoration(
            labelText: 'Restaurant Phone',
            prefixIcon: Icon(Icons.phone_outlined),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _cuisineTypeController,
          decoration: const InputDecoration(
            labelText: 'Cuisine Type',
            prefixIcon: Icon(Icons.restaurant_menu),
            hintText: 'e.g., Pakistani, Chinese, Fast Food',
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _openingTimeController,
                decoration: const InputDecoration(
                  labelText: 'Opening Time',
                  prefixIcon: Icon(Icons.access_time),
                ),
                readOnly: true,
                onTap: () => _selectTime(_openingTimeController),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _closingTimeController,
                decoration: const InputDecoration(
                  labelText: 'Closing Time',
                  prefixIcon: Icon(Icons.access_time),
                ),
                readOnly: true,
                onTap: () => _selectTime(_closingTimeController),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilesForm() {
    return Column(
      children: [
        _buildFileUploadButton(
          title: 'Restaurant Logo',
          icon: Icons.image,
          fileName: _restaurantLogo?.path.split('/').last,
          onTap: () => _pickImage(ImageSource.gallery),
        ),
        const SizedBox(height: 16),
        _buildFileUploadButton(
          title: 'Ownership Proof',
          icon: Icons.description,
          fileName: _ownershipProof?.path.split('/').last,
          onTap: _pickFile,
        ),
        const SizedBox(height: 16),
        _buildFileUploadButton(
          title: 'Business License',
          icon: Icons.assignment,
          fileName: _license?.path.split('/').last,
          onTap: _pickLicense,
        ),
      ],
    );
  }

  Widget _buildFileUploadButton({
    required String title,
    required IconData icon,
    String? fileName,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF2D6A4F), size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  if (fileName != null)
                    Text(
                      fileName,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            const Icon(Icons.upload_file, color: Color(0xFF2D6A4F)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ownerNameController.dispose();
    _ownerEmailController.dispose();
    _ownerCnicController.dispose();
    _ownerPhoneController.dispose();
    _ownerPasswordController.dispose();
    _restaurantNameController.dispose();
    _restaurantAddressController.dispose();
    _restaurantPhoneController.dispose();
    _cuisineTypeController.dispose();
    _openingTimeController.dispose();
    _closingTimeController.dispose();
    super.dispose();
  }
}