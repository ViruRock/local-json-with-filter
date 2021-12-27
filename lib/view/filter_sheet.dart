import 'package:flutter/material.dart';
import 'package:localjsonwithfilter/viewModel/training_list_vm.dart';
import 'package:localjsonwithfilter/utils/ui_helper.dart';
import 'package:provider/provider.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({Key? key}) : super(key: key);

  @override
  _FilterSheetState createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  String filterType = "name";
  String searchValue = "";

  @override
  Widget build(BuildContext context) {
    final trainingListVM = Provider.of<TrainingListVM>(context, listen: false);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: showText(
                    message: 'Sort and Filters',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              showIconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    trainingListVM.filterData();
                  },
                  icon: Icons.close),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: showText(
                    message: 'Sort by',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(width: 12.0),
            SizedBox(
              width: (MediaQuery.of(context).size.width / 2) - 16,
              child: showSearchBar(
                  context: context,
                  hintText: 'Search',
                  onChanged: (String value) {
                    searchValue = value;
                    setState(() {
                      trainingListVM.searchData(
                          filterType: filterType, search: searchValue);
                    });
                  }),
            )
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    color: filterType == 'name' || filterType.isEmpty
                        ? Colors.white
                        : Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: showClickableText(
                          message: 'Name',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w900,
                          onTap: () {
                            filterType = "name";
                            trainingListVM.searchData(
                                filterType: filterType, search: searchValue);

                            setState(() {
                              showFilterList(
                                  filterType: filterType,
                                  trainingListVM: trainingListVM);
                            });
                          }),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    color: filterType == 'location'
                        ? Colors.white
                        : Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: showClickableText(
                          message: 'Location',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w900,
                          onTap: () {
                            filterType = "location";
                            trainingListVM.searchData(
                                filterType: filterType, search: searchValue);

                            setState(() {
                              showFilterList(
                                  filterType: filterType,
                                  trainingListVM: trainingListVM);
                            });
                          }),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    color: filterType == 'speakerName'
                        ? Colors.white
                        : Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: showClickableText(
                          message: 'Speaker Name',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w900,
                          onTap: () {
                            filterType = "speakerName";
                            trainingListVM.searchData(
                                filterType: filterType, search: searchValue);

                            setState(() {
                              showFilterList(
                                  filterType: filterType,
                                  trainingListVM: trainingListVM);
                            });
                          }),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    color: filterType == 'speakerLanguage'
                        ? Colors.white
                        : Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: showClickableText(
                          message: 'Speaker Language',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w900,
                          onTap: () {
                            filterType = "speakerLanguage";
                            trainingListVM.searchData(
                                filterType: filterType, search: searchValue);

                            setState(() {
                              showFilterList(
                                  filterType: filterType,
                                  trainingListVM: trainingListVM);
                            });
                          }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            SizedBox(
              width: (MediaQuery.of(context).size.width / 2) - 16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showFilterList(
                      filterType: filterType, trainingListVM: trainingListVM),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  showFilterList({
    required String? filterType,
    required TrainingListVM trainingListVM,
  }) {
    List<String>? data;
    if (filterType == 'location') {
      data = trainingListVM.searchLocation;
    } else if (filterType == 'speakerName') {
      data = trainingListVM.searchSpeakerName;
    } else if (filterType == 'speakerLanguage') {
      data = trainingListVM.searchSpeakerLanguage;
    } else {
      data = trainingListVM.searchName;
    }

    return data.isEmpty
        ? const Text('No data available')
        : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (ctx, index) {
              return CheckboxListTile(
                  title: showText(message: data![index]),
                  value: checkDataSelected(
                      filterType: filterType.toString(),
                      data: data[index],
                      trainingListVM: trainingListVM),
                  onChanged: (value) {
                    setState(() {
                      if (filterType == 'location') {
                        if (trainingListVM.filterLocation
                            .contains(data![index])) {
                          trainingListVM.filterLocation.remove(data[index]);
                        } else {
                          trainingListVM.filterLocation.add(data[index]);
                        }
                      } else if (filterType == 'speakerName') {
                        if (trainingListVM.filterSpeakerName
                            .contains(data![index])) {
                          trainingListVM.filterSpeakerName.remove(data[index]);
                        } else {
                          trainingListVM.filterSpeakerName.add(data[index]);
                        }
                      } else if (filterType == 'speakerLanguage') {
                        if (trainingListVM.filterSpeakerLanguage
                            .contains(data![index])) {
                          trainingListVM.filterSpeakerLanguage
                              .remove(data[index]);
                        } else {
                          trainingListVM.filterSpeakerLanguage.add(data[index]);
                        }
                      } else {
                        if (trainingListVM.filterName.contains(data![index])) {
                          trainingListVM.filterName.remove(data[index]);
                        } else {
                          trainingListVM.filterName.add(data[index]);
                        }
                      }

                      trainingListVM.filterData();
                    });
                  });
            });
  }

  bool checkDataSelected({
    required String filterType,
    required String data,
    required TrainingListVM trainingListVM,
  }) {
    bool result = false;

    if (filterType == 'location') {
      if (trainingListVM.filterLocation.contains(data)) {
        result = true;
      }
    } else if (filterType == 'speakerName') {
      if (trainingListVM.filterSpeakerName.contains(data)) {
        result = true;
      }
    } else if (filterType == 'speakerLanguage') {
      if (trainingListVM.filterSpeakerLanguage.contains(data)) {
        result = true;
      }
    } else {
      if (trainingListVM.filterName.contains(data)) {
        result = true;
      }
    }

    return result;
  }
}
