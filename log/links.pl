#!/usr/bin/perl

use strict;
use warnings;

use IPC::System::Simple qw(capture);

my $line = $ARGV[3];

if ($line =~ /(http:\S+)/ or
    $line =~ /(https:\S+)/ or
    $line =~ /(\S+\.com\S*)/ or
    $line =~ /(\S+\.org\S*)/ or
    $line =~ /(\S+\.net\S*)/ or
    $line =~ /(\S+\.edu\S*)/ or
    $line =~ /(\S+\.gov\S*)/ or
    $line =~ /(\S+\.tv\S*)/ or
    $line =~ /(\S+\.it\S*)/ or
    $line =~ /(\S+\.ac\.uk\S*)/ or
    $line =~ /(\S+\.co\.uk\S*)/ or
    $line =~ /(\S+\.gov\.uk\S*)/ or
    $line =~ /(\S+\.org\.uk\S*)/ or
    $line =~ /(\S+\.sch\.uk\S*)/) {
  
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

  #not all <title> tags are on the same line
  chomp @page;
  my $wholepage = join('', @page);
  if ($wholepage =~ /<title>(.+)<\/title>/) {
    my $title = $1;

    #get a tinyurl to please the weechat users,
    #tinyurl API wants a http/s on the front of everything
    if ($url !~ /^https?:\/\//) {
      $url = "http://$url";
    }
    my @tinyurl = capture('/usr/bin/wget', '-qO-', "http://tinyurl.com/api-create.php?url=$url");

    #limit title length ansd strip naughty characters
    $title =~ s/[\t\n\r\f\a\e]//g;
    $title = substr($title, 0, 56);

    print "$tinyurl[0] - $title\n";

    exit 0;
  }
}
