#!/usr/bin/perl

use bytes;

my $data;

#prevents us from repeating messages
my $waitingflag = 0;

#arguments /dev/hidraw3
my $device = $ARGV[0];
#print $device + "\n";
unless (defined($device)) {
        die "Usage: <app> /dev/hidrawN";
        exit; 
}

while (1) {

    #$data = `/bin/cat $device | /usr/bin/head -c 7`;
    $data = `/usr/bin/head -c 7 $device`;

    my $report = ord(substr($data, 1, 1));
    my $status = ord(substr($data, 2, 1));
    my $unit   = ord(substr($data, 3, 1));
    my $exp    = ord(substr($data, 4, 1));
    my $lsb    = ord(substr($data, 5, 1));
    my $msb    = ord(substr($data, 6, 1));
#my $report = ord(substr($data, 0, 1));
#my $status = ord(substr($data, 1, 1));
#my $unit   = ord(substr($data, 2, 1));
#my $exp    = ord(substr($data, 3, 1));
#my $lsb    = ord(substr($data, 4, 1));
#my $msb    = ord(substr($data, 5, 1));

    my $weight = ($msb * 256 + $lsb) / 10;
    if($exp != 255 && $exp != 0) {
        $weight ^= $exp;
    }
    #print "$report $status $unit $exp $weight\n";

    if($report != 0x03) {
      die "Error reading scale data!\n";
    }

    if($status == 0x01) {
      die "Scale reports FAULT!\n";
    } elsif ($status == 0x02 || $weight == 0) {
        if($waitingflag != 0x02) {
            print "0\n";
            $waitingflag = 0x02;
        last;
        }
    } elsif ($status == 0x03) {
        if($waitingflag != 0x03) {
            print "Weighing...\n";
            $waitingflag = 0x03;
        }
    } elsif ($status == 0x04) {
        my $unitName = "units";
        if($unit == 11) {
            $unitName = "ounces";
        } elsif ($unit == 12) {
            $unitName = "pounds";
            print "ERR!"
        }
        #print "$weight $unitName \n";
        #print 28.3495231*$weight;
        print 28.35*$weight;
        #printf "%.2f", 28.3495231*$weight;
        print "\n";

        last;
    } elsif ($status == 0x05) {
        if($waitingflag != 0x05) {
            #print "Scale reports Under Zero...\n";
            print "-1\n";
            $waitingflag = 0x05;
        last;
        }
    } elsif ($status == 0x06) {
        if($waitingflag != 0x06) {
                #over weight
            print "OW\n";
            $waitingflag = 0x06;
        last;
        }
    } elsif ($status == 0x07) {
        if($waitingflag != 0x07) {
            print "Scale reports Calibration Needed!\n";
            $waitingflag = 0x07;
        last;
        }
    } elsif ($status == 0x08) {
        if($waitingflag != 0x08) {
            print "Scale reports Re-zeroing Needed!\n";
            $waitingflag = 0x08;
        last;
        }
    } else {
        die "Unknown status code: $status\n";
    }
}

