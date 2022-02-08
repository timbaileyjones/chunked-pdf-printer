# chunked-pdf-printer

Did you ever buy a network printer that, for whatever reason, simply cannot handle a 300+ page PDF file?

Well, I did, and this was my solution.

Simply put, `chunked-pdf-printer.sh` divides a long PDF file into 10 page chunks, and submits each chunk to the `lp` command,
sleeping for 30 seconds in between.  The sleep is to ensure that the print service keeps the chunks in the
correct order.

It relies on the [pdftk](https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/) program.
pdftk is a fabulous CLI tool.  This script uses pdftk to find the total number of pages, and to
generate each 10-page chunk of the larger file.  

I got my copy of pdftk from Ubuntu's apt repository.  I have not tested this under any other distribution.
You, of course, are welcome to do so, and share improvements, as we programmers love to do.

PRs, issues and comments are welcome.

I notified the makers of pdftk of this script via [this issue](https://github.com/ericmason/pdftk/issues/7).  
Hopefully they'll add this feature to pdftk directly. Until then, enjoy this script.

# Usage:

Put the chunked-pdf-printer.sh script somewhere in your PATH, make sure it is executable (`chmod 755`),
and invoke as follows:

```
   $ chunked-pdf-printer.sh my-giant-pdf.pdf [...]
```

Tim Bailey-Jones
Plant City, FL USA
