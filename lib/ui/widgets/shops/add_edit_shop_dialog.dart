import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prodel_admin/blocs/shop/shop_bloc.dart';
import 'package:prodel_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:prodel_admin/ui/widgets/service_area_selector.dart';
import 'package:prodel_admin/values/colors.dart';

import '../custom_button.dart';

class AddEditShopDialog extends StatefulWidget {
  final Map<String, dynamic>? shopDetails;
  const AddEditShopDialog({
    super.key,
    this.shopDetails,
  });

  @override
  State<AddEditShopDialog> createState() => _AddEditShopDialogState();
}

class _AddEditShopDialogState extends State<AddEditShopDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  int? serviceAreaId;
  bool isObscure = true;

  @override
  void initState() {
    if (widget.shopDetails != null) {
      _nameController.text = widget.shopDetails!['name'];
      _addressController.text = widget.shopDetails!['address_line'];
      _pinController.text = widget.shopDetails!['pin'];
      _cityController.text = widget.shopDetails!['city'];
      _placeController.text = widget.shopDetails!['place'];
      serviceAreaId = widget.shopDetails!['service_area_id'];
      _emailController.text = widget.shopDetails!['email'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          width: 1,
          color: Colors.black26,
        ),
      ),
      child: SizedBox(
        width: 700,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.shopDetails != null
                                ? "Edit Shop"
                                : "Add Shop",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.shopDetails != null
                                ? "Change the following details and save to apply them"
                                : "Enter the following details to add a shop.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.black,
                                ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Shop Name',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if ((value != null && value.trim().isNotEmpty) ||
                        widget.shopDetails != null) {
                      return null;
                    } else {
                      return 'Please enter your shop name';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'eg.Some name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Address',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _addressController,
                  maxLines: 2,
                  validator: (value) {
                    if ((value != null && value.trim().isNotEmpty) ||
                        widget.shopDetails != null) {
                      return null;
                    } else {
                      return 'Please enter your address';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'eg.Address line 1, address line 2',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Text(
                  'Email',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if ((value != null && value.trim().isNotEmpty) ||
                        widget.shopDetails != null) {
                      return null;
                    } else {
                      return 'Please enter your email';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'eg.shop@prodel.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Password',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        isObscure = !isObscure;
                        setState(() {});
                      },
                      icon: Icon(
                        isObscure ? Icons.visibility_off : Icons.visibility,
                        color: primaryColor,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Place',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _placeController,
                            validator: (value) {
                              if (value != null && value.trim().isNotEmpty) {
                                return null;
                              } else {
                                return 'Please enter place';
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'eg. Some place',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'City',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _cityController,
                            validator: (value) {
                              if ((value != null && value.trim().isNotEmpty) ||
                                  widget.shopDetails != null) {
                                return null;
                              } else {
                                return 'Please enter your city';
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'eg.Some city',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pin',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _pinController,
                            validator: (value) {
                              if (value != null && value.trim().isNotEmpty) {
                                return null;
                              } else {
                                return 'Please enter pin';
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'eg.123456',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Service Area',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          ServiceAreaSelector(
                            onSelect: (id) {
                              serviceAreaId = id;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  label: widget.shopDetails != null ? 'Save' : 'Add',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (serviceAreaId != null) {
                        if (widget.shopDetails != null) {
                          BlocProvider.of<ShopBloc>(context).add(
                            EditShopEvent(
                              userId: widget.shopDetails!['user_id'],
                              name: _nameController.text.trim(),
                              address: _addressController.text.trim(),
                              city: _cityController.text.trim(),
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                              pin: int.parse(
                                  _pinController.text.trim().toString()),
                              place: _placeController.text.trim(),
                              serviceAreaId: serviceAreaId!,
                            ),
                          );
                        } else {
                          BlocProvider.of<ShopBloc>(context).add(
                            AddShopEvent(
                              name: _nameController.text.trim(),
                              address: _addressController.text.trim(),
                              city: _cityController.text.trim(),
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                              pin: int.parse(
                                  _pinController.text.trim().toString()),
                              place: _placeController.text.trim(),
                              serviceAreaId: serviceAreaId!,
                            ),
                          );
                        }

                        Navigator.pop(context);
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => const CustomAlertDialog(
                            title: 'Required!',
                            message:
                                'Service Area is required, please select a Service Area',
                            primaryButtonLabel: 'Ok',
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
