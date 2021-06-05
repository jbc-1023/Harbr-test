Hi Harbr folks. Justl ike the other API test, I kept it simple. Selenium does require some prerequisites, I  hope I've minimized the dependnecies enough to make it for quick deploy and run. Thanks for looking!


### Steps to run tests:

1. Have Python 3 installed
2. Have Firefox browser installed (Tested on Firefox 88.0.1 64bit)
3. Have Selenium package is installed for Python
4. Have Selenium's geckodriver location is in environment variables. Choose your OS from here: https://github.com/mozilla/geckodriver/releases/tag/v0.29.1
5. Install behave `sudo apt install behave`
6. Go into folder `Harbr-test\ui-test` if not there already
7. Run all tests with command `behave`

If want to run a specific test rather than the whole suite, use
<br>`behave ui-test/features/tests/UI_test.feature:<line_number>` where `line_number` is the where the `Scenario` starts
<hr>

### Test Descriptions

Please see file `UI-test/features/tests/UI_test.feature` All tests are written in Gherkin and are self explanatory. Therefore I won't be describing them in the README 

### Assumptions
- Limit of text field length is 2^14

### Some tests will fail because...

Bugs found:
- United Brands customer lead to an error page