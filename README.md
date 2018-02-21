# Anthology

A quick and dirty Bash script to create an ebook from a list of web articles. 

## Getting Started

Get a copy of the script and follow the instructions below.

### Prerequisites

* Get a free API key for [Mercury Web Parser](https://mercury.postlight.com/web-parser/) and put it in `compile.sh` (Line 17).
* Install `wget`.
* Install [`jq`](https://stedolan.github.io/jq/).
* Install [`Calibre`](https://calibre-ebook.com) and make sure [`ebook-convert`](https://manual.calibre-ebook.com/generated/en/ebook-convert.html) is in your PATH.
* A way to serve the current working directory via HTTP. I find Python's `SimpleHTTPServer` to be the simplest solution.

### Usage

* Put your list of articles to compile into an ebook in a text file (one URL per line). The file should end with a newline. It should look like this:
* Start the HTTP server with `python -m SimpleHTTPServer`.
* Run the script with `compile.sh [input file]`.
* Wait for Anthology to do the right thing and generate an EPUB file in the same directory. If you want a MOBI file for your Kindle, uncomment Line 40 in `compile.sh`.

## License

This project is licensed under the WTFPL License.

## Acknowledgments

Anthology is inspired by the now-defunct [Readlists by Readability](https://www.theverge.com/2012/5/22/3035904/readlists-readability-create-share-ebook).
