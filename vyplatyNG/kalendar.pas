unit kalendar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    kalendarDBGrid: TDBGrid;
    Button1: TButton;
    FromLabel: TLabel;
    ToLabel: TLabel;
    Memo1: TMemo;
    toDateTimePicker: TDateTimePicker;
    fromDateTimePicker: TDateTimePicker;
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
