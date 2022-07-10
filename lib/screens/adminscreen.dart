import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saranfarms/providers/mainprovider.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 4);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hgt = MediaQuery.of(context).size.height;
    final wdth = MediaQuery.of(context).size.width;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String name = 'name',
        //content = 'content',
        imageurl = 'https://bit.ly/3NduB8J',
        description = 'description';
    double price = 0;

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Welcome Admin',
            style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
          ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop()),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                icon: Icon(FontAwesomeIcons.cartPlus),
                text: 'Marts and Retailors',
              ),
              Tab(
                icon: Icon(Icons.agriculture),
                text: 'Farmers and Producers',
              ),
              Tab(
                icon: Icon(Icons.import_export),
                text: 'Exporters and wholesellers',
              ),
              Tab(
                icon: Icon(Icons.factory),
                text: 'Manufacturers and Factories',
              ),
            ],
          )),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton.icon(
                  icon: const Icon(FontAwesomeIcons.plus),
                  label: Text(
                    _tabController.index == 0
                        ? 'Why add a product'
                        : 'Add a Product',
                    style: GoogleFonts.lato(fontSize: 20, color: Colors.black),
                  ),
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text('Enter The details of the  product'),
                        content: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                onChanged: (value) => name = value,
                                decoration: const InputDecoration(
                                  hintText: 'Name or title*',
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: hgt * 0.03,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Description*',
                                ),
                                onChanged: (value) => description = value,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: hgt * 0.03,
                              ),
                              TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9.,]+')),
                                ],
                                decoration: const InputDecoration(
                                  hintText: 'Price in INR*',
                                ),
                                onChanged: (value) {
                                  double prc = double.tryParse(value) ?? 0;
                                  price = prc;
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter valid number';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: hgt * 0.03,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Product image link*',
                                ),
                                onChanged: (value) => imageurl = value,
                                validator: (String? value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      !value.contains('.')) {
                                    return 'Please enter a valid link';
                                  } else {
                                    imageurl = value;
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.reset();
                                Navigator.pop(context, 'OK');
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          backgroundColor: Colors.white,
                                          title: const Text('Varify you Image'),
                                          content: Stack(
                                            children: [
                                              const CircularProgressIndicator(),
                                              Image.network(imageurl),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Provider.of<MainProvider>(
                                                        context,
                                                        listen: false)
                                                    .adddata(
                                                        name,
                                                        description,
                                                        price,
                                                        imageurl,
                                                        'retailprice');
                                                Navigator.pop(context, 'OK');
                                              },
                                              child: const Icon(
                                                  Icons.done_outlined),
                                            )
                                          ],
                                        ));
                              }
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          const Center(),
          const Center(),
          const Center()
        ],
      ),
    );
  }
}
