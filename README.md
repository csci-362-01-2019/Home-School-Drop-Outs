# Moodle Automated Testing Framework!

Welcome to the **Moodle** Automated Testing framework! Moodle is a free and open-source learning management system (LMS) written in PHP and distributed under the GNU General Public License. Moodle is used for blended learning, distance education, flipped classroom and other e-learning projects in schools, universities, workplaces and other sectors.

# The Goal

The testing framework runs on Ubuntu (Linux/Unix). The testing framework will be invoked by a single script fcalled **“./scripts/runAllTests.sh”** and will access a folder containing test case specifications. Each of these files will conform to a test case specification template. Each test case specification file thus contains the meta-data that the framework needs to setup and execute the test case and collect the results of the method being tested.

## Getting Started

- To run the framework simple clone the project to your machine.

    > git clone https://github.com/csci-362-01-2019/Home-School-Drop-Outs.git


- Navigate to the scripts directory located in the TestAutomation directory.
    > cd ../pathToProject/TestAutomation/scripts

- Run the testing framework with the following command.
    > bash ./runAllTests.sh
