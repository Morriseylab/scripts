#!/usr/bin/perl -w
#version 1.0
use Getopt::Long;
#parameter file name as commandline argument


my $dir;

usage() if ( @ARGV < 1 or
          ! GetOptions('dir=s' => \$dir, )
		);
 
sub usage
{
  print "Unknown option: @_\n" if ( @_ );
  print "usage: program [--dir STAR directory  ]\n";
  exit;
}


my @headers;
my @matrix;

while (defined(my $file = glob "$dir/*Log.final.out")) {
	my @data;	
	open my $fh, "<", $file or die;
	$file =~ s/Log.final.out//ig;
	push(@data,($file));
	undef @header;
	while(<$fh>){
		chomp;
		s/\s+|,|%//g;
		my @r = split('\|');
		next unless(@r ==2);
		push(@data,$r[1]);
		push(@header,$r[0]);
	}
	push(@matrix,\@data);
	close $fh;
}


print join(',',('library',@header)),"\n";

foreach (@matrix){
	print join(',',@{$_}),"\n";

}

