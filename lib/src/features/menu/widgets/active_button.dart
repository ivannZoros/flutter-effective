import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class ActiveButton extends StatefulWidget {
  final Function() onRemove;
  final Function(int) plusCup;
  final Function(int) minusCup;
  final int initialQuntity;

  const ActiveButton({
    super.key,
    required this.onRemove,
    required this.plusCup,
    required this.minusCup,
    this.initialQuntity = 1,
  });

  @override
  State<ActiveButton> createState() => _ActiveButtonState();
}

class _ActiveButtonState extends State<ActiveButton> {
  late int _cupCounter = 1;

  @override
  void initState() {
    super.initState();
    _cupCounter = widget.initialQuntity;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_cupCounter > 1) {
                      _cupCounter--;
                      widget.minusCup(_cupCounter);
                    } else {
                      widget.onRemove();
                      widget.minusCup(_cupCounter);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: AppColors.blue,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: const Center(
                  child: Text(
                    "-",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              height: 24,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  foregroundColor: AppColors.white,
                ),
                child: Text(
                  _cupCounter.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 24,
            width: 24,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_cupCounter < 10) {
                    _cupCounter++;
                    widget.plusCup(_cupCounter);
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: AppColors.blue,
                foregroundColor: AppColors.white,
              ),
              child: const Center(
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
