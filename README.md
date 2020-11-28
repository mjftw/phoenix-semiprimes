# Semiprimes

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/c05a36aacfc2424e81909b97d7fe132c)](https://www.codacy.com/gh/mjftw/phoenix-semiprimes/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=mjftw/phoenix-semiprimes&amp;utm_campaign=Badge_Grade)
[![Coverage Status](https://coveralls.io/repos/github/mjftw/phoenix-semiprimes/badge.svg?branch=master)](https://coveralls.io/github/mjftw/phoenix-semiprimes?branch=master)

Simple REST API to check where a given number (or batch of numbers) are semiprimes.  
A semiprime is defined as a number with exactly two prime factors.

The implementation used to find whether a number is a semiprime is somewhat naive and definitely not
efficient (something like `O(N^3)`).  
There's bound to be a clever mathematical way of doing this faster.

CI implemented with Github Actions, using [Coveralls](https://coveralls.io/github/mjftw/phoenix-semiprimes?branch=master) to
check test coverage, and [Codacy](https://app.codacy.com/gh/mjftw/phoenix-semiprimes/dashboard?branch=master) to ensure that
the code (and Markdown docs) conform to common coding styles, and are free of common errors.

Request parameters validation is done using schemaless [Ecto Changesets](https://hexdocs.pm/ecto/Ecto.Changeset.html).
## Start the server

To start your Phoenix server:

* Install dependencies with `mix deps.get`
* Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Run the tests

The tests can be run with `mix test`.

## Example usage

Below are some usage examples using cURL, and expected responses.

### Check a whether a single number is semiprime

Request:

```shell
curl -XPOST \
  localhost:4000/api/v1/semiprime \
  --header 'Content-Type: application/json' \
  -d '{"number": 3}'
```

Response from server:

```json
{"is_semiprime":false,"number":3}
```

Request:

```shell
curl -XPOST \
  localhost:4000/api/v1/semiprime \
  --header 'Content-Type: application/json' \
  -d '{"number": 22}'
```

Response from server:

```json
{"is_semiprime":true,"number":22}
```

### Check a whether a batch of numbers are semiprime

```shell
curl -XPOST \
  localhost:4000/api/v1/semiprime \
  --header 'Content-Type: application/json' \
  -d '{"batch": [9, 10, 11]}'
```

Response from server (whitespace added for readability):

```json
{
  "batch": [
    {
      "is_semiprime": false,
      "number": 9
    },
    {
      "is_semiprime": true,
      "number": 10
    },
    {
      "is_semiprime": false,
      "number": 11
    }
  ]
}
```

## Possible extensions

I considered adding some extensions to the project, but decided that it was outside the scope of the
challenge, so I should leave them.

Some possible extensions could be:

* Authentication for API using OAuth2 (bearer auth probably)
* OpenAPI definitions and Swagger documentation with executable endpoints
* A more efficient semiprimes algorithm
