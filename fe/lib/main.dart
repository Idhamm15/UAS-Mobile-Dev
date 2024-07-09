import 'package:fe/bloc/task/bloc/task_bloc.dart';
import 'package:fe/data/model/task.dart';
import 'package:fe/data/repository/task_repository.dart';
import 'package:fe/data/service/task_service.dart';
import 'package:fe/presentation/screen/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe/bloc/login/bloc/login_bloc.dart';
import 'package:fe/bloc/product/bloc/product_bloc.dart';
import 'package:fe/bloc/register/bloc/register_bloc.dart';
import 'package:fe/bloc/users/bloc/users_bloc.dart';
import 'package:fe/data/repository/repositories.dart';
import 'package:fe/data/service/data_repository.dart';
import 'package:fe/data/repository/api_repository.dart';
import 'package:fe/presentation/screen/login_screen.dart';
import 'package:fe/presentation/screen/register_screen.dart';
import 'package:fe/presentation/screen/splash_screen.dart';
import 'package:fe/presentation/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => UserRepository()),
        RepositoryProvider(
            create: (context) => ApiRepository(dataService: DataService())),
        RepositoryProvider(create: (context) => TaskService()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => UserBloc(
              RepositoryProvider.of<UserRepository>(context),
            ),
          ),
          BlocProvider(
            create: (BuildContext context) => LoginBloc(
              RepositoryProvider.of<UserRepository>(context),
            ),
          ),
          BlocProvider(
            create: (BuildContext context) => ProductBloc(
              apiRepository: RepositoryProvider.of<ApiRepository>(context),
            )..add(LoadProductEvent()),
          ),
          BlocProvider(
            create: (BuildContext context) => RegisterBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
            ),
          ),
          BlocProvider<TaskBloc>(
            create: (BuildContext context) => TaskBloc(
              taskRepository: RepositoryProvider.of<TaskRepository>(context),
            )..add(LoadTaskEvent()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Task Management Apps',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
          onGenerateRoute: (settings) {
            if (settings.name == '/edit_task') {
              final Task task = settings.arguments as Task;
              return MaterialPageRoute(
                builder: (context) => EditTaskScreen(task: task),
              );
            }

            if (settings.name == '/add_task') {
              return MaterialPageRoute(
                builder: (context) => AddTaskScreen(),
              );
            }

            // Add other routes here as needed
            return null; // Return null if the route is not handled
          },
          routes: {
            '/login': (context) => const LoginScreen(),
            '/register': (context) => RegisterScreen(),
            '/home': (context) => HomeScreen(),
            '/task': (context) => TaskScreen(),
          },
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );
}

Widget buildHeader(BuildContext context) => Material(
      color: Colors.blue.shade700,
      child: InkWell(
        onTap: () {
          // Close Navigation drawer before
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.blue.shade700,
          padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
          child: const Column(
            children: [
              CircleAvatar(
                radius: 52,
                backgroundImage: AssetImage("images/profile.jpeg"),
              ),
              SizedBox(height: 12),
              Text(
                'Idham',
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
              Text(
                'idhamtamvanz123@gmail.com',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );

Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // onTap: () =>
            // Navigator.of(context).pushReplacement(MaterialPageRoute(
            //   builder: (context) => const HomePage(),
            // )),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag_outlined),
            title: const Text('My Task'),
            onTap: () =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => TaskScreen(),
            )),
          ),
          const Divider(color: Colors.black),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () {
              // close navigation drawer before
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Notification'),
            onTap: () {
              // close navigation drawer before
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Logout'),
            // onTap: () =>
            // Navigator.of(context).pushReplacement(MaterialPageRoute(
            //   builder: (context) => const LoginScreen(),
            // )),
          ),
        ],
      ),
    );
