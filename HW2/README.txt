# README for ML Homework #2
# Tony Jebara -- Fall 2013 Columbia University
# Created by Joe Ellis

Description:
Overall:
	-The code that is within this README file has been created to help with the solutions to problems 3 and 4 of the Homework #2 for ML class.  A description of each file can be seen below.
RunProblem4.m:
	- This function automatically seperates the training data from the test/data in a 50/50 split, and then runs the classifier training based on the type of classifier it is given, the Cost value, and the extra parameter (used only in 'poly' and 'RBF' classifiers.  This is done over 10-cross_validation scripts, and the final result accuracy across those values is passed as output of the function.
Creategraphs.m:
	- This is a utility script that wraps RunProblem4 so that many values of C and paramter p1, can be tried in one run.  The script then automatically generates the surf plot for a given bunch of trial runs.
ComputeProb3,m:
	-This script computes the gram matrix for the values given in Problem3.  The result is then output to the screen.  The result is shown in two different ways, by explicitly doing the integral and then taking the definite integral as shown in the assignment.  We also do this by numerically evaluting the integral using Matlab.  Both matrices are the same, therefore the explicit integration provided in the assignment is correct.
