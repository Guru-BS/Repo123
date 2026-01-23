# CMake generated Testfile for 
# Source directory: C:/DevOpsProject
# Build directory: C:/DevOpsProject/build
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
if(CTEST_CONFIGURATION_TYPE MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
  add_test(CalculatorTests "C:/DevOpsProject/build/Debug/calculator_test.exe")
  set_tests_properties(CalculatorTests PROPERTIES  _BACKTRACE_TRIPLES "C:/DevOpsProject/CMakeLists.txt;20;add_test;C:/DevOpsProject/CMakeLists.txt;0;")
elseif(CTEST_CONFIGURATION_TYPE MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
  add_test(CalculatorTests "C:/DevOpsProject/build/Release/calculator_test.exe")
  set_tests_properties(CalculatorTests PROPERTIES  _BACKTRACE_TRIPLES "C:/DevOpsProject/CMakeLists.txt;20;add_test;C:/DevOpsProject/CMakeLists.txt;0;")
elseif(CTEST_CONFIGURATION_TYPE MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
  add_test(CalculatorTests "C:/DevOpsProject/build/MinSizeRel/calculator_test.exe")
  set_tests_properties(CalculatorTests PROPERTIES  _BACKTRACE_TRIPLES "C:/DevOpsProject/CMakeLists.txt;20;add_test;C:/DevOpsProject/CMakeLists.txt;0;")
elseif(CTEST_CONFIGURATION_TYPE MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
  add_test(CalculatorTests "C:/DevOpsProject/build/RelWithDebInfo/calculator_test.exe")
  set_tests_properties(CalculatorTests PROPERTIES  _BACKTRACE_TRIPLES "C:/DevOpsProject/CMakeLists.txt;20;add_test;C:/DevOpsProject/CMakeLists.txt;0;")
else()
  add_test(CalculatorTests NOT_AVAILABLE)
endif()
