program StartAsRoot;

{$mode objfpc}{$H+}

uses {$IFDEF UNIX} {$IFDEF UseCThreads}
  cthreads, {$ENDIF} {$ENDIF}
  Process,
  SysUtils,
  IniFiles;

var
  Ini: TIniFile;
  StartFileName: string;
  RootProcess: TProcess;

begin
  try
    Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'StartAsRoot.ini');
    StartFileName := INI.ReadString('config', 'StartFileName', '');
    StartFileName := Concat(ExtractFilePath(ParamStr(0)), StartFileName);
    INI.WriteString('config', 'UserName', GetEnvironmentVariable('USER'));

    RootProcess := TProcess.Create(nil);
    with RootProcess do
    begin
      Executable := 'sh';
      Parameters.Add('-c');
      Parameters.Add(
        'if [[ "$EUID" != "0" ]] ; then pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY '
        + '"' + StartFileName + '"' + ' "$@"; exit $?; fi; ' + '"' +
        StartFileName + '"');
      Options := Options + [poWaitOnExit];
      Execute;
    end;

  finally
    RootProcess.Free;
    INI.Free;
  end;
end.
