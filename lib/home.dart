import 'package:flutter/material.dart';
import 'package:myapp/service.dart';
import 'package:myapp/user.dart';

// Sesuaikan dengan path UserModel Anda

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppwriteService _appwriteService = AppwriteService();
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    try {
      UserModel? user = await _appwriteService.getCurrentUser();
      setState(() {
        _user = user;
      });
    } catch (e) {
      print('Error fetching user: $e');
      // Tangani error sesuai kebutuhan, misalnya tampilkan Snackbar
    }
  }

  Future<void> _logout() async {
    await _appwriteService.logout(context);
    // Ganti dengan rute login Anda
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[800]!, Colors.blue[900]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _user == null
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Gambar di sebelah kiri
                            const CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                'https://cdn-icons-png.flaticon.com/512/6858/6858504.png',
                              ),
                            ),
                            const SizedBox(
                                width: 20.0), // Jarak antara gambar dan teks
                            // Teks di sebelah kanan
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome, ${_user!.name}!',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.blue[900],
                                    ),
                                  ),
                                  Text(
                                    'Email: ${_user!.email}',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
