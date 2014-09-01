#
# This file is *** FOR CPAN USE ONLY ***.
#
# If you are an application programmer, please use file that 'Char::' removed.
#
package Char::Latin2;
######################################################################
#
# Char::Latin2 - Source code filter to escape Latin-2 script
#
# http://search.cpan.org/dist/Char-Latin2/
#
# Copyright (c) 2008, 2009, 2010, 2011, 2012, 2013, 2014 INABA Hitoshi <ina@cpan.org>
######################################################################

use 5.00503;    # Galapagos Consensus 1998 for primetools
# use 5.008001; # Lancaster Consensus 2013 for toolchains

# 12.3. Delaying use Until Runtime
# in Chapter 12. Packages, Libraries, and Modules
# of ISBN 0-596-00313-7 Perl Cookbook, 2nd Edition.
# (and so on)

BEGIN { eval q{ use vars qw($VERSION) } }
$VERSION = sprintf '%d.%02d', q$Revision: 1.00 $ =~ /(\d+)/oxmsg;

BEGIN {
    if ($^X =~ / jperl /oxmsi) {
        die __FILE__, ": needs perl(not jperl) 5.00503 or later. (\$^X==$^X)";
    }
    if (CORE::ord('A') == 193) {
        die __FILE__, ": is not US-ASCII script (may be EBCDIC or EBCDIK script).";
    }
    if (CORE::ord('A') != 0x41) {
        die __FILE__, ": is not US-ASCII script (must be US-ASCII script).";
    }
}

BEGIN { CORE::require Char::Elatin2; }

# instead of Symbol.pm
BEGIN {
    my $genpkg = "Symbol::";
    my $genseq = 0;
    sub gensym () {
        my $name = "GEN" . $genseq++;

        # here, no strict qw(refs); if strict.pm exists

        my $ref = \*{$genpkg . $name};
        delete $$genpkg{$name};
        $ref;
    }
}

# Column: local $@
# in Chapter 9. Osaete okitai Perl no kiso
# of ISBN 10: 4798119172 | ISBN 13: 978-4798119175 MODAN Perl NYUMON
# (and so on)

# use strict; if strict.pm exists
BEGIN {
    if (eval { local $@; CORE::require strict }) {
        strict::->import;
    }
}

# P.714 29.2.39. flock
# in Chapter 29: Functions
# of ISBN 0-596-00027-8 Programming Perl Third Edition.

# P.863 flock
# in Chapter 27: Functions
# of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

# P.228 Inlining Constant Functions
# in Chapter 6: Subroutines
# of ISBN 0-596-00027-8 Programming Perl Third Edition.

# P.331 Inlining Constant Functions
# in Chapter 7: Subroutines
# of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

sub LOCK_SH() {1}
sub LOCK_EX() {2}
sub LOCK_UN() {8}
sub LOCK_NB() {4}

sub unimport {}
sub Char::Latin2::escape_script;

# 6.18. Matching Multiple-Byte Characters
# in Chapter 6. Pattern Matching
# of ISBN 978-1-56592-243-3 Perl Perl Cookbook.
# (and so on)

# regexp of character
my $your_char = q{[\x00-\xFF]};
my $qq_char   = qr/\\c[\x40-\x5F]|\\?(?:$your_char)/oxms;
my  $q_char   = qr/$your_char/oxms;

# P.1023 Appendix W.9 Multibyte Anchoring
# of ISBN 1-56592-224-7 CJKV Information Processing

my $anchor = '';

BEGIN { eval q{ use vars qw($nest) } }

# regexp of nested parens in qqXX

# P.340 Matching Nested Constructs with Embedded Code
# in Chapter 7: Perl
# of ISBN 0-596-00289-0 Mastering Regular Expressions, Second edition

my $qq_paren   = qr{(?{local $nest=0}) (?>(?:
                    \\c[\x40-\x5F] |
                    \\ [\x00-\xFF] |
                    [^()] |
                             \(  (?{$nest++}) |
                             \)  (?(?{$nest>0})(?{$nest--})|(?!)))*) (?(?{$nest!=0})(?!))
                 }xms;
my $qq_brace   = qr{(?{local $nest=0}) (?>(?:
                    \\c[\x40-\x5F] |
                    \\ [\x00-\xFF] |
                    [^{}] |
                             \{  (?{$nest++}) |
                             \}  (?(?{$nest>0})(?{$nest--})|(?!)))*) (?(?{$nest!=0})(?!))
                 }xms;
my $qq_bracket = qr{(?{local $nest=0}) (?>(?:
                    \\c[\x40-\x5F] |
                    \\ [\x00-\xFF] |
                    [^[\]] |
                             \[  (?{$nest++}) |
                             \]  (?(?{$nest>0})(?{$nest--})|(?!)))*) (?(?{$nest!=0})(?!))
                 }xms;
my $qq_angle   = qr{(?{local $nest=0}) (?>(?:
                    \\c[\x40-\x5F] |
                    \\ [\x00-\xFF] |
                    [^<>] |
                             \<  (?{$nest++}) |
                             \>  (?(?{$nest>0})(?{$nest--})|(?!)))*) (?(?{$nest!=0})(?!))
                 }xms;
my $qq_scalar  = qr{(?: \{ (?:$qq_brace)*? \} |
                       (?: ::)? (?:
                             [a-zA-Z_][a-zA-Z_0-9]*
                       (?: ::[a-zA-Z_][a-zA-Z_0-9]* )* (?:                                   \[ (?: \$\[ | \$\] | $qq_char )*? \] |           \{ (?:$qq_brace)*? \} )*
                                         (?: (?: -> )? (?: [\$\@\%\&\*]\* | \$\#\* | [\@\%]? \[ (?: \$\[ | \$\] | $qq_char )*? \] | [\@\%\*]? \{ (?:$qq_brace)*? \} ) )*
                   ))
                 }xms;
my $qq_variable = qr{(?: \{ (?:$qq_brace)*? \}                    |
                        (?: ::)? (?:
                              [0-9]+                              |
                              [^a-zA-Z_0-9\[\]] |
                              ^[A-Z]                              |
                              [a-zA-Z_][a-zA-Z_0-9]*
                        (?: ::[a-zA-Z_][a-zA-Z_0-9]* )* (?:                                   \[ (?: \$\[ | \$\] | $qq_char )*? \] |           \{ (?:$qq_brace)*? \} )*
                                          (?: (?: -> )? (?: [\$\@\%\&\*]\* | \$\#\* | [\@\%]? \[ (?: \$\[ | \$\] | $qq_char )*? \] | [\@\%\*]? \{ (?:$qq_brace)*? \} ) )*
                    ))
                  }xms;
my $qq_substr  = qr{(?: Char::Latin2::substr | CORE::substr | substr ) \( $qq_paren \)
                 }xms;

# regexp of nested parens in qXX
my $q_paren    = qr{(?{local $nest=0}) (?>(?:
                    [^()] |
                             \(  (?{$nest++}) |
                             \)  (?(?{$nest>0})(?{$nest--})|(?!)))*) (?(?{$nest!=0})(?!))
                 }xms;
my $q_brace    = qr{(?{local $nest=0}) (?>(?:
                    [^{}] |
                             \{  (?{$nest++}) |
                             \}  (?(?{$nest>0})(?{$nest--})|(?!)))*) (?(?{$nest!=0})(?!))
                 }xms;
my $q_bracket  = qr{(?{local $nest=0}) (?>(?:
                    [^[\]] |
                             \[  (?{$nest++}) |
                             \]  (?(?{$nest>0})(?{$nest--})|(?!)))*) (?(?{$nest!=0})(?!))
                 }xms;
my $q_angle    = qr{(?{local $nest=0}) (?>(?:
                    [^<>] |
                             \<  (?{$nest++}) |
                             \>  (?(?{$nest>0})(?{$nest--})|(?!)))*) (?(?{$nest!=0})(?!))
                 }xms;

my $matched     = '';
my $s_matched   = '';

my $tr_variable   = '';   # variable of tr///
my $sub_variable  = '';   # variable of s///
my $bind_operator = '';   # =~ or !~
BEGIN { eval q{ use vars qw($slash) } }
                          # when 'm//', '/' means regexp match 'm//' and '?' means regexp match '??'
                          # when 'div', '/' means division operator and '?' means conditional operator (condition ? then : else)
my @heredoc = ();         # here document
my @heredoc_delimiter = ();
my $here_script = '';     # here script
my $function_ord;         # ord()   to ord()   or Char::Latin2::ord()
my $function_ord_;        # ord     to ord     or Char::Latin2::ord_
my $function_reverse;     # reverse to reverse or Char::Latin2::reverse
my $function_getc;        # getc    to getc    or Char::Latin2::getc

my $ignore_modules = join('|', qw(
    utf8
    bytes
    charnames
    I18N::Japanese
    I18N::Collate
    I18N::JExt
    File::DosGlob
    Wild
    Wildcard
    Japanese
));

# when this script is main program
if ($0 eq __FILE__) {

    # show usage
    unless (@ARGV) {
        die <<END;
$0: usage

perl $0 Latin-2_script.pl > Escaped_script.pl.e
END
    }

    print Char::Latin2::escape_script($ARGV[0]);
    exit 0;
}

my($package,$filename,$line,$subroutine,$hasargs,$wantarray,$evaltext,$is_require,$hints,$bitmask) = caller 0;

# called any package not main
if ($package ne 'main') {
    die <<END;
@{[__FILE__]}: escape by manually command '$^X @{[__FILE__]} "$filename" > "@{[__PACKAGE__]}::$filename"'
and rewrite "use $package;" to "use @{[__PACKAGE__]}::$package;" of script "$0".
END
}

# P.302 Module Privacy and the Exporter
# in Chapter 11: Modules
# of ISBN 0-596-00027-8 Programming Perl Third Edition.
#
# A module can do anything it jolly well pleases when it's used, since use just
# calls the ordinary import method for the module, and you can define that
# method to do anything you like.

# P.406 Module Privacy and the Exporter
# in Chapter 11: Modules
# of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.
#
# A module can do anything it jolly well pleases when it's used, since use just
# calls the ordinary import method for the module, and you can define that
# method to do anything you like.

sub import {

    if (-e("$filename.e")) {
        if (exists $ENV{'SJIS_DEBUG'}) {
            unlink "$filename.e";
        }
        elsif (-z("$filename.e")) {
            unlink "$filename.e";
        }
        else {

            #----------------------------------------------------
            #  older >
            #  newer >>>>>
            #----------------------------------------------------
            # Filter >
            # Source >>>>>
            # Escape >>>   needs re-escape (Source was changed)
            #
            # Filter >>>
            # Source >>>>>
            # Escape >     needs re-escape (Source was changed)
            #
            # Filter >>>>>
            # Source >>>
            # Escape >     needs re-escape (Source was changed)
            #
            # Filter >>>>>
            # Source >
            # Escape >>>   needs re-escape (Filter was changed)
            #
            # Filter >
            # Source >>>
            # Escape >>>>> executable without re-escape
            #
            # Filter >>>
            # Source >
            # Escape >>>>> executable without re-escape
            #----------------------------------------------------

            my $mtime_filter = (stat(__FILE__     ))[9];
            my $mtime_source = (stat($filename    ))[9];
            my $mtime_escape = (stat("$filename.e"))[9];
            if (($mtime_escape < $mtime_source) or ($mtime_escape < $mtime_filter)) {
                unlink "$filename.e";
            }
        }
    }

    if (not -e("$filename.e")) {
        my $fh = gensym();

        if (eval q{ use Fcntl qw(O_WRONLY O_APPEND O_CREAT); 1 } and CORE::sysopen($fh,"$filename.e",&O_WRONLY|&O_APPEND|&O_CREAT)) {
        }
        else {
            Char::Elatin2::_open_a($fh, "$filename.e") or die __FILE__, ": Can't write open file: $filename.e";
        }

        if (0) {
        }
        elsif (exists $ENV{'SJIS_NONBLOCK'}) {

            # P.419 File Locking
            # in Chapter 16: Interprocess Communication
            # of ISBN 0-596-00027-8 Programming Perl Third Edition.

            # P.524 File Locking
            # in Chapter 15: Interprocess Communication
            # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

            # P.571 Handling Race Conditions
            # in Chapter 23: Security
            # of ISBN 0-596-00027-8 Programming Perl Third Edition.

            # P.663 Handling Race Conditions
            # in Chapter 20: Security
            # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

            # (and so on)

            eval q{
                unless (flock($fh, LOCK_EX | LOCK_NB)) {
                    warn __FILE__, ": Can't immediately write-lock the file: $filename.e";
                    exit;
                }
            };
        }
        else {
            eval q{ flock($fh, LOCK_EX) };
        }

        eval q{ truncate($fh, 0) };
        seek($fh, 0, 0) or die __FILE__, ": Can't seek file: $filename.e";

        my $e_script = Char::Latin2::escape_script($filename);
        print {$fh} $e_script;

        my $mode = (stat($filename))[2] & 0777;
        chmod $mode, "$filename.e";

        close($fh) or die __FILE__, ": Can't close file: $filename.e";
    }

    my $fh = gensym();
    Char::Elatin2::_open_r($fh, "$filename.e") or die __FILE__, ": Can't read open file: $filename.e";

    if (0) {
    }
    elsif (exists $ENV{'SJIS_NONBLOCK'}) {
        eval q{
            unless (flock($fh, LOCK_SH | LOCK_NB)) {
                warn __FILE__, ": Can't immediately read-lock the file: $filename.e";
                exit;
            }
        };
    }
    else {
        eval q{ flock($fh, LOCK_SH) };
    }

    my @switch = ();
    if ($^W) {
        push @switch, '-w';
    }

    # P.707 29.2.33. exec
    # in Chapter 29: Functions
    # of ISBN 0-596-00027-8 Programming Perl Third Edition.
    #
    # If there is more than one argument in LIST, or if LIST is an array with more
    # than one value, the system shell will never be used. This also bypasses any
    # shell processing of the command. The presence or absence of metacharacters in
    # the arguments doesn't affect this list-triggered behavior, which makes it the
    # preferred from in security-conscious programs that do not with to expose
    # themselves to potential shell escapes.
    # Environment variable PERL5SHELL(Microsoft ports only) will never be used, too.

    # P.855 exec
    # in Chapter 27: Functions
    # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.
    #
    # If there is more than one argument in LIST, or if LIST is an array with more
    # than one value, the system shell will never be used. This also bypasses any
    # shell processing of the command. The presence or absence of metacharacters in
    # the arguments doesn't affect this list-triggered behavior, which makes it the
    # preferred from in security-conscious programs that do not wish to expose
    # themselves to injection attacks via shell escapes.
    # Environment variable PERL5SHELL(Microsoft ports only) will never be used, too.

    # P.489 #! and Quoting on Non-Unix Systems
    # in Chapter 19: The Command-Line Interface
    # of ISBN 0-596-00027-8 Programming Perl Third Edition.

    # P.578 #! and Quoting on Non-Unix Systems
    # in Chapter 17: The Command-Line Interface
    # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

    # DOS-like system
    if ($^O =~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms) {
        exit Char::Elatin2::_systemx(
            _escapeshellcmd_MSWin32($^X),

        # -I switch can not treat space included path
        #   (map { '-I' . _escapeshellcmd_MSWin32($_) } @INC),
            (map { '-I' .                         $_  } @INC),

            @switch,
            '--',
            map { _escapeshellcmd_MSWin32($_) } "$filename.e", @ARGV
        );
    }

    # UNIX-like system
    else {
        exit Char::Elatin2::_systemx(
            _escapeshellcmd($^X),
            (map { '-I' . _escapeshellcmd($_) } @INC),
            @switch,
            '--',
            map { _escapeshellcmd($_) } "$filename.e", @ARGV
        );
    }
}

# escape shell command line on DOS-like system
sub _escapeshellcmd_MSWin32 {
    my($word) = @_;
    if ($word =~ / [ ] /oxms) {

        # both DOS-like and UNIX-like shell quote
        return qq{"$word"};
    }
    else {
        return $word;
    }
}

# escape shell command line on UNIX-like system
sub _escapeshellcmd {
    my($word) = @_;
    return $word;
}

# P.619 Source Filters
# in Chapter 24: Common Practices
# of ISBN 0-596-00027-8 Programming Perl Third Edition.

# P.718 Source Filters
# in Chapter 21: Common Practices
# of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

# escape Latin-2 script
sub Char::Latin2::escape_script {
    my($script) = @_;
    my $e_script = '';

    # read Latin-2 script
    my $fh = gensym();
    Char::Elatin2::_open_r($fh, $script) or die __FILE__, ": Can't open file: $script";
    local $/ = undef; # slurp mode
    $_ = <$fh>;
    close($fh) or die __FILE__, ": Can't close file: $script";

    if (/^ use Char::Elatin2(?:\s+[0-9\.]*)?\s*; $/oxms) {
        return $_;
    }
    else {

        # #! shebang line
        if (s/\A(#!.+?\n)//oms) {
            my $head = $1;
            $head =~ s/\bjperl\b/perl/gi;
            $e_script .= $head;
        }

        # DOS-like system header
        if (s/\A(\@rem\s*=\s*'.*?'\s*;\s*\n)//oms) {
            my $head = $1;
            $head =~ s/\bjperl\b/perl/gi;
            $e_script .= $head;
        }

        # P.618 Generating Perl in Other Languages
        # in Chapter 24: Common Practices
        # of ISBN 0-596-00027-8 Programming Perl Third Edition.

        # P.717 Generating Perl in Other Languages
        # in Chapter 21: Common Practices
        # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

        if (s/(.*^#\s*line\s+\d+(?:\s+"(?:$q_char)+?")?\s*\n)//oms) {
            my $head = $1;
            $head =~ s/\bjperl\b/perl/gi;
            $e_script .= $head;
        }

        # P.210 5.10.3.3. Match-time code evaluation
        # in Chapter 5: Pattern Matching
        # of ISBN 0-596-00027-8 Programming Perl Third Edition.

        # P.255 Match-time code evaluation
        # in Chapter 5: Pattern Matching
        # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

        $e_script .= sprintf("use Char::Elatin2 %s.0;\n", $Char::Latin2::VERSION); # require run-time routines version

        # use Char::Latin2 version qw(ord reverse getc);
        $function_ord     = 'ord';
        $function_ord_    = 'ord';
        $function_reverse = 'reverse';
        $function_getc    = 'getc';
        if (s/^ \s* use \s+ Char::Latin2 \s* ([^;]*) ; \s* \n? $//oxms) {

            # require version
            my $list = $1;
            if ($list =~ s/\A ([0-9]+\.[0-9]+) \.0 \s* //oxms) {
                my $version = $1;
                if ($version ne $Char::Latin2::VERSION) {
                    my @file = grep -e, map {qq{$_/Char/Latin2.pm}} @INC;
                    my %file = map { $_ => 1 } @file;
                    if (scalar(keys %file) >= 2) {
                        my $file = join "\n", sort keys %file;
                        warn <<END;
****************************************************
                   C A U T I O N

              CONFLICT Char/Latin2.pm FILE

$file
****************************************************

END
                    }
                    die "Script $0 expects Char/Latin2.pm $version, but @{[__FILE__]} is version $Char::Latin2::VERSION\n";
                }
                $e_script .= qq{die "Script \$0 expects Char/Elatin2.pm $version, but \\\$Char::Elatin2::VERSION is \$Char::Elatin2::VERSION" if \$Char::Elatin2::VERSION ne '$version';\n};
            }
            elsif ($list =~ s/\A ([0-9]+(?:\.[0-9]*)) \s* //oxms) {
                my $version = $1;
                if ($version > $Char::Latin2::VERSION) {
                    die "Script $0 required Char/Latin2.pm $version, but @{[__FILE__]} is only version $Char::Latin2::VERSION\n";
                }
            }

            # demand ord, reverse, and getc
            if ($list !~ /\A \s* \z/oxms) {
                local $@;
                my @list = eval $list;
                for (@list) {
                    $function_ord     = 'Char::Latin2::ord'     if /\A ord \z/oxms;
                    $function_ord_    = 'Char::Latin2::ord_'    if /\A ord \z/oxms;
                    $function_reverse = 'Char::Latin2::reverse' if /\A reverse \z/oxms;
                    $function_getc    = 'Char::Latin2::getc'    if /\A getc \z/oxms;
                }
            }
        }
    }

    $slash = 'm//';

    # P.359 The Study Function
    # in Chapter 7: Perl
    # of ISBN 0-596-00289-0 Mastering Regular Expressions, Second edition

    study $_; # Yes, I studied study yesterday.

    # while all script

    # 6.14. Matching from Where the Last Pattern Left Off
    # in Chapter 6. Pattern Matching
    # of ISBN 0-596-00313-7 Perl Cookbook, 2nd Edition.
    # (and so on)

    # one member of Tag-team
    #
    # P.128 Start of match (or end of previous match): \G
    # P.130 Advanced Use of \G with Perl
    # in Chapter 3: Overview of Regular Expression Features and Flavors
    # P.255 Use leading anchors
    # P.256 Expose ^ and \G at the front expressions
    # in Chapter 6: Crafting an Efficient Expression
    # P.315 "Tag-team" matching with /gc
    # in Chapter 7: Perl
    # of ISBN 0-596-00289-0 Mastering Regular Expressions, Second edition

    while (not /\G \z/oxgc) { # member
        $e_script .= escape();
    }

    return $e_script;
}

# escape Latin-2 part of script
sub escape {

# \n output here document

    # another member of Tag-team
    #
    # P.315 "Tag-team" matching with /gc
    # in Chapter 7: Perl
    # of ISBN 0-596-00289-0 Mastering Regular Expressions, Second edition

    if (/\G ( \n ) /oxgc) { # another member (and so on)
        my $heredoc = '';
        if (scalar(@heredoc_delimiter) >= 1) {
            $slash = 'm//';

            $heredoc = join '', @heredoc;
            @heredoc = ();

            # skip here document
            for my $heredoc_delimiter (@heredoc_delimiter) {
                /\G .*? \n $heredoc_delimiter \n/xmsgc;
            }
            @heredoc_delimiter = ();

            $here_script = '';
        }
        return "\n" . $heredoc;
    }

# ignore space, comment
    elsif (/\G (\s+|\#.*) /oxgc) { return $1; }

# if (, elsif (, unless (, while (, until (, given (, and when (

    # given, when

    # P.225 The given Statement
    # in Chapter 15: Smart Matching and given-when
    # of ISBN 978-0-596-52010-6 Learning Perl, Fifth Edition

    # P.133 The given Statement
    # in Chapter 4: Statements and Declarations
    # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

    elsif (/\G ( (?: if | elsif | unless | while | until | given | when ) \s* \( ) /oxgc) {
        $slash = 'm//';
        return $1;
    }

# scalar variable ($scalar = ...) =~ tr///;
# scalar variable ($scalar = ...) =~ s///;

    # state

    # P.68 Persistent, Private Variables
    # in Chapter 4: Subroutines
    # of ISBN 978-0-596-52010-6 Learning Perl, Fifth Edition

    # P.160 Persistent Lexically Scoped Variables: state
    # in Chapter 4: Statements and Declarations
    # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

    # (and so on)

    elsif (/\G ( \( \s* (?: local \b | my \b | our \b | state \b )? \s* \$ $qq_scalar ) /oxgc) {
        my $e_string = e_string($1);

        if (/\G ( \s* = $qq_paren \) ) ( \s* (?: =~ | !~ ) \s* ) (?= (?: tr | y ) \b ) /oxgc) {
            $tr_variable = $e_string . e_string($1);
            $bind_operator = $2;
            $slash = 'm//';
            return '';
        }
        elsif (/\G ( \s* = $qq_paren \) ) ( \s* (?: =~ | !~ ) \s* ) (?= s \b ) /oxgc) {
            $sub_variable = $e_string . e_string($1);
            $bind_operator = $2;
            $slash = 'm//';
            return '';
        }
        else {
            $slash = 'div';
            return $e_string;
        }
    }

# $`, ${`}, $PREMATCH, ${PREMATCH}, ${^PREMATCH} --> Char::Elatin2::PREMATCH()
    elsif (/\G ( \$` | \$\{`\} | \$ \s* PREMATCH  \b | \$ \s* \{ \s* PREMATCH  \s* \} | \$ \s* \{\^PREMATCH\}  ) /oxmsgc) {
        $slash = 'div';
        return q{Char::Elatin2::PREMATCH()};
    }

# $&, ${&}, $MATCH, ${MATCH}, ${^MATCH} --> Char::Elatin2::MATCH()
    elsif (/\G ( \$& | \$\{&\} | \$ \s* MATCH     \b | \$ \s* \{ \s* MATCH     \s* \} | \$ \s* \{\^MATCH\}     ) /oxmsgc) {
        $slash = 'div';
        return q{Char::Elatin2::MATCH()};
    }

# $', ${'} --> $', ${'}
    elsif (/\G ( \$' | \$\{'\}                                                                                 ) /oxmsgc) {
        $slash = 'div';
        return $1;
    }

# $POSTMATCH, ${POSTMATCH}, ${^POSTMATCH} --> Char::Elatin2::POSTMATCH()
    elsif (/\G (                 \$ \s* POSTMATCH \b | \$ \s* \{ \s* POSTMATCH \s* \} | \$ \s* \{\^POSTMATCH\} ) /oxmsgc) {
        $slash = 'div';
        return q{Char::Elatin2::POSTMATCH()};
    }

# scalar variable $scalar =~ tr///;
# scalar variable $scalar =~ s///;
# substr() =~ tr///;
# substr() =~ s///;
    elsif (/\G ( \$ $qq_scalar | $qq_substr ) /oxgc) {
        my $scalar = e_string($1);

        if (/\G ( \s* (?: =~ | !~ ) \s* ) (?= (?: tr | y ) \b ) /oxgc) {
            $tr_variable = $scalar;
            $bind_operator = $1;
            $slash = 'm//';
            return '';
        }
        elsif (/\G ( \s* (?: =~ | !~ ) \s* ) (?= s \b ) /oxgc) {
            $sub_variable = $scalar;
            $bind_operator = $1;
            $slash = 'm//';
            return '';
        }
        else {
            $slash = 'div';
            return $scalar;
        }
    }

    # end of statement
    elsif (/\G ( [,;] ) /oxgc) {
        $slash = 'm//';

        # clear tr/// variable
        $tr_variable  = '';

        # clear s/// variable
        $sub_variable  = '';

        $bind_operator = '';

        return $1;
    }

# bareword
    elsif (/\G ( \{ \s* (?: tr | index | rindex | reverse ) \s* \} ) /oxmsgc) {
        return $1;
    }

# $0 --> $0
    elsif (/\G ( \$ 0 ) /oxmsgc) {
        $slash = 'div';
        return $1;
    }
    elsif (/\G ( \$ \{ \s* 0 \s* \} ) /oxmsgc) {
        $slash = 'div';
        return $1;
    }

# $$ --> $$
    elsif (/\G ( \$ \$ ) (?![\w\{]) /oxmsgc) {
        $slash = 'div';
        return $1;
    }

# $1, $2, $3 --> $2, $3, $4 after s/// with multibyte anchoring
# $1, $2, $3 --> $1, $2, $3 otherwise
    elsif (/\G \$ ([1-9][0-9]*) /oxmsgc) {
        $slash = 'div';
        return e_capture($1);
    }
    elsif (/\G \$ \{ \s* ([1-9][0-9]*) \s* \} /oxmsgc) {
        $slash = 'div';
        return e_capture($1);
    }

# $$foo[ ... ] --> $ $foo->[ ... ]
    elsif (/\G \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) ( \[ .+? \] ) /oxmsgc) {
        $slash = 'div';
        return e_capture($1.'->'.$2);
    }

# $$foo{ ... } --> $ $foo->{ ... }
    elsif (/\G \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) ( \{ .+? \} ) /oxmsgc) {
        $slash = 'div';
        return e_capture($1.'->'.$2);
    }

# $$foo
    elsif (/\G \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) /oxmsgc) {
        $slash = 'div';
        return e_capture($1);
    }

# ${ foo }
    elsif (/\G \$ \s* \{ ( \s* [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* \s* ) \} /oxmsgc) {
        $slash = 'div';
        return '${' . $1 . '}';
    }

# ${ ... }
    elsif (/\G \$ \s* \{ \s* ( $qq_brace ) \s* \} /oxmsgc) {
        $slash = 'div';
        return e_capture($1);
    }

# variable or function
    #                  $ @ % & *     $ #
    elsif (/\G ( (?: [\$\@\%\&\*] | \$\# | -> | \b sub \b) \s* (?: split | chop | index | rindex | lc | uc | fc | chr | ord | reverse | getc | tr | y | q | qq | qx | qw | m | s | qr | glob | lstat | opendir | stat | unlink | chdir ) ) \b /oxmsgc) {
        $slash = 'div';
        return $1;
    }
    #                $ $ $ $ $ $ $ $ $ $ $ $ $ $
    #                $ @ # \ ' " / ? ( ) [ ] < >
    elsif (/\G ( \$[\$\@\#\\\'\"\/\?\(\)\[\]\<\>] ) /oxmsgc) {
        $slash = 'div';
        return $1;
    }

# while (<FILEHANDLE>)
    elsif (/\G \b (while \s* \( \s* <[\$]?[A-Za-z_][A-Za-z_0-9]*> \s* \)) \b /oxgc) {
        return $1;
    }

# while (<WILDCARD>) --- glob

    # avoid "Error: Runtime exception" of perl version 5.005_03

    elsif (/\G \b while \s* \( \s* < ((?:[^>\0\a\e\f\n\r\t])+?) > \s* \) \b /oxgc) {
        return 'while ($_ = Char::Elatin2::glob("' . $1 . '"))';
    }

# while (glob)
    elsif (/\G \b while \s* \( \s* glob \s* \) /oxgc) {
        return 'while ($_ = Char::Elatin2::glob_)';
    }

# while (glob(WILDCARD))
    elsif (/\G \b while \s* \( \s* glob \b /oxgc) {
        return 'while ($_ = Char::Elatin2::glob';
    }

# doit if, doit unless, doit while, doit until, doit for, doit when
    elsif (/\G \b ( if | unless | while | until | for | when ) \b /oxgc) { $slash = 'm//'; return $1; }

# subroutines of package Char::Elatin2
    elsif (/\G \b (CORE:: | ->[ ]* (?: atan2 | [a-z]{2,})) \b  /oxgc) { $slash = 'm//'; return $1;                    }
    elsif (/\G \b bytes::substr \b (?! \s* => )                /oxgc) { $slash = 'm//'; return 'substr';              }
    elsif (/\G \b chop \b          (?! \s* => )                /oxgc) { $slash = 'm//'; return 'Char::Elatin2::chop';         }
    elsif (/\G \b bytes::index \b  (?! \s* => )                /oxgc) { $slash = 'm//'; return 'index';               }
    elsif (/\G \b Char::Latin2::index \b   (?! \s* => )                /oxgc) { $slash = 'm//'; return 'Char::Latin2::index';         }
    elsif (/\G \b index \b         (?! \s* => )                /oxgc) { $slash = 'm//'; return 'Char::Elatin2::index';        }
    elsif (/\G \b bytes::rindex \b (?! \s* => )                /oxgc) { $slash = 'm//'; return 'rindex';              }
    elsif (/\G \b Char::Latin2::rindex \b  (?! \s* => )                /oxgc) { $slash = 'm//'; return 'Char::Latin2::rindex';        }
    elsif (/\G \b rindex \b        (?! \s* => )                /oxgc) { $slash = 'm//'; return 'Char::Elatin2::rindex';       }
    elsif (/\G \b lc      (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $slash = 'm//'; return 'Char::Elatin2::lc';           }
    elsif (/\G \b lcfirst (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $slash = 'm//'; return 'Char::Elatin2::lcfirst';      }
    elsif (/\G \b uc      (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $slash = 'm//'; return 'Char::Elatin2::uc';           }
    elsif (/\G \b ucfirst (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $slash = 'm//'; return 'Char::Elatin2::ucfirst';      }
    elsif (/\G \b fc      (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $slash = 'm//'; return 'Char::Elatin2::fc';           }

    # "-s '' ..." means file test "-s 'filename' ..." (not means "- s/// ...")
    elsif (/\G -s                               \s+    \s* (\") ((?:$qq_char)+?)               (\") /oxgc) { $slash = 'm//'; return '-s ' . e_qq('',  $1,$3,$2); }
    elsif (/\G -s                               \s+ qq \s* (\#) ((?:$qq_char)+?)               (\#) /oxgc) { $slash = 'm//'; return '-s ' . e_qq('qq',$1,$3,$2); }
    elsif (/\G -s                               \s+ qq \s* (\() ((?:$qq_paren)+?)              (\)) /oxgc) { $slash = 'm//'; return '-s ' . e_qq('qq',$1,$3,$2); }
    elsif (/\G -s                               \s+ qq \s* (\{) ((?:$qq_brace)+?)              (\}) /oxgc) { $slash = 'm//'; return '-s ' . e_qq('qq',$1,$3,$2); }
    elsif (/\G -s                               \s+ qq \s* (\[) ((?:$qq_bracket)+?)            (\]) /oxgc) { $slash = 'm//'; return '-s ' . e_qq('qq',$1,$3,$2); }
    elsif (/\G -s                               \s+ qq \s* (\<) ((?:$qq_angle)+?)              (\>) /oxgc) { $slash = 'm//'; return '-s ' . e_qq('qq',$1,$3,$2); }
    elsif (/\G -s                               \s+ qq \s* (\S) ((?:$qq_char)+?)               (\1) /oxgc) { $slash = 'm//'; return '-s ' . e_qq('qq',$1,$3,$2); }

    elsif (/\G -s                               \s+    \s* (\') ((?:\\\'|\\\\|$q_char)+?)      (\') /oxgc) { $slash = 'm//'; return '-s ' . e_q ('',  $1,$3,$2); }
    elsif (/\G -s                               \s+ q  \s* (\#) ((?:\\\#|\\\\|$q_char)+?)      (\#) /oxgc) { $slash = 'm//'; return '-s ' . e_q ('q', $1,$3,$2); }
    elsif (/\G -s                               \s+ q  \s* (\() ((?:\\\)|\\\\|$q_paren)+?)     (\)) /oxgc) { $slash = 'm//'; return '-s ' . e_q ('q', $1,$3,$2); }
    elsif (/\G -s                               \s+ q  \s* (\{) ((?:\\\}|\\\\|$q_brace)+?)     (\}) /oxgc) { $slash = 'm//'; return '-s ' . e_q ('q', $1,$3,$2); }
    elsif (/\G -s                               \s+ q  \s* (\[) ((?:\\\]|\\\\|$q_bracket)+?)   (\]) /oxgc) { $slash = 'm//'; return '-s ' . e_q ('q', $1,$3,$2); }
    elsif (/\G -s                               \s+ q  \s* (\<) ((?:\\\>|\\\\|$q_angle)+?)     (\>) /oxgc) { $slash = 'm//'; return '-s ' . e_q ('q', $1,$3,$2); }
    elsif (/\G -s                               \s+ q  \s* (\S) ((?:\\\1|\\\\|$q_char)+?)      (\1) /oxgc) { $slash = 'm//'; return '-s ' . e_q ('q', $1,$3,$2); }

    elsif (/\G -s                               \s* (\$ \w+(?: ::\w+)* (?: (?: ->)? (?: [\$\@\%\&\*]\* | \$\#\* | \( (?:$qq_paren)*? \) | [\@\%\*]? \{ (?:$qq_brace)+? \} | [\@\%]? \[ (?:$qq_bracket)+? \] ) )*) /oxgc)
                                                                                                           { $slash = 'm//'; return "-s $1";   }
    elsif (/\G -s                               \s* \( ((?:$qq_paren)*?) \)                         /oxgc) { $slash = 'm//'; return "-s ($1)"; }
    elsif (/\G -s                               (?= \s+ [a-z]+)                                     /oxgc) { $slash = 'm//'; return '-s';      }
    elsif (/\G -s                               \s+ (\w+)                                           /oxgc) { $slash = 'm//'; return "-s $1";   }

    elsif (/\G \b bytes::length (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $slash = 'm//'; return 'length';                   }
    elsif (/\G \b bytes::chr    (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $slash = 'm//'; return 'chr';                      }
    elsif (/\G \b chr           (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $slash = 'm//'; return 'Char::Elatin2::chr';               }
    elsif (/\G \b bytes::ord    (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $slash = 'div'; return 'ord';                      }
    elsif (/\G \b ord           (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $slash = 'div'; return $function_ord;              }
    elsif (/\G \b glob          (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $slash = 'm//'; return 'Char::Elatin2::glob';              }
    elsif (/\G \b lc \b            (?! \s* => )                      /oxgc) { $slash = 'm//'; return 'Char::Elatin2::lc_';               }
    elsif (/\G \b lcfirst \b       (?! \s* => )                      /oxgc) { $slash = 'm//'; return 'Char::Elatin2::lcfirst_';          }
    elsif (/\G \b uc \b            (?! \s* => )                      /oxgc) { $slash = 'm//'; return 'Char::Elatin2::uc_';               }
    elsif (/\G \b ucfirst \b       (?! \s* => )                      /oxgc) { $slash = 'm//'; return 'Char::Elatin2::ucfirst_';          }
    elsif (/\G \b fc \b            (?! \s* => )                      /oxgc) { $slash = 'm//'; return 'Char::Elatin2::fc_';               }
    elsif (/\G    -s \b            (?! \s* => )                      /oxgc) { $slash = 'm//'; return '-s ';                      }

    elsif (/\G \b bytes::length \b (?! \s* => )                      /oxgc) { $slash = 'm//'; return 'length';                   }
    elsif (/\G \b bytes::chr \b    (?! \s* => )                      /oxgc) { $slash = 'm//'; return 'chr';                      }
    elsif (/\G \b chr \b           (?! \s* => )                      /oxgc) { $slash = 'm//'; return 'Char::Elatin2::chr_';              }
    elsif (/\G \b bytes::ord \b    (?! \s* => )                      /oxgc) { $slash = 'div'; return 'ord';                      }
    elsif (/\G \b ord \b           (?! \s* => )                      /oxgc) { $slash = 'div'; return $function_ord_;             }
    elsif (/\G \b glob \b          (?! \s* => )                      /oxgc) { $slash = 'm//'; return 'Char::Elatin2::glob_';             }
    elsif (/\G \b reverse \b       (?! \s* => )                      /oxgc) { $slash = 'm//'; return $function_reverse;          }
    elsif (/\G \b getc \b          (?! \s* => )                      /oxgc) { $slash = 'm//'; return $function_getc;             }

# split
    elsif (/\G \b (split) \b (?! \s* => ) /oxgc) {
        $slash = 'm//';

        my $e = '';
        while (/\G ( \s+ | \( | \#.* ) /oxgc) {
            $e .= $1;
        }

# end of split
        if    (/\G (?= [,;\)\}\]] )          /oxgc) { return 'Char::Elatin2::split' . $e;                 }

# split scalar value
        elsif (/\G ( [\$\@\&\*] $qq_scalar ) /oxgc) { return 'Char::Elatin2::split' . $e . e_string($1);  }

# split literal space
        elsif (/\G \b qq       (\#) [ ] (\#) /oxgc) { return 'Char::Elatin2::split' . $e . qq  {qq$1 $2}; }
        elsif (/\G \b qq (\s*) (\() [ ] (\)) /oxgc) { return 'Char::Elatin2::split' . $e . qq{$1qq$2 $3}; }
        elsif (/\G \b qq (\s*) (\{) [ ] (\}) /oxgc) { return 'Char::Elatin2::split' . $e . qq{$1qq$2 $3}; }
        elsif (/\G \b qq (\s*) (\[) [ ] (\]) /oxgc) { return 'Char::Elatin2::split' . $e . qq{$1qq$2 $3}; }
        elsif (/\G \b qq (\s*) (\<) [ ] (\>) /oxgc) { return 'Char::Elatin2::split' . $e . qq{$1qq$2 $3}; }
        elsif (/\G \b qq (\s*) (\S) [ ] (\2) /oxgc) { return 'Char::Elatin2::split' . $e . qq{$1qq$2 $3}; }
        elsif (/\G \b q        (\#) [ ] (\#) /oxgc) { return 'Char::Elatin2::split' . $e . qq   {q$1 $2}; }
        elsif (/\G \b q  (\s*) (\() [ ] (\)) /oxgc) { return 'Char::Elatin2::split' . $e . qq {$1q$2 $3}; }
        elsif (/\G \b q  (\s*) (\{) [ ] (\}) /oxgc) { return 'Char::Elatin2::split' . $e . qq {$1q$2 $3}; }
        elsif (/\G \b q  (\s*) (\[) [ ] (\]) /oxgc) { return 'Char::Elatin2::split' . $e . qq {$1q$2 $3}; }
        elsif (/\G \b q  (\s*) (\<) [ ] (\>) /oxgc) { return 'Char::Elatin2::split' . $e . qq {$1q$2 $3}; }
        elsif (/\G \b q  (\s*) (\S) [ ] (\2) /oxgc) { return 'Char::Elatin2::split' . $e . qq {$1q$2 $3}; }
        elsif (/\G                ' [ ] '    /oxgc) { return 'Char::Elatin2::split' . $e . qq     {' '};  }
        elsif (/\G                " [ ] "    /oxgc) { return 'Char::Elatin2::split' . $e . qq     {" "};  }

# split qq//
        elsif (/\G \b (qq) \b /oxgc) {
            if (/\G (\#) ((?:$qq_char)*?) (\#) /oxgc)                        { return e_split($e.'qr',$1,$3,$2,'');   } # qq# #  --> qr # #
            else {
                while (not /\G \z/oxgc) {
                    if    (/\G (\s+|\#.*)                             /oxgc) { $e .= $1; }
                    elsif (/\G (\()          ((?:$qq_paren)*?)   (\)) /oxgc) { return e_split($e.'qr',$1,$3,$2,'');   } # qq ( ) --> qr ( )
                    elsif (/\G (\{)          ((?:$qq_brace)*?)   (\}) /oxgc) { return e_split($e.'qr',$1,$3,$2,'');   } # qq { } --> qr { }
                    elsif (/\G (\[)          ((?:$qq_bracket)*?) (\]) /oxgc) { return e_split($e.'qr',$1,$3,$2,'');   } # qq [ ] --> qr [ ]
                    elsif (/\G (\<)          ((?:$qq_angle)*?)   (\>) /oxgc) { return e_split($e.'qr',$1,$3,$2,'');   } # qq < > --> qr < >
                    elsif (/\G ([*\-:?\\^|]) ((?:$qq_char)*?)    (\1) /oxgc) { return e_split($e.'qr','{','}',$2,''); } # qq | | --> qr { }
                    elsif (/\G (\S)          ((?:$qq_char)*?)    (\1) /oxgc) { return e_split($e.'qr',$1,$3,$2,'');   } # qq * * --> qr * *
                }
                die __FILE__, ": Can't find string terminator anywhere before EOF";
            }
        }

# split qr//
        elsif (/\G \b (qr) \b /oxgc) {
            if (/\G (\#) ((?:$qq_char)*?) (\#) ([imosxpadlubB]*) /oxgc)                        { return e_split  ($e.'qr',$1,$3,$2,$4);   } # qr# #
            else {
                while (not /\G \z/oxgc) {
                    if    (/\G (\s+|\#.*)                                               /oxgc) { $e .= $1; }
                    elsif (/\G (\()          ((?:$qq_paren)*?)   (\)) ([imosxpadlubB]*) /oxgc) { return e_split  ($e.'qr',$1, $3, $2,$4); } # qr ( )
                    elsif (/\G (\{)          ((?:$qq_brace)*?)   (\}) ([imosxpadlubB]*) /oxgc) { return e_split  ($e.'qr',$1, $3, $2,$4); } # qr { }
                    elsif (/\G (\[)          ((?:$qq_bracket)*?) (\]) ([imosxpadlubB]*) /oxgc) { return e_split  ($e.'qr',$1, $3, $2,$4); } # qr [ ]
                    elsif (/\G (\<)          ((?:$qq_angle)*?)   (\>) ([imosxpadlubB]*) /oxgc) { return e_split  ($e.'qr',$1, $3, $2,$4); } # qr < >
                    elsif (/\G (\')          ((?:$qq_char)*?)    (\') ([imosxpadlubB]*) /oxgc) { return e_split_q($e.'qr',$1, $3, $2,$4); } # qr ' '
                    elsif (/\G ([*\-:?\\^|]) ((?:$qq_char)*?)    (\1) ([imosxpadlubB]*) /oxgc) { return e_split  ($e.'qr','{','}',$2,$4); } # qr | | --> qr { }
                    elsif (/\G (\S)          ((?:$qq_char)*?)    (\1) ([imosxpadlubB]*) /oxgc) { return e_split  ($e.'qr',$1, $3, $2,$4); } # qr * *
                }
                die __FILE__, ": Can't find string terminator anywhere before EOF";
            }
        }

# split q//
        elsif (/\G \b (q) \b /oxgc) {
            if (/\G (\#) ((?:\\\#|\\\\|$q_char)*?) (\#) /oxgc)                    { return e_split_q($e.'qr',$1,$3,$2,'');   } # q# #  --> qr # #
            else {
                while (not /\G \z/oxgc) {
                    if    (/\G (\s+|\#.*)                                  /oxgc) { $e .= $1; }
                    elsif (/\G (\() ((?:\\\\|\\\)|\\\(|$q_paren)*?)   (\)) /oxgc) { return e_split_q($e.'qr',$1,$3,$2,'');   } # q ( ) --> qr ( )
                    elsif (/\G (\{) ((?:\\\\|\\\}|\\\{|$q_brace)*?)   (\}) /oxgc) { return e_split_q($e.'qr',$1,$3,$2,'');   } # q { } --> qr { }
                    elsif (/\G (\[) ((?:\\\\|\\\]|\\\[|$q_bracket)*?) (\]) /oxgc) { return e_split_q($e.'qr',$1,$3,$2,'');   } # q [ ] --> qr [ ]
                    elsif (/\G (\<) ((?:\\\\|\\\>|\\\<|$q_angle)*?)   (\>) /oxgc) { return e_split_q($e.'qr',$1,$3,$2,'');   } # q < > --> qr < >
                    elsif (/\G ([*\-:?\\^|])       ((?:$q_char)*?)    (\1) /oxgc) { return e_split_q($e.'qr','{','}',$2,''); } # q | | --> qr { }
                    elsif (/\G (\S) ((?:\\\\|\\\1|     $q_char)*?)    (\1) /oxgc) { return e_split_q($e.'qr',$1,$3,$2,'');   } # q * * --> qr * *
                }
                die __FILE__, ": Can't find string terminator anywhere before EOF";
            }
        }

# split m//
        elsif (/\G \b (m) \b /oxgc) {
            if (/\G (\#) ((?:$qq_char)*?) (\#) ([cgimosxpadlubB]*) /oxgc)                        { return e_split  ($e.'qr',$1,$3,$2,$4);   } # m# #  --> qr # #
            else {
                while (not /\G \z/oxgc) {
                    if    (/\G (\s+|\#.*)                                                 /oxgc) { $e .= $1; }
                    elsif (/\G (\()          ((?:$qq_paren)*?)   (\)) ([cgimosxpadlubB]*) /oxgc) { return e_split  ($e.'qr',$1, $3, $2,$4); } # m ( ) --> qr ( )
                    elsif (/\G (\{)          ((?:$qq_brace)*?)   (\}) ([cgimosxpadlubB]*) /oxgc) { return e_split  ($e.'qr',$1, $3, $2,$4); } # m { } --> qr { }
                    elsif (/\G (\[)          ((?:$qq_bracket)*?) (\]) ([cgimosxpadlubB]*) /oxgc) { return e_split  ($e.'qr',$1, $3, $2,$4); } # m [ ] --> qr [ ]
                    elsif (/\G (\<)          ((?:$qq_angle)*?)   (\>) ([cgimosxpadlubB]*) /oxgc) { return e_split  ($e.'qr',$1, $3, $2,$4); } # m < > --> qr < >
                    elsif (/\G (\')          ((?:$qq_char)*?)    (\') ([cgimosxpadlubB]*) /oxgc) { return e_split_q($e.'qr',$1, $3, $2,$4); } # m ' ' --> qr ' '
                    elsif (/\G ([*\-:?\\^|]) ((?:$qq_char)*?)    (\1) ([cgimosxpadlubB]*) /oxgc) { return e_split  ($e.'qr','{','}',$2,$4); } # m | | --> qr { }
                    elsif (/\G (\S)          ((?:$qq_char)*?)    (\1) ([cgimosxpadlubB]*) /oxgc) { return e_split  ($e.'qr',$1, $3, $2,$4); } # m * * --> qr * *
                }
                die __FILE__, ": Search pattern not terminated";
            }
        }

# split ''
        elsif (/\G (\') /oxgc) {
            my $q_string = '';
            while (not /\G \z/oxgc) {
                if    (/\G (\\\\)    /oxgc) { $q_string .= $1; }
                elsif (/\G (\\\')    /oxgc) { $q_string .= $1; }                               # splitqr'' --> split qr''
                elsif (/\G \'        /oxgc)                                                    { return e_split_q($e.q{ qr},"'","'",$q_string,''); } # ' ' --> qr ' '
                elsif (/\G ($q_char) /oxgc) { $q_string .= $1; }
            }
            die __FILE__, ": Can't find string terminator anywhere before EOF";
        }

# split ""
        elsif (/\G (\") /oxgc) {
            my $qq_string = '';
            while (not /\G \z/oxgc) {
                if    (/\G (\\\\)    /oxgc) { $qq_string .= $1; }
                elsif (/\G (\\\")    /oxgc) { $qq_string .= $1; }                              # splitqr"" --> split qr""
                elsif (/\G \"        /oxgc)                                                    { return e_split($e.q{ qr},'"','"',$qq_string,''); } # " " --> qr " "
                elsif (/\G ($q_char) /oxgc) { $qq_string .= $1; }
            }
            die __FILE__, ": Can't find string terminator anywhere before EOF";
        }

# split //
        elsif (/\G (\/) /oxgc) {
            my $regexp = '';
            while (not /\G \z/oxgc) {
                if    (/\G (\\\\)                 /oxgc) { $regexp .= $1; }
                elsif (/\G (\\\/)                 /oxgc) { $regexp .= $1; }                    # splitqr// --> split qr//
                elsif (/\G \/ ([cgimosxpadlubB]*) /oxgc)                                       { return e_split($e.q{ qr}, '/','/',$regexp,$1); } # / / --> qr / /
                elsif (/\G ($q_char)              /oxgc) { $regexp .= $1; }
            }
            die __FILE__, ": Search pattern not terminated";
        }
    }

# tr/// or y///

    # about [cdsrbB]* (/B modifier)
    #
    # P.559 appendix C
    # of ISBN 4-89052-384-7 Programming perl
    # (Japanese title is: Perl puroguramingu)

    elsif (/\G \b ( tr | y ) \b /oxgc) {
        my $ope = $1;

        #        $1   $2               $3   $4               $5   $6
        if (/\G (\#) ((?:$qq_char)*?) (\#) ((?:$qq_char)*?) (\#) ([cdsrbB]*) /oxgc) { # tr# # #
            my @tr = ($tr_variable,$2);
            return e_tr(@tr,'',$4,$6);
        }
        else {
            my $e = '';
            while (not /\G \z/oxgc) {
                if    (/\G (\s+|\#.*)                  /oxgc) { $e .= $1; }
                elsif (/\G (\() ((?:$qq_paren)*?) (\)) /oxgc) {
                    my @tr = ($tr_variable,$2);
                    while (not /\G \z/oxgc) {
                        if    (/\G (\s+|\#.*)                                /oxgc) { $e .= $1; }
                        elsif (/\G (\() ((?:$qq_paren)*?)   (\)) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr ( ) ( )
                        elsif (/\G (\{) ((?:$qq_brace)*?)   (\}) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr ( ) { }
                        elsif (/\G (\[) ((?:$qq_bracket)*?) (\]) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr ( ) [ ]
                        elsif (/\G (\<) ((?:$qq_angle)*?)   (\>) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr ( ) < >
                        elsif (/\G (\S) ((?:$qq_char)*?)    (\1) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr ( ) * *
                    }
                    die __FILE__, ": Transliteration replacement not terminated";
                }
                elsif (/\G (\{) ((?:$qq_brace)*?) (\}) /oxgc) {
                    my @tr = ($tr_variable,$2);
                    while (not /\G \z/oxgc) {
                        if    (/\G (\s+|\#.*)                                /oxgc) { $e .= $1; }
                        elsif (/\G (\() ((?:$qq_paren)*?)   (\)) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr { } ( )
                        elsif (/\G (\{) ((?:$qq_brace)*?)   (\}) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr { } { }
                        elsif (/\G (\[) ((?:$qq_bracket)*?) (\]) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr { } [ ]
                        elsif (/\G (\<) ((?:$qq_angle)*?)   (\>) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr { } < >
                        elsif (/\G (\S) ((?:$qq_char)*?)    (\1) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr { } * *
                    }
                    die __FILE__, ": Transliteration replacement not terminated";
                }
                elsif (/\G (\[) ((?:$qq_bracket)*?) (\]) /oxgc) {
                    my @tr = ($tr_variable,$2);
                    while (not /\G \z/oxgc) {
                        if    (/\G (\s+|\#.*)                                /oxgc) { $e .= $1; }
                        elsif (/\G (\() ((?:$qq_paren)*?)   (\)) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr [ ] ( )
                        elsif (/\G (\{) ((?:$qq_brace)*?)   (\}) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr [ ] { }
                        elsif (/\G (\[) ((?:$qq_bracket)*?) (\]) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr [ ] [ ]
                        elsif (/\G (\<) ((?:$qq_angle)*?)   (\>) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr [ ] < >
                        elsif (/\G (\S) ((?:$qq_char)*?)    (\1) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr [ ] * *
                    }
                    die __FILE__, ": Transliteration replacement not terminated";
                }
                elsif (/\G (\<) ((?:$qq_angle)*?) (\>) /oxgc) {
                    my @tr = ($tr_variable,$2);
                    while (not /\G \z/oxgc) {
                        if    (/\G (\s+|\#.*)                                /oxgc) { $e .= $1; }
                        elsif (/\G (\() ((?:$qq_paren)*?)   (\)) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr < > ( )
                        elsif (/\G (\{) ((?:$qq_brace)*?)   (\}) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr < > { }
                        elsif (/\G (\[) ((?:$qq_bracket)*?) (\]) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr < > [ ]
                        elsif (/\G (\<) ((?:$qq_angle)*?)   (\>) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr < > < >
                        elsif (/\G (\S) ((?:$qq_char)*?)    (\1) ([cdsrbB]*) /oxgc) { return e_tr(@tr,$e,$2,$4); } # tr < > * *
                    }
                    die __FILE__, ": Transliteration replacement not terminated";
                }
                #           $1   $2               $3   $4               $5   $6
                elsif (/\G (\S) ((?:$qq_char)*?) (\1) ((?:$qq_char)*?) (\1) ([cdsrbB]*) /oxgc) { # tr * * *
                    my @tr = ($tr_variable,$2);
                    return e_tr(@tr,'',$4,$6);
                }
            }
            die __FILE__, ": Transliteration pattern not terminated";
        }
    }

# qq//
    elsif (/\G \b (qq) \b /oxgc) {
        my $ope = $1;

#       if (/\G (\#) ((?:$qq_char)*?) (\#) /oxgc) { return e_qq($ope,$1,$3,$2); } # qq# #
        if (/\G (\#) /oxgc) {                                                     # qq# #
            my $qq_string = '';
            while (not /\G \z/oxgc) {
                if    (/\G (\\\\)     /oxgc) { $qq_string .= $1;                     }
                elsif (/\G (\\\#)     /oxgc) { $qq_string .= $1;                     }
                elsif (/\G (\#)       /oxgc) { return e_qq($ope,'#','#',$qq_string); }
                elsif (/\G ($qq_char) /oxgc) { $qq_string .= $1;                     }
            }
            die __FILE__, ": Can't find string terminator anywhere before EOF";
        }

        else {
            my $e = '';
            while (not /\G \z/oxgc) {
                if    (/\G (\s+|\#.*)                  /oxgc) { $e .= $1; }

#               elsif (/\G (\() ((?:$qq_paren)*?) (\)) /oxgc) { return $e . e_qq($ope,$1,$3,$2); } # qq ( )
                elsif (/\G (\() /oxgc) {                                                           # qq ( )
                    my $qq_string = '';
                    local $nest = 1;
                    while (not /\G \z/oxgc) {
                        if    (/\G (\\\\)     /oxgc) { $qq_string .= $1;                          }
                        elsif (/\G (\\\))     /oxgc) { $qq_string .= $1;                          }
                        elsif (/\G (\()       /oxgc) { $qq_string .= $1; $nest++;                 }
                        elsif (/\G (\))       /oxgc) {
                            if (--$nest == 0)        { return $e . e_qq($ope,'(',')',$qq_string); }
                            else                     { $qq_string .= $1;                          }
                        }
                        elsif (/\G ($qq_char) /oxgc) { $qq_string .= $1;                          }
                    }
                    die __FILE__, ": Can't find string terminator anywhere before EOF";
                }

#               elsif (/\G (\{) ((?:$qq_brace)*?) (\}) /oxgc) { return $e . e_qq($ope,$1,$3,$2); } # qq { }
                elsif (/\G (\{) /oxgc) {                                                           # qq { }
                    my $qq_string = '';
                    local $nest = 1;
                    while (not /\G \z/oxgc) {
                        if    (/\G (\\\\)     /oxgc) { $qq_string .= $1;                          }
                        elsif (/\G (\\\})     /oxgc) { $qq_string .= $1;                          }
                        elsif (/\G (\{)       /oxgc) { $qq_string .= $1; $nest++;                 }
                        elsif (/\G (\})       /oxgc) {
                            if (--$nest == 0)        { return $e . e_qq($ope,'{','}',$qq_string); }
                            else                     { $qq_string .= $1;                          }
                        }
                        elsif (/\G ($qq_char) /oxgc) { $qq_string .= $1;                          }
                    }
                    die __FILE__, ": Can't find string terminator anywhere before EOF";
                }

#               elsif (/\G (\[) ((?:$qq_bracket)*?) (\]) /oxgc) { return $e . e_qq($ope,$1,$3,$2); } # qq [ ]
                elsif (/\G (\[) /oxgc) {                                                             # qq [ ]
                    my $qq_string = '';
                    local $nest = 1;
                    while (not /\G \z/oxgc) {
                        if    (/\G (\\\\)     /oxgc) { $qq_string .= $1;                          }
                        elsif (/\G (\\\])     /oxgc) { $qq_string .= $1;                          }
                        elsif (/\G (\[)       /oxgc) { $qq_string .= $1; $nest++;                 }
                        elsif (/\G (\])       /oxgc) {
                            if (--$nest == 0)        { return $e . e_qq($ope,'[',']',$qq_string); }
                            else                     { $qq_string .= $1;                          }
                        }
                        elsif (/\G ($qq_char) /oxgc) { $qq_string .= $1;                          }
                    }
                    die __FILE__, ": Can't find string terminator anywhere before EOF";
                }

#               elsif (/\G (\<) ((?:$qq_angle)*?) (\>) /oxgc) { return $e . e_qq($ope,$1,$3,$2); } # qq < >
                elsif (/\G (\<) /oxgc) {                                                           # qq < >
                    my $qq_string = '';
                    local $nest = 1;
                    while (not /\G \z/oxgc) {
                        if    (/\G (\\\\)     /oxgc) { $qq_string .= $1;                          }
                        elsif (/\G (\\\>)     /oxgc) { $qq_string .= $1;                          }
                        elsif (/\G (\<)       /oxgc) { $qq_string .= $1; $nest++;                 }
                        elsif (/\G (\>)       /oxgc) {
                            if (--$nest == 0)        { return $e . e_qq($ope,'<','>',$qq_string); }
                            else                     { $qq_string .= $1;                          }
                        }
                        elsif (/\G ($qq_char) /oxgc) { $qq_string .= $1;                          }
                    }
                    die __FILE__, ": Can't find string terminator anywhere before EOF";
                }

#               elsif (/\G (\S) ((?:$qq_char)*?) (\1) /oxgc) { return $e . e_qq($ope,$1,$3,$2); } # qq * *
                elsif (/\G (\S) /oxgc) {                                                          # qq * *
                    my $delimiter = $1;
                    my $qq_string = '';
                    while (not /\G \z/oxgc) {
                        if    (/\G (\\\\)             /oxgc) { $qq_string .= $1;                                        }
                        elsif (/\G (\\\Q$delimiter\E) /oxgc) { $qq_string .= $1;                                        }
                        elsif (/\G (\Q$delimiter\E)   /oxgc) { return $e . e_qq($ope,$delimiter,$delimiter,$qq_string); }
                        elsif (/\G ($qq_char)         /oxgc) { $qq_string .= $1;                                        }
                    }
                    die __FILE__, ": Can't find string terminator anywhere before EOF";
                }
            }
            die __FILE__, ": Can't find string terminator anywhere before EOF";
        }
    }

# qr//
    elsif (/\G \b (qr) \b /oxgc) {
        my $ope = $1;
        if (/\G (\#) ((?:$qq_char)*?) (\#) ([imosxpadlubB]*) /oxgc) { # qr# # #
            return e_qr($ope,$1,$3,$2,$4);
        }
        else {
            my $e = '';
            while (not /\G \z/oxgc) {
                if    (/\G (\s+|\#.*)                                               /oxgc) { $e .= $1; }
                elsif (/\G (\()          ((?:$qq_paren)*?)   (\)) ([imosxpadlubB]*) /oxgc) { return $e . e_qr  ($ope,$1, $3, $2,$4); } # qr ( )
                elsif (/\G (\{)          ((?:$qq_brace)*?)   (\}) ([imosxpadlubB]*) /oxgc) { return $e . e_qr  ($ope,$1, $3, $2,$4); } # qr { }
                elsif (/\G (\[)          ((?:$qq_bracket)*?) (\]) ([imosxpadlubB]*) /oxgc) { return $e . e_qr  ($ope,$1, $3, $2,$4); } # qr [ ]
                elsif (/\G (\<)          ((?:$qq_angle)*?)   (\>) ([imosxpadlubB]*) /oxgc) { return $e . e_qr  ($ope,$1, $3, $2,$4); } # qr < >
                elsif (/\G (\')          ((?:$qq_char)*?)    (\') ([imosxpadlubB]*) /oxgc) { return $e . e_qr_q($ope,$1, $3, $2,$4); } # qr ' '
                elsif (/\G ([*\-:?\\^|]) ((?:$qq_char)*?)    (\1) ([imosxpadlubB]*) /oxgc) { return $e . e_qr  ($ope,'{','}',$2,$4); } # qr | | --> qr { }
                elsif (/\G (\S)          ((?:$qq_char)*?)    (\1) ([imosxpadlubB]*) /oxgc) { return $e . e_qr  ($ope,$1, $3, $2,$4); } # qr * *
            }
            die __FILE__, ": Can't find string terminator anywhere before EOF";
        }
    }

# qw//
    elsif (/\G \b (qw) \b /oxgc) {
        my $ope = $1;
        if (/\G (\#) (.*?) (\#) /oxmsgc) { # qw# #
            return e_qw($ope,$1,$3,$2);
        }
        else {
            my $e = '';
            while (not /\G \z/oxgc) {
                if    (/\G (\s+|\#.*)                            /oxgc)   { $e .= $1; }

                elsif (/\G (\()          ([^(]*?)           (\)) /oxmsgc) { return $e . e_qw($ope,$1,$3,$2); } # qw ( )
                elsif (/\G (\()          ((?:$q_paren)*?)   (\)) /oxmsgc) { return $e . e_qw($ope,$1,$3,$2); } # qw ( )

                elsif (/\G (\{)          ([^{]*?)           (\}) /oxmsgc) { return $e . e_qw($ope,$1,$3,$2); } # qw { }
                elsif (/\G (\{)          ((?:$q_brace)*?)   (\}) /oxmsgc) { return $e . e_qw($ope,$1,$3,$2); } # qw { }

                elsif (/\G (\[)          ([^[]*?)           (\]) /oxmsgc) { return $e . e_qw($ope,$1,$3,$2); } # qw [ ]
                elsif (/\G (\[)          ((?:$q_bracket)*?) (\]) /oxmsgc) { return $e . e_qw($ope,$1,$3,$2); } # qw [ ]

                elsif (/\G (\<)          ([^<]*?)           (\>) /oxmsgc) { return $e . e_qw($ope,$1,$3,$2); } # qw < >
                elsif (/\G (\<)          ((?:$q_angle)*?)   (\>) /oxmsgc) { return $e . e_qw($ope,$1,$3,$2); } # qw < >

                elsif (/\G ([\x21-\x3F]) (.*?)              (\1) /oxmsgc) { return $e . e_qw($ope,$1,$3,$2); } # qw * *
                elsif (/\G (\S)          ((?:$q_char)*?)    (\1) /oxmsgc) { return $e . e_qw($ope,$1,$3,$2); } # qw * *
            }
            die __FILE__, ": Can't find string terminator anywhere before EOF";
        }
    }

# qx//
    elsif (/\G \b (qx) \b /oxgc) {
        my $ope = $1;
        if (/\G (\#) ((?:$qq_char)*?) (\#) /oxgc) { # qx# #
            return e_qq($ope,$1,$3,$2);
        }
        else {
            my $e = '';
            while (not /\G \z/oxgc) {
                if    (/\G (\s+|\#.*)                    /oxgc) { $e .= $1; }
                elsif (/\G (\() ((?:$qq_paren)*?)   (\)) /oxgc) { return $e . e_qq($ope,$1,$3,$2); } # qx ( )
                elsif (/\G (\{) ((?:$qq_brace)*?)   (\}) /oxgc) { return $e . e_qq($ope,$1,$3,$2); } # qx { }
                elsif (/\G (\[) ((?:$qq_bracket)*?) (\]) /oxgc) { return $e . e_qq($ope,$1,$3,$2); } # qx [ ]
                elsif (/\G (\<) ((?:$qq_angle)*?)   (\>) /oxgc) { return $e . e_qq($ope,$1,$3,$2); } # qx < >
                elsif (/\G (\') ((?:$qq_char)*?)    (\') /oxgc) { return $e . e_q ($ope,$1,$3,$2); } # qx ' '
                elsif (/\G (\S) ((?:$qq_char)*?)    (\1) /oxgc) { return $e . e_qq($ope,$1,$3,$2); } # qx * *
            }
            die __FILE__, ": Can't find string terminator anywhere before EOF";
        }
    }

# q//
    elsif (/\G \b (q) \b /oxgc) {
        my $ope = $1;

#       if (/\G (\#) ((?:\\\#|\\\\|$q_char)*?) (\#) /oxgc) { return e_q($ope,$1,$3,$2); } # q# #

        # avoid "Error: Runtime exception" of perl version 5.005_03
        # (and so on)

        if (/\G (\#) /oxgc) {                                                             # q# #
            my $q_string = '';
            while (not /\G \z/oxgc) {
                if    (/\G (\\\\)    /oxgc) { $q_string .= $1;                    }
                elsif (/\G (\\\#)    /oxgc) { $q_string .= $1;                    }
                elsif (/\G (\#)      /oxgc) { return e_q($ope,'#','#',$q_string); }
                elsif (/\G ($q_char) /oxgc) { $q_string .= $1;                    }
            }
            die __FILE__, ": Can't find string terminator anywhere before EOF";
        }

        else {
            my $e = '';
            while (not /\G \z/oxgc) {
                if    (/\G (\s+|\#.*)                           /oxgc) { $e .= $1; }

#               elsif (/\G (\() ((?:\\\)|\\\\|$q_paren)*?) (\)) /oxgc) { return $e . e_q($ope,$1,$3,$2); } # q ( )
                elsif (/\G (\() /oxgc) {                                                                   # q ( )
                    my $q_string = '';
                    local $nest = 1;
                    while (not /\G \z/oxgc) {
                        if    (/\G (\\\\)    /oxgc) { $q_string .= $1;                         }
                        elsif (/\G (\\\))    /oxgc) { $q_string .= $1;                         }
                        elsif (/\G (\\\()    /oxgc) { $q_string .= $1;                         }
                        elsif (/\G (\()      /oxgc) { $q_string .= $1; $nest++;                }
                        elsif (/\G (\))      /oxgc) {
                            if (--$nest == 0)       { return $e . e_q($ope,'(',')',$q_string); }
                            else                    { $q_string .= $1;                         }
                        }
                        elsif (/\G ($q_char) /oxgc) { $q_string .= $1;                         }
                    }
                    die __FILE__, ": Can't find string terminator anywhere before EOF";
                }

#               elsif (/\G (\{) ((?:\\\}|\\\\|$q_brace)*?) (\}) /oxgc) { return $e . e_q($ope,$1,$3,$2); } # q { }
                elsif (/\G (\{) /oxgc) {                                                                   # q { }
                    my $q_string = '';
                    local $nest = 1;
                    while (not /\G \z/oxgc) {
                        if    (/\G (\\\\)    /oxgc) { $q_string .= $1;                         }
                        elsif (/\G (\\\})    /oxgc) { $q_string .= $1;                         }
                        elsif (/\G (\\\{)    /oxgc) { $q_string .= $1;                         }
                        elsif (/\G (\{)      /oxgc) { $q_string .= $1; $nest++;                }
                        elsif (/\G (\})      /oxgc) {
                            if (--$nest == 0)       { return $e . e_q($ope,'{','}',$q_string); }
                            else                    { $q_string .= $1;                         }
                        }
                        elsif (/\G ($q_char) /oxgc) { $q_string .= $1;                         }
                    }
                    die __FILE__, ": Can't find string terminator anywhere before EOF";
                }

#               elsif (/\G (\[) ((?:\\\]|\\\\|$q_bracket)*?) (\]) /oxgc) { return $e . e_q($ope,$1,$3,$2); } # q [ ]
                elsif (/\G (\[) /oxgc) {                                                                     # q [ ]
                    my $q_string = '';
                    local $nest = 1;
                    while (not /\G \z/oxgc) {
                        if    (/\G (\\\\)    /oxgc) { $q_string .= $1;                         }
                        elsif (/\G (\\\])    /oxgc) { $q_string .= $1;                         }
                        elsif (/\G (\\\[)    /oxgc) { $q_string .= $1;                         }
                        elsif (/\G (\[)      /oxgc) { $q_string .= $1; $nest++;                }
                        elsif (/\G (\])      /oxgc) {
                            if (--$nest == 0)       { return $e . e_q($ope,'[',']',$q_string); }
                            else                    { $q_string .= $1;                         }
                        }
                        elsif (/\G ($q_char) /oxgc) { $q_string .= $1;                         }
                    }
                    die __FILE__, ": Can't find string terminator anywhere before EOF";
                }

#               elsif (/\G (\<) ((?:\\\>|\\\\|$q_angle)*?) (\>) /oxgc) { return $e . e_q($ope,$1,$3,$2); } # q < >
                elsif (/\G (\<) /oxgc) {                                                                   # q < >
                    my $q_string = '';
                    local $nest = 1;
                    while (not /\G \z/oxgc) {
                        if    (/\G (\\\\)    /oxgc) { $q_string .= $1;                         }
                        elsif (/\G (\\\>)    /oxgc) { $q_string .= $1;                         }
                        elsif (/\G (\\\<)    /oxgc) { $q_string .= $1;                         }
                        elsif (/\G (\<)      /oxgc) { $q_string .= $1; $nest++;                }
                        elsif (/\G (\>)      /oxgc) {
                            if (--$nest == 0)       { return $e . e_q($ope,'<','>',$q_string); }
                            else                    { $q_string .= $1;                         }
                        }
                        elsif (/\G ($q_char) /oxgc) { $q_string .= $1;                         }
                    }
                    die __FILE__, ": Can't find string terminator anywhere before EOF";
                }

#               elsif (/\G (\S) ((?:\\\1|\\\\|$q_char)*?) (\1) /oxgc) { return $e . e_q($ope,$1,$3,$2); } # q * *
                elsif (/\G (\S) /oxgc) {                                                                  # q * *
                    my $delimiter = $1;
                    my $q_string = '';
                    while (not /\G \z/oxgc) {
                        if    (/\G (\\\\)             /oxgc) { $q_string .= $1;                                       }
                        elsif (/\G (\\\Q$delimiter\E) /oxgc) { $q_string .= $1;                                       }
                        elsif (/\G (\Q$delimiter\E)   /oxgc) { return $e . e_q($ope,$delimiter,$delimiter,$q_string); }
                        elsif (/\G ($q_char)          /oxgc) { $q_string .= $1;                                       }
                    }
                    die __FILE__, ": Can't find string terminator anywhere before EOF";
                }
            }
            die __FILE__, ": Can't find string terminator anywhere before EOF";
        }
    }

# m//
    elsif (/\G \b (m) \b /oxgc) {
        my $ope = $1;
        if (/\G (\#) ((?:$qq_char)*?) (\#) ([cgimosxpadlubB]*) /oxgc) { # m# #
            return e_qr($ope,$1,$3,$2,$4);
        }
        else {
            my $e = '';
            while (not /\G \z/oxgc) {
                if    (/\G (\s+|\#.*)                                                /oxgc) { $e .= $1; }
                elsif (/\G (\()         ((?:$qq_paren)*?)   (\)) ([cgimosxpadlubB]*) /oxgc) { return $e . e_qr  ($ope,$1, $3, $2,$4); } # m ( )
                elsif (/\G (\{)         ((?:$qq_brace)*?)   (\}) ([cgimosxpadlubB]*) /oxgc) { return $e . e_qr  ($ope,$1, $3, $2,$4); } # m { }
                elsif (/\G (\[)         ((?:$qq_bracket)*?) (\]) ([cgimosxpadlubB]*) /oxgc) { return $e . e_qr  ($ope,$1, $3, $2,$4); } # m [ ]
                elsif (/\G (\<)         ((?:$qq_angle)*?)   (\>) ([cgimosxpadlubB]*) /oxgc) { return $e . e_qr  ($ope,$1, $3, $2,$4); } # m < >
                elsif (/\G (\?)         ((?:$qq_char)*?)    (\?) ([cgimosxpadlubB]*) /oxgc) { return $e . e_qr  ($ope,$1, $3, $2,$4); } # m ? ?
                elsif (/\G (\')         ((?:$qq_char)*?)    (\') ([cgimosxpadlubB]*) /oxgc) { return $e . e_qr_q($ope,$1, $3, $2,$4); } # m ' '
                elsif (/\G ([*\-:\\^|]) ((?:$qq_char)*?)    (\1) ([cgimosxpadlubB]*) /oxgc) { return $e . e_qr  ($ope,'{','}',$2,$4); } # m | | --> m { }
                elsif (/\G (\S)         ((?:$qq_char)*?)    (\1) ([cgimosxpadlubB]*) /oxgc) { return $e . e_qr  ($ope,$1, $3, $2,$4); } # m * *
            }
            die __FILE__, ": Search pattern not terminated";
        }
    }

# s///

    # about [cegimosxpradlubB]* (/cg modifier)
    #
    # P.67 Pattern-Matching Operators
    # of ISBN 0-596-00241-6 Perl in a Nutshell, Second Edition.

    elsif (/\G \b (s) \b /oxgc) {
        my $ope = $1;

        #        $1   $2               $3   $4               $5   $6
        if (/\G (\#) ((?:$qq_char)*?) (\#) ((?:$qq_char)*?) (\#) ([cegimosxpradlubB]*) /oxgc) { # s# # #
            return e_sub($sub_variable,$1,$2,$3,$3,$4,$5,$6);
        }
        else {
            my $e = '';
            while (not /\G \z/oxgc) {
                if (/\G (\s+|\#.*) /oxgc) { $e .= $1; }
                elsif (/\G (\() ((?:$qq_paren)*?) (\)) /oxgc) {
                    my @s = ($1,$2,$3);
                    while (not /\G \z/oxgc) {
                        if    (/\G (\s+|\#.*)                                          /oxgc) { $e .= $1; }
                        #           $1   $2                  $3   $4
                        elsif (/\G (\() ((?:$qq_paren)*?)   (\)) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\{) ((?:$qq_brace)*?)   (\}) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\[) ((?:$qq_bracket)*?) (\]) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\<) ((?:$qq_angle)*?)   (\>) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\') ((?:$qq_char)*?)    (\') ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\$) ((?:$qq_char)*?)    (\$) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\:) ((?:$qq_char)*?)    (\:) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\@) ((?:$qq_char)*?)    (\@) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\S) ((?:$qq_char)*?)    (\1) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                    }
                    die __FILE__, ": Substitution replacement not terminated";
                }
                elsif (/\G (\{) ((?:$qq_brace)*?) (\}) /oxgc) {
                    my @s = ($1,$2,$3);
                    while (not /\G \z/oxgc) {
                        if    (/\G (\s+|\#.*)                                          /oxgc) { $e .= $1; }
                        #           $1   $2                  $3   $4
                        elsif (/\G (\() ((?:$qq_paren)*?)   (\)) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\{) ((?:$qq_brace)*?)   (\}) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\[) ((?:$qq_bracket)*?) (\]) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\<) ((?:$qq_angle)*?)   (\>) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\') ((?:$qq_char)*?)    (\') ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\$) ((?:$qq_char)*?)    (\$) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\:) ((?:$qq_char)*?)    (\:) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\@) ((?:$qq_char)*?)    (\@) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\S) ((?:$qq_char)*?)    (\1) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                    }
                    die __FILE__, ": Substitution replacement not terminated";
                }
                elsif (/\G (\[) ((?:$qq_bracket)*?) (\]) /oxgc) {
                    my @s = ($1,$2,$3);
                    while (not /\G \z/oxgc) {
                        if    (/\G (\s+|\#.*)                                          /oxgc) { $e .= $1; }
                        #           $1   $2                  $3   $4
                        elsif (/\G (\() ((?:$qq_paren)*?)   (\)) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\{) ((?:$qq_brace)*?)   (\}) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\[) ((?:$qq_bracket)*?) (\]) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\<) ((?:$qq_angle)*?)   (\>) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\') ((?:$qq_char)*?)    (\') ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\$) ((?:$qq_char)*?)    (\$) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\S) ((?:$qq_char)*?)    (\1) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                    }
                    die __FILE__, ": Substitution replacement not terminated";
                }
                elsif (/\G (\<) ((?:$qq_angle)*?) (\>) /oxgc) {
                    my @s = ($1,$2,$3);
                    while (not /\G \z/oxgc) {
                        if    (/\G (\s+|\#.*)                                          /oxgc) { $e .= $1; }
                        #           $1   $2                  $3   $4
                        elsif (/\G (\() ((?:$qq_paren)*?)   (\)) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\{) ((?:$qq_brace)*?)   (\}) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\[) ((?:$qq_bracket)*?) (\]) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\<) ((?:$qq_angle)*?)   (\>) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\') ((?:$qq_char)*?)    (\') ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\$) ((?:$qq_char)*?)    (\$) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\:) ((?:$qq_char)*?)    (\:) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\@) ((?:$qq_char)*?)    (\@) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                        elsif (/\G (\S) ((?:$qq_char)*?)    (\1) ([cegimosxpradlubB]*) /oxgc) { return e_sub($sub_variable,@s,$1,$2,$3,$4); }
                    }
                    die __FILE__, ": Substitution replacement not terminated";
                }
                #           $1   $2               $3   $4               $5   $6
                elsif (/\G (\') ((?:$qq_char)*?) (\') ((?:$qq_char)*?) (\') ([cegimosxpradlubB]*) /oxgc) {
                    return e_sub($sub_variable,$1,$2,$3,$3,$4,$5,$6);
                }
                #           $1            $2               $3   $4               $5   $6
                elsif (/\G ([*\-:?\\^|]) ((?:$qq_char)*?) (\1) ((?:$qq_char)*?) (\1) ([cegimosxpradlubB]*) /oxgc) {
                    return e_sub($sub_variable,'{',$2,'}','{',$4,'}',$6); # s | | | --> s { } { }
                }
                #           $1   $2               $3   $4               $5   $6
                elsif (/\G (\$) ((?:$qq_char)*?) (\1) ((?:$qq_char)*?) (\1) ([cegimosxpradlubB]*) /oxgc) {
                    return e_sub($sub_variable,$1,$2,$3,$3,$4,$5,$6);
                }
                #           $1   $2               $3   $4               $5   $6
                elsif (/\G (\S) ((?:$qq_char)*?) (\1) ((?:$qq_char)*?) (\1) ([cegimosxpradlubB]*) /oxgc) {
                    return e_sub($sub_variable,$1,$2,$3,$3,$4,$5,$6);
                }
            }
            die __FILE__, ": Substitution pattern not terminated";
        }
    }

# require ignore module
    elsif (/\G \b require (\s+ (?:$ignore_modules) .*? ;) ([ \t]* [#\n])                  /oxmsgc) { return "# require$1$2";   }
    elsif (/\G \b require (\s+ (?:$ignore_modules) .*? ;) ([ \t]* [^#]) /oxmsgc) { return "# require$1\n$2"; }
    elsif (/\G \b require (\s+ (?:$ignore_modules)) \b                                    /oxmsgc) { return "# require$1";     }

# use strict; --> use strict; no strict qw(refs);
    elsif (/\G \b use (\s+ strict .*? ;) ([ \t]* [#\n])                               /oxmsgc) { return "use$1 no strict qw(refs);$2";   }
    elsif (/\G \b use (\s+ strict .*? ;) ([ \t]* [^#])              /oxmsgc) { return "use$1 no strict qw(refs);\n$2"; }
    elsif (/\G \b use (\s+ strict) \b                                                 /oxmsgc) { return "use$1; no strict qw(refs)";     }

# use 5.12.0; --> use 5.12.0; no strict qw(refs);
    elsif (/\G \b use \s+ (([1-9][0-9_]*)(?:\.([0-9_]+))*)  \s* ;                     /oxmsgc) {
        if (($2 >= 6) or (($2 == 5) and ($3 ge '012'))) {
            return "use $1; no strict qw(refs);";
        }
        else {
            return "use $1;";
        }
    }
    elsif (/\G \b use \s+ (v([0-9][0-9_]*)(?:\.([0-9_]+))*) \s* ;                    /oxmsgc)  {
        if (($2 >= 6) or (($2 == 5) and ($3 >= 12))) {
            return "use $1; no strict qw(refs);";
        }
        else {
            return "use $1;";
        }
    }

# ignore use module
    elsif (/\G \b use (\s+ (?:$ignore_modules) .*? ;) ([ \t]* [#\n])                  /oxmsgc) { return "# use$1$2";         }
    elsif (/\G \b use (\s+ (?:$ignore_modules) .*? ;) ([ \t]* [^#]) /oxmsgc) { return "# use$1\n$2";       }
    elsif (/\G \b use (\s+ (?:$ignore_modules)) \b                                    /oxmsgc) { return "# use$1";           }

# ignore no module
    elsif (/\G \b no  (\s+ (?:$ignore_modules) .*? ;) ([ \t]* [#\n])                  /oxmsgc) { return "# no$1$2";          }
    elsif (/\G \b no  (\s+ (?:$ignore_modules) .*? ;) ([ \t]* [^#]) /oxmsgc) { return "# no$1\n$2";        }
    elsif (/\G \b no  (\s+ (?:$ignore_modules)) \b                                    /oxmsgc) { return "# no$1";            }

# use else
    elsif (/\G \b use \b                                                              /oxmsgc) { return "use";               }

# use else
    elsif (/\G \b no  \b                                                              /oxmsgc) { return "no";                }

# ''
    elsif (/\G (?<![\w\$\@\%\&\*]) (\') /oxgc) {
        my $q_string = '';
        while (not /\G \z/oxgc) {
            if    (/\G (\\\\)                 /oxgc) { $q_string .= $1;                   }
            elsif (/\G (\\\')                 /oxgc) { $q_string .= $1;                   }
            elsif (/\G \'                     /oxgc) { return e_q('', "'","'",$q_string); }
            elsif (/\G ($q_char)              /oxgc) { $q_string .= $1;                   }
        }
        die __FILE__, ": Can't find string terminator anywhere before EOF";
    }

# ""
    elsif (/\G (\") /oxgc) {
        my $qq_string = '';
        while (not /\G \z/oxgc) {
            if    (/\G (\\\\)                 /oxgc) { $qq_string .= $1;                    }
            elsif (/\G (\\\")                 /oxgc) { $qq_string .= $1;                    }
            elsif (/\G \"                     /oxgc) { return e_qq('', '"','"',$qq_string); }
            elsif (/\G ($q_char)              /oxgc) { $qq_string .= $1;                    }
        }
        die __FILE__, ": Can't find string terminator anywhere before EOF";
    }

# ``
    elsif (/\G (\`) /oxgc) {
        my $qx_string = '';
        while (not /\G \z/oxgc) {
            if    (/\G (\\\\)                 /oxgc) { $qx_string .= $1;                    }
            elsif (/\G (\\\`)                 /oxgc) { $qx_string .= $1;                    }
            elsif (/\G \`                     /oxgc) { return e_qq('', '`','`',$qx_string); }
            elsif (/\G ($q_char)              /oxgc) { $qx_string .= $1;                    }
        }
        die __FILE__, ": Can't find string terminator anywhere before EOF";
    }

# //   --- not divide operator (num / num), not defined-or
    elsif (($slash eq 'm//') and /\G (\/) /oxgc) {
        my $regexp = '';
        while (not /\G \z/oxgc) {
            if    (/\G (\\\\)                 /oxgc) { $regexp .= $1;                       }
            elsif (/\G (\\\/)                 /oxgc) { $regexp .= $1;                       }
            elsif (/\G \/ ([cgimosxpadlubB]*) /oxgc) { return e_qr('', '/','/',$regexp,$1); }
            elsif (/\G ($q_char)              /oxgc) { $regexp .= $1;                       }
        }
        die __FILE__, ": Search pattern not terminated";
    }

# ??   --- not conditional operator (condition ? then : else)
    elsif (($slash eq 'm//') and /\G (\?) /oxgc) {
        my $regexp = '';
        while (not /\G \z/oxgc) {
            if    (/\G (\\\\)                 /oxgc) { $regexp .= $1;                       }
            elsif (/\G (\\\?)                 /oxgc) { $regexp .= $1;                       }
            elsif (/\G \? ([cgimosxpadlubB]*) /oxgc) { return e_qr('m','?','?',$regexp,$1); }
            elsif (/\G ($q_char)              /oxgc) { $regexp .= $1;                       }
        }
        die __FILE__, ": Search pattern not terminated";
    }

# << (bit shift)   --- not here document
    elsif (/\G ( << \s* ) (?= [0-9\$\@\&] ) /oxgc)   { $slash = 'm//'; return $1;           }

# <<'HEREDOC'
    elsif (/\G ( << '([a-zA-Z_0-9]*)' ) /oxgc) {
        $slash = 'm//';
        my $here_quote = $1;
        my $delimiter  = $2;

        # get here document
        if ($here_script eq '') {
            $here_script = CORE::substr $_, pos $_;
            $here_script =~ s/.*?\n//oxm;
        }
        if ($here_script =~ s/\A (.*?) \n $delimiter \n //xms) {
            push @heredoc, $1 . qq{\n$delimiter\n};
            push @heredoc_delimiter, $delimiter;
        }
        else {
            die __FILE__, ": Can't find string terminator $delimiter anywhere before EOF";
        }
        return $here_quote;
    }

# <<\HEREDOC

    # P.66 2.6.6. "Here" Documents
    # in Chapter 2: Bits and Pieces
    # of ISBN 0-596-00027-8 Programming Perl Third Edition.

    # P.73 "Here" Documents
    # in Chapter 2: Bits and Pieces
    # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

    elsif (/\G ( << \\([a-zA-Z_0-9]+) ) /oxgc) {
        $slash = 'm//';
        my $here_quote = $1;
        my $delimiter  = $2;

        # get here document
        if ($here_script eq '') {
            $here_script = CORE::substr $_, pos $_;
            $here_script =~ s/.*?\n//oxm;
        }
        if ($here_script =~ s/\A (.*?) \n $delimiter \n //xms) {
            push @heredoc, $1 . qq{\n$delimiter\n};
            push @heredoc_delimiter, $delimiter;
        }
        else {
            die __FILE__, ": Can't find string terminator $delimiter anywhere before EOF";
        }
        return $here_quote;
    }

# <<"HEREDOC"
    elsif (/\G ( << "([a-zA-Z_0-9]*)" ) /oxgc) {
        $slash = 'm//';
        my $here_quote = $1;
        my $delimiter  = $2;

        # get here document
        if ($here_script eq '') {
            $here_script = CORE::substr $_, pos $_;
            $here_script =~ s/.*?\n//oxm;
        }
        if ($here_script =~ s/\A (.*?) \n $delimiter \n //xms) {
            push @heredoc, e_heredoc($1) . qq{\n$delimiter\n};
            push @heredoc_delimiter, $delimiter;
        }
        else {
            die __FILE__, ": Can't find string terminator $delimiter anywhere before EOF";
        }
        return $here_quote;
    }

# <<HEREDOC
    elsif (/\G ( << ([a-zA-Z_0-9]+) ) /oxgc) {
        $slash = 'm//';
        my $here_quote = $1;
        my $delimiter  = $2;

        # get here document
        if ($here_script eq '') {
            $here_script = CORE::substr $_, pos $_;
            $here_script =~ s/.*?\n//oxm;
        }
        if ($here_script =~ s/\A (.*?) \n $delimiter \n //xms) {
            push @heredoc, e_heredoc($1) . qq{\n$delimiter\n};
            push @heredoc_delimiter, $delimiter;
        }
        else {
            die __FILE__, ": Can't find string terminator $delimiter anywhere before EOF";
        }
        return $here_quote;
    }

# <<`HEREDOC`
    elsif (/\G ( << `([a-zA-Z_0-9]*)` ) /oxgc) {
        $slash = 'm//';
        my $here_quote = $1;
        my $delimiter  = $2;

        # get here document
        if ($here_script eq '') {
            $here_script = CORE::substr $_, pos $_;
            $here_script =~ s/.*?\n//oxm;
        }
        if ($here_script =~ s/\A (.*?) \n $delimiter \n //xms) {
            push @heredoc, e_heredoc($1) . qq{\n$delimiter\n};
            push @heredoc_delimiter, $delimiter;
        }
        else {
            die __FILE__, ": Can't find string terminator $delimiter anywhere before EOF";
        }
        return $here_quote;
    }

# <<= <=> <= < operator
    elsif (/\G ( <<= | <=> | <= | < ) (?= \s* [A-Za-z_0-9'"`\$\@\&\*\(\+\-] )/oxgc) {
        return $1;
    }

# <FILEHANDLE>
    elsif (/\G (<[\$]?[A-Za-z_][A-Za-z_0-9]*>) /oxgc) {
        return $1;
    }

# <WILDCARD> --- glob

    # avoid "Error: Runtime exception" of perl version 5.005_03

    elsif (/\G < ((?:[^>\0\a\e\f\n\r\t])+?) > /oxgc) {
        return 'Char::Elatin2::glob("' . $1 . '")';
    }

# __DATA__
    elsif (/\G ^ ( __DATA__ \n .*) \z /oxmsgc) { return $1; }

# __END__
    elsif (/\G ^ ( __END__  \n .*) \z /oxmsgc) { return $1; }

# \cD Control-D

    # P.68 2.6.8. Other Literal Tokens
    # in Chapter 2: Bits and Pieces
    # of ISBN 0-596-00027-8 Programming Perl Third Edition.

    # P.76 Other Literal Tokens
    # in Chapter 2: Bits and Pieces
    # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

    elsif (/\G   ( \cD         .*) \z /oxmsgc) { return $1; }

# \cZ Control-Z
    elsif (/\G   ( \cZ         .*) \z /oxmsgc) { return $1; }

    # any operator before div
    elsif (/\G (
            -- | \+\+ |
            [\)\}\]]

            ) /oxgc) { $slash = 'div'; return $1; }

    # yada-yada or triple-dot operator
    elsif (/\G (
            \.\.\.

            ) /oxgc) { $slash = 'm//'; return q{die('Unimplemented')}; }

    # any operator before m//

    # //, //= (defined-or)

    # P.164 Logical Operators
    # in Chapter 10: More Control Structures
    # of ISBN 978-0-596-52010-6 Learning Perl, Fifth Edition

    # P.119 C-Style Logical (Short-Circuit) Operators
    # in Chapter 3: Unary and Binary Operators
    # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

    # (and so on)

    # ~~

    # P.221 The Smart Match Operator
    # in Chapter 15: Smart Matching and given-when
    # of ISBN 978-0-596-52010-6 Learning Perl, Fifth Edition

    # P.112 Smartmatch Operator
    # in Chapter 3: Unary and Binary Operators
    # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

    # (and so on)

    elsif (/\G (

            !~~ | !~ | != | ! |
            %= | % |
            &&= | && | &= | & |
            -= | -> | - |
            :\s*= |
            : |
            <<= | <=> | <= | < |
            == | => | =~ | = |
            >>= | >> | >= | > |
            \*\*= | \*\* | \*= | \* |
            \+= | \+ |
            \.\. | \.= | \. |
            \/\/= | \/\/ |
            \/= | \/ |
            \? |
            \\ |
            \^= | \^ |
            \b x= |
            \|\|= | \|\| | \|= | \| |
            ~~ | ~ |
            \b(?: and | cmp | eq | ge | gt | le | lt | ne | not | or | xor | x )\b |
            \b(?: print )\b |

            [,;\(\{\[]

            ) /oxgc) { $slash = 'm//'; return $1; }

    # other any character
    elsif (/\G ($q_char) /oxgc) { $slash = 'div'; return $1; }

    # system error
    else {
        die __FILE__, ": Oops, this shouldn't happen!";
    }
}

# escape Latin-2 string
sub e_string {
    my($string) = @_;
    my $e_string = '';

    local $slash = 'm//';

    # P.1024 Appendix W.10 Multibyte Processing
    # of ISBN 1-56592-224-7 CJKV Information Processing
    # (and so on)

    my @char = $string =~ / \G (\\?(?:$q_char)) /oxmsg;

    # without { ... }
    if (not (grep(/\A \{ \z/xms, @char) and grep(/\A \} \z/xms, @char))) {
        if ($string !~ /<</oxms) {
            return $string;
        }
    }

E_STRING_LOOP:
    while ($string !~ /\G \z/oxgc) {
        if (0) {
        }

# $`, ${`}, $PREMATCH, ${PREMATCH}, ${^PREMATCH} --> @{[Char::Elatin2::PREMATCH()]}
        elsif ($string =~ /\G ( \$` | \$\{`\} | \$ \s* PREMATCH  \b | \$ \s* \{ \s* PREMATCH  \s* \} | \$ \s* \{\^PREMATCH\}  ) /oxmsgc) {
            $e_string .= q{Char::Elatin2::PREMATCH()};
            $slash = 'div';
        }

# $&, ${&}, $MATCH, ${MATCH}, ${^MATCH} --> @{[Char::Elatin2::MATCH()]}
        elsif ($string =~ /\G ( \$& | \$\{&\} | \$ \s* MATCH     \b | \$ \s* \{ \s* MATCH     \s* \} | \$ \s* \{\^MATCH\}     ) /oxmsgc) {
            $e_string .= q{Char::Elatin2::MATCH()};
            $slash = 'div';
        }

# $', ${'} --> $', ${'}
        elsif ($string =~ /\G ( \$' | \$\{'\}                                                                                 ) /oxmsgc) {
            $e_string .= $1;
            $slash = 'div';
        }

# $POSTMATCH, ${POSTMATCH}, ${^POSTMATCH} --> @{[Char::Elatin2::POSTMATCH()]}
        elsif ($string =~ /\G (                 \$ \s* POSTMATCH \b | \$ \s* \{ \s* POSTMATCH \s* \} | \$ \s* \{\^POSTMATCH\} ) /oxmsgc) {
            $e_string .= q{Char::Elatin2::POSTMATCH()};
            $slash = 'div';
        }

# bareword
        elsif ($string =~ /\G ( \{ \s* (?: tr | index | rindex | reverse ) \s* \} ) /oxmsgc) {
            $e_string .= $1;
            $slash = 'div';
        }

# $0 --> $0
        elsif ($string =~ /\G ( \$ 0 ) /oxmsgc) {
            $e_string .= $1;
            $slash = 'div';
        }
        elsif ($string =~ /\G ( \$ \{ \s* 0 \s* \} ) /oxmsgc) {
            $e_string .= $1;
            $slash = 'div';
        }

# $$ --> $$
        elsif ($string =~ /\G ( \$ \$ ) (?![\w\{]) /oxmsgc) {
            $e_string .= $1;
            $slash = 'div';
        }

# $1, $2, $3 --> $2, $3, $4 after s/// with multibyte anchoring
# $1, $2, $3 --> $1, $2, $3 otherwise
        elsif ($string =~ /\G \$ ([1-9][0-9]*) /oxmsgc) {
            $e_string .= e_capture($1);
            $slash = 'div';
        }
        elsif ($string =~ /\G \$ \{ \s* ([1-9][0-9]*) \s* \} /oxmsgc) {
            $e_string .= e_capture($1);
            $slash = 'div';
        }

# $$foo[ ... ] --> $ $foo->[ ... ]
        elsif ($string =~ /\G \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) ( \[ .+? \] ) /oxmsgc) {
            $e_string .= e_capture($1.'->'.$2);
            $slash = 'div';
        }

# $$foo{ ... } --> $ $foo->{ ... }
        elsif ($string =~ /\G \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) ( \{ .+? \} ) /oxmsgc) {
            $e_string .= e_capture($1.'->'.$2);
            $slash = 'div';
        }

# $$foo
        elsif ($string =~ /\G \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) /oxmsgc) {
            $e_string .= e_capture($1);
            $slash = 'div';
        }

# ${ foo }
        elsif ($string =~ /\G \$ \s* \{ ( \s* [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* \s* ) \} /oxmsgc) {
            $e_string .= '${' . $1 . '}';
            $slash = 'div';
        }

# ${ ... }
        elsif ($string =~ /\G \$ \s* \{ \s* ( $qq_brace ) \s* \} /oxmsgc) {
            $e_string .= e_capture($1);
            $slash = 'div';
        }

# variable or function
        #                             $ @ % & *     $ #
        elsif ($string =~ /\G ( (?: [\$\@\%\&\*] | \$\# | -> | \b sub \b) \s* (?: split | chop | index | rindex | lc | uc | fc | chr | ord | reverse | getc | tr | y | q | qq | qx | qw | m | s | qr | glob | lstat | opendir | stat | unlink | chdir ) ) \b /oxmsgc) {
            $e_string .= $1;
            $slash = 'div';
        }
        #                           $ $ $ $ $ $ $ $ $ $ $ $ $ $
        #                           $ @ # \ ' " / ? ( ) [ ] < >
        elsif ($string =~ /\G ( \$[\$\@\#\\\'\"\/\?\(\)\[\]\<\>] ) /oxmsgc) {
            $e_string .= $1;
            $slash = 'div';
        }

# subroutines of package Char::Elatin2
        elsif ($string =~ /\G \b (CORE:: | ->[ ]* (?: atan2 | [a-z]{2,})) \b  /oxgc) { $e_string .= $1;               $slash = 'm//'; }
        elsif ($string =~ /\G \b bytes::substr \b                             /oxgc) { $e_string .= 'substr';         $slash = 'm//'; }
        elsif ($string =~ /\G \b chop \b                                      /oxgc) { $e_string .= 'Char::Elatin2::chop';    $slash = 'm//'; }
        elsif ($string =~ /\G \b bytes::index \b                              /oxgc) { $e_string .= 'index';          $slash = 'm//'; }
        elsif ($string =~ /\G \b Char::Latin2::index \b                               /oxgc) { $e_string .= 'Char::Latin2::index';    $slash = 'm//'; }
        elsif ($string =~ /\G \b index \b                                     /oxgc) { $e_string .= 'Char::Elatin2::index';   $slash = 'm//'; }
        elsif ($string =~ /\G \b bytes::rindex \b                             /oxgc) { $e_string .= 'rindex';         $slash = 'm//'; }
        elsif ($string =~ /\G \b Char::Latin2::rindex \b                              /oxgc) { $e_string .= 'Char::Latin2::rindex';   $slash = 'm//'; }
        elsif ($string =~ /\G \b rindex \b                                    /oxgc) { $e_string .= 'Char::Elatin2::rindex';  $slash = 'm//'; }
        elsif ($string =~ /\G \b lc      (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $e_string .= 'Char::Elatin2::lc';      $slash = 'm//'; }
        elsif ($string =~ /\G \b lcfirst (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $e_string .= 'Char::Elatin2::lcfirst'; $slash = 'm//'; }
        elsif ($string =~ /\G \b uc      (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $e_string .= 'Char::Elatin2::uc';      $slash = 'm//'; }
        elsif ($string =~ /\G \b ucfirst (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $e_string .= 'Char::Elatin2::ucfirst'; $slash = 'm//'; }
        elsif ($string =~ /\G \b fc      (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $e_string .= 'Char::Elatin2::fc';      $slash = 'm//'; }

        # "-s '' ..." means file test "-s 'filename' ..." (not means "- s/// ...")
        elsif ($string =~ /\G -s                               \s+    \s* (\") ((?:$qq_char)+?)                (\") /oxgc) { $e_string .= '-s ' . e_qq('',  $1,$3,$2); $slash = 'm//'; }
        elsif ($string =~ /\G -s                               \s+ qq \s* (\#) ((?:$qq_char)+?)                (\#) /oxgc) { $e_string .= '-s ' . e_qq('qq',$1,$3,$2); $slash = 'm//'; }
        elsif ($string =~ /\G -s                               \s+ qq \s* (\() ((?:$qq_paren)+?)               (\)) /oxgc) { $e_string .= '-s ' . e_qq('qq',$1,$3,$2); $slash = 'm//'; }
        elsif ($string =~ /\G -s                               \s+ qq \s* (\{) ((?:$qq_brace)+?)               (\}) /oxgc) { $e_string .= '-s ' . e_qq('qq',$1,$3,$2); $slash = 'm//'; }
        elsif ($string =~ /\G -s                               \s+ qq \s* (\[) ((?:$qq_bracket)+?)             (\]) /oxgc) { $e_string .= '-s ' . e_qq('qq',$1,$3,$2); $slash = 'm//'; }
        elsif ($string =~ /\G -s                               \s+ qq \s* (\<) ((?:$qq_angle)+?)               (\>) /oxgc) { $e_string .= '-s ' . e_qq('qq',$1,$3,$2); $slash = 'm//'; }
        elsif ($string =~ /\G -s                               \s+ qq \s* (\S) ((?:$qq_char)+?)                (\1) /oxgc) { $e_string .= '-s ' . e_qq('qq',$1,$3,$2); $slash = 'm//'; }

        elsif ($string =~ /\G -s                               \s+    \s* (\') ((?:\\\'|\\\\|$q_char)+?)       (\') /oxgc) { $e_string .= '-s ' . e_q ('',  $1,$3,$2); $slash = 'm//'; }
        elsif ($string =~ /\G -s                               \s+ q  \s* (\#) ((?:\\\#|\\\\|$q_char)+?)       (\#) /oxgc) { $e_string .= '-s ' . e_q ('q', $1,$3,$2); $slash = 'm//'; }
        elsif ($string =~ /\G -s                               \s+ q  \s* (\() ((?:\\\)|\\\\|$q_paren)+?)      (\)) /oxgc) { $e_string .= '-s ' . e_q ('q', $1,$3,$2); $slash = 'm//'; }
        elsif ($string =~ /\G -s                               \s+ q  \s* (\{) ((?:\\\}|\\\\|$q_brace)+?)      (\}) /oxgc) { $e_string .= '-s ' . e_q ('q', $1,$3,$2); $slash = 'm//'; }
        elsif ($string =~ /\G -s                               \s+ q  \s* (\[) ((?:\\\]|\\\\|$q_bracket)+?)    (\]) /oxgc) { $e_string .= '-s ' . e_q ('q', $1,$3,$2); $slash = 'm//'; }
        elsif ($string =~ /\G -s                               \s+ q  \s* (\<) ((?:\\\>|\\\\|$q_angle)+?)      (\>) /oxgc) { $e_string .= '-s ' . e_q ('q', $1,$3,$2); $slash = 'm//'; }
        elsif ($string =~ /\G -s                               \s+ q  \s* (\S) ((?:\\\1|\\\\|$q_char)+?)       (\1) /oxgc) { $e_string .= '-s ' . e_q ('q', $1,$3,$2); $slash = 'm//'; }

        elsif ($string =~ /\G -s                               \s* (\$ \w+(?: ::\w+)* (?: (?: ->)? (?: [\$\@\%\&\*]\* | \$\#\* | \( (?:$qq_paren)*? \) | [\@\%\*]? \{ (?:$qq_brace)+? \} | [\@\%]? \[ (?:$qq_bracket)+? \] ) )*) /oxgc)
                                                                                                                           { $e_string .= "-s $1";   $slash = 'm//'; }
        elsif ($string =~ /\G -s                               \s* \( ((?:$qq_paren)*?) \)                          /oxgc) { $e_string .= "-s ($1)"; $slash = 'm//'; }
        elsif ($string =~ /\G -s                               (?= \s+ [a-z]+)                                      /oxgc) { $e_string .= '-s';      $slash = 'm//'; }
        elsif ($string =~ /\G -s                               \s+ (\w+)                                            /oxgc) { $e_string .= "-s $1";   $slash = 'm//'; }

        elsif ($string =~ /\G \b bytes::length (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $e_string .= 'length';                   $slash = 'm//'; }
        elsif ($string =~ /\G \b bytes::chr    (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $e_string .= 'chr';                      $slash = 'm//'; }
        elsif ($string =~ /\G \b chr           (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $e_string .= 'Char::Elatin2::chr';               $slash = 'm//'; }
        elsif ($string =~ /\G \b bytes::ord    (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $e_string .= 'ord';                      $slash = 'div'; }
        elsif ($string =~ /\G \b ord           (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $e_string .= $function_ord;              $slash = 'div'; }
        elsif ($string =~ /\G \b glob          (?= \s+[A-Za-z_]|\s*['"`\$\@\&\*\(]) /oxgc) { $e_string .= 'Char::Elatin2::glob';              $slash = 'm//'; }
        elsif ($string =~ /\G \b lc \b                                              /oxgc) { $e_string .= 'Char::Elatin2::lc_';               $slash = 'm//'; }
        elsif ($string =~ /\G \b lcfirst \b                                         /oxgc) { $e_string .= 'Char::Elatin2::lcfirst_';          $slash = 'm//'; }
        elsif ($string =~ /\G \b uc \b                                              /oxgc) { $e_string .= 'Char::Elatin2::uc_';               $slash = 'm//'; }
        elsif ($string =~ /\G \b ucfirst \b                                         /oxgc) { $e_string .= 'Char::Elatin2::ucfirst_';          $slash = 'm//'; }
        elsif ($string =~ /\G \b fc \b                                              /oxgc) { $e_string .= 'Char::Elatin2::fc_';               $slash = 'm//'; }
        elsif ($string =~ /\G    -s                              \b                 /oxgc) { $e_string .= '-s ';                      $slash = 'm//'; }

        elsif ($string =~ /\G \b bytes::length \b                                   /oxgc) { $e_string .= 'length';                   $slash = 'm//'; }
        elsif ($string =~ /\G \b bytes::chr \b                                      /oxgc) { $e_string .= 'chr';                      $slash = 'm//'; }
        elsif ($string =~ /\G \b chr \b                                             /oxgc) { $e_string .= 'Char::Elatin2::chr_';              $slash = 'm//'; }
        elsif ($string =~ /\G \b bytes::ord \b                                      /oxgc) { $e_string .= 'ord';                      $slash = 'div'; }
        elsif ($string =~ /\G \b ord \b                                             /oxgc) { $e_string .= $function_ord_;             $slash = 'div'; }
        elsif ($string =~ /\G \b glob \b                                            /oxgc) { $e_string .= 'Char::Elatin2::glob_';             $slash = 'm//'; }
        elsif ($string =~ /\G \b reverse \b                                         /oxgc) { $e_string .= $function_reverse;          $slash = 'm//'; }
        elsif ($string =~ /\G \b getc \b                                            /oxgc) { $e_string .= $function_getc;             $slash = 'm//'; }

# split
        elsif ($string =~ /\G \b (split) \b (?! \s* => ) /oxgc) {
            $slash = 'm//';

            my $e = '';
            while ($string =~ /\G ( \s+ | \( | \#.* ) /oxgc) {
                $e .= $1;
            }

# end of split
            if    ($string =~ /\G (?= [,;\)\}\]] )          /oxgc) { return 'Char::Elatin2::split' . $e;                                           }

# split scalar value
            elsif ($string =~ /\G ( [\$\@\&\*] $qq_scalar ) /oxgc) { $e_string .= 'Char::Elatin2::split' . $e . e_string($1);  next E_STRING_LOOP; }

# split literal space
            elsif ($string =~ /\G \b qq       (\#) [ ] (\#) /oxgc) { $e_string .= 'Char::Elatin2::split' . $e . qq  {qq$1 $2}; next E_STRING_LOOP; }
            elsif ($string =~ /\G \b qq (\s*) (\() [ ] (\)) /oxgc) { $e_string .= 'Char::Elatin2::split' . $e . qq{$1qq$2 $3}; next E_STRING_LOOP; }
            elsif ($string =~ /\G \b qq (\s*) (\{) [ ] (\}) /oxgc) { $e_string .= 'Char::Elatin2::split' . $e . qq{$1qq$2 $3}; next E_STRING_LOOP; }
            elsif ($string =~ /\G \b qq (\s*) (\[) [ ] (\]) /oxgc) { $e_string .= 'Char::Elatin2::split' . $e . qq{$1qq$2 $3}; next E_STRING_LOOP; }
            elsif ($string =~ /\G \b qq (\s*) (\<) [ ] (\>) /oxgc) { $e_string .= 'Char::Elatin2::split' . $e . qq{$1qq$2 $3}; next E_STRING_LOOP; }
            elsif ($string =~ /\G \b qq (\s*) (\S) [ ] (\2) /oxgc) { $e_string .= 'Char::Elatin2::split' . $e . qq{$1qq$2 $3}; next E_STRING_LOOP; }
            elsif ($string =~ /\G \b q        (\#) [ ] (\#) /oxgc) { $e_string .= 'Char::Elatin2::split' . $e . qq   {q$1 $2}; next E_STRING_LOOP; }
            elsif ($string =~ /\G \b q  (\s*) (\() [ ] (\)) /oxgc) { $e_string .= 'Char::Elatin2::split' . $e . qq {$1q$2 $3}; next E_STRING_LOOP; }
            elsif ($string =~ /\G \b q  (\s*) (\{) [ ] (\}) /oxgc) { $e_string .= 'Char::Elatin2::split' . $e . qq {$1q$2 $3}; next E_STRING_LOOP; }
            elsif ($string =~ /\G \b q  (\s*) (\[) [ ] (\]) /oxgc) { $e_string .= 'Char::Elatin2::split' . $e . qq {$1q$2 $3}; next E_STRING_LOOP; }
            elsif ($string =~ /\G \b q  (\s*) (\<) [ ] (\>) /oxgc) { $e_string .= 'Char::Elatin2::split' . $e . qq {$1q$2 $3}; next E_STRING_LOOP; }
            elsif ($string =~ /\G \b q  (\s*) (\S) [ ] (\2) /oxgc) { $e_string .= 'Char::Elatin2::split' . $e . qq {$1q$2 $3}; next E_STRING_LOOP; }
            elsif ($string =~ /\G                ' [ ] '    /oxgc) { $e_string .= 'Char::Elatin2::split' . $e . qq     {' '};  next E_STRING_LOOP; }
            elsif ($string =~ /\G                " [ ] "    /oxgc) { $e_string .= 'Char::Elatin2::split' . $e . qq     {" "};  next E_STRING_LOOP; }

# split qq//
            elsif ($string =~ /\G \b (qq) \b /oxgc) {
                if ($string =~ /\G (\#) ((?:$qq_char)*?) (\#) /oxgc)                        { $e_string .= e_split($e.'qr',$1,$3,$2,'');   next E_STRING_LOOP; } # qq# #  --> qr # #
                else {
                    while ($string !~ /\G \z/oxgc) {
                        if    ($string =~ /\G (\s+|\#.*)                             /oxgc) { $e_string .= $e . $1; }
                        elsif ($string =~ /\G (\()          ((?:$qq_paren)*?)   (\)) /oxgc) { $e_string .= e_split($e.'qr',$1,$3,$2,'');   next E_STRING_LOOP; } # qq ( ) --> qr ( )
                        elsif ($string =~ /\G (\{)          ((?:$qq_brace)*?)   (\}) /oxgc) { $e_string .= e_split($e.'qr',$1,$3,$2,'');   next E_STRING_LOOP; } # qq { } --> qr { }
                        elsif ($string =~ /\G (\[)          ((?:$qq_bracket)*?) (\]) /oxgc) { $e_string .= e_split($e.'qr',$1,$3,$2,'');   next E_STRING_LOOP; } # qq [ ] --> qr [ ]
                        elsif ($string =~ /\G (\<)          ((?:$qq_angle)*?)   (\>) /oxgc) { $e_string .= e_split($e.'qr',$1,$3,$2,'');   next E_STRING_LOOP; } # qq < > --> qr < >
                        elsif ($string =~ /\G ([*\-:?\\^|]) ((?:$qq_char)*?)    (\1) /oxgc) { $e_string .= e_split($e.'qr','{','}',$2,''); next E_STRING_LOOP; } # qq | | --> qr { }
                        elsif ($string =~ /\G (\S)          ((?:$qq_char)*?)    (\1) /oxgc) { $e_string .= e_split($e.'qr',$1,$3,$2,'');   next E_STRING_LOOP; } # qq * * --> qr * *
                    }
                    die __FILE__, ": Can't find string terminator anywhere before EOF";
                }
            }

# split qr//
            elsif ($string =~ /\G \b (qr) \b /oxgc) {
                if ($string =~ /\G (\#) ((?:$qq_char)*?) (\#) ([imosxpadlubB]*) /oxgc)                        { $e_string .= e_split  ($e.'qr',$1,$3,$2,$4);   next E_STRING_LOOP; } # qr# #
                else {
                    while ($string !~ /\G \z/oxgc) {
                        if    ($string =~ /\G (\s+|\#.*)                                               /oxgc) { $e_string .= $e . $1; }
                        elsif ($string =~ /\G (\()          ((?:$qq_paren)*?)   (\)) ([imosxpadlubB]*) /oxgc) { $e_string .= e_split  ($e.'qr',$1, $3, $2,$4); next E_STRING_LOOP; } # qr ( )
                        elsif ($string =~ /\G (\{)          ((?:$qq_brace)*?)   (\}) ([imosxpadlubB]*) /oxgc) { $e_string .= e_split  ($e.'qr',$1, $3, $2,$4); next E_STRING_LOOP; } # qr { }
                        elsif ($string =~ /\G (\[)          ((?:$qq_bracket)*?) (\]) ([imosxpadlubB]*) /oxgc) { $e_string .= e_split  ($e.'qr',$1, $3, $2,$4); next E_STRING_LOOP; } # qr [ ]
                        elsif ($string =~ /\G (\<)          ((?:$qq_angle)*?)   (\>) ([imosxpadlubB]*) /oxgc) { $e_string .= e_split  ($e.'qr',$1, $3, $2,$4); next E_STRING_LOOP; } # qr < >
                        elsif ($string =~ /\G (\')          ((?:$qq_char)*?)    (\') ([imosxpadlubB]*) /oxgc) { $e_string .= e_split_q($e.'qr',$1, $3, $2,$4); next E_STRING_LOOP; } # qr ' '
                        elsif ($string =~ /\G ([*\-:?\\^|]) ((?:$qq_char)*?)    (\1) ([imosxpadlubB]*) /oxgc) { $e_string .= e_split  ($e.'qr','{','}',$2,$4); next E_STRING_LOOP; } # qr | | --> qr { }
                        elsif ($string =~ /\G (\S)          ((?:$qq_char)*?)    (\1) ([imosxpadlubB]*) /oxgc) { $e_string .= e_split  ($e.'qr',$1, $3, $2,$4); next E_STRING_LOOP; } # qr * *
                    }
                    die __FILE__, ": Can't find string terminator anywhere before EOF";
                }
            }

# split q//
            elsif ($string =~ /\G \b (q) \b /oxgc) {
                if ($string =~ /\G (\#) ((?:\\\#|\\\\|$q_char)*?) (\#) /oxgc)                    { $e_string .= e_split_q($e.'qr',$1,$3,$2,'');   next E_STRING_LOOP; } # q# #  --> qr # #
                else {
                    while ($string !~ /\G \z/oxgc) {
                        if    ($string =~ /\G (\s+|\#.*)                                  /oxgc) { $e_string .= $e . $1; }
                        elsif ($string =~ /\G (\() ((?:\\\\|\\\)|\\\(|$q_paren)*?)   (\)) /oxgc) { $e_string .= e_split_q($e.'qr',$1,$3,$2,'');   next E_STRING_LOOP; } # q ( ) --> qr ( )
                        elsif ($string =~ /\G (\{) ((?:\\\\|\\\}|\\\{|$q_brace)*?)   (\}) /oxgc) { $e_string .= e_split_q($e.'qr',$1,$3,$2,'');   next E_STRING_LOOP; } # q { } --> qr { }
                        elsif ($string =~ /\G (\[) ((?:\\\\|\\\]|\\\[|$q_bracket)*?) (\]) /oxgc) { $e_string .= e_split_q($e.'qr',$1,$3,$2,'');   next E_STRING_LOOP; } # q [ ] --> qr [ ]
                        elsif ($string =~ /\G (\<) ((?:\\\\|\\\>|\\\<|$q_angle)*?)   (\>) /oxgc) { $e_string .= e_split_q($e.'qr',$1,$3,$2,'');   next E_STRING_LOOP; } # q < > --> qr < >
                        elsif ($string =~ /\G ([*\-:?\\^|])       ((?:$q_char)*?)    (\1) /oxgc) { $e_string .= e_split_q($e.'qr','{','}',$2,''); next E_STRING_LOOP; } # q | | --> qr { }
                        elsif ($string =~ /\G (\S) ((?:\\\\|\\\1|     $q_char)*?)    (\1) /oxgc) { $e_string .= e_split_q($e.'qr',$1,$3,$2,'');   next E_STRING_LOOP; } # q * * --> qr * *
                    }
                    die __FILE__, ": Can't find string terminator anywhere before EOF";
                }
            }

# split m//
            elsif ($string =~ /\G \b (m) \b /oxgc) {
                if ($string =~ /\G (\#) ((?:$qq_char)*?) (\#) ([cgimosxpadlubB]*) /oxgc)                        { $e_string .= e_split  ($e.'qr',$1,$3,$2,$4);   next E_STRING_LOOP; } # m# #  --> qr # #
                else {
                    while ($string !~ /\G \z/oxgc) {
                        if    ($string =~ /\G (\s+|\#.*)                                                 /oxgc) { $e_string .= $e . $1; }
                        elsif ($string =~ /\G (\()          ((?:$qq_paren)*?)   (\)) ([cgimosxpadlubB]*) /oxgc) { $e_string .= e_split  ($e.'qr',$1, $3, $2,$4); next E_STRING_LOOP; } # m ( ) --> qr ( )
                        elsif ($string =~ /\G (\{)          ((?:$qq_brace)*?)   (\}) ([cgimosxpadlubB]*) /oxgc) { $e_string .= e_split  ($e.'qr',$1, $3, $2,$4); next E_STRING_LOOP; } # m { } --> qr { }
                        elsif ($string =~ /\G (\[)          ((?:$qq_bracket)*?) (\]) ([cgimosxpadlubB]*) /oxgc) { $e_string .= e_split  ($e.'qr',$1, $3, $2,$4); next E_STRING_LOOP; } # m [ ] --> qr [ ]
                        elsif ($string =~ /\G (\<)          ((?:$qq_angle)*?)   (\>) ([cgimosxpadlubB]*) /oxgc) { $e_string .= e_split  ($e.'qr',$1, $3, $2,$4); next E_STRING_LOOP; } # m < > --> qr < >
                        elsif ($string =~ /\G (\')          ((?:$qq_char)*?)    (\') ([cgimosxpadlubB]*) /oxgc) { $e_string .= e_split_q($e.'qr',$1, $3, $2,$4); next E_STRING_LOOP; } # m ' ' --> qr ' '
                        elsif ($string =~ /\G ([*\-:?\\^|]) ((?:$qq_char)*?)    (\1) ([cgimosxpadlubB]*) /oxgc) { $e_string .= e_split  ($e.'qr','{','}',$2,$4); next E_STRING_LOOP; } # m | | --> qr { }
                        elsif ($string =~ /\G (\S)          ((?:$qq_char)*?)    (\1) ([cgimosxpadlubB]*) /oxgc) { $e_string .= e_split  ($e.'qr',$1, $3, $2,$4); next E_STRING_LOOP; } # m * * --> qr * *
                    }
                    die __FILE__, ": Search pattern not terminated";
                }
            }

# split ''
            elsif ($string =~ /\G (\') /oxgc) {
                my $q_string = '';
                while ($string !~ /\G \z/oxgc) {
                    if    ($string =~ /\G (\\\\)    /oxgc) { $q_string .= $1; }
                    elsif ($string =~ /\G (\\\')    /oxgc) { $q_string .= $1; } # splitqr'' --> split qr''
                    elsif ($string =~ /\G \'        /oxgc)                      { $e_string .= e_split_q($e.q{ qr},"'","'",$q_string,''); next E_STRING_LOOP; } # ' ' --> qr ' '
                    elsif ($string =~ /\G ($q_char) /oxgc) { $q_string .= $1; }
                }
                die __FILE__, ": Can't find string terminator anywhere before EOF";
            }

# split ""
            elsif ($string =~ /\G (\") /oxgc) {
                my $qq_string = '';
                while ($string !~ /\G \z/oxgc) {
                    if    ($string =~ /\G (\\\\)    /oxgc) { $qq_string .= $1; }
                    elsif ($string =~ /\G (\\\")    /oxgc) { $qq_string .= $1; } # splitqr"" --> split qr""
                    elsif ($string =~ /\G \"        /oxgc)                       { $e_string .= e_split($e.q{ qr},'"','"',$qq_string,''); next E_STRING_LOOP; } # " " --> qr " "
                    elsif ($string =~ /\G ($q_char) /oxgc) { $qq_string .= $1; }
                }
                die __FILE__, ": Can't find string terminator anywhere before EOF";
            }

# split //
            elsif ($string =~ /\G (\/) /oxgc) {
                my $regexp = '';
                while ($string !~ /\G \z/oxgc) {
                    if    ($string =~ /\G (\\\\)                 /oxgc) { $regexp .= $1; }
                    elsif ($string =~ /\G (\\\/)                 /oxgc) { $regexp .= $1; } # splitqr// --> split qr//
                    elsif ($string =~ /\G \/ ([cgimosxpadlubB]*) /oxgc)                    { $e_string .= e_split($e.q{ qr}, '/','/',$regexp,$1); next E_STRING_LOOP; } # / / --> qr / /
                    elsif ($string =~ /\G ($q_char)              /oxgc) { $regexp .= $1; }
                }
                die __FILE__, ": Search pattern not terminated";
            }
        }

# qq//
        elsif ($string =~ /\G \b (qq) \b /oxgc) {
            my $ope = $1;
            if ($string =~ /\G (\#) ((?:$qq_char)*?) (\#) /oxgc) { # qq# #
                $e_string .= e_qq($ope,$1,$3,$2);
            }
            else {
                my $e = '';
                while ($string !~ /\G \z/oxgc) {
                    if    ($string =~ /\G (\s+|\#.*)                    /oxgc) { $e .= $1; }
                    elsif ($string =~ /\G (\() ((?:$qq_paren)*?)   (\)) /oxgc) { $e_string .= $e . e_qq($ope,$1,$3,$2); next E_STRING_LOOP; } # qq ( )
                    elsif ($string =~ /\G (\{) ((?:$qq_brace)*?)   (\}) /oxgc) { $e_string .= $e . e_qq($ope,$1,$3,$2); next E_STRING_LOOP; } # qq { }
                    elsif ($string =~ /\G (\[) ((?:$qq_bracket)*?) (\]) /oxgc) { $e_string .= $e . e_qq($ope,$1,$3,$2); next E_STRING_LOOP; } # qq [ ]
                    elsif ($string =~ /\G (\<) ((?:$qq_angle)*?)   (\>) /oxgc) { $e_string .= $e . e_qq($ope,$1,$3,$2); next E_STRING_LOOP; } # qq < >
                    elsif ($string =~ /\G (\S) ((?:$qq_char)*?)    (\1) /oxgc) { $e_string .= $e . e_qq($ope,$1,$3,$2); next E_STRING_LOOP; } # qq * *
                }
                die __FILE__, ": Can't find string terminator anywhere before EOF";
            }
        }

# qx//
        elsif ($string =~ /\G \b (qx) \b /oxgc) {
            my $ope = $1;
            if ($string =~ /\G (\#) ((?:$qq_char)*?) (\#) /oxgc) { # qx# #
                $e_string .= e_qq($ope,$1,$3,$2);
            }
            else {
                my $e = '';
                while ($string !~ /\G \z/oxgc) {
                    if    ($string =~ /\G (\s+|\#.*)                    /oxgc) { $e .= $1; }
                    elsif ($string =~ /\G (\() ((?:$qq_paren)*?)   (\)) /oxgc) { $e_string .= $e . e_qq($ope,$1,$3,$2); next E_STRING_LOOP; } # qx ( )
                    elsif ($string =~ /\G (\{) ((?:$qq_brace)*?)   (\}) /oxgc) { $e_string .= $e . e_qq($ope,$1,$3,$2); next E_STRING_LOOP; } # qx { }
                    elsif ($string =~ /\G (\[) ((?:$qq_bracket)*?) (\]) /oxgc) { $e_string .= $e . e_qq($ope,$1,$3,$2); next E_STRING_LOOP; } # qx [ ]
                    elsif ($string =~ /\G (\<) ((?:$qq_angle)*?)   (\>) /oxgc) { $e_string .= $e . e_qq($ope,$1,$3,$2); next E_STRING_LOOP; } # qx < >
                    elsif ($string =~ /\G (\') ((?:$qq_char)*?)    (\') /oxgc) { $e_string .= $e . e_q ($ope,$1,$3,$2); next E_STRING_LOOP; } # qx ' '
                    elsif ($string =~ /\G (\S) ((?:$qq_char)*?)    (\1) /oxgc) { $e_string .= $e . e_qq($ope,$1,$3,$2); next E_STRING_LOOP; } # qx * *
                }
                die __FILE__, ": Can't find string terminator anywhere before EOF";
            }
        }

# q//
        elsif ($string =~ /\G \b (q) \b /oxgc) {
            my $ope = $1;
            if ($string =~ /\G (\#) ((?:\\\#|\\\\|$q_char)*?) (\#) /oxgc) { # q# #
                $e_string .= e_q($ope,$1,$3,$2);
            }
            else {
                my $e = '';
                while ($string !~ /\G \z/oxgc) {
                    if    ($string =~ /\G (\s+|\#.*)                                  /oxgc) { $e .= $1; }
                    elsif ($string =~ /\G (\() ((?:\\\\|\\\)|\\\(|$q_paren)*?)   (\)) /oxgc) { $e_string .= $e . e_q($ope,$1,$3,$2); next E_STRING_LOOP; } # q ( )
                    elsif ($string =~ /\G (\{) ((?:\\\\|\\\}|\\\{|$q_brace)*?)   (\}) /oxgc) { $e_string .= $e . e_q($ope,$1,$3,$2); next E_STRING_LOOP; } # q { }
                    elsif ($string =~ /\G (\[) ((?:\\\\|\\\]|\\\[|$q_bracket)*?) (\]) /oxgc) { $e_string .= $e . e_q($ope,$1,$3,$2); next E_STRING_LOOP; } # q [ ]
                    elsif ($string =~ /\G (\<) ((?:\\\\|\\\>|\\\<|$q_angle)*?)   (\>) /oxgc) { $e_string .= $e . e_q($ope,$1,$3,$2); next E_STRING_LOOP; } # q < >
                    elsif ($string =~ /\G (\S) ((?:\\\\|\\\1|     $q_char)*?)    (\1) /oxgc) { $e_string .= $e . e_q($ope,$1,$3,$2); next E_STRING_LOOP; } # q * *
                }
                die __FILE__, ": Can't find string terminator anywhere before EOF";
            }
        }

# ''
        elsif ($string =~ /\G (?<![\w\$\@\%\&\*]) (\') ((?:\\\'|\\\\|$q_char)*?) (\') /oxgc) { $e_string .= e_q('',$1,$3,$2);  }

# ""
        elsif ($string =~ /\G (\") ((?:$qq_char)*?) (\")                              /oxgc) { $e_string .= e_qq('',$1,$3,$2); }

# ``
        elsif ($string =~ /\G (\`) ((?:$qq_char)*?) (\`)                              /oxgc) { $e_string .= e_qq('',$1,$3,$2); }

# <<= <=> <= < operator
        elsif ($string =~ /\G ( <<= | <=> | <= | < ) (?= \s* [A-Za-z_0-9'"`\$\@\&\*\(\+\-] )/oxgc)
                                                                                             { $e_string .= $1;                }

# <FILEHANDLE>
        elsif ($string =~ /\G (<[\$]?[A-Za-z_][A-Za-z_0-9]*>)                         /oxgc) { $e_string .= $1;                }

# <WILDCARD>   --- glob
        elsif ($string =~ /\G < ((?:$q_char)+?) > /oxgc) {
            $e_string .= 'Char::Elatin2::glob("' . $1 . '")';
        }

# << (bit shift)   --- not here document
        elsif ($string =~ /\G ( << \s* ) (?= [0-9\$\@\&] ) /oxgc) { $slash = 'm//'; $e_string .= $1; }

# <<'HEREDOC'
        elsif ($string =~ /\G ( << '([a-zA-Z_0-9]*)' ) /oxgc) {
            $slash = 'm//';
            my $here_quote = $1;
            my $delimiter  = $2;

            # get here document
            if ($here_script eq '') {
                $here_script = CORE::substr $_, pos $_;
                $here_script =~ s/.*?\n//oxm;
            }
            if ($here_script =~ s/\A (.*?) \n $delimiter \n //xms) {
                push @heredoc, $1 . qq{\n$delimiter\n};
                push @heredoc_delimiter, $delimiter;
            }
            else {
                die __FILE__, ": Can't find string terminator $delimiter anywhere before EOF";
            }
            $e_string .= $here_quote;
        }

# <<\HEREDOC
        elsif ($string =~ /\G ( << \\([a-zA-Z_0-9]+) ) /oxgc) {
            $slash = 'm//';
            my $here_quote = $1;
            my $delimiter  = $2;

            # get here document
            if ($here_script eq '') {
                $here_script = CORE::substr $_, pos $_;
                $here_script =~ s/.*?\n//oxm;
            }
            if ($here_script =~ s/\A (.*?) \n $delimiter \n //xms) {
                push @heredoc, $1 . qq{\n$delimiter\n};
                push @heredoc_delimiter, $delimiter;
            }
            else {
                die __FILE__, ": Can't find string terminator $delimiter anywhere before EOF";
            }
            $e_string .= $here_quote;
        }

# <<"HEREDOC"
        elsif ($string =~ /\G ( << "([a-zA-Z_0-9]*)" ) /oxgc) {
            $slash = 'm//';
            my $here_quote = $1;
            my $delimiter  = $2;

            # get here document
            if ($here_script eq '') {
                $here_script = CORE::substr $_, pos $_;
                $here_script =~ s/.*?\n//oxm;
            }
            if ($here_script =~ s/\A (.*?) \n $delimiter \n //xms) {
                push @heredoc, e_heredoc($1) . qq{\n$delimiter\n};
                push @heredoc_delimiter, $delimiter;
            }
            else {
                die __FILE__, ": Can't find string terminator $delimiter anywhere before EOF";
            }
            $e_string .= $here_quote;
        }

# <<HEREDOC
        elsif ($string =~ /\G ( << ([a-zA-Z_0-9]+) ) /oxgc) {
            $slash = 'm//';
            my $here_quote = $1;
            my $delimiter  = $2;

            # get here document
            if ($here_script eq '') {
                $here_script = CORE::substr $_, pos $_;
                $here_script =~ s/.*?\n//oxm;
            }
            if ($here_script =~ s/\A (.*?) \n $delimiter \n //xms) {
                push @heredoc, e_heredoc($1) . qq{\n$delimiter\n};
                push @heredoc_delimiter, $delimiter;
            }
            else {
                die __FILE__, ": Can't find string terminator $delimiter anywhere before EOF";
            }
            $e_string .= $here_quote;
        }

# <<`HEREDOC`
        elsif ($string =~ /\G ( << `([a-zA-Z_0-9]*)` ) /oxgc) {
            $slash = 'm//';
            my $here_quote = $1;
            my $delimiter  = $2;

            # get here document
            if ($here_script eq '') {
                $here_script = CORE::substr $_, pos $_;
                $here_script =~ s/.*?\n//oxm;
            }
            if ($here_script =~ s/\A (.*?) \n $delimiter \n //xms) {
                push @heredoc, e_heredoc($1) . qq{\n$delimiter\n};
                push @heredoc_delimiter, $delimiter;
            }
            else {
                die __FILE__, ": Can't find string terminator $delimiter anywhere before EOF";
            }
            $e_string .= $here_quote;
        }

        # any operator before div
        elsif ($string =~ /\G (
            -- | \+\+ |
            [\)\}\]]

            ) /oxgc) { $slash = 'div'; $e_string .= $1; }

        # yada-yada or triple-dot operator
        elsif ($string =~ /\G (
            \.\.\.

            ) /oxgc) { $slash = 'm//'; $e_string .= q{die('Unimplemented')}; }

        # any operator before m//
        elsif ($string =~ /\G (

            !~~ | !~ | != | ! |
            %= | % |
            &&= | && | &= | & |
            -= | -> | - |
            :\s*= |
            : |
            <<= | <=> | <= | < |
            == | => | =~ | = |
            >>= | >> | >= | > |
            \*\*= | \*\* | \*= | \* |
            \+= | \+ |
            \.\. | \.= | \. |
            \/\/= | \/\/ |
            \/= | \/ |
            \? |
            \\ |
            \^= | \^ |
            \b x= |
            \|\|= | \|\| | \|= | \| |
            ~~ | ~ |
            \b(?: and | cmp | eq | ge | gt | le | lt | ne | not | or | xor | x )\b |
            \b(?: print )\b |

            [,;\(\{\[]

            ) /oxgc) { $slash = 'm//'; $e_string .= $1; }

        # other any character
        elsif ($string =~ /\G ($q_char) /oxgc) { $e_string .= $1; }

        # system error
        else {
            die __FILE__, ": Oops, this shouldn't happen!";
        }
    }

    return $e_string;
}

#
# character class
#
sub character_class {
    my($char,$modifier) = @_;

    if ($char eq '.') {
        if ($modifier =~ /s/) {
            return '${Char::Elatin2::dot_s}';
        }
        else {
            return '${Char::Elatin2::dot}';
        }
    }
    else {
        return Char::Elatin2::classic_character_class($char);
    }
}

#
# escape capture ($1, $2, $3, ...)
#
sub e_capture {

    return join '', '${',                $_[0],  '}';
}

#
# escape transliteration (tr/// or y///)
#
sub e_tr {
    my($variable,$charclass,$e,$charclass2,$modifier) = @_;
    my $e_tr = '';
    $modifier ||= '';

    $slash = 'div';

    # quote character class 1
    $charclass  = q_tr($charclass);

    # quote character class 2
    $charclass2 = q_tr($charclass2);

    # /b /B modifier
    if ($modifier =~ tr/bB//d) {
        if ($variable eq '') {
            $e_tr = qq{tr$charclass$e$charclass2$modifier};
        }
        else {
            $e_tr = qq{$variable${bind_operator}tr$charclass$e$charclass2$modifier};
        }
    }
    else {
        if ($variable eq '') {
            $e_tr = qq{Char::Elatin2::tr(\$_,' =~ ',$charclass,$e$charclass2,'$modifier')};
        }
        else {
            $e_tr = qq{Char::Elatin2::tr($variable,'$bind_operator',$charclass,$e$charclass2,'$modifier')};
        }
    }

    # clear tr/// variable
    $tr_variable = '';
    $bind_operator = '';

    return $e_tr;
}

#
# quote for escape transliteration (tr/// or y///)
#
sub q_tr {
    my($charclass) = @_;

    # quote character class
    if ($charclass !~ /'/oxms) {
        return e_q('',  "'", "'", $charclass); # --> q' '
    }
    elsif ($charclass !~ /\//oxms) {
        return e_q('q',  '/', '/', $charclass); # --> q/ /
    }
    elsif ($charclass !~ /\#/oxms) {
        return e_q('q',  '#', '#', $charclass); # --> q# #
    }
    elsif ($charclass !~ /[\<\>]/oxms) {
        return e_q('q', '<', '>', $charclass); # --> q< >
    }
    elsif ($charclass !~ /[\(\)]/oxms) {
        return e_q('q', '(', ')', $charclass); # --> q( )
    }
    elsif ($charclass !~ /[\{\}]/oxms) {
        return e_q('q', '{', '}', $charclass); # --> q{ }
    }
    else {
        for my $char (qw( ! " $ % & * + . : = ? @ ^ ` | ~ ), "\x00".."\x1F", "\x7F", "\xFF") {
            if ($charclass !~ /\Q$char\E/xms) {
                return e_q('q', $char, $char, $charclass);
            }
        }
    }

    return e_q('q', '{', '}', $charclass);
}

#
# escape q string (q//, '')
#
sub e_q {
    my($ope,$delimiter,$end_delimiter,$string) = @_;

    $slash = 'div';

    return join '', $ope, $delimiter, $string, $end_delimiter;
}

#
# escape qq string (qq//, "", qx//, ``)
#
sub e_qq {
    my($ope,$delimiter,$end_delimiter,$string) = @_;

    $slash = 'div';

    my $left_e  = 0;
    my $right_e = 0;
    my @char = $string =~ /\G(
        \\o\{ [0-7]+          \}   |
        \\x\{ [0-9A-Fa-f]+    \}   |
        \\N\{ [^0-9\}][^\}]* \} |
        \$` | \$\{`\} | \$ \s* PREMATCH  | \$ \s* \{ \s* PREMATCH  \s* \} | \$ \s* \{\^PREMATCH\}  |
        \$& | \$\{&\} | \$ \s* MATCH     | \$ \s* \{ \s* MATCH     \s* \} | \$ \s* \{\^MATCH\}     |
                        \$ \s* POSTMATCH | \$ \s* \{ \s* POSTMATCH \s* \} | \$ \s* \{\^POSTMATCH\} |
        \$ \s* \d+                 |
        \$ \s* \{ \s* \d+ \s* \}   |
        \$ \$ (?![\w\{])           |
        \$ \s* \$ \s* $qq_variable |
        \\?(?:$q_char)
    )/oxmsg;

    for (my $i=0; $i <= $#char; $i++) {

        # "\L\u" --> "\u\L"
        if (($char[$i] eq '\L') and ($char[$i+1] eq '\u')) {
            @char[$i,$i+1] = @char[$i+1,$i];
        }

        # "\U\l" --> "\l\U"
        elsif (($char[$i] eq '\U') and ($char[$i+1] eq '\l')) {
            @char[$i,$i+1] = @char[$i+1,$i];
        }

        # octal escape sequence
        elsif ($char[$i] =~ /\A \\o \{ ([0-7]+) \} \z/oxms) {
            $char[$i] = Char::Elatin2::octchr($1);
        }

        # hexadecimal escape sequence
        elsif ($char[$i] =~ /\A \\x \{ ([0-9A-Fa-f]+) \} \z/oxms) {
            $char[$i] = Char::Elatin2::hexchr($1);
        }

        # \N{CHARNAME} --> N{CHARNAME}
        elsif ($char[$i] =~ /\A \\ ( N\{ ([^0-9\}][^\}]*) \} ) \z/oxms) {
            $char[$i] = $1;
        }

        if (0) {
        }

        # \F
        #
        # P.69 Table 2-6. Translation escapes
        # in Chapter 2: Bits and Pieces
        # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.
        # (and so on)

        # \u \l \U \L \F \Q \E
        elsif ($char[$i] =~ /\A ([<>]) \z/oxms) {
            if ($right_e < $left_e) {
                $char[$i] = '\\' . $char[$i];
            }
        }
        elsif ($char[$i] eq '\u') {

            # "STRING @{[ LIST EXPR ]} MORE STRING"

            # P.257 Other Tricks You Can Do with Hard References
            # in Chapter 8: References
            # of ISBN 0-596-00027-8 Programming Perl Third Edition.

            # P.353 Other Tricks You Can Do with Hard References
            # in Chapter 8: References
            # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

            # (and so on)

            $char[$i] = '@{[Char::Elatin2::ucfirst qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\l') {
            $char[$i] = '@{[Char::Elatin2::lcfirst qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\U') {
            $char[$i] = '@{[Char::Elatin2::uc qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\L') {
            $char[$i] = '@{[Char::Elatin2::lc qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\F') {
            $char[$i] = '@{[Char::Elatin2::fc qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\Q') {
            $char[$i] = '@{[CORE::quotemeta qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\E') {
            if ($right_e < $left_e) {
                $char[$i] = '>]}';
                $right_e++;
            }
            else {
                $char[$i] = '';
            }
        }
        elsif ($char[$i] eq '\Q') {
            while (1) {
                if (++$i > $#char) {
                    last;
                }
                if ($char[$i] eq '\E') {
                    last;
                }
            }
        }
        elsif ($char[$i] eq '\E') {
        }

        # $0 --> $0
        elsif ($char[$i] =~ /\A \$ 0 \z/oxms) {
        }
        elsif ($char[$i] =~ /\A \$ \{ \s* 0 \s* \} \z/oxms) {
        }

        # $$ --> $$
        elsif ($char[$i] =~ /\A \$\$ \z/oxms) {
        }

        # $1, $2, $3 --> $2, $3, $4 after s/// with multibyte anchoring
        # $1, $2, $3 --> $1, $2, $3 otherwise
        elsif ($char[$i] =~ /\A \$ ([1-9][0-9]*) \z/oxms) {
            $char[$i] = e_capture($1);
        }
        elsif ($char[$i] =~ /\A \$ \{ \s* ([1-9][0-9]*) \s* \} \z/oxms) {
            $char[$i] = e_capture($1);
        }

        # $$foo[ ... ] --> $ $foo->[ ... ]
        elsif ($char[$i] =~ /\A \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) ( \[ (?:$qq_bracket)*? \] ) \z/oxms) {
            $char[$i] = e_capture($1.'->'.$2);
        }

        # $$foo{ ... } --> $ $foo->{ ... }
        elsif ($char[$i] =~ /\A \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) ( \{ (?:$qq_brace)*? \} ) \z/oxms) {
            $char[$i] = e_capture($1.'->'.$2);
        }

        # $$foo
        elsif ($char[$i] =~ /\A \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) \z/oxms) {
            $char[$i] = e_capture($1);
        }

        # $`, ${`}, $PREMATCH, ${PREMATCH}, ${^PREMATCH} --> Char::Elatin2::PREMATCH()
        elsif ($char[$i] =~ /\A ( \$` | \$\{`\} | \$ \s* PREMATCH  | \$ \s* \{ \s* PREMATCH \s* \}  | \$ \s* \{\^PREMATCH\}  ) \z/oxmsgc) {
            $char[$i] = '@{[Char::Elatin2::PREMATCH()]}';
        }

        # $&, ${&}, $MATCH, ${MATCH}, ${^MATCH} --> Char::Elatin2::MATCH()
        elsif ($char[$i] =~ /\A ( \$& | \$\{&\} | \$ \s* MATCH     | \$ \s* \{ \s* MATCH     \s* \} | \$ \s* \{\^MATCH\}     ) \z/oxmsgc) {
            $char[$i] = '@{[Char::Elatin2::MATCH()]}';
        }

        # $POSTMATCH, ${POSTMATCH}, ${^POSTMATCH} --> Char::Elatin2::POSTMATCH()
        elsif ($char[$i] =~ /\A (                 \$ \s* POSTMATCH | \$ \s* \{ \s* POSTMATCH \s* \} | \$ \s* \{\^POSTMATCH\} ) \z/oxmsgc) {
            $char[$i] = '@{[Char::Elatin2::POSTMATCH()]}';
        }

        # ${ foo } --> ${ foo }
        elsif ($char[$i] =~ /\A \$ \s* \{ \s* [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* \s* \} \z/oxms) {
        }

        # ${ ... }
        elsif ($char[$i] =~ /\A \$ \s* \{ \s* ( .+ ) \s* \} \z/oxms) {
            $char[$i] = e_capture($1);
        }
    }

    # return string
    if ($left_e > $right_e) {
        return join '', $ope, $delimiter, @char, '>]}' x ($left_e - $right_e), $end_delimiter;
    }
    return     join '', $ope, $delimiter, @char,                               $end_delimiter;
}

#
# escape qw string (qw//)
#
sub e_qw {
    my($ope,$delimiter,$end_delimiter,$string) = @_;

    $slash = 'div';

    # choice again delimiter
    my %octet = map {$_ => 1} ($string =~ /\G ([\x00-\xFF]) /oxmsg);
    if (not $octet{$end_delimiter}) {
        return join '', $ope, $delimiter, $string, $end_delimiter;
    }
    elsif (not $octet{')'}) {
        return join '', $ope, '(',        $string, ')';
    }
    elsif (not $octet{'}'}) {
        return join '', $ope, '{',        $string, '}';
    }
    elsif (not $octet{']'}) {
        return join '', $ope, '[',        $string, ']';
    }
    elsif (not $octet{'>'}) {
        return join '', $ope, '<',        $string, '>';
    }
    else {
        for my $char (qw( ! " $ % & * + - . / : = ? @ ^ ` | ~ ), "\x00".."\x1F", "\x7F", "\xFF") {
            if (not $octet{$char}) {
                return join '', $ope,      $char, $string, $char;
            }
        }
    }

    # qw/AAA BBB C'CC/ --> ('AAA', 'BBB', 'C\'CC')
    my @string = CORE::split(/\s+/, $string);
    for my $string (@string) {
        my @octet = $string =~ /\G ([\x00-\xFF]) /oxmsg;
        for my $octet (@octet) {
            if ($octet =~ /\A (['\\]) \z/oxms) {
                $octet = '\\' . $1;
            }
        }
        $string = join '', @octet;
    }
    return join '', '(', (join ', ', map { "'$_'" } @string), ')';
}

#
# escape here document (<<"HEREDOC", <<HEREDOC, <<`HEREDOC`)
#
sub e_heredoc {
    my($string) = @_;

    $slash = 'm//';

    my $metachar = qr/[\@\\|]/oxms; # '|' is for <<`HEREDOC`

    my $left_e  = 0;
    my $right_e = 0;
    my @char = $string =~ /\G(
        \\o\{ [0-7]+          \}   |
        \\x\{ [0-9A-Fa-f]+    \}   |
        \\N\{ [^0-9\}][^\}]* \} |
        \$` | \$\{`\} | \$ \s* PREMATCH  | \$ \s* \{ \s* PREMATCH  \s* \} | \$ \s* \{\^PREMATCH\}  |
        \$& | \$\{&\} | \$ \s* MATCH     | \$ \s* \{ \s* MATCH     \s* \} | \$ \s* \{\^MATCH\}     |
                        \$ \s* POSTMATCH | \$ \s* \{ \s* POSTMATCH \s* \} | \$ \s* \{\^POSTMATCH\} |
        \$ \s* \d+                 |
        \$ \s* \{ \s* \d+ \s* \}   |
        \$ \$ (?![\w\{])           |
        \$ \s* \$ \s* $qq_variable |
        \\?(?:$q_char)
    )/oxmsg;

    for (my $i=0; $i <= $#char; $i++) {

        # "\L\u" --> "\u\L"
        if (($char[$i] eq '\L') and ($char[$i+1] eq '\u')) {
            @char[$i,$i+1] = @char[$i+1,$i];
        }

        # "\U\l" --> "\l\U"
        elsif (($char[$i] eq '\U') and ($char[$i+1] eq '\l')) {
            @char[$i,$i+1] = @char[$i+1,$i];
        }

        # octal escape sequence
        elsif ($char[$i] =~ /\A \\o \{ ([0-7]+) \} \z/oxms) {
            $char[$i] = Char::Elatin2::octchr($1);
        }

        # hexadecimal escape sequence
        elsif ($char[$i] =~ /\A \\x \{ ([0-9A-Fa-f]+) \} \z/oxms) {
            $char[$i] = Char::Elatin2::hexchr($1);
        }

        # \N{CHARNAME} --> N{CHARNAME}
        elsif ($char[$i] =~ /\A \\ ( N\{ ([^0-9\}][^\}]*) \} ) \z/oxms) {
            $char[$i] = $1;
        }

        if (0) {
        }

        # \u \l \U \L \F \Q \E
        elsif ($char[$i] =~ /\A ([<>]) \z/oxms) {
            if ($right_e < $left_e) {
                $char[$i] = '\\' . $char[$i];
            }
        }
        elsif ($char[$i] eq '\u') {
            $char[$i] = '@{[Char::Elatin2::ucfirst qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\l') {
            $char[$i] = '@{[Char::Elatin2::lcfirst qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\U') {
            $char[$i] = '@{[Char::Elatin2::uc qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\L') {
            $char[$i] = '@{[Char::Elatin2::lc qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\F') {
            $char[$i] = '@{[Char::Elatin2::fc qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\Q') {
            $char[$i] = '@{[CORE::quotemeta qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\E') {
            if ($right_e < $left_e) {
                $char[$i] = '>]}';
                $right_e++;
            }
            else {
                $char[$i] = '';
            }
        }
        elsif ($char[$i] eq '\Q') {
            while (1) {
                if (++$i > $#char) {
                    last;
                }
                if ($char[$i] eq '\E') {
                    last;
                }
            }
        }
        elsif ($char[$i] eq '\E') {
        }

        # $0 --> $0
        elsif ($char[$i] =~ /\A \$ 0 \z/oxms) {
        }
        elsif ($char[$i] =~ /\A \$ \{ \s* 0 \s* \} \z/oxms) {
        }

        # $$ --> $$
        elsif ($char[$i] =~ /\A \$\$ \z/oxms) {
        }

        # $1, $2, $3 --> $2, $3, $4 after s/// with multibyte anchoring
        # $1, $2, $3 --> $1, $2, $3 otherwise
        elsif ($char[$i] =~ /\A \$ ([1-9][0-9]*) \z/oxms) {
            $char[$i] = e_capture($1);
        }
        elsif ($char[$i] =~ /\A \$ \{ \s* ([1-9][0-9]*) \s* \} \z/oxms) {
            $char[$i] = e_capture($1);
        }

        # $$foo[ ... ] --> $ $foo->[ ... ]
        elsif ($char[$i] =~ /\A \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) ( \[ (?:$qq_bracket)*? \] ) \z/oxms) {
            $char[$i] = e_capture($1.'->'.$2);
        }

        # $$foo{ ... } --> $ $foo->{ ... }
        elsif ($char[$i] =~ /\A \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) ( \{ (?:$qq_brace)*? \} ) \z/oxms) {
            $char[$i] = e_capture($1.'->'.$2);
        }

        # $$foo
        elsif ($char[$i] =~ /\A \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) \z/oxms) {
            $char[$i] = e_capture($1);
        }

        # $`, ${`}, $PREMATCH, ${PREMATCH}, ${^PREMATCH} --> Char::Elatin2::PREMATCH()
        elsif ($char[$i] =~ /\A ( \$` | \$\{`\} | \$ \s* PREMATCH  | \$ \s* \{ \s* PREMATCH  \s* \} | \$ \s* \{\^PREMATCH\}  ) \z/oxmsgc) {
            $char[$i] = '@{[Char::Elatin2::PREMATCH()]}';
        }

        # $&, ${&}, $MATCH, ${MATCH}, ${^MATCH} --> Char::Elatin2::MATCH()
        elsif ($char[$i] =~ /\A ( \$& | \$\{&\} | \$ \s* MATCH     | \$ \s* \{ \s* MATCH     \s* \} | \$ \s* \{\^MATCH\}     ) \z/oxmsgc) {
            $char[$i] = '@{[Char::Elatin2::MATCH()]}';
        }

        # $POSTMATCH, ${POSTMATCH}, ${^POSTMATCH} --> Char::Elatin2::POSTMATCH()
        elsif ($char[$i] =~ /\A (                 \$ \s* POSTMATCH | \$ \s* \{ \s* POSTMATCH \s* \} | \$ \s* \{\^POSTMATCH\} ) \z/oxmsgc) {
            $char[$i] = '@{[Char::Elatin2::POSTMATCH()]}';
        }

        # ${ foo } --> ${ foo }
        elsif ($char[$i] =~ /\A \$ \s* \{ \s* [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* \s* \} \z/oxms) {
        }

        # ${ ... }
        elsif ($char[$i] =~ /\A \$ \s* \{ \s* ( .+ ) \s* \} \z/oxms) {
            $char[$i] = e_capture($1);
        }
    }

    # return string
    if ($left_e > $right_e) {
        return join '', @char, '>]}' x ($left_e - $right_e);
    }
    return     join '', @char;
}

#
# escape regexp (m//, qr//)
#
sub e_qr {
    my($ope,$delimiter,$end_delimiter,$string,$modifier) = @_;
    $modifier ||= '';

    $modifier =~ tr/p//d;
    if ($modifier =~ /([adlu])/oxms) {
        my $line = 0;
        for (my $i=0; my($package,$filename,$use_line,$subroutine) = caller($i); $i++) {
            if ($filename ne __FILE__) {
                $line = $use_line + (CORE::substr($_,0,pos($_)) =~ tr/\n//) + 1;
                last;
            }
        }
        die qq{Unsupported modifier "$1" used at line $line.\n};
    }

    $slash = 'div';

    # literal null string pattern
    if ($string eq '') {
        $modifier =~ tr/bB//d;
        $modifier =~ tr/i//d;
        return join '', $ope, $delimiter, $end_delimiter, $modifier;
    }

    # /b /B modifier
    elsif ($modifier =~ tr/bB//d) {

        # choice again delimiter
        if ($delimiter =~ / [\@:] /oxms) {
            my @char = $string =~ /\G([\x00-\xFF])/oxmsg;
            my %octet = map {$_ => 1} @char;
            if (not $octet{')'}) {
                $delimiter     = '(';
                $end_delimiter = ')';
            }
            elsif (not $octet{'}'}) {
                $delimiter     = '{';
                $end_delimiter = '}';
            }
            elsif (not $octet{']'}) {
                $delimiter     = '[';
                $end_delimiter = ']';
            }
            elsif (not $octet{'>'}) {
                $delimiter     = '<';
                $end_delimiter = '>';
            }
            else {
                for my $char (qw( ! " $ % & * + - . / = ? ^ ` | ~ ), "\x00".."\x1F", "\x7F", "\xFF") {
                    if (not $octet{$char}) {
                        $delimiter     = $char;
                        $end_delimiter = $char;
                        last;
                    }
                }
            }
        }

        if (($ope =~ /\A m? \z/oxms) and ($delimiter eq '?')) {
            return join '', $ope, $delimiter,        $string,      $matched, $end_delimiter, $modifier;
        }
        else {
            return join '', $ope, $delimiter, '(?:', $string, ')', $matched, $end_delimiter, $modifier;
        }
    }

    my $ignorecase = ($modifier =~ /i/oxms) ? 1 : 0;
    my $metachar = qr/[\@\\|[\]{^]/oxms;

    # split regexp
    my @char = $string =~ /\G(
        \\o\{ [0-7]+           \}  |
        \\    [0-7]{2,3}           |
        \\x\{ [0-9A-Fa-f]+     \}  |
        \\x   [0-9A-Fa-f]{1,2}     |
        \\c   [\x40-\x5F]          |
        \\N\{ [^0-9\}][^\}]* \} |
        \\p\{ [^0-9\}][^\}]* \} |
        \\P\{ [^0-9\}][^\}]* \} |
        \\  (?:$q_char)            |
        \$` | \$\{`\} | \$ \s* PREMATCH  | \$ \s* \{ \s* PREMATCH  \s* \} | \$ \s* \{\^PREMATCH\}  |
        \$& | \$\{&\} | \$ \s* MATCH     | \$ \s* \{ \s* MATCH     \s* \} | \$ \s* \{\^MATCH\}     |
                        \$ \s* POSTMATCH | \$ \s* \{ \s* POSTMATCH \s* \} | \$ \s* \{\^POSTMATCH\} |
        [\$\@] $qq_variable        |
        \$ \s* \d+                 |
        \$ \s* \{ \s* \d+ \s* \}   |
        \$ \$ (?![\w\{])           |
        \$ \s* \$ \s* $qq_variable |
        \[\:\^ (?:alnum|alpha|ascii|blank|cntrl|digit|graph|lower|print|punct|space|upper|word|xdigit) :\] |
        \[\:   (?:alnum|alpha|ascii|blank|cntrl|digit|graph|lower|print|punct|space|upper|word|xdigit) :\] |
        \[\^                       |
        \(\?                       |
            (?:$q_char)
    )/oxmsg;

    # choice again delimiter
    if ($delimiter =~ / [\@:] /oxms) {
        my %octet = map {$_ => 1} @char;
        if (not $octet{')'}) {
            $delimiter     = '(';
            $end_delimiter = ')';
        }
        elsif (not $octet{'}'}) {
            $delimiter     = '{';
            $end_delimiter = '}';
        }
        elsif (not $octet{']'}) {
            $delimiter     = '[';
            $end_delimiter = ']';
        }
        elsif (not $octet{'>'}) {
            $delimiter     = '<';
            $end_delimiter = '>';
        }
        else {
            for my $char (qw( ! " $ % & * + - . / = ? ^ ` | ~ ), "\x00".."\x1F", "\x7F", "\xFF") {
                if (not $octet{$char}) {
                    $delimiter     = $char;
                    $end_delimiter = $char;
                    last;
                }
            }
        }
    }

    my $left_e  = 0;
    my $right_e = 0;
    for (my $i=0; $i <= $#char; $i++) {

        # "\L\u" --> "\u\L"
        if (($char[$i] eq '\L') and ($char[$i+1] eq '\u')) {
            @char[$i,$i+1] = @char[$i+1,$i];
        }

        # "\U\l" --> "\l\U"
        elsif (($char[$i] eq '\U') and ($char[$i+1] eq '\l')) {
            @char[$i,$i+1] = @char[$i+1,$i];
        }

        # octal escape sequence
        elsif ($char[$i] =~ /\A \\o \{ ([0-7]+) \} \z/oxms) {
            $char[$i] = Char::Elatin2::octchr($1);
        }

        # hexadecimal escape sequence
        elsif ($char[$i] =~ /\A \\x \{ ([0-9A-Fa-f]+) \} \z/oxms) {
            $char[$i] = Char::Elatin2::hexchr($1);
        }

        # \N{CHARNAME} --> N\{CHARNAME}
        elsif ($char[$i] =~ /\A \\ (N) ( \{ ([^0-9\}][^\}]*) \} ) \z/oxms) {
            $char[$i] = $1 . '\\' . $2;
        }

        # \p{PROPERTY} --> p\{PROPERTY}
        elsif ($char[$i] =~ /\A \\ (p) ( \{ ([^0-9\}][^\}]*) \} ) \z/oxms) {
            $char[$i] = $1 . '\\' . $2;
        }

        # \P{PROPERTY} --> P\{PROPERTY}
        elsif ($char[$i] =~ /\A \\ (P) ( \{ ([^0-9\}][^\}]*) \} ) \z/oxms) {
            $char[$i] = $1 . '\\' . $2;
        }

        # \p, \P, \X --> p, P, X
        elsif ($char[$i] =~ /\A \\ ( [pPX] ) \z/oxms) {
            $char[$i] = $1;
        }

        if (0) {
        }

        # join separated multiple-octet
        elsif ($char[$i] =~ /\A (?: \\ [0-7]{2,3} | \\x [0-9A-Fa-f]{1,2}) \z/oxms) {
            if (   ($i+3 <= $#char) and (grep(/\A (?: \\ [0-7]{2,3} | \\x [0-9A-Fa-f]{1,2}) \z/oxms, @char[$i+1..$i+3]) == 3) and (eval(sprintf '"%s%s%s%s"', @char[$i..$i+3]) =~ /\A $q_char \z/oxms)) {
                $char[$i] .= join '', splice @char, $i+1, 3;
            }
            elsif (($i+2 <= $#char) and (grep(/\A (?: \\ [0-7]{2,3} | \\x [0-9A-Fa-f]{1,2}) \z/oxms, @char[$i+1..$i+2]) == 2) and (eval(sprintf '"%s%s%s"',   @char[$i..$i+2]) =~ /\A $q_char \z/oxms)) {
                $char[$i] .= join '', splice @char, $i+1, 2;
            }
            elsif (($i+1 <= $#char) and (grep(/\A (?: \\ [0-7]{2,3} | \\x [0-9A-Fa-f]{1,2}) \z/oxms, $char[$i+1      ]) == 1) and (eval(sprintf '"%s%s"',     @char[$i..$i+1]) =~ /\A $q_char \z/oxms)) {
                $char[$i] .= join '', splice @char, $i+1, 1;
            }
        }

        # open character class [...]
        elsif ($char[$i] eq '[') {
            my $left = $i;

            # [] make die "Unmatched [] in regexp ..."
            # (and so on)

            if ($char[$i+1] eq ']') {
                $i++;
            }

            while (1) {
                if (++$i > $#char) {
                    die __FILE__, ": Unmatched [] in regexp";
                }
                if ($char[$i] eq ']') {
                    my $right = $i;

                    # [...]
                    if (grep(/\A [\$\@]/oxms,@char[$left+1..$right-1]) >= 1) {
                        splice @char, $left, $right-$left+1, sprintf(q{@{[Char::Elatin2::charlist_qr(%s,'%s')]}}, join(',', map {qq_stuff($delimiter,$end_delimiter,$_)} @char[$left+1..$right-1]), $modifier);
                    }
                    else {
                        splice @char, $left, $right-$left+1, Char::Elatin2::charlist_qr(@char[$left+1..$right-1], $modifier);
                    }

                    $i = $left;
                    last;
                }
            }
        }

        # open character class [^...]
        elsif ($char[$i] eq '[^') {
            my $left = $i;

            # [^] make die "Unmatched [] in regexp ..."
            # (and so on)

            if ($char[$i+1] eq ']') {
                $i++;
            }

            while (1) {
                if (++$i > $#char) {
                    die __FILE__, ": Unmatched [] in regexp";
                }
                if ($char[$i] eq ']') {
                    my $right = $i;

                    # [^...]
                    if (grep(/\A [\$\@]/oxms,@char[$left+1..$right-1]) >= 1) {
                        splice @char, $left, $right-$left+1, sprintf(q{@{[Char::Elatin2::charlist_not_qr(%s,'%s')]}}, join(',', map {qq_stuff($delimiter,$end_delimiter,$_)} @char[$left+1..$right-1]), $modifier);
                    }
                    else {
                        splice @char, $left, $right-$left+1, Char::Elatin2::charlist_not_qr(@char[$left+1..$right-1], $modifier);
                    }

                    $i = $left;
                    last;
                }
            }
        }

        # rewrite character class or escape character
        elsif (my $char = character_class($char[$i],$modifier)) {
            $char[$i] = $char;
        }

        # /i modifier
        elsif ($ignorecase and ($char[$i] =~ /\A [\x00-\xFF] \z/oxms) and (Char::Elatin2::uc($char[$i]) ne Char::Elatin2::fc($char[$i]))) {
            if (CORE::length(Char::Elatin2::fc($char[$i])) == 1) {
                $char[$i] = '['   . Char::Elatin2::uc($char[$i])       . Char::Elatin2::fc($char[$i]) . ']';
            }
            else {
                $char[$i] = '(?:' . Char::Elatin2::uc($char[$i]) . '|' . Char::Elatin2::fc($char[$i]) . ')';
            }
        }

        # \u \l \U \L \F \Q \E
        elsif ($char[$i] =~ /\A [<>] \z/oxms) {
            if ($right_e < $left_e) {
                $char[$i] = '\\' . $char[$i];
            }
        }
        elsif ($char[$i] eq '\u') {
            $char[$i] = '@{[Char::Elatin2::ucfirst qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\l') {
            $char[$i] = '@{[Char::Elatin2::lcfirst qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\U') {
            $char[$i] = '@{[Char::Elatin2::uc qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\L') {
            $char[$i] = '@{[Char::Elatin2::lc qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\F') {
            $char[$i] = '@{[Char::Elatin2::fc qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\Q') {
            $char[$i] = '@{[CORE::quotemeta qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\E') {
            if ($right_e < $left_e) {
                $char[$i] = '>]}';
                $right_e++;
            }
            else {
                $char[$i] = '';
            }
        }
        elsif ($char[$i] eq '\Q') {
            while (1) {
                if (++$i > $#char) {
                    last;
                }
                if ($char[$i] eq '\E') {
                    last;
                }
            }
        }
        elsif ($char[$i] eq '\E') {
        }

        # $0 --> $0
        elsif ($char[$i] =~ /\A \$ 0 \z/oxms) {
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }
        elsif ($char[$i] =~ /\A \$ \{ \s* 0 \s* \} \z/oxms) {
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # $$ --> $$
        elsif ($char[$i] =~ /\A \$\$ \z/oxms) {
        }

        # $1, $2, $3 --> $2, $3, $4 after s/// with multibyte anchoring
        # $1, $2, $3 --> $1, $2, $3 otherwise
        elsif ($char[$i] =~ /\A \$ ([1-9][0-9]*) \z/oxms) {
            $char[$i] = e_capture($1);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }
        elsif ($char[$i] =~ /\A \$ \{ \s* ([1-9][0-9]*) \s* \} \z/oxms) {
            $char[$i] = e_capture($1);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # $$foo[ ... ] --> $ $foo->[ ... ]
        elsif ($char[$i] =~ /\A \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) ( \[ (?:$qq_bracket)*? \] ) \z/oxms) {
            $char[$i] = e_capture($1.'->'.$2);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # $$foo{ ... } --> $ $foo->{ ... }
        elsif ($char[$i] =~ /\A \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) ( \{ (?:$qq_brace)*? \} ) \z/oxms) {
            $char[$i] = e_capture($1.'->'.$2);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # $$foo
        elsif ($char[$i] =~ /\A \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) \z/oxms) {
            $char[$i] = e_capture($1);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # $`, ${`}, $PREMATCH, ${PREMATCH}, ${^PREMATCH} --> Char::Elatin2::PREMATCH()
        elsif ($char[$i] =~ /\A ( \$` | \$\{`\} | \$ \s* PREMATCH  | \$ \s* \{ \s* PREMATCH  \s* \} | \$ \s* \{\^PREMATCH\}  ) \z/oxmsgc) {
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(Char::Elatin2::PREMATCH())]}';
            }
            else {
                $char[$i] = '@{[Char::Elatin2::PREMATCH()]}';
            }
        }

        # $&, ${&}, $MATCH, ${MATCH}, ${^MATCH} --> Char::Elatin2::MATCH()
        elsif ($char[$i] =~ /\A ( \$& | \$\{&\} | \$ \s* MATCH     | \$ \s* \{ \s* MATCH     \s* \} | \$ \s* \{\^MATCH\}     ) \z/oxmsgc) {
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(Char::Elatin2::MATCH())]}';
            }
            else {
                $char[$i] = '@{[Char::Elatin2::MATCH()]}';
            }
        }

        # $POSTMATCH, ${POSTMATCH}, ${^POSTMATCH} --> Char::Elatin2::POSTMATCH()
        elsif ($char[$i] =~ /\A (                 \$ \s* POSTMATCH | \$ \s* \{ \s* POSTMATCH \s* \} | \$ \s* \{\^POSTMATCH\} ) \z/oxmsgc) {
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(Char::Elatin2::POSTMATCH())]}';
            }
            else {
                $char[$i] = '@{[Char::Elatin2::POSTMATCH()]}';
            }
        }

        # ${ foo }
        elsif ($char[$i] =~ /\A \$ \s* \{ ( \s* [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* \s* ) \} \z/oxms) {
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # ${ ... }
        elsif ($char[$i] =~ /\A \$ \s* \{ \s* ( .+ ) \s* \} \z/oxms) {
            $char[$i] = e_capture($1);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # $scalar or @array
        elsif ($char[$i] =~ /\A [\$\@].+ /oxms) {
            $char[$i] = e_string($char[$i]);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # quote character before ? + * {
        elsif (($i >= 1) and ($char[$i] =~ /\A [\?\+\*\{] \z/oxms)) {
            if ($char[$i-1] =~ /\A (?:\\[0-7]{2,3}|\\x[0-9-A-Fa-f]{1,2}) \z/oxms) {
            }
            elsif (($ope =~ /\A m? \z/oxms) and ($delimiter eq '?')) {
                my $char = $char[$i-1];
                if ($char[$i] eq '{') {
                    die __FILE__, qq{: "MULTIBYTE{n}" should be "(MULTIBYTE){n}" in m?? (and shift \$1,\$2,\$3,...) ($char){n}};
                }
                else {
                    die __FILE__, qq{: "MULTIBYTE$char[$i]" should be "(MULTIBYTE)$char[$i]" in m?? (and shift \$1,\$2,\$3,...) ($char)$char[$i]};
                }
            }
            else {
                $char[$i-1] = '(?:' . $char[$i-1] . ')';
            }
        }
    }

    # make regexp string
    $modifier =~ tr/i//d;
    if ($left_e > $right_e) {
        if (($ope =~ /\A m? \z/oxms) and ($delimiter eq '?')) {
            return join '', $ope, $delimiter, $anchor,        @char, '>]}' x ($left_e - $right_e),      $matched, $end_delimiter, $modifier;
        }
        else {
            return join '', $ope, $delimiter, $anchor, '(?:', @char, '>]}' x ($left_e - $right_e), ')', $matched, $end_delimiter, $modifier;
        }
    }
    if (($ope =~ /\A m? \z/oxms) and ($delimiter eq '?')) {
        return     join '', $ope, $delimiter, $anchor,        @char,                                    $matched, $end_delimiter, $modifier;
    }
    else {
        return     join '', $ope, $delimiter, $anchor, '(?:', @char,                               ')', $matched, $end_delimiter, $modifier;
    }
}

#
# double quote stuff
#
sub qq_stuff {
    my($delimiter,$end_delimiter,$stuff) = @_;

    # scalar variable or array variable
    if ($stuff =~ /\A [\$\@] /oxms) {
        return $stuff;
    }

    # quote by delimiter
    my %octet = map {$_ => 1} ($stuff =~ /\G ([\x00-\xFF]) /oxmsg);
    for my $char (qw( ! " $ % & * + - . / : = ? @ ^ ` | ~ ), "\x00".."\x1F", "\x7F", "\xFF") {
        next if $char eq $delimiter;
        next if $char eq $end_delimiter;
        if (not $octet{$char}) {
            return join '', 'qq', $char, $stuff, $char;
        }
    }
    return join '', 'qq', '<', $stuff, '>';
}

#
# escape regexp (m'', qr'', and m''b, qr''b)
#
sub e_qr_q {
    my($ope,$delimiter,$end_delimiter,$string,$modifier) = @_;
    $modifier ||= '';

    $modifier =~ tr/p//d;
    if ($modifier =~ /([adlu])/oxms) {
        my $line = 0;
        for (my $i=0; my($package,$filename,$use_line,$subroutine) = caller($i); $i++) {
            if ($filename ne __FILE__) {
                $line = $use_line + (CORE::substr($_,0,pos($_)) =~ tr/\n//) + 1;
                last;
            }
        }
        die qq{Unsupported modifier "$1" used at line $line.\n};
    }

    $slash = 'div';

    # literal null string pattern
    if ($string eq '') {
        $modifier =~ tr/bB//d;
        $modifier =~ tr/i//d;
        return join '', $ope, $delimiter, $end_delimiter, $modifier;
    }

    # with /b /B modifier
    elsif ($modifier =~ tr/bB//d) {
        return e_qr_qb($ope,$delimiter,$end_delimiter,$string,$modifier);
    }

    # without /b /B modifier
    else {
        return e_qr_qt($ope,$delimiter,$end_delimiter,$string,$modifier);
    }
}

#
# escape regexp (m'', qr'')
#
sub e_qr_qt {
    my($ope,$delimiter,$end_delimiter,$string,$modifier) = @_;

    my $ignorecase = ($modifier =~ /i/oxms) ? 1 : 0;

    # split regexp
    my @char = $string =~ /\G(
        \[\:\^ [a-z]+ \:\] |
        \[\:   [a-z]+ \:\] |
        \[\^               |
        [\$\@\/\\]         |
        \\?    (?:$q_char)
    )/oxmsg;

    # unescape character
    for (my $i=0; $i <= $#char; $i++) {
        if (0) {
        }

        # open character class [...]
        elsif ($char[$i] eq '[') {
            my $left = $i;
            if ($char[$i+1] eq ']') {
                $i++;
            }
            while (1) {
                if (++$i > $#char) {
                    die __FILE__, ": Unmatched [] in regexp";
                }
                if ($char[$i] eq ']') {
                    my $right = $i;

                    # [...]
                    splice @char, $left, $right-$left+1, Char::Elatin2::charlist_qr(@char[$left+1..$right-1], $modifier);

                    $i = $left;
                    last;
                }
            }
        }

        # open character class [^...]
        elsif ($char[$i] eq '[^') {
            my $left = $i;
            if ($char[$i+1] eq ']') {
                $i++;
            }
            while (1) {
                if (++$i > $#char) {
                    die __FILE__, ": Unmatched [] in regexp";
                }
                if ($char[$i] eq ']') {
                    my $right = $i;

                    # [^...]
                    splice @char, $left, $right-$left+1, Char::Elatin2::charlist_not_qr(@char[$left+1..$right-1], $modifier);

                    $i = $left;
                    last;
                }
            }
        }

        # escape $ @ / and \
        elsif ($char[$i] =~ /\A [\$\@\/\\] \z/oxms) {
            $char[$i] = '\\' . $char[$i];
        }

        # rewrite character class or escape character
        elsif (my $char = character_class($char[$i],$modifier)) {
            $char[$i] = $char;
        }

        # /i modifier
        elsif ($ignorecase and ($char[$i] =~ /\A [\x00-\xFF] \z/oxms) and (Char::Elatin2::uc($char[$i]) ne Char::Elatin2::fc($char[$i]))) {
            if (CORE::length(Char::Elatin2::fc($char[$i])) == 1) {
                $char[$i] = '['   . Char::Elatin2::uc($char[$i])       . Char::Elatin2::fc($char[$i]) . ']';
            }
            else {
                $char[$i] = '(?:' . Char::Elatin2::uc($char[$i]) . '|' . Char::Elatin2::fc($char[$i]) . ')';
            }
        }

        # quote character before ? + * {
        elsif (($i >= 1) and ($char[$i] =~ /\A [\?\+\*\{] \z/oxms)) {
            if ($char[$i-1] =~ /\A [\x00-\xFF] \z/oxms) {
            }
            else {
                $char[$i-1] = '(?:' . $char[$i-1] . ')';
            }
        }
    }

    $delimiter     = '/';
    $end_delimiter = '/';

    $modifier =~ tr/i//d;
    return join '', $ope, $delimiter, $anchor, '(?:', @char, ')', $matched, $end_delimiter, $modifier;
}

#
# escape regexp (m''b, qr''b)
#
sub e_qr_qb {
    my($ope,$delimiter,$end_delimiter,$string,$modifier) = @_;

    # split regexp
    my @char = $string =~ /\G(
        \\\\        |
        [\$\@\/\\]  |
        [\x00-\xFF]
    )/oxmsg;

    # unescape character
    for (my $i=0; $i <= $#char; $i++) {
        if (0) {
        }

        # remain \\
        elsif ($char[$i] eq '\\\\') {
        }

        # escape $ @ / and \
        elsif ($char[$i] =~ /\A [\$\@\/\\] \z/oxms) {
            $char[$i] = '\\' . $char[$i];
        }
    }

    $delimiter     = '/';
    $end_delimiter = '/';
    return join '', $ope, $delimiter, '(?:', @char, ')', $matched, $end_delimiter, $modifier;
}

#
# escape regexp (s/here//)
#
sub e_s1 {
    my($ope,$delimiter,$end_delimiter,$string,$modifier) = @_;
    $modifier ||= '';

    $modifier =~ tr/p//d;
    if ($modifier =~ /([adlu])/oxms) {
        my $line = 0;
        for (my $i=0; my($package,$filename,$use_line,$subroutine) = caller($i); $i++) {
            if ($filename ne __FILE__) {
                $line = $use_line + (CORE::substr($_,0,pos($_)) =~ tr/\n//) + 1;
                last;
            }
        }
        die qq{Unsupported modifier "$1" used at line $line.\n};
    }

    $slash = 'div';

    # literal null string pattern
    if ($string eq '') {
        $modifier =~ tr/bB//d;
        $modifier =~ tr/i//d;
        return join '', $ope, $delimiter, $end_delimiter, $modifier;
    }

    # /b /B modifier
    elsif ($modifier =~ tr/bB//d) {

        # choice again delimiter
        if ($delimiter =~ / [\@:] /oxms) {
            my @char = $string =~ /\G([\x00-\xFF])/oxmsg;
            my %octet = map {$_ => 1} @char;
            if (not $octet{')'}) {
                $delimiter     = '(';
                $end_delimiter = ')';
            }
            elsif (not $octet{'}'}) {
                $delimiter     = '{';
                $end_delimiter = '}';
            }
            elsif (not $octet{']'}) {
                $delimiter     = '[';
                $end_delimiter = ']';
            }
            elsif (not $octet{'>'}) {
                $delimiter     = '<';
                $end_delimiter = '>';
            }
            else {
                for my $char (qw( ! " $ % & * + - . / = ? ^ ` | ~ ), "\x00".."\x1F", "\x7F", "\xFF") {
                    if (not $octet{$char}) {
                        $delimiter     = $char;
                        $end_delimiter = $char;
                        last;
                    }
                }
            }
        }

        my $prematch = '';
        return join '', $ope, $delimiter, $prematch, '(?:', $string, ')', $matched, $end_delimiter, $modifier;
    }

    my $ignorecase = ($modifier =~ /i/oxms) ? 1 : 0;
    my $metachar = qr/[\@\\|[\]{^]/oxms;

    # split regexp
    my @char = $string =~ /\G(
        \\g \s* \{ \s* - \s* [1-9][0-9]* \s* \} |
        \\g \s* \{ \s*       [1-9][0-9]* \s* \} |
        \\g \s*              [1-9][0-9]*        |
        \\o\{                [0-7]+          \} |
        \\                   [1-9][0-9]*        |
        \\                   [0-7]{2,3}         |
        \\x\{                [0-9A-Fa-f]+    \} |
        \\x                  [0-9A-Fa-f]{1,2}   |
        \\c                  [\x40-\x5F]        |
        \\N\{                [^0-9\}][^\}]* \} |
        \\p\{                [^0-9\}][^\}]* \} |
        \\P\{                [^0-9\}][^\}]* \} |
        \\  (?:$q_char)                         |
        \$` | \$\{`\} | \$ \s* PREMATCH  | \$ \s* \{ \s* PREMATCH  \s* \} | \$ \s* \{\^PREMATCH\}  |
        \$& | \$\{&\} | \$ \s* MATCH     | \$ \s* \{ \s* MATCH     \s* \} | \$ \s* \{\^MATCH\}     |
                        \$ \s* POSTMATCH | \$ \s* \{ \s* POSTMATCH \s* \} | \$ \s* \{\^POSTMATCH\} |
        [\$\@] $qq_variable                     |
        \$ \s* \d+                              |
        \$ \s* \{ \s* \d+ \s* \}                |
        \$ \$ (?![\w\{])                        |
        \$ \s* \$ \s* $qq_variable              |
        \[\:\^ (?:alnum|alpha|ascii|blank|cntrl|digit|graph|lower|print|punct|space|upper|word|xdigit) :\] |
        \[\:   (?:alnum|alpha|ascii|blank|cntrl|digit|graph|lower|print|punct|space|upper|word|xdigit) :\] |
        \[\^                                    |
        \(\?                                    |
            (?:$q_char)
    )/oxmsg;

    # choice again delimiter
    if ($delimiter =~ / [\@:] /oxms) {
        my %octet = map {$_ => 1} @char;
        if (not $octet{')'}) {
            $delimiter     = '(';
            $end_delimiter = ')';
        }
        elsif (not $octet{'}'}) {
            $delimiter     = '{';
            $end_delimiter = '}';
        }
        elsif (not $octet{']'}) {
            $delimiter     = '[';
            $end_delimiter = ']';
        }
        elsif (not $octet{'>'}) {
            $delimiter     = '<';
            $end_delimiter = '>';
        }
        else {
            for my $char (qw( ! " $ % & * + - . / = ? ^ ` | ~ ), "\x00".."\x1F", "\x7F", "\xFF") {
                if (not $octet{$char}) {
                    $delimiter     = $char;
                    $end_delimiter = $char;
                    last;
                }
            }
        }
    }

    # count '('
    my $parens = grep { $_ eq '(' } @char;

    my $left_e  = 0;
    my $right_e = 0;
    for (my $i=0; $i <= $#char; $i++) {

        # "\L\u" --> "\u\L"
        if (($char[$i] eq '\L') and ($char[$i+1] eq '\u')) {
            @char[$i,$i+1] = @char[$i+1,$i];
        }

        # "\U\l" --> "\l\U"
        elsif (($char[$i] eq '\U') and ($char[$i+1] eq '\l')) {
            @char[$i,$i+1] = @char[$i+1,$i];
        }

        # octal escape sequence
        elsif ($char[$i] =~ /\A \\o \{ ([0-7]+) \} \z/oxms) {
            $char[$i] = Char::Elatin2::octchr($1);
        }

        # hexadecimal escape sequence
        elsif ($char[$i] =~ /\A \\x \{ ([0-9A-Fa-f]+) \} \z/oxms) {
            $char[$i] = Char::Elatin2::hexchr($1);
        }

        # \N{CHARNAME} --> N\{CHARNAME}
        elsif ($char[$i] =~ /\A \\ (N) ( \{ ([^0-9\}][^\}]*) \} ) \z/oxms) {
            $char[$i] = $1 . '\\' . $2;
        }

        # \p{PROPERTY} --> p\{PROPERTY}
        elsif ($char[$i] =~ /\A \\ (p) ( \{ ([^0-9\}][^\}]*) \} ) \z/oxms) {
            $char[$i] = $1 . '\\' . $2;
        }

        # \P{PROPERTY} --> P\{PROPERTY}
        elsif ($char[$i] =~ /\A \\ (P) ( \{ ([^0-9\}][^\}]*) \} ) \z/oxms) {
            $char[$i] = $1 . '\\' . $2;
        }

        # \p, \P, \X --> p, P, X
        elsif ($char[$i] =~ /\A \\ ( [pPX] ) \z/oxms) {
            $char[$i] = $1;
        }

        if (0) {
        }

        # join separated multiple-octet
        elsif ($char[$i] =~ /\A (?: \\ [0-7]{2,3} | \\x [0-9A-Fa-f]{1,2}) \z/oxms) {
            if (   ($i+3 <= $#char) and (grep(/\A (?: \\ [0-7]{2,3} | \\x [0-9A-Fa-f]{1,2}) \z/oxms, @char[$i+1..$i+3]) == 3) and (eval(sprintf '"%s%s%s%s"', @char[$i..$i+3]) =~ /\A $q_char \z/oxms)) {
                $char[$i] .= join '', splice @char, $i+1, 3;
            }
            elsif (($i+2 <= $#char) and (grep(/\A (?: \\ [0-7]{2,3} | \\x [0-9A-Fa-f]{1,2}) \z/oxms, @char[$i+1..$i+2]) == 2) and (eval(sprintf '"%s%s%s"',   @char[$i..$i+2]) =~ /\A $q_char \z/oxms)) {
                $char[$i] .= join '', splice @char, $i+1, 2;
            }
            elsif (($i+1 <= $#char) and (grep(/\A (?: \\ [0-7]{2,3} | \\x [0-9A-Fa-f]{1,2}) \z/oxms, $char[$i+1      ]) == 1) and (eval(sprintf '"%s%s"',     @char[$i..$i+1]) =~ /\A $q_char \z/oxms)) {
                $char[$i] .= join '', splice @char, $i+1, 1;
            }
        }

        # open character class [...]
        elsif ($char[$i] eq '[') {
            my $left = $i;
            if ($char[$i+1] eq ']') {
                $i++;
            }
            while (1) {
                if (++$i > $#char) {
                    die __FILE__, ": Unmatched [] in regexp";
                }
                if ($char[$i] eq ']') {
                    my $right = $i;

                    # [...]
                    if (grep(/\A [\$\@]/oxms,@char[$left+1..$right-1]) >= 1) {
                        splice @char, $left, $right-$left+1, sprintf(q{@{[Char::Elatin2::charlist_qr(%s,'%s')]}}, join(',', map {qq_stuff($delimiter,$end_delimiter,$_)} @char[$left+1..$right-1]), $modifier);
                    }
                    else {
                        splice @char, $left, $right-$left+1, Char::Elatin2::charlist_qr(@char[$left+1..$right-1], $modifier);
                    }

                    $i = $left;
                    last;
                }
            }
        }

        # open character class [^...]
        elsif ($char[$i] eq '[^') {
            my $left = $i;
            if ($char[$i+1] eq ']') {
                $i++;
            }
            while (1) {
                if (++$i > $#char) {
                    die __FILE__, ": Unmatched [] in regexp";
                }
                if ($char[$i] eq ']') {
                    my $right = $i;

                    # [^...]
                    if (grep(/\A [\$\@]/oxms,@char[$left+1..$right-1]) >= 1) {
                        splice @char, $left, $right-$left+1, sprintf(q{@{[Char::Elatin2::charlist_not_qr(%s,'%s')]}}, join(',', map {qq_stuff($delimiter,$end_delimiter,$_)} @char[$left+1..$right-1]), $modifier);
                    }
                    else {
                        splice @char, $left, $right-$left+1, Char::Elatin2::charlist_not_qr(@char[$left+1..$right-1], $modifier);
                    }

                    $i = $left;
                    last;
                }
            }
        }

        # rewrite character class or escape character
        elsif (my $char = character_class($char[$i],$modifier)) {
            $char[$i] = $char;
        }

        # /i modifier
        elsif ($ignorecase and ($char[$i] =~ /\A [\x00-\xFF] \z/oxms) and (Char::Elatin2::uc($char[$i]) ne Char::Elatin2::fc($char[$i]))) {
            if (CORE::length(Char::Elatin2::fc($char[$i])) == 1) {
                $char[$i] = '['   . Char::Elatin2::uc($char[$i])       . Char::Elatin2::fc($char[$i]) . ']';
            }
            else {
                $char[$i] = '(?:' . Char::Elatin2::uc($char[$i]) . '|' . Char::Elatin2::fc($char[$i]) . ')';
            }
        }

        # \u \l \U \L \F \Q \E
        elsif ($char[$i] =~ /\A [<>] \z/oxms) {
            if ($right_e < $left_e) {
                $char[$i] = '\\' . $char[$i];
            }
        }
        elsif ($char[$i] eq '\u') {
            $char[$i] = '@{[Char::Elatin2::ucfirst qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\l') {
            $char[$i] = '@{[Char::Elatin2::lcfirst qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\U') {
            $char[$i] = '@{[Char::Elatin2::uc qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\L') {
            $char[$i] = '@{[Char::Elatin2::lc qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\F') {
            $char[$i] = '@{[Char::Elatin2::fc qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\Q') {
            $char[$i] = '@{[CORE::quotemeta qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\E') {
            if ($right_e < $left_e) {
                $char[$i] = '>]}';
                $right_e++;
            }
            else {
                $char[$i] = '';
            }
        }
        elsif ($char[$i] eq '\Q') {
            while (1) {
                if (++$i > $#char) {
                    last;
                }
                if ($char[$i] eq '\E') {
                    last;
                }
            }
        }
        elsif ($char[$i] eq '\E') {
        }

        # \0 --> \0
        elsif ($char[$i] =~ /\A \\ \s* 0 \z/oxms) {
        }

        # \g{N}, \g{-N}

        # P.108 Using Simple Patterns
        # in Chapter 7: In the World of Regular Expressions
        # of ISBN 978-0-596-52010-6 Learning Perl, Fifth Edition

        # P.221 Capturing
        # in Chapter 5: Pattern Matching
        # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

        # \g{-1}, \g{-2}, \g{-3} --> \g{-1}, \g{-2}, \g{-3}
        elsif ($char[$i] =~ /\A \\g \s* \{ \s* - \s* ([1-9][0-9]*) \s* \} \z/oxms) {
        }

        # \g{1}, \g{2}, \g{3} --> \g{2}, \g{3}, \g{4} (only when multibyte anchoring is enable)
        elsif ($char[$i] =~ /\A \\g \s* \{ \s* ([1-9][0-9]*) \s* \} \z/oxms) {
        }

        # \g1, \g2, \g3 --> \g2, \g3, \g4 (only when multibyte anchoring is enable)
        elsif ($char[$i] =~ /\A \\g \s* ([1-9][0-9]*) \z/oxms) {
        }

        # \1, \2, \3 --> \2, \3, \4 (only when multibyte anchoring is enable)
        elsif ($char[$i] =~ /\A \\ \s* ([1-9][0-9]*) \z/oxms) {
        }

        # $0 --> $0
        elsif ($char[$i] =~ /\A \$ 0 \z/oxms) {
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }
        elsif ($char[$i] =~ /\A \$ \{ \s* 0 \s* \} \z/oxms) {
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # $$ --> $$
        elsif ($char[$i] =~ /\A \$\$ \z/oxms) {
        }

        # $1, $2, $3 --> $2, $3, $4 after s/// with multibyte anchoring
        # $1, $2, $3 --> $1, $2, $3 otherwise
        elsif ($char[$i] =~ /\A \$ ([1-9][0-9]*) \z/oxms) {
            $char[$i] = e_capture($1);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }
        elsif ($char[$i] =~ /\A \$ \{ \s* ([1-9][0-9]*) \s* \} \z/oxms) {
            $char[$i] = e_capture($1);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # $$foo[ ... ] --> $ $foo->[ ... ]
        elsif ($char[$i] =~ /\A \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) ( \[ (?:$qq_bracket)*? \] ) \z/oxms) {
            $char[$i] = e_capture($1.'->'.$2);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # $$foo{ ... } --> $ $foo->{ ... }
        elsif ($char[$i] =~ /\A \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) ( \{ (?:$qq_brace)*? \} ) \z/oxms) {
            $char[$i] = e_capture($1.'->'.$2);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # $$foo
        elsif ($char[$i] =~ /\A \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) \z/oxms) {
            $char[$i] = e_capture($1);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # $`, ${`}, $PREMATCH, ${PREMATCH}, ${^PREMATCH} --> Char::Elatin2::PREMATCH()
        elsif ($char[$i] =~ /\A ( \$` | \$\{`\} | \$ \s* PREMATCH  | \$ \s* \{ \s* PREMATCH  \s* \} | \$ \s* \{\^PREMATCH\}  ) \z/oxmsgc) {
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(Char::Elatin2::PREMATCH())]}';
            }
            else {
                $char[$i] = '@{[Char::Elatin2::PREMATCH()]}';
            }
        }

        # $&, ${&}, $MATCH, ${MATCH}, ${^MATCH} --> Char::Elatin2::MATCH()
        elsif ($char[$i] =~ /\A ( \$& | \$\{&\} | \$ \s* MATCH     | \$ \s* \{ \s* MATCH     \s* \} | \$ \s* \{\^MATCH\}     ) \z/oxmsgc) {
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(Char::Elatin2::MATCH())]}';
            }
            else {
                $char[$i] = '@{[Char::Elatin2::MATCH()]}';
            }
        }

        # $POSTMATCH, ${POSTMATCH}, ${^POSTMATCH} --> Char::Elatin2::POSTMATCH()
        elsif ($char[$i] =~ /\A (                 \$ \s* POSTMATCH | \$ \s* \{ \s* POSTMATCH \s* \} | \$ \s* \{\^POSTMATCH\} ) \z/oxmsgc) {
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(Char::Elatin2::POSTMATCH())]}';
            }
            else {
                $char[$i] = '@{[Char::Elatin2::POSTMATCH()]}';
            }
        }

        # ${ foo }
        elsif ($char[$i] =~ /\A \$ \s* \{ ( \s* [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* \s* ) \} \z/oxms) {
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # ${ ... }
        elsif ($char[$i] =~ /\A \$ \s* \{ \s* ( .+ ) \s* \} \z/oxms) {
            $char[$i] = e_capture($1);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # $scalar or @array
        elsif ($char[$i] =~ /\A [\$\@].+ /oxms) {
            $char[$i] = e_string($char[$i]);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # quote character before ? + * {
        elsif (($i >= 1) and ($char[$i] =~ /\A [\?\+\*\{] \z/oxms)) {
            if ($char[$i-1] =~ /\A (?:\\[0-7]{2,3}|\\x[0-9-A-Fa-f]{1,2}) \z/oxms) {
            }
            else {
                $char[$i-1] = '(?:' . $char[$i-1] . ')';
            }
        }
    }

    # make regexp string
    my $prematch = '';
    $modifier =~ tr/i//d;
    if ($left_e > $right_e) {
        return join '', $ope, $delimiter, $prematch, '(?:', @char, '>]}' x ($left_e - $right_e), ')', $matched, $end_delimiter, $modifier;
    }
    return     join '', $ope, $delimiter, $prematch, '(?:', @char,                               ')', $matched, $end_delimiter, $modifier;
}

#
# escape regexp (s'here'' or s'here''b)
#
sub e_s1_q {
    my($ope,$delimiter,$end_delimiter,$string,$modifier) = @_;
    $modifier ||= '';

    $modifier =~ tr/p//d;
    if ($modifier =~ /([adlu])/oxms) {
        my $line = 0;
        for (my $i=0; my($package,$filename,$use_line,$subroutine) = caller($i); $i++) {
            if ($filename ne __FILE__) {
                $line = $use_line + (CORE::substr($_,0,pos($_)) =~ tr/\n//) + 1;
                last;
            }
        }
        die qq{Unsupported modifier "$1" used at line $line.\n};
    }

    $slash = 'div';

    # literal null string pattern
    if ($string eq '') {
        $modifier =~ tr/bB//d;
        $modifier =~ tr/i//d;
        return join '', $ope, $delimiter, $end_delimiter, $modifier;
    }

    # with /b /B modifier
    elsif ($modifier =~ tr/bB//d) {
        return e_s1_qb($ope,$delimiter,$end_delimiter,$string,$modifier);
    }

    # without /b /B modifier
    else {
        return e_s1_qt($ope,$delimiter,$end_delimiter,$string,$modifier);
    }
}

#
# escape regexp (s'here'')
#
sub e_s1_qt {
    my($ope,$delimiter,$end_delimiter,$string,$modifier) = @_;

    my $ignorecase = ($modifier =~ /i/oxms) ? 1 : 0;

    # split regexp
    my @char = $string =~ /\G(
        \[\:\^ [a-z]+ \:\] |
        \[\:   [a-z]+ \:\] |
        \[\^               |
        [\$\@\/\\]         |
        \\?    (?:$q_char)
    )/oxmsg;

    # unescape character
    for (my $i=0; $i <= $#char; $i++) {
        if (0) {
        }

        # open character class [...]
        elsif ($char[$i] eq '[') {
            my $left = $i;
            if ($char[$i+1] eq ']') {
                $i++;
            }
            while (1) {
                if (++$i > $#char) {
                    die __FILE__, ": Unmatched [] in regexp";
                }
                if ($char[$i] eq ']') {
                    my $right = $i;

                    # [...]
                    splice @char, $left, $right-$left+1, Char::Elatin2::charlist_qr(@char[$left+1..$right-1], $modifier);

                    $i = $left;
                    last;
                }
            }
        }

        # open character class [^...]
        elsif ($char[$i] eq '[^') {
            my $left = $i;
            if ($char[$i+1] eq ']') {
                $i++;
            }
            while (1) {
                if (++$i > $#char) {
                    die __FILE__, ": Unmatched [] in regexp";
                }
                if ($char[$i] eq ']') {
                    my $right = $i;

                    # [^...]
                    splice @char, $left, $right-$left+1, Char::Elatin2::charlist_not_qr(@char[$left+1..$right-1], $modifier);

                    $i = $left;
                    last;
                }
            }
        }

        # escape $ @ / and \
        elsif ($char[$i] =~ /\A [\$\@\/\\] \z/oxms) {
            $char[$i] = '\\' . $char[$i];
        }

        # rewrite character class or escape character
        elsif (my $char = character_class($char[$i],$modifier)) {
            $char[$i] = $char;
        }

        # /i modifier
        elsif ($ignorecase and ($char[$i] =~ /\A [\x00-\xFF] \z/oxms) and (Char::Elatin2::uc($char[$i]) ne Char::Elatin2::fc($char[$i]))) {
            if (CORE::length(Char::Elatin2::fc($char[$i])) == 1) {
                $char[$i] = '['   . Char::Elatin2::uc($char[$i])       . Char::Elatin2::fc($char[$i]) . ']';
            }
            else {
                $char[$i] = '(?:' . Char::Elatin2::uc($char[$i]) . '|' . Char::Elatin2::fc($char[$i]) . ')';
            }
        }

        # quote character before ? + * {
        elsif (($i >= 1) and ($char[$i] =~ /\A [\?\+\*\{] \z/oxms)) {
            if ($char[$i-1] =~ /\A [\x00-\xFF] \z/oxms) {
            }
            else {
                $char[$i-1] = '(?:' . $char[$i-1] . ')';
            }
        }
    }

    $modifier =~ tr/i//d;
    $delimiter     = '/';
    $end_delimiter = '/';
    my $prematch = '';
    return join '', $ope, $delimiter, $prematch, '(?:', @char, ')', $matched, $end_delimiter, $modifier;
}

#
# escape regexp (s'here''b)
#
sub e_s1_qb {
    my($ope,$delimiter,$end_delimiter,$string,$modifier) = @_;

    # split regexp
    my @char = $string =~ /\G(
        \\\\        |
        [\$\@\/\\]  |
        [\x00-\xFF]
    )/oxmsg;

    # unescape character
    for (my $i=0; $i <= $#char; $i++) {
        if (0) {
        }

        # remain \\
        elsif ($char[$i] eq '\\\\') {
        }

        # escape $ @ / and \
        elsif ($char[$i] =~ /\A [\$\@\/\\] \z/oxms) {
            $char[$i] = '\\' . $char[$i];
        }
    }

    $delimiter     = '/';
    $end_delimiter = '/';
    my $prematch = '';
    return join '', $ope, $delimiter, $prematch, '(?:', @char, ')', $matched, $end_delimiter, $modifier;
}

#
# escape regexp (s''here')
#
sub e_s2_q {
    my($ope,$delimiter,$end_delimiter,$string) = @_;

    $slash = 'div';

    my @char = $string =~ / \G (\\\\|[\$\@\/\\]|$q_char) /oxmsg;
    for (my $i=0; $i <= $#char; $i++) {
        if (0) {
        }

        # not escape \\
        elsif ($char[$i] =~ /\A \\\\ \z/oxms) {
        }

        # escape $ @ / and \
        elsif ($char[$i] =~ /\A [\$\@\/\\] \z/oxms) {
            $char[$i] = '\\' . $char[$i];
        }
    }

    return join '', $ope, $delimiter, @char,   $end_delimiter;
}

#
# escape regexp (s/here/and here/modifier)
#
sub e_sub {
    my($variable,$delimiter1,$pattern,$end_delimiter1,$delimiter2,$replacement,$end_delimiter2,$modifier) = @_;
    $modifier ||= '';

    $modifier =~ tr/p//d;
    if ($modifier =~ /([adlu])/oxms) {
        my $line = 0;
        for (my $i=0; my($package,$filename,$use_line,$subroutine) = caller($i); $i++) {
            if ($filename ne __FILE__) {
                $line = $use_line + (CORE::substr($_,0,pos($_)) =~ tr/\n//) + 1;
                last;
            }
        }
        die qq{Unsupported modifier "$1" used at line $line.\n};
    }

    if ($variable eq '') {
        $variable      = '$_';
        $bind_operator = ' =~ ';
    }

    $slash = 'div';

    # P.128 Start of match (or end of previous match): \G
    # P.130 Advanced Use of \G with Perl
    # in Chapter 3: Overview of Regular Expression Features and Flavors
    # P.312 Iterative Matching: Scalar Context, with /g
    # in Chapter 7: Perl
    # of ISBN 0-596-00289-0 Mastering Regular Expressions, Second edition

    # P.181 Where You Left Off: The \G Assertion
    # in Chapter 5: Pattern Matching
    # of ISBN 0-596-00027-8 Programming Perl Third Edition.

    # P.220 Where You Left Off: The \G Assertion
    # in Chapter 5: Pattern Matching
    # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

    my $e_modifier = $modifier =~ tr/e//d;
    my $r_modifier = $modifier =~ tr/r//d;

    my $my = '';
    if ($variable =~ s/\A \( \s* ( (?: local \b | my \b | our \b | state \b )? .+ ) \) \z/$1/oxms) {
        $my = $variable;
        $variable =~ s/ (?: local \b | my \b | our \b | state \b ) \s* //oxms;
        $variable =~ s/ = .+ \z//oxms;
    }

    (my $variable_basename = $variable) =~ s/ [\[\{].* \z//oxms;
    $variable_basename =~ s/ \s+ \z//oxms;

    # quote replacement string
    my $e_replacement = '';
    if ($e_modifier >= 1) {
        $e_replacement = e_qq('', '', '', $replacement);
        $e_modifier--;
    }
    else {
        if ($delimiter2 eq "'") {
            $e_replacement = e_s2_q('qq', '/',         '/',             $replacement);
        }
        else {
            $e_replacement = e_qq  ('qq', $delimiter2, $end_delimiter2, $replacement);
        }
    }

    my $sub = '';

    # with /r
    if ($r_modifier) {
        if (0) {
        }

        # s///gr without multibyte anchoring
        elsif ($modifier =~ /g/oxms) {
            $sub = sprintf(
                #                        1                        2   3                                 4   5
                q<eval{local $Char::Latin2::re_t=%s; while($Char::Latin2::re_t =~ %s){%s local $^W=0; local $Char::Latin2::re_r=%s; %s$Char::Latin2::re_t="$`$Char::Latin2::re_r$'"; pos($Char::Latin2::re_t)=length "$`$Char::Latin2::re_r"; } return $Char::Latin2::re_t}>,

                $variable,                                                       #  1
                ($delimiter1 eq "'") ?                                           #  2
                e_s1_q('m', $delimiter1, $end_delimiter1, $pattern, $modifier) : #  :
                e_s1  ('m', $delimiter1, $end_delimiter1, $pattern, $modifier),  #  :
                $s_matched,                                                      #  3
                $e_replacement,                                                  #  4
                '$Char::Latin2::re_r=eval $Char::Latin2::re_r; ' x $e_modifier,                  #  5
            );
        }

        # s///r
        else {

            my $prematch = q{$`};

            $sub = sprintf(
                #  1     2          3                                 4   5  6                    7
                q<(%s =~ %s) ? eval{%s local $^W=0; local $Char::Latin2::re_r=%s; %s"%s$Char::Latin2::re_r$'" } : %s>,

                $variable,                                                       #  1
                ($delimiter1 eq "'") ?                                           #  2
                e_s1_q('m', $delimiter1, $end_delimiter1, $pattern, $modifier) : #  :
                e_s1  ('m', $delimiter1, $end_delimiter1, $pattern, $modifier),  #  :
                $s_matched,                                                      #  3
                $e_replacement,                                                  #  4
                '$Char::Latin2::re_r=eval $Char::Latin2::re_r; ' x $e_modifier,                  #  5
                $prematch,                                                       #  6
                $variable,                                                       #  7
            );
        }

        # $var !~ s///r doesn't make sense
        if ($bind_operator =~ / !~ /oxms) {
            $sub = q{die("$0: Using !~ with s///r doesn't make sense"), } . $sub;
        }
    }

    # without /r
    else {
        if (0) {
        }

        # s///g without multibyte anchoring
        elsif ($modifier =~ /g/oxms) {
            $sub = sprintf(
                #                                 1     2   3                                 4   5 6                         7                                                 8
                q<eval{local $Char::Latin2::re_n=0; while(%s =~ %s){%s local $^W=0; local $Char::Latin2::re_r=%s; %s%s="$`$Char::Latin2::re_r$'"; pos(%s)=length "$`$Char::Latin2::re_r"; $Char::Latin2::re_n++} return %s$Char::Latin2::re_n}>,

                $variable,                                                       #  1
                ($delimiter1 eq "'") ?                                           #  2
                e_s1_q('m', $delimiter1, $end_delimiter1, $pattern, $modifier) : #  :
                e_s1  ('m', $delimiter1, $end_delimiter1, $pattern, $modifier),  #  :
                $s_matched,                                                      #  3
                $e_replacement,                                                  #  4
                '$Char::Latin2::re_r=eval $Char::Latin2::re_r; ' x $e_modifier,                  #  5
                $variable,                                                       #  6
                $variable,                                                       #  7
                ($bind_operator =~ / !~ /oxms) ? '!' : '',                       #  8
            );
        }

        # s///
        else {

            my $prematch = q{$`};

            $sub = sprintf(

                ($bind_operator =~ / =~ /oxms) ?

                #  1 2 3          4                                 5   6 7   8
                q<(%s%s%s) ? eval{%s local $^W=0; local $Char::Latin2::re_r=%s; %s%s="%s$Char::Latin2::re_r$'"; 1 } : undef> :

                #  1 2 3              4                                 5   6 7   8
                q<(%s%s%s) ? 1 : eval{%s local $^W=0; local $Char::Latin2::re_r=%s; %s%s="%s$Char::Latin2::re_r$'"; undef }>,

                $variable,                                                       #  1
                $bind_operator,                                                  #  2
                ($delimiter1 eq "'") ?                                           #  3
                e_s1_q('m', $delimiter1, $end_delimiter1, $pattern, $modifier) : #  :
                e_s1  ('m', $delimiter1, $end_delimiter1, $pattern, $modifier),  #  :
                $s_matched,                                                      #  4
                $e_replacement,                                                  #  5
                '$Char::Latin2::re_r=eval $Char::Latin2::re_r; ' x $e_modifier,                  #  6
                $variable,                                                       #  7
                $prematch,                                                       #  8
            );
        }
    }

    # (my $foo = $bar) =~ s///   -->   (my $foo = $bar, eval { ... })[1]
    if ($my ne '') {
        $sub = "($my, $sub)[1]";
    }

    # clear s/// variable
    $sub_variable = '';
    $bind_operator = '';

    return $sub;
}

#
# escape regexp of split qr//
#
sub e_split {
    my($ope,$delimiter,$end_delimiter,$string,$modifier) = @_;
    $modifier ||= '';

    $modifier =~ tr/p//d;
    if ($modifier =~ /([adlu])/oxms) {
        my $line = 0;
        for (my $i=0; my($package,$filename,$use_line,$subroutine) = caller($i); $i++) {
            if ($filename ne __FILE__) {
                $line = $use_line + (CORE::substr($_,0,pos($_)) =~ tr/\n//) + 1;
                last;
            }
        }
        die qq{Unsupported modifier "$1" used at line $line.\n};
    }

    $slash = 'div';

    # /b /B modifier
    if ($modifier =~ tr/bB//d) {
        return join '', 'split', $ope, $delimiter, $string, $end_delimiter, $modifier;
    }

    my $ignorecase = ($modifier =~ /i/oxms) ? 1 : 0;
    my $metachar = qr/[\@\\|[\]{^]/oxms;

    # split regexp
    my @char = $string =~ /\G(
        \\o\{ [0-7]+           \}  |
        \\    [0-7]{2,3}           |
        \\x\{ [0-9A-Fa-f]+     \}  |
        \\x   [0-9A-Fa-f]{1,2}     |
        \\c   [\x40-\x5F]          |
        \\N\{ [^0-9\}][^\}]* \} |
        \\p\{ [^0-9\}][^\}]* \} |
        \\P\{ [^0-9\}][^\}]* \} |
        \\  (?:$q_char)            |
        \$` | \$\{`\} | \$ \s* PREMATCH  | \$ \s* \{ \s* PREMATCH  \s* \} | \$ \s* \{\^PREMATCH\}  |
        \$& | \$\{&\} | \$ \s* MATCH     | \$ \s* \{ \s* MATCH     \s* \} | \$ \s* \{\^MATCH\}     |
                        \$ \s* POSTMATCH | \$ \s* \{ \s* POSTMATCH \s* \} | \$ \s* \{\^POSTMATCH\} |
        [\$\@] $qq_variable        |
        \$ \s* \d+                 |
        \$ \s* \{ \s* \d+ \s* \}   |
        \$ \$ (?![\w\{])           |
        \$ \s* \$ \s* $qq_variable |
        \[\:\^ (?:alnum|alpha|ascii|blank|cntrl|digit|graph|lower|print|punct|space|upper|word|xdigit) :\] |
        \[\:   (?:alnum|alpha|ascii|blank|cntrl|digit|graph|lower|print|punct|space|upper|word|xdigit) :\] |
        \[\^                       |
        \(\?                       |
            (?:$q_char)
    )/oxmsg;

    my $left_e  = 0;
    my $right_e = 0;
    for (my $i=0; $i <= $#char; $i++) {

        # "\L\u" --> "\u\L"
        if (($char[$i] eq '\L') and ($char[$i+1] eq '\u')) {
            @char[$i,$i+1] = @char[$i+1,$i];
        }

        # "\U\l" --> "\l\U"
        elsif (($char[$i] eq '\U') and ($char[$i+1] eq '\l')) {
            @char[$i,$i+1] = @char[$i+1,$i];
        }

        # octal escape sequence
        elsif ($char[$i] =~ /\A \\o \{ ([0-7]+) \} \z/oxms) {
            $char[$i] = Char::Elatin2::octchr($1);
        }

        # hexadecimal escape sequence
        elsif ($char[$i] =~ /\A \\x \{ ([0-9A-Fa-f]+) \} \z/oxms) {
            $char[$i] = Char::Elatin2::hexchr($1);
        }

        # \N{CHARNAME} --> N\{CHARNAME}
        elsif ($char[$i] =~ /\A \\ (N) ( \{ ([^0-9\}][^\}]*) \} ) \z/oxms) {
            $char[$i] = $1 . '\\' . $2;
        }

        # \p{PROPERTY} --> p\{PROPERTY}
        elsif ($char[$i] =~ /\A \\ (p) ( \{ ([^0-9\}][^\}]*) \} ) \z/oxms) {
            $char[$i] = $1 . '\\' . $2;
        }

        # \P{PROPERTY} --> P\{PROPERTY}
        elsif ($char[$i] =~ /\A \\ (P) ( \{ ([^0-9\}][^\}]*) \} ) \z/oxms) {
            $char[$i] = $1 . '\\' . $2;
        }

        # \p, \P, \X --> p, P, X
        elsif ($char[$i] =~ /\A \\ ( [pPX] ) \z/oxms) {
            $char[$i] = $1;
        }

        if (0) {
        }

        # join separated multiple-octet
        elsif ($char[$i] =~ /\A (?: \\ [0-7]{2,3} | \\x [0-9A-Fa-f]{1,2}) \z/oxms) {
            if (   ($i+3 <= $#char) and (grep(/\A (?: \\ [0-7]{2,3} | \\x [0-9A-Fa-f]{1,2}) \z/oxms, @char[$i+1..$i+3]) == 3) and (eval(sprintf '"%s%s%s%s"', @char[$i..$i+3]) =~ /\A $q_char \z/oxms)) {
                $char[$i] .= join '', splice @char, $i+1, 3;
            }
            elsif (($i+2 <= $#char) and (grep(/\A (?: \\ [0-7]{2,3} | \\x [0-9A-Fa-f]{1,2}) \z/oxms, @char[$i+1..$i+2]) == 2) and (eval(sprintf '"%s%s%s"',   @char[$i..$i+2]) =~ /\A $q_char \z/oxms)) {
                $char[$i] .= join '', splice @char, $i+1, 2;
            }
            elsif (($i+1 <= $#char) and (grep(/\A (?: \\ [0-7]{2,3} | \\x [0-9A-Fa-f]{1,2}) \z/oxms, $char[$i+1      ]) == 1) and (eval(sprintf '"%s%s"',     @char[$i..$i+1]) =~ /\A $q_char \z/oxms)) {
                $char[$i] .= join '', splice @char, $i+1, 1;
            }
        }

        # open character class [...]
        elsif ($char[$i] eq '[') {
            my $left = $i;
            if ($char[$i+1] eq ']') {
                $i++;
            }
            while (1) {
                if (++$i > $#char) {
                    die __FILE__, ": Unmatched [] in regexp";
                }
                if ($char[$i] eq ']') {
                    my $right = $i;

                    # [...]
                    if (grep(/\A [\$\@]/oxms,@char[$left+1..$right-1]) >= 1) {
                        splice @char, $left, $right-$left+1, sprintf(q{@{[Char::Elatin2::charlist_qr(%s,'%s')]}}, join(',', map {qq_stuff($delimiter,$end_delimiter,$_)} @char[$left+1..$right-1]), $modifier);
                    }
                    else {
                        splice @char, $left, $right-$left+1, Char::Elatin2::charlist_qr(@char[$left+1..$right-1], $modifier);
                    }

                    $i = $left;
                    last;
                }
            }
        }

        # open character class [^...]
        elsif ($char[$i] eq '[^') {
            my $left = $i;
            if ($char[$i+1] eq ']') {
                $i++;
            }
            while (1) {
                if (++$i > $#char) {
                    die __FILE__, ": Unmatched [] in regexp";
                }
                if ($char[$i] eq ']') {
                    my $right = $i;

                    # [^...]
                    if (grep(/\A [\$\@]/oxms,@char[$left+1..$right-1]) >= 1) {
                        splice @char, $left, $right-$left+1, sprintf(q{@{[Char::Elatin2::charlist_not_qr(%s,'%s')]}}, join(',', map {qq_stuff($delimiter,$end_delimiter,$_)} @char[$left+1..$right-1]), $modifier);
                    }
                    else {
                        splice @char, $left, $right-$left+1, Char::Elatin2::charlist_not_qr(@char[$left+1..$right-1], $modifier);
                    }

                    $i = $left;
                    last;
                }
            }
        }

        # rewrite character class or escape character
        elsif (my $char = character_class($char[$i],$modifier)) {
            $char[$i] = $char;
        }

        # P.794 29.2.161. split
        # in Chapter 29: Functions
        # of ISBN 0-596-00027-8 Programming Perl Third Edition.

        # P.951 split
        # in Chapter 27: Functions
        # of ISBN 978-0-596-00492-7 Programming Perl 4th Edition.

        # said "The //m modifier is assumed when you split on the pattern /^/",
        # but perl5.008 is not so. Therefore, this software adds //m.
        # (and so on)

        # split(m/^/) --> split(m/^/m)
        elsif (($char[$i] eq '^') and ($modifier !~ /m/oxms)) {
            $modifier .= 'm';
        }

        # /i modifier
        elsif ($ignorecase and ($char[$i] =~ /\A [\x00-\xFF] \z/oxms) and (Char::Elatin2::uc($char[$i]) ne Char::Elatin2::fc($char[$i]))) {
            if (CORE::length(Char::Elatin2::fc($char[$i])) == 1) {
                $char[$i] = '['   . Char::Elatin2::uc($char[$i])       . Char::Elatin2::fc($char[$i]) . ']';
            }
            else {
                $char[$i] = '(?:' . Char::Elatin2::uc($char[$i]) . '|' . Char::Elatin2::fc($char[$i]) . ')';
            }
        }

        # \u \l \U \L \F \Q \E
        elsif ($char[$i] =~ /\A ([<>]) \z/oxms) {
            if ($right_e < $left_e) {
                $char[$i] = '\\' . $char[$i];
            }
        }
        elsif ($char[$i] eq '\u') {
            $char[$i] = '@{[Char::Elatin2::ucfirst qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\l') {
            $char[$i] = '@{[Char::Elatin2::lcfirst qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\U') {
            $char[$i] = '@{[Char::Elatin2::uc qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\L') {
            $char[$i] = '@{[Char::Elatin2::lc qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\F') {
            $char[$i] = '@{[Char::Elatin2::fc qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\Q') {
            $char[$i] = '@{[CORE::quotemeta qq<';
            $left_e++;
        }
        elsif ($char[$i] eq '\E') {
            if ($right_e < $left_e) {
                $char[$i] = '>]}';
                $right_e++;
            }
            else {
                $char[$i] = '';
            }
        }
        elsif ($char[$i] eq '\Q') {
            while (1) {
                if (++$i > $#char) {
                    last;
                }
                if ($char[$i] eq '\E') {
                    last;
                }
            }
        }
        elsif ($char[$i] eq '\E') {
        }

        # $0 --> $0
        elsif ($char[$i] =~ /\A \$ 0 \z/oxms) {
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }
        elsif ($char[$i] =~ /\A \$ \{ \s* 0 \s* \} \z/oxms) {
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # $$ --> $$
        elsif ($char[$i] =~ /\A \$\$ \z/oxms) {
        }

        # $1, $2, $3 --> $2, $3, $4 after s/// with multibyte anchoring
        # $1, $2, $3 --> $1, $2, $3 otherwise
        elsif ($char[$i] =~ /\A \$ ([1-9][0-9]*) \z/oxms) {
            $char[$i] = e_capture($1);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }
        elsif ($char[$i] =~ /\A \$ \{ \s* ([1-9][0-9]*) \s* \} \z/oxms) {
            $char[$i] = e_capture($1);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # $$foo[ ... ] --> $ $foo->[ ... ]
        elsif ($char[$i] =~ /\A \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) ( \[ (?:$qq_bracket)*? \] ) \z/oxms) {
            $char[$i] = e_capture($1.'->'.$2);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # $$foo{ ... } --> $ $foo->{ ... }
        elsif ($char[$i] =~ /\A \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) ( \{ (?:$qq_brace)*? \} ) \z/oxms) {
            $char[$i] = e_capture($1.'->'.$2);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # $$foo
        elsif ($char[$i] =~ /\A \$ ( \$ [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* ) \z/oxms) {
            $char[$i] = e_capture($1);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # $`, ${`}, $PREMATCH, ${PREMATCH}, ${^PREMATCH} --> Char::Elatin2::PREMATCH()
        elsif ($char[$i] =~ /\A ( \$` | \$\{`\} | \$ \s* PREMATCH  | \$ \s* \{ \s* PREMATCH  \s* \} | \$ \s* \{\^PREMATCH\}  ) \z/oxmsgc) {
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(Char::Elatin2::PREMATCH())]}';
            }
            else {
                $char[$i] = '@{[Char::Elatin2::PREMATCH()]}';
            }
        }

        # $&, ${&}, $MATCH, ${MATCH}, ${^MATCH} --> Char::Elatin2::MATCH()
        elsif ($char[$i] =~ /\A ( \$& | \$\{&\} | \$ \s* MATCH     | \$ \s* \{ \s* MATCH     \s* \} | \$ \s* \{\^MATCH\}     ) \z/oxmsgc) {
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(Char::Elatin2::MATCH())]}';
            }
            else {
                $char[$i] = '@{[Char::Elatin2::MATCH()]}';
            }
        }

        # $POSTMATCH, ${POSTMATCH}, ${^POSTMATCH} --> Char::Elatin2::POSTMATCH()
        elsif ($char[$i] =~ /\A (                 \$ \s* POSTMATCH | \$ \s* \{ \s* POSTMATCH \s* \} | \$ \s* \{\^POSTMATCH\} ) \z/oxmsgc) {
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(Char::Elatin2::POSTMATCH())]}';
            }
            else {
                $char[$i] = '@{[Char::Elatin2::POSTMATCH()]}';
            }
        }

        # ${ foo }
        elsif ($char[$i] =~ /\A \$ \s* \{ ( \s* [A-Za-z_][A-Za-z0-9_]*(?: ::[A-Za-z_][A-Za-z0-9_]*)* \s* ) \} \z/oxms) {
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $1 . ')]}';
            }
        }

        # ${ ... }
        elsif ($char[$i] =~ /\A \$ \s* \{ \s* ( .+ ) \s* \} \z/oxms) {
            $char[$i] = e_capture($1);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # $scalar or @array
        elsif ($char[$i] =~ /\A [\$\@].+ /oxms) {
            $char[$i] = e_string($char[$i]);
            if ($ignorecase) {
                $char[$i] = '@{[Char::Elatin2::ignorecase(' . $char[$i] . ')]}';
            }
        }

        # quote character before ? + * {
        elsif (($i >= 1) and ($char[$i] =~ /\A [\?\+\*\{] \z/oxms)) {
            if ($char[$i-1] =~ /\A (?:\\[0-7]{2,3}|\\x[0-9-A-Fa-f]{1,2}) \z/oxms) {
            }
            else {
                $char[$i-1] = '(?:' . $char[$i-1] . ')';
            }
        }
    }

    # make regexp string
    $modifier =~ tr/i//d;
    if ($left_e > $right_e) {
        return join '', 'Char::Elatin2::split', $ope, $delimiter, @char, '>]}' x ($left_e - $right_e), $end_delimiter, $modifier;
    }
    return     join '', 'Char::Elatin2::split', $ope, $delimiter, @char,                               $end_delimiter, $modifier;
}

#
# escape regexp of split qr''
#
sub e_split_q {
    my($ope,$delimiter,$end_delimiter,$string,$modifier) = @_;
    $modifier ||= '';

    $modifier =~ tr/p//d;
    if ($modifier =~ /([adlu])/oxms) {
        my $line = 0;
        for (my $i=0; my($package,$filename,$use_line,$subroutine) = caller($i); $i++) {
            if ($filename ne __FILE__) {
                $line = $use_line + (CORE::substr($_,0,pos($_)) =~ tr/\n//) + 1;
                last;
            }
        }
        die qq{Unsupported modifier "$1" used at line $line.\n};
    }

    $slash = 'div';

    # /b /B modifier
    if ($modifier =~ tr/bB//d) {
        return join '', 'split', $ope, $delimiter, $string, $end_delimiter, $modifier;
    }

    my $ignorecase = ($modifier =~ /i/oxms) ? 1 : 0;

    # split regexp
    my @char = $string =~ /\G(
        \[\:\^ [a-z]+ \:\] |
        \[\:   [a-z]+ \:\] |
        \[\^               |
        \\?    (?:$q_char)
    )/oxmsg;

    # unescape character
    for (my $i=0; $i <= $#char; $i++) {
        if (0) {
        }

        # open character class [...]
        elsif ($char[$i] eq '[') {
            my $left = $i;
            if ($char[$i+1] eq ']') {
                $i++;
            }
            while (1) {
                if (++$i > $#char) {
                    die __FILE__, ": Unmatched [] in regexp";
                }
                if ($char[$i] eq ']') {
                    my $right = $i;

                    # [...]
                    splice @char, $left, $right-$left+1, Char::Elatin2::charlist_qr(@char[$left+1..$right-1], $modifier);

                    $i = $left;
                    last;
                }
            }
        }

        # open character class [^...]
        elsif ($char[$i] eq '[^') {
            my $left = $i;
            if ($char[$i+1] eq ']') {
                $i++;
            }
            while (1) {
                if (++$i > $#char) {
                    die __FILE__, ": Unmatched [] in regexp";
                }
                if ($char[$i] eq ']') {
                    my $right = $i;

                    # [^...]
                    splice @char, $left, $right-$left+1, Char::Elatin2::charlist_not_qr(@char[$left+1..$right-1], $modifier);

                    $i = $left;
                    last;
                }
            }
        }

        # rewrite character class or escape character
        elsif (my $char = character_class($char[$i],$modifier)) {
            $char[$i] = $char;
        }

        # split(m/^/) --> split(m/^/m)
        elsif (($char[$i] eq '^') and ($modifier !~ /m/oxms)) {
            $modifier .= 'm';
        }

        # /i modifier
        elsif ($ignorecase and ($char[$i] =~ /\A [\x00-\xFF] \z/oxms) and (Char::Elatin2::uc($char[$i]) ne Char::Elatin2::fc($char[$i]))) {
            if (CORE::length(Char::Elatin2::fc($char[$i])) == 1) {
                $char[$i] = '['   . Char::Elatin2::uc($char[$i])       . Char::Elatin2::fc($char[$i]) . ']';
            }
            else {
                $char[$i] = '(?:' . Char::Elatin2::uc($char[$i]) . '|' . Char::Elatin2::fc($char[$i]) . ')';
            }
        }

        # quote character before ? + * {
        elsif (($i >= 1) and ($char[$i] =~ /\A [\?\+\*\{] \z/oxms)) {
            if ($char[$i-1] =~ /\A [\x00-\xFF] \z/oxms) {
            }
            else {
                $char[$i-1] = '(?:' . $char[$i-1] . ')';
            }
        }
    }

    $modifier =~ tr/i//d;
    return join '', 'Char::Elatin2::split', $ope, $delimiter, @char, $end_delimiter, $modifier;
}

1;

__END__

=pod

=head1 NAME

Char::Latin2 - Source code filter to escape Latin-2 script

=head1 Install and Usage

There are two steps there:

=over 2

=item * You'll have to download Char/Latin2.pm and Char/Elatin2.pm and put it in your perl lib directory.

=item * You'll need to write "use Char::Latin2;" at head of the script.

=back

=head1 SYNOPSIS

  use Char::Latin2;
  use Char::Latin2 ver.sion;             --- require minimum version
  use Char::Latin2 ver.sion.0;           --- expects version (match or die)

  # "no Char::Latin2;" not supported

  or

  $ perl Char/Latin2.pm Latin-2_script.pl > Escaped_script.pl.e

  then

  $ perl Escaped_script.pl.e

  Latin-2_script.pl  --- script written in Latin-2
  Escaped_script.pl.e --- escaped script


  dummy functions:
    utf8::upgrade(...);
    utf8::downgrade(...);
    utf8::encode(...);
    utf8::decode(...);
    utf8::is_utf8(...);
    utf8::valid(...);
    bytes::chr(...);
    bytes::index(...);
    bytes::length(...);
    bytes::ord(...);
    bytes::rindex(...);
    bytes::substr(...);

=head1 ABSTRACT

Char::Latin2 software is "middleware" between perl interpreter and your Perl script
written in Latin-2.

Perl is optimized for problems which are about 90% working with text and about
10% everything else. Even if this "text" doesn't contain Latin-2, Perl3 or later
can treat Latin-2 as binary data.

By "use Char::Latin2;", it automatically interpret your script as Latin-2. The various
functions of perl including a regular expression can treat Latin-2 now.
The function length treats length per byte. This software does not use UTF8
flag.

=head1 Yet Another Future Of

JPerl is very useful software. -- Oops, note, this "JPerl" means "Japanized Perl"
or "Japanese Perl". Therefore, it is unrelated to JPerl of the following.

 JPerl is an implementation of Perl written in Java.
 http://www.javainc.com/projects/jperl/
 
 jPerl - Perl on the JVM
 http://www.dzone.com/links/175948.html
 
 Jamie's PERL scripts for bioinformatics
 http://code.google.com/p/jperl/
 
 jperl (Jonathan Perl)
 https://github.com/jperl

Now, the last version of JPerl is 5.005_04 and is not maintained now.

Japanization modifier WATANABE Hirofumi said,

  "Because WATANABE am tired I give over maintaing JPerl."

at Slide #15: "The future of JPerl" of

L<ftp://ftp.oreilly.co.jp/pcjp98/watanabe/jperlconf.ppt>

in The Perl Confernce Japan 1998.

When I heard it, I thought that someone excluding me would maintain JPerl.
And I slept every night hanging a sock. Night and day, I kept having hope.
After 10 years, I noticed that white beard exists in the sock :-)

This software is a source code filter to escape Perl script encoded by Latin-2
given from STDIN or command line parameter. The character code is never converted
by escaping the script. Neither the value of the character nor the length of the
character string change even if it escapes.

I learned the following things from the successful software.

=over 2

=item * Upper Compatibility like Perl4 to Perl5

=item * Maximum Portability like jcode.pl

=item * Remains One Language Handling Raw Latin-2, Doesn't Use UTF8 flag like JPerl

=item * Remains One Interpreter like Encode module

=item * Code Set Independent like Ruby

=item * Monolithic Script like cpanminus

=item * There's more than one way to do it like Perl itself

=back

I am excited about this software and Perl's future --- I hope you are too.

=head1 JRE: JPerl Runtime Environment

  +---------------------------------------+
  |        JPerl Application Script       | Your Script
  +---------------------------------------+
  |  Source Code Filter, Runtime Routine  | ex. Char/Latin2.pm, Char/Elatin2.pm
  +---------------------------------------+
  |          PVM 5.00503 or later         | ex. perl 5.00503
  +---------------------------------------+

A Perl Virtual Machine (PVM) enables a set of computer software programs and
data structures to use a virtual machine model for the execution of other
computer programs and scripts. The model used by a PVM accepts a form of
computer intermediate language commonly referred to as Perl byteorientedcode.
This language conceptually represents the instruction set of a byte-oriented,
capability architecture.

=head1 Basic Idea of Source Code Filter

I discovered this mail again recently.

[Tokyo.pm] jus Benkyoukai

http://mail.pm.org/pipermail/tokyo-pm/1999-September/001854.html

save as: SJIS.pm

  package SJIS;
  use Filter::Util::Call;
  sub multibyte_filter {
      my $status;
      if (($status = filter_read()) > 0 ) {
          s/([\x81-\x9f\xe0-\xef])([\x40-\x7e\x80-\xfc])/
              sprintf("\\x%02x\\x%02x",ord($1),ord($2))
          /eg;
      }
      $status;
  }
  sub import {
      filter_add(\&multibyte_filter);
  }
  1;

I am glad that I could confirm my idea is not so wrong.

=head1 Command-line Wildcard Expansion on DOS-like Systems

The default command shells on DOS-like systems (COMMAND.COM or cmd.exe or
Win95Cmd.exe) do not expand wildcard arguments supplied to programs. Instead,
import of Char/Elatin2.pm works well.

   in Char/Elatin2.pm
   #
   # @ARGV wildcard globbing
   #
   sub import {

       if ($^O =~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms) {
           my @argv = ();
           for (@ARGV) {

               # has space
               if (/\A (?:$q_char)*? [ ] /oxms) {
                   if (my @glob = Char::Elatin2::glob(qq{"$_"})) {
                       push @argv, @glob;
                   }
                   else {
                       push @argv, $_;
                   }
               }

               # has wildcard metachar
               elsif (/\A (?:$q_char)*? [*?] /oxms) {
                   if (my @glob = Char::Elatin2::glob($_)) {
                       push @argv, @glob;
                   }
                   else {
                       push @argv, $_;
                   }
               }

               # no wildcard globbing
               else {
                   push @argv, $_;
               }
           }
           @ARGV = @argv;
       }
   }

=head1 Software Composition

   Char/Latin2.pm               --- source code filter to escape Latin-2
   Char/Elatin2.pm              --- run-time routines for Char/Latin2.pm

=head1 Upper Compatibility by Escaping

This software adds the function by 'Escaping' it always, and nothing of the
past is broken. Therefore, 'Possible job' never becomes 'Impossible job'.
This approach is effective in the field where the retreat is never permitted.
It means incompatible upgrade of Perl should be rewound.

=head1 Escaping Your Script (You do)

You need write 'use Char::Latin2;' in your script.

  ---------------------------------
  Before      You do
  ---------------------------------
  (nothing)   use Char::Latin2;
  ---------------------------------

=head1 Calling 'Char::Elatin2::ignorecase()' (Char/Latin2.pm provides)

Char/Latin2.pm applies calling 'Char::Elatin2::ignorecase()' instead of /i modifier.

  --------------------------------------------------------------------------------
  Before                  After
  --------------------------------------------------------------------------------
  m/...$var.../i          m/...@{[Char::Elatin2::ignorecase($var)]}.../
  --------------------------------------------------------------------------------

=head1 Escaping Character Classes (Char/Elatin2.pm provides)

The character classes are redefined as follows to backward compatibility.

  ---------------------------------------------------------------
  Before        After
  ---------------------------------------------------------------
   .            ${Char::Elatin2::dot}
                ${Char::Elatin2::dot_s}    (/s modifier)
  \d            [0-9]              (universally)
  \s            \s
  \w            [0-9A-Z_a-z]       (universally)
  \D            ${Char::Elatin2::eD}
  \S            ${Char::Elatin2::eS}
  \W            ${Char::Elatin2::eW}
  \h            [\x09\x20]
  \v            [\x0A\x0B\x0C\x0D]
  \H            ${Char::Elatin2::eH}
  \V            ${Char::Elatin2::eV}
  \C            [\x00-\xFF]
  \X            X                  (so, just 'X')
  \R            ${Char::Elatin2::eR}
  \N            ${Char::Elatin2::eN}
  ---------------------------------------------------------------

Also POSIX-style character classes.

  ---------------------------------------------------------------
  Before        After
  ---------------------------------------------------------------
  [:alnum:]     [\x30-\x39\x41-\x5A\x61-\x7A]
  [:alpha:]     [\x41-\x5A\x61-\x7A]
  [:ascii:]     [\x00-\x7F]
  [:blank:]     [\x09\x20]
  [:cntrl:]     [\x00-\x1F\x7F]
  [:digit:]     [\x30-\x39]
  [:graph:]     [\x21-\x7F]
  [:lower:]     [\x61-\x7A]
                [\x41-\x5A\x61-\x7A]     (/i modifier)
  [:print:]     [\x20-\x7F]
  [:punct:]     [\x21-\x2F\x3A-\x3F\x40\x5B-\x5F\x60\x7B-\x7E]
  [:space:]     [\s\x0B]
  [:upper:]     [\x41-\x5A]
                [\x41-\x5A\x61-\x7A]     (/i modifier)
  [:word:]      [\x30-\x39\x41-\x5A\x5F\x61-\x7A]
  [:xdigit:]    [\x30-\x39\x41-\x46\x61-\x66]
  [:^alnum:]    ${Char::Elatin2::not_alnum}
  [:^alpha:]    ${Char::Elatin2::not_alpha}
  [:^ascii:]    ${Char::Elatin2::not_ascii}
  [:^blank:]    ${Char::Elatin2::not_blank}
  [:^cntrl:]    ${Char::Elatin2::not_cntrl}
  [:^digit:]    ${Char::Elatin2::not_digit}
  [:^graph:]    ${Char::Elatin2::not_graph}
  [:^lower:]    ${Char::Elatin2::not_lower}
                ${Char::Elatin2::not_lower_i}    (/i modifier)
  [:^print:]    ${Char::Elatin2::not_print}
  [:^punct:]    ${Char::Elatin2::not_punct}
  [:^space:]    ${Char::Elatin2::not_space}
  [:^upper:]    ${Char::Elatin2::not_upper}
                ${Char::Elatin2::not_upper_i}    (/i modifier)
  [:^word:]     ${Char::Elatin2::not_word}
  [:^xdigit:]   ${Char::Elatin2::not_xdigit}
  ---------------------------------------------------------------

\b and \B are redefined as follows to backward compatibility.

  ---------------------------------------------------------------
  Before      After
  ---------------------------------------------------------------
  \b          ${Char::Elatin2::eb}
  \B          ${Char::Elatin2::eB}
  ---------------------------------------------------------------

Definitions in Char/Elatin2.pm.

  ---------------------------------------------------------------------------------------------------------------------------------------------------------
  After                    Definition
  ---------------------------------------------------------------------------------------------------------------------------------------------------------
  ${Char::Elatin2::dot}            qr{(?:[^\x0A])}
  ${Char::Elatin2::dot_s}          qr{(?:[\x00-\xFF])}
  ${Char::Elatin2::eD}             qr{(?:[^0-9])}
  ${Char::Elatin2::eS}             qr{(?:[^\s])}
  ${Char::Elatin2::eW}             qr{(?:[^0-9A-Z_a-z])}
  ${Char::Elatin2::eH}             qr{(?:[^\x09\x20])}
  ${Char::Elatin2::eV}             qr{(?:[^\x0A\x0B\x0C\x0D])}
  ${Char::Elatin2::eR}             qr{(?:\x0D\x0A|[\x0A\x0D])}
  ${Char::Elatin2::eN}             qr{(?:[^\x0A])}
  ${Char::Elatin2::not_alnum}      qr{(?:[^\x30-\x39\x41-\x5A\x61-\x7A])}
  ${Char::Elatin2::not_alpha}      qr{(?:[^\x41-\x5A\x61-\x7A])}
  ${Char::Elatin2::not_ascii}      qr{(?:[^\x00-\x7F])}
  ${Char::Elatin2::not_blank}      qr{(?:[^\x09\x20])}
  ${Char::Elatin2::not_cntrl}      qr{(?:[^\x00-\x1F\x7F])}
  ${Char::Elatin2::not_digit}      qr{(?:[^\x30-\x39])}
  ${Char::Elatin2::not_graph}      qr{(?:[^\x21-\x7F])}
  ${Char::Elatin2::not_lower}      qr{(?:[^\x61-\x7A])}
  ${Char::Elatin2::not_lower_i}    qr{(?:[\x00-\xFF])}
  ${Char::Elatin2::not_print}      qr{(?:[^\x20-\x7F])}
  ${Char::Elatin2::not_punct}      qr{(?:[^\x21-\x2F\x3A-\x3F\x40\x5B-\x5F\x60\x7B-\x7E])}
  ${Char::Elatin2::not_space}      qr{(?:[^\s\x0B])}
  ${Char::Elatin2::not_upper}      qr{(?:[^\x41-\x5A])}
  ${Char::Elatin2::not_upper_i}    qr{(?:[\x00-\xFF])}
  ${Char::Elatin2::not_word}       qr{(?:[^\x30-\x39\x41-\x5A\x5F\x61-\x7A])}
  ${Char::Elatin2::not_xdigit}     qr{(?:[^\x30-\x39\x41-\x46\x61-\x66])}
  ${Char::Elatin2::eb}             qr{(?:\A(?=[0-9A-Z_a-z])|(?<=[\x00-\x2F\x40\x5B-\x5E\x60\x7B-\xFF])(?=[0-9A-Z_a-z])|(?<=[0-9A-Z_a-z])(?=[\x00-\x2F\x40\x5B-\x5E\x60\x7B-\xFF]|\z))}
  ${Char::Elatin2::eB}             qr{(?:(?<=[0-9A-Z_a-z])(?=[0-9A-Z_a-z])|(?<=[\x00-\x2F\x40\x5B-\x5E\x60\x7B-\xFF])(?=[\x00-\x2F\x40\x5B-\x5E\x60\x7B-\xFF]))}
  ---------------------------------------------------------------------------------------------------------------------------------------------------------

=head1 Un-Escaping \ of \N, \p, \P, and \X (Char/Latin2.pm provides)

Char/Latin2.pm removes '\' at head of alphanumeric regexp metasymbols \N, \p, \P
and \X. By this method, you can avoid the trap of the abstraction.

See also,
Deprecate literal unescaped "{" in regexes.
http://perl5.git.perl.org/perl.git/commit/2a53d3314d380af5ab5283758219417c6dfa36e9

  ------------------------------------
  Before           After
  ------------------------------------
  \N{CHARNAME}     N\{CHARNAME}
  \p{L}            p\{L}
  \p{^L}           p\{^L}
  \p{\^L}          p\{\^L}
  \pL              pL
  \P{L}            P\{L}
  \P{^L}           P\{^L}
  \P{\^L}          P\{\^L}
  \PL              PL
  \X               X
  ------------------------------------

=head1 Escaping Built-in Functions (Char/Latin2.pm and Char/Elatin2.pm provide)

Insert 'Char::Elatin2::' at head of function name. Char/Elatin2.pm provides your script Char::Elatin2::*
subroutines.

  -------------------------------------------
  Before      After            Works as
  -------------------------------------------
  lc          Char::Elatin2::lc        Character
  lcfirst     Char::Elatin2::lcfirst   Character
  uc          Char::Elatin2::uc        Character
  ucfirst     Char::Elatin2::ucfirst   Character
  fc          Char::Elatin2::fc        Character
  chr         Char::Elatin2::chr       Character
  glob        Char::Elatin2::glob      Character
  -------------------------------------------

  ------------------------------------------------------------------------------------------------------------------------
  Before                   After
  ------------------------------------------------------------------------------------------------------------------------
  use Perl::Module;        BEGIN { require 'Perl/Module.pm'; Perl::Module->import() if Perl::Module->can('import'); }
  use Perl::Module @list;  BEGIN { require 'Perl/Module.pm'; Perl::Module->import(@list) if Perl::Module->can('import'); }
  use Perl::Module ();     BEGIN { require 'Perl/Module.pm'; }
  no Perl::Module;         BEGIN { require 'Perl/Module.pm'; Perl::Module->unimport() if Perl::Module->can('unimport'); }
  no Perl::Module @list;   BEGIN { require 'Perl/Module.pm'; Perl::Module->unimport(@list) if Perl::Module->can('unimport'); }
  no Perl::Module ();      BEGIN { require 'Perl/Module.pm'; }
  ------------------------------------------------------------------------------------------------------------------------

=head1 Un-Escaping bytes::* Subroutines (Char/Latin2.pm provides)

Char/Latin2.pm removes 'bytes::' at head of subroutine name.

  ---------------------------------------
  Before           After     Works as
  ---------------------------------------
  bytes::chr       chr       Byte
  bytes::index     index     Byte
  bytes::length    length    Byte
  bytes::ord       ord       Byte
  bytes::rindex    rindex    Byte
  bytes::substr    substr    Byte
  ---------------------------------------

=head1 Escaping Standard Module Content (You do)

You need copy built-in standard module to /Perl/site/lib/Char::Latin2 and change
'use utf8;' to 'use Char::Latin2;' in its. You need help yourself for now.

Back to and see 'Escaping Your Script'. Enjoy hacking!!

=head1 Ignore Pragmas and Modules

  -----------------------------------------------------------
  Before                    After
  -----------------------------------------------------------
  use strict;               use strict; no strict qw(refs);
  use 5.12.0;               use 5.12.0; no strict qw(refs);
  require utf8;             # require utf8;
  require bytes;            # require bytes;
  require charnames;        # require charnames;
  require I18N::Japanese;   # require I18N::Japanese;
  require I18N::Collate;    # require I18N::Collate;
  require I18N::JExt;       # require I18N::JExt;
  require File::DosGlob;    # require File::DosGlob;
  require Wild;             # require Wild;
  require Wildcard;         # require Wildcard;
  require Japanese;         # require Japanese;
  use utf8;                 # use utf8;
  use bytes;                # use bytes;
  use charnames;            # use charnames;
  use I18N::Japanese;       # use I18N::Japanese;
  use I18N::Collate;        # use I18N::Collate;
  use I18N::JExt;           # use I18N::JExt;
  use File::DosGlob;        # use File::DosGlob;
  use Wild;                 # use Wild;
  use Wildcard;             # use Wildcard;
  use Japanese;             # use Japanese;
  no utf8;                  # no utf8;
  no bytes;                 # no bytes;
  no charnames;             # no charnames;
  no I18N::Japanese;        # no I18N::Japanese;
  no I18N::Collate;         # no I18N::Collate;
  no I18N::JExt;            # no I18N::JExt;
  no File::DosGlob;         # no File::DosGlob;
  no Wild;                  # no Wild;
  no Wildcard;              # no Wildcard;
  no Japanese;              # no Japanese;
  -----------------------------------------------------------

  Comment out pragma to ignore utf8 environment, and Char/Elatin2.pm provides these
  functions.

=over 2

=item * Dummy utf8::upgrade

  $num_octets = utf8::upgrade($string);

  Returns the number of octets necessary to represent the string.

=item * Dummy utf8::downgrade

  $success = utf8::downgrade($string[, FAIL_OK]);

  Returns true always.

=item * Dummy utf8::encode

  utf8::encode($string);

  Returns nothing.

=item * Dummy utf8::decode

  $success = utf8::decode($string);

  Returns true always.

=item * Dummy utf8::is_utf8

  $flag = utf8::is_utf8(STRING);

  Returns false always.

=item * Dummy utf8::valid

  $flag = utf8::valid(STRING);

  Returns true always.

=item * Dummy bytes::chr

  This subroutine is same as chr.

=item * Dummy bytes::index

  This subroutine is same as index.

=item * Dummy bytes::length

  This subroutine is same as length.

=item * Dummy bytes::ord

  This subroutine is same as ord.

=item * Dummy bytes::rindex

  This subroutine is same as rindex.

=item * Dummy bytes::substr

  This subroutine is same as substr.

=back

=head1 Environment Variable

 This software uses the flock function for exclusive control. The execution of the
 program is blocked until it becomes possible to read or write the file.
 You can have it not block in the flock function by defining environment variable
 SJIS_NONBLOCK.
 
 Example:
 
   SET SJIS_NONBLOCK=1
 
 (The value '1' doesn't have the meaning)

=head1 BUGS, LIMITATIONS, and COMPATIBILITY

I have tested and verified this software using the best of my ability.
However, a software containing much regular expression is bound to contain
some bugs. Thus, if you happen to find a bug that's in Char::Latin2 software and not
your own program, you can try to reduce it to a minimal test case and then
report it to the following author's address. If you have an idea that could
make this a more useful tool, please let everyone share it.

=over 2

=item * cloister of regular expression

The cloister (?s) and (?i) of a regular expression will not be implemented for
the time being. Cloister (?s) can be substituted with the .(dot) and \N on /s
modifier. Cloister (?i) can be substituted with \F...\E.

=item * Modifier /a /d /l and /u of Regular Expression

The concept of this software is not to use two or more encoding methods as
literal string and literal of regexp in one Perl script. Therefore, modifier
/a, /d, /l, and /u are not supported.
\d means [0-9] universally.

=item * Named Character

A named character, such \N{GREEK SMALL LETTER EPSILON}, \N{greek:epsilon}, or
\N{epsilon} is not supported.

=item * Unicode Properties (aka Character Properties) of Regular Expression

Unicode properties (aka character properties) of regexp are not available.
Also (?[]) in regexp of Perl 5.18 is not available. There is no plans to currently
support these.

=item * eval "string"

The function which escapes "string" of eval has not been implemented yet. It will
be supported in future versions.

=item * Delimiter of String and Regexp

qq//, q//, qw//, qx//, qr//, m//, s///, tr///, and y/// can't use a wide character
as the delimiter.

=back

=head1 AUTHOR

INABA Hitoshi E<lt>ina@cpan.orgE<gt>

This project was originated by INABA Hitoshi.

=head1 LICENSE AND COPYRIGHT

This software is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

This software is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=head1 My Goal

P.401 See chapter 15: Unicode
of ISBN 0-596-00027-8 Programming Perl Third Edition.

Before the introduction of Unicode support in perl, The eq operator
just compared the byte-strings represented by two scalars. Beginning
with perl 5.8, eq compares two byte-strings with simultaneous
consideration of the UTF8 flag.

  Information processing model beginning with perl 5.8
 
    +----------------------+---------------------+
    |     Text strings     |                     |
    +----------+-----------|    Binary strings   |
    |   UTF8   |  Latin-1  |                     |
    +----------+-----------+---------------------+
    | UTF8     |            Not UTF8             |
    | Flagged  |            Flagged              |
    +--------------------------------------------+
    http://perl-users.jp/articles/advent-calendar/2010/casual/4
 
    You should memorize this figure.
 
    (Why is only Latin-1 special?)

This change consequentially made a big gap between a past script and
new script. Both scripts cannot re-use the code mutually any longer.
Because a new method puts a strain in the programmer, it will still take
time to replace all the in existence scripts.

The biggest problem of new method is that the UTF8 flag can't synchronize
to real encode of string. Thus you must debug about UTF8 flag, before
your script. How to solve it by returning to a this method, let's drag out
page 402 of the old dusty Programming Perl, 3rd ed. again.

  Information processing model beginning with perl3 or this software of
  UNIX/C-ism.

    +--------------------------------------------+
    |       Text strings as Binary strings       |
    |       Binary strings as Text strings       |
    +--------------------------------------------+
    |        Not UTF8 Flagged, UNIX/C-ism        |
    +--------------------------------------------+

  Script could be written in native encoding of operating systems.
  - Like contents of a file
  - Like a file name on the file systems
  - Like command lines
  - Like environment variables
  - Like parameters of API

  In UNIX Everything is a File
  - In UNIX everything is a stream of bytes
  - In UNIX the filesystem is used as a universal name space

Ideally, I'd like to achieve these five Goals:

=over 2

=item * Goal #1:

Old byte-oriented programs should not spontaneously break on the old
byte-oriented data they used to work on.

This goal has been achieved by that this software is additional code
for perl like utf8 pragma. Perl should work same as past Perl if added
nothing.

=item * Goal #2:

Old byte-oriented programs should magically start working on the new
character-oriented data when appropriate.

Still now, 1 octet is counted with 1 by built-in functions length,
substr, index, rindex, and pos that handle length and position of string.
In this part, there is no change. The length of 1 character of 2 octet
code is 2.

On the other hand, the regular expression in the script is added the
multibyte anchoring processing with this software, instead of you.

figure of Goal #1 and Goal #2.

                               GOAL#1  GOAL#2
                        (a)     (b)     (c)     (d)     (e)
      +--------------+-------+-------+-------+-------+-------+
      | data         |  Old  |  Old  |  New  |  Old  |  New  |
      +--------------+-------+-------+-------+-------+-------+
      | script       |  Old  |      Old      |      New      |
      +--------------+-------+---------------+---------------+
      | interpreter  |  Old  |              New              |
      +--------------+-------+-------------------------------+
      Old --- Old byte-oriented
      New --- New character-oriented

There is a combination from (a) to (e) in data, script, and interpreter
of old and new. Let's add the Encode module and this software did not
exist at time of be written this document and JPerl did exist.

                        (a)     (b)     (c)     (d)     (e)
                                      JPerl,japerl    Encode,Char::Latin2
      +--------------+-------+-------+-------+-------+-------+
      | data         |  Old  |  Old  |  New  |  Old  |  New  |
      +--------------+-------+-------+-------+-------+-------+
      | script       |  Old  |      Old      |      New      |
      +--------------+-------+---------------+---------------+
      | interpreter  |  Old  |              New              |
      +--------------+-------+-------------------------------+
      Old --- Old byte-oriented
      New --- New character-oriented

The reason why JPerl is very excellent is that it is at the position of
(c). That is, it is not necessary to do a special description to the
script to process new character-oriented string.

=item * Goal #3:

Programs should run just as fast in the new character-oriented mode
as in the old byte-oriented mode.

It is impossible. Because the following time is necessary.

(1) Time of escape script for old byte-oriented perl.

Someday, I want to ask Larry Wall about this goal in the elevator.

=item * Goal #4:

Perl should remain one language, rather than forking into a
byte-oriented Perl and a character-oriented Perl.

JPerl remains one Perl language by forking to two interpreters.
However, the Perl core team did not desire fork of the interpreter.
As a result, Perl language forked contrary to goal #4.

A character-oriented perl is not necessary to make it specially,
because a byte-oriented perl can already treat the binary data.
This software is only an application program of byte-oriented Perl,
a filter program.

And you will get support from the Perl community, when you solve the
problem by the Perl script.

Char::Latin2 software remains one language and one interpreter.

=item * Goal #5:

JPerl users will be able to maintain JPerl by Perl.

May the JPerl be with you, always.

=back

Back when Programming Perl, 3rd ed. was written, UTF8 flag was not born
and Perl is designed to make the easy jobs easy. This software provide
programming environment like at that time.

=head1 Perl's motto

   Some computer scientists (the reductionists, in particular) would
  like to deny it, but people have funny-shaped minds. Mental geography
  is not linear, and cannot be mapped onto a flat surface without
  severe distortion. But for the last score years or so, computer
  reductionists have been first bowing down at the Temple of Orthogonality,
  then rising up to preach their ideas of ascetic rectitude to any who
  would listen.
 
   Their fervent but misguided desire was simply to squash your mind to
  fit their mindset, to smush your patterns of thought into some sort of
  Hyperdimensional Flatland. It's a joyless existence, being smushed.
  --- Learning Perl on Win32 Systems

  If you think this is a big headache, you're right. No one likes
  this situation, but Perl does the best it can with the input and
  encodings it has to deal with. If only we could reset history and
  not make so many mistakes next time.
  --- Learning Perl 6th Edition

   The most important thing for most people to know about handling
  Unicode data in Perl, however, is that if you don't ever use any Uni-
  code data -- if none of your files are marked as UTF-8 and you don't
  use UTF-8 locales -- then you can happily pretend that you're back in
  Perl 5.005_03 land; the Unicode features will in no way interfere with
  your code unless you're explicitly using them. Sometimes the twin
  goals of embracing Unicode but not disturbing old-style byte-oriented
  scripts has led to compromise and confusion, but it's the Perl way to
  silently do the right thing, which is what Perl ends up doing.
  --- Advanced Perl Programming, 2nd Edition

=head1 SEE ALSO

 PERL PUROGURAMINGU
 Larry Wall, Randal L.Schwartz, Yoshiyuki Kondo
 December 1997
 ISBN 4-89052-384-7
 http://www.context.co.jp/~cond/books/old-books.html

 Programming Perl, Second Edition
 By Larry Wall, Tom Christiansen, Randal L. Schwartz
 October 1996
 Pages: 670
 ISBN 10: 1-56592-149-6 | ISBN 13: 9781565921498
 http://shop.oreilly.com/product/9781565921498.do

 Programming Perl, Third Edition
 By Larry Wall, Tom Christiansen, Jon Orwant
 Third Edition  July 2000
 Pages: 1104
 ISBN 10: 0-596-00027-8 | ISBN 13: 9780596000271
 http://shop.oreilly.com/product/9780596000271.do

 The Perl Language Reference Manual (for Perl version 5.12.1)
 by Larry Wall and others
 Paperback (6"x9"), 724 pages
 Retail Price: $39.95 (pound 29.95 in UK)
 ISBN-13: 978-1-906966-02-7
 http://www.network-theory.co.uk/perl/language/

 Perl Pocket Reference, 5th Edition
 By Johan Vromans
 Publisher: O'Reilly Media
 Released: July 2011
 Pages: 102
 http://shop.oreilly.com/product/0636920018476.do

 Programming Perl, 4th Edition
 By: Tom Christiansen, brian d foy, Larry Wall, Jon Orwant
 Publisher: O'Reilly Media
 Formats: Print, Ebook, Safari Books Online
 Released: March 2012
 Pages: 1130
 Print ISBN: 978-0-596-00492-7 | ISBN 10: 0-596-00492-3
 Ebook ISBN: 978-1-4493-9890-3 | ISBN 10: 1-4493-9890-1
 http://shop.oreilly.com/product/9780596004927.do

 Perl Cookbook
 By Tom Christiansen, Nathan Torkington
 August 1998
 Pages: 800
 ISBN 10: 1-56592-243-3 | ISBN 13: 978-1-56592-243-3
 http://shop.oreilly.com/product/9781565922433.do

 Perl Cookbook, Second Edition
 By Tom Christiansen, Nathan Torkington
 Second Edition  August 2003
 Pages: 964
 ISBN 10: 0-596-00313-7 | ISBN 13: 9780596003135
 http://shop.oreilly.com/product/9780596003135.do

 Perl in a Nutshell, Second Edition
 By Stephen Spainhour, Ellen Siever, Nathan Patwardhan
 Second Edition  June 2002
 Pages: 760
 Series: In a Nutshell
 ISBN 10: 0-596-00241-6 | ISBN 13: 9780596002411
 http://shop.oreilly.com/product/9780596002411.do

 Learning Perl on Win32 Systems
 By Randal L. Schwartz, Erik Olson, Tom Christiansen
 August 1997
 Pages: 306
 ISBN 10: 1-56592-324-3 | ISBN 13: 9781565923249
 http://shop.oreilly.com/product/9781565923249.do

 Learning Perl, Fifth Edition
 By Randal L. Schwartz, Tom Phoenix, brian d foy
 June 2008
 Pages: 352
 Print ISBN:978-0-596-52010-6 | ISBN 10: 0-596-52010-7
 Ebook ISBN:978-0-596-10316-3 | ISBN 10: 0-596-10316-6
 http://shop.oreilly.com/product/9780596520113.do

 Learning Perl, 6th Edition
 By Randal L. Schwartz, brian d foy, Tom Phoenix
 June 2011
 Pages: 390
 ISBN-10: 1449303587 | ISBN-13: 978-1449303587
 http://shop.oreilly.com/product/0636920018452.do

 Advanced Perl Programming, 2nd Edition
 By Simon Cozens
 June 2005
 Pages: 300
 ISBN-10: 0-596-00456-7 | ISBN-13: 978-0-596-00456-9
 http://shop.oreilly.com/product/9780596004569.do

 Perl RESOURCE KIT UNIX EDITION
 Futato, Irving, Jepson, Patwardhan, Siever
 ISBN 10: 1-56592-370-7
 http://shop.oreilly.com/product/9781565923706.do

 MODAN Perl NYUMON
 By Daisuke Maki
 2009/2/10
 Pages: 344
 ISBN 10: 4798119172 | ISBN 13: 978-4798119175
 http://www.seshop.com/product/detail/10250/

 Understanding Japanese Information Processing
 By Ken Lunde
 January 1900
 Pages: 470
 ISBN 10: 1-56592-043-0 | ISBN 13: 9781565920439
 http://shop.oreilly.com/product/9781565920439.do

 CJKV Information Processing
 Chinese, Japanese, Korean & Vietnamese Computing
 By Ken Lunde
 First Edition  January 1999
 Pages: 1128
 ISBN 10: 1-56592-224-7 | ISBN 13: 9781565922242
 http://shop.oreilly.com/product/9781565922242.do

 Mastering Regular Expressions, Second Edition
 By Jeffrey E. F. Friedl
 Second Edition  July 2002
 Pages: 484
 ISBN 10: 0-596-00289-0 | ISBN 13: 9780596002893
 http://shop.oreilly.com/product/9780596002893.do

 Mastering Regular Expressions, Third Edition
 By Jeffrey E. F. Friedl
 Third Edition  August 2006
 Pages: 542
 ISBN 10: 0-596-52812-4 | ISBN 13:9780596528126
 http://shop.oreilly.com/product/9780596528126.do

 Regular Expressions Cookbook
 By Jan Goyvaerts, Steven Levithan
 May 2009
 Pages: 512
 ISBN 10:0-596-52068-9 | ISBN 13: 978-0-596-52068-7
 http://shop.oreilly.com/product/9780596520694.do

 JIS KANJI JITEN
 By Kouji Shibano
 Pages: 1456
 ISBN 4-542-20129-5
 http://www.webstore.jsa.or.jp/lib/lib.asp?fn=/manual/mnl01_12.htm

 UNIX MAGAZINE
 1993 Aug
 Pages: 172
 T1008901080816 ZASSHI 08901-8
 http://ascii.asciimw.jp/books/books/detail/978-4-7561-5008-0.shtml

 LINUX NIHONGO KANKYO
 By YAMAGATA Hiroo, Stephen J. Turnbull, Craig Oda, Robert J. Bickel
 June, 2000
 Pages: 376
 ISBN 4-87311-016-5
 http://www.oreilly.co.jp/books/4873110165/

 MacPerl Power and Ease
 By Vicki Brown, Chris Nandor
 April 1998
 Pages: 350
 ISBN 10: 1881957322 | ISBN 13: 978-1881957324
 http://www.amazon.com/Macperl-Power-Ease-Vicki-Brown/dp/1881957322

 Windows NT Shell Scripting
 By Timothy Hill
 April 27, 1998
 Pages: 400
 ISBN 10: 1578700477 | ISBN 13: 9781578700479
 http://search.barnesandnoble.com/Windows-NT-Shell-Scripting/Timothy-Hill/e/9781578700479/

 Windows(R) Command-Line Administrators Pocket Consultant, 2nd Edition
 By William R. Stanek
 February 2009
 Pages: 594
 ISBN 10: 0-7356-2262-0 | ISBN 13: 978-0-7356-2262-3
 http://shop.oreilly.com/product/9780735622623.do

 CPAN Directory INABA Hitoshi
 http://search.cpan.org/~ina/

 BackPAN
 http://backpan.perl.org/authors/id/I/IN/INA/

 Recent Perl packages by "INABA Hitoshi"
 http://code.activestate.com/ppm/author:INABA-Hitoshi/

=head1 ACKNOWLEDGEMENTS

This software was made referring to software and the document that the
following hackers or persons had made. 
I am thankful to all persons.

 Rick Yamashita, Shift_JIS
 ttp://furukawablog.spaces.live.com/Blog/cns!1pmWgsL289nm7Shn7cS0jHzA!2225.entry (dead link)
 ttp://shino.tumblr.com/post/116166805/1981-us-jis
 (add 'h' at head)
 http://www.wdic.org/w/WDIC/%E3%82%B7%E3%83%95%E3%83%88JIS

 Larry Wall, Perl
 http://www.perl.org/

 Kazumasa Utashiro, jcode.pl
 ftp://ftp.iij.ad.jp/pub/IIJ/dist/utashiro/perl/
 http://log.utashiro.com/pub/2006/07/jkondo_a580.html

 Jeffrey E. F. Friedl, Mastering Regular Expressions
 http://regex.info/

 SADAHIRO Tomoyuki, The right way of using Shift_JIS
 http://homepage1.nifty.com/nomenclator/perl/shiftjis.htm
 http://search.cpan.org/~sadahiro/

 Yukihiro "Matz" Matsumoto, YAPC::Asia2006 Ruby on Perl(s)
 http://www.rubyist.net/~matz/slides/yapc2006/

 jscripter, For jperl users
 http://homepage1.nifty.com/kazuf/jperl.html

 Bruce., Unicode in Perl
 http://www.rakunet.org/tsnet/TSabc/18/546.html

 Hiroaki Izumi, Perl5.8/Perl5.10 is not useful on the Windows.
 http://dl.dropbox.com/u/23756062/perlwin.html
 https://sites.google.com/site/hiroa63iz/perlwin

 TSUKAMOTO Makio, Perl memo/file path of Windows
 http://digit.que.ne.jp/work/wiki.cgi?Perl%E3%83%A1%E3%83%A2%2FWindows%E3%81%A7%E3%81%AE%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%83%91%E3%82%B9

 chaichanPaPa, Matching Shift_JIS file name
 http://d.hatena.ne.jp/chaichanPaPa/20080802/1217660826

 SUZUKI Norio, Jperl
 http://homepage2.nifty.com/kipp/perl/jperl/

 WATANABE Hirofumi, Jperl
 http://www.cpan.org/src/5.0/jperl/
 http://search.cpan.org/~watanabe/
 ftp://ftp.oreilly.co.jp/pcjp98/watanabe/jperlconf.ppt

 Chuck Houpt, Michiko Nozu, MacJPerl
 http://habilis.net/macjperl/index.j.html

 Kenichi Ishigaki, Pod-PerldocJp, Welcome to modern Perl world
 http://search.cpan.org/dist/Pod-PerldocJp/
 http://gihyo.jp/dev/serial/01/modern-perl/0031
 http://gihyo.jp/dev/serial/01/modern-perl/0032
 http://gihyo.jp/dev/serial/01/modern-perl/0033

 Fuji, Goro (gfx), Perl Hackers Hub No.16
 http://gihyo.jp/dev/serial/01/perl-hackers-hub/001602

 Dan Kogai, Encode module
 http://search.cpan.org/dist/Encode/
 http://www.archive.org/details/YAPCAsia2006TokyoPerl58andUnicodeMythsFactsandChanges (video)
 http://yapc.g.hatena.ne.jp/jkondo/ (audio)

 Takahashi Masatuyo, JPerl Wiki
 http://ja.jperl.wikia.com/wiki/JPerl_Wiki

 Juerd, Perl Unicode Advice
 http://juerd.nl/site.plp/perluniadvice

 daily dayflower, 2008-06-25 perluniadvice
 http://d.hatena.ne.jp/dayflower/20080625/1214374293

 Jesse Vincent, Compatibility is a virtue
 http://www.nntp.perl.org/group/perl.perl5.porters/2010/05/msg159825.html

 Tokyo-pm archive
 http://mail.pm.org/pipermail/tokyo-pm/
 http://mail.pm.org/pipermail/tokyo-pm/1999-September/001844.html
 http://mail.pm.org/pipermail/tokyo-pm/1999-September/001854.html

 Error: Runtime exception on jperl 5.005_03
 http://www.rakunet.org/tsnet/TSperl/12/374.html
 http://www.rakunet.org/tsnet/TSperl/12/375.html
 http://www.rakunet.org/tsnet/TSperl/12/376.html
 http://www.rakunet.org/tsnet/TSperl/12/377.html
 http://www.rakunet.org/tsnet/TSperl/12/378.html
 http://www.rakunet.org/tsnet/TSperl/12/379.html
 http://www.rakunet.org/tsnet/TSperl/12/380.html
 http://www.rakunet.org/tsnet/TSperl/12/382.html

 ruby-list
 http://blade.nagaokaut.ac.jp/ruby/ruby-list/index.shtml
 http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/2440
 http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/2446
 http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/2569
 http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/9427
 http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/9431
 http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/10500
 http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/10501
 http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/10502
 http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/12385
 http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/12392
 http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/12393
 http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/19156

 Object-oriented with Perl
 http://www.freeml.com/perl-oo/486
 http://www.freeml.com/perl-oo/487
 http://www.freeml.com/perl-oo/490
 http://www.freeml.com/perl-oo/491
 http://www.freeml.com/perl-oo/492
 http://www.freeml.com/perl-oo/494
 http://www.freeml.com/perl-oo/514

=cut

# Did you fun enough? ^o^)
