# Automation Project-Tasks

### Intro
This project contains 7 robot files. 
- Five of them contain my solution to the corresponding tasks. 
- One (test.robot) is a universal test where the value of the variables can be changed and
non-required statements can be changed to comments. (I try)
- One (common.robot) is a file containing all the keywords of the test statements.


### Get started
1. Create a file containing your Deriv account's credentials (email and password), and initialize the variables 'my_email' and 'my_password':
````
-v my_email:<email>
-v my_password:<password>
````

2. Run the following command to execute the test.
````
robot -A <fileName containing credentials> <robot file>
````
Eg.
````
robot -A credentials.txt task1.robot
````
