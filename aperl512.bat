@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  aperl512 - execute perlscript on ActivePerl 5.8 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%APERL512BIN%" == "" goto SetWin95
  %APERL512BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET APERL512BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET APERL512BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable APERL512BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\Perl512\bin\perl.exe echo SET APERL512BIN=Z:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist Y:\Perl512\bin\perl.exe echo SET APERL512BIN=Y:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist X:\Perl512\bin\perl.exe echo SET APERL512BIN=X:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist W:\Perl512\bin\perl.exe echo SET APERL512BIN=W:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist V:\Perl512\bin\perl.exe echo SET APERL512BIN=V:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist U:\Perl512\bin\perl.exe echo SET APERL512BIN=U:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist T:\Perl512\bin\perl.exe echo SET APERL512BIN=T:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist S:\Perl512\bin\perl.exe echo SET APERL512BIN=S:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist R:\Perl512\bin\perl.exe echo SET APERL512BIN=R:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist Q:\Perl512\bin\perl.exe echo SET APERL512BIN=Q:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist P:\Perl512\bin\perl.exe echo SET APERL512BIN=P:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist O:\Perl512\bin\perl.exe echo SET APERL512BIN=O:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist N:\Perl512\bin\perl.exe echo SET APERL512BIN=N:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist M:\Perl512\bin\perl.exe echo SET APERL512BIN=M:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist L:\Perl512\bin\perl.exe echo SET APERL512BIN=L:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist K:\Perl512\bin\perl.exe echo SET APERL512BIN=K:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist J:\Perl512\bin\perl.exe echo SET APERL512BIN=J:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist I:\Perl512\bin\perl.exe echo SET APERL512BIN=I:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist H:\Perl512\bin\perl.exe echo SET APERL512BIN=H:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist G:\Perl512\bin\perl.exe echo SET APERL512BIN=G:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist F:\Perl512\bin\perl.exe echo SET APERL512BIN=F:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist E:\Perl512\bin\perl.exe echo SET APERL512BIN=E:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist D:\Perl512\bin\perl.exe echo SET APERL512BIN=D:\Perl512\bin\perl.exe>APERL512BIN.$$$
  if exist C:\Perl512\bin\perl.exe echo SET APERL512BIN=C:\Perl512\bin\perl.exe>APERL512BIN.$$$

  if exist APERL512BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl512\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable APERL512BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type APERL512BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  type APERL512BIN.$$$ >> C:\AUTOEXEC.BAT
  del APERL512BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable APERL512BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%APERL512BIN%" == "" goto SetWinNT
  %APERL512BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\Perl512\bin\perl.exe echo "APERL512BIN"="Z:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist Y:\Perl512\bin\perl.exe echo "APERL512BIN"="Y:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist X:\Perl512\bin\perl.exe echo "APERL512BIN"="X:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist W:\Perl512\bin\perl.exe echo "APERL512BIN"="W:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist V:\Perl512\bin\perl.exe echo "APERL512BIN"="V:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist U:\Perl512\bin\perl.exe echo "APERL512BIN"="U:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist T:\Perl512\bin\perl.exe echo "APERL512BIN"="T:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist S:\Perl512\bin\perl.exe echo "APERL512BIN"="S:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist R:\Perl512\bin\perl.exe echo "APERL512BIN"="R:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist Q:\Perl512\bin\perl.exe echo "APERL512BIN"="Q:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist P:\Perl512\bin\perl.exe echo "APERL512BIN"="P:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist O:\Perl512\bin\perl.exe echo "APERL512BIN"="O:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist N:\Perl512\bin\perl.exe echo "APERL512BIN"="N:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist M:\Perl512\bin\perl.exe echo "APERL512BIN"="M:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist L:\Perl512\bin\perl.exe echo "APERL512BIN"="L:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist K:\Perl512\bin\perl.exe echo "APERL512BIN"="K:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist J:\Perl512\bin\perl.exe echo "APERL512BIN"="J:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist I:\Perl512\bin\perl.exe echo "APERL512BIN"="I:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist H:\Perl512\bin\perl.exe echo "APERL512BIN"="H:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist G:\Perl512\bin\perl.exe echo "APERL512BIN"="G:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist F:\Perl512\bin\perl.exe echo "APERL512BIN"="F:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist E:\Perl512\bin\perl.exe echo "APERL512BIN"="E:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist D:\Perl512\bin\perl.exe echo "APERL512BIN"="D:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$
  if exist C:\Perl512\bin\perl.exe echo "APERL512BIN"="C:\\Perl512\\bin\\perl.exe">APERL512BIN.$$$

  if exist APERL512BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl512\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable APERL512BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type APERL512BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>APERL512BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>APERL512BIN.REG
  echo.>>APERL512BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>APERL512BIN.REG
  type APERL512BIN.$$$ >> APERL512BIN.REG
  APERL512BIN.REG
  del APERL512BIN.REG
  del APERL512BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable APERL512BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

aperl512 - execute perlscript on ActivePerl 5.8 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<aperl512> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when ActivePerl 5.8 and other version of perl are on the one
computer. Do not set perl5.12's bin directory to %PATH%.

It is necessary to install perl5.12 in "\Perl512\bin" directory of the drive of
either. This software is executed by perl5.12, and find the perl5.12 and execute it.

 Find perl5.12 order by,
     Z:\Perl512\bin\perl.exe
     Y:\Perl512\bin\perl.exe
     X:\Perl512\bin\perl.exe
                 :
                 :
     C:\Perl512\bin\perl.exe

When found it at last, set its path to environment variable APERL512BIN.

=head1 EXAMPLES

    C:\> aperl512 foo.pl
    [..execute foo.pl by perl5.12..]

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

=cut

:END
