import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> filters;

  const FiltersScreen(this.saveFilters, this.filters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _glutenFree = widget.filters['gluten'] ?? false;
    _lactoseFree = widget.filters['lactose'] ?? false;
    _vegan = widget.filters['vegan'] ?? false;
    _vegetarian = widget.filters['vegetarian'] ?? false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your filters'),
        actions: [
          IconButton(
            onPressed: () => widget.saveFilters({
              'gluten': _glutenFree,
              'lactose': _lactoseFree,
              'vegan': _vegan,
              'vegetarian': _vegetarian,
            }),
            icon: Icon(Icons.save),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                'Gluten-free',
                "Only includes gluten-free meals",
                _glutenFree,
                (val) => _glutenFree = val,
              ),
              _buildSwitchListTile(
                'Lactose-free',
                "Only includes lactose-free meals",
                _lactoseFree,
                (val) => _lactoseFree = val,
              ),
              _buildSwitchListTile(
                'Vegetarian',
                "Only includes vegetarian meals",
                _vegetarian,
                (val) => _vegetarian = val,
              ),
              _buildSwitchListTile(
                'Vegan',
                "Only includes vegan meals",
                _vegan,
                (val) => _vegan = val,
              ),
            ],
          ))
        ],
      ),
    );
  }

  SwitchListTile _buildSwitchListTile(
      String title, String subtitle, bool value, Function onChanged) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      activeColor: Theme.of(context).colorScheme.secondary,
      value: value,
      onChanged: (newValue) => setState(() => onChanged(newValue)),
    );
  }
}
