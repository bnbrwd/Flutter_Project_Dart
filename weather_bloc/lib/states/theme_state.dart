
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final Color backgroundColor;
  final Color textColor;

  const ThemeState({required this.backgroundColor, required this.textColor});

  @override
  // TODO: implement props
  List<Object?> get props => [backgroundColor, textColor];
  
}