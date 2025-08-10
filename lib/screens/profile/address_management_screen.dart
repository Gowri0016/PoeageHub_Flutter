import 'package:flutter/material.dart';
import 'package:primepick/services/auth_service.dart';
import 'package:provider/provider.dart';
import '../../services/address_service.dart';
import 'address_form_screen.dart';

class AddressManagementScreen extends StatelessWidget {
  const AddressManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressService = Provider.of<AddressService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    final userId = authService.currentUser?.uid;
    if (userId == null) {
      return const Scaffold(body: Center(child: Text('Not logged in')));
    }
    // Load addresses for this user when screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addressService.loadAddresses(userId);
    });
    // Always show default address first
    final addresses = [
      ...addressService.addresses.where((a) => a.isDefault),
      ...addressService.addresses.where((a) => !a.isDefault),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Addresses'),
        centerTitle: true,
        elevation: 0,
      ),
      body: addresses.isEmpty
          ? const Center(
              child: Text(
                'No addresses added yet.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
              itemCount: addresses.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final address = addresses[index];
                return Material(
                  color: Colors.transparent,
                  child: Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        address.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context).colorScheme.primary,
                                              fontSize: 18,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (address.isDefault)
                                      Padding(
                                        padding: const EdgeInsets.only(right: 4.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(0.13),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(Icons.check_circle, color: Colors.green, size: 16),
                                              SizedBox(width: 4),
                                              Text('Default', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              PopupMenuButton<String>(
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.black54,
                                ),
                                elevation: 8,
                                offset: const Offset(-20, 36),
                                constraints: const BoxConstraints(
                                  minWidth: 160,
                                  maxWidth: 220,
                                  maxHeight: 180,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                onSelected: (value) async {
                                  if (value == 'edit') {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddressFormScreen(address: address),
                                      ),
                                    );
                                    if (result != null && result is Address) {
                                      addressService.updateAddress(
                                        result,
                                        userId: userId,
                                      );
                                    }
                                  } else if (value == 'delete') {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text('Delete Address'),
                                        content: const Text(
                                          'Are you sure you want to delete this address?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(ctx, false),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(ctx, true),
                                            child: const Text(
                                              'Delete',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (confirm == true) {
                                      addressService.removeAddress(
                                        address.id,
                                        userId: userId,
                                      );
                                    }
                                  } else if (value == 'default') {
                                    await addressService.selectDefault(
                                      address.id,
                                      userId: userId,
                                    );
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'edit',
                                    height: 36,
                                    child: ListTile(
                                      dense: true,
                                      minLeadingWidth: 0,
                                      leading: Icon(
                                        Icons.edit,
                                        color: Colors.blueAccent,
                                        size: 20,
                                      ),
                                      title: Text(
                                        'Edit',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    height: 36,
                                    child: ListTile(
                                      dense: true,
                                      minLeadingWidth: 0,
                                      leading: Icon(
                                        Icons.delete_outline,
                                        color: Colors.redAccent,
                                        size: 20,
                                      ),
                                      title: Text(
                                        'Delete',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  if (!address.isDefault)
                                    const PopupMenuItem(
                                      value: 'default',
                                      height: 36,
                                      child: ListTile(
                                        dense: true,
                                        minLeadingWidth: 0,
                                        leading: Icon(
                                          Icons.check_circle_outline,
                                          color: Colors.green,
                                          size: 20,
                                        ),
                                        title: Text(
                                          'Set as Default',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${address.addressLine1}${address.addressLine2.isNotEmpty ? ", " + address.addressLine2 : ""}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${address.city}, ${address.state} - ${address.zipCode}',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Phone: ${address.phone}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddressFormScreen()),
          );
          if (result != null && result is Address) {
            addressService.addAddress(result, userId: userId);
          }
        },
        child: const Icon(Icons.add),
        tooltip: 'Add Address',
      ),
    );
  }
}
