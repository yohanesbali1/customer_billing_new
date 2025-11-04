import 'dart:convert';
import 'dart:io';

import 'package:vigo_customer_billing/app/data/models/models.dart';
import 'package:vigo_customer_billing/app/data/services/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

part 'auth_provider.dart';
part 'account_bill_provider.dart';
part 'invoice_provider.dart';
part 'bank_provider.dart';
part 'helper_provider.dart';
part 'map_provider.dart';
