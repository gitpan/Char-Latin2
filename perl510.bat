@echo off
rem version 1.0.6
rem ======================================================================
rem 
rem  perl510 - execute perlscript on the perl5.10 without %PATH% settings
rem           (poor App::perlbrew)
rem 
rem  Copyright (c) 2008, 2009, 2011, 2012 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%PERL510BIN%" == "" goto SetWin95
  %PERL510BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET PERL510BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET PERL510BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable PERL510BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\Perl510\bin\perl.exe echo SET PERL510BIN=Z:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist Y:\Perl510\bin\perl.exe echo SET PERL510BIN=Y:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist X:\Perl510\bin\perl.exe echo SET PERL510BIN=X:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist W:\Perl510\bin\perl.exe echo SET PERL510BIN=W:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist V:\Perl510\bin\perl.exe echo SET PERL510BIN=V:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist U:\Perl510\bin\perl.exe echo SET PERL510BIN=U:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist T:\Perl510\bin\perl.exe echo SET PERL510BIN=T:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist S:\Perl510\bin\perl.exe echo SET PERL510BIN=S:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist R:\Perl510\bin\perl.exe echo SET PERL510BIN=R:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist Q:\Perl510\bin\perl.exe echo SET PERL510BIN=Q:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist P:\Perl510\bin\perl.exe echo SET PERL510BIN=P:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist O:\Perl510\bin\perl.exe echo SET PERL510BIN=O:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist N:\Perl510\bin\perl.exe echo SET PERL510BIN=N:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist M:\Perl510\bin\perl.exe echo SET PERL510BIN=M:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist L:\Perl510\bin\perl.exe echo SET PERL510BIN=L:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist K:\Perl510\bin\perl.exe echo SET PERL510BIN=K:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist J:\Perl510\bin\perl.exe echo SET PERL510BIN=J:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist I:\Perl510\bin\perl.exe echo SET PERL510BIN=I:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist H:\Perl510\bin\perl.exe echo SET PERL510BIN=H:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist G:\Perl510\bin\perl.exe echo SET PERL510BIN=G:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist F:\Perl510\bin\perl.exe echo SET PERL510BIN=F:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist E:\Perl510\bin\perl.exe echo SET PERL510BIN=E:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist D:\Perl510\bin\perl.exe echo SET PERL510BIN=D:\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist C:\Perl510\bin\perl.exe echo SET PERL510BIN=C:\Perl510\bin\perl.exe>PERL510BIN.$$$

  if exist Z:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=Z:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist Y:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=Y:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist X:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=X:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist W:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=W:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist V:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=V:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist U:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=U:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist T:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=T:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist S:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=S:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist R:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=R:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist Q:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=Q:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist P:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=P:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist O:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=O:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist N:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=N:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist M:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=M:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist L:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=L:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist K:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=K:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist J:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=J:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist I:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=I:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist H:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=H:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist G:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=G:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist F:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=F:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist E:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=E:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist D:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=D:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$
  if exist C:\strawberry\Perl510\bin\perl.exe echo SET PERL510BIN=C:\strawberry\Perl510\bin\perl.exe>PERL510BIN.$$$

  if exist PERL510BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl510\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable PERL510BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type PERL510BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  type PERL510BIN.$$$ >> C:\AUTOEXEC.BAT
  del PERL510BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL510BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%PERL510BIN%" == "" goto SetWinNT
  %PERL510BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\Perl510\bin\perl.exe echo "PERL510BIN"="Z:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist Y:\Perl510\bin\perl.exe echo "PERL510BIN"="Y:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist X:\Perl510\bin\perl.exe echo "PERL510BIN"="X:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist W:\Perl510\bin\perl.exe echo "PERL510BIN"="W:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist V:\Perl510\bin\perl.exe echo "PERL510BIN"="V:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist U:\Perl510\bin\perl.exe echo "PERL510BIN"="U:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist T:\Perl510\bin\perl.exe echo "PERL510BIN"="T:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist S:\Perl510\bin\perl.exe echo "PERL510BIN"="S:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist R:\Perl510\bin\perl.exe echo "PERL510BIN"="R:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist Q:\Perl510\bin\perl.exe echo "PERL510BIN"="Q:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist P:\Perl510\bin\perl.exe echo "PERL510BIN"="P:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist O:\Perl510\bin\perl.exe echo "PERL510BIN"="O:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist N:\Perl510\bin\perl.exe echo "PERL510BIN"="N:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist M:\Perl510\bin\perl.exe echo "PERL510BIN"="M:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist L:\Perl510\bin\perl.exe echo "PERL510BIN"="L:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist K:\Perl510\bin\perl.exe echo "PERL510BIN"="K:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist J:\Perl510\bin\perl.exe echo "PERL510BIN"="J:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist I:\Perl510\bin\perl.exe echo "PERL510BIN"="I:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist H:\Perl510\bin\perl.exe echo "PERL510BIN"="H:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist G:\Perl510\bin\perl.exe echo "PERL510BIN"="G:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist F:\Perl510\bin\perl.exe echo "PERL510BIN"="F:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist E:\Perl510\bin\perl.exe echo "PERL510BIN"="E:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist D:\Perl510\bin\perl.exe echo "PERL510BIN"="D:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist C:\Perl510\bin\perl.exe echo "PERL510BIN"="C:\\Perl510\\bin\\perl.exe">PERL510BIN.$$$

  if exist Z:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="Z:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist Y:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="Y:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist X:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="X:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist W:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="W:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist V:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="V:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist U:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="U:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist T:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="T:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist S:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="S:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist R:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="R:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist Q:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="Q:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist P:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="P:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist O:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="O:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist N:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="N:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist M:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="M:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist L:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="L:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist K:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="K:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist J:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="J:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist I:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="I:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist H:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="H:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist G:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="G:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist F:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="F:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist E:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="E:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist D:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="D:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$
  if exist C:\strawberry\Perl510\bin\perl.exe echo "PERL510BIN"="C:\\strawberry\\Perl510\\bin\\perl.exe">PERL510BIN.$$$

  if exist PERL510BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl510\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable PERL510BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type PERL510BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>PERL510BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>PERL510BIN.REG
  echo.>>PERL510BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>PERL510BIN.REG
  type PERL510BIN.$$$ >> PERL510BIN.REG
  PERL510BIN.REG
  del PERL510BIN.REG
  del PERL510BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL510BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

perl510 - execute perlscript on the perl5.10 without %PATH% settings (poor App::perlbrew)

=head1 SYNOPSIS

B<perl510> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl5.10 and other version of perl are on the one
computer. Do not set perl5.10's bin directory to %PATH%.

It is necessary to install perl5.10 in "\Perl510\bin" directory of the drive of
either. This software is executed by perl5.10, and find the perl5.10 and execute it.

 Find perl5.10 order by,
     Z:\Perl510\bin\perl.exe
     Y:\Perl510\bin\perl.exe
     X:\Perl510\bin\perl.exe
                 :
                 :
     C:\Perl510\bin\perl.exe

     Z:\strawberry\Perl510\bin\perl.exe
     Y:\strawberry\Perl510\bin\perl.exe
     X:\strawberry\Perl510\bin\perl.exe
                 :
                 :
     C:\strawberry\Perl510\bin\perl.exe

When found it at last, set its path to environment variable PERL510BIN.

=head1 EXAMPLES

    C:\> perl510 foo.pl
    [..execute foo.pl by perl5.10..]

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
