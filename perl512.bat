@echo off
rem version 1.0.5
rem ======================================================================
rem 
rem  perl512 -  execute perlscript on the perl5.12 without %PATH% settings
rem 
rem  Copyright (c) 2008, 2009 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%PERL512BIN%" == "" goto SetWin95
  %PERL512BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET PERL512BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET PERL512BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable PERL512BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\Perl512\bin\perl.exe echo SET PERL512BIN=Z:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist Y:\Perl512\bin\perl.exe echo SET PERL512BIN=Y:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist X:\Perl512\bin\perl.exe echo SET PERL512BIN=X:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist W:\Perl512\bin\perl.exe echo SET PERL512BIN=W:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist V:\Perl512\bin\perl.exe echo SET PERL512BIN=V:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist U:\Perl512\bin\perl.exe echo SET PERL512BIN=U:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist T:\Perl512\bin\perl.exe echo SET PERL512BIN=T:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist S:\Perl512\bin\perl.exe echo SET PERL512BIN=S:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist R:\Perl512\bin\perl.exe echo SET PERL512BIN=R:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist Q:\Perl512\bin\perl.exe echo SET PERL512BIN=Q:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist P:\Perl512\bin\perl.exe echo SET PERL512BIN=P:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist O:\Perl512\bin\perl.exe echo SET PERL512BIN=O:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist N:\Perl512\bin\perl.exe echo SET PERL512BIN=N:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist M:\Perl512\bin\perl.exe echo SET PERL512BIN=M:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist L:\Perl512\bin\perl.exe echo SET PERL512BIN=L:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist K:\Perl512\bin\perl.exe echo SET PERL512BIN=K:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist J:\Perl512\bin\perl.exe echo SET PERL512BIN=J:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist I:\Perl512\bin\perl.exe echo SET PERL512BIN=I:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist H:\Perl512\bin\perl.exe echo SET PERL512BIN=H:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist G:\Perl512\bin\perl.exe echo SET PERL512BIN=G:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist F:\Perl512\bin\perl.exe echo SET PERL512BIN=F:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist E:\Perl512\bin\perl.exe echo SET PERL512BIN=E:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist D:\Perl512\bin\perl.exe echo SET PERL512BIN=D:\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist C:\Perl512\bin\perl.exe echo SET PERL512BIN=C:\Perl512\bin\perl.exe>PERL512BIN.$$$

  if exist Z:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=Z:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist Y:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=Y:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist X:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=X:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist W:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=W:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist V:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=V:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist U:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=U:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist T:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=T:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist S:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=S:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist R:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=R:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist Q:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=Q:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist P:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=P:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist O:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=O:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist N:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=N:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist M:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=M:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist L:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=L:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist K:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=K:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist J:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=J:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist I:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=I:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist H:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=H:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist G:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=G:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist F:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=F:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist E:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=E:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist D:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=D:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$
  if exist C:\strawberry\Perl512\bin\perl.exe echo SET PERL512BIN=C:\strawberry\Perl512\bin\perl.exe>PERL512BIN.$$$

  if exist PERL512BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl512\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable PERL512BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type PERL512BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  type PERL512BIN.$$$ >> C:\AUTOEXEC.BAT
  del PERL512BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL512BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%PERL512BIN%" == "" goto SetWinNT
  %PERL512BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\Perl512\bin\perl.exe echo "PERL512BIN"="Z:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist Y:\Perl512\bin\perl.exe echo "PERL512BIN"="Y:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist X:\Perl512\bin\perl.exe echo "PERL512BIN"="X:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist W:\Perl512\bin\perl.exe echo "PERL512BIN"="W:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist V:\Perl512\bin\perl.exe echo "PERL512BIN"="V:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist U:\Perl512\bin\perl.exe echo "PERL512BIN"="U:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist T:\Perl512\bin\perl.exe echo "PERL512BIN"="T:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist S:\Perl512\bin\perl.exe echo "PERL512BIN"="S:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist R:\Perl512\bin\perl.exe echo "PERL512BIN"="R:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist Q:\Perl512\bin\perl.exe echo "PERL512BIN"="Q:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist P:\Perl512\bin\perl.exe echo "PERL512BIN"="P:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist O:\Perl512\bin\perl.exe echo "PERL512BIN"="O:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist N:\Perl512\bin\perl.exe echo "PERL512BIN"="N:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist M:\Perl512\bin\perl.exe echo "PERL512BIN"="M:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist L:\Perl512\bin\perl.exe echo "PERL512BIN"="L:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist K:\Perl512\bin\perl.exe echo "PERL512BIN"="K:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist J:\Perl512\bin\perl.exe echo "PERL512BIN"="J:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist I:\Perl512\bin\perl.exe echo "PERL512BIN"="I:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist H:\Perl512\bin\perl.exe echo "PERL512BIN"="H:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist G:\Perl512\bin\perl.exe echo "PERL512BIN"="G:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist F:\Perl512\bin\perl.exe echo "PERL512BIN"="F:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist E:\Perl512\bin\perl.exe echo "PERL512BIN"="E:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist D:\Perl512\bin\perl.exe echo "PERL512BIN"="D:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist C:\Perl512\bin\perl.exe echo "PERL512BIN"="C:\\Perl512\\bin\\perl.exe">PERL512BIN.$$$

  if exist Z:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="Z:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist Y:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="Y:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist X:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="X:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist W:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="W:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist V:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="V:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist U:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="U:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist T:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="T:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist S:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="S:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist R:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="R:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist Q:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="Q:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist P:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="P:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist O:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="O:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist N:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="N:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist M:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="M:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist L:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="L:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist K:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="K:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist J:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="J:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist I:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="I:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist H:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="H:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist G:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="G:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist F:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="F:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist E:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="E:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist D:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="D:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$
  if exist C:\strawberry\Perl512\bin\perl.exe echo "PERL512BIN"="C:\\strawberry\\Perl512\\bin\\perl.exe">PERL512BIN.$$$

  if exist PERL512BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl512\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable PERL512BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type PERL512BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>PERL512BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>PERL512BIN.REG
  echo.>>PERL512BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>PERL512BIN.REG
  type PERL512BIN.$$$ >> PERL512BIN.REG
  PERL512BIN.REG
  del PERL512BIN.REG
  del PERL512BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL512BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

perl512 - execute perlscript on the perl5.12 without %PATH% settings

=head1 SYNOPSIS

B<perl512> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl5.12 and other version of perl are on the one
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

     Z:\strawberry\Perl512\bin\perl.exe
     Y:\strawberry\Perl512\bin\perl.exe
     X:\strawberry\Perl512\bin\perl.exe
                 :
                 :
     C:\strawberry\Perl512\bin\perl.exe

When found it at last, set its path to environment variable PERL512BIN.

=head1 EXAMPLES

    C:\> perl512 foo.pl
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

perl

=cut

:END
