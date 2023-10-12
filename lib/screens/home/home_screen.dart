import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wire_viewer/constants/app_constants.dart';
import 'package:wire_viewer/form_event/form_submission_status.dart';
import 'package:wire_viewer/models/Item.dart';
import 'package:wire_viewer/screens/home/bloC/home_bloc.dart';
import 'package:wire_viewer/screens/home/bloC/home_event.dart';
import 'package:wire_viewer/screens/home/bloC/home_state.dart';
import 'package:wire_viewer/screens/item_details/ItemDetails.dart';
import 'package:wire_viewer/screens/item_listing/ItemListing.dart';
import 'package:wire_viewer/utils/loader_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = new TextEditingController();
  static const int mobileMaxWidth = 600;
  List<Item> search_items = [];

  Item? _selectedItem = null;

  Widget _buildMobileLayout() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(Icons.search),
            title: TextField(
              controller: controller,
              decoration:
                  InputDecoration(hintText: 'Search', border: InputBorder.none),
              onChanged: onSearchTextChanged,
            ),
          ),
        ),
        Expanded(
          child: ItemListing(
            list_items: search_items.length > 0 ? search_items : items,
            selectedItem: _selectedItem,
            itemSelectedCallback: (item) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ItemDetails(
                      isInTabletLayout: false,
                      item: item,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  onSearchTextChanged(String text) async {
    search_items.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    items.forEach((userDetail) {
      if (userDetail.title.toLowerCase().contains(text.toLowerCase()))
        search_items.add(userDetail);
    });

    setState(() {});
  }

  Widget _buildTabletLayout() {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Material(
            elevation: 4.0,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.search),
                    title: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: 'Search', border: InputBorder.none),
                      onChanged: onSearchTextChanged,
                    ),
                  ),
                ),
                Expanded(
                  child: ItemListing(
                    list_items: search_items.length > 0 ? search_items : items,
                    itemSelectedCallback: (item) {
                      setState(() {
                        _selectedItem = item;
                      });
                    },
                    selectedItem: _selectedItem,
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: ItemDetails(
            isInTabletLayout: true,
            item: _selectedItem,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Wire Viewer"),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc()..add(LoadData()),
        child: BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) =>
              previous.formStatus != current.formStatus,
          listener: (context, state) {
            final formStatus = state.formStatus;
            print(formStatus);
            if (formStatus is SubmissionFailed) {
              closeLoadingDialog(context);
              AppConstants.showAlertDialog(
                  context, "Error", formStatus.errorMessage.toString());
            } else if (formStatus is SubmissionSuccess) {
              closeLoadingDialog(context);
            } else if (formStatus is FormSubmitting) {
              showLoadingDialog(context);
            }
          },
          child: SafeArea(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return (shortestSide < mobileMaxWidth)
                    ? _buildMobileLayout()
                    : _buildTabletLayout();
              },
            ),
          ),
        ),
      ),
    );
  }
}
