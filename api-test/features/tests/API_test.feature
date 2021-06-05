Feature: Harbr API test

    Scenario: Sanity functional test
        When I make a POST request to http://localhost:3001 with a user
        """
            {'name':'RANDOM_USER'}
        """
        Then I see the response code is 200
        Then I verify output is a valid json with defined schema

    Scenario: Functional / Data validation - employees vs size
        When I make a POST request to http://localhost:3001 with a user
        """
            {'name':'RANDOM_USER'}
        """
        And I see every entry size is correct in respect to their employee count

    Scenario: Error handling - No username given
        When I make a POST request to http://localhost:3001 with a user
        """
            {'name':''}
        """
        Then I see the response code is not 200

    Scenario: Error handling - No post data given
        When I make a POST request to http://localhost:3001 with a user
        Then I see the response code is not 200

    Scenario: Error handling - Username is made of up special characters
        When I make a POST request to http://localhost:3001 with a user
        """
            {'name':'~!@#$%^&*()_+'}
        """
        Then I see the response code is not 200

    Scenario: Boundary / Edge - Max boundary of POST username length 1024 chars
        When I make a POST request to http://localhost:3001 with a user
        """
            {'name':'oiaejwngogienroiuh34oignvoeirwnvoieuhrn4goieashngvpoiuehr4gpoiueoiaejwngogienroiuh34oignvoeirwnvoieuhrn4goieashngvpoiuehr4gpoiueoiaejwngogienroiuh34oignvoeirwnvoieuhrn4goieashngvpoiuehr4gpoiueoiaejwngogienroiuh34oignvoeirwnvoieuhrn4goieashngvpoiuehr4gpoiueoiaejwngogienroiuh34oignvoeirwnvoieuhrn4goieashngvpoiuehr4gpoiueoiaejwngogienroiuh34oignvoeirwnvoieuhrn4goieashngvpoiuehr4gpoiueoiaejwngogienroiuh34oignvoeirwnvoieuhrn4goieashngvpoiuehr4gpoiueoiaejwngogienroiuh34oignvoeirwnvoieuhrn4goieashngvpoiuehr4gpoiueoiaejwngogienroiuh34oignvoeirwnvoieuhrn4goieashngvpoiuehr4gpoiueoiaejwngogienroiuh34oignvoeirwnvoieuhrn4goieashngvpoiuehr4gpoiueoiaejwngogienroiuh34oignvoeirwnvoieuhrn4goieashngvpoiuehr4gpoiueoiaejwngogienroiuh34oignvoeirwnvoieuhrn4goieashngvpoiuehr4gpoiueoiaejwngogienroiuh34oignvoeirwnvoieuhrn4goieashngvpoiuehr4gpoiueoiaejwngogienroiuh34oignvoeirwnvoieuhrn4goieashngvpoiuehr4gpoiueoiaejwngogienroiuh34oignvoeirwnvoieuhrn4goieashngvpoiuehr4gpoiueoiaejwngogienroiuh34oignvoeirwnvoieuhrn4goieashngvpoiuehr4gpoiue'}
        """
        Then I see the response code is 200

    Scenario: Stress - Hammer the API 100 times
        When I make a POST request to http://localhost:3001 with a user 100 times and validate
        """
            {'name':'RANDOM_USER'}
        """
