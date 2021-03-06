unit AsyncIO.Net.IP.Detail;

interface

uses
  IdWinsock2, AsyncIO, AsyncIO.ErrorCodes, AsyncIO.Detail, AsyncIO.Net.IP;

const
//#define SO_UPDATE_CONNECT_CONTEXT   0x7010
  SO_UPDATE_CONNECT_CONTEXT = $7010;

type
  IPSocketAccess = interface
    ['{05B1639C-2E59-4174-B18B-43E2B40F1E50}']
    procedure Assign(const Protocol: IPProtocol; const SocketHandle: TSocket);
  end;

procedure IPSocketAssign(const Socket: IPSocket; const Protocol: IPProtocol; const SocketHandle: TSocket);

type
  AsyncSocketStreamImpl = class(AsyncStreamImplBase, AsyncSocketStream)
  private
    FSocket: IPStreamSocket;
  public
    constructor Create(const Socket: IPStreamSocket);
    destructor Destroy; override;

    function GetSocket: IPStreamSocket;

    procedure AsyncReadSome(const Buffer: MemoryBuffer; const Handler: IOHandler); override;
    procedure AsyncWriteSome(const Buffer: MemoryBuffer; const Handler: IOHandler); override;

    property Socket: IPStreamSocket read FSocket;
  end;

function DefaultConnectCondition(const ErrorCode: IOErrorCode; const Endpoint: IPEndpoint): boolean;

implementation

procedure IPSocketAssign(const Socket: IPSocket; const Protocol: IPProtocol; const SocketHandle: TSocket);
var
  socketAccess: IPSocketAccess;
begin
  socketAccess := Socket as IPSocketAccess;
  socketAccess.Assign(Protocol, SocketHandle);
end;

function DefaultConnectCondition(const ErrorCode: IOErrorCode; const Endpoint: IPEndpoint): boolean;
begin
  result := True;
end;

{ AsyncSocketStreamImpl }

procedure AsyncSocketStreamImpl.AsyncReadSome(const Buffer: MemoryBuffer;
  const Handler: IOHandler);
begin
  Socket.AsyncReceive(Buffer, Handler);
end;

procedure AsyncSocketStreamImpl.AsyncWriteSome(const Buffer: MemoryBuffer;
  const Handler: IOHandler);
begin
  Socket.AsyncSend(Buffer, Handler);
end;

constructor AsyncSocketStreamImpl.Create(const Socket: IPStreamSocket);
begin
  inherited Create(Socket.Service);

  FSocket := Socket;
end;

destructor AsyncSocketStreamImpl.Destroy;
begin

  inherited;
end;

function AsyncSocketStreamImpl.GetSocket: IPStreamSocket;
begin
  result := FSocket;
end;

end.
