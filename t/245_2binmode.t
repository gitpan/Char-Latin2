# This file is encoded in Latin-2.
die "This file is not encoded in Latin-2.\n" if q{あ} ne "\x82\xa0";

# 引数 2 個に対応した関数 binmode() のテスト

my $__FILE__ = __FILE__;

use Char::Latin2;
print "1..10\n";

if ($^O eq 'MacOS') {
    for my $tno (1.. 10) {
        print "ok - $tno # SKIP $^X $0\n";
    }
    exit;
}

# 引数 0 個

eval q{ binmode(); };
if ($@) {
    print "ok - 1 eval q{ binmode(); } $^X $__FILE__\n";
}
else {
    print "not ok - 1 eval q{ binmode(); } $^X $__FILE__\n";
}

# 引数 1 個 ベアワード

open(FILE,'>binmode.txt');
binmode(FILE);
print FILE "\n" x 2;
close(FILE);

if (-s 'binmode.txt' == 2) {
    print "ok - 2 binmode(FILE); $^X $__FILE__\n";
}
else {
    print "not ok - 2 binmode(FILE); $^X $__FILE__\n";
}

# 引数 1 個 ファイルハンドルが格納された変数

open(my $fh,'>binmode.txt');
binmode($fh);
print $fh "\n" x 3;
close($fh);

if (-s 'binmode.txt' == 3) {
    print "ok - 3 binmode(\$fh); $^X $__FILE__\n";
}
else {
    print "not ok - 3 binmode(\$fh); $^X $__FILE__\n";
}

# 引数 2 個 :raw, ベアワード

open(FILE,'>binmode.txt');
binmode(FILE,':raw');
print FILE "\n" x 4;
close(FILE);

if (-s 'binmode.txt' == 4) {
    print "ok - 4 binmode(FILE,':raw'); $^X $__FILE__\n";
}
else {
    print "not ok - 4 binmode(FILE,':raw'); $^X $__FILE__\n";
}

# 引数 2 個 :raw, ファイルハンドルが格納された変数

open(my $fh2,'>binmode.txt');
binmode($fh2,':raw');
print $fh2 "\n" x 5;
close($fh2);

if (-s 'binmode.txt' == 5) {
    print "ok - 5 binmode(\$fh,':raw'); $^X $__FILE__\n";
}
else {
    print "not ok - 5 binmode(\$fh,':raw'); $^X $__FILE__\n";
}

# 引数 2 個 :crlf, ベアワード

if ($] =~ /^5\.006/) {
    print "ok - 6 # SKIP binmode(FILE,':crlf'); $^X $__FILE__ ($^O)\n";
}
elsif (($] =~ /^5\.005/) and ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms)) {
    print "ok - 6 # SKIP binmode(FILE,':crlf'); $^X $__FILE__ ($^O)\n";
}
else {
    open(FILE,'>binmode.txt');
    binmode(FILE,':crlf');
    print FILE "\n" x 6;
    close(FILE);

    if (-s 'binmode.txt' == 6*2) {
        print "ok - 6 binmode(FILE,':crlf'); $^X $__FILE__ ($^O)\n";
    }
    else {
        print "not ok - 6 binmode(FILE,':crlf'); $^X $__FILE__ ($^O)\n";
    }
}

# 引数 2 個 :crlf, ファイルハンドルが格納された変数

if ($] =~ /^5\.006/) {
    print "ok - 7 # SKIP binmode(\$fh,':crlf'); $^X $__FILE__ ($^O)\n";
}
elsif (($] =~ /^5\.005/) and ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms)) {
    print "ok - 7 # SKIP binmode(\$fh,':crlf'); $^X $__FILE__ ($^O)\n";
}
else {
    open(my $fh,'>binmode.txt');
    binmode($fh,':crlf');
    print $fh "\n" x 7;
    close($fh);

    if (-s 'binmode.txt' == 7*2) {
        print "ok - 7 binmode(\$fh,':crlf'); $^X $__FILE__ ($^O)\n";
    }
    else {
        print "not ok - 7 binmode(\$fh,':crlf'); $^X $__FILE__ ($^O)\n";
    }
}

# 引数 2 個 :unknownmode, ベアワード

if ($] =~ /^5\.006/) {
    print "ok - 8 # SKIP eval q{ binmode(FILE,':unknownmode'); } $^X $__FILE__\n";
}
else {
    eval q{
        open(FILE,'>binmode.txt');
        binmode(FILE,':unknownmode');
        print FILE "\n" x 8;
        close(FILE);
    };
    if (not $@) {
        print "ok - 8 eval q{ binmode(FILE,':unknownmode'); } $^X $__FILE__\n";
    }
    else {
        print "not ok - 8 eval q{ binmode(FILE,':unknownmode'); } $^X $__FILE__\n";
    }
}

# 引数 2 個 :unknownmode, ファイルハンドルが格納された変数

if ($] =~ /^5\.006/) {
    print "ok - 9 # SKIP eval q{ binmode(\$fh,':unknownmode'); } $^X $__FILE__\n";
}
else {
    eval q{
        open(my $fh,'>binmode.txt');
        binmode($fh,':unknownmode');
        print $fh "\n" x 9;
        close($fh);
    };
    if (not $@) {
        print "ok - 9 eval q{ binmode(\$fh,':unknownmode'); } $^X $__FILE__\n";
    }
    else {
        print "not ok - 9 eval q{ binmode(\$fh,':unknownmode'); } $^X $__FILE__\n";
    }
}

# 引数 3 個 :raw, ベアワード, その他

eval q{
    open(FILE,'>binmode.txt');
    binmode(FILE,':raw',1);
    print FILE "\n" x 10;
    close(FILE);
};
if ($@) {
    print "ok - 10 eval q{ binmode(FILE,':raw',1); } $^X $__FILE__\n";
}
else {
    print "not ok - 10 eval q{ binmode(FILE,':raw',1); } $^X $__FILE__\n";
}

END {
    unlink 'binmode.txt';
}

__END__

