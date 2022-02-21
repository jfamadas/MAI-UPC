
In MLE_MainClassification.m / MLE_MainRegression.m:

  You will need to change the variable MatlabMLExperimentsHome

---

You may need different versions of the LIBSVM software depending of
the version of Matlab you are using.

This software uses version 2.89 (32bits) and 3.20 (64bits) by default.

If needed, you may recompile the original sources, following these
steps:

1- Remove the folders with the current versions, which are in

  ./MLE_Software/ModelsResults/ModelsSoftware/LIBSVM-2.89-32bits
  ./MLE_Software/ModelsResults/ModelsSoftware/LIBSVM-3.20-64bits

2- Compile the original sources, which are in

  ./LIBSVM-Software

3- Move the compiled files to

  ./MLE_Software/ModelsResults/ModelsSoftware/LIBSVM-3.20-MyCompilation

---

You may need different versions of the PRTools software depending of
the version of Matlab you are using.

This software uses the PRTools version 4.2.0 (2011-Aug-26) by default.

If you need to use a different version of the PRTools software, follow
these steps:

1- Remove the folder with the current PRTools version, which is in

    ./MLE_Software/ModelsResults/ModelsSoftware/

2- Copy the folder with the version you want to use, which is in

    ./PRTools-Software/

   to the folder

    ./MLE_Software/ModelsResults/ModelsSoftware/

   and untar+unzip it

    tar xfz PRTools-version-date.tgz
