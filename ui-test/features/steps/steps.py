from selenium import webdriver
import random
import time
from datetime import date
from behave import use_step_matcher, step
use_step_matcher("re")

def random_user_gen(length_min=3, length_max=8):
    """
    Creates a ranmdom string using capital/noncapital alphanumeric chars within a range of length.
    :param length_min: The minimal length of generated string
    :param length_max: The maximum length of generated string
    :return: The generated string
    """
    char_list = ["a", "b", "c", "d", "e", "f", "g", "h", "i",
                 "j", "k", "l", "m", "n", "o", "p", "q", "r", "s",
                 "t", "u", "v", "w", "x", "y", "z", "1", "2", "3",
                 "4", "5", "6", "7", "8", "9", "0"]
    answer = ""
    length_of_username = random.randint(length_min, length_max)

    # Loop to generate string
    while length_of_username > 0:                                     # Loop till string length is reached
        length_of_username -= 1
        rand_cap = random.randint(0, 1)                               # Decide if capital or not 50/50 chance
        rand_char = char_list[random.randint(0, len(char_list) - 1)]  # Grab random char from list
        if rand_cap == 1:                                             # If capital, make capital
            rand_char = rand_char.upper()
        answer += rand_char                                           # Append to the generated string

    return answer

# -------------------------------------------------------------------------------------
# The var "context" is shared global var, i.e., fixture, between all tests/functions
# -------------------------------------------------------------------------------------

@step("I open Firefox browser")
def OpenBrowser(context):
    """
    Create a Firefox brower instance and save object to context
    """
    context.browser = webdriver.Firefox()

@step("I close Firefox browser")
def CloseBrowser(context):
    """
    Close the opened Firefox browser instance that's in context
    """
    context.browser.quit()

@step(u"I go to URL (.*)")
def Go2URL(context, url):
    """
    Browser to go a specified URL. The URL must be a valid URL.
    """
    context.browser.get(url)

@step(u"I see the text (.*) at the right place")
def TextValidate(context, text):
    """
    A specific string of text is given and matched to it's respective location via xpath.
    Assert that the text indeed is within the xpath given.
    """
    xpath = ""
    if text == "Welcome to Customer App":
        xpath = "/html/body/div/div/h1"
    elif text == "Please provide your name:":
        xpath = "/html/body/div/div/div/div/p[1]"

    assert context.browser.find_element_by_xpath(xpath).text == text

@step("I enter a random user and click submit")
def Login(context):
    """
    On the home page, enter a random username and click the submit.
    This only works on home page.
    """
    context.username = random_user_gen()
    context.browser.find_element_by_id("name").send_keys(context.username)
    context.browser.find_element_by_xpath("/html/body/div/div/div/div/p[2]/input[2]").click()

@step("I enter empty user and click submit")
def Login_empty(context):
    """
    On the home page, just click submit without entering a username.
    """
    context.browser.find_element_by_xpath("/html/body/div/div/div/div/p[2]/input[2]").click()

@step("I validate username on page")
def Username_valid(context):
    """
    Validate that the user name used to log in (that's saved in context) is indeed the same username
    that is visible on page after submit, AND in the right place on page (check via xpath)
    """
    should_be = context.username
    observed = context.browser.find_element_by_xpath("/html/body/div/div/div/div/p/b[1]").text
    assert should_be.strip() == observed.strip()

@step("I validate timestamp on page is now")
def Date_valid(context):
    """
    Validate that the timestamp given after submit is correct when comparing to the timestamp of the
    local machine
    """
    observed_time = context.browser.find_element_by_xpath("/html/body/div/div/div/div/p/b[2]").text
    today = date.today()
    should_be_time = today.strftime("%a %b %d %Y")  # Example format "Fri Jun 04 2021"
    assert observed_time == should_be_time

@step("I wait (\d+) (microsecond|second|minute)?s?")
def wait_time(context, duration, units):
    """
    Let program run hold/wait for the specified time
    """
    duration = int(duration)

    if units == "minute":
        duration *= 60
    if units == "microsecond":
        duration /= 1000

    time.sleep(float(duration))

@step("I click on each customer name and validate the link isnt dead")
def click_validate(context):
    """
    Loop through each link and click on it to verify the link works by validating
    a expected text on the landing page.
    """
    max_rows = 6                                                   # The amount of rows expected to display per page
    title = ["Welcome to Customer App", "/html/body/div/div/h1"]   # The title and it's expected xpath, used for validating landing page
    back_button_xpath = "/html/body/div/div/div/div/div/input"     # Back button xpath

    for row in range(1, max_rows+1):                               # Loop through each row of table
        xpath = f"/html/body/div/div/div/div/div/table/tbody/tr[{row}]/td[1]/a"
        context.browser.find_element_by_xpath(xpath).click()       # Click the link in Name column
        time.sleep(1)                                              # Good habit to put a delay to avoid race condition
        assert context.browser.find_element_by_xpath(title[1]).text == title[0]
        context.browser.find_element_by_xpath(back_button_xpath).click() # Click back button to return to previous page of links
        time.sleep(1)                                              # Good habit to put a delay to avoid race condition

@step("I click on each customer name and validate the same customer data is returned")
def validate_link(context):
    """
    Loop through each link and click on it, verify the "Name" text of the link leads to the
    expected page with the same name.
    """
    max_rows = 6                                                   # The amount of rows expected to display per page
    back_button_xpath = "/html/body/div/div/div/div/div/input"     # Back button xpath

    for row in range(1, max_rows + 1):                             # Loop through each row of table
        xpath = f"/html/body/div/div/div/div/div/table/tbody/tr[{row}]/td[1]/a"
        current_customer = context.browser.find_element_by_xpath(xpath).text # Get link name text
        context.browser.find_element_by_xpath(xpath).click()       # Click the link
        time.sleep(1)                                              # Good habit to put a delay to avoid race condition
        assert context.browser.find_element_by_xpath("/html/body/div/div/div/div/div/p[2]").text == "Name: "+current_customer  # Validate the name link matches the name on next page
        context.browser.find_element_by_xpath(back_button_xpath).click()  # Click back button to return to previous page
        time.sleep(1)                                              # Good habit to put a delay to avoid race condition

@step(u"I see a popup error message saying (.*)")
def validate_popup(context, message):
    """
    Validate that a popup is seen with the expected text.
    """
    popup_obj = context.browser.switch_to.alert
    assert popup_obj.text == message
    popup_obj.accept()

@step("I enter user and click submit")
def Login_specific(context):
    """
    Log in using a specific username from context
    """
    context.username = context.text
    context.browser.find_element_by_id("name").send_keys(context.username)                     # Enter username into text field
    context.browser.find_element_by_xpath("/html/body/div/div/div/div/p[2]/input[2]").click()  # Click submit