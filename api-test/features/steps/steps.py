import random
import requests
import json
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


def api_schema():
    """
    The json schema that's expected for the response page.
    :return:
    """
    return """ 
          {
          "$schema": "http://json-schema.org/draft-04/schema#",
          "type": "object",
          "properties": {
            "timestamp": {
              "type": "string"
            },
            "customers": {
              "type": "array",
              "items": [
                {
                  "type": "object",
                  "properties": {
                    "id": {
                      "type": "integer"
                    },
                    "name": {
                      "type": "string"
                    },
                    "employees": {
                      "type": "integer"
                    },
                    "contactInfo": {
                      "type": "object",
                      "properties": {
                        "name": {
                          "type": "string"
                        },
                        "email": {
                          "type": "string"
                        }
                      },
                      "required": [
                        "name",
                        "email"
                      ]
                    },
                    "size": {
                      "type": "string"
                    }
                  },
                  "required": [
                    "id",
                    "name",
                    "employees",
                    "contactInfo",
                    "size"
                  ]
                },
                {
                  "type": "object",
                  "properties": {
                    "id": {
                      "type": "integer"
                    },
                    "name": {
                      "type": "string"
                    },
                    "employees": {
                      "type": "integer"
                    },
                    "contactInfo": {
                      "type": "object",
                      "properties": {
                        "name": {
                          "type": "string"
                        },
                        "email": {
                          "type": "string"
                        }
                      },
                      "required": [
                        "name",
                        "email"
                      ]
                    },
                    "size": {
                      "type": "string"
                    }
                  },
                  "required": [
                    "id",
                    "name",
                    "employees",
                    "contactInfo",
                    "size"
                  ]
                },
                {
                  "type": "object",
                  "properties": {
                    "id": {
                      "type": "integer"
                    },
                    "name": {
                      "type": "string"
                    },
                    "employees": {
                      "type": "integer"
                    },
                    "contactInfo": {
                      "type": "object",
                      "properties": {
                        "name": {
                          "type": "string"
                        },
                        "email": {
                          "type": "string"
                        }
                      },
                      "required": [
                        "name",
                        "email"
                      ]
                    },
                    "size": {
                      "type": "string"
                    }
                  },
                  "required": [
                    "id",
                    "name",
                    "employees",
                    "contactInfo",
                    "size"
                  ]
                },
                {
                  "type": "object",
                  "properties": {
                    "id": {
                      "type": "integer"
                    },
                    "name": {
                      "type": "string"
                    },
                    "employees": {
                      "type": "integer"
                    },
                    "size": {
                      "type": "string"
                    }
                  },
                  "required": [
                    "id",
                    "name",
                    "employees",
                    "size"
                  ]
                },
                {
                  "type": "object",
                  "properties": {
                    "id": {
                      "type": "integer"
                    },
                    "name": {
                      "type": "string"
                    },
                    "employees": {
                      "type": "integer"
                    },
                    "contactInfo": {
                      "type": "object",
                      "properties": {
                        "name": {
                          "type": "string"
                        },
                        "email": {
                          "type": "string"
                        }
                      },
                      "required": [
                        "name",
                        "email"
                      ]
                    },
                    "size": {
                      "type": "string"
                    }
                  },
                  "required": [
                    "id",
                    "name",
                    "employees",
                    "contactInfo",
                    "size"
                  ]
                },
                {
                  "type": "object",
                  "properties": {
                    "id": {
                      "type": "integer"
                    },
                    "name": {
                      "type": "string"
                    },
                    "employees": {
                      "type": "integer"
                    },
                    "contactInfo": {
                      "type": "object",
                      "properties": {
                        "name": {
                          "type": "string"
                        },
                        "email": {
                          "type": "string"
                        }
                      },
                      "required": [
                        "name",
                        "email"
                      ]
                    },
                    "size": {
                      "type": "string"
                    }
                  },
                  "required": [
                    "id",
                    "name",
                    "employees",
                    "contactInfo",
                    "size"
                  ]
                }
              ]
            }
          },
          "required": [
            "timestamp",
            "customers"
          ]
}
        """


def e_v_s(employees, size):
    """
    Look at the number of employees and determine the size given is correct.
    Returns True if is correct, False if incorrect
    """
    if employees <= 10 and size == "Small":
        return True
    elif employees <= 1000 and size == "Medium":
        return True
    elif employees > 1000 and size == "Big":
        return True
    else:
        return False


@step(u'I make a POST request to (.*) with a user')
def requacks(context, api_url):
    """
    Make a POST request with a user. If the username given in json is "RANDOM_USER" then it
    will be replaced with a randomly generated user name.
    """
    data = context.text or None                                   # The POST data
    if data is not None:
        data = data.replace("RANDOM_USER", random_user_gen())     # Relace with randomly generated username
    context.raw_response = requests.post(api_url, data=data)


@step(u"I see the response code is ?(not)? (.*)")
def raw_check_response_code(context, negate, expected_code):
    """
    See if the response code is or isn'g matching to the expected code
    """
    if negate:
        assert int(context.raw_response.status_code) != int(expected_code)
    else:
        assert int(context.raw_response.status_code) == int(expected_code)


@step("I verify output is a valid json with defined schema")
def check_json(context):
    from jsonschema import validate
    schema_raw = api_schema()
    schema_jsonified = json.loads(schema_raw)
    json_output = json.loads(context.raw_response.text)
    validate(instance=json_output, schema=schema_jsonified)  # Only throws up error if json is detected invalid to schema


@step("I see every entry size is correct in respect to their employee count")
def employee_vs_size(context):
    """
    Compares the output json that the employee size is matching the size that's shown
    """
    json_output = json.loads(context.raw_response.text)
    for key in json_output:
        if key == "customers":
            customers_json = json_output[key]
            for customer in customers_json:
                assert e_v_s(customer["employees"], customer["size"])

@step(u"I make a POST request to (.*) with a user 100 times and validate")
def Loop(context, api_url):
    """
    Make a POST request with the user, validate the response is 200 and valid json.
    Repeat 100 times in a row without delay.
    """
    for current_loop in range(100):                                         # Loop 100x
        requacks(context, api_url)                                          # Make POST request
        raw_check_response_code(context, negate=False, expected_code=200)   # Check response code is 200
        check_json(context)                                                 # Check response json is valid