#!/bin/tcsh

## usage: entities.sh filename
## Converts sgml-style entities to unicode-compliant entities.

set convert = "/home/rsutton/workarea/wwrp/dataPrep/convertEntities2Unicode.pl";
set perl_inc = "/home/rsutton/workarea/wwrp/dataPrep";

## if multiple filenames are specified, run this process on all of them
foreach file ($argv)
echo "Converting entities in $file."
# run conversion, output to a file of the same name in the current directory
perl -I${perl_inc} $convert < $file > `basename $file`
end
