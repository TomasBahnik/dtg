program vyplatyNG;

uses
  Forms,
  kalendar in 'kalendar.pas' {Form1},
  dtgDM in 'dtgDM.pas' {dtgDataModule: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdtgDataModule, dtgDataModule);
  Application.Run;
end.
