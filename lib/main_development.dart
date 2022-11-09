// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/app/app.dart';
import 'package:todo/bootstrap.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await  Firebase.initializeApp();
   bootstrap(() => const App());
}
