import 'package:flutter/material.dart';

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

          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => const UserPage(),
          // ));
        },
        child: Container(
          color: Colors.blue.shade700,
          padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
          child: const Column(
            children: [
              CircleAvatar(
                radius: 52,
                backgroundImage: NetworkImage(
                    "https://media.licdn.com/dms/image/D5603AQF6DiSoELIvUw/profile-displayphoto-shrink_800_800/0/1682754123265?e=1719446400&v=beta&t=f8YWFSDw94rRuUAUg_iLhlHZduxvJXMcMexTpYN2104"),
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
            title: const Text('Product'),
            onTap: () {
              // close navigation drawer before
              Navigator.pop(context);

              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => const StudentPage(),
              // ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.category_outlined),
            title: const Text('Category'),
            onTap: () {
              // close navigation drawer before
              Navigator.pop(context);

              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => const ClassPage(),
              // ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.production_quantity_limits_outlined),
            title: const Text('Cart'),
            onTap: () {
              // close navigation drawer before
              Navigator.pop(context);

              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => const FavouritesPage(),
              // ));
            },
          ),
          const Divider(color: Colors.black),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () {
                 // close navigation drawer before
              Navigator.pop(context);

              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => const SettingsPage(),
              // ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Notification'),
            onTap: () {
              // close navigation drawer before
              Navigator.pop(context);

              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => const NotificationPage(),
              // ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
