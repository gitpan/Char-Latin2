@echo off
rem version 1.0.7
rem ======================================================================
rem 
rem  sperl512 - execute perlscript on Strawbery Perl 5.8 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%SPERL512BIN%" == "" goto SetWin95
  %SPERL512BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET SPERL512BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET SPERL512BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable SPERL512BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=Z:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist Y:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=Y:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist X:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=X:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist W:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=W:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist V:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=V:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist U:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=U:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist T:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=T:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist S:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=S:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist R:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=R:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist Q:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=Q:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist P:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=P:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist O:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=O:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist N:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=N:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist M:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=M:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist L:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=L:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist K:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=K:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist J:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=J:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist I:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=I:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist H:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=H:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist G:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=G:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist F:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=F:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist E:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=E:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist D:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=D:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$
  if exist C:\strawberry\Perl512\bin\perl.exe echo SET SPERL512BIN=C:\strawberry\Perl512\bin\perl.exe>SPERL512BIN.$$$

  if exist SPERL512BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl512\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable SPERL512BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type SPERL512BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  type SPERL512BIN.$$$ >> C:\AUTOEXEC.BAT
  del SPERL512BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable SPERL512BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%SPERL512BIN%" == "" goto SetWinNT
  %SPERL512BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="Z:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist Y:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="Y:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist X:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="X:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist W:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="W:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist V:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="V:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist U:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="U:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist T:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="T:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist S:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="S:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist R:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="R:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist Q:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="Q:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist P:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="P:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist O:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="O:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist N:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="N:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist M:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="M:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist L:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="L:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist K:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="K:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist J:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="J:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist I:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="I:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist H:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="H:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist G:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="G:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist F:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="F:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist E:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="E:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist D:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="D:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$
  if exist C:\strawberry\Perl512\bin\perl.exe echo "SPERL512BIN"="C:\\strawberry\\Perl512\\bin\\perl.exe">SPERL512BIN.$$$

  if exist SPERL512BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl512\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable SPERL512BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type SPERL512BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>SPERL512BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>SPERL512BIN.REG
  echo.>>SPERL512BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>SPERL512BIN.REG
  type SPERL512BIN.$$$ >> SPERL512BIN.REG
  SPERL512BIN.REG
  del SPERL512BIN.REG
  del SPERL512BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable SPERL512BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

sperl512 - execute perlscript on Strawbery Perl 5.8 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<sperl512> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl5.12 and other version of perl are on the one
computer. Do not set perl5.12's bin directory to %PATH%.

It is necessary to install perl5.12 in "\Perl512\bin" directory of the drive of
either. This software is executed by perl5.12, and find the perl5.12 and execute it.

 Find perl5.12 order by,
     Z:\strawberry\Perl512\bin\perl.exe
     Y:\strawberry\Perl512\bin\perl.exe
     X:\strawberry\Perl512\bin\perl.exe
                 :
                 :
     C:\strawberry\Perl512\bin\perl.exe

When found it at last, set its path to environment variable SPERL512BIN.

=head1 EXAMPLES

    C:\> sperl512 foo.pl
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

Strawberry Perl
http://strawberryperl.com/

=cut

:END
