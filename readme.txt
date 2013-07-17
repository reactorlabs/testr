TESTR Documentation
===================

First of all, there are currently two versions of testR. The old one which is in the / folder, and the new one which is in the /testr folder. This manual only deals with the new version and everyone is highly encouraged to use the new version. Please note that testR is under continuous development and I am adding things as I find them useful for the project. A disadvantage of this approach is that it might happen that certain things will break from time to time. Should you see this, please do let me know and I will fix them ASAP: peta.maj82@gmail.com

Note: Because I only have access to Windows and Linux machines, testR on MacOSX is well, untested. If you happen to figure out that it works (or indeed does not:), please let me know as well. 

General Overview
----------------

testR is a test system framework written in Python that is capable of testing and benchmarking various R virtual machines. It is written in a very extensible way so that its features can be increased efficiently (if you know a bit Python). Main important terms when running testR are:

target = the VM that will be used to run the tests. 
module = object responsible for handling the results of the evaluations of the R programs on the target. This is the code that does the actual job of say comparing the results, timing, etc. 
suite = location from which the tests are read. Also the code responsible for dealing with the test header processing and code genertaion (see below)

Multiple targets, modules, and suites can be executed in a single run, although having only a single module and multiple tests and targets is the recommended mode of operation. testR is a python script and requires Python 3 and above to run correctly. Depending on your system, you can thus execute testR by typing the following

python testr.py # if python 3 is your default python distribution
python3 testr.py
testr.py # if your system supports hashbang and you have python 3 properly installed (linux mostly)

testR then accepts many arguments, which can either be specified on the commandline, or written to a file and testR is executed pointing to the file:

testr.py -include=THE_FILE

In general, all testR arguments are specified by -ARG_NAME=ARG_VALUE, if specified in the dedicted file, one argument per line and the leading - signs are still mandatory. Many arguments have their simpler forms (-target, -t), etc. In the file, comments can be added by starting the line with # character. 

Arguments are positional, that is if say a certain target is selected, then all arguments following that specification as long as they are understood by the target will be only used for that particular target. The same goes for modules. 

There is a small set of arguments that are target/module agnostic:

-n= specifies the number of threads to be used for execution. Since running the tests can be very tedious task, this can significantly speed the process up. Of course specifying this argument for benchmarking is not recommended. 

-suite= specifies the root point of a test suite. This can either be R file, or a folder which will then be scanner recursively. Multiple roots can be specified by using the -suite argument many times. 

Targets
-------

There is a number of targets, they can be selected by their name using the -t argument. Each target supports the following attributes:

-p= specifies new path for the target VM
-a= adds an argument to the execution (! this does not always mean an attribute to the target VM itself depending on the target implementation)
-displayCmd (no value) displays the command executed to run the target
-displayOutput (no value) displays the output of the target in raw form

Different targets can have additional arguments. For those it is best to consult the target python files located in the targets package. 

Please note, that the fastr targets point to a shell file executing fastr itself. Examples of these files can be found in /scripts directory. To use them properly, you should either edit the required paths in the provided examples and then point to them, or make them available at path, or you can always create your own shell files and use them without any problem. 

To use fastr, use fastr-new for master branch, and fastr for branch truffle-api. The fastr-new target deals properly with the new output formatting in the latest fastr builds. 

Modules
-------

A module must be specified for testR to actually do anything (without a module, testR only silently iterates over the tests doing nothing with them). 

Similarly there is a number of modules, each of them defined in the modules package, which is also a good place to look for more advanced arguments. The following should be understood by all modules:

-outputFile= redirects all output from the module to the given file. 

Module timer has additional arguments, notably the -measurements= argument that specifies the number of executions of each test. 

Test Module
-----------

Test module has the additional arguments:

-showOnlyErrors, or -soe : only tests that have failed or are skipped will be displayed - by default all tests are displayed. 

-failAfterError, or -fae : exits testR after first failing test. Default is to analyze all tests. 

-showCodeOnError, or -coe : if there is an error, displays the raw R code that is the test that has failed in the output. 

Tests
-----

The test roots can either be R files themselves, or folders. The folders will be recursively searched for R files which will be used for the tests. Multiple tests can be stored in single R file, each test starting with at least one testR command identified by line start #!. This is the list of most important header commands, full list can be found in testsuite.py:

#!   == specifies the name of the test
#!t RESULT  == expects no warnings or errors and the given RESULT as the output
#!o RESULT == only checks the ouput, does not deal with warnings 
#!w TXT == warning containing TXT is expected
#!e TXT == error containing TXT is expected
#!g NAME = (VALUES) == introduces a new test generic named NAME with given VALUES, values are separated by # characters. To refer to the generic from test or other commands, use @NAME. Multiple generics will result in permutation of their values. 
#!g NAME(DEP) = (VALUES) == introduces a new generic NAME dependent on generic DEP with given values. Each time the DEP generic changes, the NAME generic changes too, therefore the dependent generics do not produce permutations. 

Tests can be blacklisted or whitelisted based on their names and locations using the -wl and -bl arguments after the -suite commands. 

Tests in the repository:
------------------------

The following tests can be found in the repository:

language tests -- testR R testing suite, these are the structured tests that aim to cover the R language and provide the reference. Some of them also fail gnu-r (or are skipped for clearer results) as gnu-r is inconsistent with the manual itself (manuals are the R tutorial and the R language reference).

language inconsistencies -- failed tests from language tests, sometimes with more information, aggregated here for simplicity.

graal tests -- several of my tests when I was testing graal with us. They may or may not be relevant to others, as they are pretty much ad hoc versions of shootouts or microbenchmarks I used to play with graal and its various features.  

Examples
--------

The following are simple examples of argument files that can be used to drive testr to do different tasks:


# simplest example, just running the module for counting the tests, no targets specified
-m=counter
-suite=/home/peta/devel/work/testr/language tests

# now runs the conformity test module for target gnu-r
-t=gnur-linux
-m=test
-suite=/home/peta/devel/work/testr/language tests

# multiple targets can be executed for the same suite, here we ran gnu-r and fastr together, using 4 threads
-t=gnur-linux
-t=fastr
-m=test
-suite=/home/peta/devel/work/testr/language tests
-n=4

# module timer can be used to time executions, again, can be used with more targets at once, number of measurements for
# each benchmark can be specified as well using the -measurements argument
-t=gnur-linux
-t=fastr
-m=timer
-measurements=10
-suite=/home/peta/devel/work/testr/language tests
