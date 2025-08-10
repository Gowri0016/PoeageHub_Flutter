import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/address_service.dart';
import '../../services/auth_service.dart';
import '../../utils/pincode_api_helper.dart';

class AddressFormScreen extends StatefulWidget {
  final Address? address;
  const AddressFormScreen({super.key, this.address});

  @override
  State<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _address1Controller;
  late TextEditingController _address2Controller;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _zipController;
  bool _isDefault = false;
  bool _isFetchingPincode = false;
  String? _pincodeError;
  String _country = 'India';
  final List<String> _countries = [
    'India',
    'United States',
    'United Kingdom',
    'Australia',
    'Canada',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    final a = widget.address;
    _nameController = TextEditingController(text: a?.name ?? '');
    _phoneController = TextEditingController(text: a?.phone ?? '');
    _address1Controller = TextEditingController(text: a?.addressLine1 ?? '');
    _address2Controller = TextEditingController(text: a?.addressLine2 ?? '');
    _cityController = TextEditingController(text: a?.city ?? '');
    _stateController = TextEditingController(text: a?.state ?? '');
    _zipController = TextEditingController(text: a?.zipCode ?? '');
    _isDefault = a?.isDefault ?? false;
    if (a?.country != null && a!.country.isNotEmpty) {
      _country = a.country;
    }
    _zipController.addListener(_onZipChanged);
  }

  void _onZipChanged() async {
    final zip = _zipController.text.trim();
    if (zip.length == 6) {
      setState(() {
        _isFetchingPincode = true;
        _pincodeError = null;
      });
      final result = await PincodeApiHelper.fetchDetails(zip);
      if (result != null && result.found) {
        if (result.city != null && result.city!.isNotEmpty) {
          _cityController.text = result.city!;
        }
        if (result.state != null && result.state!.isNotEmpty) {
          _stateController.text = result.state!;
        }
        setState(() {
          _isFetchingPincode = false;
          _pincodeError = null;
        });
      } else {
        setState(() {
          _isFetchingPincode = false;
          _pincodeError = 'Invalid or unknown pincode';
          _cityController.text = '';
          _stateController.text = '';
        });
      }
    } else {
      setState(() {
        _pincodeError = null;
        _cityController.text = '';
        _stateController.text = '';
      });
    }
  }

  @override
  void dispose() {
    _zipController.removeListener(_onZipChanged);
    _nameController.dispose();
    _phoneController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  void _save() async {
    if (_formKey.currentState?.validate() != true) return;
    final address = Address(
      id:
          widget.address?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      addressLine1: _address1Controller.text.trim(),
      addressLine2: _address2Controller.text.trim(),
      city: _cityController.text.trim(),
      state: _stateController.text.trim(),
      zipCode: _zipController.text.trim(),
      country: _country,
      isDefault: _isDefault,
    );
    final addressService = Provider.of<AddressService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final userId = authService.currentUser?.uid;
    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Not logged in')));
      return;
    }
    if (widget.address == null) {
      await addressService.addAddress(address, userId: userId);
    } else {
      await addressService.updateAddress(address, userId: userId);
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color cardBg = theme.brightness == Brightness.dark
        ? theme.colorScheme.surface.withOpacity(0.97)
        : const Color(0xFFF8F9FB);
    final Color autofillBg = theme.brightness == Brightness.dark
        ? theme.colorScheme.surfaceVariant.withOpacity(0.5)
        : const Color(0xFFE9F0FA);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.address == null ? 'Add Address' : 'Edit Address'),
        // Use default background/foreground (old style)
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Card(
              elevation: 12,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              color: cardBg,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          Text(
                            'Contact Details',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          prefixIcon: const Icon(Icons.phone_outlined),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 28),
                      Divider(
                        height: 1,
                        thickness: 1.2,
                        color: theme.dividerColor.withOpacity(0.12),
                      ),
                      const SizedBox(),
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          Text(
                            'Address Details',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _country,
                        decoration: InputDecoration(
                          labelText: 'Country',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          prefixIcon: const Icon(Icons.public),
                          filled: true,
                          fillColor: theme.cardColor.withOpacity(0.08),
                        ),
                        items: _countries
                            .map(
                              (c) => DropdownMenuItem(value: c, child: Text(c)),
                            )
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _country = val);
                        },
                        style: theme.textTheme.bodyLarge,
                        borderRadius: BorderRadius.circular(16),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: theme.primaryColor,
                        ),
                        dropdownColor: theme.cardColor,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _address1Controller,
                        decoration: InputDecoration(
                          labelText: 'Address Line 1',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          prefixIcon: const Icon(Icons.home_outlined),
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _address2Controller,
                        decoration: InputDecoration(
                          labelText: 'Address Line 2 (optional)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          prefixIcon: const Icon(Icons.apartment_outlined),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _zipController,
                        decoration: InputDecoration(
                          labelText: 'Pincode',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          prefixIcon: const Icon(
                            Icons.local_post_office_outlined,
                          ),
                          errorText: _pincodeError,
                          suffixIcon: _isFetchingPincode
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _cityController,
                              readOnly: true,
                              style: TextStyle(
                                color: theme.disabledColor,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                labelText: 'City',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                prefixIcon: const Icon(
                                  Icons.location_city_outlined,
                                ),
                                filled: true,
                                fillColor: autofillBg,
                              ),
                              validator: (v) =>
                                  v == null || v.isEmpty ? 'Required' : null,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: TextFormField(
                              controller: _stateController,
                              readOnly: true,
                              style: TextStyle(
                                color: theme.disabledColor,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                labelText: 'State',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                prefixIcon: const Icon(Icons.map_outlined),
                                filled: true,
                                fillColor: autofillBg,
                              ),
                              validator: (v) =>
                                  v == null || v.isEmpty ? 'Required' : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton.icon(
                          icon: Icon(
                            widget.address == null
                                ? Icons.add_location_alt
                                : Icons.save,
                            size: 22,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 4,
                            shadowColor: theme.primaryColor.withOpacity(0.18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: BorderSide(
                                color: theme.primaryColor.withOpacity(0.18),
                                width: 1.2,
                              ),
                            ),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              letterSpacing: 0.2,
                            ),
                          ),
                          onPressed: _save,
                          label: Text(
                            widget.address == null
                                ? 'Add Address'
                                : 'Save Changes',
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
