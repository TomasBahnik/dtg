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
  week: Word = 1; //global variable can be initialized
  startWeek : Word = 1;
  STD_NUM_OF_WEEKS : Word = 52;
  compareWithYear : Word = 0;
  isNewYearAfterThu : Boolean = False;

implementation

uses dtgDM;
{$R *.DFM}

type
   TAfterThursday = set of Byte;
var
   AfterThursday : TAfterThursday = [5,6,7,1];

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

function afterThu(day : TDateTime) : Boolean;
   begin
      Result := (DayOfWeek(day) in AfterThursday);
   end;

// assumes that generation starts at the begining of year i.e. 1.1.YYYY
function getTyden(den: TDateTime): Integer;
var
  myYear, myMonth, myDay : Word;
  newYear : TDateTime;
begin
  DecodeDate(den, myYear, myMonth, myDay);
  if (myYear = compareWithYear) then begin
        if (DayOfWeek(den) = 2) then begin
             // in the next command else is used, Result inside begin end does not return
             if (week = STD_NUM_OF_WEEKS) AND (isNewYearAfterThu) then week := 0;
             if (week > STD_NUM_OF_WEEKS) then week := 1 else week := week + 1;
             Result := week; // reurns value assigned in the last command
             end else
             Result := week;
      end else
      begin
        //new year
        compareWithYear := myYear;
        newYear := EncodeDate(compareWithYear,1,1);
        isNewYearAfterThu := afterThu(newYear);
        if (NOT afterThu(den)) OR (DayOfWeek(den) = 2) then week := 1;
        Result := week;
     end;
end;

procedure TForm1.AddClick(Sender: TObject);
 var
  fromDate,toDate,aDate : TDate;
  numOfDays,i     : Integer;
  myYear, myMonth, myDay : Word;
  newYear : TDateTime;
 begin
   toDate := toDateTimePicker.Date;
   fromDate := fromDateTimePicker.Date;
   numOfDays := Trunc(toDate - fromDate);
   DecodeDate(fromDate, myYear, myMonth, myDay);
   compareWithYear := myYear;
   newYear := EncodeDate(compareWithYear,1,1);
   isNewYearAfterThu := afterThu(newYear);
   week := startWeek;
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
