import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final Function(String)? onChange;
  const SearchField({Key? key, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
        onChanged: onChange,
        decoration: const InputDecoration(
          icon: Icon(Icons.search),
          labelText: 'Search',
          enabledBorder: UnderlineInputBorder(),
        ),
      );
}
