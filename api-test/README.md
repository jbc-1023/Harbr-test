Hi Harbr folks. Just keeping it simple for easy deploy and run. Thanks for looking!

### Steps to run tests:

_Assuming you are running Ubuntu Linux_

1. Install Python 3 
2. Install behave `sudo apt install behave`
3. Go into folder `Harbr-test\api-test` if not there already
4. Run all tests with command `behave`


If want to run a specific test rather than the whole suite, use
<br>`behave api-test/features/tests/API_test.feature:<line_number>` where `line_number` is the where the `Scenario` starts
<hr>

### Test Descriptions

Please see file `api-test/features/tests/API_test.feature` All tests are written in Gherkin and are self explanatory. Therefore I won't be describing them in the README 

### Assumptions

- Max limit of allowed POST username char count is 1024
- Performance limit of API 100 rps

### Some tests will fail because...

Bugs found:
- Spec says "Medium" if employees <= 1000 but the customer "Caribian Airlnis" is marked as "Big" at 1000 employees. The test that caught it is "Scenario: Functional test - Data validation - employees vs size and will fail when run"
- When POST with no username, still returned 200
- When POST with no post data, still returned 200
- The user name given in POST is not present in the response json as described in spec


Undefined expected behavior (unsure if pass or fail)
- When username in POST is made up of special characters only
