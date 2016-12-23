#!/usr/bin/perl
#TODO: 
#(/) XML komplett aufgedroeselt ausgeben
#(b) Verzeichnis ueberwachen (inotify)  http://www.perlmonks.org/?node_id=742728 
#
#perl -MXML::Simple -MDumpvalue -E
use 5.012;
use XML::Simple;
use Data::Dumper;

my $jrExport=XMLin("/mnt/brennerpublic/JobRouter2Confluence/text.xml") ;#,NormalizeSpace=>2);
my $toConfHtml='<html><head></head><body>';
my $toConfHtmlEnd='</body></html>';

$Data::Dumper::Terse=1;
$Data::Dumper::Indent=1;
$Data::Dumper::Pair=":";
#say Dumper(keys %{$jrExport}); # just print main keys 'PROCESSDATA';'SUBDATA'; 'PROCESSDETAILS'

for my $i (sort keys %{$jrExport}){ 
	$toConfHtml .= "<h1>$i</h1>";
	$toConfHtml .= "<p>";
	$toConfHtml .= getXmlSubkey($i);
	$toConfHtml .= "</p>";
}

# fuer jeden unterpunkt der xml-date (processdetails, subtable, processdata) soll eine ueberschrift in Confluence erstellt werden
# also pro xml-bereich die daten auslesen und mit etwas html drumherum in eine Datei exportieren
sub getXmlSubkey {
	my $xmlKey=shift;
	$Data::Dumper::Sortkeys;

	#my $myDump=$Data::Dumper->Dump(${$jrExport}{$xmlKey}); #${$jrExport->'SUBDATA'});
	#print $myDump;
	print Dumper(${$jrExport}{'SUBDATA'});
#	print Dumper(%{$$jrExport{$xmlKey}});

=for comment
	my $expTxt=Dumper(keys %{$jrExport});
	print $expTxt;

	print Dumper(${$jrExport->'SUBDATA'});

	open my $fh,'<',\$expTxt;
	open my $out,'>','/mnt/tmp01/temp/some.html' or die "someDebug: $!";
	$/='';
	while (<$fh>){
		$_=~s/\n\s+'value\'\s=>\s(\'.*?\').*?\n\s+?/$1/smg;
		print $out $_ ;

	}
=cut
}
#$expTxt =~ tr/ //s;
#$expTxt=~ s/^[\s\xA0\t]?\'value\'\s=>\s//g;
#$expTxt=~s/(^.*)(value)(.*$)/$3/g;

#print $expTxt =~ /^/;
#$expTxt=~ s/\s+.*value.*\n$/-----/g;

#print $expTxt.'123';
#print "__$\ __ $/__";

#=for comment
#sub list{
#	my $key=shift;
#	foreach my $i ( Dumper(keys $key)){	; #->{SUBDATA}});
#		say $i;
#		list($i);
#
#	}
#}
#my $jrData=%{$jrExport};
#list($jrData);
