unit dtgDM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db;

type
  TdtgDataModule = class(TDataModule)
    vyplatyDB: TDatabase;
    kalendarTbl: TTable;
    kalendarQuery: TQuery;
    kalendarTblDS: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtgDataModule: TdtgDataModule;

implementation

{$R *.DFM}

end.
