Feature: Flyertown language switch
  Verify that the language on Flyertown changes successfully

  #website: http://www.flyertown.ca/
  Scenario Outline: 
    Given that I am on "<browser>" 
    When I go to the flyertown "<page>" and choose "<lang>"
    Then I should see the proper language displayed

    Scenarios: 
      | browser | page   | lang                | 
      | chrome             | home  | En                | 
      | firefox         | home  | Fr                |
