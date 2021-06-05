Feature: Harbr UI test

  Background:
    Given I open Firefox browser
    When I wait 2 seconds
    And I go to URL http://localhost:3000

  Scenario: Sanity check portal UI
    When I see the text Welcome to Customer App at the right place
    And I see the text Please provide your name: at the right place
    Then I close Firefox browser

  Scenario: Functional - Log in with user
    When I enter a random user and click submit
    Then I wait 2 seconds
    And I validate username on page
    And I validate timestamp on page is now
    Then I close Firefox browser

  Scenario: Functional - Click each customer name to verify link isn't dead
    When I enter a random user and click submit
    Then I wait 2 seconds
    Then I click on each customer name and validate the link isnt dead
    Then I close Firefox browser

  Scenario: Functional - Validate each link goes to expected customer's page
    When I enter a random user and click submit
    Then I wait 2 seconds
    Then I click on each customer name and validate the same customer data is returned
    Then I close Firefox browser

  Scenario: Error handling - Empty user submitted, error popup seen, return to main page
    When I enter empty user and click submit
    Then I wait 2 seconds
    And I see a popup error message saying Please provide your name
    And I see the text Welcome to Customer App at the right place
    Then I close Firefox browser

  Scenario: Input security - Insert html code and validate it doesn't get evaluated
    When I enter user and click submit
    '''
      user<br>user<!-- abc -->user<?PHP echo "<br>"; ?>
    '''
    Then I wait 2 seconds
    And I validate username on page
    Then I close Firefox browser

  Scenario: Input boundary/edge - Username is 2^14 chars long
    When I enter user and click submit
    """
      oaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovow3h049ghoaiergvopiawh4evopniovow3pirnvp3489hw3904ghp3h049ghoaiergvopiawh4evopniovoww4gwregvrf
    """
    Then I wait 2 seconds
    And I validate username on page
    Then I close Firefox browser






