import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    Key? key,
    required this.onChanged,
    required this.onSubmitted,
  }) : super(key: key);
  final Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  var _searchMode = false;

  void _searchModeToggle() {
    _searchMode = !_searchMode;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_searchMode) {
      return TextField(
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withAlpha(150),
          border: const OutlineInputBorder(),
          labelText: 'Search',
          suffix: _SearchIconButton(
            icon: const Icon(Icons.cancel),
            onPressed: _searchModeToggle,
          ),
        ),

      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _SearchIconButton(
        icon: const Icon(Icons.search,size: 35,),
        onPressed: _searchModeToggle,
      ),
    );
  }
}

class _SearchIconButton extends StatelessWidget {
  const _SearchIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);
  final Widget icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: icon,
    );
  }
}
