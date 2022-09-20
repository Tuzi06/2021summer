In deadlock.cpp, it does not read all three input.txt files process the out at once.

To test the specific file, please go to line 76 and change the file name in the code:
ifstream fin ("input.txt");
to test the specific file you want to run.