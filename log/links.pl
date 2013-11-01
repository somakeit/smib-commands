#!/usr/bin/perl

use strict;
use warnings;

use IPC::System::Simple qw(capture);

my $line = $ARGV[3];

if ($line =~ /(http:\S+)/ or
    $line =~ /(https:\S+)/ or
    $line =~ /(\S+\.com)/ or
    $line =~ /(\S+\.org)/ or
    $line =~ /(\S+\.net)/ or
    $line =~ /(\S+\.edu)/ or
    $line =~ /(\S+\.gov)/ or
    $line =~ /(\S+\.tv)/ or
    $line =~ /(\S+\.it)/ or
    $line =~ /(\S+\.ac\.uk)/ or
    $line =~ /(\S+\.co\.uk)/ or
    $line =~ /(\S+\.gov\.uk)/ or
    $line =~ /(\S+\.org\.uk)/ or
    $line =~ /(\S+\.sch\.uk)/) {
  
  my $url = $1;

  #Fork here to time out if wget takes too long,
  #I see this preventing people making smib
  # download large files.
  my $childpid = fork(); 
  if (!$childpid) {
    #this is the child
    sleep 10;
    my $parentpid = getppid;
    kill 9, $parentpid;
    exit 1;
  }

  #wget will only follow 20 redirects.
  #capture will die if wget returns non 0 status,
  #for example, if the url is not valid.
  my @page = capture('/usr/bin/wget', '-qO-', $url);

  #stop the timout
  kill 9, $childpid;

  foreach (@page) {
    if ($_ =~ /<title>(.+)<\/title>/) {
      my $title = $1;

      #get a tinyurl to please the weechat users,
      #tinyurl API wants a http/s on the front of everything
      if ($url !~ /^https?:\/\//) {
        $url = "http://$url";
      }
      my @tinyurl = capture('/usr/bin/wget', '-qO-', "http://tinyurl.com/api-create.php?url=$url");

      #limit to 32 character titles
      $title = substr($title, 0, 32);

      print "$tinyurl[0] - $title\n";

      exit 0;
    }
  }
}
