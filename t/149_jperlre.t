# This file is encoded in Latin-2.
die "This file is not encoded in Latin-2.\n" if q{‚ } ne "\x82\xa0";

print "1..1\n";

my $__FILE__ = __FILE__;

my $null = '/dev/null';
if ($^O =~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms) {
    $null = 'NUL';
}

my $script = __FILE__ . '.pl';
open(TEST,">$script") || die "Can't open file: $script\n";
print TEST <DATA>;
close(TEST);

if (system(qq{$^X $script 2>$null}) != 0) {
    print "ok - 1 $^X $__FILE__ die ('-' =~ /‚ [‚¢-‚ ]/).\n";
}
else {
    print "not ok - 1 $^X $__FILE__ die ('-' =~ /‚ [‚¢-‚ ]/).\n";
}

__END__
# This file is encoded in Latin-2.
die "This file is not encoded in Latin-2.\n" if q{‚ } ne "\x82\xa0";

use Char::Latin2;

'-' =~ /(‚ [‚¢-‚ ])/;

exit 0;
