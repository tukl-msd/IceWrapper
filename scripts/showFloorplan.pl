#!/usr/bin/perl -w
use strict;
use warnings;
use SVG;

my $file   = shift || die("Please specify fpl file!");
my $height = shift || die("Please specify height!");
my $width  = shift || die("Please specify width!");
my $zoom   = shift || die("Please specify the zoom factor!");


# Extract Filename:
unless($file =~ /(.+)\.flp/)
{
    die("Please provide a fpl filetype");
}
my $outfile = $1;

open(FH, $file);

my $height_zoom = $height/$zoom;
my $svg = SVG->new(width => $width/$zoom, height => $height/$zoom);

my $name ="";
my $x = 0;
my $y = 0;
my $w = 0;
my $h = 0;

my $rect_begin = 0;

while(<FH>)
{
    my $line = $_;
    

    if($line =~ /^(.+)\s*:\s*\n$/)
    {
        $name = $1;
    }
    elsif($line =~ /position\s*(\d+),\s*(\d+)\s*;/)
    {
        $x = $1;
        $y = $2;
    }
    elsif($line =~ /dimension\s*(\d+),\s*(\d+)\s*;/)
    {
        $w = $1;
        $h = $2;

        $y = $height - $y -$h;

        $x = $x / $zoom;
        $y = $y / $zoom;
        $w = $w / $zoom;
        $h = $h / $zoom;

        $svg->rectangle(
            x => $x,
            y => $y,
            width => $w,
            height => $h,
            style => {
                'fill' => 'rgb(128, 128, 128)',
                'stroke' => 'black',
                'stroke-width' => 1,
                'stroke-opacity' => 1,
                'fill-opacity' => 0.5,
            },
        );

        my $textx = $x + $w/2;
        my $texty = $y + $h/2;

        $svg->text(
            #id=>$name,
            x => $textx,
            y => $texty,
            "text-anchor"=>"middle",
            "alignment-baseline"=>"middle",
        )->cdata($name);
    }
    elsif($line =~ /rectangle\s*\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)\s*;/)
    {
        $rect_begin++;

        my $x1 = $1;
        my $y1 = $2;
        my $x2 = $3;
        my $y2 = $4;

        $x = $x1;
        $y = $y1;
        $w = $x2-$x1;
        $h = $y2-$y1;

        $y = $height - $y -$h;

        $x = $x / $zoom;
        $y = $y / $zoom;
        $w = $w / $zoom;
        $h = $h / $zoom;

        $svg->rectangle(
            x => $x,
            y => $y,
            width => $w,
            height => $h,
            style => {
                'fill' => 'rgb(128, 128, 128)',
                'stroke' => 'black',
                'stroke-width' => 1,
                'stroke-opacity' => 0.5,
                'fill-opacity' => 0.5,
            },
        );
    }
    else
    {
        if($rect_begin != 0)
        {
            my $textx = $x + $w/2;
            my $texty = $y + $h/2;

            $svg->text(
                #    id=>"rect_".$name,
                x => $textx,
                y => $texty,
                "text-anchor"=>"middle",
                "alignment-baseline"=>"middle",
            )->cdata($name);
            $rect_begin = 0;
        }
    }
}



# convert into svg
open my $out, '>', "$outfile.svg" or die;
print $out $svg->xmlify;

# convert to pdf
system("inkscape $outfile.svg --export-pdf=$outfile.pdf");

