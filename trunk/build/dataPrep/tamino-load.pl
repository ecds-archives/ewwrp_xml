#!/usr/bin/perl

## Rebecca Sutton Koeser, March 2004.
## This script loads a file or files to a specified tamino database
## and collection.
## Files loaded with this script will have docnames defined in tamino.
##
## This script is derived in part from tamino load scripts created by Julia Leon.


use Carp;
## Note: do we need this?
# use File::Spec;  # for portability to Windows
use strict;
use POSIX ":sys_wait_h";
use IO::Handle;



my($debug);
$debug = 1;

my ($db, $coll, $root, $argmax, $arg, @files);
my($usage, $exename);
$exename = "tamino-load.pl";
$usage = "Usage:
 $exename --db DATABASE --coll COLLECTION [--root TEI.2] file [file2 [file3]]

 $exename loads one or several files to the specified database and
 collection in tamino.

   Options:
	-d,--db		Tamino Database
	-c,--coll	Tamino collection
	-r,--root	root element in collection (defaults to TEI.2)
	-h,--help	Display usage information

Note: filenames should specified either with an absolute path or a path relative
to the current directory, but must not contain '../'

";
$argmax = $#ARGV;

## get command line arguments & filenames
for (my $i = 0; $i <= $argmax; $i++){
  $arg = shift(@ARGV);
  if (($arg =~ /^-d/)||($arg =~ /^--db/))   { $i++; $db = shift(@ARGV);}
  elsif (($arg =~ /^-c/)||($arg =~ /^--coll/)) { $i++; $coll = shift(@ARGV);}
  elsif (($arg =~ /^-r/)||($arg =~ /^--root/)) { $i++; $root = shift(@ARGV);}
  elsif (($arg =~ /^-h/)||($arg =~ /^--help/)) { print $usage; exit(); }
  ## any other option should be a filename
  else { push(@files, $arg); }
}

if (!($db) || !($coll)) {
  print "Error: database and collection must be defined!\n";
  exit();
}



## default root element is TEI.2 (specify anything else on command line)
if (!($root)) {
  $root = "TEI.2";
}

if ($debug) {
  print "Settings:\tDB = $db\tcollection = $coll\troot element = $root\n";
}

my($javaMemoryHeapSzie, $classpath);
my $javaMemoryHeapSize="-Xmx510m";
## FIXME: this classpath should be relative or absolute????
#$classpath=" JavaLoader.jar:xercesTamino.jar";
$classpath="dataPrep/JavaLoader.jar:dataPrep/xercesTamino.jar";

#increase memory with the mx parameter. must be multiple of 1024k greater than 2mb
my($logfile, $output);
$logfile = "tamino-load.log";
open(LOG, ">$logfile") || confess("Can't open $logfile: $!\n");

my($f, $fullf, $basef, $wd, $javacmd);
$wd = `pwd`;
chop($wd);


foreach $f (@files) {
print  "Loading $f to tamino.";
$basef = `basename $f`;
chop($basef);
if ($debug) {  print "File basename is $basef.\n"; }
if (!($f =~ m|^/|)) {
  if ($debug) {  print "File does not have full path, adding wd to path.\n"; }
  $fullf = "$wd/$f";
} else {
  $fullf = $f;
}


## NOTE: using root element & filename sets ino:docname in tamino
$javacmd = "java $javaMemoryHeapSize -classpath $classpath com.softwareag.tamino.db.tools.loader.TaminoLoad -f $fullf -u http://vip.library.emory.edu/tamino/$db/$coll/$root/$basef -d";

## debugging info
if ($debug) { print "JAVALOAD COMMAND:\n$javacmd\n"; }

STDOUT->autoflush();
my($child, $pid);
if ($pid = fork()) {  	# parent process
  do {
    print ".";        # give user some feedback while they wait
    select(undef, undef, undef, 0.2);	 # sleep for 200 ms
   $child = waitpid($pid, WNOHANG);      # check if java is still running
  } until $child > 0;
} elsif (defined $pid) { # child process  -- run java command
  ## redirect the output away from the screen
  $output = `$javacmd`;
  if ($output =~ '1 elements uploaded') {
    print "\nSuccess!\n";
  } elsif (($output =~ 'ERROR')||($output =~ '0 elements uploaded')) {
    print "\nLoad failed.\n";
  }

  print LOG $output;
  exit();
}
#    open(JAVALOADER, "|$javacmd") or confess ("Can't start java: $!");
## took out option -E $dtd ....

#    close JAVALOADER or
#	warn $! ? "Error closing java pipe: $!" : "Exit status $? from java";

}

close(LOG);

print "Please see $logfile for more details.\n";
