@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  perl5 - execute perlscript on ActivePerl 5.X or Strawbery Perl 5.X without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
rem select any one
rem %APERL55BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
rem %APERL56BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
rem %APERL58BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
rem %APERL510BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
rem %APERL512BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
    %APERL514BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
rem %APERL516BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
rem %APERL518BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
rem %SPERL58BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
rem %SPERL510BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
rem %SPERL512BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
rem %SPERL514BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
rem %SPERL516BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
rem %SPERL518BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:WinNT
rem select any one
rem %APERL55BIN% %*
rem %APERL56BIN% %*
rem %APERL58BIN% %*
rem %APERL510BIN% %*
rem %APERL512BIN% %*
    %APERL514BIN% %*
rem %APERL516BIN% %*
rem %APERL518BIN% %*
rem %SPERL58BIN% %*
rem %SPERL510BIN% %*
rem %SPERL512BIN% %*
rem %SPERL514BIN% %*
rem %SPERL516BIN% %*
rem %SPERL518BIN% %*
exit /b %ERRORLEVEL%
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

perl5 - execute perlscript on ActivePerl 5.X or Strawbery Perl 5.X without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<perl5> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl5 and other version of perl are on the one
computer. Do not set perl5's bin directory to %PATH%.

It is necessary to install perl5 in "\Perl5xx\bin" directory of the drive of
either. This software is executed by perl5, and find the perl5 and execute it.

=head1 EXAMPLES

    C:\> perl5 foo.pl
    [..execute foo.pl by perl5..]

=head1 BUGS AND LIMITATIONS

Please patches and report problems to author are welcome.

=head1 AUTHOR

INABA Hitoshi E<lt>ina@cpan.orgE<gt>

This project was originated by INABA Hitoshi.
For any questions, use E<lt>ina@cpan.orgE<gt> so we can share
this file.

=head1 LICENSE AND COPYRIGHT

This software is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

This software is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=head1 SEE ALSO

ActivePerl
http://www.activestate.com/activeperl

Strawberry Perl
http://strawberryperl.com/

=cut

:END
