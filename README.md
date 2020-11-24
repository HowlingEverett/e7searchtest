# E7 Code Test Implementation - Justin Marrington

This is my implementation for the E7 Ruby code test. I've implemented the specification as a rubygem, and included a very basic
STDIN-driven CLI for executing the ranker.

## Getting set up

Clone this repository, then:

```
bundle install
```

## Running tests

```
rspec
```

## Using the CLI

The CLI application is called `e7searchtest`. It is designed to work via a pipe into STDIN, so you can echo a string or cat the contents of a
file you want to test rankings on.
You can install the gem as a global rubygem and execute the CLI from your path. Or, just run it from the `bin` directory, e.g.

```
cat my_sample_query.txt | bin/e7searchtest
```
