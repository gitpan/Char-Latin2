# This file is encoded in Latin-2.
die "This file is not encoded in Latin-2.\n" if q{��} ne "\x82\xa0";

use Char::Latin2;
print "1..1\n";

my $__FILE__ = __FILE__;

# s///m
$a = "ABCDEFG\nHIJKLMNOPQRSTUVWXYZ";
if ($a =~ s/^HI/������/m) {
    if ($a eq "ABCDEFG\n������JKLMNOPQRSTUVWXYZ") {
        print qq{ok - 1 \$a =~ s/^HI/������/m ($a) $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 1 \$a =~ s/^HI/������/m ($a) $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 1 \$a =~ s/^HI/������/m ($a) $^X $__FILE__\n};
}

__END__