unit kalendar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, StdCtrls;

type
  TForm1 = class(TForm)
    kalendarDBGrid: TDBGrid;
    Button1: TButton;
    FromYearEdit: TEdit;
    FromLabel: TLabel;
    ToLabel: TLabel;
    ToYearEdit: TEdit;
    Memo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses dtgDM;

{$R *.DFM}

end.
