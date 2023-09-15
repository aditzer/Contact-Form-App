import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../view/widgets/custom_snackbar.dart';

// Loading Indicator
const customLoadingIndicator = SpinKitPouringHourGlassRefined(color: Colors.white, size: 70);

// SnackBars
SnackBar invalidNameSnackBar = customSnackBar("Name can not be empty!");

SnackBar invalidEmailSnackBar = customSnackBar("Invalid Email!");

SnackBar invalidPhoneSnackBar = customSnackBar("Phone number can not be empty!");

SnackBar invalidAddressSnackBar = customSnackBar("Address can not be empty!");