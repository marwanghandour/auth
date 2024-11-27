import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'data/sources/supabase_auth_sources.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/views/auth/sign_in_view.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imhpcmh3a3JkZ2Nucmpvc3lwZmpnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzIyNzIxNjEsImV4cCI6MjA0Nzg0ODE2MX0.6JaylnrYPcnMUB8fk8qkX_1P1QV4fSVmJSR8O4hMZL0', 
    url: 'https://hirhwkrdgcnrjosypfjg.supabase.co',
    );
    final supabaseClient = Supabase.instance.client;
     final authSource = SupabaseAuthSource(supabaseClient); 
     runApp(MyApp(authSource)); 
     } 
     class MyApp extends StatelessWidget 
     { 
      final SupabaseAuthSource authSource;
       const MyApp(this.authSource, {super.key});
        @override
         Widget build(BuildContext context) {
           return BlocProvider(
             create: (context) => AuthBloc(authSource),
              child: const MaterialApp( 
                debugShowCheckedModeBanner: false,
                home: SignInPage(),
                       ),
                        );
                         }
     }