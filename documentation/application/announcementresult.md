# Announce Result

## Definition

This message is the result of an announcement and returns information about whether or not the announcement failed. If the announcement failed, it provides the reason for this failure.

## Operation
Once the client sends the announce presence message, it should check for this confirmation message. For this purpose, the client should be listening for this application level message.
C++ Example:
```asm
circuitConnections_[newCircuit->streamID()].push_back(
    newCircuit->registerEscape<AnnouncementResult>(
        task_, EscapeMessageId::announcementResult, [=](AnnouncementResult res) {
            onAnnouncementResult(newCircuit, res);
        }));
```
Method registerEscape takes care about deserializing message.

## Payload

```
message AnnouncementResult {
    enum resultType {
        success = 0;
        formatError = 1;
        expirationInvalid = 2;
        signatureInvalid = 3;
        internalError = 4;
        alreadyRegistered = 5;
    }

    resultType result = 1;
}
```

### AnnouncementResult::resultType

ID|Name|Type|Desc
--|----|----|----
0|success|enum|The request succeeded and a certificate exists in bytes
1|formatError|enum|The format of the provided certificate was in error
2|expirationInvalid|enum|The requested expiration times of the certificate were outside the current date time range
3|signatureInvalid|enum|The signature did not match the expected and therefore the request was viewed as fraudulent and rejected
4|internalError|enum|PSP declared an error which does not match one of the other cases
5|alreadyRegistered|enum|The entity was already registered

### AnnouncementResult

ID|Name|Type|Desc
--|----|----|----
1|result|resultType|The result of the announcement
