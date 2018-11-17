program TestSQLYacc;

uses
  ShareMem,
  Forms,
  frm_tyMain in 'frm_tyMain.pas' {Form1},
  unt_ISQLTreeNode in '..\unt_ISQLTreeNode.pas',
  DGL_SQLTreeList in '..\DGL_SQLTreeList.pas',
  unt_SQLTreeAnalyzer in '..\unt_SQLTreeAnalyzer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
