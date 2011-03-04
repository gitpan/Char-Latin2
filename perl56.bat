@echo off
rem version 1.0.5
rem ======================================================================
rem 
rem  perl56 -  execute perlscript on the perl5.6 without %PATH% settings
rem 
rem  Copyright (c) 2008, 2009 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%PERL56BIN%" == "" goto SetWin95
  %PERL56BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET PERL56BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET PERL56BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable PERL56BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\Perl56\bin\perl.exe echo SET PERL56BIN=Z:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist Y:\Perl56\bin\perl.exe echo SET PERL56BIN=Y:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist X:\Perl56\bin\perl.exe echo SET PERL56BIN=X:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist W:\Perl56\bin\perl.exe echo SET PERL56BIN=W:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist V:\Perl56\bin\perl.exe echo SET PERL56BIN=V:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist U:\Perl56\bin\perl.exe echo SET PERL56BIN=U:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist T:\Perl56\bin\perl.exe echo SET PERL56BIN=T:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist S:\Perl56\bin\perl.exe echo SET PERL56BIN=S:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist R:\Perl56\bin\perl.exe echo SET PERL56BIN=R:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist Q:\Perl56\bin\perl.exe echo SET PERL56BIN=Q:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist P:\Perl56\bin\perl.exe echo SET PERL56BIN=P:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist O:\Perl56\bin\perl.exe echo SET PERL56BIN=O:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist N:\Perl56\bin\perl.exe echo SET PERL56BIN=N:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist M:\Perl56\bin\perl.exe echo SET PERL56BIN=M:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist L:\Perl56\bin\perl.exe echo SET PERL56BIN=L:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist K:\Perl56\bin\perl.exe echo SET PERL56BIN=K:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist J:\Perl56\bin\perl.exe echo SET PERL56BIN=J:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist I:\Perl56\bin\perl.exe echo SET PERL56BIN=I:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist H:\Perl56\bin\perl.exe echo SET PERL56BIN=H:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist G:\Perl56\bin\perl.exe echo SET PERL56BIN=G:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist F:\Perl56\bin\perl.exe echo SET PERL56BIN=F:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist E:\Perl56\bin\perl.exe echo SET PERL56BIN=E:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist D:\Perl56\bin\perl.exe echo SET PERL56BIN=D:\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist C:\Perl56\bin\perl.exe echo SET PERL56BIN=C:\Perl56\bin\perl.exe>PERL56BIN.$$$

  if exist Z:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=Z:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist Y:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=Y:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist X:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=X:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist W:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=W:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist V:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=V:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist U:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=U:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist T:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=T:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist S:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=S:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist R:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=R:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist Q:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=Q:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist P:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=P:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist O:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=O:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist N:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=N:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist M:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=M:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist L:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=L:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist K:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=K:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist J:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=J:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist I:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=I:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist H:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=H:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist G:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=G:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist F:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=F:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist E:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=E:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist D:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=D:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$
  if exist C:\strawberry\Perl56\bin\perl.exe echo SET PERL56BIN=C:\strawberry\Perl56\bin\perl.exe>PERL56BIN.$$$

  if exist PERL56BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl56\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable PERL56BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type PERL56BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  type PERL56BIN.$$$ >> C:\AUTOEXEC.BAT
  del PERL56BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL56BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%PERL56BIN%" == "" goto SetWinNT
  %PERL56BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\Perl56\bin\perl.exe echo "PERL56BIN"="Z:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist Y:\Perl56\bin\perl.exe echo "PERL56BIN"="Y:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist X:\Perl56\bin\perl.exe echo "PERL56BIN"="X:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist W:\Perl56\bin\perl.exe echo "PERL56BIN"="W:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist V:\Perl56\bin\perl.exe echo "PERL56BIN"="V:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist U:\Perl56\bin\perl.exe echo "PERL56BIN"="U:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist T:\Perl56\bin\perl.exe echo "PERL56BIN"="T:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist S:\Perl56\bin\perl.exe echo "PERL56BIN"="S:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist R:\Perl56\bin\perl.exe echo "PERL56BIN"="R:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist Q:\Perl56\bin\perl.exe echo "PERL56BIN"="Q:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist P:\Perl56\bin\perl.exe echo "PERL56BIN"="P:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist O:\Perl56\bin\perl.exe echo "PERL56BIN"="O:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist N:\Perl56\bin\perl.exe echo "PERL56BIN"="N:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist M:\Perl56\bin\perl.exe echo "PERL56BIN"="M:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist L:\Perl56\bin\perl.exe echo "PERL56BIN"="L:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist K:\Perl56\bin\perl.exe echo "PERL56BIN"="K:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist J:\Perl56\bin\perl.exe echo "PERL56BIN"="J:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist I:\Perl56\bin\perl.exe echo "PERL56BIN"="I:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist H:\Perl56\bin\perl.exe echo "PERL56BIN"="H:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist G:\Perl56\bin\perl.exe echo "PERL56BIN"="G:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist F:\Perl56\bin\perl.exe echo "PERL56BIN"="F:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist E:\Perl56\bin\perl.exe echo "PERL56BIN"="E:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist D:\Perl56\bin\perl.exe echo "PERL56BIN"="D:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist C:\Perl56\bin\perl.exe echo "PERL56BIN"="C:\\Perl56\\bin\\perl.exe">PERL56BIN.$$$

  if exist Z:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="Z:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist Y:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="Y:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist X:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="X:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist W:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="W:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist V:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="V:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist U:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="U:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist T:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="T:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist S:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="S:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist R:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="R:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist Q:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="Q:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist P:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="P:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist O:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="O:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist N:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="N:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist M:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="M:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist L:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="L:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist K:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="K:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist J:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="J:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist I:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="I:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist H:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="H:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist G:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="G:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist F:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="F:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist E:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="E:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist D:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="D:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$
  if exist C:\strawberry\Perl56\bin\perl.exe echo "PERL56BIN"="C:\\strawberry\\Perl56\\bin\\perl.exe">PERL56BIN.$$$

  if exist PERL56BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl56\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable PERL56BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type PERL56BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>PERL56BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>PERL56BIN.REG
  echo.>>PERL56BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>PERL56BIN.REG
  type PERL56BIN.$$$ >> PERL56BIN.REG
  PERL56BIN.REG
  del PERL56BIN.REG
  del PERL56BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL56BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

perl56 - execute perlscript on the perl5.6 without %PATH% settings

=head1 SYNOPSIS

B<perl56> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl5.6 and other version of perl are on the one
computer. Do not set perl5.6's bin directory to %PATH%.

It is necessary to install perl5.6 in "\Perl56\bin" directory of the drive of
either. This software is executed by perl5.6, and find the perl5.6 and execute it.

 Find perl5.6 order by,
     Z:\Perl56\bin\perl.exe
     Y:\Perl56\bin\perl.exe
     X:\Perl56\bin\perl.exe
                 :
                 :
     C:\Perl56\bin\perl.exe

     Z:\strawberry\Perl56\bin\perl.exe
     Y:\strawberry\Perl56\bin\perl.exe
     X:\strawberry\Perl56\bin\perl.exe
                 :
                 :
     C:\strawberry\Perl56\bin\perl.exe

When found it at last, set its path to environment variable PERL56BIN.

=head1 EXAMPLES

    C:\> perl56 foo.pl
    [..execute foo.pl by perl5.6..]

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

perl

=cut

:END
