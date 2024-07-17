import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../Model/Filter.dart';
import 'FilterMenuViewModel.dart';

class FilterMenuView extends StatefulWidget {
  final FilterMenuViewModel viewModel;

  FilterMenuView({required this.viewModel});

  @override
  _FilterMenuViewState createState() => _FilterMenuViewState();
}

class _FilterMenuViewState extends State<FilterMenuView> {
  late FilterMenuViewModel viewModel;

  String selectedStatus = '';
  String selectedGender = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController speciesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
  }

  void vmFilterUpdate(){
    viewModel.updateFilter(Filter(
      name: nameController.text,
      status: selectedStatus,
      species: speciesController.text,
      gender: selectedGender,
    ));
    viewModel.onFilterChanged;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: widget.viewModel,
        child: Consumer<FilterMenuViewModel>(
            builder: (context, viewModel, child) {
              double screenWidth = MediaQuery.of(context).size.width;

              return viewModel.isFilterMenuOpen
                  ? Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Filter By",
                          style: TextStyle(
                            color: CupertinoColors.systemBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: CupertinoTextField(
                            controller: nameController,
                            placeholder: "Name",
                            onChanged: (String value) {
                              viewModel.filter.name = value;
                              vmFilterUpdate();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CupertinoSlidingSegmentedControl<String>(
                            backgroundColor: Color(0xFFC0DCFF),
                            thumbColor: CupertinoColors.white,
                            children: const <String, Widget>{
                              '': Text(
                                'All',
                                style: TextStyle(color: CupertinoColors.systemBlue, fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                              'Dead': Text(
                                'Dead',
                                style: TextStyle(color: CupertinoColors.systemBlue, fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                              'Alive': Text(
                                'Alive',
                                style: TextStyle(color: CupertinoColors.systemBlue, fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                              'unknown': Text(
                                'unknown',
                                style: TextStyle(color: CupertinoColors.systemBlue, fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            },
                            onValueChanged: (String? value) {
                              setState(() {
                                selectedStatus = value ?? 'All';
                                viewModel.filter.status = value ?? 'All';
                                vmFilterUpdate();
                              });
                            },
                            groupValue: selectedStatus,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: CupertinoTextField(
                            controller: speciesController,
                            placeholder: "Species",
                            onChanged: (String value) {
                              viewModel.filter.species = value;
                              vmFilterUpdate();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CupertinoSlidingSegmentedControl<String>(
                            backgroundColor: Color(0xFFC0DCFF),
                            thumbColor: CupertinoColors.white,
                            children: const <String, Widget>{
                              '': Text(
                                'All',
                                style: TextStyle(color: CupertinoColors.systemBlue, fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                              'Male': Text(
                                'Male',
                                style: TextStyle(color: CupertinoColors.systemBlue, fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                              'Female': Text(
                                'Female',
                                style: TextStyle(color: CupertinoColors.systemBlue, fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                              'Genderless': Text(
                                'Genderless',
                                style: TextStyle(color: CupertinoColors.systemBlue, fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                              'unknown': Text(
                                'unknown',
                                style: TextStyle(color: CupertinoColors.systemBlue, fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            },
                            onValueChanged: (String? value) {
                              setState(() {
                                selectedGender = value ?? 'All';
                                viewModel.filter.gender = value ?? 'All';
                                print(viewModel.filter.gender);
                                vmFilterUpdate();
                              });
                            },
                            groupValue: selectedGender,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (viewModel.filter.name.isNotEmpty)
                    buildFilterButton(viewModel.filter.name, () {
                      setState(() {
                        nameController.text = "";
                        viewModel.filter.name = "";
                        vmFilterUpdate();
                      });
                    }),
                  if (viewModel.filter.status.isNotEmpty)
                    buildFilterButton(viewModel.filter.status, () {
                      setState(() {
                        selectedStatus = '';
                        viewModel.filter.status = "";
                        vmFilterUpdate();
                      });
                    }),
                  if (viewModel.filter.species.isNotEmpty)
                    buildFilterButton(viewModel.filter.species, () {
                      setState(() {
                        speciesController.text = "";
                        viewModel.filter.species = "";
                        vmFilterUpdate();
                      });
                    }),
                  if (viewModel.filter.gender.isNotEmpty)
                    buildFilterButton(viewModel.filter.gender, () {
                      setState(() {
                        selectedGender = '';
                        viewModel.filter.gender = "";
                        vmFilterUpdate();
                      });
                    }),
                ],
              );
            }));
  }

  Widget buildFilterButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4, top: 8, bottom: 4),
      child: Container(
        height: 36,
        width: 90,
        decoration: BoxDecoration(
          color: CupertinoColors.systemBlue,
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: CupertinoButton(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
          borderRadius: BorderRadius.circular(10.0),
          onPressed: onPressed,
          child: Row(
            children: [

              Icon(
                  CupertinoIcons.xmark_circle,
                  color: CupertinoColors.white,
                  size: 18,
                ),
              SizedBox(width: 2),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(color: CupertinoColors.white, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
