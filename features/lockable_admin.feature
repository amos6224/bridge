#TODO improve? http://gregbee.ch/blog/effective-api-testing-with-cucumber

@mocks
Feature: Adding locked and unlocked admins to companies
  As a client
  In order to add locked and unlocked admins to companies
  I need an API endpoint

  Background:
    Given the call to the lockable admin worker is stubbed

  Scenario: Posting with a permalink that doesn't exist
    Given a client requests POST "/companies" with the following json:
    """
    {
      "permalink":["namely"],
      "emails":["attila1@namely.com"],
      "command":"lock",
      "authorized_by":"damon1@namely.com"
    }
    """
    Then the response status should be "403"
    And the JSON body should be:
    """
    {"permalink":"Invalid permalinks: namely"}
    """

  Scenario: Posting with a permalink that does exist
    Given companies exist with the following permalinks: namely
    And a client requests POST "/companies" with the following json:
    """
    {
      "permalink":["namely"],
      "emails":["attila1@namely.com"],
      "command":"lock",
      "authorized_by":"damon1@namely.com"
    }
    """
    Then the response status should be "200"
    And the JSON body should be:
    """
    {"success":true}
    """
