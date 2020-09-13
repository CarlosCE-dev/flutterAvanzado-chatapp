import 'package:chat_app/src/services/chat_service.dart';
import 'package:flutter/material.dart';

// Lib
import 'package:provider/provider.dart';

// Services
import 'package:chat_app/src/services/auth_service.dart';
import 'package:chat_app/src/services/socket_service.dart';
 
// Routes
import 'package:chat_app/src/routes/routes.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (_) => AuthService() ),
        ChangeNotifierProvider( create: (_) => SocketService() ),
        ChangeNotifierProvider( create: (_) => ChatService() )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}