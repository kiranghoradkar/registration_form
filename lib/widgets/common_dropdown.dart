import 'package:flutter/material.dart';

class CommonDropDown extends StatefulWidget {
  final List<String> dropDownList;
   String? dropdownValue;
  final String heading;
  final void Function(String) callback;
   CommonDropDown(this.dropDownList, this.heading,{Key? key, this.dropdownValue, required this.callback})
      : super(key: key);

  @override
  State<CommonDropDown> createState() => _CommonDropDownState();
}

class _CommonDropDownState extends State<CommonDropDown> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
      child: Column(
        children: [
           Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.heading,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          DropdownButtonHideUnderline(
            child: Container(
              color: const Color(0xFFEEEEEE),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator:  (value) => value == null ? 'This field required' : null,
                value: widget.dropdownValue,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  size: 28,
                ),
                elevation: 16,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600),
                onChanged: (String? newValue) {
                  setState((){
                    widget.dropdownValue = newValue;
                    widget.callback(newValue!);
                  });
                },
                items: widget.dropDownList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
