unit Test.AsyncIO.Net.IP;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit
  being tested.

}

interface

uses
  TestFramework, NetTestCase,  IdWinsock2, AsyncIO, AsyncIO.Net.IP;

type
  // Test methods for class IPv4Address

  TestIPv4Address = class(TNetTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExplicitCast;
    procedure TestImplicitCast;
    procedure TestTryFromString;
  end;
  // Test methods for class IPv6Address

  TestIPv6Address = class(TNetTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExplicitCast;
    procedure TestImplicitCast;
    procedure TestTryFromString;
  end;
  // Test methods for class IPAddress

  TestIPAddress = class(TNetTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExplicitCast;
    procedure TestSetAsIPv4;
    procedure TestSetAsIPv6;
    procedure TestGetAsIPv4;
    procedure TestGetAsIPv6;
  end;
  // Test methods for class IPEndpoint

  TestIPEndpoint = class(TNetTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestImplicitCast;
    procedure TestFromDataIPv4;
    procedure TestFromDataIPv6;
    procedure TestSetAddressIPv4;
    procedure TestSetAddressIPv6;
    procedure TestGetAddressIPv4;
    procedure TestGetAddressIPv6;
  end;
  // Test methods for class IPSocket

  TestIPResolver = class(TNetTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestResolveBasic;
    procedure TestResolveIPv4;
    procedure TestResolveIPv6;
  end;
  // Test methods for class IPSocket

  TestIPSocket = class(TNetTestCase)
  strict private
    FIPSocket: IPSocket;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestGetService;
    procedure TestGetProtocol;
    procedure TestGetLocalEndpoint;
    procedure TestGetRemoteEndpoint;
    procedure TestGetSocketHandle;
    procedure TestAsyncConnect;
    procedure TestBind;
    procedure TestConnect;
    procedure TestClose;
    procedure TestShutdown;
  end;
  // Test methods for class IPStreamSocket

  TestIPStreamSocket = class(TNetTestCase)
  strict private
    FIPStreamSocket: IPStreamSocket;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAsyncSend;
    procedure TestAsyncReceive;
  end;
  // Test methods for class AsyncSocketStream

  TestAsyncSocketStream = class(TNetTestCase)
  strict private
    FAsyncSocketStream: AsyncSocketStream;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestGetSocket;
  end;

implementation

uses
  System.SysUtils;


procedure TestIPv4Address.SetUp;
begin

end;

procedure TestIPv4Address.TearDown;
begin

end;

procedure TestIPv4Address.TestExplicitCast;
var
  Addr: UInt32;
  IPv4Addr: IPv4Address;
begin
  Addr := $0A010203;
  IPv4Addr := IPv4Address(Addr);

  CheckEqualsHex(Addr, IPv4Addr.Data, 'Explicit cast stored wrong address');
end;

procedure TestIPv4Address.TestImplicitCast;
var
  Addr: UInt32;
  IPv4Addr: IPv4Address;
  ReturnValue: string;
begin
  Addr := IPv4Address.Loopback.Data;
  IPv4Addr := IPv4Address(Addr);

  ReturnValue := IPv4Addr;

  CheckEquals('127.0.0.1', ReturnValue, 'Implicit cast returned wrong address');
end;

procedure TestIPv4Address.TestTryFromString;
var
  IPv4Addr: IPv4Address;
  ReturnValue: boolean;
begin
  IPv4Addr := IPv4Address.Any;

  ReturnValue := IPv4Address.TryFromString('1.2.3.4', IPv4Addr);
  CheckTrue(ReturnValue, 'TryFromString failed to convert address 1');
  CheckEqualsHex($01020304, IPv4Addr.Data, 'TryFromString returned wrong address 1');

  ReturnValue := IPv4Address.TryFromString('127.0.0.1', IPv4Addr);
  CheckTrue(ReturnValue, 'TryFromString failed to convert address 2');
  CheckEqualsHex($7F000001, IPv4Addr.Data, 'TryFromString returned wrong address 2');

  ReturnValue := IPv4Address.TryFromString('100.200.300.400', IPv4Addr);
  CheckFalse(ReturnValue, 'TryFromString failed reject bad address');
end;

procedure TestIPv6Address.SetUp;
begin

end;

procedure TestIPv6Address.TearDown;
begin

end;

procedure TestIPv6Address.TestExplicitCast;
const
  Addr: IPv6Address.IPv6AddressBytes =
    ($01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10);
var
  IPv6Addr: IPv6Address;
begin
  IPv6Addr := IPv6Address(Addr);

  CheckEquals(IPv6Address(Addr), IPv6Addr, 'Explicit cast stored wrong address');
end;

procedure TestIPv6Address.TestImplicitCast;
const
  Addr: IPv6Address.IPv6AddressBytes =
    ($01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10);
var
  IPv6Addr: IPv6Address;
  ReturnValue: string;
begin
  IPv6Addr := IPv6Address(Addr);

  ReturnValue := LowerCase(IPv6Addr);

  CheckEqualsString(ReturnValue, '102:304:506:708:90a:b0c:d0e:f10', 'Implicit cast returned wrong address');
end;

procedure TestIPv6Address.TestTryFromString;
const
  Addr1: IPv6Address.IPv6AddressBytes =
    (0, $01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, $42);
var
  IPv6Addr: IPv6Address;
  ReturnValue: boolean;
begin
  IPv6Addr := IPv6Address.Any;

  ReturnValue := IPv6Address.TryFromString('1::42', IPv6Addr);
  CheckTrue(ReturnValue, 'TryFromString failed to convert address');
  CheckEquals(IPv6Address(Addr1), IPv6Addr, 'TryFromString returned wrong address 1');

  ReturnValue := IPv6Address.TryFromString('10.0.0.1', IPv6Addr);
  CheckFalse(ReturnValue, 'TryFromString failed reject bad address');
end;

procedure TestIPAddress.SetUp;
begin

end;

procedure TestIPAddress.TearDown;
begin

end;

procedure TestIPAddress.TestExplicitCast;
var
  ReturnValue: IPAddress;
begin
  ReturnValue := IPAddress('127.0.0.1');
  CheckTrue(ReturnValue.IsIPv4, 'IPAddress failed to convert to IPv4 address 1');
  CheckFalse(ReturnValue.IsIPv6, 'IPAddress failed to convert to IPv4 address 2');
  CheckTrue(ReturnValue.IsLoopback, 'IPAddress failed to convert to IPv4 loopback address');

  ReturnValue := IPAddress('::1');
  CheckFalse(ReturnValue.IsIPv4, 'IPAddress failed to convert to IPv6 address 1');
  CheckTrue(ReturnValue.IsIPv6, 'IPAddress failed to convert to IPv6 address 2');
  CheckTrue(ReturnValue.IsLoopback, 'IPAddress failed to convert to IPv6 loopback address');
end;

procedure TestIPAddress.TestGetAsIPv4;
var
  Addr: IPAddress;
  ReturnValue: IPv4Address;
begin
  Addr := IPv4Address.Broadcast;
  ReturnValue := Addr.AsIPv4;
  CheckEquals(IPv4Address.Broadcast.Data, ReturnValue.Data, 'IPAddress failed to get IPv4 address');
end;

procedure TestIPAddress.TestGetAsIPv6;
var
  Addr: IPAddress;
  ReturnValue: IPv6Address;
begin
  Addr := IPv6Address.Loopback;
  ReturnValue := Addr.AsIPv6;
  CheckEquals(IPv6Address.Loopback, ReturnValue, 'IPAddress failed to get IPv6 address');
end;

procedure TestIPAddress.TestSetAsIPv4;
var
  Addr: IPAddress;
begin
  Addr.AsIPv4 := IPv4Address.Loopback;
  CheckTrue(Addr.IsIPv4, 'IPAddress failed to set IPv4 address 1');
  CheckFalse(Addr.IsIPv6, 'IPAddress failed to set IPv4 address 2');
  CheckTrue(Addr.IsLoopback, 'IPAddress failed to set IPv4 address 3');
  CheckFalse(Addr.IsMulticast, 'IPAddress failed to set IPv4 address 4');
end;

procedure TestIPAddress.TestSetAsIPv6;
var
  Addr: IPAddress;
begin
  Addr.AsIPv6 := IPv6Address.Loopback;
  CheckFalse(Addr.IsIPv4, 'IPAddress failed to set IPv6 address 1');
  CheckTrue(Addr.IsIPv6, 'IPAddress failed to set IPv6 address 2');
  CheckTrue(Addr.IsLoopback, 'IPAddress failed to set IPv6 address 3');
  CheckFalse(Addr.IsMulticast, 'IPAddress failed to set IPv6 address 4');
end;

procedure TestIPEndpoint.SetUp;
begin

end;

procedure TestIPEndpoint.TearDown;
begin

end;

procedure TestIPEndpoint.TestFromDataIPv4;
var
  Data: sockaddr_in;
  ReturnValue: IPEndpoint;
begin
  FillChar(Data, SizeOf(Data), 0);
  Data.sin_family := AF_INET;
  Data.sin_port := htons(42);
  Data.sin_addr.S_addr := INADDR_LOOPBACK;

  ReturnValue := IPEndpoint.FromData(Data, SizeOf(Data));

  CheckTrue(ReturnValue.IsIPv4, 'Failed to set IPv4 address 1');
  CheckFalse(ReturnValue.IsIPv6, 'Failed to set IPv4 address 2');
  CheckEquals(ReturnValue.Address.AsIPv4, IPv4Address(ntohl(Data.sin_addr.S_addr)), 'Failed to set IPv4 address 3');
  CheckEquals(42, ReturnValue.Port, 'Failed to set port');
end;

procedure TestIPEndpoint.TestFromDataIPv6;
const
  Addr: IPv6Address.IPv6AddressBytes =
    ($01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10);
var
  Data: SOCKADDR_IN6;
  ReturnValue: IPEndpoint;
begin
  FillChar(Data, SizeOf(Data), 0);
  Data.sin6_family := AF_INET6;
  Data.sin6_port := htons(42);
  Move(Addr, Data.sin6_addr.s6_bytes, 16);

  ReturnValue := IPEndpoint.FromData(Data, SizeOf(Data));

  CheckFalse(ReturnValue.IsIPv4, 'Failed to set IPv6 address 1');
  CheckTrue(ReturnValue.IsIPv6, 'Failed to set IPv6 address 2');
  CheckEquals(ReturnValue.Address.AsIPv6, IPv6Address(Addr), 'Failed to set IPv6 address 3');
  CheckEquals(42, ReturnValue.Port, 'Failed to set port');
end;

procedure TestIPEndpoint.TestGetAddressIPv4;
var
  Addr: IPAddress;
  Endp: IPEndpoint;
  ReturnValue: IPAddress;
begin
  Addr := IPv4Address.Loopback;
  Endp := Endpoint(Addr, 1042);

  ReturnValue := Endp.Address;
  CheckEquals(Addr, ReturnValue, 'Failed to get IPv4 address');
end;

procedure TestIPEndpoint.TestGetAddressIPv6;
var
  Addr: IPAddress;
  Endp: IPEndpoint;
  ReturnValue: IPAddress;
begin
  Addr := IPv6Address.Loopback;
  Endp := Endpoint(Addr, 1042);

  ReturnValue := Endp.Address;
  CheckEquals(Addr, ReturnValue, 'Failed to get IPv6 address');
end;

procedure TestIPEndpoint.TestImplicitCast;
var
  Endp: IPEndpoint;
  ReturnValue: string;
begin
  Endp := Endpoint(IPv4Address.Loopback, 1042);

  ReturnValue := Endp;
  CheckEquals('127.0.0.1:1042', ReturnValue, 'Failed to cast IPv4 endpoint');

  Endp := Endpoint(IPv6Address.Loopback, 1042);

  ReturnValue := Endp;
  CheckEquals('[::1]:1042', ReturnValue, 'Failed to cast IPv6 endpoint');
end;

procedure TestIPEndpoint.TestSetAddressIPv4;
var
  Addr: IPAddress;
  Endp: IPEndpoint;
begin
  Endp := Endpoint(IPAddressFamily.v6, 1234);
  Addr := IPv4Address.Loopback;

  Endp.Address := Addr;

  CheckTrue(Endp.IsIPv4, 'Failed to set IPv4 address 1');
  CheckFalse(Endp.IsIPv6, 'Failed to set IPv4 address 2');
  CheckEquals(Addr, Endp.Address, 'Failed to set IPv4 address 3');
end;

procedure TestIPEndpoint.TestSetAddressIPv6;
var
  Addr: IPAddress;
  Endp: IPEndpoint;
begin
  Endp := Endpoint(IPAddressFamily.v4, 1234);
  Addr := IPv6Address.Loopback;

  Endp.Address := Addr;

  CheckFalse(Endp.IsIPv4, 'Failed to set IPv6 address 1');
  CheckTrue(Endp.IsIPv6, 'Failed to set IPv6 address 2');
  CheckEquals(Addr, Endp.Address, 'Failed to set IPv6 address 3');
end;

procedure TestIPResolver.SetUp;
begin

end;

procedure TestIPResolver.TearDown;
begin

end;

procedure TestIPResolver.TestResolveBasic;
var
  ReturnValue: IPResolver.Results;
begin
  ReturnValue := IPResolver.Resolve(Query('localhost', ''));

  CheckTrue(Length(ReturnValue.ToArray()) > 0, 'Failed to resolve localhost');
end;

procedure TestIPResolver.TestResolveIPv4;
var
  ReturnValue: IPResolver.Results;
  Entries: TArray<IPResolver.Entry>;
begin
  ReturnValue := IPResolver.Resolve(Query(IPProtocol.TCP.v4, 'localhost', ''));

  Entries := ReturnValue.ToArray();

  CheckTrue(Length(Entries) > 0, 'Failed to resolve IPv4 localhost 1');
  CheckEquals(IPv4Address.Loopback, Entries[0].Endpoint.Address.AsIPv4, 'Failed to resolve IPv4 loopback 2');
  CheckEquals('localhost', Entries[0].HostName, 'Failed to resolve IPv4 loopback 3');
  CheckEquals('', Entries[0].ServiceName, 'Failed to resolve IPv4 loopback 4');
end;

procedure TestIPResolver.TestResolveIPv6;
var
  ReturnValue: IPResolver.Results;
  Entries: TArray<IPResolver.Entry>;
begin
  ReturnValue := IPResolver.Resolve(Query(IPProtocol.TCP.v6, 'localhost', ''));

  Entries := ReturnValue.ToArray();

  CheckTrue(Length(Entries) > 0, 'Failed to resolve IPv6 localhost 1');
  CheckEquals(IPv6Address.Loopback, Entries[0].Endpoint.Address.AsIPv6, 'Failed to resolve IPv6 loopback 2');
  CheckEquals('localhost', Entries[0].HostName, 'Failed to resolve IPv6 loopback 3');
  CheckEquals('', Entries[0].ServiceName, 'Failed to resolve IPv6 loopback 4');
end;

procedure TestIPSocket.SetUp;
begin
  // TODO: Initialize FIPSocket
end;

procedure TestIPSocket.TearDown;
begin
  FIPSocket := nil;
end;

procedure TestIPSocket.TestGetService;
var
  ReturnValue: IOService;
begin
  ReturnValue := FIPSocket.GetService;
  // TODO: Validate method results
end;

procedure TestIPSocket.TestGetProtocol;
var
  ReturnValue: IPProtocol;
begin
  ReturnValue := FIPSocket.GetProtocol;
  // TODO: Validate method results
end;

procedure TestIPSocket.TestGetLocalEndpoint;
var
  ReturnValue: IPEndpoint;
begin
  ReturnValue := FIPSocket.GetLocalEndpoint;
  // TODO: Validate method results
end;

procedure TestIPSocket.TestGetRemoteEndpoint;
var
  ReturnValue: IPEndpoint;
begin
  ReturnValue := FIPSocket.GetRemoteEndpoint;
  // TODO: Validate method results
end;

procedure TestIPSocket.TestGetSocketHandle;
var
  ReturnValue: TSocket;
begin
  ReturnValue := FIPSocket.GetSocketHandle;
  // TODO: Validate method results
end;

procedure TestIPSocket.TestAsyncConnect;
var
  Handler: OpHandler;
  PeerEndpoint: IPEndpoint;
begin
  // TODO: Setup method call parameters
  FIPSocket.AsyncConnect(PeerEndpoint, Handler);
  // TODO: Validate method results
end;

procedure TestIPSocket.TestBind;
var
  LocalEndpoint: IPEndpoint;
begin
  // TODO: Setup method call parameters
  FIPSocket.Bind(LocalEndpoint);
  // TODO: Validate method results
end;

procedure TestIPSocket.TestConnect;
var
  PeerEndpoint: IPEndpoint;
begin
  // TODO: Setup method call parameters
  FIPSocket.Connect(PeerEndpoint);
  // TODO: Validate method results
end;

procedure TestIPSocket.TestClose;
begin
  FIPSocket.Close;
  // TODO: Validate method results
end;

procedure TestIPSocket.TestShutdown;
var
  ShutdownFlag: SocketShutdownFlag;
begin
  // TODO: Setup method call parameters
  FIPSocket.Shutdown(ShutdownFlag);
  // TODO: Validate method results
end;

procedure TestIPStreamSocket.SetUp;
begin
  // TODO: Initialize FIPStreamSocket
end;

procedure TestIPStreamSocket.TearDown;
begin
  FIPStreamSocket := nil;
end;

procedure TestIPStreamSocket.TestAsyncSend;
var
  Handler: IOHandler;
  Buffer: MemoryBuffer;
begin
  // TODO: Setup method call parameters
  FIPStreamSocket.AsyncSend(Buffer, Handler);
  // TODO: Validate method results
end;

procedure TestIPStreamSocket.TestAsyncReceive;
var
  Handler: IOHandler;
  Buffer: MemoryBuffer;
begin
  // TODO: Setup method call parameters
  FIPStreamSocket.AsyncReceive(Buffer, Handler);
  // TODO: Validate method results
end;

procedure TestAsyncSocketStream.SetUp;
begin
  // TODO: Initialize FAsyncSocketStream
end;

procedure TestAsyncSocketStream.TearDown;
begin
  FAsyncSocketStream := nil;
end;

procedure TestAsyncSocketStream.TestGetSocket;
var
  ReturnValue: IPStreamSocket;
begin
  ReturnValue := FAsyncSocketStream.GetSocket;
  // TODO: Validate method results
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestIPv4Address.Suite);
  RegisterTest(TestIPv6Address.Suite);
  RegisterTest(TestIPAddress.Suite);
  RegisterTest(TestIPEndpoint.Suite);
  RegisterTest(TestIPResolver.Suite);
//  RegisterTest(TestIPSocket.Suite);
//  RegisterTest(TestIPStreamSocket.Suite);
//  RegisterTest(TestAsyncSocketStream.Suite);
end.

