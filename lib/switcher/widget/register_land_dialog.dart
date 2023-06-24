import 'package:flutter/material.dart';

void registerLandDialog(
  BuildContext context,
  var ownerController,
  var locationController,
  var areaController,
  var pricePerAreaController,
  var formKey,
  void Function() onRegister,
) {
  showDialog(
    context: context,
    builder: (context) {
      //form key

      return Builder(builder: (context) {
        return AlertDialog(
          title: const Text("Register Land"),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: TextFormField(
                    controller: ownerController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Owner cannot be empty";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Owner",
                      filled: true,
                      fillColor: Color.fromRGBO(234, 240, 247, 1),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: TextFormField(
                    controller: locationController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Location cannot be empty";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Location",
                      filled: true,
                      fillColor: Color.fromRGBO(234, 240, 247, 1),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: TextFormField(
                    controller: areaController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Area cannot be empty";
                      }
                      try {
                        int.parse(value);
                        return null;
                      } catch (e) {
                        return "Area must be a number";
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "Area",
                      filled: true,
                      fillColor: Color.fromRGBO(234, 240, 247, 1),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: TextFormField(
                    controller: pricePerAreaController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Price per area cannot be empty";
                      }
                      try {
                        int.parse(value);
                        return null;
                      } catch (e) {
                        return "Price per area must be a number";
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "Price per area",
                      filled: true,
                      fillColor: Color.fromRGBO(234, 240, 247, 1),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                onRegister();
                Navigator.pop(context);
                ownerController.clear();
                locationController.clear();
                areaController.clear();
                pricePerAreaController.clear();
              },
              child: const Text("Register"),
            ),
          ],
        );
      });
    },
  );
}
