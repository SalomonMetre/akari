import 'package:akari/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Renders the game cell given the current game grid, the row & col of the clicked cell, and the cell size
Widget renderCell(
    {required List gridProposition,
    required int row,
    required int col,
    required double cellSize}) {
  int cellValue = gridProposition[row][col];
  return switch (cellValue) {
    -1 => Container(
        color: Colors.black,
      ),
    0 => Container(
        color: Colors.white70,
      ),
    10 => Container(
      color: Colors.yellow,
      child: const Icon(
          Icons.light,
          color: Colors.deepOrangeAccent,
        ),
    ),
    20 => Container(
        color: Colors.yellow,
      ),
    _ => Container(
        width: cellSize,
        height: cellSize,
        color: AppColors.black,
        child: Center(
          child: Text(
            "${gridProposition[row][col]}",
            style: GoogleFonts.cherrySwash(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      )
  };
}
