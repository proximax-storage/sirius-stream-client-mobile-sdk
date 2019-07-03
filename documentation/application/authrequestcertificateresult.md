# Auth Request Certificate Result

## Definition

After requesting an auth request certificate, the initiator will receive a response from a PSP node. The response will either be valid or will have an error code (value other than success), which indicates that the certificate was not processed for one of the reasons listed below. If valid, there is then a certificate result, which has the certificate returned by the server, which may be used for future login sessions, for the duration of the certificate. The initiator is now considered "logged in" for the specified duration and the returned certificate may be thought of as the concept of a "token".

## Operation

When receiving a auth request certificate result, it should be handled in the following way:

1. Check if the result indicates success. If failure, the application may choose to exit based on the resultant error code, or it may create a new circuit and retry.

Success:

2. Deserialize into a flat certificate from the certificate field of the result message.

C++ example:

```
auto crt = FlatCertificate::fromBinary(container_, stringToVec(result.certificate()));
```

3. Validate the certificate by verifing the signature came from a valid auth node.

4. Store the certificate in a secure way for use for the duration of the certificate lifetime.

## Payload

### AuthRequestCertificateResult::requestResult (enum)

ID|Name|Type|Desc
--|----|----|----
0|success|enum|The request succeeded and a certificate exists in bytes
1|formatError|enum|The format of the provided certificate was in error
2|unsupportedVersion|enum|The requested auth version was invalid
3|signatureInvalid|enum|The signature did not match the expected and therefore the request was viewed as fraudulent and rejected
4|internalError|enum|PSP declared an error which does not match one of the other cases

### AuthRequestCertificateResult

ID|Name|Type|Desc
--|----|----|----
1|result|requestResult|The result of the request
1|certificate|bytes|The certificated marshalled to bytes
