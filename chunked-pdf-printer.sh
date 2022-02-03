#!/bin/bash

which pdftk
if [ $? -gt 0 ]
then
  echo "This script requires the pdftk program to operate.  Please install it and try again."
  exit 1
fi

if [ $# -lt 2 ]
then
  echo Usage: $0 long-file.pdf '[...]'
fi

for input in $*
do
  if [ ! -r $input ]
  then
      echo skipping non-existing or unreadable file $input...
      continue
  fi
  start=1
  batch=10

  base=`basename $input .pdf` 
  page_count=`pdftk ${input} dump_data | grep NumberOfPages | awk '{ print $2 }'`

  while [ $start -le $page_count ]
  do 
    end=`expr $start + $batch - 1`
    if [ $end -gt $page_count ]
    then
      end=$page_count
    fi

    output=.${base}-pages-`printf %04d ${start}`-`printf %04d ${end}`.pdf
    echo pdftk $input cat ${start}-${end} output $output
         pdftk $input cat ${start}-${end} output $output

    lp -o sides=two-sided-long-edge $output; sleep 30

    start=`expr $start + $batch`
  done 
done
