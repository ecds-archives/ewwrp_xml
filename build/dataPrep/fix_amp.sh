#!/bin/tcsh

## fix the non-entity & in sgml files
## usage: fix_amp.sh file1 file2 file3

set exscript = "/tmp/fix_amp";

echo '1,$s/ & / \&amp; /g' > $exscript;
echo "write" >> $exscript;
echo "quit" >> $exscript;

foreach file ($argv)
   ex $file < $exscript;
end

rm $exscript;
