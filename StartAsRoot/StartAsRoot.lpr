program StartAsRoot;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, Process, Sysutils;

  var
    ExeFile: string;
    RootProcess: TProcess;
  begin
    //ExeFile:='/home/marsik/lmgui/project';
    ExeFile:= ExpandFileName(ParamStr(0)) + 'project';
    RootProcess := TProcess.Create(nil);
    with RootProcess do
    begin
    Executable := '/usr/bin/sh';  //sh или xterm
    Parameters.Add('-c');
      Parameters.Add(
        'if [[ "$EUID" != "0" ]] ; then pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY ' +
        '"' + ExeFile + '"' +  '"$@"; exit $?; fi; ' + '"' + ExeFile + '"');
      Options := Options + [poWaitOnExit];
  {   Executable:= 'pkexec';
      Environment.Add('DISPLAY=$DISPLAY');
      Environment.Add('XAUTHORITY=$XAUTHORITY');
      Parameters.Add('"' + ExeFile + '"' +  '"$@"; exit $?; fi; ' + '"' + ExeFile + '"');  }

      Execute;
      Free;
    end;

end.
