import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:masak_apa_hari_ini/model/category.dart';

class Kategori extends StatefulWidget {
  const Kategori({Key? key}) : super(key: key);

  @override
  _KategoriState createState() => _KategoriState();
}

class _KategoriState extends State<Kategori> {
  bool _isErrorButtonReloading = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategories(Client()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasError) {
          _isErrorButtonReloading = false;

          return Column(
            children: <Widget>[
              Text('Terjadi kesalahan saat mengambil categori resep.'),
              SizedBox(height: 8.0),
              MaterialButton(
                child: _isErrorButtonReloading
                    ? Text('Memuat ulang...')
                    : Text('Muat ulang'),
                color: Colors.blue,
                disabledColor: Colors.grey,
                textColor: Colors.white,
                onPressed: _isErrorButtonReloading
                    ? null
                    : () {
                        _isErrorButtonReloading = true;
                        setState(() {});
                      },
              )
            ],
          );
        }

        return snapshot.hasData
            ? CategoryListBuilder(category: snapshot.data)
            : Text('Tidak ada kategori resep yang dapat ditampilkan.');
      },
    );
  }
}

class CategoryListBuilder extends StatelessWidget {
  const CategoryListBuilder({Key? key, required this.category})
      : super(key: key);
  final List<Category> category;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: category.length,
      physics: BouncingScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 0,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          key: Key(category[index].key),
          title: Text(category[index].category),
          onTap: () {
            // TODO: Buat redirection ke list category
            print(category[index].url);
          },
        );
      },
    );
  }
}
