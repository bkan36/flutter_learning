/*
 * Copyright (c) 2019 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'package:flutter/material.dart';
import 'package:magiccart/data/CloudPersistence.dart';
import 'package:magiccart/screens/CartPage.dart';
import 'package:magiccart/screens/ItemDetailPage.dart';
import 'package:magiccart/screens/LoginPage.dart';
import 'package:magiccart/screens/StorePage.dart';
import 'package:provider/provider.dart';

import 'Storage.dart';
import 'data/FilePersistence.dart';
import 'data/LocalKeyValuePersistence.dart';
import 'demo/Demo.dart';
import 'models/Item.dart';
import 'models/MagicCartApp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  static var provider = MagicCartApp(Demo.store, null);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Storage>(
        future: Storage.create(
          repository: FilePersistence(),
        ),
        builder: (context, snapshot) {
          final repository = snapshot.data;
          provider = MagicCartApp(Demo.store, repository);

          return MultiProvider(
            providers: [ChangeNotifierProvider.value(value: provider)],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primaryColor: Color(0xff006837),
                  primaryColorDark: Color(0xff004012),
                  accentColor: Color(0xffc75f00)),
              home: provider.user == null ? LoginPage() : StorePage(),
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) {
                    return _makeRoute(
                        context: context,
                        routeName: settings.name,
                        arguments: settings.arguments);
                  },
                  maintainState: true,
                  fullscreenDialog: false,
                );
              },
            ),
          );
        });
  }

  Widget _makeRoute(
      {@required BuildContext context,
      @required String routeName,
      Object arguments}) {
    final Widget child = _buildRoute(
      context: context,
      routeName: routeName,
      arguments: arguments,
    );
    return child;
  }

  Widget _buildRoute({
    @required BuildContext context,
    @required String routeName,
    Object arguments,
  }) {
    switch (routeName) {
      case '/login':
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: provider,
            )
          ],
          child: LoginPage(),
        );
      case '/shop':
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: provider,
            )
          ],
          child: StorePage(),
        );
      case '/details':
        final map = arguments as Map<String, dynamic> ?? Map();
        final item = map['item'] as Item;

        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: provider,
            )
          ],
          child: ItemDetailPage(item: item),
        );
      case '/cart':
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: provider,
            )
          ],
          child: CartPage(),
        );
      default:
        return Container();
    }
  }
}
