"
FFIExternalObject subclass: #SeaboltStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	package: 'OSWindow-SDL2-Bindings'
"
Class {
	#name : #SbSeaboltFFI,
	#superclass : #Object,
	#pools : [
		'SbBoltConstants'
	],
	#category : #'SmallBolt-FFI'
}

{ #category : #'class initialization' }
SbSeaboltFFI class >> initialize [
	"self initialize"
	
]

{ #category : #factory }
SbSeaboltFFI class >> newAutoReleasePointer: size [
	^ (ExternalAddress allocate: 1024) autoRelease.
]

{ #category : #utility }
SbSeaboltFFI class >> shutdown [
	<script>
	self new shutdown
]

{ #category : #utility }
SbSeaboltFFI class >> startup [
	<script>
	self new startup
]

{ #category : #connector }
SbSeaboltFFI >> acquireConnection: connector mode: accessMode status: status [
	^ self ffiCall: #( SbBoltConnection BoltConnector_acquire(SbBoltConnector connector, int32 accessMode, SbBoltStatus status) )
]

{ #category : #connector }
SbSeaboltFFI >> applyDefaults: config [
	^ self ffiCall: #( SbBoltConfig BoltConnector_apply_defaults(SbBoltConfig config) )
]

{ #category : #authentication }
SbSeaboltFFI >> authBasic: userName password: password [
	 ^ self authBasic: userName password: password realm: nil
]

{ #category : #authentication }
SbSeaboltFFI >> authBasic: userName password: password realm: realm [
	 ^ self ffiCall: #( SbBoltValue BoltAuth_basic(String userName, String password, String realm) )
]

{ #category : #authentication }
SbSeaboltFFI >> authNone [
	 ^ self ffiCall: #( SbBoltValue BoltAuth_none() )
]

{ #category : #connection }
SbSeaboltFFI >> clearBeginOnConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_clear_begin(SbBoltConnection aBoltConnection) )
]

{ #category : #connection }
SbSeaboltFFI >> clearRunOnConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_clear_run(SbBoltConnection aBoltConnection) )
]

{ #category : #address }
SbSeaboltFFI >> createAddress: host port: port [
	^ self ffiCall: #( SbBoltAddress BoltAddress_create(String host, String port) )
]

{ #category : #config }
SbSeaboltFFI >> createConfig [
	^ self ffiCall: #( SbBoltConfig BoltConfig_create() )
]

{ #category : #connector }
SbSeaboltFFI >> createConnector: address token: authToken config: config [
	^ self ffiCall: #( SbBoltConnector BoltConnector_create(SbBoltAddress address, SbBoltValue authToken, SbBoltConfig config) )
]

{ #category : #logging }
SbSeaboltFFI >> createLog: aState [
	^ self ffiCall: #( SbBoltLog BoltLog_create(void* aState) )
]

{ #category : #status }
SbSeaboltFFI >> createStatus [
	^ self ffiCall: #( SbBoltStatus BoltStatus_create() )
]

{ #category : #value }
SbSeaboltFFI >> createValue [
	^ self ffiCall: #( SbBoltValue BoltValue_create() )
]

{ #category : #address }
SbSeaboltFFI >> destroyAddress: aBoltAddress [
	^ self ffiCall: #( void BoltAddress_destroy(SbBoltAddress aBoltAddress ) )
]

{ #category : #config }
SbSeaboltFFI >> destroyConfig: aBoltConfig [
	^ self ffiCall: #( void BoltConfig_destroy(SbBoltConfig aBoltConfig ) )
]

{ #category : #connector }
SbSeaboltFFI >> destroyConnector: connector [
	^ self ffiCall: #( void BoltConnector_destroy(SbBoltConnector connector) )
]

{ #category : #logging }
SbSeaboltFFI >> destroyLog: aBoltLog [
	^ self ffiCall: #( void BoltLog_destroy(SbBoltLog aBoltLog ) )
]

{ #category : #status }
SbSeaboltFFI >> destroyStatus: aBoltStatus [
	^ self ffiCall: #( void BoltStatus_destroy(SbBoltStatus aBoltStatus ) )
]

{ #category : #value }
SbSeaboltFFI >> destroyValue: aBoltValue [
	^ self ffiCall: #( void BoltValue_destroy(SbBoltValue aBoltValue ) )
]

{ #category : #value }
SbSeaboltFFI >> duplicateOnValue: aBoltValue [
	^ self ffiCall: #( SbBoltValue BoltValue_duplicate(SbBoltValue aBoltValue) )
]

{ #category : #connection }
SbSeaboltFFI >> fetchOnConnection: aBoltConnection request: aBoltRequest [
	^ self ffiCall: #( int32 BoltConnection_fetch(SbBoltConnection aBoltConnection, SbBoltRequest aBoltRequest) )
]

{ #category : #connection }
SbSeaboltFFI >> fetchSummaryOnConnection: aBoltConnection request: aBoltRequest [
	^ self ffiCall: #( int32 BoltConnection_fetch_summary(SbBoltConnection aBoltConnection, SbBoltRequest aBoltRequest) )
]

{ #category : #accessing }
SbSeaboltFFI >> ffiLibraryName [
	^ SbSeaboltLibrary
]

{ #category : #connection }
SbSeaboltFFI >> getAddressOnConnection: aBoltConnection [
	^ self ffiCall: #( SbBoltAddress BoltConnection_address(SbBoltConnection aBoltConnection) )
]

{ #category : #value }
SbSeaboltFFI >> getBooleanOnValue: aBoltValue [
	^ self ffiCall: #( char BoltBoolean_get(SbBoltValue aBoltValue) )
]

{ #category : #value }
SbSeaboltFFI >> getBytesOnValue: aBoltValue [
	^ self ffiCall: #( ByteArray BoltBytes_get_all(SbBoltValue aBoltValue) )
]

{ #category : #status }
SbSeaboltFFI >> getConnectionStateOnStatus: aBoltStatus [
	^ self ffiCall: #( int32 BoltStatus_get_state(SbBoltStatus aBoltStatus) )
]

{ #category : #value }
SbSeaboltFFI >> getDictionaryKeyAt: index onValue: aBoltValue [
	^ self ffiCall: #( SbBoltValue BoltDictionary_key(SbBoltValue aBoltValue, int32 index) )
]

{ #category : #value }
SbSeaboltFFI >> getDictionaryStringKeyAt: index onValue: aBoltValue [
	^ self ffiCall: #( String BoltDictionary_get_key(SbBoltValue aBoltValue, int32 index) )
]

{ #category : #value }
SbSeaboltFFI >> getDictionaryValueAt: index onValue: aBoltValue [
	^ self ffiCall: #( SbBoltValue BoltDictionary_value(SbBoltValue aBoltValue, int32 index) )
]

{ #category : #status }
SbSeaboltFFI >> getErrorCodeOnStatus: aBoltStatus [
	^ self ffiCall: #( int32 BoltStatus_get_error(SbBoltStatus aBoltStatus) )
]

{ #category : #status }
SbSeaboltFFI >> getErrorContextOnStatus: aBoltStatus [
	^ self ffiCall: #( String BoltStatus_get_error_context(SbBoltStatus aBoltStatus) )
]

{ #category : #error }
SbSeaboltFFI >> getErrorStringOnErrorCode: anInteger [
	^ self ffiCall: #( String BoltError_get_string(int32 anInteger) )
]

{ #category : #connection }
SbSeaboltFFI >> getFailureDetailsOnConnection: aBoltConnection [
	^ self ffiCall: #( SbBoltValue BoltConnection_failure(SbBoltConnection aBoltConnection) )
]

{ #category : #connection }
SbSeaboltFFI >> getFieldNamesOnConnection: aBoltConnection [
	^ self ffiCall: #( SbBoltValue BoltConnection_field_names(SbBoltConnection aBoltConnection) )
]

{ #category : #connection }
SbSeaboltFFI >> getFieldValuesOnConnection: aBoltConnection [
	^ self ffiCall: #( SbBoltValue BoltConnection_field_values(SbBoltConnection aBoltConnection) )
]

{ #category : #value }
SbSeaboltFFI >> getFloatOnValue: aBoltValue [
	^ self ffiCall: #( double BoltFloat_get(SbBoltValue aBoltValue) )
]

{ #category : #address }
SbSeaboltFFI >> getHostOnAddress: aBoltAddress [
	^ self ffiCall: #( String BoltAddress_host(SbBoltAddress aBoltAddress) )
]

{ #category : #connection }
SbSeaboltFFI >> getIdOnConnection: aBoltConnection [
	^ self ffiCall: #( String BoltConnection_id(SbBoltConnection aBoltConnection) )
]

{ #category : #value }
SbSeaboltFFI >> getIntegerOnValue: aBoltValue [
	^ self ffiCall: #( int64 BoltInteger_get(SbBoltValue aBoltValue) )
]

{ #category : #connection }
SbSeaboltFFI >> getLastBookmarkListOnConnection: aBoltConnection [
	^ self ffiCall: #( String BoltConnection_last_bookmark(SbBoltConnection aBoltConnection) )
]

{ #category : #connection }
SbSeaboltFFI >> getLastRequestOnConnection: aBoltConnection [
	^ self ffiCall: #( SbBoltRequest BoltConnection_last_request(SbBoltConnection aBoltConnection) )
]

{ #category : #value }
SbSeaboltFFI >> getListValueAt: index onValue: aBoltValue [
	^ self ffiCall: #( SbBoltValue BoltList_value(SbBoltValue aBoltValue, int32 index) )
]

{ #category : #connection }
SbSeaboltFFI >> getLocalEndpointOnConnection: aBoltConnection [
	^ self ffiCall: #( SbBoltAddress BoltConnection_local_endpoint(SbBoltConnection aBoltConnection) )
]

{ #category : #config }
SbSeaboltFFI >> getLogOnConfig: aBoltConfig [
	^ self ffiCall: #( SbBoltLog BoltConfig_get_log(SbBoltConfig aBoltConfig) )
]

{ #category : #config }
SbSeaboltFFI >> getMaxConnectionAcquisitionTimeOnConfig: aBoltConfig [
	^ self ffiCall: #( int32 BoltConfig_get_max_connection_acquisition_time(SbBoltConfig aBoltConfig) )
]

{ #category : #config }
SbSeaboltFFI >> getMaxConnectionLifeTimeOnConfig: aBoltConfig [
	^ self ffiCall: #( int32 BoltConfig_get_max_connection_life_time(SbBoltConfig aBoltConfig) )
]

{ #category : #config }
SbSeaboltFFI >> getMaxPoolSizeOnConfig: aBoltConfig [
	^ self ffiCall: #( int32 BoltConfig_get_max_pool_size(SbBoltConfig aBoltConfig) )
]

{ #category : #connection }
SbSeaboltFFI >> getMetadataOnConnection: aBoltConnection [
	^ self ffiCall: #( SbBoltValue BoltConnection_metadata(SbBoltConnection aBoltConnection) )
]

{ #category : #address }
SbSeaboltFFI >> getPortOnAddress: aBoltAddress [
	^ self ffiCall: #( String BoltAddress_port(SbBoltAddress aBoltAddress) )
]

{ #category : #value }
SbSeaboltFFI >> getRawStringOnValue: aBoltValue [
	^ self ffiCall: #( void* BoltString_get(SbBoltValue aBoltValue) )
]

{ #category : #connection }
SbSeaboltFFI >> getRemoteEndpointOnConnection: aBoltConnection [
	^ self ffiCall: #( SbBoltAddress BoltConnection_remote_endpoint(SbBoltConnection aBoltConnection) )
]

{ #category : #config }
SbSeaboltFFI >> getSchemeOnConfig: aBoltConfig [
	^ self ffiCall: #( int32 BoltConfig_get_scheme(SbBoltConfig aBoltConfig) )
]

{ #category : #connection }
SbSeaboltFFI >> getServerOnConnection: aBoltConnection [
	^ self ffiCall: #( String BoltConnection_server(SbBoltConnection aBoltConnection) )
]

{ #category : #value }
SbSeaboltFFI >> getSizeOnValue: aBoltValue [
	^ self ffiCall: #( int32 BoltValue_size(SbBoltValue aBoltValue) )
]

{ #category : #connection }
SbSeaboltFFI >> getStatusOnConnection: aBoltConnection [
	^ self ffiCall: #( SbBoltStatus BoltConnection_status(SbBoltConnection aBoltConnection) )
]

{ #category : #value }
SbSeaboltFFI >> getStringOnValue: aBoltValue [
	^ self ffiCall: #( String BoltString_get(SbBoltValue aBoltValue) )
]

{ #category : #value }
SbSeaboltFFI >> getStructureCodeOnValue: aBoltValue [
	^ self ffiCall: #( int16 BoltStructure_code(SbBoltValue aBoltValue) )
]

{ #category : #value }
SbSeaboltFFI >> getStructureFieldValueAt: index onValue: aBoltValue [
	^ self ffiCall: #( SbBoltValue BoltStructure_value(SbBoltValue aBoltValue, int32 index) )
]

{ #category : #connection }
SbSeaboltFFI >> getSummarySuccessOnConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_summary_success(SbBoltConnection aBoltConnection) )
]

{ #category : #config }
SbSeaboltFFI >> getTransportOnConfig: aBoltConfig [
	^ self ffiCall: #( int32 BoltConfig_get_transport(SbBoltConfig aBoltConfig) )
]

{ #category : #value }
SbSeaboltFFI >> getTypeOnValue: aBoltValue [
	^ self ffiCall: #( SbBoltType BoltValue_type(SbBoltValue aBoltValue) )
]

{ #category : #config }
SbSeaboltFFI >> getUserAgentOnConfig: aBoltConfig [
	^ self ffiCall: #( String BoltConfig_get_user_agent(SbBoltConfig aBoltConfig) )
]

{ #category : #connection }
SbSeaboltFFI >> loadBeginRequestOnConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_load_begin_request(SbBoltConnection aBoltConnection) )
]

{ #category : #connection }
SbSeaboltFFI >> loadCommitRequestOnConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_load_commit_request(SbBoltConnection aBoltConnection) )
]

{ #category : #connection }
SbSeaboltFFI >> loadDiscardRequestOnConnection: aBoltConnection [
	| n |
	n := -1.
	^ self ffiCall: #( int32 BoltConnection_load_discard_request(SbBoltConnection aBoltConnection, int32_t n) )
]

{ #category : #connection }
SbSeaboltFFI >> loadPullRequestOnConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_load_pull_request(SbBoltConnection aBoltConnection, int32 -1) )
]

{ #category : #connection }
SbSeaboltFFI >> loadResetRequestOnConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_load_reset_request(SbBoltConnection aBoltConnection) )
]

{ #category : #connection }
SbSeaboltFFI >> loadRollbackRequestOnConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_load_rollback_request(SbBoltConnection aBoltConnection) )
]

{ #category : #connection }
SbSeaboltFFI >> loadRunRequestOnConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_load_run_request(SbBoltConnection aBoltConnection) )
]

{ #category : #connector }
SbSeaboltFFI >> releaseConnection: connection onConnector: connector [
	^ self ffiCall: #( void BoltConnector_release(SbBoltConnector connector, SbBoltConnection connection) )
]

{ #category : #connection }
SbSeaboltFFI >> sendOnConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_send(SbBoltConnection aBoltConnection) )
]

{ #category : #connection }
SbSeaboltFFI >> setBeginBookmarkList: bookmarkList onConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_set_begin_bookmarks(SbBoltConnection aBoltConnection, BoltValue bookmarkList) )
]

{ #category : #connection }
SbSeaboltFFI >> setBeginTransactionMetadataMetadata: metadata onConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_set_begin_tx_metadata(SbBoltConnection aBoltConnection, BoltValue metadata) )
]

{ #category : #connection }
SbSeaboltFFI >> setBeginTransactionTimeout: timeout onConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_set_begin_tx_timeout(SbBoltConnection aBoltConnection, int64 timeout) )
]

{ #category : #value }
SbSeaboltFFI >> setBoolean: booleanNumber onValue: aBoltValue [
	^ self ffiCall: #( void BoltValue_format_as_Boolean(SbBoltValue aBoltValue, char booleanNumber) )
]

{ #category : #value }
SbSeaboltFFI >> setBytes: byteArray onValue: aBoltValue [
	^ self setBytes: byteArray sized: byteArray size onValue: aBoltValue
]

{ #category : #value }
SbSeaboltFFI >> setBytes: byteArray sized: size onValue: aBoltValue [
	^ self ffiCall: #( void BoltValue_format_as_Bytes(SbBoltValue aBoltValue, ByteArray byteArray, int32 size) )
]

{ #category : #logging }
SbSeaboltFFI >> setDebugCallback: aBoltLogCallback onLog: aBoltLog [
	^ self ffiCall: #( void BoltLog_set_debug_func(SbBoltLog aBoltLog , SbBoltLogCallback aBoltLogCallback) )
]

{ #category : #value }
SbSeaboltFFI >> setDictionaryKey: keyString at: index onValue: aBoltValue [
	| size |
	size := keyString size.
	^ self setDictionaryKey: keyString sized: size at: index onValue: aBoltValue
]

{ #category : #value }
SbSeaboltFFI >> setDictionaryKey: keyString sized: size at: index onValue: aBoltValue [
	^ self ffiCall: #( int32 BoltDictionary_set_key(SbBoltValue aBoltValue, int32 index, String keyString, int32 size) )
]

{ #category : #value }
SbSeaboltFFI >> setDictionarySize: size onValue: aBoltValue [
	^ self ffiCall: #( void BoltValue_format_as_Dictionary(SbBoltValue aBoltValue, int32 size) )
]

{ #category : #logging }
SbSeaboltFFI >> setErrorCallback: aBoltLogCallback onLog: aBoltLog [
	^ self ffiCall: #( void BoltLog_set_error_func(SbBoltLog aBoltLog , SbBoltLogCallback aBoltLogCallback) )
]

{ #category : #value }
SbSeaboltFFI >> setFloat: data onValue: aBoltValue [
	^ self ffiCall: #( void BoltValue_format_as_Float(SbBoltValue aBoltValue, double data) )
]

{ #category : #logging }
SbSeaboltFFI >> setInfoCallback: aBoltLogCallback onLog: aBoltLog [
	^ self ffiCall: #( void BoltLog_set_info_func(SbBoltLog aBoltLog , SbBoltLogCallback aBoltLogCallback) )
]

{ #category : #value }
SbSeaboltFFI >> setInteger: data onValue: aBoltValue [
	^ self ffiCall: #( void BoltValue_format_as_Integer(SbBoltValue aBoltValue, int64 data) )
]

{ #category : #value }
SbSeaboltFFI >> setListSize: size onValue: aBoltValue [
	^ self ffiCall: #( void BoltValue_format_as_List(SbBoltValue aBoltValue, int32 size) )
]

{ #category : #config }
SbSeaboltFFI >> setLog: aBoltLog onConfig: aBoltConfig [
	^ self ffiCall: #( void BoltConfig_set_log(SbBoltConfig aBoltConfig, SbBoltLog aBoltLog) )
]

{ #category : #config }
SbSeaboltFFI >> setMaxConnectionAcquisitionTime: anInteger onConfig: aBoltConfig [
	^ self ffiCall: #( void BoltConfig_set_max_connection_acquisition_time(SbBoltConfig aBoltConfig , int32 anInteger) )
]

{ #category : #config }
SbSeaboltFFI >> setMaxConnectionLifeTime: anInteger onConfig: aBoltConfig [
	^ self ffiCall: #( void BoltConfig_set_max_connection_life_time(SbBoltConfig aBoltConfig , int32 anInteger) )
]

{ #category : #config }
SbSeaboltFFI >> setMaxPoolSize: anInteger onConfig: aBoltConfig [
	^ self ffiCall: #( void BoltConfig_set_max_pool_size(SbBoltConfig aBoltConfig , int32 anInteger) )
]

{ #category : #value }
SbSeaboltFFI >> setNilOnValue: aBoltValue [
	^ self ffiCall: #( void BoltValue_format_as_Null(SbBoltValue aBoltValue) )
]

{ #category : #value }
SbSeaboltFFI >> setRawBytes: byteArray sized: size onValue: aBoltValue [
	^ self ffiCall: #( void BoltValue_format_as_Bytes(SbBoltValue aBoltValue, void* byteArray, int32 size) )
]

{ #category : #value }
SbSeaboltFFI >> setRawString: aString sized: size onValue: aBoltValue [
	^ self ffiCall: #( void BoltValue_format_as_String(SbBoltValue aBoltValue, void* aString, int32 size) )
]

{ #category : #connection }
SbSeaboltFFI >> setRunBookmarkList: bookmarkList onConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_set_run_bookmarks(SbBoltConnection aBoltConnection, BoltValue bookmarkList) )
]

{ #category : #connection }
SbSeaboltFFI >> setRunCypher: cypherString cypherSize: cypherSize numberOfParameters: numberOfParameters onConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_set_run_cypher(SbBoltConnection aBoltConnection, String cypherString, int64 cypherSize, int32 numberOfParameters) )
]

{ #category : #connection }
SbSeaboltFFI >> setRunCypher: cypherString numberOfParameters: numberOfParameters onConnection: aBoltConnection [
	| targetString encodedBytes |
	targetString := cypherString asString.
	encodedBytes := targetString utf8Encoded.
	^ self setRunRawCypher: encodedBytes cypherSize: encodedBytes size numberOfParameters: numberOfParameters onConnection: aBoltConnection
	
]

{ #category : #connection }
SbSeaboltFFI >> setRunCypher: cypherString onConnection: aBoltConnection [
	^ self setRunCypher: cypherString numberOfParameters: 0 onConnection: aBoltConnection
]

{ #category : #connection }
SbSeaboltFFI >> setRunCypherParameter: paramNameString at: index onConnection: aBoltConnection [
	| paramNameSize |
	paramNameSize := paramNameString asString size.
	^ self setRunCypherParameter: paramNameString sized: paramNameSize at: index onConnection: aBoltConnection
]

{ #category : #connection }
SbSeaboltFFI >> setRunCypherParameter: paramNameString sized: paramNameSize at: index onConnection: aBoltConnection [
	^ self ffiCall: #( SbBoltValue BoltConnection_set_run_cypher_parameter(SbBoltConnection aBoltConnection, int32 index, String paramNameString, int64 paramNameSize) )
]

{ #category : #connection }
SbSeaboltFFI >> setRunRawCypher: cypherString cypherSize: cypherSize numberOfParameters: numberOfParameters onConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_set_run_cypher(SbBoltConnection aBoltConnection, void* cypherString, int64 cypherSize, int32 numberOfParameters) )
]

{ #category : #connection }
SbSeaboltFFI >> setRunTransactionMetadata: metadata onConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_set_run_tx_metadata(SbBoltConnection aBoltConnection, BoltValue metadata) )
]

{ #category : #connection }
SbSeaboltFFI >> setRunTransactionTimeout: timeout onConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_set_run_tx_timeout(SbBoltConnection aBoltConnection, int64 timeout) )
]

{ #category : #config }
SbSeaboltFFI >> setScheme: anInteger onConfig: aBoltConfig [
	^ self ffiCall: #( void BoltConfig_set_scheme(SbBoltConfig aBoltConfig , int32 anInteger) )
]

{ #category : #value }
SbSeaboltFFI >> setString: aString onValue: aBoltValue [
	^self setString: aString sized: aString size onValue: aBoltValue
]

{ #category : #value }
SbSeaboltFFI >> setString: aString sized: size onValue: aBoltValue [
	^ self ffiCall: #( void BoltValue_format_as_String(SbBoltValue aBoltValue, String aString, int32 size) )
]

{ #category : #value }
SbSeaboltFFI >> setStructureCode: code size: size onValue: aBoltValue [
	^ self ffiCall: #( void BoltValue_format_as_Structure(SbBoltValue aBoltValue, int32 code, int32 size) )
]

{ #category : #config }
SbSeaboltFFI >> setTransport: anInteger onConfig: aBoltConfig [
	^ self ffiCall: #( void BoltConfig_set_transport(SbBoltConfig aBoltConfig , int32 anInteger) )
]

{ #category : #config }
SbSeaboltFFI >> setUserAgent: aString onConfig: aBoltConfig [
	^ self ffiCall: #( void BoltConfig_set_user_agent(SbBoltConfig aBoltConfig , String aString) )
]

{ #category : #logging }
SbSeaboltFFI >> setWarningCallback: aBoltLogCallback onLog: aBoltLog [
	^ self ffiCall: #( void BoltLog_set_warning_func(SbBoltLog aBoltLog , SbBoltLogCallback aBoltLogCallback) )
]

{ #category : #'startup - shutdown' }
SbSeaboltFFI >> shutdown [
	^ self ffiCall: #( void Bolt_shutdown() )
]

{ #category : #'startup - shutdown' }
SbSeaboltFFI >> startup [
	^ self ffiCall: #( void Bolt_startup() )
]

{ #category : #value }
SbSeaboltFFI >> toString: dest fromValue: aBoltValue length: length [
	| conn |
	conn := SbBoltConnection null.
	^ self toString: dest fromValue: aBoltValue length: length onConnection: conn
]

{ #category : #value }
SbSeaboltFFI >> toString: dest fromValue: aBoltValue length: length onConnection: aSbBoltConnection [
	^ self ffiCall: #( int32 BoltValue_to_string(SbBoltValue aBoltValue, char* dest, int32 length, SbBoltConnection aSbBoltConnection) )
]
