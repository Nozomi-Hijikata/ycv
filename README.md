# Ycv

The `Ycv` Gem (YAML to CSV and vice versa) is a simple yet powerful command-line tool designed specifically for converting Rails fixtures between YAML and CSV formats. This makes `Ycv` an ideal tool for developers working with Rails applications, allowing for easy manipulation and conversion of data fixtures and configurations.


## Installation

To install the `Ycv` gem, add the following line to your application's Gemfile:

```ruby
gem 'ycv'
```
Then execute:
````bash
bundle install
````

Alternatively, you can install it yourself from the command line:

```bash
gem install ycv
```

# Usage

## Command-Line Interface (CLI)
The ycv command-line tool is straightforward to use and supports output to both files and standard output (STDOUT), making it versatile for scripting and piping to other commands.

### Converting Files

To convert a YAML file to CSV:
```bash
ycv path/to/input.yml path/to/output.csv
```

To convert a CSV file to YAML:
```bash
ycv path/to/input.csv path/to/output.yml
```

Using Standard Output
If you prefer to output the conversion result to STDOUT (for example, for further processing with other command-line tools), simply omit the output file path:

Convert YAML to CSV and output to STDOUT:
```bash
ycv path/to/input.yml > output.csv
```

Convert CSV to YAML and output to STDOUT:
```bash
ycv path/to/input.csv > output.yml
```
This feature allows you to easily integrate ycv into your command-line workflows and use it in conjunction with other tools like grep, awk, or redirections.

## As a Ruby Library
In addition to the CLI, Ycv can be used as a library within Ruby applications.

## Sample Conversion
This section provides a simple example of converting between CSV and YAML formats using the ycv tool.

### YAML to CSV Conversion
Given a YAML file sample.yml with the following content:

```yml
sample_1:
  id: 1
  name: Alice
  age: 30
  
sample_2:
  id: 2
  name: Bob
  age: 25
```
Running `ycv sample.yml sample.csv` will produce a CSV file sample.csv with the following content:
```csv
id,name,age
1,Alice,30
2,Bob,25
```


### CSV to YAML Conversion
Conversely, given a CSV file sample.csv with the following content:
```csv
id,name,age
1,Alice,30
2,Bob,25
```

Running `ycv sample.csv sample.yml` will produce a YAML file sample.yml with the following content:
```yml
sample_1:
  id: 1
  name: Alice
  age: 30
  
sample_2:
  id: 2
  name: Bob
  age: 25
```
These examples demonstrate the straightforward conversion process between CSV and YAML formats, making it easy to integrate ycv into your data handling workflows.

# Contributing
Contributions to Ycv are always welcome, whether it's through bug reports, pull requests, or feature requests. 

Feel free to contribute GitHub at https://github.com/Nozomi-Hijikata/ycv.
