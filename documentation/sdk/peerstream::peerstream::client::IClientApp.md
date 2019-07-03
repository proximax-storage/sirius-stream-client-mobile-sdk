# class `peerstream::peerstream::client::IClientApp` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app}

Main entry point of a client application to interface with the onion-routed network, while providing a higher-level abstraction, so most of the details are hidden from the application itself.

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public inline virtual  `[`~IClientApp`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a634c0ae405aaf051dfc72ed0d28a4217)`()` | 
`public void `[`start`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a3656109f345c4799ca766bd64878c2e1)`()` | Call this to start the client app.
`public void `[`stop`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1aed3cb4d9c92b3612dea91406ead8e401)`()` | Call this to stop the client app.
`public void `[`setMinLogLevel`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a26b3f2e773d8e8c0b054e3abaccd6159)`(const `[`LogLevel`](doxygen/md/LogLevel.md#namespacepeerstream_1_1peerstream_1_1client_1a87d4e19670413f5103aaf81e29f6035f)` & level)` | 
`public void `[`setStdoutLoggingEnabled`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a0c104f034ba6654e351fcc26d458088f)`(bool isEnabled)` | Set to true to enable STD output, set to false to disable.
`public void `[`executeAsync`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a1018b65a1f8814963f2562d5b6279767)`(std::function< `[`Action`](doxygen/md/Action.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1af08795415cdbd15b44d0995a7b1af8b1)` > action)` | Method to execute an action on [IClientApp](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app)'s processing task, which ensures that all operations occur in a serial manner 
`public void `[`log`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ad57e6f685dd65f8f8317a098b6712852)`(const std::string & componentName,const `[`LogLevel`](doxygen/md/LogLevel.md#namespacepeerstream_1_1peerstream_1_1client_1a87d4e19670413f5103aaf81e29f6035f)` & level,const char * file,const char * function,size_t line,const std::string & msg)` | Helper method for logging using SDK logging 
`public void `[`registerUser`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1abb647e078df3d115a45d4c95ad4e52fa)`(std::function< `[`OnRegisterSuccess`](doxygen/md/OnRegisterSuccess.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ab635b3ba9bfd8e0fa3640cddaa44f7b1)` > onRegisterSucceeded,std::function< `[`OnRegisterFailure`](doxygen/md/OnRegisterFailure.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a3b2ca02d07a2a324443db06c15967a7d)` > onRegisterFailure)` | Method to register a new user. NOTE: If the user is already logged in, onRegisterFailure() will be called with a code to indicate the attempt to register an additional user while logged in. 
`public void `[`login`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1af45461822a290e8305f53eae4ed30453)`(`[`UserRegistrationData`](doxygen/md/peerstream::peerstream::client::UserRegistrationData.md#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data)` userRegData,std::function< `[`OnLoginSuccess`](doxygen/md/OnLoginSuccess.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a498b6633cddd19db8a79363405d54cc9)` > onLoginSucceeded,std::function< `[`OnLoginFailure`](doxygen/md/OnLoginFailure.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ab315cda42ff5c158fe131c80d3eb3845)` > onLoginFailure)` | Log in a user with the underlying authentication system. This loads a user from the specified user registration data structure and verifies their identity with the system, along with a valid certificate. NOTE: If the user is already logged in and the attempt is to log in the same user, onLoginSucceeded() is called back and no further processing occurs. NOTE: If the user is already logged in adn the attempt is to log in a different user, onLoginFailure() will be called back with an appropriate code to indicate the attempt to log in a different user while already logged in. 
`public std::string `[`identity`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a8ecf3cd0cf82e09513d3bea54eb51e6c)`() const` | Retrieve the identity of the user.
`public IVideoStreamer & `[`videoStreamer`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a7039b4a48655fb92fa58cf1b116db337)`()` | Retrieve interface to video streamer, used if broadcasting video to the psp network
`public void `[`createChannel`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ac12439fc3e1be85b6efa9425b14ca8ad)`(const std::string & userId,std::function< `[`OnChannelConfirmed`](doxygen/md/OnChannelConfirmed.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a6241b4695574cd9c43eb4290ac5dcaa5)` > onChannelConfirmed,std::function< `[`OnChannelRequestError`](doxygen/md/OnChannelRequestError.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ad3a9dd4de3a22c5bb17f468c764bac45)` > onError,ChannelSecurity security)` | Use this to create a new channel to the specified user. The user will either respond by creating the channel or it could fail by one of the mechanisms described in the ChannelRequestErrorID enum. 
`public void `[`confirmChannel`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a91e9947479f6bb4be1d2592d544dc9ae)`(const std::string & userId,std::function< `[`OnChannelConfirmed`](doxygen/md/OnChannelConfirmed.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a6241b4695574cd9c43eb4290ac5dcaa5)` > onChannelConfirmed,std::function< `[`OnChannelRequestError`](doxygen/md/OnChannelRequestError.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ad3a9dd4de3a22c5bb17f468c764bac45)` > onError,ChannelSecurity security)` | Use this to confirm a requested channel to the specified user. The user has already indicated their desire to communicate with you, but it can still fail due to network errors, disconnections, etc... If it succeeds, you will receive a callback, and if it fails, there is another callback to handle this. 
`public void `[`denyChannel`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a44dc345f445d3989833aaeab4cbae2c5)`(const std::string & userId)` | Use this method to deny a channel request to a specific user. If any network failures occur, they are transparent to the client. 
`public `[`KeyPair`](doxygen/md/KeyPair.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a789ef2f0eedf83d4a989c3c39465cf56)` `[`generateKeyPair`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a5c82bd10daf4002bb28740f182bc6667)`() const` | 
`public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` `[`registerApplicationReady`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a56b3dae1c225cb035d04cb458c847cb3)`(std::function< `[`OnApplicationReady`](doxygen/md/OnApplicationReady.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a8604c740afb08f9ab110e2469810820c)` > handler)` | Use this to register for a notification that the application is fully started.
`public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerChannelRequested `[`PS_SDK_NODISCARD`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1aef95d4d751be61eaa3b9fdfd73f4f163)`(std::function< `[`OnChannelRequested`](doxygen/md/OnChannelRequested.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a51f9a04978a7436e3eeaa5e2c0da1edd)` > handler)` | #### Parameters
`public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerNetworkStatus `[`PS_SDK_NODISCARD`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a676a73fcbac5ee5b2264bbc0788cc517)`(std::function< `[`OnNetworkStatus`](doxygen/md/OnNetworkStatus.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1abaff3cceaf2beac7efdd400f2f857f97)` > handler)` | Register for network status - e.g.: Number of entry nodes online, and other statistics? 
`public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerUserPresenceChange `[`PS_SDK_NODISCARD`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1adc4da95509e7f6f71e22fa5dd7310c33)`(const std::string & userId,std::function< void(bool isActive)> handler)` | Register for an event to determine the current user presence. Will call back with initial presence at time of request and presence as it changes 
`public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerApplicationExit `[`PS_SDK_NODISCARD`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1afb2c0444858d0a5a9bd55c3e8721f8b9)`(std::function< `[`OnApplicationExit`](doxygen/md/OnApplicationExit.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1aaf4923919419f175e48f166677c431c1)` > handler)` | Register for an event when general SDK error happened 
`typedef `[`KeyPair`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a789ef2f0eedf83d4a989c3c39465cf56) | 
`typedef `[`ChannelPtr`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ac56fb7c0d09a5f748442083bad079e27) | 
`typedef `[`OnApplicationReady`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a8604c740afb08f9ab110e2469810820c) | 
`typedef `[`OnApplicationExit`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1aaf4923919419f175e48f166677c431c1) | 
`typedef `[`OnChannelRequested`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a51f9a04978a7436e3eeaa5e2c0da1edd) | 
`typedef `[`OnNetworkStatus`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1abaff3cceaf2beac7efdd400f2f857f97) | 
`typedef `[`OnUserPresenceChange`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a6395346310de7caf9b4d2363676071f2) | 
`typedef `[`OnChannelConfirmed`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a6241b4695574cd9c43eb4290ac5dcaa5) | 
`typedef `[`OnChannelRequestError`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ad3a9dd4de3a22c5bb17f468c764bac45) | 
`typedef `[`OnRegisterSuccess`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ab635b3ba9bfd8e0fa3640cddaa44f7b1) | 
`typedef `[`OnRegisterFailure`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a3b2ca02d07a2a324443db06c15967a7d) | 
`typedef `[`OnUserLoaded`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a7c355e760a8895dfb4bbc5acbc4f6ebe) | 
`typedef `[`OnLoginSuccess`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a498b6633cddd19db8a79363405d54cc9) | 
`typedef `[`OnLoginFailure`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ab315cda42ff5c158fe131c80d3eb3845) | 
`typedef `[`OnLookupResult`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a2bd61905f00016ad176c667aaa798554) | 
`typedef `[`VideoStreamID`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a79d605d339014c39153d13f29f3da224) | 
`typedef `[`Action`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1af08795415cdbd15b44d0995a7b1af8b1) | 

## Members

#### `public inline virtual  `[`~IClientApp`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a634c0ae405aaf051dfc72ed0d28a4217)`()` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a634c0ae405aaf051dfc72ed0d28a4217}

#### `public void `[`start`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a3656109f345c4799ca766bd64878c2e1)`()` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a3656109f345c4799ca766bd64878c2e1}

Call this to start the client app.

#### `public void `[`stop`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1aed3cb4d9c92b3612dea91406ead8e401)`()` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1aed3cb4d9c92b3612dea91406ead8e401}

Call this to stop the client app.

#### `public void `[`setMinLogLevel`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a26b3f2e773d8e8c0b054e3abaccd6159)`(const `[`LogLevel`](doxygen/md/LogLevel.md#namespacepeerstream_1_1peerstream_1_1client_1a87d4e19670413f5103aaf81e29f6035f)` & level)` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a26b3f2e773d8e8c0b054e3abaccd6159}

#### `public void `[`setStdoutLoggingEnabled`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a0c104f034ba6654e351fcc26d458088f)`(bool isEnabled)` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a0c104f034ba6654e351fcc26d458088f}

Set to true to enable STD output, set to false to disable.

#### `public void `[`executeAsync`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a1018b65a1f8814963f2562d5b6279767)`(std::function< `[`Action`](doxygen/md/Action.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1af08795415cdbd15b44d0995a7b1af8b1)` > action)` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a1018b65a1f8814963f2562d5b6279767}

Method to execute an action on [IClientApp](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app)'s processing task, which ensures that all operations occur in a serial manner 
#### Parameters
* `action`

#### `public void `[`log`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ad57e6f685dd65f8f8317a098b6712852)`(const std::string & componentName,const `[`LogLevel`](doxygen/md/LogLevel.md#namespacepeerstream_1_1peerstream_1_1client_1a87d4e19670413f5103aaf81e29f6035f)` & level,const char * file,const char * function,size_t line,const std::string & msg)` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ad57e6f685dd65f8f8317a098b6712852}

Helper method for logging using SDK logging 
#### Parameters
* `componentName` The name of the component to log from 

* `file` The file of the log location 

* `function` The function of the log location 

* `line` The line of the log location 

* `level` The log level we're logging at 

* `msg` The log message

#### `public void `[`registerUser`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1abb647e078df3d115a45d4c95ad4e52fa)`(std::function< `[`OnRegisterSuccess`](doxygen/md/OnRegisterSuccess.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ab635b3ba9bfd8e0fa3640cddaa44f7b1)` > onRegisterSucceeded,std::function< `[`OnRegisterFailure`](doxygen/md/OnRegisterFailure.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a3b2ca02d07a2a324443db06c15967a7d)` > onRegisterFailure)` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1abb647e078df3d115a45d4c95ad4e52fa}

Method to register a new user. NOTE: If the user is already logged in, onRegisterFailure() will be called with a code to indicate the attempt to register an additional user while logged in. 
#### Parameters
* `onRegisterSucceeded` Callback for when registration is successful 

* `onRegisterFailure` Callback for when registration fails

#### `public void `[`login`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1af45461822a290e8305f53eae4ed30453)`(`[`UserRegistrationData`](doxygen/md/peerstream::peerstream::client::UserRegistrationData.md#structpeerstream_1_1peerstream_1_1client_1_1_user_registration_data)` userRegData,std::function< `[`OnLoginSuccess`](doxygen/md/OnLoginSuccess.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a498b6633cddd19db8a79363405d54cc9)` > onLoginSucceeded,std::function< `[`OnLoginFailure`](doxygen/md/OnLoginFailure.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ab315cda42ff5c158fe131c80d3eb3845)` > onLoginFailure)` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1af45461822a290e8305f53eae4ed30453}

Log in a user with the underlying authentication system. This loads a user from the specified user registration data structure and verifies their identity with the system, along with a valid certificate. NOTE: If the user is already logged in and the attempt is to log in the same user, onLoginSucceeded() is called back and no further processing occurs. NOTE: If the user is already logged in adn the attempt is to log in a different user, onLoginFailure() will be called back with an appropriate code to indicate the attempt to log in a different user while already logged in. 
#### Parameters
* `userRegData` Registration data for the user 

* `onLoginSucceeded` Callback for when login is successful 

* `onLoginFailure` Callback for when login fails

#### `public std::string `[`identity`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a8ecf3cd0cf82e09513d3bea54eb51e6c)`() const` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a8ecf3cd0cf82e09513d3bea54eb51e6c}

Retrieve the identity of the user.

#### `public IVideoStreamer & `[`videoStreamer`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a7039b4a48655fb92fa58cf1b116db337)`()` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a7039b4a48655fb92fa58cf1b116db337}

Retrieve interface to video streamer, used if broadcasting video to the psp network

#### `public void `[`createChannel`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ac12439fc3e1be85b6efa9425b14ca8ad)`(const std::string & userId,std::function< `[`OnChannelConfirmed`](doxygen/md/OnChannelConfirmed.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a6241b4695574cd9c43eb4290ac5dcaa5)` > onChannelConfirmed,std::function< `[`OnChannelRequestError`](doxygen/md/OnChannelRequestError.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ad3a9dd4de3a22c5bb17f468c764bac45)` > onError,ChannelSecurity security)` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ac12439fc3e1be85b6efa9425b14ca8ad}

Use this to create a new channel to the specified user. The user will either respond by creating the channel or it could fail by one of the mechanisms described in the ChannelRequestErrorID enum. 
#### Parameters
* `userId` of the User that we would like to create a channel with 

* `onChannelConfirmed` Callback for when a channel is created 

* `onError` Callback for when channel creation fails due to a reason specified in the enum 

* `security` The security of the channel (relates to number of hops for underlying circuits)

#### `public void `[`confirmChannel`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a91e9947479f6bb4be1d2592d544dc9ae)`(const std::string & userId,std::function< `[`OnChannelConfirmed`](doxygen/md/OnChannelConfirmed.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a6241b4695574cd9c43eb4290ac5dcaa5)` > onChannelConfirmed,std::function< `[`OnChannelRequestError`](doxygen/md/OnChannelRequestError.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ad3a9dd4de3a22c5bb17f468c764bac45)` > onError,ChannelSecurity security)` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a91e9947479f6bb4be1d2592d544dc9ae}

Use this to confirm a requested channel to the specified user. The user has already indicated their desire to communicate with you, but it can still fail due to network errors, disconnections, etc... If it succeeds, you will receive a callback, and if it fails, there is another callback to handle this. 
#### Parameters
* `userId` of the User that we would like to confirm a channel with 

* `onChannelConfirmed` Callback for when a channel is created 

* `onError` Callback for when channel creation fails due to a reason specified in the enum 

* `security` The security of the channel (relates to number of hops for underlying circuits)

#### `public void `[`denyChannel`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a44dc345f445d3989833aaeab4cbae2c5)`(const std::string & userId)` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a44dc345f445d3989833aaeab4cbae2c5}

Use this method to deny a channel request to a specific user. If any network failures occur, they are transparent to the client. 
#### Parameters
* `userId` The user ID that we are denying

#### `public `[`KeyPair`](doxygen/md/KeyPair.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a789ef2f0eedf83d4a989c3c39465cf56)` `[`generateKeyPair`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a5c82bd10daf4002bb28740f182bc6667)`() const` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a5c82bd10daf4002bb28740f182bc6667}

#### `public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` `[`registerApplicationReady`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a56b3dae1c225cb035d04cb458c847cb3)`(std::function< `[`OnApplicationReady`](doxygen/md/OnApplicationReady.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a8604c740afb08f9ab110e2469810820c)` > handler)` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a56b3dae1c225cb035d04cb458c847cb3}

Use this to register for a notification that the application is fully started.

#### `public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerChannelRequested `[`PS_SDK_NODISCARD`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1aef95d4d751be61eaa3b9fdfd73f4f163)`(std::function< `[`OnChannelRequested`](doxygen/md/OnChannelRequested.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a51f9a04978a7436e3eeaa5e2c0da1edd)` > handler)` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1aef95d4d751be61eaa3b9fdfd73f4f163}

#### Parameters
* `handler` The handler to call back when network status is available

#### `public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerNetworkStatus `[`PS_SDK_NODISCARD`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a676a73fcbac5ee5b2264bbc0788cc517)`(std::function< `[`OnNetworkStatus`](doxygen/md/OnNetworkStatus.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1abaff3cceaf2beac7efdd400f2f857f97)` > handler)` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a676a73fcbac5ee5b2264bbc0788cc517}

Register for network status - e.g.: Number of entry nodes online, and other statistics? 
#### Parameters
* `handler` The handler to call back when network status is available

#### `public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerUserPresenceChange `[`PS_SDK_NODISCARD`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1adc4da95509e7f6f71e22fa5dd7310c33)`(const std::string & userId,std::function< void(bool isActive)> handler)` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1adc4da95509e7f6f71e22fa5dd7310c33}

Register for an event to determine the current user presence. Will call back with initial presence at time of request and presence as it changes 
#### Parameters
* `The` user who you'd like to monitor the presence of 

* `handler` The handler to call back upon presence changes

#### `public `[`core::signals::ConnectionPtr`](doxygen/md/ConnectionPtr.md#namespacepeerstream_1_1core_1_1signals_1aca3fd2deaf3c0f573c485c8e8ab0b31d)` registerApplicationExit `[`PS_SDK_NODISCARD`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1afb2c0444858d0a5a9bd55c3e8721f8b9)`(std::function< `[`OnApplicationExit`](doxygen/md/OnApplicationExit.md#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1aaf4923919419f175e48f166677c431c1)` > handler)` {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1afb2c0444858d0a5a9bd55c3e8721f8b9}

Register for an event when general SDK error happened 
#### Parameters
* `handler` The handler to call back upon error happened

#### `typedef `[`KeyPair`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a789ef2f0eedf83d4a989c3c39465cf56) {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a789ef2f0eedf83d4a989c3c39465cf56}

#### `typedef `[`ChannelPtr`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ac56fb7c0d09a5f748442083bad079e27) {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ac56fb7c0d09a5f748442083bad079e27}

#### `typedef `[`OnApplicationReady`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a8604c740afb08f9ab110e2469810820c) {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a8604c740afb08f9ab110e2469810820c}

#### `typedef `[`OnApplicationExit`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1aaf4923919419f175e48f166677c431c1) {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1aaf4923919419f175e48f166677c431c1}

#### `typedef `[`OnChannelRequested`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a51f9a04978a7436e3eeaa5e2c0da1edd) {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a51f9a04978a7436e3eeaa5e2c0da1edd}

#### `typedef `[`OnNetworkStatus`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1abaff3cceaf2beac7efdd400f2f857f97) {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1abaff3cceaf2beac7efdd400f2f857f97}

#### `typedef `[`OnUserPresenceChange`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a6395346310de7caf9b4d2363676071f2) {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a6395346310de7caf9b4d2363676071f2}

#### `typedef `[`OnChannelConfirmed`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a6241b4695574cd9c43eb4290ac5dcaa5) {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a6241b4695574cd9c43eb4290ac5dcaa5}

#### `typedef `[`OnChannelRequestError`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ad3a9dd4de3a22c5bb17f468c764bac45) {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ad3a9dd4de3a22c5bb17f468c764bac45}

#### `typedef `[`OnRegisterSuccess`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ab635b3ba9bfd8e0fa3640cddaa44f7b1) {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ab635b3ba9bfd8e0fa3640cddaa44f7b1}

#### `typedef `[`OnRegisterFailure`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a3b2ca02d07a2a324443db06c15967a7d) {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a3b2ca02d07a2a324443db06c15967a7d}

#### `typedef `[`OnUserLoaded`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a7c355e760a8895dfb4bbc5acbc4f6ebe) {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a7c355e760a8895dfb4bbc5acbc4f6ebe}

#### `typedef `[`OnLoginSuccess`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a498b6633cddd19db8a79363405d54cc9) {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a498b6633cddd19db8a79363405d54cc9}

#### `typedef `[`OnLoginFailure`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ab315cda42ff5c158fe131c80d3eb3845) {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1ab315cda42ff5c158fe131c80d3eb3845}

#### `typedef `[`OnLookupResult`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a2bd61905f00016ad176c667aaa798554) {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a2bd61905f00016ad176c667aaa798554}

#### `typedef `[`VideoStreamID`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a79d605d339014c39153d13f29f3da224) {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1a79d605d339014c39153d13f29f3da224}

#### `typedef `[`Action`](#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1af08795415cdbd15b44d0995a7b1af8b1) {#classpeerstream_1_1peerstream_1_1client_1_1_i_client_app_1af08795415cdbd15b44d0995a7b1af8b1}

