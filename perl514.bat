@echo off
rem version 1.0.5
rem ======================================================================
rem 
rem  perl514 -  execute perlscript on the perl5.14 without %PATH% settings
rem 
rem  Copyright (c) 2008, 2009 INABA Hitoshi (ina@cpan.org)
rem 
rem ======================================================================

if "%OS%" == "Windows_NT" goto WinNT

:Win95
  if "%PERL514BIN%" == "" goto SetWin95
  %PERL514BIN% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto END

:SetWin95
  if not exist C:\AUTOEXEC.BAT goto L1
  type C:\AUTOEXEC.BAT | find "SET PERL514BIN=" > nul
  if not %ERRORLEVEL% == 0 goto L1
  echo -----------------------------------------------------------
  echo Description "SET PERL514BIN=" already exists in C:\AUTOEXEC.BAT.
  echo Reboot computer to enable PERL514BIN, and try again.
  echo -----------------------------------------------------------
goto END

:L1
  if exist Z:\Perl514\bin\perl.exe echo SET PERL514BIN=Z:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist Y:\Perl514\bin\perl.exe echo SET PERL514BIN=Y:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist X:\Perl514\bin\perl.exe echo SET PERL514BIN=X:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist W:\Perl514\bin\perl.exe echo SET PERL514BIN=W:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist V:\Perl514\bin\perl.exe echo SET PERL514BIN=V:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist U:\Perl514\bin\perl.exe echo SET PERL514BIN=U:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist T:\Perl514\bin\perl.exe echo SET PERL514BIN=T:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist S:\Perl514\bin\perl.exe echo SET PERL514BIN=S:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist R:\Perl514\bin\perl.exe echo SET PERL514BIN=R:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist Q:\Perl514\bin\perl.exe echo SET PERL514BIN=Q:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist P:\Perl514\bin\perl.exe echo SET PERL514BIN=P:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist O:\Perl514\bin\perl.exe echo SET PERL514BIN=O:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist N:\Perl514\bin\perl.exe echo SET PERL514BIN=N:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist M:\Perl514\bin\perl.exe echo SET PERL514BIN=M:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist L:\Perl514\bin\perl.exe echo SET PERL514BIN=L:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist K:\Perl514\bin\perl.exe echo SET PERL514BIN=K:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist J:\Perl514\bin\perl.exe echo SET PERL514BIN=J:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist I:\Perl514\bin\perl.exe echo SET PERL514BIN=I:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist H:\Perl514\bin\perl.exe echo SET PERL514BIN=H:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist G:\Perl514\bin\perl.exe echo SET PERL514BIN=G:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist F:\Perl514\bin\perl.exe echo SET PERL514BIN=F:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist E:\Perl514\bin\perl.exe echo SET PERL514BIN=E:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist D:\Perl514\bin\perl.exe echo SET PERL514BIN=D:\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist C:\Perl514\bin\perl.exe echo SET PERL514BIN=C:\Perl514\bin\perl.exe>PERL514BIN.$$$

  if exist Z:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=Z:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist Y:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=Y:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist X:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=X:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist W:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=W:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist V:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=V:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist U:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=U:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist T:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=T:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist S:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=S:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist R:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=R:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist Q:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=Q:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist P:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=P:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist O:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=O:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist N:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=N:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist M:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=M:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist L:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=L:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist K:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=K:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist J:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=J:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist I:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=I:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist H:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=H:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist G:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=G:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist F:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=F:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist E:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=E:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist D:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=D:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$
  if exist C:\strawberry\Perl514\bin\perl.exe echo SET PERL514BIN=C:\strawberry\Perl514\bin\perl.exe>PERL514BIN.$$$

  if exist PERL514BIN.$$$ goto L2

  echo ***********************************************************
  echo "\Perl514\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L2
  echo ***********************************************************
  echo Environment variable PERL514BIN not set.
  echo Do you add following description to C:\AUTOEXEC.BAT?
  echo 
  type PERL514BIN.$$$
  echo 
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  type PERL514BIN.$$$ >> C:\AUTOEXEC.BAT
  del PERL514BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL514BIN, and try again.
  echo -----------------------------------------------------------
goto END

:WinNT
  if "%PERL514BIN%" == "" goto SetWinNT
  %PERL514BIN% %*
  exit /b %ERRORLEVEL%
goto END

:SetWinNT
  if exist Z:\Perl514\bin\perl.exe echo "PERL514BIN"="Z:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist Y:\Perl514\bin\perl.exe echo "PERL514BIN"="Y:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist X:\Perl514\bin\perl.exe echo "PERL514BIN"="X:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist W:\Perl514\bin\perl.exe echo "PERL514BIN"="W:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist V:\Perl514\bin\perl.exe echo "PERL514BIN"="V:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist U:\Perl514\bin\perl.exe echo "PERL514BIN"="U:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist T:\Perl514\bin\perl.exe echo "PERL514BIN"="T:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist S:\Perl514\bin\perl.exe echo "PERL514BIN"="S:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist R:\Perl514\bin\perl.exe echo "PERL514BIN"="R:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist Q:\Perl514\bin\perl.exe echo "PERL514BIN"="Q:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist P:\Perl514\bin\perl.exe echo "PERL514BIN"="P:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist O:\Perl514\bin\perl.exe echo "PERL514BIN"="O:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist N:\Perl514\bin\perl.exe echo "PERL514BIN"="N:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist M:\Perl514\bin\perl.exe echo "PERL514BIN"="M:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist L:\Perl514\bin\perl.exe echo "PERL514BIN"="L:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist K:\Perl514\bin\perl.exe echo "PERL514BIN"="K:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist J:\Perl514\bin\perl.exe echo "PERL514BIN"="J:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist I:\Perl514\bin\perl.exe echo "PERL514BIN"="I:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist H:\Perl514\bin\perl.exe echo "PERL514BIN"="H:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist G:\Perl514\bin\perl.exe echo "PERL514BIN"="G:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist F:\Perl514\bin\perl.exe echo "PERL514BIN"="F:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist E:\Perl514\bin\perl.exe echo "PERL514BIN"="E:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist D:\Perl514\bin\perl.exe echo "PERL514BIN"="D:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist C:\Perl514\bin\perl.exe echo "PERL514BIN"="C:\\Perl514\\bin\\perl.exe">PERL514BIN.$$$

  if exist Z:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="Z:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist Y:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="Y:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist X:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="X:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist W:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="W:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist V:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="V:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist U:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="U:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist T:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="T:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist S:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="S:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist R:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="R:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist Q:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="Q:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist P:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="P:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist O:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="O:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist N:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="N:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist M:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="M:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist L:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="L:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist K:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="K:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist J:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="J:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist I:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="I:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist H:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="H:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist G:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="G:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist F:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="F:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist E:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="E:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist D:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="D:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$
  if exist C:\strawberry\Perl514\bin\perl.exe echo "PERL514BIN"="C:\\strawberry\\Perl514\\bin\\perl.exe">PERL514BIN.$$$

  if exist PERL514BIN.$$$ goto L3

  echo ***********************************************************
  echo "\Perl514\bin\perl.exe" not found in C: to Z: drives.
  echo ***********************************************************
goto END

:L3
  echo ***********************************************************
  echo Environment variable PERL514BIN not set.
  echo Do you set following registry?
  echo.
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
  type PERL514BIN.$$$
  echo.
  echo Press [Enter] to Yes continue, or [Ctrl]+[C] to No, quit.
  echo ***********************************************************
  pause
  ver | find "Windows NT" > nul
  if     %ERRORLEVEL% == 0 echo REGEDIT4>PERL514BIN.REG
  if not %ERRORLEVEL% == 0 echo Windows Registry Editor Version 5.00>PERL514BIN.REG
  echo.>>PERL514BIN.REG
  echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]>>PERL514BIN.REG
  type PERL514BIN.$$$ >> PERL514BIN.REG
  PERL514BIN.REG
  del PERL514BIN.REG
  del PERL514BIN.$$$
  echo -----------------------------------------------------------
  echo Reboot computer to enable PERL514BIN, and try again.
  echo -----------------------------------------------------------
goto END

The world wants practical solutions anytime.

=pod

=head1 NAME

perl514 - execute perlscript on the perl5.14 without %PATH% settings

=head1 SYNOPSIS

B<perl514> [perlscript.pl]

=head1 DESCRIPTION

This software is useful when perl5.14 and other version of perl are on the one
computer. Do not set perl5.14's bin directory to %PATH%.

It is necessary to install perl5.14 in "\Perl514\bin" directory of the drive of
either. This software is executed by perl5.14, and find the perl5.14 and execute it.

 Find perl5.14 order by,
     Z:\Perl514\bin\perl.exe
     Y:\Perl514\bin\perl.exe
     X:\Perl514\bin\perl.exe
                 :
                 :
     C:\Perl514\bin\perl.exe

     Z:\strawberry\Perl514\bin\perl.exe
     Y:\strawberry\Perl514\bin\perl.exe
     X:\strawberry\Perl514\bin\perl.exe
                 :
                 :
     C:\strawberry\Perl514\bin\perl.exe

When found it at last, set its path to environment variable PERL514BIN.

=head1 EXAMPLES

    C:\> perl514 foo.pl
    [..execute foo.pl by perl5.14..]

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
