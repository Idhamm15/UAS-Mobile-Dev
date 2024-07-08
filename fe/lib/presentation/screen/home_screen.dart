import 'package:fe/bloc/product/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe/main.dart' as main;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  @override
Widget build(BuildContext context) {
  
  return Scaffold(
    drawer: main.NavigationDrawer(),
    appBar: AppBar(
      title: const Text("Task Management"),
      centerTitle: true,
    ),
    body: BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is LoadedState) {
          if (state.products != null && state.products.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProductBloc>().add(PullToRefreshEvent());
              },

              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return Card(
                    elevation: 2,
                    shadowColor: Colors.green,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: product.id,
                          child: SizedBox(
                            width: 150,
                            child: Image.asset(
                              'assets/images/img2.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // const SizedBox(height: 2),
                        Text(
                          product.productName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Rp ${product.price.toString()}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),

                        ElevatedButton(
                          onPressed: () {
                            // Aksi yang dijalankan ketika tombol Beli ditekan
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            minimumSize: Size(150, 50),
                          ),
                          child: Text(
                            'Beli',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: state.products.length,
              ),



              );
            } else {
              return const Center(
                child: Text("No Data"),
              );
            }
          }
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FailedToLoadState) {
            return Center(child: Text(state.message));
          }
          return const Center(
            child: Text("No Data"),
          );
        },
      ),
    );
  }


}