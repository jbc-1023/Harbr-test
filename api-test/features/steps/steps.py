import random
import requests
import json
from behave import use_step_matcher, step

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


def api_schema():
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
    data = context.text or None
    if data is not None:
        data = data.replace("RANDOM_USER", random_user_gen())
    context.raw_response = requests.post(api_url, data=data)


@step(u"I see the response code is ?(not)? (.*)")
def raw_check_response_code(context, negate, expected_code):
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
    validate(instance=json_output, schema=schema_jsonified)


@step("I see every entry size is correct in respect to their employee count")
def employee_vs_size(context):
    json_output = json.loads(context.raw_response.text)
    for key in json_output:
        if key == "customers":
            customers_json = json_output[key]
            for customer in customers_json:
                assert e_v_s(customer["employees"], customer["size"])

@step(u"I make a POST request to (.*) with a user 100 times and validate")
def Loop(context, api_url):
    for current_loop in range(100):
        requacks(context, api_url)
        raw_check_response_code(context, negate=False, expected_code=200)
        check_json(context)