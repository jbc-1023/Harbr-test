from selenium import webdriver
from selenium.webdriver import Firefox
import random
import time
from datetime import date
from behave import use_step_matcher, step, fixture, use_fixture
use_step_matcher("re")

def random_user_gen():
    char_list = ["a", "b", "c", "d", "e", "f", "g", "h", "i",
                 "j", "k", "l", "m", "n", "o", "p", "q", "r", "s",
                 "t", "u", "v", "w", "x", "y", "z", "1", "2", "3",
                 "4", "5", "6", "7", "8", "9", "0"]
    answer = ""
    length_of_username = random.randint(3, 8)

    while length_of_username > 0:
        length_of_username -= 1
        answer += char_list[random.randint(0, len(char_list) - 1)]

    return answer

@fixture
def browser_firefox(context):
    context.browser = Firefox()
    yield context.browser
    context.browser.quit()

def before_all(context):
    use_fixture(browser_firefox, context)

@step("I open Firefox browser")
def OpenBrowser(context):
    context.browser = webdriver.Firefox()

@step("I close Firefox browser")
def CloseBrowser(context):
    context.browser.quit()

@step(u"I go to URL (.*)")
def Go2URL(context, url):
    context.browser.get(url)

@step(u"I see the text (.*) at the right place")
def TextValidate(context, text):
    xpath = ""
    if text == "Welcome to Customer App":
        xpath = "/html/body/div/div/h1"
    elif text == "Please provide your name:":
        xpath = "/html/body/div/div/div/div/p[1]"

    assert context.browser.find_element_by_xpath(xpath).text == text

@step("I enter a random user and click submit")
def Login(context):
    context.username = random_user_gen()
    context.browser.find_element_by_id("name").send_keys(context.username)
    context.browser.find_element_by_xpath("/html/body/div/div/div/div/p[2]/input[2]").click()

@step("I enter empty user and click submit")
def Login_empty(context):
    context.browser.find_element_by_xpath("/html/body/div/div/div/div/p[2]/input[2]").click()

@step("I validate username on page")
def Username_valid(context):
    should_be = context.username
    observed = context.browser.find_element_by_xpath("/html/body/div/div/div/div/p/b[1]").text
    assert should_be.strip() == observed.strip()

@step("I validate timestamp on page is now")
def Date_valid(context):
    observed_time = context.browser.find_element_by_xpath("/html/body/div/div/div/div/p/b[2]").text
    today = date.today()
    should_be_time = today.strftime("%a %b %d %Y")
    assert observed_time == should_be_time

@step("I wait (\d+) (microsecond|second|minute)?s?")
def wait_time(context, duration, units):
    duration = int(duration)

    if units == "minute":
        duration *= 60
    if units == "microsecond":
        duration /= 1000

    time.sleep(float(duration))

@step("I click on each customer name and validate the link isnt dead")
def click_validate(context):
    max_rows = 6
    title = ["Welcome to Customer App", "/html/body/div/div/h1"]
    back_button_xpath = "/html/body/div/div/div/div/div/input"

    for row in range(1, max_rows+1):
        xpath = f"/html/body/div/div/div/div/div/table/tbody/tr[{row}]/td[1]/a"
        context.browser.find_element_by_xpath(xpath).click()
        time.sleep(1)
        assert context.browser.find_element_by_xpath(title[1]).text == title[0]
        context.browser.find_element_by_xpath(back_button_xpath).click()
        time.sleep(1)

@step("I click on each customer name and validate the same customer data is returned")
def validate_link(context):
    max_rows = 6
    title = ["Welcome to Customer App", "/html/body/div/div/h1"]
    back_button_xpath = "/html/body/div/div/div/div/div/input"

    for row in range(1, max_rows + 1):
        xpath = f"/html/body/div/div/div/div/div/table/tbody/tr[{row}]/td[1]/a"
        current_customer = context.browser.find_element_by_xpath(xpath).text
        context.browser.find_element_by_xpath(xpath).click()
        time.sleep(1)
        assert context.browser.find_element_by_xpath("/html/body/div/div/div/div/div/p[2]").text == "Name: "+current_customer
        context.browser.find_element_by_xpath(back_button_xpath).click()
        time.sleep(1)

@step(u"I see a popup error message saying (.*)")
def validate_popup(context, message):
    popup_obj = context.browser.switch_to.alert
    assert popup_obj.text == message
    popup_obj.accept()

@step("I enter user and click submit")
def Login_specific(context):
    context.username = context.text
    context.browser.find_element_by_id("name").send_keys(context.username)
    context.browser.find_element_by_xpath("/html/body/div/div/div/div/p[2]/input[2]").click()