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
	#classVars : [
		'StringHolderType'
	],
	#pools : [
		'SbSeaboltConstants'
	],
	#category : #'SmallBolt-FFI'
}

{ #category : #'class initialization' }
SbSeaboltFFI class >> initialize [
	"self initialize"
	StringHolderType := FFIExternalValueHolder ofType: 'char*'.
]

{ #category : #factory }
SbSeaboltFFI class >> newStringHolder [
	^StringHolderType new
]

{ #category : #connector }
SbSeaboltFFI >> acquireConnection: connector mode: accessMode status: status [
	^ self ffiCall: #( SbBoltConnection BoltConnector_acquire(SbBoltConnector connector, int32 accessMode, SbBoltStatus status) )
]

{ #category : #connector }
SbSeaboltFFI >> applyDefaults: config [
	^ self ffiCall: #( SbBoltConfig BoltConnector_apply_defaults(SbBoltConfig config) )
]

{ #category : #auth }
SbSeaboltFFI >> authBasic: userName password: password [
	 ^ self authBasic: userName password: password realm: nil
]

{ #category : #auth }
SbSeaboltFFI >> authBasic: userName password: password realm: realm [
	 ^ self ffiCall: #( SbBoltValue BoltAuth_basic(String userName, String password, String realm) )
]

{ #category : #auth }
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
	^ self ffiCall: #( int32 BoltConnection_fetch(SbBoltConnection aBoltConnection, SbBoltRequest request) )
]

{ #category : #connection }
SbSeaboltFFI >> fetchSummaryOnConnection: aBoltConnection request: aBoltRequest [
	^ self ffiCall: #( int32 BoltConnection_fetch_summary(SbBoltConnection aBoltConnection, SbBoltRequest request) )
]

{ #category : #accessing }
SbSeaboltFFI >> ffiLibraryName [
	^ SbSeaboltLibrary
]

{ #category : #connection }
SbSeaboltFFI >> getAddressOnConnection: aBoltConnection [
	^ self ffiCall: #( BoltAddress BoltConnection_address(SbBoltConnection aBoltConnection) )
]

{ #category : #value }
SbSeaboltFFI >> getBooleanOnValue: aBoltValue [
	^ self ffiCall: #( short BoltBoolean_get(SbBoltValue aBoltValue) )
]

{ #category : #value }
SbSeaboltFFI >> getBytesOnValue: aBoltValue [
	^ self ffiCall: #( ByteArray BoltBytes_get(SbBoltValue aBoltValue) )
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
	^ self ffiCall: #( BoltValue BoltConnection_failure(SbBoltConnection aBoltConnection) )
]

{ #category : #connection }
SbSeaboltFFI >> getFieldNamesOnConnection: aBoltConnection [
	^ self ffiCall: #( BoltValue BoltConnection_field_names(SbBoltConnection aBoltConnection) )
]

{ #category : #connection }
SbSeaboltFFI >> getFieldValuesOnConnection: aBoltConnection [
	^ self ffiCall: #( BoltValue BoltConnection_field_values(SbBoltConnection aBoltConnection) )
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
	^ self ffiCall: #( BoltRequest BoltConnection_last_request(SbBoltConnection aBoltConnection) )
]

{ #category : #value }
SbSeaboltFFI >> getListOnValue: aBoltValue [
	^ self ffiCall: #( SBBoltValue BoltList_value(SbBoltValue aBoltValue) )
]

{ #category : #connection }
SbSeaboltFFI >> getLocalEndpointOnConnection: aBoltConnection [
	^ self ffiCall: #( BoltAddress BoltConnection_local_endpoint(SbBoltConnection aBoltConnection) )
]

{ #category : #config }
SbSeaboltFFI >> getMaxPoolSizeOnConfig: aBoltConfig [
	^ self ffiCall: #( int32 BoltConfig_get_max_pool_size(SbBoltConfig aBoltConfig) )
]

{ #category : #connection }
SbSeaboltFFI >> getMetadataOnConnection: aBoltConnection [
	^ self ffiCall: #( BoltValue BoltConnection_metadata(SbBoltConnection aBoltConnection) )
]

{ #category : #address }
SbSeaboltFFI >> getPortOnAddress: aBoltAddress [
	^ self ffiCall: #( String BoltAddress_port(SbBoltAddress aBoltAddress) )
]

{ #category : #connection }
SbSeaboltFFI >> getRemoteEndpointOnConnection: aBoltConnection [
	^ self ffiCall: #( BoltAddress BoltConnection_remote_endpoint(SbBoltConnection aBoltConnection) )
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
	^ self ffiCall: #( BoltStatus BoltConnection_metadata(SbBoltConnection aBoltConnection) )
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
SbSeaboltFFI >> getStructureOnValue: aBoltValue [
	^ self ffiCall: #( SBBoltValue BoltStructure_value(SbBoltValue aBoltValue) )
]

{ #category : #connection }
SbSeaboltFFI >> getSummarySuccessOnConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_summary_success(SbBoltConnection aBoltConnection) )
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
	| n |
	n := -1.
	^ self ffiCall: #( int32 BoltConnection_load_pull_request(SbBoltConnection aBoltConnection, int32_t n) )
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

{ #category : #config }
SbSeaboltFFI >> setMaxPoolSize: anInteger onConfig: aBoltConfig [
	^ self ffiCall: #( void BoltConfig_set_max_pool_size(SbBoltConfig aBoltConfig , int32 anInteger) )
]

{ #category : #connection }
SbSeaboltFFI >> setRunBookmarkList: bookmarkList onConnection: aBoltConnection [
	^ self ffiCall: #( int32 BoltConnection_set_run_bookmarks(SbBoltConnection aBoltConnection, BoltValue bookmarkList) )
]

{ #category : #connection }
SbSeaboltFFI >> setRunCypher: aString numberOfParameters: numberOfParameters onConnection: aBoltConnection [
	| cypherSize |
	cypherSize := aString asString size.
	^ self ffiCall: #( int32 BoltConnection_set_run_cypher(SbBoltConnection aBoltConnection, String cypher, int64 cypherSize, int32 numberOfParameters) )
]

{ #category : #connection }
SbSeaboltFFI >> setRunCypher: cypherString onConnection: aBoltConnection [
	^ self setRunCypher: cypherString numberOfParameters: 0 onConnection: aBoltConnection
]

{ #category : #connection }
SbSeaboltFFI >> setRunCypherParameter: paramNameString at: index onConnection: aBoltConnection [
	| paramNameSize |
	paramNameSize := paramNameString asString size.
	^ self ffiCall: #( BoltValue BoltConnection_set_run_cypher_parameter(SbBoltConnection aBoltConnection, int32 index, String paramNameString, int64 paramNameSize) )
]

{ #category : #connection }
SbSeaboltFFI >> setRunTransactionMetadataMetadata: metadata onConnection: aBoltConnection [
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

{ #category : #config }
SbSeaboltFFI >> setTransport: anInteger onConfig: aBoltConfig [
	^ self ffiCall: #( void BoltConfig_set_transport(SbBoltConfig aBoltConfig , int32 anInteger) )
]

{ #category : #config }
SbSeaboltFFI >> setUserAgent: aString onConfig: aBoltConfig [
	^ self ffiCall: #( void BoltConfig_set_user_agent(SbBoltConfig aBoltConfig , String aString) )
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
SbSeaboltFFI >> toString: dest fromValue: aBoltValue length: length onConnection: aSbBoldConnection [
	^ self ffiCall: #( int32 BoltValue_to_string(SbBoltValue aBoltValue, StringHolderType dest, int32 length, BoltConnection aSbBoldConnection) )
]
