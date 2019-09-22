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
  week: Word = 0; //global variable can be initilized
  lastYear : Word = 1;
  lastWeek : Word = 53;
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
// assumes that generation starts at the begining of year i.e. 1.1.YYYY
function getTyden(den: TDateTime): Integer;
 var
  myYear, myMonth, myDay : Word;
  begin
   DecodeDate(den, myYear, myMonth, myDay);
   //if lastYear = 0 then lastYear := myYear; // start from begining of yaer
   //if (myYear = lastYear + 1) and (DayOfWeek(den) > 4) or (DayOfWeek(den) = 1)
   //then lastWeek := 53
   //else lastWeek := 52;
   if DayOfWeek(den) = 2 then week := week + 1;
   if (week = lastWeek) and (DayOfWeek(den) = 2) then week := 1;
   Result := week;
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
