import 'package:flutter/material.dart';
import 'package:game_lists/model/company.dart';
import 'package:game_lists/pages/add_edit_pages/company_page.dart';
import 'package:hive/hive.dart';

class SelectCompanyPage extends StatefulWidget {
  static const routeName = '/selectCompany';

  @override
  _SelectCompanyPageState createState() => _SelectCompanyPageState();
}

class _SelectCompanyPageState extends State<SelectCompanyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {},
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text('Select Company'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Company',
            onPressed: () async {
              await Navigator.pushNamed(context, CompanyPage.routeName)
                  .then((value) => setState(() {}));
            },
          ),
        ],
      ),
      body: FutureBuilder<Box<Company>>(
        future: Hive.openBox<Company>('company'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var companies = snapshot.data!.values.toList()
              ..sort((a, b) {
                return a.name.toLowerCase().compareTo(b.name.toLowerCase());
              });
            return ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: companies.length,
              itemBuilder: (context, index) {
                var company = companies.elementAt(index);
                return CompanyCard(
                  company: company,
                  onEditPressed: () async {
                    await Navigator.pushNamed(context, CompanyPage.routeName,
                        arguments: company);
                    setState(() {});
                  },
                  onLongPress: () {},
                );
              },
            );
          }
          return Center(child: Text('Please Wait!'));
        },
      ),
    );
  }
}

class CompanyCard extends StatelessWidget {
  const CompanyCard(
      {Key? key, required this.company, this.onEditPressed, this.onLongPress})
      : super(key: key);

  final Company company;
  final VoidCallback? onEditPressed;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      onLongPress: onLongPress,
      child: ListTile(
        leading: Icon(Icons.flag),
        title: Text(company.name),
        subtitle: Text(company.country),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: onEditPressed,
        ),
      ),
    ));
  }
}
