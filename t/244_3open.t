# This file is encoded in Latin-2.
die "This file is not encoded in Latin-2.\n" if q{あ} ne "\x82\xa0";

# 引数 3 個に対応した関数 open() のテスト

my $__FILE__ = __FILE__;

use Char::Latin2;
print "1..34\n";

if ($^O eq 'MacOS') {
    for my $tno (1.. 34) {
        print "ok - $tno # SKIP $^X $0\n";
    }
    exit;
}

# 引数 0 個

eval q{ open(); };
if ($@) {
    print "ok - 1 eval q{ open(); } $^X $__FILE__\n";
}
else {
    print "not ok - 1 eval q{ open(); } $^X $__FILE__\n";
}

# 引数 1 個

$FILE = '>open.txt';
open(FILE);
print FILE "A" x 2;
close(FILE);

$FILE = 'open.txt';
open(FILE);
my $file = join('',<FILE>);
close(FILE);

if ($file eq ('A' x 2)) {
    print "ok - 2 open(FILE); $^X $__FILE__\n";
}
else {
    print "not ok - 2 open(FILE); $^X $__FILE__\n";
}

# 引数 2 個 ベアワード

open(FILE,'>open.txt');
print FILE "A" x 3;
close(FILE);

open(FILE,'open.txt');
$file = join('',<FILE>);
close(FILE);

if ($file eq ('A' x 3)) {
    print "ok - 3 open(FILE,'open.txt'); $^X $__FILE__\n";
}
else {
    print "not ok - 3 open(FILE,'open.txt'); $^X $__FILE__\n";
}

# 引数 2 個  未定義の値が格納された変数

open(my $fh3,'>open.txt');
print $fh3 "A" x 4;
close($fh3);

open(my $fh4,'open.txt');
$file = join('',<$fh4>);
close($fh4);

if ($file eq ('A' x 4)) {
    print "ok - 4 open(\$fh,'open.txt'); $^X $__FILE__\n";
}
else {
    print "not ok - 4 open(\$fh,'open.txt'); $^X $__FILE__\n";
}

# 引数 3 個 >, ベアワード

open(FILE,'>','open.txt');
print FILE "A" x 5;
close(FILE);

open(FILE,'open.txt');
$file = join('',<FILE>);
close(FILE);

if ($file eq ('A' x 5)) {
    print "ok - 5 open(FILE,'>','open.txt'); $^X $__FILE__\n";
}
else {
    print "not ok - 5 open(FILE,'>','open.txt'); $^X $__FILE__\n";
}

# 引数 3 個 >>, ベアワード

open(FILE,'>>','open.txt');
print FILE "A" x 6;
close(FILE);

open(FILE,'open.txt');
$file = join('',<FILE>);
close(FILE);

if ($file eq ('A' x (5+6))) {
    print "ok - 6 open(FILE,'>>','open.txt'); $^X $__FILE__\n";
}
else {
    print "not ok - 6 open(FILE,'>>','open.txt'); $^X $__FILE__\n";
}

# 引数 3 個 <, ベアワード

open(FILE,'<','open.txt');
$file = join('',<FILE>);
close(FILE);

if ($file eq ('A' x (5+6))) {
    print "ok - 7 open(FILE,'<','open.txt'); $^X $__FILE__\n";
}
else {
    print "not ok - 7 open(FILE,'<','open.txt'); $^X $__FILE__\n";
}

# 引数 3 個 >:crlf, ベアワード

if ($] =~ /^5\.006/) {
    print "ok - 8 # SKIP open(FILE,'>:crlf','open.txt'); $^X $__FILE__\n";
}
elsif (($] =~ /^5\.005/) and ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms)) {
    print "ok - 8 # SKIP open(FILE,'>:crlf','open.txt'); $^X $__FILE__\n";
}
else {
    open(FILE,'>:crlf','open.txt');
    print FILE "A" x 8;
    print FILE "\n";
    close(FILE);

    open(FILE,'open.txt');
    binmode(FILE);
    my $file = join('',<FILE>);
    close(FILE);

    if ($file eq ('A' x 8)."\r\n") {
        print "ok - 8 open(FILE,'>:crlf','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 8 open(FILE,'>:crlf','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 >>:crlf, ベアワード

if ($] =~ /^5\.006/) {
    print "ok - 9 # SKIP open(FILE,'>>:crlf','open.txt'); $^X $__FILE__\n";
}
elsif (($] =~ /^5\.005/) and ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms)) {
    print "ok - 9 # SKIP open(FILE,'>>:crlf','open.txt'); $^X $__FILE__\n";
}
else {
    open(FILE,'>>:crlf','open.txt');
    print FILE "A" x 9;
    print FILE "\n";
    close(FILE);

    open(FILE,'open.txt');
    binmode(FILE);
    my $file = join('',<FILE>);
    close(FILE);

    if ($file eq ('A' x 8)."\r\n".('A' x 9)."\r\n") {
        print "ok - 9 open(FILE,'>>:crlf','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 9 open(FILE,'>>:crlf','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 <:crlf, ベアワード

if ($] =~ /^5\.006/) {
    print "ok - 10 # SKIP open(FILE,'<:crlf','open.txt'); $^X $__FILE__\n";
}
elsif (($] =~ /^5\.005/) and ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms)) {
    print "ok - 10 # SKIP open(FILE,'<:crlf','open.txt'); $^X $__FILE__\n";
}
else {
    open(FILE,'<:crlf','open.txt');
    my $file = join('',<FILE>);
    close(FILE);

    if ($file eq ('A' x 8)."\n".('A' x 9)."\n") {
        print "ok - 10 open(FILE,'<:crlf','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 10 open(FILE,'<:crlf','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 >:encoding(latin2), ベアワード

if ($] =~ /^5\.006/) {
    print "ok - 11 # SKIP open(FILE,'>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
}
else {
    open(FILE,'>:encoding(latin2)','open.txt');
    print FILE "A" x 11;
    print FILE "\n";
    close(FILE);

    open(FILE,'open.txt');
    binmode(FILE);
    my $file = join('',<FILE>);
    close(FILE);

    if ($^O =~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms) {
        if ($file eq ('A' x 11)."\r\n") {
            print "ok - 11 open(FILE,'>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
        }
        else {
            print "not ok - 11 open(FILE,'>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
        }
    }
    else {
        if ($file eq ('A' x 11)."\n") {
            print "ok - 11 open(FILE,'>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
        }
        else {
            print "not ok - 11 open(FILE,'>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
        }
    }
}

# 引数 3 個 >>:encoding(latin2), ベアワード

if ($] =~ /^5\.006/) {
    print "ok - 12 # SKIP open(FILE,'>>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
}
else {
    open(FILE,'>>:encoding(latin2)','open.txt');
    print FILE "A" x 12;
    print FILE "\n";
    close(FILE);

    open(FILE,'open.txt');
    binmode(FILE);
    my $file = join('',<FILE>);
    close(FILE);

    if ($^O =~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms) {
        if ($file eq ('A' x 11)."\r\n".('A' x 12)."\r\n") {
            print "ok - 12 open(FILE,'>>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
        }
        else {
            print "not ok - 12 open(FILE,'>>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
        }
    }
    else {
        if ($file eq ('A' x 11)."\n".('A' x 12)."\n") {
            print "ok - 12 open(FILE,'>>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
        }
        else {
            print "not ok - 12 open(FILE,'>>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
        }
    }
}

# 引数 3 個 <:encoding(latin2), ベアワード

if ($] =~ /^5\.006/) {
    print "ok - 13 # SKIP open(FILE,'<:encoding(latin2)','open.txt'); $^X $__FILE__\n";
}
else {
    open(FILE,'<:encoding(latin2)','open.txt');
    my $file = join('',<FILE>);
    close(FILE);

    if ($file eq ('A' x 11)."\n".('A' x 12)."\n") {
        print "ok - 13 open(FILE,'<:encoding(latin2)','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 13 open(FILE,'<:encoding(latin2)','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 >:crlf:encoding(latin2), ベアワード

if ($] =~ /^5\.006/) {
    print "ok - 14 # SKIP open(FILE,'>:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
}
elsif (($] =~ /^5\.005/) and ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms)) {
    print "ok - 14 # SKIP open(FILE,'>:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
}
else {
    open(FILE,'>:crlf:encoding(latin2)','open.txt');
    print FILE "A" x 14;
    print FILE "\n";
    close(FILE);

    open(FILE,'open.txt');
    binmode(FILE);
    my $file = join('',<FILE>);
    close(FILE);

    if ($file eq ('A' x 14)."\r\n") {
        print "ok - 14 open(FILE,'>:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 14 open(FILE,'>:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 >>:crlf:encoding(latin2), ベアワード

if ($] =~ /^5\.006/) {
    print "ok - 15 # SKIP open(FILE,'>>:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
}
elsif (($] =~ /^5\.005/) and ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms)) {
    print "ok - 15 # SKIP open(FILE,'>>:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
}
else {
    open(FILE,'>>:crlf:encoding(latin2)','open.txt');
    print FILE "A" x 15;
    print FILE "\n";
    close(FILE);

    open(FILE,'open.txt');
    binmode(FILE);
    my $file = join('',<FILE>);
    close(FILE);

    if ($file eq ('A' x 14)."\r\n".('A' x 15)."\r\n") {
        print "ok - 15 open(FILE,'>>:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 15 open(FILE,'>>:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 <:crlf:encoding(latin2), ベアワード

if ($] =~ /^5\.006/) {
    print "ok - 16 # SKIP open(FILE,'<:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
}
elsif (($] =~ /^5\.005/) and ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms)) {
    print "ok - 16 # SKIP open(FILE,'<:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
}
else {
    open(FILE,'<:crlf:encoding(latin2)','open.txt');
    my $file = join('',<FILE>);
    close(FILE);

    if ($file eq ('A' x 14)."\n".('A' x 15)."\n") {
        print "ok - 16 open(FILE,'<:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 16 open(FILE,'<:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 >:raw, ベアワード

if ($] =~ /^5\.006/) {
    print "ok - 17 # SKIP open(FILE,'>:raw','open.txt'); $^X $__FILE__\n";
}
else {
    open(FILE,'>:raw','open.txt');
    print FILE "A" x 17;
    print FILE "\n";
    close(FILE);

    open(FILE,'open.txt');
    binmode(FILE);
    my $file = join('',<FILE>);
    close(FILE);

    if ($file eq ('A' x 17)."\n") {
        print "ok - 17 open(FILE,'>:raw','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 17 open(FILE,'>:raw','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 >>:raw, ベアワード

if ($] =~ /^5\.006/) {
    print "ok - 18 # SKIP open(FILE,'>>:raw','open.txt'); $^X $__FILE__\n";
}
else {
    open(FILE,'>>:raw','open.txt');
    print FILE "A" x 18;
    print FILE "\n";
    close(FILE);

    open(FILE,'open.txt');
    binmode(FILE);
    my $file = join('',<FILE>);
    close(FILE);

    if ($file eq ('A' x 17)."\n".('A' x 18)."\n") {
        print "ok - 18 open(FILE,'>>:raw','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 18 open(FILE,'>>:raw','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 <:raw, ベアワード

if ($] =~ /^5\.006/) {
    print "ok - 19 # SKIP open(FILE,'<:raw','open.txt'); $^X $__FILE__\n";
}
else {
    open(FILE,'<:raw','open.txt');
    my $file = join('',<FILE>);
    close(FILE);

    if ($file eq ('A' x 17)."\n".('A' x 18)."\n") {
        print "ok - 19 open(FILE,'<:raw','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 19 open(FILE,'<:raw','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 >, 未定義の値が格納された変数

if ($] =~ /^5\.006/) {
    print "ok - 20 # SKIP open(my \$fh,'>','open.txt'); $^X $__FILE__\n";
}
else {
    open(my $fh,'>','open.txt');
    print $fh "A" x 20;
    close($fh);

    open(my $fh2,'open.txt');
    my $file = join('',<$fh2>);
    close($fh2);

    if ($file eq ('A' x 20)) {
        print "ok - 20 open(my \$fh,'>','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 20 open(my \$fh,'>','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 >>, 未定義の値が格納された変数

if ($] =~ /^5\.006/) {
    print "ok - 21 # SKIP open(my \$fh,'>>','open.txt'); $^X $__FILE__\n";
}
else {
    open(my $fh,'>>','open.txt');
    print $fh "A" x 21;
    close($fh);

    open(my $fh2,'open.txt');
    my $file = join('',<$fh2>);
    close($fh2);

    if ($file eq ('A' x (20+21))) {
        print "ok - 21 open(my \$fh,'>>','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 21 open(my \$fh,'>>','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 <, 未定義の値が格納された変数

if ($] =~ /^5\.006/) {
    print "ok - 22 # SKIP open(my \$fh,'<','open.txt'); $^X $__FILE__\n";
}
else {
    open(my $fh,'<','open.txt');
    my $file = join('',<$fh>);
    close($fh);

    if ($file eq ('A' x (20+21))) {
        print "ok - 22 open(my \$fh,'<','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 22 open(my \$fh,'<','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 >:crlf, 未定義の値が格納された変数

if ($] =~ /^5\.006/) {
    print "ok - 23 # SKIP open(my \$fh,'>:crlf','open.txt'); $^X $__FILE__\n";
}
elsif (($] =~ /^5\.005/) and ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms)) {
    print "ok - 23 # SKIP open(my \$fh,'>:crlf','open.txt'); $^X $__FILE__\n";
}
else {
    open(my $fh,'>:crlf','open.txt');
    print $fh "A" x 23;
    print $fh "\n";
    close($fh);

    open(my $fh2,'open.txt');
    binmode($fh2);
    my $file = join('',<$fh2>);
    close($fh2);

    if ($file eq ('A' x 23)."\r\n") {
        print "ok - 23 open(my \$fh,'>:crlf','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 23 open(my \$fh,'>:crlf','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 >>:crlf, 未定義の値が格納された変数

if ($] =~ /^5\.006/) {
    print "ok - 24 # SKIP open(my \$fh,'>>:crlf','open.txt'); $^X $__FILE__\n";
}
elsif (($] =~ /^5\.005/) and ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms)) {
    print "ok - 24 # SKIP open(my \$fh,'>>:crlf','open.txt'); $^X $__FILE__\n";
}
else {
    open(my $fh,'>>:crlf','open.txt');
    print $fh "A" x 24;
    print $fh "\n";
    close($fh);

    open(my $fh2,'open.txt');
    binmode($fh2);
    my $file = join('',<$fh2>);
    close($fh2);

    if ($file eq ('A' x 23)."\r\n".('A' x 24)."\r\n") {
        print "ok - 24 open(my \$fh,'>>:crlf','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 24 open(my \$fh,'>>:crlf','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 <:crlf, 未定義の値が格納された変数

if ($] =~ /^5\.006/) {
    print "ok - 25 # SKIP open(my \$fh,'<:crlf','open.txt'); $^X $__FILE__\n";
}
elsif (($] =~ /^5\.005/) and ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms)) {
    print "ok - 25 # SKIP open(my \$fh,'<:crlf','open.txt'); $^X $__FILE__\n";
}
else {
    open(my $fh,'<:crlf','open.txt');
    my $file = join('',<$fh>);
    close($fh);

    if ($file eq ('A' x 23)."\n".('A' x 24)."\n") {
        print "ok - 25 open(my \$fh,'<:crlf','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 25 open(my \$fh,'<:crlf','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 >:encoding(latin2), 未定義の値が格納された変数

if ($] =~ /^5\.006/) {
    print "ok - 26 # SKIP open(my \$fh,'>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
}
else {
    open(my $fh,'>:encoding(latin2)','open.txt');
    print $fh "A" x 26;
    print $fh "\n";
    close($fh);

    open(my $fh2,'open.txt');
    binmode($fh2);
    my $file = join('',<$fh2>);
    close($fh2);

    if ($^O =~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms) {
        if ($file eq ('A' x 26)."\r\n") {
            print "ok - 26 open(my \$fh,'>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
        }
        else {
            print "not ok - 26 open(my \$fh,'>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
        }
    }
    else {
        if ($file eq ('A' x 26)."\n") {
            print "ok - 26 open(my \$fh,'>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
        }
        else {
            print "not ok - 26 open(my \$fh,'>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
        }
    }
}

# 引数 3 個 >>:encoding(latin2), 未定義の値が格納された変数

if ($] =~ /^5\.006/) {
    print "ok - 27 # SKIP open(my \$fh,'>>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
}
else {
    open(my $fh,'>>:encoding(latin2)','open.txt');
    print $fh "A" x 27;
    print $fh "\n";
    close($fh);

    open(my $fh2,'open.txt');
    binmode($fh2);
    my $file = join('',<$fh2>);
    close($fh2);

    if ($^O =~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms) {
        if ($file eq ('A' x 26)."\r\n".('A' x 27)."\r\n") {
            print "ok - 27 open(my \$fh,'>>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
        }
        else {
            print "not ok - 27 open(my \$fh,'>>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
        }
    }
    else {
        if ($file eq ('A' x 26)."\n".('A' x 27)."\n") {
            print "ok - 27 open(my \$fh,'>>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
        }
        else {
            print "not ok - 27 open(my \$fh,'>>:encoding(latin2)','open.txt'); $^X $__FILE__\n";
        }
    }
}

# 引数 3 個 <:encoding(latin2), 未定義の値が格納された変数

if ($] =~ /^5\.006/) {
    print "ok - 28 # SKIP open(my \$fh,'<:encoding(latin2)','open.txt'); $^X $__FILE__\n";
}
else {
    open(my $fh,'<:encoding(latin2)','open.txt');
    my $file = join('',<$fh>);
    close($fh);

    if ($file eq ('A' x 26)."\n".('A' x 27)."\n") {
        print "ok - 28 open(my \$fh,'<:encoding(latin2)','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 28 open(my \$fh,'<:encoding(latin2)','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 >:crlf:encoding(latin2), 未定義の値が格納された変数

if ($] =~ /^5\.006/) {
    print "ok - 29 # SKIP open(my \$fh,'>:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
}
elsif (($] =~ /^5\.005/) and ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms)) {
    print "ok - 29 # SKIP open(my \$fh,'>:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
}
else {
    open(my $fh,'>:crlf:encoding(latin2)','open.txt');
    print $fh "A" x 29;
    print $fh "\n";
    close($fh);

    open(my $fh2,'open.txt');
    binmode($fh2);
    my $file = join('',<$fh2>);
    close($fh2);

    if ($file eq ('A' x 29)."\r\n") {
        print "ok - 29 open(my \$fh,'>:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 29 open(my \$fh,'>:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 >>:crlf:encoding(latin2), 未定義の値が格納された変数

if ($] =~ /^5\.006/) {
    print "ok - 30 # SKIP open(my \$fh,'>>:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
}
elsif (($] =~ /^5\.005/) and ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms)) {
    print "ok - 30 # SKIP open(my \$fh,'>>:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
}
else {
    open(my $fh,'>>:crlf:encoding(latin2)','open.txt');
    print $fh "A" x 30;
    print $fh "\n";
    close($fh);

    open(my $fh2,'open.txt');
    binmode($fh2);
    my $file = join('',<$fh2>);
    close($fh2);

    if ($file eq ('A' x 29)."\r\n".('A' x 30)."\r\n") {
        print "ok - 30 open(my \$fh,'>>:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 30 open(my \$fh,'>>:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 <:crlf:encoding(latin2), 未定義の値が格納された変数

if ($] =~ /^5\.006/) {
    print "ok - 31 # SKIP open(my \$fh,'<:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
}
elsif (($] =~ /^5\.005/) and ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms)) {
    print "ok - 31 # SKIP open(my \$fh,'<:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
}
else {
    open(my $fh,'<:crlf:encoding(latin2)','open.txt');
    my $file = join('',<$fh>);
    close($fh);

    if ($file eq ('A' x 29)."\n".('A' x 30)."\n") {
        print "ok - 31 open(my \$fh,'<:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 31 open(my \$fh,'<:crlf:encoding(latin2)','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 >:raw, 未定義の値が格納された変数

if ($] =~ /^5\.006/) {
    print "ok - 32 # SKIP open(my \$fh,'>:raw','open.txt'); $^X $__FILE__\n";
}
else {
    open(my $fh,'>:raw','open.txt');
    print $fh "A" x 32;
    print $fh "\n";
    close($fh);

    open(my $fh2,'open.txt');
    binmode($fh2);
    my $file = join('',<$fh2>);
    close($fh2);

    if ($file eq ('A' x 32)."\n") {
        print "ok - 32 open(my \$fh,'>:raw','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 32 open(my \$fh,'>:raw','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 >>:raw, 未定義の値が格納された変数

if ($] =~ /^5\.006/) {
    print "ok - 33 # SKIP open(my \$fh,'>>:raw','open.txt'); $^X $__FILE__\n";
}
else {
    open(my $fh,'>>:raw','open.txt');
    print $fh "A" x 33;
    print $fh "\n";
    close($fh);

    open(my $fh2,'open.txt');
    binmode($fh2);
    my $file = join('',<$fh2>);
    close($fh2);

    if ($file eq ('A' x 32)."\n".('A' x 33)."\n") {
        print "ok - 33 open(my \$fh,'>>:raw','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 33 open(my \$fh,'>>:raw','open.txt'); $^X $__FILE__\n";
    }
}

# 引数 3 個 <:raw, 未定義の値が格納された変数

if ($] =~ /^5\.006/) {
    print "ok - 34 # SKIP open(my \$fh,'<:raw','open.txt'); $^X $__FILE__\n";
}
else {
    open(my $fh,'<:raw','open.txt');
    my $file = join('',<$fh>);
    close($fh);

    if ($file eq ('A' x 32)."\n".('A' x 33)."\n") {
        print "ok - 34 open(my \$fh,'<:raw','open.txt'); $^X $__FILE__\n";
    }
    else {
        print "not ok - 34 open(my \$fh,'<:raw','open.txt'); $^X $__FILE__\n";
    }
}

END {
    unlink 'open.txt';
}

__END__

