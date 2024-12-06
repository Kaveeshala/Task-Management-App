import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/view_models/app_view_model.dart';

//import '../../models/task_model.dart';

class SettingBottomSheetView extends StatelessWidget {
  const SettingBottomSheetView({super.key});

  
  @override
  Widget build(BuildContext context) {
    final TextEditingController entryController = TextEditingController();
  

    return Consumer<AppViewModel>(builder:(context, viewModel, child){
      return Padding(
        padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 80,
          child:  Center(
            child: SizedBox(
              height: 40,
              width: 250,
              child: TextField(
                onSubmitted: (value){
                  if(entryController.text.isNotEmpty){
                     viewModel.updateUsername(entryController.text);
                  }
                  Navigator.of(context).pop();
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: viewModel.clrLvl2,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      width: 0, style: BorderStyle.none
                    )
                  )),
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                cursorColor: viewModel.clrLvl4,
                autofocus: true,
                autocorrect: true,
                controller: entryController,
                style: TextStyle(
                  color: viewModel.clrLvl4, fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
          ),
      );
    });
  }
}