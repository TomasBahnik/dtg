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
    procedure AddClick(Sender: TObject);
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

// Druh Dne v kalendari
// ddDovolena = 1;
// ddPlacenySvatek = 2;
// ddPracovniDen = 3;
// ddVikend = 4;
function getDruhDne(den: TDateTime): Integer;
 var
   i, retVal : Integer;
 begin
   i := DayOfWeek(den);
   Case i of
     2 : retVal := 3; //Po
     3 : retVal := 3; //Ut
     4 : retVal := 3; //St
     5 : retVal := 3; //Ct
     6 : retVal := 3; //Pa
     7 : retVal := 4; //So
     1 : retVal := 4; //Ne
   end;
   Result := retVal;
 end;

function getTyden(den: TDateTime): Integer;
 var
   i : Integer;
 begin
   i := DayOfWeek(den);
   Result := i * i;
 end;

procedure TForm1.AddClick(Sender: TObject);
 var
  fromDate,toDate,aDate : TDate;
  numOfDays,i     : Integer;
 begin
   toDate := toDateTimePicker.Date;
   fromDate := fromDateTimePicker.Date;
   numOfDays := Trunc(toDate - fromDate);
   for i := 0 to numOfDays do
      begin
         with dtgDataModule.kalendarTbl do
           begin
              aDate := fromDate + i;
              Insert;
              FieldByName('Datum').AsDateTime := aDate;
              FieldByName('Den').AsInteger := DayOfWeek(aDate);
              FieldByName('DruhDne').AsInteger := getDruhDne(aDate);
              FieldByName('Tyden').AsInteger := getTyden(aDate);
              Post;
           end;
      end;
 end;

end.
