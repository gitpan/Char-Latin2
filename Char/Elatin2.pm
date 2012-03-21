package Char::Elatin2;
######################################################################
#
# Char::Elatin2 - Run-time routines for Char/Latin2.pm
#
# Copyright (c) 2008, 2009, 2010, 2011, 2012 INABA Hitoshi <ina@cpan.org>
#
######################################################################

use 5.00503;
use strict qw(subs vars);

BEGIN {
    if ($^X =~ m/ jperl /oxmsi) {
        die "$0 need perl(not jperl) 5.00503 or later. (\$^X==$^X)";
    }
}

# 12.3. Delaying use Until Runtime
# in Chapter 12. Packages, Libraries, and Modules
# of ISBN 0-596-00313-7 Perl Cookbook, 2nd Edition.
# (and so on)

BEGIN { eval q{ use vars qw($VERSION) } }
$VERSION = sprintf '%d.%02d', q$Revision: 0.80 $ =~ m/(\d+)/xmsg;

BEGIN {
    my $PERL5LIB = __FILE__;

    # DOS-like system
    if ($^O =~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms) {
        $PERL5LIB =~ s{[^/]*$}{Char::Latin2};
    }

    # UNIX-like system
    else {
        $PERL5LIB =~ s{[^/]*$}{Char::Latin2};
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
        if (!ref($name) && (Char::Elatin2::index($name, '::') == -1) && (Char::Elatin2::index($name, "'") == -1)) {
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

# P.863 flock
# in Chapter 27: Functions
# of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

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
    $encoding_alias = qr/ \b (?: (?:us-?)?ascii ) \b /oxmsi;
}

# Latin-1
elsif (__PACKAGE__ =~ m/ \b Elatin1 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: iso[-_ ]?8859-1 | iec[- ]?8859-1 | latin-?1 ) \b /oxmsi;
}

# Latin-2
elsif (__PACKAGE__ =~ m/ \b Elatin2 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: iso[-_ ]?8859-2 | iec[- ]?8859-2 | latin-?2 ) \b /oxmsi;
}

# Latin-3
elsif (__PACKAGE__ =~ m/ \b Elatin3 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: iso[-_ ]?8859-3 | iec[- ]?8859-3 | latin-?3 ) \b /oxmsi;
}

# Latin-4
elsif (__PACKAGE__ =~ m/ \b Elatin4 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: iso[-_ ]?8859-4 | iec[- ]?8859-4 | latin-?4 ) \b /oxmsi;
}

# Cyrillic
elsif (__PACKAGE__ =~ m/ \b Ecyrillic \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: iso[-_ ]?8859-5 | iec[- ]?8859-5 | cyrillic ) \b /oxmsi;
}

# KOI8-R
elsif (__PACKAGE__ =~ m/ \b Ekoi8r \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: koi8-?r ) \b /oxmsi;
}

# KOI8-U
elsif (__PACKAGE__ =~ m/ \b Ekoi8u \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: koi8-?u ) \b /oxmsi;
}

# Greek
elsif (__PACKAGE__ =~ m/ \b Egreek \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: iso[-_ ]?8859-7 | iec[- ]?8859-7 | greek ) \b /oxmsi;
}

# Latin-5
elsif (__PACKAGE__ =~ m/ \b Elatin5 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: iso[-_ ]?8859-9 | iec[- ]?8859-9 | latin-?5 ) \b /oxmsi;
}

# Latin-6
elsif (__PACKAGE__ =~ m/ \b Elatin6 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: iso[-_ ]?8859-10 | iec[- ]?8859-10 | latin-?6 ) \b /oxmsi;
}

# Latin-7
elsif (__PACKAGE__ =~ m/ \b Elatin7 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: iso[-_ ]?8859-13 | iec[- ]?8859-13 | latin-?7 ) \b /oxmsi;
}

# Latin-8
elsif (__PACKAGE__ =~ m/ \b Elatin8 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: iso[-_ ]?8859-14 | iec[- ]?8859-14 | latin-?8 ) \b /oxmsi;
}

# Latin-9
elsif (__PACKAGE__ =~ m/ \b Elatin9 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: iso[-_ ]?8859-15 | iec[- ]?8859-15 | latin-?9 ) \b /oxmsi;
}

# Latin-10
elsif (__PACKAGE__ =~ m/ \b Elatin10 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: iso[-_ ]?8859-16 | iec[- ]?8859-16 | latin-?10 ) \b /oxmsi;
}

# Windows-1252
elsif (__PACKAGE__ =~ m/ \b Ewindows1252 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: windows-?1252 ) \b /oxmsi;
}

# Windows-1258
elsif (__PACKAGE__ =~ m/ \b Ewindows1258 \z/oxms) {
    %range_tr = (
        1 => [ [0x00..0xFF],
             ],
    );
    $encoding_alias = qr/ \b (?: windows-?1258 ) \b /oxmsi;
}

else {
    croak "$0 don't know my package name '" . __PACKAGE__ . "'";
}

#
# Prototypes of subroutines
#
sub import() {}
sub unimport() {}
sub Char::Elatin2::split(;$$$);
sub Char::Elatin2::tr($$$$;$);
sub Char::Elatin2::chop(@);
sub Char::Elatin2::index($$;$);
sub Char::Elatin2::rindex($$;$);
sub Char::Elatin2::lcfirst(@);
sub Char::Elatin2::lcfirst_();
sub Char::Elatin2::lc(@);
sub Char::Elatin2::lc_();
sub Char::Elatin2::ucfirst(@);
sub Char::Elatin2::ucfirst_();
sub Char::Elatin2::uc(@);
sub Char::Elatin2::uc_();
sub Char::Elatin2::ignorecase(@);
sub Char::Elatin2::classic_character_class($);
sub Char::Elatin2::capture($);
sub Char::Elatin2::chr(;$);
sub Char::Elatin2::chr_();
sub Char::Elatin2::glob($);
sub Char::Elatin2::glob_();

sub Char::Latin2::ord(;$);
sub Char::Latin2::ord_();
sub Char::Latin2::reverse(@);
sub Char::Latin2::length(;$);
sub Char::Latin2::substr($$;$$);
sub Char::Latin2::index($$;$);
sub Char::Latin2::rindex($$;$);

#
# Character class
#
use vars qw(
    @anchor
    @dot
    @dot_s
    @eD
    @eS
    @eW
    @eH
    @eV
    @eR
    @eN
    @not_alnum
    @not_alpha
    @not_ascii
    @not_blank
    @not_cntrl
    @not_digit
    @not_graph
    @not_lower
    @not_lower_i
    @not_print
    @not_punct
    @not_space
    @not_upper
    @not_upper_i
    @not_word
    @not_xdigit
    @eb
    @eB
);
@{Char::Elatin2::anchor}      = qr{\G(?:[\x00-\xFF])*?};
@{Char::Elatin2::dot}         = qr{(?:[^\x0A])};
@{Char::Elatin2::dot_s}       = qr{(?:[\x00-\xFF])};
@{Char::Elatin2::eD}          = qr{(?:[^0-9])};
@{Char::Elatin2::eS}          = qr{(?:[^\x09\x0A\x0C\x0D\x20])};
@{Char::Elatin2::eW}          = qr{(?:[^0-9A-Z_a-z])};
@{Char::Elatin2::eH}          = qr{(?:[^\x09\x20])};
@{Char::Elatin2::eV}          = qr{(?:[^\x0C\x0A\x0D])};
@{Char::Elatin2::eR}          = qr{(?:\x0D\x0A|[\x0A\x0D])};
@{Char::Elatin2::eN}          = qr{(?:[^\x0A])};
@{Char::Elatin2::not_alnum}   = qr{(?:[^\x30-\x39\x41-\x5A\x61-\x7A])};
@{Char::Elatin2::not_alpha}   = qr{(?:[^\x41-\x5A\x61-\x7A])};
@{Char::Elatin2::not_ascii}   = qr{(?:[^\x00-\x7F])};
@{Char::Elatin2::not_blank}   = qr{(?:[^\x09\x20])};
@{Char::Elatin2::not_cntrl}   = qr{(?:[^\x00-\x1F\x7F])};
@{Char::Elatin2::not_digit}   = qr{(?:[^\x30-\x39])};
@{Char::Elatin2::not_graph}   = qr{(?:[^\x21-\x7F])};
@{Char::Elatin2::not_lower}   = qr{(?:[^\x61-\x7A])};
@{Char::Elatin2::not_lower_i} = qr{(?:[\x00-\xFF])};
@{Char::Elatin2::not_print}   = qr{(?:[^\x20-\x7F])};
@{Char::Elatin2::not_punct}   = qr{(?:[^\x21-\x2F\x3A-\x3F\x40\x5B-\x5F\x60\x7B-\x7E])};
@{Char::Elatin2::not_space}   = qr{(?:[^\x09\x0A\x0B\x0C\x0D\x20])};
@{Char::Elatin2::not_upper}   = qr{(?:[^\x41-\x5A])};
@{Char::Elatin2::not_upper_i} = qr{(?:[\x00-\xFF])};
@{Char::Elatin2::not_word}    = qr{(?:[^\x30-\x39\x41-\x5A\x5F\x61-\x7A])};
@{Char::Elatin2::not_xdigit}  = qr{(?:[^\x30-\x39\x41-\x46\x61-\x66])};
@{Char::Elatin2::eb}          = qr{(?:\A(?=[0-9A-Z_a-z])|(?<=[\x00-\x2F\x40\x5B-\x5E\x60\x7B-\xFF])(?=[0-9A-Z_a-z])|(?<=[0-9A-Z_a-z])(?=[\x00-\x2F\x40\x5B-\x5E\x60\x7B-\xFF]|\z))};
@{Char::Elatin2::eB}          = qr{(?:(?<=[0-9A-Z_a-z])(?=[0-9A-Z_a-z])|(?<=[\x00-\x2F\x40\x5B-\x5E\x60\x7B-\xFF])(?=[\x00-\x2F\x40\x5B-\x5E\x60\x7B-\xFF]))};

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
            elsif (m/\A (?:$q_char)*? [*?] /oxms and (my @glob = Char::Elatin2::glob($_))) {
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
sub Char::Elatin2::split(;$$$) {

    # P.794 29.2.161. split
    # in Chapter 29: Functions
    # of ISBN 0-596-00027-8 Programming Perl Third Edition.

    # P.951 split
    # in Chapter 27: Functions
    # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

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
sub Char::Elatin2::tr($$$$;$) {

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
sub Char::Elatin2::chop(@) {

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
sub Char::Elatin2::index($$;$) {

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
sub Char::Elatin2::rindex($$;$) {

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

    # P.159 Lexically Scoped Variables: my
    # in Chapter 4: Statements and Declarations
    # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

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

    elsif (__PACKAGE__ =~ m/ \b Ekoi8r \z/oxms) {
        %lc = (%lc,
            "\xB3" => "\xA3", # CYRILLIC LETTER IO
            "\xE0" => "\xC0", # CYRILLIC LETTER IU
            "\xE1" => "\xC1", # CYRILLIC LETTER A
            "\xE2" => "\xC2", # CYRILLIC LETTER BE
            "\xE3" => "\xC3", # CYRILLIC LETTER TSE
            "\xE4" => "\xC4", # CYRILLIC LETTER DE
            "\xE5" => "\xC5", # CYRILLIC LETTER IE
            "\xE6" => "\xC6", # CYRILLIC LETTER EF
            "\xE7" => "\xC7", # CYRILLIC LETTER GE
            "\xE8" => "\xC8", # CYRILLIC LETTER KHA
            "\xE9" => "\xC9", # CYRILLIC LETTER II
            "\xEA" => "\xCA", # CYRILLIC LETTER SHORT II
            "\xEB" => "\xCB", # CYRILLIC LETTER KA
            "\xEC" => "\xCC", # CYRILLIC LETTER EL
            "\xED" => "\xCD", # CYRILLIC LETTER EM
            "\xEE" => "\xCE", # CYRILLIC LETTER EN
            "\xEF" => "\xCF", # CYRILLIC LETTER O
            "\xF0" => "\xD0", # CYRILLIC LETTER PE
            "\xF1" => "\xD1", # CYRILLIC LETTER IA
            "\xF2" => "\xD2", # CYRILLIC LETTER ER
            "\xF3" => "\xD3", # CYRILLIC LETTER ES
            "\xF4" => "\xD4", # CYRILLIC LETTER TE
            "\xF5" => "\xD5", # CYRILLIC LETTER U
            "\xF6" => "\xD6", # CYRILLIC LETTER ZHE
            "\xF7" => "\xD7", # CYRILLIC LETTER VE
            "\xF8" => "\xD8", # CYRILLIC LETTER SOFT SIGN
            "\xF9" => "\xD9", # CYRILLIC LETTER YERI
            "\xFA" => "\xDA", # CYRILLIC LETTER ZE
            "\xFB" => "\xDB", # CYRILLIC LETTER SHA
            "\xFC" => "\xDC", # CYRILLIC LETTER REVERSED E
            "\xFD" => "\xDD", # CYRILLIC LETTER SHCHA
            "\xFE" => "\xDE", # CYRILLIC LETTER CHE
            "\xFF" => "\xDF", # CYRILLIC LETTER HARD SIGN
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Ekoi8u \z/oxms) {
        %lc = (%lc,
            "\xB3" => "\xA3", # CYRILLIC LETTER IO
            "\xB4" => "\xA4", # CYRILLIC LETTER UKRAINIAN IE
            "\xB6" => "\xA6", # CYRILLIC LETTER BYELORUSSIAN-UKRAINIAN I
            "\xB7" => "\xA7", # CYRILLIC LETTER YI (UKRAINIAN)
            "\xBD" => "\xAD", # CYRILLIC LETTER GHE WITH UPTURN
            "\xE0" => "\xC0", # CYRILLIC LETTER YU
            "\xE1" => "\xC1", # CYRILLIC LETTER A
            "\xE2" => "\xC2", # CYRILLIC LETTER BE
            "\xE3" => "\xC3", # CYRILLIC LETTER TSE
            "\xE4" => "\xC4", # CYRILLIC LETTER DE
            "\xE5" => "\xC5", # CYRILLIC LETTER IE
            "\xE6" => "\xC6", # CYRILLIC LETTER EF
            "\xE7" => "\xC7", # CYRILLIC LETTER GHE
            "\xE8" => "\xC8", # CYRILLIC LETTER KHA
            "\xE9" => "\xC9", # CYRILLIC LETTER I
            "\xEA" => "\xCA", # CYRILLIC LETTER SHORT I
            "\xEB" => "\xCB", # CYRILLIC LETTER KA
            "\xEC" => "\xCC", # CYRILLIC LETTER EL
            "\xED" => "\xCD", # CYRILLIC LETTER EM
            "\xEE" => "\xCE", # CYRILLIC LETTER EN
            "\xEF" => "\xCF", # CYRILLIC LETTER O
            "\xF0" => "\xD0", # CYRILLIC LETTER PE
            "\xF1" => "\xD1", # CYRILLIC LETTER YA
            "\xF2" => "\xD2", # CYRILLIC LETTER ER
            "\xF3" => "\xD3", # CYRILLIC LETTER ES
            "\xF4" => "\xD4", # CYRILLIC LETTER TE
            "\xF5" => "\xD5", # CYRILLIC LETTER U
            "\xF6" => "\xD6", # CYRILLIC LETTER ZHE
            "\xF7" => "\xD7", # CYRILLIC LETTER VE
            "\xF8" => "\xD8", # CYRILLIC LETTER SOFT SIGN
            "\xF9" => "\xD9", # CYRILLIC LETTER YERU
            "\xFA" => "\xDA", # CYRILLIC LETTER ZE
            "\xFB" => "\xDB", # CYRILLIC LETTER SHA
            "\xFC" => "\xDC", # CYRILLIC LETTER E
            "\xFD" => "\xDD", # CYRILLIC LETTER SHCHA
            "\xFE" => "\xDE", # CYRILLIC LETTER CHE
            "\xFF" => "\xDF", # CYRILLIC LETTER HARD SIGN
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

    elsif (__PACKAGE__ =~ m/ \b Ewindows1258 \z/oxms) {
        %lc = (%lc,
            "\x8C" => "\x9C", # LATIN LIGATURE OE
            "\x9F" => "\xFF", # LATIN LETTER Y WITH DIAERESIS
            "\xC0" => "\xE0", # LATIN LETTER A WITH GRAVE
            "\xC1" => "\xE1", # LATIN LETTER A WITH ACUTE
            "\xC2" => "\xE2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xC3" => "\xE3", # LATIN LETTER A WITH BREVE
            "\xC4" => "\xE4", # LATIN LETTER A WITH DIAERESIS
            "\xC5" => "\xE5", # LATIN LETTER A WITH RING ABOVE
            "\xC6" => "\xE6", # LATIN LETTER AE
            "\xC7" => "\xE7", # LATIN LETTER C WITH CEDILLA
            "\xC8" => "\xE8", # LATIN LETTER E WITH GRAVE
            "\xC9" => "\xE9", # LATIN LETTER E WITH ACUTE
            "\xCA" => "\xEA", # LATIN LETTER E WITH CIRCUMFLEX
            "\xCB" => "\xEB", # LATIN LETTER E WITH DIAERESIS
            "\xCD" => "\xED", # LATIN LETTER I WITH ACUTE
            "\xCE" => "\xEE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xCF" => "\xEF", # LATIN LETTER I WITH DIAERESIS
            "\xD0" => "\xF0", # LATIN LETTER D WITH STROKE
            "\xD1" => "\xF1", # LATIN LETTER N WITH TILDE
            "\xD3" => "\xF3", # LATIN LETTER O WITH ACUTE
            "\xD4" => "\xF4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xD5" => "\xF5", # LATIN LETTER O WITH HORN
            "\xD6" => "\xF6", # LATIN LETTER O WITH DIAERESIS
            "\xD8" => "\xF8", # LATIN LETTER O WITH STROKE
            "\xD9" => "\xF9", # LATIN LETTER U WITH GRAVE
            "\xDA" => "\xFA", # LATIN LETTER U WITH ACUTE
            "\xDB" => "\xFB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xDC" => "\xFC", # LATIN LETTER U WITH DIAERESIS
            "\xDD" => "\xFD", # LATIN LETTER U WITH HORN
        );
    }

    # lower case first with parameter
    sub Char::Elatin2::lcfirst(@) {
        if (@_) {
            my $s = shift @_;
            if (@_ and wantarray) {
                return Char::Elatin2::lc(CORE::substr($s,0,1)) . CORE::substr($s,1), @_;
            }
            else {
                return Char::Elatin2::lc(CORE::substr($s,0,1)) . CORE::substr($s,1);
            }
        }
        else {
            return Char::Elatin2::lc(CORE::substr($_,0,1)) . CORE::substr($_,1);
        }
    }

    # lower case first without parameter
    sub Char::Elatin2::lcfirst_() {
        return Char::Elatin2::lc(CORE::substr($_,0,1)) . CORE::substr($_,1);
    }

    # lower case with parameter
    sub Char::Elatin2::lc(@) {
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
            return Char::Elatin2::lc_();
        }
    }

    # lower case without parameter
    sub Char::Elatin2::lc_() {
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

    elsif (__PACKAGE__ =~ m/ \b Ekoi8r \z/oxms) {
        %uc = (%uc,
            "\xA3" => "\xB3", # CYRILLIC LETTER IO
            "\xC0" => "\xE0", # CYRILLIC LETTER IU
            "\xC1" => "\xE1", # CYRILLIC LETTER A
            "\xC2" => "\xE2", # CYRILLIC LETTER BE
            "\xC3" => "\xE3", # CYRILLIC LETTER TSE
            "\xC4" => "\xE4", # CYRILLIC LETTER DE
            "\xC5" => "\xE5", # CYRILLIC LETTER IE
            "\xC6" => "\xE6", # CYRILLIC LETTER EF
            "\xC7" => "\xE7", # CYRILLIC LETTER GE
            "\xC8" => "\xE8", # CYRILLIC LETTER KHA
            "\xC9" => "\xE9", # CYRILLIC LETTER II
            "\xCA" => "\xEA", # CYRILLIC LETTER SHORT II
            "\xCB" => "\xEB", # CYRILLIC LETTER KA
            "\xCC" => "\xEC", # CYRILLIC LETTER EL
            "\xCD" => "\xED", # CYRILLIC LETTER EM
            "\xCE" => "\xEE", # CYRILLIC LETTER EN
            "\xCF" => "\xEF", # CYRILLIC LETTER O
            "\xD0" => "\xF0", # CYRILLIC LETTER PE
            "\xD1" => "\xF1", # CYRILLIC LETTER IA
            "\xD2" => "\xF2", # CYRILLIC LETTER ER
            "\xD3" => "\xF3", # CYRILLIC LETTER ES
            "\xD4" => "\xF4", # CYRILLIC LETTER TE
            "\xD5" => "\xF5", # CYRILLIC LETTER U
            "\xD6" => "\xF6", # CYRILLIC LETTER ZHE
            "\xD7" => "\xF7", # CYRILLIC LETTER VE
            "\xD8" => "\xF8", # CYRILLIC LETTER SOFT SIGN
            "\xD9" => "\xF9", # CYRILLIC LETTER YERI
            "\xDA" => "\xFA", # CYRILLIC LETTER ZE
            "\xDB" => "\xFB", # CYRILLIC LETTER SHA
            "\xDC" => "\xFC", # CYRILLIC LETTER REVERSED E
            "\xDD" => "\xFD", # CYRILLIC LETTER SHCHA
            "\xDE" => "\xFE", # CYRILLIC LETTER CHE
            "\xDF" => "\xFF", # CYRILLIC LETTER HARD SIGN
        );
    }

    elsif (__PACKAGE__ =~ m/ \b Ekoi8u \z/oxms) {
        %uc = (%uc,
            "\xA3" => "\xB3", # CYRILLIC LETTER IO
            "\xA4" => "\xB4", # CYRILLIC LETTER UKRAINIAN IE
            "\xA6" => "\xB6", # CYRILLIC LETTER BYELORUSSIAN-UKRAINIAN I
            "\xA7" => "\xB7", # CYRILLIC LETTER YI (UKRAINIAN)
            "\xAD" => "\xBD", # CYRILLIC LETTER GHE WITH UPTURN
            "\xC0" => "\xE0", # CYRILLIC LETTER YU
            "\xC1" => "\xE1", # CYRILLIC LETTER A
            "\xC2" => "\xE2", # CYRILLIC LETTER BE
            "\xC3" => "\xE3", # CYRILLIC LETTER TSE
            "\xC4" => "\xE4", # CYRILLIC LETTER DE
            "\xC5" => "\xE5", # CYRILLIC LETTER IE
            "\xC6" => "\xE6", # CYRILLIC LETTER EF
            "\xC7" => "\xE7", # CYRILLIC LETTER GHE
            "\xC8" => "\xE8", # CYRILLIC LETTER KHA
            "\xC9" => "\xE9", # CYRILLIC LETTER I
            "\xCA" => "\xEA", # CYRILLIC LETTER SHORT I
            "\xCB" => "\xEB", # CYRILLIC LETTER KA
            "\xCC" => "\xEC", # CYRILLIC LETTER EL
            "\xCD" => "\xED", # CYRILLIC LETTER EM
            "\xCE" => "\xEE", # CYRILLIC LETTER EN
            "\xCF" => "\xEF", # CYRILLIC LETTER O
            "\xD0" => "\xF0", # CYRILLIC LETTER PE
            "\xD1" => "\xF1", # CYRILLIC LETTER YA
            "\xD2" => "\xF2", # CYRILLIC LETTER ER
            "\xD3" => "\xF3", # CYRILLIC LETTER ES
            "\xD4" => "\xF4", # CYRILLIC LETTER TE
            "\xD5" => "\xF5", # CYRILLIC LETTER U
            "\xD6" => "\xF6", # CYRILLIC LETTER ZHE
            "\xD7" => "\xF7", # CYRILLIC LETTER VE
            "\xD8" => "\xF8", # CYRILLIC LETTER SOFT SIGN
            "\xD9" => "\xF9", # CYRILLIC LETTER YERU
            "\xDA" => "\xFA", # CYRILLIC LETTER ZE
            "\xDB" => "\xFB", # CYRILLIC LETTER SHA
            "\xDC" => "\xFC", # CYRILLIC LETTER E
            "\xDD" => "\xFD", # CYRILLIC LETTER SHCHA
            "\xDE" => "\xFE", # CYRILLIC LETTER CHE
            "\xDF" => "\xFF", # CYRILLIC LETTER HARD SIGN
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

    elsif (__PACKAGE__ =~ m/ \b Ewindows1258 \z/oxms) {
        %uc = (%uc,
            "\x9C" => "\x8C", # LATIN LIGATURE OE
            "\xFF" => "\x9F", # LATIN LETTER Y WITH DIAERESIS
            "\xE0" => "\xC0", # LATIN LETTER A WITH GRAVE
            "\xE1" => "\xC1", # LATIN LETTER A WITH ACUTE
            "\xE2" => "\xC2", # LATIN LETTER A WITH CIRCUMFLEX
            "\xE3" => "\xC3", # LATIN LETTER A WITH BREVE
            "\xE4" => "\xC4", # LATIN LETTER A WITH DIAERESIS
            "\xE5" => "\xC5", # LATIN LETTER A WITH RING ABOVE
            "\xE6" => "\xC6", # LATIN LETTER AE
            "\xE7" => "\xC7", # LATIN LETTER C WITH CEDILLA
            "\xE8" => "\xC8", # LATIN LETTER E WITH GRAVE
            "\xE9" => "\xC9", # LATIN LETTER E WITH ACUTE
            "\xEA" => "\xCA", # LATIN LETTER E WITH CIRCUMFLEX
            "\xEB" => "\xCB", # LATIN LETTER E WITH DIAERESIS
            "\xED" => "\xCD", # LATIN LETTER I WITH ACUTE
            "\xEE" => "\xCE", # LATIN LETTER I WITH CIRCUMFLEX
            "\xEF" => "\xCF", # LATIN LETTER I WITH DIAERESIS
            "\xF0" => "\xD0", # LATIN LETTER D WITH STROKE
            "\xF1" => "\xD1", # LATIN LETTER N WITH TILDE
            "\xF3" => "\xD3", # LATIN LETTER O WITH ACUTE
            "\xF4" => "\xD4", # LATIN LETTER O WITH CIRCUMFLEX
            "\xF5" => "\xD5", # LATIN LETTER O WITH HORN
            "\xF6" => "\xD6", # LATIN LETTER O WITH DIAERESIS
            "\xF8" => "\xD8", # LATIN LETTER O WITH STROKE
            "\xF9" => "\xD9", # LATIN LETTER U WITH GRAVE
            "\xFA" => "\xDA", # LATIN LETTER U WITH ACUTE
            "\xFB" => "\xDB", # LATIN LETTER U WITH CIRCUMFLEX
            "\xFC" => "\xDC", # LATIN LETTER U WITH DIAERESIS
            "\xFD" => "\xDD", # LATIN LETTER U WITH HORN
        );
    }

    # upper case first with parameter
    sub Char::Elatin2::ucfirst(@) {
        if (@_) {
            my $s = shift @_;
            if (@_ and wantarray) {
                return Char::Elatin2::uc(CORE::substr($s,0,1)) . CORE::substr($s,1), @_;
            }
            else {
                return Char::Elatin2::uc(CORE::substr($s,0,1)) . CORE::substr($s,1);
            }
        }
        else {
            return Char::Elatin2::uc(CORE::substr($_,0,1)) . CORE::substr($_,1);
        }
    }

    # upper case first without parameter
    sub Char::Elatin2::ucfirst_() {
        return Char::Elatin2::uc(CORE::substr($_,0,1)) . CORE::substr($_,1);
    }

    # upper case with parameter
    sub Char::Elatin2::uc(@) {
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
            return Char::Elatin2::uc_();
        }
    }

    # upper case without parameter
    sub Char::Elatin2::uc_() {
        my $s = $_;
        return join '', map {defined($uc{$_}) ? $uc{$_} : $_} ($s =~ m/\G ($q_char) /oxmsg);
    }
}

#
# Latin-2 regexp capture
#
{
    sub Char::Elatin2::capture($) {
        return $_[0];
    }
}

#
# Latin-2 regexp ignore case modifier
#
sub Char::Elatin2::ignorecase(@) {

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

            # rewrite classic character class or escape character
            elsif (my $char = classic_character_class($char[$i])) {
                $char[$i] = $char;
            }

            # /i modifier
            elsif ($char[$i] =~ m/\A [\x00-\xFF] \z/oxms) {
                my $uc = Char::Elatin2::uc($char[$i]);
                my $lc = Char::Elatin2::lc($char[$i]);
                if ($uc ne $lc) {
                    $char[$i] = '[' . $uc . $lc . ']';
                }
            }
        }

        # characterize
        for (my $i=0; $i <= $#char; $i++) {
            next if not defined $char[$i];

            # escape last octet of multiple-octet
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
# classic character class ( \D \S \W \d \s \w \C \X \H \V \h \v \R \N \b \B )
#
sub classic_character_class($) {
    my($char) = @_;

    return {
        '\D' => '@{Char::Elatin2::eD}',
        '\S' => '@{Char::Elatin2::eS}',
        '\W' => '@{Char::Elatin2::eW}',
        '\d' => '[0-9]',
                 # \t  \n  \f  \r space
        '\s' => '[\x09\x0A\x0C\x0D\x20]',
        '\w' => '[0-9A-Z_a-z]',
        '\C' => '[\x00-\xFF]',
        '\X' => 'X',

        # \h \v \H \V

        # P.114 Character Class Shortcuts
        # in Chapter 7: In the World of Regular Expressions
        # of ISBN 978-0-596-52010-6 Learning Perl, Fifth Edition

        # P.196 Table 5-9. Alphanumeric regex metasymbols
        # in Chapter 5. Pattern Matching
        # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

        # (and so on)

        '\H' => '@{Char::Elatin2::eH}',
        '\V' => '@{Char::Elatin2::eV}',
        '\h' => '[\x09\x20]',
        '\v' => '[\x0C\x0A\x0D]',
        '\R' => '@{Char::Elatin2::eR}',

        # \N
        #
        # http://perldoc.perl.org/perlre.html
        # Character Classes and other Special Escapes
        # Any character but \n (experimental). Not affected by /s modifier

        '\N' => '@{Char::Elatin2::eN}',

        # \b \B

        # P.131 Word boundaries: \b, \B, \<, \>, ...
        # in Chapter 3: Overview of Regular Expression Features and Flavors
        # of ISBN 0-596-00289-0 Mastering Regular Expressions, Second edition

        # P.219 Boundaries: The \b and \B Assertions
        # in Chapter 5: Pattern Matching
        # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

        # '\b' => '(?:(?<=\A|\W)(?=\w)|(?<=\w)(?=\W|\z))',
        '\b' => '@{Char::Elatin2::eb}',

        # '\B' => '(?:(?<=\w)(?=\w)|(?<=\W)(?=\W))',
        '\B' => '@{Char::Elatin2::eB}',

    }->{$char} || '';
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

    # join separated multiple-octet
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

        # range of multiple-octet code
        if (length($char[$i-1]) == 1) {
            if (length($char[$i+1]) == 1) {
                push @range, grep {($char[$i-1] le $_) and ($_ le $char[$i+1])} chars1();
            }
            elsif (length($char[$i+1]) == 2) {
                push @range, grep {$char[$i-1] le $_}                           chars1();
                push @range, grep {$_ le $char[$i+1]}                           chars2();
            }
            elsif (length($char[$i+1]) == 3) {
                push @range, grep {$char[$i-1] le $_}                           chars1();
                push @range,                                                    chars2();
                push @range, grep {$_ le $char[$i+1]}                           chars3();
            }
            elsif (length($char[$i+1]) == 4) {
                push @range, grep {$char[$i-1] le $_}                           chars1();
                push @range,                                                    chars2();
                push @range,                                                    chars3();
                push @range, grep {$_ le $char[$i+1]}                           chars4();
            }
        }
        elsif (length($char[$i-1]) == 2) {
            if (length($char[$i+1]) == 2) {
                push @range, grep {($char[$i-1] le $_) and ($_ le $char[$i+1])} chars2();
            }
            elsif (length($char[$i+1]) == 3) {
                push @range, grep {$char[$i-1] le $_}                           chars2();
                push @range, grep {$_ le $char[$i+1]}                           chars3();
            }
            elsif (length($char[$i+1]) == 4) {
                push @range, grep {$char[$i-1] le $_}                           chars2();
                push @range,                                                    chars3();
                push @range, grep {$_ le $char[$i+1]}                           chars4();
            }
        }
        elsif (length($char[$i-1]) == 3) {
            if (length($char[$i+1]) == 3) {
                push @range, grep {($char[$i-1] le $_) and ($_ le $char[$i+1])} chars3();
            }
            elsif (length($char[$i+1]) == 4) {
                push @range, grep {$char[$i-1] le $_}                           chars3();
                push @range, grep {$_ le $char[$i+1]}                           chars4();
            }
        }
        elsif (length($char[$i-1]) == 4) {
            if (length($char[$i+1]) == 4) {
                push @range, grep {($char[$i-1] le $_) and ($_ le $char[$i+1])} chars4();
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
        if (((caller(1))[3] ne 'Char::Elatin2::_octets') and ($modifier =~ m/i/oxms)) {
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

        # not ignore case or one of multiple-octet
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

    my $ignorecase = ($modifier =~ m/i/oxms) ? 1 : 0;

    # unescape character
    for (my $i=0; $i <= $#char; $i++) {

        # escape - to ...
        if ($char[$i] eq '-') {
            if ((0 < $i) and ($i < $#char)) {
                $char[$i] = '...';
            }
        }

        # octal escape sequence
        elsif ($char[$i] =~ m/\A \\o \{ ([0-7]+) \} \z/oxms) {
            $char[$i] = octchr($1);
        }

        # hexadecimal escape sequence
        elsif ($char[$i] =~ m/\A \\x \{ ([0-9A-Fa-f]+) \} \z/oxms) {
            $char[$i] = hexchr($1);
        }

        # \N{CHARNAME} --> N{CHARNAME}
        elsif ($char[$i] =~ m/\A \\ ( N\{ ([^0-9\}][^\}]*) \} ) \z/oxms) {
            $char[$i] = $1;
        }

        # \p{PROPERTY} --> p{PROPERTY}
        elsif ($char[$i] =~ m/\A \\ ( p\{ ([^0-9\}][^\}]*) \} ) \z/oxms) {
            $char[$i] = $1;
        }

        # \P{PROPERTY} --> P{PROPERTY}
        elsif ($char[$i] =~ m/\A \\ ( P\{ ([^0-9\}][^\}]*) \} ) \z/oxms) {
            $char[$i] = $1;
        }

        # \p, \P, \X --> p, P, X
        elsif ($char[$i] =~ m/\A \\ ( [pPX] ) \z/oxms) {
            $char[$i] = $1;
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
        elsif ($char[$i] =~ m/\A (\\ [0nrtfbaedswDSWHVhvR]) \z/oxms) {
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
                '\D' => '@{Char::Elatin2::eD}',
                '\S' => '@{Char::Elatin2::eS}',
                '\W' => '@{Char::Elatin2::eW}',

                '\H' => '@{Char::Elatin2::eH}',
                '\V' => '@{Char::Elatin2::eV}',
                '\h' => '[\x09\x20]',
                '\v' => '[\x0C\x0A\x0D]',
                '\R' => '@{Char::Elatin2::eR}',

            }->{$1};
        }

        # POSIX-style character classes
        elsif ($ignorecase and ($char[$i] =~ m/\A ( \[\: \^? (?:lower|upper) :\] ) \z/oxms)) {
            $char[$i] = {

                '[:lower:]'   => '[\x41-\x5A\x61-\x7A]',
                '[:upper:]'   => '[\x41-\x5A\x61-\x7A]',
                '[:^lower:]'  => '@{Char::Elatin2::not_lower_i}',
                '[:^upper:]'  => '@{Char::Elatin2::not_upper_i}',

            }->{$1};
        }
        elsif ($char[$i] =~ m/\A ( \[\: \^? (?:alnum|alpha|ascii|blank|cntrl|digit|graph|lower|print|punct|space|upper|word|xdigit) :\] ) \z/oxms) {
            $char[$i] = {

                '[:alnum:]'   => '[\x30-\x39\x41-\x5A\x61-\x7A]',
                '[:alpha:]'   => '[\x41-\x5A\x61-\x7A]',
                '[:ascii:]'   => '[\x00-\x7F]',
                '[:blank:]'   => '[\x09\x20]',
                '[:cntrl:]'   => '[\x00-\x1F\x7F]',
                '[:digit:]'   => '[\x30-\x39]',
                '[:graph:]'   => '[\x21-\x7F]',
                '[:lower:]'   => '[\x61-\x7A]',
                '[:print:]'   => '[\x20-\x7F]',
                '[:punct:]'   => '[\x21-\x2F\x3A-\x3F\x40\x5B-\x5F\x60\x7B-\x7E]',
                '[:space:]'   => '[\x09\x0A\x0B\x0C\x0D\x20]',
                '[:upper:]'   => '[\x41-\x5A]',
                '[:word:]'    => '[\x30-\x39\x41-\x5A\x5F\x61-\x7A]',
                '[:xdigit:]'  => '[\x30-\x39\x41-\x46\x61-\x66]',
                '[:^alnum:]'  => '@{Char::Elatin2::not_alnum}',
                '[:^alpha:]'  => '@{Char::Elatin2::not_alpha}',
                '[:^ascii:]'  => '@{Char::Elatin2::not_ascii}',
                '[:^blank:]'  => '@{Char::Elatin2::not_blank}',
                '[:^cntrl:]'  => '@{Char::Elatin2::not_cntrl}',
                '[:^digit:]'  => '@{Char::Elatin2::not_digit}',
                '[:^graph:]'  => '@{Char::Elatin2::not_graph}',
                '[:^lower:]'  => '@{Char::Elatin2::not_lower}',
                '[:^print:]'  => '@{Char::Elatin2::not_print}',
                '[:^punct:]'  => '@{Char::Elatin2::not_punct}',
                '[:^space:]'  => '@{Char::Elatin2::not_space}',
                '[:^upper:]'  => '@{Char::Elatin2::not_upper}',
                '[:^word:]'   => '@{Char::Elatin2::not_word}',
                '[:^xdigit:]' => '@{Char::Elatin2::not_xdigit}',

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

            # range of multiple-octet code
            elsif (length($char[$i-1]) == length($char[$i+1])) {
                push @charlist, _octets(length($char[$i-1]), $char[$i-1], $char[$i+1], $modifier);
            }
            elsif (length($char[$i-1]) == 1) {
                if (length($char[$i+1]) == 2) {
                    push @charlist,
                        _octets(1, $char[$i-1], maxchar(1),  $modifier),
                        _octets(2, minchar(2),  $char[$i+1], $modifier);
                }
                elsif (length($char[$i+1]) == 3) {
                    push @charlist,
                        _octets(1, $char[$i-1], maxchar(1),  $modifier),
                        _octets(2, minchar(2),  maxchar(2),  $modifier),
                        _octets(3, minchar(3),  $char[$i+1], $modifier);
                }
                elsif (length($char[$i+1]) == 4) {
                    push @charlist,
                        _octets(1, $char[$i-1], maxchar(1),  $modifier),
                        _octets(2, minchar(2),  maxchar(2),  $modifier),
                        _octets(3, minchar(3),  maxchar(3),  $modifier),
                        _octets(4, minchar(4),  $char[$i+1], $modifier);
                }
            }
            elsif (length($char[$i-1]) == 2) {
                if (length($char[$i+1]) == 3) {
                    push @charlist,
                        _octets(2, $char[$i-1], maxchar(2),  $modifier),
                        _octets(3, minchar(3),  $char[$i+1], $modifier);
                }
                elsif (length($char[$i+1]) == 4) {
                    push @charlist,
                        _octets(2, $char[$i-1], maxchar(2),  $modifier),
                        _octets(3, minchar(3),  maxchar(3),  $modifier),
                        _octets(4, minchar(4),  $char[$i+1], $modifier);
                }
            }
            elsif (length($char[$i-1]) == 3) {
                if (length($char[$i+1]) == 4) {
                    push @charlist,
                        _octets(3, $char[$i-1], maxchar(3),  $modifier),
                        _octets(4, minchar(4),  $char[$i+1], $modifier);
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
                my $uc = Char::Elatin2::uc($char[$i]);
                my $lc = Char::Elatin2::lc($char[$i]);
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
        elsif ($char[$i] =~ m/\A (?: \\h ) \z/oxms) {
            push @singleoctet, "\t", "\x20";
            $i += 1;
        }
        elsif ($char[$i] =~ m/\A (?: \\v ) \z/oxms) {
            push @singleoctet, "\f","\n","\r";
            $i += 1;
        }
        elsif ($char[$i] =~ m/\A (?: \\d | \\s | \\w ) \z/oxms) {
            push @singleoctet, $char[$i];
            $i += 1;
        }

        # single character of multiple-octet code
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
# Latin-2 octal escape sequence
#
sub octchr {
    my($octdigit) = @_;

    my @binary = ();
    for my $octal (split(//,$octdigit)) {
        push @binary, {
            '0' => '000',
            '1' => '001',
            '2' => '010',
            '3' => '011',
            '4' => '100',
            '5' => '101',
            '6' => '110',
            '7' => '111',
        }->{$octal};
    }
    my $binary = join '', @binary;

    my $octchr = {
        #                1234567
        1 => pack('B*', "0000000$binary"),
        2 => pack('B*', "000000$binary"),
        3 => pack('B*', "00000$binary"),
        4 => pack('B*', "0000$binary"),
        5 => pack('B*', "000$binary"),
        6 => pack('B*', "00$binary"),
        7 => pack('B*', "0$binary"),
        0 => pack('B*', "$binary"),

    }->{CORE::length($binary) % 8};

    return $octchr;
}

#
# Latin-2 hexadecimal escape sequence
#
sub hexchr {
    my($hexdigit) = @_;

    my $hexchr = {
        1 => pack('H*', "0$hexdigit"),
        0 => pack('H*', "$hexdigit"),

    }->{CORE::length($_[0]) % 2};

    return $hexchr;
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

            # any character other than multiple-octet and single octet character class
            return '(?!' . join('|', @charlist) . ')(?:[^'. join('', @singleoctet) . '])';
        }
        else {

            # any character other than multiple-octet character class
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
sub Char::Elatin2::chr(;$) {

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
sub Char::Elatin2::chr_() {

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
sub Char::Elatin2::glob($) {

    return _dosglob(@_);
}

#
# Latin-2 path globbing (without parameter)
#
sub Char::Elatin2::glob_() {

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
    my $fix_drive_relative_paths = 0;

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
            if ($expr =~ s# \A ((?:[A-Za-z]:)?) ([^/\\]) #$1./$2#oxms) {
                $fix_drive_relative_paths = 1;
            }
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
            elsif ((my $uc = Char::Elatin2::uc($char)) ne $char) {
                $pattern .= $uc;
            }
            else {
                $pattern .= quotemeta $char;
            }
        }
        my $matchsub = sub { Char::Elatin2::uc($_[0]) =~ m{\A $pattern \z}xms };

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

            if (Char::Elatin2::index($leaf,'.') == -1 and   # if name does not have a dot in it *and*
                CORE::length($leaf) <= 8 and        # name is shorter than or equal to 8 chars *and*
                Char::Elatin2::index($pattern,'\\.') != -1  # pattern has a dot.
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
    if ($fix_drive_relative_paths) {
        for my $glob (@glob) {
            $glob =~ s# \A ([A-Za-z]:) \./ #$1#oxms;
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
# ${^PREMATCH}, $PREMATCH, $` the string preceding what was matched
#
sub Char::Elatin2::PREMATCH {
    return $`;
}

#
# ${^MATCH}, $MATCH, $& the string that matched
#
sub Char::Elatin2::MATCH {
    return $&;
}

#
# ${^POSTMATCH}, $POSTMATCH, $' the string following what was matched
#
sub Char::Elatin2::POSTMATCH {
    return $';
}

#
# Latin-2 character to order (with parameter)
#
sub Char::Latin2::ord(;$) {

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
sub Char::Latin2::ord_() {

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
sub Char::Latin2::reverse(@) {

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
sub Char::Latin2::length(;$) {

    local $_ = shift if @_;

    local @_ = m/\G ($q_char) /oxmsg;
    return scalar @_;
}

#
# Latin-2 substr by character
#
sub Char::Latin2::substr($$;$$) {

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
sub Char::Latin2::index($$;$) {

    my $index;
    if (@_ == 3) {
        $index = Char::Elatin2::index($_[0], $_[1], CORE::length(Char::Latin2::substr($_[0], 0, $_[2])));
    }
    else {
        $index = Char::Elatin2::index($_[0], $_[1]);
    }

    if ($index == -1) {
        return -1;
    }
    else {
        return Char::Latin2::length(CORE::substr $_[0], 0, $index);
    }
}

#
# Latin-2 rindex by character
#
sub Char::Latin2::rindex($$;$) {

    my $rindex;
    if (@_ == 3) {
        $rindex = Char::Elatin2::rindex($_[0], $_[1], CORE::length(Char::Latin2::substr($_[0], 0, $_[2])));
    }
    else {
        $rindex = Char::Elatin2::rindex($_[0], $_[1]);
    }

    if ($rindex == -1) {
        return -1;
    }
    else {
        return Char::Latin2::length(CORE::substr $_[0], 0, $rindex);
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

Char::Elatin2 - Run-time routines for Char/Latin2.pm

=head1 SYNOPSIS

  use Char::Elatin2;

    Char::Elatin2::split(...);
    Char::Elatin2::tr(...);
    Char::Elatin2::chop(...);
    Char::Elatin2::index(...);
    Char::Elatin2::rindex(...);
    Char::Elatin2::lc(...);
    Char::Elatin2::lc_;
    Char::Elatin2::lcfirst(...);
    Char::Elatin2::lcfirst_;
    Char::Elatin2::uc(...);
    Char::Elatin2::uc_;
    Char::Elatin2::ucfirst(...);
    Char::Elatin2::ucfirst_;
    Char::Elatin2::ignorecase(...);
    Char::Elatin2::capture(...);
    Char::Elatin2::chr(...);
    Char::Elatin2::chr_;
    Char::Elatin2::glob(...);
    Char::Elatin2::glob_;

  # "no Char::Elatin2;" not supported

=head1 ABSTRACT

This module is a run-time routines of the Char/Latin2.pm.
Because the Char/Latin2.pm automatically uses this module, you need not use directly.

=head1 BUGS AND LIMITATIONS

I have tested and verified this software using the best of my ability.
However, a software containing much regular expression is bound to contain
some bugs. Thus, if you happen to find a bug that's in Char::Latin2 software and not
your own program, you can try to reduce it to a minimal test case and then
report it to the following author's address. If you have an idea that could
make this a more useful tool, please let everyone share it.

=head1 HISTORY

This Char::Elatin2 module first appeared in ActivePerl Build 522 Built under
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

  @split = Char::Elatin2::split(/pattern/,$string,$limit);
  @split = Char::Elatin2::split(/pattern/,$string);
  @split = Char::Elatin2::split(/pattern/);
  @split = Char::Elatin2::split('',$string,$limit);
  @split = Char::Elatin2::split('',$string);
  @split = Char::Elatin2::split('');
  @split = Char::Elatin2::split();
  @split = Char::Elatin2::split;

  Scans a Latin-2 $string for delimiters that match pattern and splits the Latin-2
  $string into a list of substrings, returning the resulting list value in list
  context, or the count of substrings in scalar context. The delimiters are
  determined by repeated pattern matching, using the regular expression given in
  pattern, so the delimiters may be of any size and need not be the same Latin-2
  $string on every match. If the pattern doesn't match at all, Char::Elatin2::split returns
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
  Unlike Perl4, you cannot force the split into @_ by using ?? as the pattern
  delimiters, it only returns the list value.

=item Transliteration

  $tr = Char::Elatin2::tr($variable,$bind_operator,$searchlist,$replacementlist,$modifier);
  $tr = Char::Elatin2::tr($variable,$bind_operator,$searchlist,$replacementlist);

  This function scans a Latin-2 string character by character and replaces all
  occurrences of the characters found in $searchlist with the corresponding character
  in $replacementlist. It returns the number of characters replaced or deleted.
  If no Latin-2 string is specified via =~ operator, the $_ variable is translated.
  $modifier are:

  ------------------------------------------------------
  Modifier   Meaning
  ------------------------------------------------------
  c          Complement $searchlist
  d          Delete found but unreplaced characters
  s          Squash duplicate replaced characters
  ------------------------------------------------------

=item Chop string

  $chop = Char::Elatin2::chop(@list);
  $chop = Char::Elatin2::chop();
  $chop = Char::Elatin2::chop;

  Chops off the last character of a Latin-2 string contained in the variable (or
  Latin-2 strings in each element of a @list) and returns the character chopped.
  The Char::Elatin2::chop operator is used primarily to remove the newline from the end of
  an input record but is more efficient than s/\n$//. If no argument is given, the
  function chops the $_ variable.

=item Index string

  $pos = Char::Elatin2::index($string,$substr,$position);
  $pos = Char::Elatin2::index($string,$substr);

  Returns the position of the first occurrence of $substr in Latin-2 $string.
  The start, if specified, specifies the $position to start looking in the Latin-2
  $string. Positions are integer numbers based at 0. If the substring is not found,
  the Char::Elatin2::index function returns -1.

=item Reverse index string

  $pos = Char::Elatin2::rindex($string,$substr,$position);
  $pos = Char::Elatin2::rindex($string,$substr);

  Works just like Char::Elatin2::index except that it returns the position of the last
  occurence of $substr in Latin-2 $string (a reverse index). The function returns
  -1 if not found. $position, if specified, is the rightmost position that may be
  returned, i.e., how far in the Latin-2 string the function can search.

=item Lower case string

  $lc = Char::Elatin2::lc($string);
  $lc = Char::Elatin2::lc_;

  Returns a lowercase version of Latin-2 string (or $_, if omitted). This is the
  internal function implementing the \L escape in double-quoted strings.

=item Lower case first character of string

  $lcfirst = Char::Elatin2::lcfirst($string);
  $lcfirst = Char::Elatin2::lcfirst_;

  Returns a version of Latin-2 string (or $_, if omitted) with the first character
  lowercased. This is the internal function implementing the \l escape in double-
  quoted strings.

=item Upper case string

  $uc = Char::Elatin2::uc($string);
  $uc = Char::Elatin2::uc_;

  Returns an uppercased version of Latin-2 string (or $_, if string is omitted).
  This is the internal function implementing the \U escape in double-quoted
  strings.

=item Upper case first character of string

  $ucfirst = Char::Elatin2::ucfirst($string);
  $ucfirst = Char::Elatin2::ucfirst_;

  Returns a version of Latin-2 string (or $_, if omitted) with the first character
  uppercased. This is the internal function implementing the \u escape in double-
  quoted strings.

=item Make ignore case string

  @ignorecase = Char::Elatin2::ignorecase(@string);

  This function is internal use to m/ /i, s/ / /i, split / /i and qr/ /i.

=item Make capture number

  $capturenumber = Char::Elatin2::capture($string);

  This function is internal use to m/ /, s/ / /, split / / and qr/ /.

=item Make character

  $chr = Char::Elatin2::chr($code);
  $chr = Char::Elatin2::chr_;

  This function returns the character represented by that $code in the character
  set. For example, Char::Elatin2::chr(65) is "A" in either ASCII or Latin-2, not Unicode,
  and Char::Elatin2::chr(0x82a0) is a Latin-2 HIRAGANA LETTER A. For the reverse of
  Char::Elatin2::chr, use Char::Latin2::ord.

=item Filename expansion (globbing)

  @glob = Char::Elatin2::glob($string);
  @glob = Char::Elatin2::glob_;

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

=cut

