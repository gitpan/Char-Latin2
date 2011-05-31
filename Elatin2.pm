package Elatin2;
######################################################################
#
# Elatin2 - Run-time routines for Latin2.pm
#
# Copyright (c) 2008, 2009, 2010, 2011 INABA Hitoshi <ina@cpan.org>
#
######################################################################

use 5.00503;
use strict qw(subs vars);

# 12.3. Delaying use Until Runtime
# in Chapter 12. Packages, Libraries, and Modules
# of ISBN 0-596-00313-7 Perl Cookbook, 2nd Edition.
# (and so on)

BEGIN { eval q{ use vars qw($VERSION) } }
$VERSION = sprintf '%d.%02d', q$Revision: 0.74 $ =~ m/(\d+)/xmsg;

BEGIN {
    my $PERL5LIB = __FILE__;

    # DOS-like system
    if ($^O =~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms) {
        $PERL5LIB =~ s{[^/]*$}{Latin2};
    }

    # UNIX-like system
    else {
        $PERL5LIB =~ s{[^/]*$}{Latin2};
    }

    my @inc = ();
    my %inc = ();
    for my $path ($PERL5LIB, @INC) {
        if (not exists $inc{$path}) {
            push @inc, $path;
            $inc{$path} = 1;
        }
    }
    @INC = @inc;
}

BEGIN {

    # instead of utf8.pm
    eval q{
        no warnings qw(redefine);
        *utf8::upgrade   = sub { CORE::length $_[0] };
        *utf8::downgrade = sub { 1 };
        *utf8::encode    = sub {   };
        *utf8::decode    = sub { 1 };
        *utf8::is_utf8   = sub {   };
        *utf8::valid     = sub { 1 };
    };
    if ($@) {
        *utf8::upgrade   = sub { CORE::length $_[0] };
        *utf8::downgrade = sub { 1 };
        *utf8::encode    = sub {   };
        *utf8::decode    = sub { 1 };
        *utf8::is_utf8   = sub {   };
        *utf8::valid     = sub { 1 };
    }

    # 7.6. Writing a Subroutine That Takes Filehandles as Built-ins Do
    # in Chapter 7. File Access
    # of ISBN 0-596-00313-7 Perl Cookbook, 2nd Edition.

    sub Elatin2::binmode(*;$);
    sub Elatin2::open(*;$@);

    if ($] < 5.006) {

        # 12.13. Overriding a Built-in Function in All Packages
        # in Chapter 12. Packages, Libraries, and Modules
        # of ISBN 0-596-00313-7 Perl Cookbook, 2nd Edition.

        # avoid warning: Name "CORE::GLOBAL::binmode" used only once: possible typo at ...
        if ($^O ne 'MacOS') {
            *CORE::GLOBAL::binmode =
            *CORE::GLOBAL::binmode = \&Elatin2::binmode;
        }
        *CORE::GLOBAL::open    =
        *CORE::GLOBAL::open    = \&Elatin2::open;
    }
}

# poor Symbol.pm - substitute of real Symbol.pm
BEGIN {
    my $genpkg = "Symbol::";
    my $genseq = 0;

    sub gensym () {
        my $name = "GEN" . $genseq++;
        my $ref = \*{$genpkg . $name};
        delete $$genpkg{$name};
        $ref;
    }

    sub qualify ($;$) {
        my ($name) = @_;
        if (!ref($name) && (Elatin2::index($name, '::') == -1) && (Elatin2::index($name, "'") == -1)) {
            my $pkg;
            my %global = map {$_ => 1} qw(ARGV ARGVOUT ENV INC SIG STDERR STDIN STDOUT);

            # Global names: special character, "^xyz", or other.
            if ($name =~ /^(([^a-z])|(\^[a-z_]+))\z/i || $global{$name}) {
                # RGS 2001-11-05 : translate leading ^X to control-char
                $name =~ s/^\^([a-z_])/'qq(\c'.$1.')'/eei;
                $pkg = "main";
            }
            else {
                $pkg = (@_ > 1) ? $_[1] : caller;
            }
            $name = $pkg . "::" . $name;
        }
        $name;
    }

    sub qualify_to_ref ($;$) {
        no strict qw(refs);
        return \*{ qualify $_[0], @_ > 1 ? $_[1] : caller };
    }
}

# P.714 29.2.39. flock
# in Chapter 29: Functions
# of ISBN 0-596-00027-8 Programming Perl Third Edition.

sub LOCK_SH() {1}
sub LOCK_EX() {2}
sub LOCK_UN() {8}
sub LOCK_NB() {4}

# instead of Carp.pm
sub carp(@);
sub croak(@);
sub cluck(@);
sub confess(@);

my $__FILE__ = __FILE__;

BEGIN {
    if ($^X =~ m/ jperl /oxmsi) {
        die "$0 need perl(not jperl) 5.00503 or later. (\$^X==$^X)";
    }
}

my $your_char = q{[\x00-\xFF]};

# regexp of character
my $q_char = qr/$your_char/oxms;

#
# Latin-2 character range per length
#
my %range_tr = ();
my $is_shiftjis_family = 0;
my $is_eucjp_family    = 0;

#
# alias of encoding name
#

BEGIN { eval q{ use vars qw($encoding_alias) } }

if (0) {
}

# US-ASCII
elsif (__PACKAGE__ =~ m/ \b Eusascii \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: (?:US-?)?ASCII ) \b /oxmsi;
}

# Latin-1
elsif (__PACKAGE__ =~ m/ \b Elatin1 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: ISO[-_ ]?8859-1 | IEC[- ]?8859-1 | Latin-?1 ) \b /oxmsi;
}

# Latin-2
elsif (__PACKAGE__ =~ m/ \b Elatin2 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: ISO[-_ ]?8859-2 | IEC[- ]?8859-2 | Latin-?2 ) \b /oxmsi;
}

# Latin-3
elsif (__PACKAGE__ =~ m/ \b Elatin3 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: ISO[-_ ]?8859-3 | IEC[- ]?8859-3 | Latin-?3 ) \b /oxmsi;
}

# Latin-4
elsif (__PACKAGE__ =~ m/ \b Elatin4 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: ISO[-_ ]?8859-4 | IEC[- ]?8859-4 | Latin-?4 ) \b /oxmsi;
}

# Cyrillic
elsif (__PACKAGE__ =~ m/ \b Ecyrillic \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: ISO[-_ ]?8859-5 | IEC[- ]?8859-5 | Cyrillic ) \b /oxmsi;
}

# Greek
elsif (__PACKAGE__ =~ m/ \b Egreek \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: ISO[-_ ]?8859-7 | IEC[- ]?8859-7 | Greek ) \b /oxmsi;
}

# Latin-5
elsif (__PACKAGE__ =~ m/ \b Elatin5 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: ISO[-_ ]?8859-9 | IEC[- ]?8859-9 | Latin-?5 ) \b /oxmsi;
}

# Latin-6
elsif (__PACKAGE__ =~ m/ \b Elatin6 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: ISO[-_ ]?8859-10 | IEC[- ]?8859-10 | Latin-?6 ) \b /oxmsi;
}

# Latin-7
elsif (__PACKAGE__ =~ m/ \b Elatin7 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: ISO[-_ ]?8859-13 | IEC[- ]?8859-13 | Latin-?7 ) \b /oxmsi;
}

# Latin-8
elsif (__PACKAGE__ =~ m/ \b Elatin8 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: ISO[-_ ]?8859-14 | IEC[- ]?8859-14 | Latin-?8 ) \b /oxmsi;
}

# Latin-9
elsif (__PACKAGE__ =~ m/ \b Elatin9 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: ISO[-_ ]?8859-15 | IEC[- ]?8859-15 | Latin-?9 ) \b /oxmsi;
}

# Latin-10
elsif (__PACKAGE__ =~ m/ \b Elatin10 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: ISO[-_ ]?8859-16 | IEC[- ]?8859-16 | Latin-?10 ) \b /oxmsi;
}

# Windows-1252
elsif (__PACKAGE__ =~ m/ \b Ewindows1252 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: Windows-?1252 ) \b /oxmsi;
}

else {
    croak "$0 don't know my package name '" . __PACKAGE__ . "'";
}

#
# Prototypes of subroutines
#
sub import() {}
sub unimport() {}
sub Elatin2::split(;$$$);
sub Elatin2::tr($$$$;$);
sub Elatin2::chop(@);
sub Elatin2::index($$;$);
sub Elatin2::rindex($$;$);
sub Elatin2::lcfirst(@);
sub Elatin2::lcfirst_();
sub Elatin2::lc(@);
sub Elatin2::lc_();
sub Elatin2::ucfirst(@);
sub Elatin2::ucfirst_();
sub Elatin2::uc(@);
sub Elatin2::uc_();
sub Elatin2::ignorecase(@);
sub Elatin2::capture($);
sub Elatin2::chr(;$);
sub Elatin2::chr_();
sub Elatin2::glob($);
sub Elatin2::glob_();

sub Latin2::ord(;$);
sub Latin2::ord_();
sub Latin2::reverse(@);
sub Latin2::length(;$);
sub Latin2::substr($$;$$);
sub Latin2::index($$;$);
sub Latin2::rindex($$;$);

#
# @ARGV wildcard globbing
#
if ($^O =~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms) {
    if ($ENV{'ComSpec'} =~ / (?: COMMAND\.COM | CMD\.EXE ) \z /oxmsi) {
        my @argv = ();
        for (@ARGV) {
            if (m/\A ' ((?:$q_char)*) ' \z/oxms) {
                push @argv, $1;
            }
            elsif (m/\A (?:$q_char)*? [*?] /oxms and (my @glob = Elatin2::glob($_))) {
                push @argv, @glob;
            }
            else {
                push @argv, $_;
            }
        }
        @ARGV = @argv;
    }
}

#
# Latin-2 split
#
sub Elatin2::split(;$$$) {

    # P.794 29.2.161. split
    # in Chapter 29: Functions
    # of ISBN 0-596-00027-8 Programming Perl Third Edition.

    my $pattern = $_[0];
    my $string  = $_[1];
    my $limit   = $_[2];

    # if $string is omitted, the function splits the $_ string
    if (not defined $string) {
        if (defined $_) {
            $string = $_;
        }
        else {
            $string = '';
        }
    }

    my @split = ();

    # when string is empty
    if ($string eq '') {

        # resulting list value in list context
        if (wantarray) {
            return @split;
        }

        # count of substrings in scalar context
        else {
            carp "$0: Use of implicit split to \@_ is deprecated" if $^W;
            @_ = @split;
            return scalar @_;
        }
    }

    # if $limit is negative, it is treated as if an arbitrarily large $limit has been specified
    if ((not defined $limit) or ($limit <= 0)) {

        # if $pattern is also omitted or is the literal space, " ", the function splits
        # on whitespace, /\s+/, after skipping any leading whitespace
        # (and so on)

        if ((not defined $pattern) or ($pattern eq ' ')) {
            $string =~ s/ \A \s+ //oxms;

            # P.1024 Appendix W.10 Multibyte Processing
            # of ISBN 1-56592-224-7 CJKV Information Processing
            # (and so on)

            # the //m modifier is assumed when you split on the pattern /^/
            # (and so on)

            while ($string =~ s/\A((?:$q_char)*?)\s+//m) {

                # if the $pattern contains parentheses, then the substring matched by each pair of parentheses
                # is included in the resulting list, interspersed with the fields that are ordinarily returned
                # (and so on)

                local $@;
                for (my $digit=1; eval "defined(\$$digit)"; $digit++) {
                    push @split, eval '$' . $digit;
                }
            }
        }

        # a pattern capable of matching either the null string or something longer than the
        # null string will split the value of $string into separate characters wherever it
        # matches the null string between characters
        # (and so on)

        elsif ('' =~ m/ \A $pattern \z /xms) {
            while ($string =~ s/\A((?:$q_char)+?)$pattern//m) {
                local $@;
                for (my $digit=1; eval "defined(\$$digit)"; $digit++) {
                    push @split, eval '$' . $digit;
                }
            }
        }

        else {
            while ($string =~ s/\A((?:$q_char)*?)$pattern//m) {
                local $@;
                for (my $digit=1; eval "defined(\$$digit)"; $digit++) {
                    push @split, eval '$' . $digit;
                }
            }
        }
    }

    else {
        if ((not defined $pattern) or ($pattern eq ' ')) {
            $string =~ s/ \A \s+ //oxms;
            while ((--$limit > 0) and (CORE::length($string) > 0)) {
                if ($string =~ s/\A((?:$q_char)*?)\s+//m) {
                    local $@;
                    for (my $digit=1; eval "defined(\$$digit)"; $digit++) {
                        push @split, eval '$' . $digit;
                    }
                }
            }
        }
        elsif ('' =~ m/ \A $pattern \z /xms) {
            while ((--$limit > 0) and (CORE::length($string) > 0)) {
                if ($string =~ s/\A((?:$q_char)+?)$pattern//m) {
                    local $@;
                    for (my $digit=1; eval "defined(\$$digit)"; $digit++) {
                        push @split, eval '$' . $digit;
                    }
                }
            }
        }
        else {
            while ((--$limit > 0) and (CORE::length($string) > 0)) {
                if ($string =~ s/\A((?:$q_char)*?)$pattern//m) {
                    local $@;
                    for (my $digit=1; eval "defined(\$$digit)"; $digit++) {
                        push @split, eval '$' . $digit;
                    }
                }
            }
        }
    }

    push @split, $string;

    # if $limit is omitted or zero, trailing null fields are stripped from the result
    if ((not defined $limit) or ($limit == 0)) {
        while ((scalar(@split) >= 1) and ($split[-1] eq '')) {
            pop @split;
        }
    }

    # resulting list value in list context
    if (wantarray) {
        return @split;
    }

    # count of substrings in scalar context
    else {
        carp "$0: Use of implicit split to \@_ is deprecated" if $^W;
        @_ = @split;
        return scalar @_;
    }
}

#
# Latin-2 transliteration (tr///)
#
sub Elatin2::tr($$$$;$) {

    my $bind_operator   = $_[1];
    my $searchlist      = $_[2];
    my $replacementlist = $_[3];
    my $modifier        = $_[4] || '';

    if ($modifier =~ m/r/oxms) {
        if ($bind_operator =~ m/ !~ /oxms) {
            croak "$0: Using !~ with tr///r doesn't make sense";
        }
    }

    my @char            = $_[0] =~ m/\G ($q_char) /oxmsg;
    my @searchlist      = _charlist_tr($searchlist);
    my @replacementlist = _charlist_tr($replacementlist);

    my %tr = ();
    for (my $i=0; $i <= $#searchlist; $i++) {
        if (not exists $tr{$searchlist[$i]}) {
            if (defined $replacementlist[$i] and ($replacementlist[$i] ne '')) {
                $tr{$searchlist[$i]} = $replacementlist[$i];
            }
            elsif ($modifier =~ m/d/oxms) {
                $tr{$searchlist[$i]} = '';
            }
            elsif (defined $replacementlist[-1] and ($replacementlist[-1] ne '')) {
                $tr{$searchlist[$i]} = $replacementlist[-1];
            }
            else {
                $tr{$searchlist[$i]} = $searchlist[$i];
            }
        }
    }

    my $tr = 0;
    my $replaced = '';
    if ($modifier =~ m/c/oxms) {
        while (defined(my $char = shift @char)) {
            if (not exists $tr{$char}) {
                if (defined $replacementlist[0]) {
                    $replaced .= $replacementlist[0];
                }
                $tr++;
                if ($modifier =~ m/s/oxms) {
                    while (@char and (not exists $tr{$char[0]})) {
                        shift @char;
                        $tr++;
                    }
                }
            }
            else {
                $replaced .= $char;
            }
        }
    }
    else {
        while (defined(my $char = shift @char)) {
            if (exists $tr{$char}) {
                $replaced .= $tr{$char};
                $tr++;
                if ($modifier =~ m/s/oxms) {
                    while (@char and (exists $tr{$char[0]}) and ($tr{$char[0]} eq $tr{$char})) {
                        shift @char;
                        $tr++;
                    }
                }
            }
            else {
                $replaced .= $char;
            }
        }
    }

    if ($modifier =~ m/r/oxms) {
        return $replaced;
    }
    else {
        $_[0] = $replaced;
        if ($bind_operator =~ m/ !~ /oxms) {
            return not $tr;
        }
        else {
            return $tr;
        }
    }
}

#
# Latin-2 chop
#
sub Elatin2::chop(@) {

    my $chop;
    if (@_ == 0) {
        my @char = m/\G ($q_char) /oxmsg;
        $chop = pop @char;
        $_ = join '', @char;
    }
    else {
        for (@_) {
            my @char = m/\G ($q_char) /oxmsg;
            $chop = pop @char;
            $_ = join '', @char;
        }
    }
    return $chop;
}

#
# Latin-2 index by octet
#
sub Elatin2::index($$;$) {

    my($str,$substr,$position) = @_;
    $position ||= 0;
    my $pos = 0;

    while ($pos < CORE::length($str)) {
        if (CORE::substr($str,$pos,CORE::length($substr)) eq $substr) {
            if ($pos >= $position) {
                return $pos;
            }
        }
        if (CORE::substr($str,$pos) =~ m/\A ($q_char) /oxms) {
            $pos += CORE::length($1);
        }
        else {
            $pos += 1;
        }
    }
    return -1;
}

#
# Latin-2 reverse index
#
sub Elatin2::rindex($$;$) {

    my($str,$substr,$position) = @_;
    $position ||= CORE::length($str) - 1;
    my $pos = 0;
    my $rindex = -1;

    while (($pos < CORE::length($str)) and ($pos <= $position)) {
        if (CORE::substr($str,$pos,CORE::length($substr)) eq $substr) {
            $rindex = $pos;
        }
        if (CORE::substr($str,$pos) =~ m/\A ($q_char) /oxms) {
            $pos += CORE::length($1);
        }
        else {
            $pos += 1;
        }
    }
    return $rindex;
}

#
# Latin-2 lower case
#
{
    # P.132 4.8.2. Lexically Scoped Variables: my
    # in Chapter 4: Statements and Declarations
    # of ISBN 0-596-00027-8 Programming Perl Third Edition.
    # (and so on)

    my %lc = ();
    @lc{qw(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)} =
        qw(a b c d e f g h i j k l m n o p q r s t u v w x y z);

    if (0) {
    }

    elsif (__PACKAGE__ =~ m/ \b Eusascii \z/oxms) {
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin1 \z/oxms) {
        %lc = (%lc,
            "\xC0" => "\xE0", # LATIN LETTER A WITH GRAVE
            "\xC1" => "\xE1", # LATIN LETTER A WITH ACUTE
            "\xC2" => "\xE2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xC3" => "\xE3", # LATIN LETTER A WITH TILDE
            "\xC4" => "\xE4", # LATIN LETTER A WITH DIAERESIS
            "\xC5" => "\xE5", # LATIN LETTER A WITH RING ABOVE
            "\xC6" => "\xE6", # LATIN LETTER AE
            "\xC7" => "\xE7", # LATIN LETTER C WITH CEDILLA
            "\xC8" => "\xE8", # LATIN LETTER E WITH GRAVE
            "\xC9" => "\xE9", # LATIN LETTER E WITH ACUTE
            "\xCA" => "\xEA", # LATIN LETTER E WITH CIRCUMFLEX
            "\xCB" => "\xEB", # LATIN LETTER E WITH DIAERESIS
            "\xCC" => "\xEC", # LATIN LETTER I WITH GRAVE
            "\xCD" => "\xED", # LATIN LETTER I WITH ACUTE
            "\xCE" => "\xEE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xCF" => "\xEF", # LATIN LETTER I WITH DIAERESIS
            "\xD0" => "\xF0", # LATIN LETTER ETH (Icelandic)
            "\xD1" => "\xF1", # LATIN LETTER N WITH TILDE
            "\xD2" => "\xF2", # LATIN LETTER O WITH GRAVE
            "\xD3" => "\xF3", # LATIN LETTER O WITH ACUTE
            "\xD4" => "\xF4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xD5" => "\xF5", # LATIN LETTER O WITH TILDE
            "\xD6" => "\xF6", # LATIN LETTER O WITH DIAERESIS
            "\xD8" => "\xF8", # LATIN LETTER O WITH STROKE
            "\xD9" => "\xF9", # LATIN LETTER U WITH GRAVE
            "\xDA" => "\xFA", # LATIN LETTER U WITH ACUTE
            "\xDB" => "\xFB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xDC" => "\xFC", # LATIN LETTER U WITH DIAERESIS
            "\xDD" => "\xFD", # LATIN LETTER Y WITH ACUTE
            "\xDE" => "\xFE", # LATIN LETTER THORN (Icelandic)
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin2 \z/oxms) {
        %lc = (%lc,
            "\xA1" => "\xB1", # LATIN LETTER A WITH OGONEK
            "\xA3" => "\xB3", # LATIN LETTER L WITH STROKE
            "\xA5" => "\xB5", # LATIN LETTER L WITH CARON
            "\xA6" => "\xB6", # LATIN LETTER S WITH ACUTE
            "\xA9" => "\xB9", # LATIN LETTER S WITH CARON
            "\xAA" => "\xBA", # LATIN LETTER S WITH CEDILLA
            "\xAB" => "\xBB", # LATIN LETTER T WITH CARON
            "\xAC" => "\xBC", # LATIN LETTER Z WITH ACUTE
            "\xAE" => "\xBE", # LATIN LETTER Z WITH CARON
            "\xAF" => "\xBF", # LATIN LETTER Z WITH DOT ABOVE
            "\xC0" => "\xE0", # LATIN LETTER R WITH ACUTE
            "\xC1" => "\xE1", # LATIN LETTER A WITH ACUTE
            "\xC2" => "\xE2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xC3" => "\xE3", # LATIN LETTER A WITH BREVE
            "\xC4" => "\xE4", # LATIN LETTER A WITH DIAERESIS
            "\xC5" => "\xE5", # LATIN LETTER L WITH ACUTE
            "\xC6" => "\xE6", # LATIN LETTER C WITH ACUTE
            "\xC7" => "\xE7", # LATIN LETTER C WITH CEDILLA
            "\xC8" => "\xE8", # LATIN LETTER C WITH CARON
            "\xC9" => "\xE9", # LATIN LETTER E WITH ACUTE
            "\xCA" => "\xEA", # LATIN LETTER E WITH OGONEK
            "\xCB" => "\xEB", # LATIN LETTER E WITH DIAERESIS
            "\xCC" => "\xEC", # LATIN LETTER E WITH CARON
            "\xCD" => "\xED", # LATIN LETTER I WITH ACUTE
            "\xCE" => "\xEE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xCF" => "\xEF", # LATIN LETTER D WITH CARON
            "\xD0" => "\xF0", # LATIN LETTER D WITH STROKE
            "\xD1" => "\xF1", # LATIN LETTER N WITH ACUTE
            "\xD2" => "\xF2", # LATIN LETTER N WITH CARON
            "\xD3" => "\xF3", # LATIN LETTER O WITH ACUTE
            "\xD4" => "\xF4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xD5" => "\xF5", # LATIN LETTER O WITH DOUBLE ACUTE
            "\xD6" => "\xF6", # LATIN LETTER O WITH DIAERESIS
            "\xD8" => "\xF8", # LATIN LETTER R WITH CARON
            "\xD9" => "\xF9", # LATIN LETTER U WITH RING ABOVE
            "\xDA" => "\xFA", # LATIN LETTER U WITH ACUTE
            "\xDB" => "\xFB", # LATIN LETTER U WITH DOUBLE ACUTE
            "\xDC" => "\xFC", # LATIN LETTER U WITH DIAERESIS
            "\xDD" => "\xFD", # LATIN LETTER Y WITH ACUTE
            "\xDE" => "\xFE", # LATIN LETTER T WITH CEDILLA
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin3 \z/oxms) {
        %lc = (%lc,
            "\xA1" => "\xB1", # LATIN LETTER H WITH STROKE
            "\xA6" => "\xB6", # LATIN LETTER H WITH CIRCUMFLEX
            "\xAA" => "\xBA", # LATIN LETTER S WITH CEDILLA
            "\xAB" => "\xBB", # LATIN LETTER G WITH BREVE
            "\xAC" => "\xBC", # LATIN LETTER J WITH CIRCUMFLEX
            "\xAF" => "\xBF", # LATIN LETTER Z WITH DOT ABOVE
            "\xC0" => "\xE0", # LATIN LETTER A WITH GRAVE
            "\xC1" => "\xE1", # LATIN LETTER A WITH ACUTE
            "\xC2" => "\xE2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xC4" => "\xE4", # LATIN LETTER A WITH DIAERESIS
            "\xC5" => "\xE5", # LATIN LETTER C WITH DOT ABOVE
            "\xC6" => "\xE6", # LATIN LETTER C WITH CIRCUMFLEX
            "\xC7" => "\xE7", # LATIN LETTER C WITH CEDILLA
            "\xC8" => "\xE8", # LATIN LETTER E WITH GRAVE
            "\xC9" => "\xE9", # LATIN LETTER E WITH ACUTE
            "\xCA" => "\xEA", # LATIN LETTER E WITH CIRCUMFLEX
            "\xCB" => "\xEB", # LATIN LETTER E WITH DIAERESIS
            "\xCC" => "\xEC", # LATIN LETTER I WITH GRAVE
            "\xCD" => "\xED", # LATIN LETTER I WITH ACUTE
            "\xCE" => "\xEE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xCF" => "\xEF", # LATIN LETTER I WITH DIAERESIS
            "\xD1" => "\xF1", # LATIN LETTER N WITH TILDE
            "\xD2" => "\xF2", # LATIN LETTER O WITH GRAVE
            "\xD3" => "\xF3", # LATIN LETTER O WITH ACUTE
            "\xD4" => "\xF4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xD5" => "\xF5", # LATIN LETTER G WITH DOT ABOVE
            "\xD6" => "\xF6", # LATIN LETTER O WITH DIAERESIS
            "\xD8" => "\xF8", # LATIN LETTER G WITH CIRCUMFLEX
            "\xD9" => "\xF9", # LATIN LETTER U WITH GRAVE
            "\xDA" => "\xFA", # LATIN LETTER U WITH ACUTE
            "\xDB" => "\xFB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xDC" => "\xFC", # LATIN LETTER U WITH DIAERESIS
            "\xDD" => "\xFD", # LATIN LETTER U WITH BREVE
            "\xDE" => "\xFE", # LATIN LETTER S WITH CIRCUMFLEX
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin4 \z/oxms) {
        %lc = (%lc,
            "\xA1" => "\xB1", # LATIN LETTER A WITH OGONEK
            "\xA3" => "\xB3", # LATIN LETTER R WITH CEDILLA
            "\xA5" => "\xB5", # LATIN LETTER I WITH TILDE
            "\xA6" => "\xB6", # LATIN LETTER L WITH CEDILLA
            "\xA9" => "\xB9", # LATIN LETTER S WITH CARON
            "\xAA" => "\xBA", # LATIN LETTER E WITH MACRON
            "\xAB" => "\xBB", # LATIN LETTER G WITH CEDILLA
            "\xAC" => "\xBC", # LATIN LETTER T WITH STROKE
            "\xAE" => "\xBE", # LATIN LETTER Z WITH CARON
            "\xBD" => "\xBF", # LATIN LETTER ENG
            "\xC0" => "\xE0", # LATIN LETTER A WITH MACRON
            "\xC1" => "\xE1", # LATIN LETTER A WITH ACUTE
            "\xC2" => "\xE2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xC3" => "\xE3", # LATIN LETTER A WITH TILDE
            "\xC4" => "\xE4", # LATIN LETTER A WITH DIAERESIS
            "\xC5" => "\xE5", # LATIN LETTER A WITH RING ABOVE
            "\xC6" => "\xE6", # LATIN LETTER AE
            "\xC7" => "\xE7", # LATIN LETTER I WITH OGONEK
            "\xC8" => "\xE8", # LATIN LETTER C WITH CARON
            "\xC9" => "\xE9", # LATIN LETTER E WITH ACUTE
            "\xCA" => "\xEA", # LATIN LETTER E WITH OGONEK
            "\xCB" => "\xEB", # LATIN LETTER E WITH DIAERESIS
            "\xCC" => "\xEC", # LATIN LETTER E WITH DOT ABOVE
            "\xCD" => "\xED", # LATIN LETTER I WITH ACUTE
            "\xCE" => "\xEE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xCF" => "\xEF", # LATIN LETTER I WITH MACRON
            "\xD0" => "\xF0", # LATIN LETTER D WITH STROKE
            "\xD1" => "\xF1", # LATIN LETTER N WITH CEDILLA
            "\xD2" => "\xF2", # LATIN LETTER O WITH MACRON
            "\xD3" => "\xF3", # LATIN LETTER K WITH CEDILLA
            "\xD4" => "\xF4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xD5" => "\xF5", # LATIN LETTER O WITH TILDE
            "\xD6" => "\xF6", # LATIN LETTER O WITH DIAERESIS
            "\xD8" => "\xF8", # LATIN LETTER O WITH STROKE
            "\xD9" => "\xF9", # LATIN LETTER U WITH OGONEK
            "\xDA" => "\xFA", # LATIN LETTER U WITH ACUTE
            "\xDB" => "\xFB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xDC" => "\xFC", # LATIN LETTER U WITH DIAERESIS
            "\xDD" => "\xFD", # LATIN LETTER U WITH TILDE
            "\xDE" => "\xFE", # LATIN LETTER U WITH MACRON
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Ecyrillic \z/oxms) {
        %lc = (%lc,
            "\xA1" => "\xF1", # CYRILLIC LETTER IO
            "\xA2" => "\xF2", # CYRILLIC LETTER DJE
            "\xA3" => "\xF3", # CYRILLIC LETTER GJE
            "\xA4" => "\xF4", # CYRILLIC LETTER UKRAINIAN IE
            "\xA5" => "\xF5", # CYRILLIC LETTER DZE
            "\xA6" => "\xF6", # CYRILLIC LETTER BYELORUSSIAN-UKRAINIAN I
            "\xA7" => "\xF7", # CYRILLIC LETTER YI
            "\xA8" => "\xF8", # CYRILLIC LETTER JE
            "\xA9" => "\xF9", # CYRILLIC LETTER LJE
            "\xAA" => "\xFA", # CYRILLIC LETTER NJE
            "\xAB" => "\xFB", # CYRILLIC LETTER TSHE
            "\xAC" => "\xFC", # CYRILLIC LETTER KJE
            "\xAE" => "\xFE", # CYRILLIC LETTER SHORT U
            "\xAF" => "\xFF", # CYRILLIC LETTER DZHE
            "\xB0" => "\xD0", # CYRILLIC LETTER A
            "\xB1" => "\xD1", # CYRILLIC LETTER BE
            "\xB2" => "\xD2", # CYRILLIC LETTER VE
            "\xB3" => "\xD3", # CYRILLIC LETTER GHE
            "\xB4" => "\xD4", # CYRILLIC LETTER DE
            "\xB5" => "\xD5", # CYRILLIC LETTER IE
            "\xB6" => "\xD6", # CYRILLIC LETTER ZHE
            "\xB7" => "\xD7", # CYRILLIC LETTER ZE
            "\xB8" => "\xD8", # CYRILLIC LETTER I
            "\xB9" => "\xD9", # CYRILLIC LETTER SHORT I
            "\xBA" => "\xDA", # CYRILLIC LETTER KA
            "\xBB" => "\xDB", # CYRILLIC LETTER EL
            "\xBC" => "\xDC", # CYRILLIC LETTER EM
            "\xBD" => "\xDD", # CYRILLIC LETTER EN
            "\xBE" => "\xDE", # CYRILLIC LETTER O
            "\xBF" => "\xDF", # CYRILLIC LETTER PE
            "\xC0" => "\xE0", # CYRILLIC LETTER ER
            "\xC1" => "\xE1", # CYRILLIC LETTER ES
            "\xC2" => "\xE2", # CYRILLIC LETTER TE
            "\xC3" => "\xE3", # CYRILLIC LETTER U
            "\xC4" => "\xE4", # CYRILLIC LETTER EF
            "\xC5" => "\xE5", # CYRILLIC LETTER HA
            "\xC6" => "\xE6", # CYRILLIC LETTER TSE
            "\xC7" => "\xE7", # CYRILLIC LETTER CHE
            "\xC8" => "\xE8", # CYRILLIC LETTER SHA
            "\xC9" => "\xE9", # CYRILLIC LETTER SHCHA
            "\xCA" => "\xEA", # CYRILLIC LETTER HARD SIGN
            "\xCB" => "\xEB", # CYRILLIC LETTER YERU
            "\xCC" => "\xEC", # CYRILLIC LETTER SOFT SIGN
            "\xCD" => "\xED", # CYRILLIC LETTER E
            "\xCE" => "\xEE", # CYRILLIC LETTER YU
            "\xCF" => "\xEF", # CYRILLIC LETTER YA
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Egreek \z/oxms) {
        %lc = (%lc,
            "\xB6" => "\xDC", # GREEK LETTER ALPHA WITH TONOS
            "\xB8" => "\xDD", # GREEK LETTER EPSILON WITH TONOS
            "\xB9" => "\xDE", # GREEK LETTER ETA WITH TONOS
            "\xBA" => "\xDF", # GREEK LETTER IOTA WITH TONOS
            "\xBC" => "\xFC", # GREEK LETTER OMICRON WITH TONOS
            "\xBE" => "\xFD", # GREEK LETTER UPSILON WITH TONOS
            "\xBF" => "\xFE", # GREEK LETTER OMEGA WITH TONOS
            "\xC1" => "\xE1", # GREEK LETTER ALPHA
            "\xC2" => "\xE2", # GREEK LETTER BETA
            "\xC3" => "\xE3", # GREEK LETTER GAMMA
            "\xC4" => "\xE4", # GREEK LETTER DELTA
            "\xC5" => "\xE5", # GREEK LETTER EPSILON
            "\xC6" => "\xE6", # GREEK LETTER ZETA
            "\xC7" => "\xE7", # GREEK LETTER ETA
            "\xC8" => "\xE8", # GREEK LETTER THETA
            "\xC9" => "\xE9", # GREEK LETTER IOTA
            "\xCA" => "\xEA", # GREEK LETTER KAPPA
            "\xCB" => "\xEB", # GREEK LETTER LAMDA
            "\xCC" => "\xEC", # GREEK LETTER MU
            "\xCD" => "\xED", # GREEK LETTER NU
            "\xCE" => "\xEE", # GREEK LETTER XI
            "\xCF" => "\xEF", # GREEK LETTER OMICRON
            "\xD0" => "\xF0", # GREEK LETTER PI
            "\xD1" => "\xF1", # GREEK LETTER RHO
            "\xD3" => "\xF3", # GREEK LETTER SIGMA
            "\xD4" => "\xF4", # GREEK LETTER TAU
            "\xD5" => "\xF5", # GREEK LETTER UPSILON
            "\xD6" => "\xF6", # GREEK LETTER PHI
            "\xD7" => "\xF7", # GREEK LETTER CHI
            "\xD8" => "\xF8", # GREEK LETTER PSI
            "\xD9" => "\xF9", # GREEK LETTER OMEGA
            "\xDA" => "\xFA", # GREEK LETTER IOTA WITH DIALYTIKA
            "\xDB" => "\xFB", # GREEK LETTER UPSILON WITH DIALYTIKA
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin5 \z/oxms) {
        %lc = (%lc,
            "\xC0" => "\xE0", # LATIN LETTER A WITH GRAVE
            "\xC1" => "\xE1", # LATIN LETTER A WITH ACUTE
            "\xC2" => "\xE2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xC3" => "\xE3", # LATIN LETTER A WITH TILDE
            "\xC4" => "\xE4", # LATIN LETTER A WITH DIAERESIS
            "\xC5" => "\xE5", # LATIN LETTER A WITH RING ABOVE
            "\xC6" => "\xE6", # LATIN LETTER AE
            "\xC7" => "\xE7", # LATIN LETTER C WITH CEDILLA
            "\xC8" => "\xE8", # LATIN LETTER E WITH GRAVE
            "\xC9" => "\xE9", # LATIN LETTER E WITH ACUTE
            "\xCA" => "\xEA", # LATIN LETTER E WITH CIRCUMFLEX
            "\xCB" => "\xEB", # LATIN LETTER E WITH DIAERESIS
            "\xCC" => "\xEC", # LATIN LETTER I WITH GRAVE
            "\xCD" => "\xED", # LATIN LETTER I WITH ACUTE
            "\xCE" => "\xEE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xCF" => "\xEF", # LATIN LETTER I WITH DIAERESIS
            "\xD0" => "\xF0", # LATIN LETTER G WITH BREVE
            "\xD1" => "\xF1", # LATIN LETTER N WITH TILDE
            "\xD2" => "\xF2", # LATIN LETTER O WITH GRAVE
            "\xD3" => "\xF3", # LATIN LETTER O WITH ACUTE
            "\xD4" => "\xF4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xD5" => "\xF5", # LATIN LETTER O WITH TILDE
            "\xD6" => "\xF6", # LATIN LETTER O WITH DIAERESIS
            "\xD8" => "\xF8", # LATIN LETTER O WITH STROKE
            "\xD9" => "\xF9", # LATIN LETTER U WITH GRAVE
            "\xDA" => "\xFA", # LATIN LETTER U WITH ACUTE
            "\xDB" => "\xFB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xDC" => "\xFC", # LATIN LETTER U WITH DIAERESIS
            "\xDE" => "\xFE", # LATIN LETTER S WITH CEDILLA
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin6 \z/oxms) {
        %lc = (%lc,
            "\xA1" => "\xB1", # LATIN LETTER A WITH OGONEK
            "\xA2" => "\xB2", # LATIN LETTER E WITH MACRON
            "\xA3" => "\xB3", # LATIN LETTER G WITH CEDILLA
            "\xA4" => "\xB4", # LATIN LETTER I WITH MACRON
            "\xA5" => "\xB5", # LATIN LETTER I WITH TILDE
            "\xA6" => "\xB6", # LATIN LETTER K WITH CEDILLA
            "\xA8" => "\xB8", # LATIN LETTER L WITH CEDILLA
            "\xA9" => "\xB9", # LATIN LETTER D WITH STROKE
            "\xAA" => "\xBA", # LATIN LETTER S WITH CARON
            "\xAB" => "\xBB", # LATIN LETTER T WITH STROKE
            "\xAC" => "\xBC", # LATIN LETTER Z WITH CARON
            "\xAE" => "\xBE", # LATIN LETTER U WITH MACRON
            "\xAF" => "\xBF", # LATIN LETTER ENG
            "\xC0" => "\xE0", # LATIN LETTER A WITH MACRON
            "\xC1" => "\xE1", # LATIN LETTER A WITH ACUTE
            "\xC2" => "\xE2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xC3" => "\xE3", # LATIN LETTER A WITH TILDE
            "\xC4" => "\xE4", # LATIN LETTER A WITH DIAERESIS
            "\xC5" => "\xE5", # LATIN LETTER A WITH RING ABOVE
            "\xC6" => "\xE6", # LATIN LETTER AE
            "\xC7" => "\xE7", # LATIN LETTER I WITH OGONEK
            "\xC8" => "\xE8", # LATIN LETTER C WITH CARON
            "\xC9" => "\xE9", # LATIN LETTER E WITH ACUTE
            "\xCA" => "\xEA", # LATIN LETTER E WITH OGONEK
            "\xCB" => "\xEB", # LATIN LETTER E WITH DIAERESIS
            "\xCC" => "\xEC", # LATIN LETTER E WITH DOT ABOVE
            "\xCD" => "\xED", # LATIN LETTER I WITH ACUTE
            "\xCE" => "\xEE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xCF" => "\xEF", # LATIN LETTER I WITH DIAERESIS
            "\xD0" => "\xF0", # LATIN LETTER ETH (Icelandic)
            "\xD1" => "\xF1", # LATIN LETTER N WITH CEDILLA
            "\xD2" => "\xF2", # LATIN LETTER O WITH MACRON
            "\xD3" => "\xF3", # LATIN LETTER O WITH ACUTE
            "\xD4" => "\xF4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xD5" => "\xF5", # LATIN LETTER O WITH TILDE
            "\xD6" => "\xF6", # LATIN LETTER O WITH DIAERESIS
            "\xD7" => "\xF7", # LATIN LETTER U WITH TILDE
            "\xD8" => "\xF8", # LATIN LETTER O WITH STROKE
            "\xD9" => "\xF9", # LATIN LETTER U WITH OGONEK
            "\xDA" => "\xFA", # LATIN LETTER U WITH ACUTE
            "\xDB" => "\xFB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xDC" => "\xFC", # LATIN LETTER U WITH DIAERESIS
            "\xDD" => "\xFD", # LATIN LETTER Y WITH ACUTE
            "\xDE" => "\xFE", # LATIN LETTER THORN (Icelandic)
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin7 \z/oxms) {
        %lc = (%lc,
            "\xA8" => "\xB8", # LATIN LETTER O WITH STROKE
            "\xAA" => "\xBA", # LATIN LETTER R WITH CEDILLA
            "\xAF" => "\xBF", # LATIN LETTER AE
            "\xC0" => "\xE0", # LATIN LETTER A WITH OGONEK
            "\xC1" => "\xE1", # LATIN LETTER I WITH OGONEK
            "\xC2" => "\xE2", # LATIN LETTER A WITH MACRON
            "\xC3" => "\xE3", # LATIN LETTER C WITH ACUTE
            "\xC4" => "\xE4", # LATIN LETTER A WITH DIAERESIS
            "\xC5" => "\xE5", # LATIN LETTER A WITH RING ABOVE
            "\xC6" => "\xE6", # LATIN LETTER E WITH OGONEK
            "\xC7" => "\xE7", # LATIN LETTER E WITH MACRON
            "\xC8" => "\xE8", # LATIN LETTER C WITH CARON
            "\xC9" => "\xE9", # LATIN LETTER E WITH ACUTE
            "\xCA" => "\xEA", # LATIN LETTER Z WITH ACUTE
            "\xCB" => "\xEB", # LATIN LETTER E WITH DOT ABOVE
            "\xCC" => "\xEC", # LATIN LETTER G WITH CEDILLA
            "\xCD" => "\xED", # LATIN LETTER K WITH CEDILLA
            "\xCE" => "\xEE", # LATIN LETTER I WITH MACRON
            "\xCF" => "\xEF", # LATIN LETTER L WITH CEDILLA
            "\xD0" => "\xF0", # LATIN LETTER S WITH CARON
            "\xD1" => "\xF1", # LATIN LETTER N WITH ACUTE
            "\xD2" => "\xF2", # LATIN LETTER N WITH CEDILLA
            "\xD3" => "\xF3", # LATIN LETTER O WITH ACUTE
            "\xD4" => "\xF4", # LATIN LETTER O WITH MACRON
            "\xD5" => "\xF5", # LATIN LETTER O WITH TILDE
            "\xD6" => "\xF6", # LATIN LETTER O WITH DIAERESIS
            "\xD8" => "\xF8", # LATIN LETTER U WITH OGONEK
            "\xD9" => "\xF9", # LATIN LETTER L WITH STROKE
            "\xDA" => "\xFA", # LATIN LETTER S WITH ACUTE
            "\xDB" => "\xFB", # LATIN LETTER U WITH MACRON
            "\xDC" => "\xFC", # LATIN LETTER U WITH DIAERESIS
            "\xDD" => "\xFD", # LATIN LETTER Z WITH DOT ABOVE
            "\xDE" => "\xFE", # LATIN LETTER Z WITH CARON
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin8 \z/oxms) {
        %lc = (%lc,
            "\xA1" => "\xA2", # LATIN LETTER B WITH DOT ABOVE
            "\xA4" => "\xA5", # LATIN LETTER C WITH DOT ABOVE
            "\xA6" => "\xAB", # LATIN LETTER D WITH DOT ABOVE
            "\xA8" => "\xB8", # LATIN LETTER W WITH GRAVE
            "\xAA" => "\xBA", # LATIN LETTER W WITH ACUTE
            "\xAC" => "\xBC", # LATIN LETTER Y WITH GRAVE
            "\xAF" => "\xFF", # LATIN LETTER Y WITH DIAERESIS
            "\xB0" => "\xB1", # LATIN LETTER F WITH DOT ABOVE
            "\xB2" => "\xB3", # LATIN LETTER G WITH DOT ABOVE
            "\xB4" => "\xB5", # LATIN LETTER M WITH DOT ABOVE
            "\xB7" => "\xB9", # LATIN LETTER P WITH DOT ABOVE
            "\xBB" => "\xBF", # LATIN LETTER S WITH DOT ABOVE
            "\xBD" => "\xBE", # LATIN LETTER W WITH DIAERESIS
            "\xC0" => "\xE0", # LATIN LETTER A WITH GRAVE
            "\xC1" => "\xE1", # LATIN LETTER A WITH ACUTE
            "\xC2" => "\xE2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xC3" => "\xE3", # LATIN LETTER A WITH TILDE
            "\xC4" => "\xE4", # LATIN LETTER A WITH DIAERESIS
            "\xC5" => "\xE5", # LATIN LETTER A WITH RING ABOVE
            "\xC6" => "\xE6", # LATIN LETTER AE
            "\xC7" => "\xE7", # LATIN LETTER C WITH CEDILLA
            "\xC8" => "\xE8", # LATIN LETTER E WITH GRAVE
            "\xC9" => "\xE9", # LATIN LETTER E WITH ACUTE
            "\xCA" => "\xEA", # LATIN LETTER E WITH CIRCUMFLEX
            "\xCB" => "\xEB", # LATIN LETTER E WITH DIAERESIS
            "\xCC" => "\xEC", # LATIN LETTER I WITH GRAVE
            "\xCD" => "\xED", # LATIN LETTER I WITH ACUTE
            "\xCE" => "\xEE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xCF" => "\xEF", # LATIN LETTER I WITH DIAERESIS
            "\xD0" => "\xF0", # LATIN LETTER W WITH CIRCUMFLEX
            "\xD1" => "\xF1", # LATIN LETTER N WITH TILDE
            "\xD2" => "\xF2", # LATIN LETTER O WITH GRAVE
            "\xD3" => "\xF3", # LATIN LETTER O WITH ACUTE
            "\xD4" => "\xF4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xD5" => "\xF5", # LATIN LETTER O WITH TILDE
            "\xD6" => "\xF6", # LATIN LETTER O WITH DIAERESIS
            "\xD7" => "\xF7", # LATIN LETTER T WITH DOT ABOVE
            "\xD8" => "\xF8", # LATIN LETTER O WITH STROKE
            "\xD9" => "\xF9", # LATIN LETTER U WITH GRAVE
            "\xDA" => "\xFA", # LATIN LETTER U WITH ACUTE
            "\xDB" => "\xFB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xDC" => "\xFC", # LATIN LETTER U WITH DIAERESIS
            "\xDD" => "\xFD", # LATIN LETTER Y WITH ACUTE
            "\xDE" => "\xFE", # LATIN LETTER Y WITH CIRCUMFLEX
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin9 \z/oxms) {
        %lc = (%lc,
            "\xA6" => "\xA8", # LATIN LETTER S WITH CARON
            "\xB4" => "\xB8", # LATIN LETTER Z WITH CARON
            "\xBC" => "\xBD", # LATIN LIGATURE OE
            "\xBE" => "\xFF", # LATIN LETTER Y WITH DIAERESIS
            "\xC0" => "\xE0", # LATIN LETTER A WITH GRAVE
            "\xC1" => "\xE1", # LATIN LETTER A WITH ACUTE
            "\xC2" => "\xE2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xC3" => "\xE3", # LATIN LETTER A WITH TILDE
            "\xC4" => "\xE4", # LATIN LETTER A WITH DIAERESIS
            "\xC5" => "\xE5", # LATIN LETTER A WITH RING ABOVE
            "\xC6" => "\xE6", # LATIN LETTER AE
            "\xC7" => "\xE7", # LATIN LETTER C WITH CEDILLA
            "\xC8" => "\xE8", # LATIN LETTER E WITH GRAVE
            "\xC9" => "\xE9", # LATIN LETTER E WITH ACUTE
            "\xCA" => "\xEA", # LATIN LETTER E WITH CIRCUMFLEX
            "\xCB" => "\xEB", # LATIN LETTER E WITH DIAERESIS
            "\xCC" => "\xEC", # LATIN LETTER I WITH GRAVE
            "\xCD" => "\xED", # LATIN LETTER I WITH ACUTE
            "\xCE" => "\xEE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xCF" => "\xEF", # LATIN LETTER I WITH DIAERESIS
            "\xD0" => "\xF0", # LATIN LETTER ETH
            "\xD1" => "\xF1", # LATIN LETTER N WITH TILDE
            "\xD2" => "\xF2", # LATIN LETTER O WITH GRAVE
            "\xD3" => "\xF3", # LATIN LETTER O WITH ACUTE
            "\xD4" => "\xF4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xD5" => "\xF5", # LATIN LETTER O WITH TILDE
            "\xD6" => "\xF6", # LATIN LETTER O WITH DIAERESIS
            "\xD8" => "\xF8", # LATIN LETTER O WITH STROKE
            "\xD9" => "\xF9", # LATIN LETTER U WITH GRAVE
            "\xDA" => "\xFA", # LATIN LETTER U WITH ACUTE
            "\xDB" => "\xFB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xDC" => "\xFC", # LATIN LETTER U WITH DIAERESIS
            "\xDD" => "\xFD", # LATIN LETTER Y WITH ACUTE
            "\xDE" => "\xFE", # LATIN LETTER THORN
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin10 \z/oxms) {
        %lc = (%lc,
            "\xA1" => "\xA2", # LATIN LETTER A WITH OGONEK
            "\xA3" => "\xB3", # LATIN LETTER L WITH STROKE
            "\xA6" => "\xA8", # LATIN LETTER S WITH CARON
            "\xAA" => "\xBA", # LATIN LETTER S WITH COMMA BELOW
            "\xAC" => "\xAE", # LATIN LETTER Z WITH ACUTE
            "\xAF" => "\xBF", # LATIN LETTER Z WITH DOT ABOVE
            "\xB2" => "\xB9", # LATIN LETTER C WITH CARON
            "\xB4" => "\xB8", # LATIN LETTER Z WITH CARON
            "\xBC" => "\xBD", # LATIN LIGATURE OE
            "\xBE" => "\xFF", # LATIN LETTER Y WITH DIAERESIS
            "\xC0" => "\xE0", # LATIN LETTER A WITH GRAVE
            "\xC1" => "\xE1", # LATIN LETTER A WITH ACUTE
            "\xC2" => "\xE2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xC3" => "\xE3", # LATIN LETTER A WITH BREVE
            "\xC4" => "\xE4", # LATIN LETTER A WITH DIAERESIS
            "\xC5" => "\xE5", # LATIN LETTER C WITH ACUTE
            "\xC6" => "\xE6", # LATIN LETTER AE
            "\xC7" => "\xE7", # LATIN LETTER C WITH CEDILLA
            "\xC8" => "\xE8", # LATIN LETTER E WITH GRAVE
            "\xC9" => "\xE9", # LATIN LETTER E WITH ACUTE
            "\xCA" => "\xEA", # LATIN LETTER E WITH CIRCUMFLEX
            "\xCB" => "\xEB", # LATIN LETTER E WITH DIAERESIS
            "\xCC" => "\xEC", # LATIN LETTER I WITH GRAVE
            "\xCD" => "\xED", # LATIN LETTER I WITH ACUTE
            "\xCE" => "\xEE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xCF" => "\xEF", # LATIN LETTER I WITH DIAERESIS
            "\xD0" => "\xF0", # LATIN LETTER D WITH STROKE
            "\xD1" => "\xF1", # LATIN LETTER N WITH ACUTE
            "\xD2" => "\xF2", # LATIN LETTER O WITH GRAVE
            "\xD3" => "\xF3", # LATIN LETTER O WITH ACUTE
            "\xD4" => "\xF4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xD5" => "\xF5", # LATIN LETTER O WITH DOUBLE ACUTE
            "\xD6" => "\xF6", # LATIN LETTER O WITH DIAERESIS
            "\xD7" => "\xF7", # LATIN LETTER S WITH ACUTE
            "\xD8" => "\xF8", # LATIN LETTER U WITH DOUBLE ACUTE
            "\xD9" => "\xF9", # LATIN LETTER U WITH GRAVE
            "\xDA" => "\xFA", # LATIN LETTER U WITH ACUTE
            "\xDB" => "\xFB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xDC" => "\xFC", # LATIN LETTER U WITH DIAERESIS
            "\xDD" => "\xFD", # LATIN LETTER E WITH OGONEK
            "\xDE" => "\xFE", # LATIN LETTER T WITH COMMA BELOW
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Ewindows1252 \z/oxms) {
        %lc = (%lc,
            "\x8A" => "\x9A", # LATIN LETTER S WITH CARON
            "\x8C" => "\x9C", # LATIN LIGATURE OE
            "\x8E" => "\x9E", # LATIN LETTER Z WITH CARON
            "\x9F" => "\xFF", # LATIN LETTER Y WITH DIAERESIS
            "\xC0" => "\xE0", # LATIN LETTER A WITH GRAVE
            "\xC1" => "\xE1", # LATIN LETTER A WITH ACUTE
            "\xC2" => "\xE2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xC3" => "\xE3", # LATIN LETTER A WITH TILDE
            "\xC4" => "\xE4", # LATIN LETTER A WITH DIAERESIS
            "\xC5" => "\xE5", # LATIN LETTER A WITH RING ABOVE
            "\xC6" => "\xE6", # LATIN LETTER AE
            "\xC7" => "\xE7", # LATIN LETTER C WITH CEDILLA
            "\xC8" => "\xE8", # LATIN LETTER E WITH GRAVE
            "\xC9" => "\xE9", # LATIN LETTER E WITH ACUTE
            "\xCA" => "\xEA", # LATIN LETTER E WITH CIRCUMFLEX
            "\xCB" => "\xEB", # LATIN LETTER E WITH DIAERESIS
            "\xCC" => "\xEC", # LATIN LETTER I WITH GRAVE
            "\xCD" => "\xED", # LATIN LETTER I WITH ACUTE
            "\xCE" => "\xEE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xCF" => "\xEF", # LATIN LETTER I WITH DIAERESIS
            "\xD0" => "\xF0", # LATIN LETTER ETH
            "\xD1" => "\xF1", # LATIN LETTER N WITH TILDE
            "\xD2" => "\xF2", # LATIN LETTER O WITH GRAVE
            "\xD3" => "\xF3", # LATIN LETTER O WITH ACUTE
            "\xD4" => "\xF4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xD5" => "\xF5", # LATIN LETTER O WITH TILDE
            "\xD6" => "\xF6", # LATIN LETTER O WITH DIAERESIS
            "\xD8" => "\xF8", # LATIN LETTER O WITH STROKE
            "\xD9" => "\xF9", # LATIN LETTER U WITH GRAVE
            "\xDA" => "\xFA", # LATIN LETTER U WITH ACUTE
            "\xDB" => "\xFB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xDC" => "\xFC", # LATIN LETTER U WITH DIAERESIS
            "\xDD" => "\xFD", # LATIN LETTER Y WITH ACUTE
            "\xDE" => "\xFE", # LATIN LETTER THORN
        );
    }

    # lower case first with parameter
    sub Elatin2::lcfirst(@) {
        if (@_) {
            my $s = shift @_;
            if (@_ and wantarray) {
                return Elatin2::lc(CORE::substr($s,0,1)) . CORE::substr($s,1), @_;
            }
            else {
                return Elatin2::lc(CORE::substr($s,0,1)) . CORE::substr($s,1);
            }
        }
        else {
            return Elatin2::lc(CORE::substr($_,0,1)) . CORE::substr($_,1);
        }
    }

    # lower case first without parameter
    sub Elatin2::lcfirst_() {
        return Elatin2::lc(CORE::substr($_,0,1)) . CORE::substr($_,1);
    }

    # lower case with parameter
    sub Elatin2::lc(@) {
        if (@_) {
            my $s = shift @_;
            if (@_ and wantarray) {
                return join('', map {defined($lc{$_}) ? $lc{$_} : $_} ($s =~ m/\G ($q_char) /oxmsg)), @_;
            }
            else {
                return join('', map {defined($lc{$_}) ? $lc{$_} : $_} ($s =~ m/\G ($q_char) /oxmsg));
            }
        }
        else {
            return Elatin2::lc_();
        }
    }

    # lower case without parameter
    sub Elatin2::lc_() {
        my $s = $_;
        return join '', map {defined($lc{$_}) ? $lc{$_} : $_} ($s =~ m/\G ($q_char) /oxmsg);
    }
}

#
# Latin-2 upper case
#
{
    my %uc = ();
    @uc{qw(a b c d e f g h i j k l m n o p q r s t u v w x y z)} =
        qw(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z);

    if (0) {
    }

    elsif (__PACKAGE__ =~ m/ \b Eusascii \z/oxms) {
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin1 \z/oxms) {
        %uc = (%uc,
            "\xE0" => "\xC0", # LATIN LETTER A WITH GRAVE
            "\xE1" => "\xC1", # LATIN LETTER A WITH ACUTE
            "\xE2" => "\xC2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xE3" => "\xC3", # LATIN LETTER A WITH TILDE
            "\xE4" => "\xC4", # LATIN LETTER A WITH DIAERESIS
            "\xE5" => "\xC5", # LATIN LETTER A WITH RING ABOVE
            "\xE6" => "\xC6", # LATIN LETTER AE
            "\xE7" => "\xC7", # LATIN LETTER C WITH CEDILLA
            "\xE8" => "\xC8", # LATIN LETTER E WITH GRAVE
            "\xE9" => "\xC9", # LATIN LETTER E WITH ACUTE
            "\xEA" => "\xCA", # LATIN LETTER E WITH CIRCUMFLEX
            "\xEB" => "\xCB", # LATIN LETTER E WITH DIAERESIS
            "\xEC" => "\xCC", # LATIN LETTER I WITH GRAVE
            "\xED" => "\xCD", # LATIN LETTER I WITH ACUTE
            "\xEE" => "\xCE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xEF" => "\xCF", # LATIN LETTER I WITH DIAERESIS
            "\xF0" => "\xD0", # LATIN LETTER ETH (Icelandic)
            "\xF1" => "\xD1", # LATIN LETTER N WITH TILDE
            "\xF2" => "\xD2", # LATIN LETTER O WITH GRAVE
            "\xF3" => "\xD3", # LATIN LETTER O WITH ACUTE
            "\xF4" => "\xD4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xF5" => "\xD5", # LATIN LETTER O WITH TILDE
            "\xF6" => "\xD6", # LATIN LETTER O WITH DIAERESIS
            "\xF8" => "\xD8", # LATIN LETTER O WITH STROKE
            "\xF9" => "\xD9", # LATIN LETTER U WITH GRAVE
            "\xFA" => "\xDA", # LATIN LETTER U WITH ACUTE
            "\xFB" => "\xDB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xFC" => "\xDC", # LATIN LETTER U WITH DIAERESIS
            "\xFD" => "\xDD", # LATIN LETTER Y WITH ACUTE
            "\xFE" => "\xDE", # LATIN LETTER THORN (Icelandic)
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin2 \z/oxms) {
        %uc = (%uc,
            "\xB1" => "\xA1", # LATIN LETTER A WITH OGONEK
            "\xB3" => "\xA3", # LATIN LETTER L WITH STROKE
            "\xB5" => "\xA5", # LATIN LETTER L WITH CARON
            "\xB6" => "\xA6", # LATIN LETTER S WITH ACUTE
            "\xB9" => "\xA9", # LATIN LETTER S WITH CARON
            "\xBA" => "\xAA", # LATIN LETTER S WITH CEDILLA
            "\xBB" => "\xAB", # LATIN LETTER T WITH CARON
            "\xBC" => "\xAC", # LATIN LETTER Z WITH ACUTE
            "\xBE" => "\xAE", # LATIN LETTER Z WITH CARON
            "\xBF" => "\xAF", # LATIN LETTER Z WITH DOT ABOVE
            "\xE0" => "\xC0", # LATIN LETTER R WITH ACUTE
            "\xE1" => "\xC1", # LATIN LETTER A WITH ACUTE
            "\xE2" => "\xC2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xE3" => "\xC3", # LATIN LETTER A WITH BREVE
            "\xE4" => "\xC4", # LATIN LETTER A WITH DIAERESIS
            "\xE5" => "\xC5", # LATIN LETTER L WITH ACUTE
            "\xE6" => "\xC6", # LATIN LETTER C WITH ACUTE
            "\xE7" => "\xC7", # LATIN LETTER C WITH CEDILLA
            "\xE8" => "\xC8", # LATIN LETTER C WITH CARON
            "\xE9" => "\xC9", # LATIN LETTER E WITH ACUTE
            "\xEA" => "\xCA", # LATIN LETTER E WITH OGONEK
            "\xEB" => "\xCB", # LATIN LETTER E WITH DIAERESIS
            "\xEC" => "\xCC", # LATIN LETTER E WITH CARON
            "\xED" => "\xCD", # LATIN LETTER I WITH ACUTE
            "\xEE" => "\xCE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xEF" => "\xCF", # LATIN LETTER D WITH CARON
            "\xF0" => "\xD0", # LATIN LETTER D WITH STROKE
            "\xF1" => "\xD1", # LATIN LETTER N WITH ACUTE
            "\xF2" => "\xD2", # LATIN LETTER N WITH CARON
            "\xF3" => "\xD3", # LATIN LETTER O WITH ACUTE
            "\xF4" => "\xD4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xF5" => "\xD5", # LATIN LETTER O WITH DOUBLE ACUTE
            "\xF6" => "\xD6", # LATIN LETTER O WITH DIAERESIS
            "\xF8" => "\xD8", # LATIN LETTER R WITH CARON
            "\xF9" => "\xD9", # LATIN LETTER U WITH RING ABOVE
            "\xFA" => "\xDA", # LATIN LETTER U WITH ACUTE
            "\xFB" => "\xDB", # LATIN LETTER U WITH DOUBLE ACUTE
            "\xFC" => "\xDC", # LATIN LETTER U WITH DIAERESIS
            "\xFD" => "\xDD", # LATIN LETTER Y WITH ACUTE
            "\xFE" => "\xDE", # LATIN LETTER T WITH CEDILLA
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin3 \z/oxms) {
        %uc = (%uc,
            "\xB1" => "\xA1", # LATIN LETTER H WITH STROKE
            "\xB6" => "\xA6", # LATIN LETTER H WITH CIRCUMFLEX
            "\xBA" => "\xAA", # LATIN LETTER S WITH CEDILLA
            "\xBB" => "\xAB", # LATIN LETTER G WITH BREVE
            "\xBC" => "\xAC", # LATIN LETTER J WITH CIRCUMFLEX
            "\xBF" => "\xAF", # LATIN LETTER Z WITH DOT ABOVE
            "\xE0" => "\xC0", # LATIN LETTER A WITH GRAVE
            "\xE1" => "\xC1", # LATIN LETTER A WITH ACUTE
            "\xE2" => "\xC2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xE4" => "\xC4", # LATIN LETTER A WITH DIAERESIS
            "\xE5" => "\xC5", # LATIN LETTER C WITH DOT ABOVE
            "\xE6" => "\xC6", # LATIN LETTER C WITH CIRCUMFLEX
            "\xE7" => "\xC7", # LATIN LETTER C WITH CEDILLA
            "\xE8" => "\xC8", # LATIN LETTER E WITH GRAVE
            "\xE9" => "\xC9", # LATIN LETTER E WITH ACUTE
            "\xEA" => "\xCA", # LATIN LETTER E WITH CIRCUMFLEX
            "\xEB" => "\xCB", # LATIN LETTER E WITH DIAERESIS
            "\xEC" => "\xCC", # LATIN LETTER I WITH GRAVE
            "\xED" => "\xCD", # LATIN LETTER I WITH ACUTE
            "\xEE" => "\xCE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xEF" => "\xCF", # LATIN LETTER I WITH DIAERESIS
            "\xF1" => "\xD1", # LATIN LETTER N WITH TILDE
            "\xF2" => "\xD2", # LATIN LETTER O WITH GRAVE
            "\xF3" => "\xD3", # LATIN LETTER O WITH ACUTE
            "\xF4" => "\xD4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xF5" => "\xD5", # LATIN LETTER G WITH DOT ABOVE
            "\xF6" => "\xD6", # LATIN LETTER O WITH DIAERESIS
            "\xF8" => "\xD8", # LATIN LETTER G WITH CIRCUMFLEX
            "\xF9" => "\xD9", # LATIN LETTER U WITH GRAVE
            "\xFA" => "\xDA", # LATIN LETTER U WITH ACUTE
            "\xFB" => "\xDB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xFC" => "\xDC", # LATIN LETTER U WITH DIAERESIS
            "\xFD" => "\xDD", # LATIN LETTER U WITH BREVE
            "\xFE" => "\xDE", # LATIN LETTER S WITH CIRCUMFLEX
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin4 \z/oxms) {
        %uc = (%uc,
            "\xB1" => "\xA1", # LATIN LETTER A WITH OGONEK
            "\xB3" => "\xA3", # LATIN LETTER R WITH CEDILLA
            "\xB5" => "\xA5", # LATIN LETTER I WITH TILDE
            "\xB6" => "\xA6", # LATIN LETTER L WITH CEDILLA
            "\xB9" => "\xA9", # LATIN LETTER S WITH CARON
            "\xBA" => "\xAA", # LATIN LETTER E WITH MACRON
            "\xBB" => "\xAB", # LATIN LETTER G WITH CEDILLA
            "\xBC" => "\xAC", # LATIN LETTER T WITH STROKE
            "\xBE" => "\xAE", # LATIN LETTER Z WITH CARON
            "\xBF" => "\xBD", # LATIN LETTER ENG
            "\xE0" => "\xC0", # LATIN LETTER A WITH MACRON
            "\xE1" => "\xC1", # LATIN LETTER A WITH ACUTE
            "\xE2" => "\xC2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xE3" => "\xC3", # LATIN LETTER A WITH TILDE
            "\xE4" => "\xC4", # LATIN LETTER A WITH DIAERESIS
            "\xE5" => "\xC5", # LATIN LETTER A WITH RING ABOVE
            "\xE6" => "\xC6", # LATIN LETTER AE
            "\xE7" => "\xC7", # LATIN LETTER I WITH OGONEK
            "\xE8" => "\xC8", # LATIN LETTER C WITH CARON
            "\xE9" => "\xC9", # LATIN LETTER E WITH ACUTE
            "\xEA" => "\xCA", # LATIN LETTER E WITH OGONEK
            "\xEB" => "\xCB", # LATIN LETTER E WITH DIAERESIS
            "\xEC" => "\xCC", # LATIN LETTER E WITH DOT ABOVE
            "\xED" => "\xCD", # LATIN LETTER I WITH ACUTE
            "\xEE" => "\xCE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xEF" => "\xCF", # LATIN LETTER I WITH MACRON
            "\xF0" => "\xD0", # LATIN LETTER D WITH STROKE
            "\xF1" => "\xD1", # LATIN LETTER N WITH CEDILLA
            "\xF2" => "\xD2", # LATIN LETTER O WITH MACRON
            "\xF3" => "\xD3", # LATIN LETTER K WITH CEDILLA
            "\xF4" => "\xD4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xF5" => "\xD5", # LATIN LETTER O WITH TILDE
            "\xF6" => "\xD6", # LATIN LETTER O WITH DIAERESIS
            "\xF8" => "\xD8", # LATIN LETTER O WITH STROKE
            "\xF9" => "\xD9", # LATIN LETTER U WITH OGONEK
            "\xFA" => "\xDA", # LATIN LETTER U WITH ACUTE
            "\xFB" => "\xDB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xFC" => "\xDC", # LATIN LETTER U WITH DIAERESIS
            "\xFD" => "\xDD", # LATIN LETTER U WITH TILDE
            "\xFE" => "\xDE", # LATIN LETTER U WITH MACRON
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Ecyrillic \z/oxms) {
        %uc = (%uc,
            "\xD0" => "\xB0", # CYRILLIC LETTER A
            "\xD1" => "\xB1", # CYRILLIC LETTER BE
            "\xD2" => "\xB2", # CYRILLIC LETTER VE
            "\xD3" => "\xB3", # CYRILLIC LETTER GHE
            "\xD4" => "\xB4", # CYRILLIC LETTER DE
            "\xD5" => "\xB5", # CYRILLIC LETTER IE
            "\xD6" => "\xB6", # CYRILLIC LETTER ZHE
            "\xD7" => "\xB7", # CYRILLIC LETTER ZE
            "\xD8" => "\xB8", # CYRILLIC LETTER I
            "\xD9" => "\xB9", # CYRILLIC LETTER SHORT I
            "\xDA" => "\xBA", # CYRILLIC LETTER KA
            "\xDB" => "\xBB", # CYRILLIC LETTER EL
            "\xDC" => "\xBC", # CYRILLIC LETTER EM
            "\xDD" => "\xBD", # CYRILLIC LETTER EN
            "\xDE" => "\xBE", # CYRILLIC LETTER O
            "\xDF" => "\xBF", # CYRILLIC LETTER PE
            "\xE0" => "\xC0", # CYRILLIC LETTER ER
            "\xE1" => "\xC1", # CYRILLIC LETTER ES
            "\xE2" => "\xC2", # CYRILLIC LETTER TE
            "\xE3" => "\xC3", # CYRILLIC LETTER U
            "\xE4" => "\xC4", # CYRILLIC LETTER EF
            "\xE5" => "\xC5", # CYRILLIC LETTER HA
            "\xE6" => "\xC6", # CYRILLIC LETTER TSE
            "\xE7" => "\xC7", # CYRILLIC LETTER CHE
            "\xE8" => "\xC8", # CYRILLIC LETTER SHA
            "\xE9" => "\xC9", # CYRILLIC LETTER SHCHA
            "\xEA" => "\xCA", # CYRILLIC LETTER HARD SIGN
            "\xEB" => "\xCB", # CYRILLIC LETTER YERU
            "\xEC" => "\xCC", # CYRILLIC LETTER SOFT SIGN
            "\xED" => "\xCD", # CYRILLIC LETTER E
            "\xEE" => "\xCE", # CYRILLIC LETTER YU
            "\xEF" => "\xCF", # CYRILLIC LETTER YA
            "\xF1" => "\xA1", # CYRILLIC LETTER IO
            "\xF2" => "\xA2", # CYRILLIC LETTER DJE
            "\xF3" => "\xA3", # CYRILLIC LETTER GJE
            "\xF4" => "\xA4", # CYRILLIC LETTER UKRAINIAN IE
            "\xF5" => "\xA5", # CYRILLIC LETTER DZE
            "\xF6" => "\xA6", # CYRILLIC LETTER BYELORUSSIAN-UKRAINIAN I
            "\xF7" => "\xA7", # CYRILLIC LETTER YI
            "\xF8" => "\xA8", # CYRILLIC LETTER JE
            "\xF9" => "\xA9", # CYRILLIC LETTER LJE
            "\xFA" => "\xAA", # CYRILLIC LETTER NJE
            "\xFB" => "\xAB", # CYRILLIC LETTER TSHE
            "\xFC" => "\xAC", # CYRILLIC LETTER KJE
            "\xFE" => "\xAE", # CYRILLIC LETTER SHORT U
            "\xFF" => "\xAF", # CYRILLIC LETTER DZHE
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Egreek \z/oxms) {
        %uc = (%uc,
            "\xDC" => "\xB6", # GREEK LETTER ALPHA WITH TONOS
            "\xDD" => "\xB8", # GREEK LETTER EPSILON WITH TONOS
            "\xDE" => "\xB9", # GREEK LETTER ETA WITH TONOS
            "\xDF" => "\xBA", # GREEK LETTER IOTA WITH TONOS
            "\xE1" => "\xC1", # GREEK LETTER ALPHA
            "\xE2" => "\xC2", # GREEK LETTER BETA
            "\xE3" => "\xC3", # GREEK LETTER GAMMA
            "\xE4" => "\xC4", # GREEK LETTER DELTA
            "\xE5" => "\xC5", # GREEK LETTER EPSILON
            "\xE6" => "\xC6", # GREEK LETTER ZETA
            "\xE7" => "\xC7", # GREEK LETTER ETA
            "\xE8" => "\xC8", # GREEK LETTER THETA
            "\xE9" => "\xC9", # GREEK LETTER IOTA
            "\xEA" => "\xCA", # GREEK LETTER KAPPA
            "\xEB" => "\xCB", # GREEK LETTER LAMDA
            "\xEC" => "\xCC", # GREEK LETTER MU
            "\xED" => "\xCD", # GREEK LETTER NU
            "\xEE" => "\xCE", # GREEK LETTER XI
            "\xEF" => "\xCF", # GREEK LETTER OMICRON
            "\xF0" => "\xD0", # GREEK LETTER PI
            "\xF1" => "\xD1", # GREEK LETTER RHO
            "\xF3" => "\xD3", # GREEK LETTER SIGMA
            "\xF4" => "\xD4", # GREEK LETTER TAU
            "\xF5" => "\xD5", # GREEK LETTER UPSILON
            "\xF6" => "\xD6", # GREEK LETTER PHI
            "\xF7" => "\xD7", # GREEK LETTER CHI
            "\xF8" => "\xD8", # GREEK LETTER PSI
            "\xF9" => "\xD9", # GREEK LETTER OMEGA
            "\xFA" => "\xDA", # GREEK LETTER IOTA WITH DIALYTIKA
            "\xFB" => "\xDB", # GREEK LETTER UPSILON WITH DIALYTIKA
            "\xFC" => "\xBC", # GREEK LETTER OMICRON WITH TONOS
            "\xFD" => "\xBE", # GREEK LETTER UPSILON WITH TONOS
            "\xFE" => "\xBF", # GREEK LETTER OMEGA WITH TONOS
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin5 \z/oxms) {
        %uc = (%uc,
            "\xE0" => "\xC0", # LATIN LETTER A WITH GRAVE
            "\xE1" => "\xC1", # LATIN LETTER A WITH ACUTE
            "\xE2" => "\xC2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xE3" => "\xC3", # LATIN LETTER A WITH TILDE
            "\xE4" => "\xC4", # LATIN LETTER A WITH DIAERESIS
            "\xE5" => "\xC5", # LATIN LETTER A WITH RING ABOVE
            "\xE6" => "\xC6", # LATIN LETTER AE
            "\xE7" => "\xC7", # LATIN LETTER C WITH CEDILLA
            "\xE8" => "\xC8", # LATIN LETTER E WITH GRAVE
            "\xE9" => "\xC9", # LATIN LETTER E WITH ACUTE
            "\xEA" => "\xCA", # LATIN LETTER E WITH CIRCUMFLEX
            "\xEB" => "\xCB", # LATIN LETTER E WITH DIAERESIS
            "\xEC" => "\xCC", # LATIN LETTER I WITH GRAVE
            "\xED" => "\xCD", # LATIN LETTER I WITH ACUTE
            "\xEE" => "\xCE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xEF" => "\xCF", # LATIN LETTER I WITH DIAERESIS
            "\xF0" => "\xD0", # LATIN LETTER G WITH BREVE
            "\xF1" => "\xD1", # LATIN LETTER N WITH TILDE
            "\xF2" => "\xD2", # LATIN LETTER O WITH GRAVE
            "\xF3" => "\xD3", # LATIN LETTER O WITH ACUTE
            "\xF4" => "\xD4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xF5" => "\xD5", # LATIN LETTER O WITH TILDE
            "\xF6" => "\xD6", # LATIN LETTER O WITH DIAERESIS
            "\xF8" => "\xD8", # LATIN LETTER O WITH STROKE
            "\xF9" => "\xD9", # LATIN LETTER U WITH GRAVE
            "\xFA" => "\xDA", # LATIN LETTER U WITH ACUTE
            "\xFB" => "\xDB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xFC" => "\xDC", # LATIN LETTER U WITH DIAERESIS
            "\xFE" => "\xDE", # LATIN LETTER S WITH CEDILLA
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin6 \z/oxms) {
        %uc = (%uc,
            "\xB1" => "\xA1", # LATIN LETTER A WITH OGONEK
            "\xB2" => "\xA2", # LATIN LETTER E WITH MACRON
            "\xB3" => "\xA3", # LATIN LETTER G WITH CEDILLA
            "\xB4" => "\xA4", # LATIN LETTER I WITH MACRON
            "\xB5" => "\xA5", # LATIN LETTER I WITH TILDE
            "\xB6" => "\xA6", # LATIN LETTER K WITH CEDILLA
            "\xB8" => "\xA8", # LATIN LETTER L WITH CEDILLA
            "\xB9" => "\xA9", # LATIN LETTER D WITH STROKE
            "\xBA" => "\xAA", # LATIN LETTER S WITH CARON
            "\xBB" => "\xAB", # LATIN LETTER T WITH STROKE
            "\xBC" => "\xAC", # LATIN LETTER Z WITH CARON
            "\xBE" => "\xAE", # LATIN LETTER U WITH MACRON
            "\xBF" => "\xAF", # LATIN LETTER ENG
            "\xE0" => "\xC0", # LATIN LETTER A WITH MACRON
            "\xE1" => "\xC1", # LATIN LETTER A WITH ACUTE
            "\xE2" => "\xC2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xE3" => "\xC3", # LATIN LETTER A WITH TILDE
            "\xE4" => "\xC4", # LATIN LETTER A WITH DIAERESIS
            "\xE5" => "\xC5", # LATIN LETTER A WITH RING ABOVE
            "\xE6" => "\xC6", # LATIN LETTER AE
            "\xE7" => "\xC7", # LATIN LETTER I WITH OGONEK
            "\xE8" => "\xC8", # LATIN LETTER C WITH CARON
            "\xE9" => "\xC9", # LATIN LETTER E WITH ACUTE
            "\xEA" => "\xCA", # LATIN LETTER E WITH OGONEK
            "\xEB" => "\xCB", # LATIN LETTER E WITH DIAERESIS
            "\xEC" => "\xCC", # LATIN LETTER E WITH DOT ABOVE
            "\xED" => "\xCD", # LATIN LETTER I WITH ACUTE
            "\xEE" => "\xCE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xEF" => "\xCF", # LATIN LETTER I WITH DIAERESIS
            "\xF0" => "\xD0", # LATIN LETTER ETH (Icelandic)
            "\xF1" => "\xD1", # LATIN LETTER N WITH CEDILLA
            "\xF2" => "\xD2", # LATIN LETTER O WITH MACRON
            "\xF3" => "\xD3", # LATIN LETTER O WITH ACUTE
            "\xF4" => "\xD4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xF5" => "\xD5", # LATIN LETTER O WITH TILDE
            "\xF6" => "\xD6", # LATIN LETTER O WITH DIAERESIS
            "\xF7" => "\xD7", # LATIN LETTER U WITH TILDE
            "\xF8" => "\xD8", # LATIN LETTER O WITH STROKE
            "\xF9" => "\xD9", # LATIN LETTER U WITH OGONEK
            "\xFA" => "\xDA", # LATIN LETTER U WITH ACUTE
            "\xFB" => "\xDB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xFC" => "\xDC", # LATIN LETTER U WITH DIAERESIS
            "\xFD" => "\xDD", # LATIN LETTER Y WITH ACUTE
            "\xFE" => "\xDE", # LATIN LETTER THORN (Icelandic)
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin7 \z/oxms) {
        %uc = (%uc,
            "\xB8" => "\xA8", # LATIN LETTER O WITH STROKE
            "\xBA" => "\xAA", # LATIN LETTER R WITH CEDILLA
            "\xBF" => "\xAF", # LATIN LETTER AE
            "\xE0" => "\xC0", # LATIN LETTER A WITH OGONEK
            "\xE1" => "\xC1", # LATIN LETTER I WITH OGONEK
            "\xE2" => "\xC2", # LATIN LETTER A WITH MACRON
            "\xE3" => "\xC3", # LATIN LETTER C WITH ACUTE
            "\xE4" => "\xC4", # LATIN LETTER A WITH DIAERESIS
            "\xE5" => "\xC5", # LATIN LETTER A WITH RING ABOVE
            "\xE6" => "\xC6", # LATIN LETTER E WITH OGONEK
            "\xE7" => "\xC7", # LATIN LETTER E WITH MACRON
            "\xE8" => "\xC8", # LATIN LETTER C WITH CARON
            "\xE9" => "\xC9", # LATIN LETTER E WITH ACUTE
            "\xEA" => "\xCA", # LATIN LETTER Z WITH ACUTE
            "\xEB" => "\xCB", # LATIN LETTER E WITH DOT ABOVE
            "\xEC" => "\xCC", # LATIN LETTER G WITH CEDILLA
            "\xED" => "\xCD", # LATIN LETTER K WITH CEDILLA
            "\xEE" => "\xCE", # LATIN LETTER I WITH MACRON
            "\xEF" => "\xCF", # LATIN LETTER L WITH CEDILLA
            "\xF0" => "\xD0", # LATIN LETTER S WITH CARON
            "\xF1" => "\xD1", # LATIN LETTER N WITH ACUTE
            "\xF2" => "\xD2", # LATIN LETTER N WITH CEDILLA
            "\xF3" => "\xD3", # LATIN LETTER O WITH ACUTE
            "\xF4" => "\xD4", # LATIN LETTER O WITH MACRON
            "\xF5" => "\xD5", # LATIN LETTER O WITH TILDE
            "\xF6" => "\xD6", # LATIN LETTER O WITH DIAERESIS
            "\xF8" => "\xD8", # LATIN LETTER U WITH OGONEK
            "\xF9" => "\xD9", # LATIN LETTER L WITH STROKE
            "\xFA" => "\xDA", # LATIN LETTER S WITH ACUTE
            "\xFB" => "\xDB", # LATIN LETTER U WITH MACRON
            "\xFC" => "\xDC", # LATIN LETTER U WITH DIAERESIS
            "\xFD" => "\xDD", # LATIN LETTER Z WITH DOT ABOVE
            "\xFE" => "\xDE", # LATIN LETTER Z WITH CARON
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin8 \z/oxms) {
        %uc = (%uc,
            "\xA2" => "\xA1", # LATIN LETTER B WITH DOT ABOVE
            "\xA5" => "\xA4", # LATIN LETTER C WITH DOT ABOVE
            "\xAB" => "\xA6", # LATIN LETTER D WITH DOT ABOVE
            "\xB1" => "\xB0", # LATIN LETTER F WITH DOT ABOVE
            "\xB3" => "\xB2", # LATIN LETTER G WITH DOT ABOVE
            "\xB5" => "\xB4", # LATIN LETTER M WITH DOT ABOVE
            "\xB8" => "\xA8", # LATIN LETTER W WITH GRAVE
            "\xB9" => "\xB7", # LATIN LETTER P WITH DOT ABOVE
            "\xBA" => "\xAA", # LATIN LETTER W WITH ACUTE
            "\xBC" => "\xAC", # LATIN LETTER Y WITH GRAVE
            "\xBE" => "\xBD", # LATIN LETTER W WITH DIAERESIS
            "\xBF" => "\xBB", # LATIN LETTER S WITH DOT ABOVE
            "\xE0" => "\xC0", # LATIN LETTER A WITH GRAVE
            "\xE1" => "\xC1", # LATIN LETTER A WITH ACUTE
            "\xE2" => "\xC2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xE3" => "\xC3", # LATIN LETTER A WITH TILDE
            "\xE4" => "\xC4", # LATIN LETTER A WITH DIAERESIS
            "\xE5" => "\xC5", # LATIN LETTER A WITH RING ABOVE
            "\xE6" => "\xC6", # LATIN LETTER AE
            "\xE7" => "\xC7", # LATIN LETTER C WITH CEDILLA
            "\xE8" => "\xC8", # LATIN LETTER E WITH GRAVE
            "\xE9" => "\xC9", # LATIN LETTER E WITH ACUTE
            "\xEA" => "\xCA", # LATIN LETTER E WITH CIRCUMFLEX
            "\xEB" => "\xCB", # LATIN LETTER E WITH DIAERESIS
            "\xEC" => "\xCC", # LATIN LETTER I WITH GRAVE
            "\xED" => "\xCD", # LATIN LETTER I WITH ACUTE
            "\xEE" => "\xCE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xEF" => "\xCF", # LATIN LETTER I WITH DIAERESIS
            "\xF0" => "\xD0", # LATIN LETTER W WITH CIRCUMFLEX
            "\xF1" => "\xD1", # LATIN LETTER N WITH TILDE
            "\xF2" => "\xD2", # LATIN LETTER O WITH GRAVE
            "\xF3" => "\xD3", # LATIN LETTER O WITH ACUTE
            "\xF4" => "\xD4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xF5" => "\xD5", # LATIN LETTER O WITH TILDE
            "\xF6" => "\xD6", # LATIN LETTER O WITH DIAERESIS
            "\xF7" => "\xD7", # LATIN LETTER T WITH DOT ABOVE
            "\xF8" => "\xD8", # LATIN LETTER O WITH STROKE
            "\xF9" => "\xD9", # LATIN LETTER U WITH GRAVE
            "\xFA" => "\xDA", # LATIN LETTER U WITH ACUTE
            "\xFB" => "\xDB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xFC" => "\xDC", # LATIN LETTER U WITH DIAERESIS
            "\xFD" => "\xDD", # LATIN LETTER Y WITH ACUTE
            "\xFE" => "\xDE", # LATIN LETTER Y WITH CIRCUMFLEX
            "\xFF" => "\xAF", # LATIN LETTER Y WITH DIAERESIS
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin9 \z/oxms) {
        %uc = (%uc,
            "\xA8" => "\xA6", # LATIN LETTER S WITH CARON
            "\xB8" => "\xB4", # LATIN LETTER Z WITH CARON
            "\xBD" => "\xBC", # LATIN LIGATURE OE
            "\xE0" => "\xC0", # LATIN LETTER A WITH GRAVE
            "\xE1" => "\xC1", # LATIN LETTER A WITH ACUTE
            "\xE2" => "\xC2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xE3" => "\xC3", # LATIN LETTER A WITH TILDE
            "\xE4" => "\xC4", # LATIN LETTER A WITH DIAERESIS
            "\xE5" => "\xC5", # LATIN LETTER A WITH RING ABOVE
            "\xE6" => "\xC6", # LATIN LETTER AE
            "\xE7" => "\xC7", # LATIN LETTER C WITH CEDILLA
            "\xE8" => "\xC8", # LATIN LETTER E WITH GRAVE
            "\xE9" => "\xC9", # LATIN LETTER E WITH ACUTE
            "\xEA" => "\xCA", # LATIN LETTER E WITH CIRCUMFLEX
            "\xEB" => "\xCB", # LATIN LETTER E WITH DIAERESIS
            "\xEC" => "\xCC", # LATIN LETTER I WITH GRAVE
            "\xED" => "\xCD", # LATIN LETTER I WITH ACUTE
            "\xEE" => "\xCE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xEF" => "\xCF", # LATIN LETTER I WITH DIAERESIS
            "\xF0" => "\xD0", # LATIN LETTER ETH
            "\xF1" => "\xD1", # LATIN LETTER N WITH TILDE
            "\xF2" => "\xD2", # LATIN LETTER O WITH GRAVE
            "\xF3" => "\xD3", # LATIN LETTER O WITH ACUTE
            "\xF4" => "\xD4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xF5" => "\xD5", # LATIN LETTER O WITH TILDE
            "\xF6" => "\xD6", # LATIN LETTER O WITH DIAERESIS
            "\xF8" => "\xD8", # LATIN LETTER O WITH STROKE
            "\xF9" => "\xD9", # LATIN LETTER U WITH GRAVE
            "\xFA" => "\xDA", # LATIN LETTER U WITH ACUTE
            "\xFB" => "\xDB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xFC" => "\xDC", # LATIN LETTER U WITH DIAERESIS
            "\xFD" => "\xDD", # LATIN LETTER Y WITH ACUTE
            "\xFE" => "\xDE", # LATIN LETTER THORN
            "\xFF" => "\xBE", # LATIN LETTER Y WITH DIAERESIS
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Elatin10 \z/oxms) {
        %uc = (%uc,
            "\xA2" => "\xA1", # LATIN LETTER A WITH OGONEK
            "\xA8" => "\xA6", # LATIN LETTER S WITH CARON
            "\xAE" => "\xAC", # LATIN LETTER Z WITH ACUTE
            "\xB3" => "\xA3", # LATIN LETTER L WITH STROKE
            "\xB8" => "\xB4", # LATIN LETTER Z WITH CARON
            "\xB9" => "\xB2", # LATIN LETTER C WITH CARON
            "\xBA" => "\xAA", # LATIN LETTER S WITH COMMA BELOW
            "\xBD" => "\xBC", # LATIN LIGATURE OE
            "\xBF" => "\xAF", # LATIN LETTER Z WITH DOT ABOVE
            "\xE0" => "\xC0", # LATIN LETTER A WITH GRAVE
            "\xE1" => "\xC1", # LATIN LETTER A WITH ACUTE
            "\xE2" => "\xC2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xE3" => "\xC3", # LATIN LETTER A WITH BREVE
            "\xE4" => "\xC4", # LATIN LETTER A WITH DIAERESIS
            "\xE5" => "\xC5", # LATIN LETTER C WITH ACUTE
            "\xE6" => "\xC6", # LATIN LETTER AE
            "\xE7" => "\xC7", # LATIN LETTER C WITH CEDILLA
            "\xE8" => "\xC8", # LATIN LETTER E WITH GRAVE
            "\xE9" => "\xC9", # LATIN LETTER E WITH ACUTE
            "\xEA" => "\xCA", # LATIN LETTER E WITH CIRCUMFLEX
            "\xEB" => "\xCB", # LATIN LETTER E WITH DIAERESIS
            "\xEC" => "\xCC", # LATIN LETTER I WITH GRAVE
            "\xED" => "\xCD", # LATIN LETTER I WITH ACUTE
            "\xEE" => "\xCE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xEF" => "\xCF", # LATIN LETTER I WITH DIAERESIS
            "\xF0" => "\xD0", # LATIN LETTER D WITH STROKE
            "\xF1" => "\xD1", # LATIN LETTER N WITH ACUTE
            "\xF2" => "\xD2", # LATIN LETTER O WITH GRAVE
            "\xF3" => "\xD3", # LATIN LETTER O WITH ACUTE
            "\xF4" => "\xD4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xF5" => "\xD5", # LATIN LETTER O WITH DOUBLE ACUTE
            "\xF6" => "\xD6", # LATIN LETTER O WITH DIAERESIS
            "\xF7" => "\xD7", # LATIN LETTER S WITH ACUTE
            "\xF8" => "\xD8", # LATIN LETTER U WITH DOUBLE ACUTE
            "\xF9" => "\xD9", # LATIN LETTER U WITH GRAVE
            "\xFA" => "\xDA", # LATIN LETTER U WITH ACUTE
            "\xFB" => "\xDB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xFC" => "\xDC", # LATIN LETTER U WITH DIAERESIS
            "\xFD" => "\xDD", # LATIN LETTER E WITH OGONEK
            "\xFE" => "\xDE", # LATIN LETTER T WITH COMMA BELOW
            "\xFF" => "\xBE", # LATIN LETTER Y WITH DIAERESIS
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Ewindows1252 \z/oxms) {
        %uc = (%uc,
            "\x9A" => "\x8A", # LATIN LETTER S WITH CARON
            "\x9C" => "\x8C", # LATIN LIGATURE OE
            "\x9E" => "\x8E", # LATIN LETTER Z WITH CARON
            "\xE0" => "\xC0", # LATIN LETTER A WITH GRAVE
            "\xE1" => "\xC1", # LATIN LETTER A WITH ACUTE
            "\xE2" => "\xC2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xE3" => "\xC3", # LATIN LETTER A WITH TILDE
            "\xE4" => "\xC4", # LATIN LETTER A WITH DIAERESIS
            "\xE5" => "\xC5", # LATIN LETTER A WITH RING ABOVE
            "\xE6" => "\xC6", # LATIN LETTER AE
            "\xE7" => "\xC7", # LATIN LETTER C WITH CEDILLA
            "\xE8" => "\xC8", # LATIN LETTER E WITH GRAVE
            "\xE9" => "\xC9", # LATIN LETTER E WITH ACUTE
            "\xEA" => "\xCA", # LATIN LETTER E WITH CIRCUMFLEX
            "\xEB" => "\xCB", # LATIN LETTER E WITH DIAERESIS
            "\xEC" => "\xCC", # LATIN LETTER I WITH GRAVE
            "\xED" => "\xCD", # LATIN LETTER I WITH ACUTE
            "\xEE" => "\xCE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xEF" => "\xCF", # LATIN LETTER I WITH DIAERESIS
            "\xF0" => "\xD0", # LATIN LETTER ETH
            "\xF1" => "\xD1", # LATIN LETTER N WITH TILDE
            "\xF2" => "\xD2", # LATIN LETTER O WITH GRAVE
            "\xF3" => "\xD3", # LATIN LETTER O WITH ACUTE
            "\xF4" => "\xD4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xF5" => "\xD5", # LATIN LETTER O WITH TILDE
            "\xF6" => "\xD6", # LATIN LETTER O WITH DIAERESIS
            "\xF8" => "\xD8", # LATIN LETTER O WITH STROKE
            "\xF9" => "\xD9", # LATIN LETTER U WITH GRAVE
            "\xFA" => "\xDA", # LATIN LETTER U WITH ACUTE
            "\xFB" => "\xDB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xFC" => "\xDC", # LATIN LETTER U WITH DIAERESIS
            "\xFD" => "\xDD", # LATIN LETTER Y WITH ACUTE
            "\xFE" => "\xDE", # LATIN LETTER THORN
            "\xFF" => "\x9F", # LATIN LETTER Y WITH DIAERESIS
        );
    }

    # upper case first with parameter
    sub Elatin2::ucfirst(@) {
        if (@_) {
            my $s = shift @_;
            if (@_ and wantarray) {
                return Elatin2::uc(CORE::substr($s,0,1)) . CORE::substr($s,1), @_;
            }
            else {
                return Elatin2::uc(CORE::substr($s,0,1)) . CORE::substr($s,1);
            }
        }
        else {
            return Elatin2::uc(CORE::substr($_,0,1)) . CORE::substr($_,1);
        }
    }

    # upper case first without parameter
    sub Elatin2::ucfirst_() {
        return Elatin2::uc(CORE::substr($_,0,1)) . CORE::substr($_,1);
    }

    # upper case with parameter
    sub Elatin2::uc(@) {
        if (@_) {
            my $s = shift @_;
            if (@_ and wantarray) {
                return join('', map {defined($uc{$_}) ? $uc{$_} : $_} ($s =~ m/\G ($q_char) /oxmsg)), @_;
            }
            else {
                return join('', map {defined($uc{$_}) ? $uc{$_} : $_} ($s =~ m/\G ($q_char) /oxmsg));
            }
        }
        else {
            return Elatin2::uc_();
        }
    }

    # upper case without parameter
    sub Elatin2::uc_() {
        my $s = $_;
        return join '', map {defined($uc{$_}) ? $uc{$_} : $_} ($s =~ m/\G ($q_char) /oxmsg);
    }
}

#
# Latin-2 regexp capture
#
{
    sub Elatin2::capture($) {
        return $_[0];
    }
}

#
# Latin-2 regexp ignore case modifier
#
sub Elatin2::ignorecase(@) {

    my @string = @_;
    my $metachar = qr/[\@\\|[\]{]/oxms;

    # ignore case of $scalar or @array
    for my $string (@string) {

        # split regexp
        my @char = $string =~ m{\G(
            \[\^ |
                \\? (?:$q_char)
        )}oxmsg;

        # unescape character
        for (my $i=0; $i <= $#char; $i++) {
            next if not defined $char[$i];

            # open character class [...]
            if ($char[$i] eq '[') {
                my $left = $i;

                # [] make die "unmatched [] in regexp ..."

                if ($char[$i+1] eq ']') {
                    $i++;
                }

                while (1) {
                    if (++$i > $#char) {
                        croak "$0: unmatched [] in regexp";
                    }
                    if ($char[$i] eq ']') {
                        my $right = $i;
                        my @charlist = charlist_qr(@char[$left+1..$right-1], 'i');

                        # escape character
                        for my $char (@charlist) {

                            # do not use quotemeta here
                            if ($char =~ m/\A ([\x80-\xFF].*) ($metachar) \z/oxms) {
                                $char = $1 . '\\' . $2;
                            }
                            elsif ($char =~ m/\A [.|)] \z/oxms) {
                                $char = $1 . '\\' . $char;
                            }
                        }

                        # [...]
                        splice @char, $left, $right-$left+1, '(?:' . join('|', @charlist) . ')';

                        $i = $left;
                        last;
                    }
                }
            }

            # open character class [^...]
            elsif ($char[$i] eq '[^') {
                my $left = $i;

                # [^] make die "unmatched [] in regexp ..."

                if ($char[$i+1] eq ']') {
                    $i++;
                }

                while (1) {
                    if (++$i > $#char) {
                        croak "$0: unmatched [] in regexp";
                    }
                    if ($char[$i] eq ']') {
                        my $right = $i;
                        my @charlist = charlist_not_qr(@char[$left+1..$right-1], 'i');

                        # escape character
                        for my $char (@charlist) {

                            # do not use quotemeta here
                            if ($char =~ m/\A ([\x80-\xFF].*) ($metachar) \z/oxms) {
                                $char = $1 . '\\' . $2;
                            }
                            elsif ($char =~ m/\A [.|)] \z/oxms) {
                                $char = '\\' . $char;
                            }
                        }

                        # [^...]
                        splice @char, $left, $right-$left+1, '(?!' . join('|', @charlist) . ")(?:$your_char)";

                        $i = $left;
                        last;
                    }
                }
            }

            # rewrite character class or escape character
            elsif (my $char = {
                '\D' => '(?:[^0-9])',
                '\S' => '(?:[^\x09\x0A\x0C\x0D\x20])',
                '\W' => '(?:[^0-9A-Z_a-z])',
                '\d' => '[0-9]',
                '\s' => '[\x09\x0A\x0C\x0D\x20]',
                '\w' => '[0-9A-Z_a-z]',

                # \h \v \H \V
                #
                # P.114 Character Class Shortcuts
                # in Chapter 7: In the World of Regular Expressions
                # of ISBN 978-0-596-52010-6 Learning Perl, Fifth Edition

                '\H' => '(?:[^\x09\x20])',
                '\V' => '(?:[^\x0C\x0A\x0D])',
                '\h' => '[\x09\x20]',
                '\v' => '[\x0C\x0A\x0D]',

                # \b \B
                #
                # P.131 Word boundaries: \b, \B, \<, \>, ...
                # in Chapter 3: Overview of Regular Expression Features and Flavors
                # of ISBN 0-596-00289-0 Mastering Regular Expressions, Second edition

                # '\b' => '(?:(?<=\A|\W)(?=\w)|(?<=\w)(?=\W|\z))',
                '\b' => '(?:\A(?=[0-9A-Z_a-z])|(?<=[\x00-\x2F\x40\x5B-\x5E\x60\x7B-\xFF])(?=[0-9A-Z_a-z])|(?<=[0-9A-Z_a-z])(?=[\x00-\x2F\x40\x5B-\x5E\x60\x7B-\xFF]|\z))',

                # '\B' => '(?:(?<=\w)(?=\w)|(?<=\W)(?=\W))',
                '\B' => '(?:(?<=[0-9A-Z_a-z])(?=[0-9A-Z_a-z])|(?<=[\x00-\x2F\x40\x5B-\x5E\x60\x7B-\xFF])(?=[\x00-\x2F\x40\x5B-\x5E\x60\x7B-\xFF]))',

                }->{$char[$i]}
            ) {
                $char[$i] = $char;
            }

            # /i modifier
            elsif ($char[$i] =~ m/\A [\x00-\xFF] \z/oxms) {
                my $uc = Elatin2::uc($char[$i]);
                my $lc = Elatin2::lc($char[$i]);
                if ($uc ne $lc) {
                    $char[$i] = '[' . $uc . $lc . ']';
                }
            }
        }

        # characterize
        for (my $i=0; $i <= $#char; $i++) {
            next if not defined $char[$i];

            # escape last octet of multiple octet
            if ($char[$i] =~ m/\A ([\x80-\xFF].*) ($metachar) \z/oxms) {
                $char[$i] = $1 . '\\' . $2;
            }

            # quote character before ? + * {
            elsif (($i >= 1) and ($char[$i] =~ m/\A [\?\+\*\{] \z/oxms)) {
                if ($char[$i-1] !~ m/\A [\x00-\xFF] \z/oxms) {
                    $char[$i-1] = '(?:' . $char[$i-1] . ')';
                }
            }
        }

        $string = join '', @char;
    }

    # make regexp string
    return @string;
}

#
# prepare Latin-2 characters per length
#

# 1 octet characters
my @chars1 = ();
sub chars1 {
    if (@chars1) {
        return @chars1;
    }
    if (exists $range_tr{1}) {
        my @ranges = @{ $range_tr{1} };
        while (my @range = splice(@ranges,0,1)) {
            for my $oct0 (@{$range[0]}) {
                push @chars1, pack 'C', $oct0;
            }
        }
    }
    return @chars1;
}

# 2 octets characters
my @chars2 = ();
sub chars2 {
    if (@chars2) {
        return @chars2;
    }
    if (exists $range_tr{2}) {
        my @ranges = @{ $range_tr{2} };
        while (my @range = splice(@ranges,0,2)) {
            for my $oct0 (@{$range[0]}) {
                for my $oct1 (@{$range[1]}) {
                    push @chars2, pack 'CC', $oct0,$oct1;
                }
            }
        }
    }
    return @chars2;
}

# 3 octets characters
my @chars3 = ();
sub chars3 {
    if (@chars3) {
        return @chars3;
    }
    if (exists $range_tr{3}) {
        my @ranges = @{ $range_tr{3} };
        while (my @range = splice(@ranges,0,3)) {
            for my $oct0 (@{$range[0]}) {
                for my $oct1 (@{$range[1]}) {
                    for my $oct2 (@{$range[2]}) {
                        push @chars3, pack 'CCC', $oct0,$oct1,$oct2;
                    }
                }
            }
        }
    }
    return @chars3;
}

# 4 octets characters
my @chars4 = ();
sub chars4 {
    if (@chars4) {
        return @chars4;
    }
    if (exists $range_tr{4}) {
        my @ranges = @{ $range_tr{4} };
        while (my @range = splice(@ranges,0,4)) {
            for my $oct0 (@{$range[0]}) {
                for my $oct1 (@{$range[1]}) {
                    for my $oct2 (@{$range[2]}) {
                        for my $oct3 (@{$range[3]}) {
                            push @chars4, pack 'CCCC', $oct0,$oct1,$oct2,$oct3;
                        }
                    }
                }
            }
        }
    }
    return @chars4;
}

# minimum value of each octet
my @minchar = ();
sub minchar {
    if (defined $minchar[$_[0]]) {
        return $minchar[$_[0]];
    }
    $minchar[$_[0]] = (&{(sub {}, \&chars1, \&chars2, \&chars3, \&chars4)[$_[0]]})[0];
}

# maximum value of each octet
my @maxchar = ();
sub maxchar {
    if (defined $maxchar[$_[0]]) {
        return $maxchar[$_[0]];
    }
    $maxchar[$_[0]] = (&{(sub {}, \&chars1, \&chars2, \&chars3, \&chars4)[$_[0]]})[-1];
}

#
# Latin-2 open character list for tr
#
sub _charlist_tr {

    local $_ = shift @_;

    # unescape character
    my @char = ();
    while (not m/\G \z/oxmsgc) {
        if (m/\G (\\0?55|\\x2[Dd]|\\-) /oxmsgc) {
            push @char, '\-';
        }
        elsif (m/\G \\ ([0-7]{2,3}) /oxmsgc) {
            push @char, CORE::chr(oct $1);
        }
        elsif (m/\G \\x ([0-9A-Fa-f]{1,2}) /oxmsgc) {
            push @char, CORE::chr(hex $1);
        }
        elsif (m/\G \\c ([\x40-\x5F]) /oxmsgc) {
            push @char, CORE::chr(CORE::ord($1) & 0x1F);
        }
        elsif (m/\G (\\ [0nrtfbae]) /oxmsgc) {
            push @char, {
                '\0' => "\0",
                '\n' => "\n",
                '\r' => "\r",
                '\t' => "\t",
                '\f' => "\f",
                '\b' => "\x08", # \b means backspace in character class
                '\a' => "\a",
                '\e' => "\e",
            }->{$1};
        }
        elsif (m/\G \\ ($q_char) /oxmsgc) {
            push @char, $1;
        }
        elsif (m/\G ($q_char) /oxmsgc) {
            push @char, $1;
        }
    }

    # join separated multiple octet
    @char = join('',@char) =~ m/\G (\\-|$q_char) /oxmsg;

    # unescape '-'
    my @i = ();
    for my $i (0 .. $#char) {
        if ($char[$i] eq '\-') {
            $char[$i] = '-';
        }
        elsif ($char[$i] eq '-') {
            if ((0 < $i) and ($i < $#char)) {
                push @i, $i;
            }
        }
    }

    # open character list (reverse for splice)
    for my $i (CORE::reverse @i) {
        my @range = ();

        # range error
        if ((length($char[$i-1]) > length($char[$i+1])) or ($char[$i-1] gt $char[$i+1])) {
            croak "$0: invalid [] range \"\\x" . unpack('H*',$char[$i-1]) . '-\\x' . unpack('H*',$char[$i+1]) . '" in regexp';
        }

        # range of multiple octet code
        if (length($char[$i-1]) == 1) {
            if (length($char[$i+1]) == 1) {
                push @range, grep {($char[$i-1] le $_) and ($_ le $char[$i+1])} &chars1();
            }
            elsif (length($char[$i+1]) == 2) {
                push @range, grep {$char[$i-1] le $_}                           &chars1();
                push @range, grep {$_ le $char[$i+1]}                           &chars2();
            }
            elsif (length($char[$i+1]) == 3) {
                push @range, grep {$char[$i-1] le $_}                           &chars1();
                push @range,                                                    &chars2();
                push @range, grep {$_ le $char[$i+1]}                           &chars3();
            }
            elsif (length($char[$i+1]) == 4) {
                push @range, grep {$char[$i-1] le $_}                           &chars1();
                push @range,                                                    &chars2();
                push @range,                                                    &chars3();
                push @range, grep {$_ le $char[$i+1]}                           &chars4();
            }
        }
        elsif (length($char[$i-1]) == 2) {
            if (length($char[$i+1]) == 2) {
                push @range, grep {($char[$i-1] le $_) and ($_ le $char[$i+1])} &chars2();
            }
            elsif (length($char[$i+1]) == 3) {
                push @range, grep {$char[$i-1] le $_}                           &chars2();
                push @range, grep {$_ le $char[$i+1]}                           &chars3();
            }
            elsif (length($char[$i+1]) == 4) {
                push @range, grep {$char[$i-1] le $_}                           &chars2();
                push @range,                                                    &chars3();
                push @range, grep {$_ le $char[$i+1]}                           &chars4();
            }
        }
        elsif (length($char[$i-1]) == 3) {
            if (length($char[$i+1]) == 3) {
                push @range, grep {($char[$i-1] le $_) and ($_ le $char[$i+1])} &chars3();
            }
            elsif (length($char[$i+1]) == 4) {
                push @range, grep {$char[$i-1] le $_}                           &chars3();
                push @range, grep {$_ le $char[$i+1]}                           &chars4();
            }
        }
        elsif (length($char[$i-1]) == 4) {
            if (length($char[$i+1]) == 4) {
                push @range, grep {($char[$i-1] le $_) and ($_ le $char[$i+1])} &chars4();
            }
        }

        splice @char, $i-1, 3, @range;
    }

    return @char;
}

#
# Latin-2 octet range
#
sub _octets {

    my $modifier = pop @_;
    my $length = shift;

    my($a) = unpack 'C', $_[0];
    my($z) = unpack 'C', $_[1];

    # single octet code
    if ($length == 1) {

        # single octet and ignore case
        if (((caller(1))[3] ne 'Elatin2::_octets') and ($modifier =~ m/i/oxms)) {
            if ($a == $z) {
                return sprintf('(?i:\x%02X)',          $a);
            }
            elsif (($a+1) == $z) {
                return sprintf('(?i:[\x%02X\x%02X])',  $a, $z);
            }
            else {
                return sprintf('(?i:[\x%02X-\x%02X])', $a, $z);
            }
        }

        # not ignore case or one of multiple octet
        else {
            if ($a == $z) {
                return sprintf('\x%02X',          $a);
            }
            elsif (($a+1) == $z) {
                return sprintf('[\x%02X\x%02X]',  $a, $z);
            }
            else {
                return sprintf('[\x%02X-\x%02X]', $a, $z);
            }
        }
    }
}

#
# Latin-2 open character list for qr and not qr
#
sub _charlist {

    my $modifier = pop @_;
    my @char = @_;

    # unescape character
    for (my $i=0; $i <= $#char; $i++) {

        # escape - to ...
        if ($char[$i] eq '-') {
            if ((0 < $i) and ($i < $#char)) {
                $char[$i] = '...';
            }
        }
        elsif ($char[$i] =~ m/\A \\ ([0-7]{2,3}) \z/oxms) {
            $char[$i] = CORE::chr oct $1;
        }
        elsif ($char[$i] =~ m/\A \\x ([0-9A-Fa-f]{1,2}) \z/oxms) {
            $char[$i] = CORE::chr hex $1;
        }
        elsif ($char[$i] =~ m/\A \\c ([\x40-\x5F]) \z/oxms) {
            $char[$i] = CORE::chr(CORE::ord($1) & 0x1F);
        }
        elsif ($char[$i] =~ m/\A (\\ [0nrtfbaedDhHsSvVwW]) \z/oxms) {
            $char[$i] = {
                '\0' => "\0",
                '\n' => "\n",
                '\r' => "\r",
                '\t' => "\t",
                '\f' => "\f",
                '\b' => "\x08", # \b means backspace in character class
                '\a' => "\a",
                '\e' => "\e",
                '\d' => '[0-9]',
                '\s' => '[\x09\x0A\x0C\x0D\x20]',
                '\w' => '[0-9A-Z_a-z]',
                '\D' => '(?:[^0-9])',
                '\S' => '(?:[^\x09\x0A\x0C\x0D\x20])',
                '\W' => '(?:[^0-9A-Z_a-z])',

                '\H' => '(?:[^\x09\x20])',
                '\V' => '(?:[^\x0C\x0A\x0D])',
                '\h' => '[\x09\x20]',
                '\v' => '[\x0C\x0A\x0D]',

            }->{$1};
        }
        elsif ($char[$i] =~ m/\A \\ ($q_char) \z/oxms) {
            $char[$i] = $1;
        }
    }

    # open character list
    my @singleoctet = ();
    my @charlist    = ();
    for (my $i=0; $i <= $#char; ) {

        # escaped -
        if (defined($char[$i+1]) and ($char[$i+1] eq '...')) {
            $i += 1;
            next;
        }
        elsif ($char[$i] eq '...') {

            # range error
            if ((length($char[$i-1]) > length($char[$i+1])) or ($char[$i-1] gt $char[$i+1])) {
                croak "$0: invalid [] range \"\\x" . unpack('H*',$char[$i-1]) . '-\\x' . unpack('H*',$char[$i+1]) . '" in regexp';
            }

            # range of single octet code and not ignore case
            if ((length($char[$i-1]) == 1) and (length($char[$i+1]) == 1) and ($modifier !~ m/i/oxms)) {
                my $a = unpack 'C', $char[$i-1];
                my $z = unpack 'C', $char[$i+1];

                if ($a == $z) {
                    push @singleoctet, sprintf('\x%02X',        $a);
                }
                elsif (($a+1) == $z) {
                    push @singleoctet, sprintf('\x%02X\x%02X',  $a, $z);
                }
                else {
                    push @singleoctet, sprintf('\x%02X-\x%02X', $a, $z);
                }
            }

            # range of multiple octet code
            elsif (length($char[$i-1]) == length($char[$i+1])) {
                push @charlist, _octets(length($char[$i-1]), $char[$i-1], $char[$i+1], $modifier);
            }
            elsif (length($char[$i-1]) == 1) {
                if (length($char[$i+1]) == 2) {
                    push @charlist,
                        _octets(1, $char[$i-1], &maxchar(1), $modifier),
                        _octets(2, &minchar(2), $char[$i+1], $modifier);
                }
                elsif (length($char[$i+1]) == 3) {
                    push @charlist,
                        _octets(1, $char[$i-1], &maxchar(1), $modifier),
                        _octets(2, &minchar(2), &maxchar(2), $modifier),
                        _octets(3, &minchar(3), $char[$i+1], $modifier);
                }
                elsif (length($char[$i+1]) == 4) {
                    push @charlist,
                        _octets(1, $char[$i-1], &maxchar(1), $modifier),
                        _octets(2, &minchar(2), &maxchar(2), $modifier),
                        _octets(3, &minchar(3), &maxchar(3), $modifier),
                        _octets(4, &minchar(4), $char[$i+1], $modifier);
                }
            }
            elsif (length($char[$i-1]) == 2) {
                if (length($char[$i+1]) == 3) {
                    push @charlist,
                        _octets(2, $char[$i-1], &maxchar(2), $modifier),
                        _octets(3, &minchar(3), $char[$i+1], $modifier);
                }
                elsif (length($char[$i+1]) == 4) {
                    push @charlist,
                        _octets(2, $char[$i-1], &maxchar(2), $modifier),
                        _octets(3, &minchar(3), &maxchar(3), $modifier),
                        _octets(4, &minchar(4), $char[$i+1], $modifier);
                }
            }
            elsif (length($char[$i-1]) == 3) {
                if (length($char[$i+1]) == 4) {
                    push @charlist,
                        _octets(3, $char[$i-1], &maxchar(3), $modifier),
                        _octets(4, &minchar(4), $char[$i+1], $modifier);
                }
            }
            else {
                croak "$0: invalid [] range \"\\x" . unpack('H*',$char[$i-1]) . '-\\x' . unpack('H*',$char[$i+1]) . '" in regexp';
            }

            $i += 2;
        }

        # /i modifier
        elsif ($char[$i] =~ m/\A [\x00-\xFF] \z/oxms) {
            if ($modifier =~ m/i/oxms) {
                my $uc = Elatin2::uc($char[$i]);
                my $lc = Elatin2::lc($char[$i]);
                if ($uc ne $lc) {
                    push @singleoctet, $uc, $lc;
                }
                else {
                    push @singleoctet, $char[$i];
                }
            }
            else {
                push @singleoctet, $char[$i];
            }
            $i += 1;
        }

        # single character of single octet code

        # \h \v
        #
        # P.114 Character Class Shortcuts
        # in Chapter 7: In the World of Regular Expressions
        # of ISBN 978-0-596-52010-6 Learning Perl, Fifth Edition

        elsif ($char[$i] =~ m/\A (?: \\h ) \z/oxms) {
            push @singleoctet, "\t", "\x20";
            $i += 1;
        }
        elsif ($char[$i] =~ m/\A (?: \\v ) \z/oxms) {
            push @singleoctet, "\f","\n","\r";
            $i += 1;
        }
        elsif ($char[$i] =~ m/\A (?: [\x00-\xFF] | \\d | \\s | \\w ) \z/oxms) {
            push @singleoctet, $char[$i];
            $i += 1;
        }

        # single character of multiple octet code
        else {
            push @charlist, $char[$i];
            $i += 1;
        }
    }

    # quote metachar
    for (@singleoctet) {
        if (m/\A \n \z/oxms) {
            $_ = '\n';
        }
        elsif (m/\A \r \z/oxms) {
            $_ = '\r';
        }
        elsif (m/\A ([\x00-\x20\x7F-\xFF]) \z/oxms) {
            $_ = sprintf('\x%02X', CORE::ord $1);
        }
        elsif (m/\A [\x00-\xFF] \z/oxms) {
            $_ = quotemeta $_;
        }
    }

    # return character list
    return \@singleoctet, \@charlist;
}

#
# Latin-2 open character list for qr
#
sub charlist_qr {

    my $modifier = pop @_;
    my @char = @_;

    my($singleoctet, $charlist) = _charlist(@char, $modifier);
    my @singleoctet = @$singleoctet;
    my @charlist    = @$charlist;

    # return character list
    if (scalar(@singleoctet) == 0) {
    }
    elsif (scalar(@singleoctet) >= 2) {
        push @charlist, '[' . join('',@singleoctet) . ']';
    }
    elsif ($singleoctet[0] =~ m/ . - . /oxms) {
        push @charlist, '[' . $singleoctet[0] . ']';
    }
    else {
        push @charlist, $singleoctet[0];
    }
    if (scalar(@charlist) >= 2) {
        return '(?:' . join('|', @charlist) . ')';
    }
    else {
        return $charlist[0];
    }
}

#
# Latin-2 open character list for not qr
#
sub charlist_not_qr {

    my $modifier = pop @_;
    my @char = @_;

    my($singleoctet, $charlist) = _charlist(@char, $modifier);
    my @singleoctet = @$singleoctet;
    my @charlist    = @$charlist;

    # return character list
    if (scalar(@charlist) >= 1) {
        if (scalar(@singleoctet) >= 1) {

            # any character other than multiple octet and single octet character class
            return '(?!' . join('|', @charlist) . ')(?:[^'. join('', @singleoctet) . '])';
        }
        else {

            # any character other than multiple octet character class
            return '(?!' . join('|', @charlist) . ")(?:$your_char)";
        }
    }
    else {
        if (scalar(@singleoctet) >= 1) {

            # any character other than single octet character class
            return                                 '(?:[^'. join('', @singleoctet) . '])';
        }
        else {

            # any character
            return                                 "(?:$your_char)";
        }
    }
}

#
# Latin-2 order to character (with parameter)
#
sub Elatin2::chr(;$) {

    my $c = @_ ? $_[0] : $_;

    if ($c == 0x00) {
        return "\x00";
    }
    else {
        my @chr = ();
        while ($c > 0) {
            unshift @chr, ($c % 0x100);
            $c = int($c / 0x100);
        }
        return pack 'C*', @chr;
    }
}

#
# Latin-2 order to character (without parameter)
#
sub Elatin2::chr_() {

    my $c = $_;

    if ($c == 0x00) {
        return "\x00";
    }
    else {
        my @chr = ();
        while ($c > 0) {
            unshift @chr, ($c % 0x100);
            $c = int($c / 0x100);
        }
        return pack 'C*', @chr;
    }
}

#
# Latin-2 path globbing (with parameter)
#
sub Elatin2::glob($) {

    return _dosglob(@_);
}

#
# Latin-2 path globbing (without parameter)
#
sub Elatin2::glob_() {

    return _dosglob();
}

#
# Latin-2 path globbing from File::DosGlob module
#
my %iter;
my %entries;
sub _dosglob {

    # context (keyed by second cxix argument provided by core)
    my($expr,$cxix) = @_;

    # glob without args defaults to $_
    $expr = $_ if not defined $expr;

    # represents the current user's home directory
    #
    # 7.3. Expanding Tildes in Filenames
    # in Chapter 7. File Access
    # of ISBN 0-596-00313-7 Perl Cookbook, 2nd Edition.
    #
    # and File::HomeDir, File::HomeDir::Windows module

    # DOS-like system
    if ($^O =~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms) {
        $expr =~ s{ \A ~ (?= [^/\\] ) }
                  { $ENV{'HOME'} || $ENV{'USERPROFILE'} || "$ENV{'HOMEDRIVE'}$ENV{'HOMEPATH'}" }oxmse;
    }

    # UNIX-like system
    else {
        $expr =~ s{ \A ~ ( (?:[^/])* ) }
                  { $1 ? (getpwnam($1))[7] : ($ENV{'HOME'} || $ENV{'LOGDIR'} || (getpwuid($<))[7]) }oxmse;
    }

    # assume global context if not provided one
    $cxix = '_G_' if not defined $cxix;
    $iter{$cxix} = 0 if not exists $iter{$cxix};

    # if we're just beginning, do it all first
    if ($iter{$cxix} == 0) {
            $entries{$cxix} = [ _do_glob(1, _parse_line($expr)) ];
    }

    # chuck it all out, quick or slow
    if (wantarray) {
        delete $iter{$cxix};
        return @{delete $entries{$cxix}};
    }
    else {
        if ($iter{$cxix} = scalar @{$entries{$cxix}}) {
            return shift @{$entries{$cxix}};
        }
        else {
            # return undef for EOL
            delete $iter{$cxix};
            delete $entries{$cxix};
            return undef;
        }
    }
}

#
# Latin-2 path globbing subroutine
#
sub _do_glob {

    my($cond,@expr) = @_;
    my @glob = ();

OUTER:
    for my $expr (@expr) {
        next OUTER if not defined $expr;
        next OUTER if $expr eq '';

        my @matched = ();
        my @globdir = ();
        my $head    = '.';
        my $pathsep = '/';
        my $tail;

        # if argument is within quotes strip em and do no globbing
        if ($expr =~ m/\A " ((?:$q_char)*) " \z/oxms) {
            $expr = $1;
            if ($cond eq 'd') {
                if (-d $expr) {
                    push @glob, $expr;
                }
            }
            else {
                if (-e $expr) {
                    push @glob, $expr;
                }
            }
            next OUTER;
        }

        # wildcards with a drive prefix such as h:*.pm must be changed
        # to h:./*.pm to expand correctly
        if ($^O =~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms) {
            $expr =~ s# \A ((?:[A-Za-z]:)?) ([^/\\]) #$1./$2#oxms;
        }

        if (($head, $tail) = _parse_path($expr,$pathsep)) {
            if ($tail eq '') {
                push @glob, $expr;
                next OUTER;
            }
            if ($head =~ m/ \A (?:$q_char)*? [*?] /oxms) {
                if (@globdir = _do_glob('d', $head)) {
                    push @glob, _do_glob($cond, map {"$_$pathsep$tail"} @globdir);
                    next OUTER;
                }
            }
            if ($head eq '' or $head =~ m/\A [A-Za-z]: \z/oxms) {
                $head .= $pathsep;
            }
            $expr = $tail;
        }

        # If file component has no wildcards, we can avoid opendir
        if ($expr !~ m/ \A (?:$q_char)*? [*?] /oxms) {
            if ($head eq '.') {
                $head = '';
            }
            if ($head ne '' and ($head =~ m/ \G ($q_char) /oxmsg)[-1] ne $pathsep) {
                $head .= $pathsep;
            }
            $head .= $expr;
            if ($cond eq 'd') {
                if (-d $head) {
                    push @glob, $head;
                }
            }
            else {
                if (-e $head) {
                    push @glob, $head;
                }
            }
            next OUTER;
        }
        opendir(*DIR, $head) or next OUTER;
        my @leaf = readdir DIR;
        closedir DIR;

        if ($head eq '.') {
            $head = '';
        }
        if ($head ne '' and ($head =~ m/ \G ($q_char) /oxmsg)[-1] ne $pathsep) {
            $head .= $pathsep;
        }

        my $pattern = '';
        while ($expr =~ m/ \G ($q_char) /oxgc) {
            my $char = $1;
            if ($char eq '*') {
                $pattern .= "(?:$your_char)*",
            }
            elsif ($char eq '?') {
                $pattern .= "(?:$your_char)?",  # DOS style
#               $pattern .= "(?:$your_char)",   # UNIX style
            }
            elsif ((my $uc = Elatin2::uc($char)) ne $char) {
                $pattern .= $uc;
            }
            else {
                $pattern .= quotemeta $char;
            }
        }
        my $matchsub = sub { Elatin2::uc($_[0]) =~ m{\A $pattern \z}xms };

#       if ($@) {
#           print STDERR "$0: $@\n";
#           next OUTER;
#       }

INNER:
        for my $leaf (@leaf) {
            if ($leaf eq '.' or $leaf eq '..') {
                next INNER;
            }
            if ($cond eq 'd' and not -d "$head$leaf") {
                next INNER;
            }

            if (&$matchsub($leaf)) {
                push @matched, "$head$leaf";
                next INNER;
            }

            # [DOS compatibility special case]
            # Failed, add a trailing dot and try again, but only...

            if (Elatin2::index($leaf,'.') == -1 and   # if name does not have a dot in it *and*
                CORE::length($leaf) <= 8 and        # name is shorter than or equal to 8 chars *and*
                Elatin2::index($pattern,'\\.') != -1  # pattern has a dot.
            ) {
                if (&$matchsub("$leaf.")) {
                    push @matched, "$head$leaf";
                    next INNER;
                }
            }
        }
        if (@matched) {
            push @glob, @matched;
        }
    }
    return @glob;
}

#
# Latin-2 parse line
#
sub _parse_line {

    my($line) = @_;

    $line .= ' ';
    my @piece = ();
    while ($line =~ m{
        " ( (?: [^"]   )*  ) " \s+ |
          ( (?: [^"\s] )*  )   \s+
        }oxmsg
    ) {
        push @piece, defined($1) ? $1 : $2;
    }
    return @piece;
}

#
# Latin-2 parse path
#
sub _parse_path {

    my($path,$pathsep) = @_;

    $path .= '/';
    my @subpath = ();
    while ($path =~ m{
        ((?: [^/\\] )+?) [/\\] }oxmsg
    ) {
        push @subpath, $1;
    }

    my $tail = pop @subpath;
    my $head = join $pathsep, @subpath;
    return $head, $tail;
}

#
# instead of binmode (for perl5.005 only)
#
sub Elatin2::binmode(*;$) {
    if (@_ == 1) {
        local $^W = 0;
        if (ref $_[0]) {
            my $filehandle = qualify_to_ref $_[0];
            return eval { CORE::binmode $filehandle; };
        }
        else {
            return eval { CORE::binmode *{(caller(1))[0] . "::$_[0]"}; };
        }
    }
    elsif (@_ == 2) {
        my(undef,$layer) = @_;
        $layer =~ s/ :? encoding\($encoding_alias\) //oxms;
        if ($layer =~ m/\A :raw \z/oxms) {
            local $^W = 0;
            if ($_[0] =~ m/\A (?: STDIN | STDOUT | STDERR ) \z/oxms) {
                return eval { CORE::binmode $_[0]; };
            }
            elsif (ref $_[0]) {
                my $filehandle = qualify_to_ref $_[0];
                return eval { CORE::binmode $filehandle; };
            }
            else {
                return eval { CORE::binmode *{(caller(1))[0] . "::$_[0]"}; };
            }
        }
        elsif ($layer =~ m/\A :crlf \z/oxms) {
            if ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms) {
                croak "$0: open: Unknown binmode() layer '$layer'";
            }
            return;
        }
        else {
            return;
        }
    }
    else {
        croak "$0: usage: binmode(FILEHANDLE [,LAYER])";
    }
}

#
# instead of open (for perl5.005 only)
#
sub Elatin2::open(*;$@) {

    if (@_ == 0) {
        croak "$0: usage: open(FILEHANDLE [,MODE [,EXPR]])";
    }
    elsif (@_ == 1) {
        my $filehandle = gensym;
        local $^W = 0;
        my $expr = ${(caller(1))[0] . "::$_[0]"};
        my $ref = \${(caller(1))[0] . "::$_[0]"};
        *{(caller(1))[0] . "::$_[0]"} = $filehandle;
        *{(caller(1))[0] . "::$_[0]"} = $ref;
        return CORE::open $filehandle, $expr;
    }

    my $filehandle = gensym;
    {
        local $^W = 0;
        if (not defined $_[0]) {
            $_[0] = $filehandle;
        }
        else {
            *{(caller(1))[0] . "::$_[0]"} = $filehandle;
        }
    }

    if (@_ == 2) {
        return CORE::open $filehandle, $_[1];
    }
    elsif (@_ == 3) {
        my(undef,$mode,$expr) = @_;

        $mode =~ s/ :? encoding\($encoding_alias\) //oxms;
        if ($mode =~ s/ :crlf //oxms) {
            if ($^O !~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms) {
                croak "$0: open: Unknown open() mode '$mode'";
            }
        }
        my $binmode = $mode =~ s/ :raw //oxms;

        if (eval q{ use Fcntl qw(O_RDONLY O_WRONLY O_RDWR O_CREAT O_TRUNC O_APPEND); 1 }) {

            # 7.1. Opening a File
            # in Chapter 7. File Access
            # of ISBN 0-596-00313-7 Perl Cookbook, 2nd Edition.

            my %o_flags = (
                ''    => &O_RDONLY,
                '<'   => &O_RDONLY,
                '>'   => &O_WRONLY | &O_TRUNC  | &O_CREAT,
                '>>'  => &O_WRONLY | &O_APPEND | &O_CREAT,
                '+<'  => &O_RDWR,
                '+>'  => &O_RDWR   | &O_TRUNC  | &O_CREAT,
                '+>>' => &O_RDWR   | &O_APPEND | &O_CREAT,
            );
            if ($o_flags{$mode}) {
                my $sysopen = CORE::sysopen $filehandle, $expr, $o_flags{$mode};
                if ($sysopen and $binmode) {
                    eval { CORE::binmode $filehandle; };
                }
                return $sysopen;
            }
        }

        # P.747 29.2.104. open
        # in Chapter 29: Functions
        # of ISBN 0-596-00027-8 Programming Perl Third Edition.
        # (and so on)

        if ($mode eq '|-') {
            my $open = CORE::open $filehandle, qq{| $expr};
            if ($open and $binmode) {
                eval { CORE::binmode $filehandle; };
            }
            return $open;
        }
        elsif ($mode eq '-|') {
            my $open = CORE::open $filehandle, qq{$expr |};
            if ($open and $binmode) {
                eval { CORE::binmode $filehandle; };
            }
            return $open;
        }
        elsif ($mode =~ m/\A (?: \+? (?: < | > | >> ) )? \z/oxms) {

            # 7.2. Opening Files with Unusual Filenames
            # in Chapter 7. File Access
            # of ISBN 0-596-00313-7 Perl Cookbook, 2nd Edition.

            $expr =~ s#\A([ ])#./$1#oxms;
            my $open = CORE::open $filehandle, qq{$mode $expr\0};
            if ($open and $binmode) {
                eval { CORE::binmode $filehandle; };
            }
            return $open;
        }
        else {
            croak "$0: open: Unknown open() mode '$mode'";
        }
    }
    else {
        croak "$0: usage: open(FILEHANDLE [,MODE [,EXPR]])";
    }
}

#
# Latin-2 character to order (with parameter)
#
sub Latin2::ord(;$) {

    local $_ = shift if @_;

    if (m/\A ($q_char) /oxms) {
        my @ord = unpack 'C*', $1;
        my $ord = 0;
        while (my $o = shift @ord) {
            $ord = $ord * 0x100 + $o;
        }
        return $ord;
    }
    else {
        return CORE::ord $_;
    }
}

#
# Latin-2 character to order (without parameter)
#
sub Latin2::ord_() {

    if (m/\A ($q_char) /oxms) {
        my @ord = unpack 'C*', $1;
        my $ord = 0;
        while (my $o = shift @ord) {
            $ord = $ord * 0x100 + $o;
        }
        return $ord;
    }
    else {
        return CORE::ord $_;
    }
}

#
# Latin-2 reverse
#
sub Latin2::reverse(@) {

    if (wantarray) {
        return CORE::reverse @_;
    }
    else {
        return join '', CORE::reverse(join('',@_) =~ m/\G ($q_char) /oxmsg);
    }
}

#
# Latin-2 length by character
#
sub Latin2::length(;$) {

    local $_ = shift if @_;

    local @_ = m/\G ($q_char) /oxmsg;
    return scalar @_;
}

#
# Latin-2 substr by character
#
sub Latin2::substr($$;$$) {

    my @char = $_[0] =~ m/\G ($q_char) /oxmsg;

    # substr($string,$offset,$length,$replacement)
    if (@_ == 4) {
        my(undef,$offset,$length,$replacement) = @_;
        my $substr = join '', splice(@char, $offset, $length, $replacement);
        $_[0] = join '', @char;
        return $substr;
    }

    # substr($string,$offset,$length)
    elsif (@_ == 3) {
        my(undef,$offset,$length) = @_;
        if ($length == 0) {
            return '';
        }
        if ($offset >= 0) {
            return join '', (@char[$offset            .. $#char])[0 .. $length-1];
        }
        else {
            return join '', (@char[($#char+$offset+1) .. $#char])[0 .. $length-1];
        }
    }

    # substr($string,$offset)
    else {
        my(undef,$offset) = @_;
        if ($offset >= 0) {
            return join '', @char[$offset            .. $#char];
        }
        else {
            return join '', @char[($#char+$offset+1) .. $#char];
        }
    }
}

#
# Latin-2 index by character
#
sub Latin2::index($$;$) {

    my $index;
    if (@_ == 3) {
        $index = Elatin2::index($_[0], $_[1], CORE::length(Latin2::substr($_[0], 0, $_[2])));
    }
    else {
        $index = Elatin2::index($_[0], $_[1]);
    }

    if ($index == -1) {
        return -1;
    }
    else {
        return Latin2::length(CORE::substr $_[0], 0, $index);
    }
}

#
# Latin-2 rindex by character
#
sub Latin2::rindex($$;$) {

    my $rindex;
    if (@_ == 3) {
        $rindex = Elatin2::rindex($_[0], $_[1], CORE::length(Latin2::substr($_[0], 0, $_[2])));
    }
    else {
        $rindex = Elatin2::rindex($_[0], $_[1]);
    }

    if ($rindex == -1) {
        return -1;
    }
    else {
        return Latin2::length(CORE::substr $_[0], 0, $rindex);
    }
}

#
# instead of Carp::carp
#
sub carp(@) {
    my($package,$filename,$line) = caller(1);
    print STDERR "@_ at $filename line $line.\n";
}

#
# instead of Carp::croak
#
sub croak(@) {
    my($package,$filename,$line) = caller(1);
    print STDERR "@_ at $filename line $line.\n";
    die "\n";
}

#
# instead of Carp::cluck
#
sub cluck(@) {
    my $i = 0;
    my @cluck = ();
    while (my($package,$filename,$line,$subroutine) = caller($i)) {
        push @cluck, "[$i] $filename($line) $package::$subroutine\n";
        $i++;
    }
    print STDERR reverse @cluck;
    print STDERR "\n";
    carp @_;
}

#
# instead of Carp::confess
#
sub confess(@) {
    my $i = 0;
    my @confess = ();
    while (my($package,$filename,$line,$subroutine) = caller($i)) {
        push @confess, "[$i] $filename($line) $package::$subroutine\n";
        $i++;
    }
    print STDERR reverse @confess;
    print STDERR "\n";
    croak @_;
}

1;

__END__

=pod

=head1 NAME

Elatin2 - Run-time routines for Latin2.pm

=head1 SYNOPSIS

  use Elatin2;

    Elatin2::split(...);
    Elatin2::tr(...);
    Elatin2::chop(...);
    Elatin2::index(...);
    Elatin2::rindex(...);
    Elatin2::lc(...);
    Elatin2::lc_;
    Elatin2::lcfirst(...);
    Elatin2::lcfirst_;
    Elatin2::uc(...);
    Elatin2::uc_;
    Elatin2::ucfirst(...);
    Elatin2::ucfirst_;
    Elatin2::ignorecase(...);
    Elatin2::capture(...);
    Elatin2::chr(...);
    Elatin2::chr_;
    Elatin2::glob(...);
    Elatin2::glob_;

  # "no Elatin2;" not supported

=head1 ABSTRACT

This module is a run-time routines of the Latin2.pm.
Because the Latin2.pm automatically uses this module, you need not use directly.

=head1 BUGS AND LIMITATIONS

Please patches and report problems to author are welcome.

=head1 HISTORY

This Elatin2 module first appeared in ActivePerl Build 522 Built under
MSWin32 Compiled at Nov 2 1999 09:52:28

=head1 AUTHOR

INABA Hitoshi E<lt>ina@cpan.orgE<gt>

This project was originated by INABA Hitoshi.
For any questions, use E<lt>ina@cpan.orgE<gt> so we can share
this file.

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=head1 EXAMPLES

=over 2

=item Split string

  @split = Elatin2::split(/pattern/,$string,$limit);
  @split = Elatin2::split(/pattern/,$string);
  @split = Elatin2::split(/pattern/);
  @split = Elatin2::split('',$string,$limit);
  @split = Elatin2::split('',$string);
  @split = Elatin2::split('');
  @split = Elatin2::split();
  @split = Elatin2::split;

  Scans a Latin-2 $string for delimiters that match pattern and splits the Latin-2
  $string into a list of substrings, returning the resulting list value in list
  context, or the count of substrings in scalar context. The delimiters are
  determined by repeated pattern matching, using the regular expression given in
  pattern, so the delimiters may be of any size and need not be the same Latin-2
  $string on every match. If the pattern doesn't match at all, Elatin2::split returns
  the original Latin-2 $string as a single substring. If it matches once, you get
  two substrings, and so on.
  If $limit is specified and is not negative, the function splits into no more than
  that many fields. If $limit is negative, it is treated as if an arbitrarily large
  $limit has been specified. If $limit is omitted, trailing null fields are stripped
  from the result (which potential users of pop would do well to remember).
  If Latin-2 $string is omitted, the function splits the $_ Latin-2 string.
  If $patten is also omitted, the function splits on whitespace, /\s+/, after
  skipping any leading whitespace.
  If the pattern contains parentheses, then the substring matched by each pair of
  parentheses is included in the resulting list, interspersed with the fields that
  are ordinarily returned.

=item Transliteration

  $tr = Elatin2::tr($variable,$bind_operator,$searchlist,$replacementlist,$modifier);
  $tr = Elatin2::tr($variable,$bind_operator,$searchlist,$replacementlist);

  This function scans a Latin-2 string character by character and replaces all
  occurrences of the characters found in $searchlist with the corresponding character
  in $replacementlist. It returns the number of characters replaced or deleted.
  If no Latin-2 string is specified via =~ operator, the $_ variable is translated.
  $modifier are:

  Modifier   Meaning
  ------------------------------------------------------
  c          Complement $searchlist
  d          Delete found but unreplaced characters
  s          Squash duplicate replaced characters
  ------------------------------------------------------

=item Chop string

  $chop = Elatin2::chop(@list);
  $chop = Elatin2::chop();
  $chop = Elatin2::chop;

  Chops off the last character of a Latin-2 string contained in the variable (or
  Latin-2 strings in each element of a @list) and returns the character chopped.
  The Elatin2::chop operator is used primarily to remove the newline from the end of
  an input record but is more efficient than s/\n$//. If no argument is given, the
  function chops the $_ variable.

=item Index string

  $pos = Elatin2::index($string,$substr,$position);
  $pos = Elatin2::index($string,$substr);

  Returns the position of the first occurrence of $substr in Latin-2 $string.
  The start, if specified, specifies the $position to start looking in the Latin-2
  $string. Positions are integer numbers based at 0. If the substring is not found,
  the Elatin2::index function returns -1.

=item Reverse index string

  $pos = Elatin2::rindex($string,$substr,$position);
  $pos = Elatin2::rindex($string,$substr);

  Works just like Elatin2::index except that it returns the position of the last
  occurence of $substr in Latin-2 $string (a reverse index). The function returns
  -1 if not found. $position, if specified, is the rightmost position that may be
  returned, i.e., how far in the Latin-2 string the function can search.

=item Lower case string

  $lc = Elatin2::lc($string);
  $lc = Elatin2::lc_;

  Returns a lowercase version of Latin-2 string (or $_, if omitted). This is the
  internal function implementing the \L escape in double-quoted strings.

=item Lower case first character of string

  $lcfirst = Elatin2::lcfirst($string);
  $lcfirst = Elatin2::lcfirst_;

  Returns a version of Latin-2 string (or $_, if omitted) with the first character
  lowercased. This is the internal function implementing the \l escape in double-
  quoted strings.

=item Upper case string

  $uc = Elatin2::uc($string);
  $uc = Elatin2::uc_;

  Returns an uppercased version of Latin-2 string (or $_, if string is omitted).
  This is the internal function implementing the \U escape in double-quoted
  strings.

=item Upper case first character of string

  $ucfirst = Elatin2::ucfirst($string);
  $ucfirst = Elatin2::ucfirst_;

  Returns a version of Latin-2 string (or $_, if omitted) with the first character
  uppercased. This is the internal function implementing the \u escape in double-
  quoted strings.

=item Make ignore case string

  @ignorecase = Elatin2::ignorecase(@string);

  This function is internal use to m/ /i, s/ / /i, split / /i and qr/ /i.

=item Make capture number

  $capturenumber = Elatin2::capture($string);

  This function is internal use to m/ /, s/ / /, split / / and qr/ /.

=item Make character

  $chr = Elatin2::chr($code);
  $chr = Elatin2::chr_;

  This function returns the character represented by that $code in the character
  set. For example, Elatin2::chr(65) is "A" in either ASCII or Latin-2, and
  Elatin2::chr(0x82a0) is a Latin-2 HIRAGANA LETTER A. For the reverse of Elatin2::chr,
  use Latin2::ord.

=item Filename expansion (globbing)

  @glob = Elatin2::glob($string);
  @glob = Elatin2::glob_;

  Performs filename expansion (DOS-like globbing) on $string, returning the next
  successive name on each call. If $string is omitted, $_ is globbed instead.
  This function function when the pathname ends with chr(0x5C) on MSWin32.

  For example, C<<..\\l*b\\file/*glob.p?>> on MSWin32 or UNIX will work as
  expected (in that it will find something like '..\lib\File/DosGlob.pm'
  alright).
  Note that all path components are
  case-insensitive, and that backslashes and forward slashes are both accepted,
  and preserved. You may have to double the backslashes if you are putting them in
  literally, due to double-quotish parsing of the pattern by perl.
  A tilde ("~") expands to the current user's home directory.

  Spaces in the argument delimit distinct patterns, so C<glob('*.exe *.dll')> globs
  all filenames that end in C<.exe> or C<.dll>. If you want to put in literal spaces
  in the glob pattern, you can escape them with either double quotes.
  e.g. C<glob('c:/"Program Files"/*/*.dll')>.

=item binary mode (Perl5.6 emulation on perl5.005)

  Elatin2::binmode(FILEHANDLE, $disciplines);
  Elatin2::binmode(FILEHANDLE);
  Elatin2::binmode($filehandle, $disciplines);
  Elatin2::binmode($filehandle);

  * two arguments

  If you are using perl5.005 other than MacPerl, Latin2 software emulate perl5.6's
  binmode function. Only the point is here. See also perlfunc/binmode for details.

  This function arranges for the FILEHANDLE to have the semantics specified by the
  $disciplines argument. If $disciplines is omitted, ':raw' semantics are applied
  to the filehandle. If FILEHANDLE is an expression, the value is taken as the
  name of the filehandle or a reference to a filehandle, as appropriate.
  The binmode function should be called after the open but before any I/O is done
  on the filehandle. The only way to reset the mode on a filehandle is to reopen
  the file, since the various disciplines may have treasured up various bits and
  pieces of data in various buffers.

  The ":raw" discipline tells Perl to keep its cotton-pickin' hands off the data.
  For more on how disciplines work, see the open function.

=item open file (Perl5.6 emulation on perl5.005)

  $rc = Elatin2::open(FILEHANDLE, $mode, $expr);
  $rc = Elatin2::open(FILEHANDLE, $expr);
  $rc = Elatin2::open(FILEHANDLE);
  $rc = Elatin2::open(my $filehandle, $mode, $expr);
  $rc = Elatin2::open(my $filehandle, $expr);
  $rc = Elatin2::open(my $filehandle);

  * autovivification filehandle
  * three arguments

  If you are using perl5.005, Latin2 software emulate perl5.6's open function.
  Only the point is here. See also perlfunc/open for details.

  As that example shows, the FILEHANDLE argument is often just a simple identifier
  (normally uppercase), but it may also be an expression whose value provides a
  reference to the actual filehandle. (The reference may be either a symbolic
  reference to the filehandle name or a hard reference to any object that can be
  interpreted as a filehandle.) This is called an indirect filehandle, and any
  function that takes a FILEHANDLE as its first argument can handle indirect
  filehandles as well as direct ones. But open is special in that if you supply
  it with an undefined variable for the indirect filehandle, Perl will automatically
  define that variable for you, that is, autovivifying it to contain a proper
  filehandle reference.

  {
      my $fh;                          # (uninitialized)
      Elatin2::open($fh, ">logfile")     # $fh is autovivified
          or die "Can't create logfile: $!";
          ...                          # do stuff with $fh
  }                                    # $fh closed here

  The my $fh declaration can be readably incorporated into the open:

  Elatin2::open my $fh, ">logfile" or die ...

  The > symbol you've been seeing in front of the filename is an example of a mode.
  Historically, the two-argument form of open came first. The recent addition of
  the three-argument form lets you separate the mode from the filename, which has
  the advantage of avoiding any possible confusion between the two. In the following
  example, we know that the user is not trying to open a filename that happens to
  start with ">". We can be sure that they're specifying a $mode of ">", which opens
  the file named in $expr for writing, creating the file if it doesn't exist and
  truncating the file down to nothing if it already exists:

  Elatin2::open(LOG, ">", "logfile") or die "Can't create logfile: $!";

  With the one- or two-argument form of open, you have to be careful when you use
  a string variable as a filename, since the variable may contain arbitrarily
  weird characters (particularly when the filename has been supplied by arbitrarily
  weird characters on the Internet). If you're not careful, parts of the filename
  might get interpreted as a $mode string, ignorable whitespace, a dup specification,
  or a minus.
  Here's one historically interesting way to insulate yourself:

  $path =~ s#^([ ])#./$1#;
  Elatin2::open (FH, "< $path\0") or die "can't open $path: $!";

  But that's still broken in several ways. Instead, just use the three-argument
  form of open to open any arbitrary filename cleanly and without any (extra)
  security risks:

  Elatin2::open(FH, "<", $path) or die "can't open $path: $!";

  As of the 5.6 release of Perl, you can specify binary mode in the open function
  without a separate call to binmode. As part of the $mode
  argument (but only in the three-argument form), you may specify various input
  and output disciplines.
  To do the equivalent of a binmode, use the three argument form of open and stuff
  a discipline of :raw in after the other $mode characters:

  Elatin2::open(FH, "<:raw", $path) or die "can't open $path: $!";

  Table 1. I/O Disciplines
  -------------------------------------------------
  Discipline      Meaning
  -------------------------------------------------
  :raw            Binary mode; do no processing
  :crlf           Text mode; Intuit newlines
                  (DOS-like system only)
  :encoding(...)  Legacy encoding
  -------------------------------------------------

  You'll be able to stack disciplines that make sense to stack, so, for instance,
  you could say:

  Elatin2::open(FH, "<:crlf:encoding(Latin2)", $path) or die "can't open $path: $!";

=back

=cut

