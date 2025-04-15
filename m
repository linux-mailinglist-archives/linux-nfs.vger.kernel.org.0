Return-Path: <linux-nfs+bounces-11141-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2917A8A1D1
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Apr 2025 16:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D073E441E9A
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Apr 2025 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A392973BE;
	Tue, 15 Apr 2025 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="rZlKy59F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55E297A40
	for <linux-nfs@vger.kernel.org>; Tue, 15 Apr 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728567; cv=none; b=mzbpQXWHpe+mLbG/OFoLdCMrBH80atcFlT5Z61Nztgk2ATb/lfsYH5KxMwfrH9EwMlNYO8umnJrqC+9lnAXXgLHknYam5t1STBZhQ97Irs9yXNbANBfGZphxq7z05LbzUyGsPg6ZPfcVv8giLBz/JQnmw2nHaUckX8F/pTK28+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728567; c=relaxed/simple;
	bh=a97Mlu0hFAMIjHLIr8ZqFabRyI+4TfXIar5z2rU6Hn8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Ph0lKIgq5do/hIzCsw8e7IBNuxSi3AUiYwwUhB4qbIe/xA9XWp3aWGQpH+KCzC0he6Npzf4ms6jL599s1c5wfI2tBERwa1f3TgY9zADdtHMkg30hD6s1c4dYN17kTBQokLmSvm1w+n8yB6QXCBOLRVO0mnZKbrC3L3VtY31d5rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=rZlKy59F; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 249E913F647
	for <linux-nfs@vger.kernel.org>; Tue, 15 Apr 2025 16:49:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 249E913F647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1744728556; bh=/hYCj25gZwgh9zjBvBTcDEKYpBSc5IEVHOXX7mF7YXQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rZlKy59Fd9IRJ22IAfTKDIyrB93/UAYOXxNDfESVdHA+i/TqeFHnlv38v4VRTBkcu
	 DdiLKLZ+z1yqYdQ3+Lz7LzR3/ixIpRal+6SeVf994T4gDKMhf4Fs9XFUwGO7eC4isg
	 tQyer+FqOdqVWaweH5OHm5Ha8V3pnJnPTuslX04I=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 18DCA120043;
	Tue, 15 Apr 2025 16:49:16 +0200 (CEST)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [IPv6:2001:638:d:c302:acdc:1979:2:e7])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 0EE0940044;
	Tue, 15 Apr 2025 16:49:16 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by b1722.mx.srv.dfn.de (Postfix) with ESMTP id 4EE54160059;
	Tue, 15 Apr 2025 16:49:14 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 1C48220044;
	Tue, 15 Apr 2025 16:49:14 +0200 (CEST)
Date: Tue, 15 Apr 2025 16:49:13 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>, 
	linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <865403842.27244482.1744728553871.JavaMail.zimbra@desy.de>
In-Reply-To: <5fb69477dfb9e372e70caf6d320170f6a20927af.camel@kernel.org>
References: <20250415114814.285400-1-tigran.mkrtchyan@desy.de> <5fb69477dfb9e372e70caf6d320170f6a20927af.camel@kernel.org>
Subject: Re: [PATCH] deleg: break infinite loop in DELEG8 test
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_27244483_2037462523.1744728554060"
X-Mailer: Zimbra 9.0.0_GA_4718 (ZimbraWebClient - FF137 (Linux)/9.0.0_GA_4737)
Thread-Topic: deleg: break infinite loop in DELEG8 test
Thread-Index: 86Ejh6Wg87gsfDadJqiPNw+u24dukg==

------=_Part_27244483_2037462523.1744728554060
Date: Tue, 15 Apr 2025 16:49:13 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: Calum Mackay <calum.mackay@oracle.com>, 
	linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <865403842.27244482.1744728553871.JavaMail.zimbra@desy.de>
In-Reply-To: <5fb69477dfb9e372e70caf6d320170f6a20927af.camel@kernel.org>
References: <20250415114814.285400-1-tigran.mkrtchyan@desy.de> <5fb69477dfb9e372e70caf6d320170f6a20927af.camel@kernel.org>
Subject: Re: [PATCH] deleg: break infinite loop in DELEG8 test
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4718 (ZimbraWebClient - FF137 (Linux)/9.0.0_GA_4737)
Thread-Topic: deleg: break infinite loop in DELEG8 test
Thread-Index: 86Ejh6Wg87gsfDadJqiPNw+u24dukg==

In general, I want, but it's already happens on handling compound call:

```
        for item in range(max_retries):
            res = self.c.compound([seq_op] + ops, **kwargs)
            res = self.update_seq_state(res, slot)
            if res.status != NFS4ERR_DELAY or not handle_state_errors:
                break
            if res.resarray[0].sr_status != NFS4ERR_DELAY:
                # As per errata ID 2006 for RFC 5661 section 15.1.1.3
                # don't update the slot and sequence ID if the sequence
                # operation itself receives NFS4ERR_DELAY
                slot, seq_op = self._prepare_compound(saved_kwargs)
            time.sleep(delay_time)
```

Tigran.

----- Original Message -----
> From: "Jeff Layton" <jlayton@kernel.org>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>, "Calum Mackay" <calum.mackay@oracle.com>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Tuesday, 15 April, 2025 16:10:11
> Subject: Re: [PATCH] deleg: break infinite loop in DELEG8 test

> On Tue, 2025-04-15 at 13:48 +0200, Tigran Mkrtchyan wrote:
>> The test assumes that the server can return either OK or DELAY,
>> however, the 'break' condition checks only for OK.
>> 
>> Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
>> ---
>>  nfs4.1/server41tests/st_delegation.py | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/nfs4.1/server41tests/st_delegation.py
>> b/nfs4.1/server41tests/st_delegation.py
>> index ea4c073..60b0de6 100644
>> --- a/nfs4.1/server41tests/st_delegation.py
>> +++ b/nfs4.1/server41tests/st_delegation.py
>> @@ -181,8 +181,8 @@ def testDelegRevocation(t, env):
>>                          owner, how, claim)
>>      while 1:
>>          res = sess2.compound(env.home + [open_op])
>> -        if res.status == NFS4_OK:
>> -            break;
>> +        if res.status == NFS4_OK or res.status == NFS4ERR_DELAY:
>> +            break
>>          check(res, [NFS4_OK, NFS4ERR_DELAY])
>>          # just to keep sess1 renewed.  This is a bit fragile, as we
>>          # depend on the above compound waiting no longer than the
> 
> Don't you want to loop on NFS4ERR_DELAY?
> 
> It looks like this is supposed to loop (with no DELEGRETURN) until the
> open returns NFS4_OK. Presumably at that point the delegation will be
> revoked and you'll get the expected errors.
> --
> Jeff Layton <jlayton@kernel.org>

------=_Part_27244483_2037462523.1744728554060
Content-Type: application/pkcs7-signature; name=smime.p7s; smime-type=signed-data
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCAMIIH
XzCCBUegAwIBAgIQGrSZ0tLzGu9JoeeaXGroSzANBgkqhkiG9w0BAQwFADBVMQswCQYDVQQGEwJO
TDEZMBcGA1UEChMQR0VBTlQgVmVyZW5pZ2luZzErMCkGA1UEAxMiR0VBTlQgVENTIEF1dGhlbnRp
Y2F0aW9uIFJTQSBDQSA0QjAeFw0yNDEyMDQwOTQzMjZaFw0yNjAxMDMwOTQzMjZaMIGpMRMwEQYK
CZImiZPyLGQBGRMDb3JnMRYwFAYKCZImiZPyLGQBGRMGdGVyZW5hMRMwEQYKCZImiZPyLGQBGRMD
dGNzMQswCQYDVQQGEwJERTEuMCwGA1UEChMlRGV1dHNjaGVzIEVsZWt0cm9uZW4tU3luY2hyb3Ry
b24gREVTWTEoMCYGA1UEAwwfVGlncmFuIE1rcnRjaHlhbiB0aWdyYW5AZGVzeS5kZTCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBAKZ1aJleygPW8bRzYJ3VfXwfY2TxAF0QUuTk/6Bqu8Bi
UQjIgmBQ1hCzz8DVdJ8saw7p5/c1JDmVHqm2DJPwXLROKACiDdSHPf+N8PFZvxHxOqFNPeO/oJhO
jHXG1c/tL8ElfiUlMtEZYtoS60/VUz3A/4FIWP2A5s/UIOSZyCcKz3AUcAanHGEJVS8oWKQj7pNX
yjojvX4aPHzsKP+c+c/5wq08/aziRXLCekhKk+VdS8lhlS/3AL1G0VSWKj5/pOpz4ozmv44GEw9z
FAsPWuTcLXqCX993BOoWAyQDcygAsb0nQQMzx+4wlSGsI31/gKOE5ZOJ3SErWDswgzxWm8Xht/Kl
ymDHPXi8P0ohQjJrQRpJXVwD/tXDwSSbWP9jnVbtqpvLLBkNrSy6elW19nkE1ObpSPcn+be5hs1P
59Y+GPudytAQ3MOoFoNd7kxpVQoM6cdQjRHdyIDbavZrdxr33s7uqSbcI/PE8W5M0iPNnd4ip4kH
UIOdpsjk7b7kEdO4Jf9dDrz/fduAEaW+AUTfb+G42LiftUBXkANa50nOseW3tocadYOTySufN9or
IwvcQ/1uemVd83On7k8bWevfU159x28aidxv8liqJXrrT28tp/QxtGtDXjo9jdkWi/5d/9XfqQgN
IT7KH42fc3ZlaL3pLuJwEQWVtFnWUTRJAgMBAAGjggHUMIIB0DAfBgNVHSMEGDAWgBQQMuoC4vzP
6lYlVIfDmPXog9bFJDAOBgNVHQ8BAf8EBAMCBaAwCQYDVR0TBAIwADAdBgNVHSUEFjAUBggrBgEF
BQcDAgYIKwYBBQUHAwQwRQYDVR0gBD4wPDAMBgoqhkiG90wFAgIFMA0GCyqGSIb3TAUCAwMDMA0G
CyqGSIb3TAUCAwECMA4GDCsGAQQBgcRaAgMCAjBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8vY3Js
LmVudGVycHJpc2Uuc2VjdGlnby5jb20vR0VBTlRUQ1NBdXRoZW50aWNhdGlvblJTQUNBNEIuY3Js
MIGRBggrBgEFBQcBAQSBhDCBgTBPBggrBgEFBQcwAoZDaHR0cDovL2NydC5lbnRlcnByaXNlLnNl
Y3RpZ28uY29tL0dFQU5UVENTQXV0aGVudGljYXRpb25SU0FDQTRCLmNydDAuBggrBgEFBQcwAYYi
aHR0cDovL29jc3AuZW50ZXJwcmlzZS5zZWN0aWdvLmNvbTAjBgNVHREEHDAagRh0aWdyYW4ubWty
dGNoeWFuQGRlc3kuZGUwHQYDVR0OBBYEFMmhx6vILo+tVVV6rojJTwL+t2eGMA0GCSqGSIb3DQEB
DAUAA4ICAQARKKJEO1G3lIe+AA+E3pl5mNYs/+XgswX1316JYDRzBnfVweMR6IaOT7yrP+Mwhx3v
yiM8VeSVFtfyLlV6FaHAxNFo5Z19L++g/FWWAg0Wz13aFaEm0+KEp8RkB/Mh3EbSukZxUqmWCgrx
zmx+I5zlX8pLxNgrxcc1WW5l7Y7y2sci++W6wE/L7rgMuznqiBLw/qwnkXAeQrw2PIllAGwRqrwa
37kPa+naT1P0HskuBFHQSmMihB5HQl6+2Rs9M5RMW3/IlUQAqkhZQGBXmiWDivjPFKXJQnCmhQmh
76sOcSOScfzYI5xOD+ZGdBRRufkUxaXJ2G//IgkK2R8mqrFEXxBFaBMc0uMBJHKNv+FO7H6VPOe9
BD9FwfLiqWvGwKJrF11Bk/QSfWh+zCJ8JHPAi6irwQO4Xf+0xhPsxb+jBfKK3I84YMf6zsDkdDzH
lkNPhDh4xhYhEAk+L228pjTEmnbb2QVv52grZ0dbITuN+Hz2ypvLfaS8p06lrht45COlkmuIUVqp
bsc3kRt610qwXSjYcc8zeCQI0Rqnnq+0UN5T0KU7JSzUho6vaTSUG57uc7b3DkIW2Z9VpXX5xKb/
vfl++jC5JzKrbCeS+QOStpXwwaH62IUHwdfWfkvpzb8EFALEmCvu8nlT9NaqYlB/xogMH6oHBm+Y
nxmRQxWROAAAMYIDZTCCA2ECAQEwaTBVMQswCQYDVQQGEwJOTDEZMBcGA1UEChMQR0VBTlQgVmVy
ZW5pZ2luZzErMCkGA1UEAxMiR0VBTlQgVENTIEF1dGhlbnRpY2F0aW9uIFJTQSBDQSA0QgIQGrSZ
0tLzGu9JoeeaXGroSzANBglghkgBZQMEAgEFAKCBzjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yNTA0MTUxNDQ5MTRaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIINbA1tT6EgG9TgpUd09d+fGNxpK
yYRrZuTwq446/MhWMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICAJ/R4TL7440Ho07fAtaYOgcjKZQzH4D3efP8J5/Y
tOGsBpgC5QMMEBYrbAWFBFgaKDQXvFIA/YI3W1Eye+rZZ648GczXsVM0pmPbfe05dZ2I2riPEwo+
5RHDVGMRvNp8fbwB+OLGVlcoAkV5ZPiGSkAwqUATlUw/bPqWj8gRESPI7Rl7lUAMo+3oJfWY30kw
vdLedU1NQMgf4CJ5um39U4WefaXXCk+zTmALt3mgNht0SGJI0fI2bNn+/mAL2dc/j2f7Fp6BFiMM
w/PNzQV1xUi93wWw/uROoTC9Aj54ilqaSNp/e6frXf0ecoT+PI0tQw8AyVedeByI3rgzoClVGsmU
jPteQu25fvYrIbMRJgl6EX5eXy2v/k6EOiQB0ruc6hd8Nmyzr4s49sQYxPoZGjvWILkdj8wap+56
oNvpUWVpV+F7nLUfiSPoUnTN1+Mo4nFJBELOVO3AphX28YsIJx9BbqAEO6ot3RLhnhRWIsZKqZ2+
SdZQlPr5sNERTRHKOCVwHId2TFPxBofgPp8TZA+WY5VaC2arJ4SauUpK2f+2mrsPoOO7PawezyMA
d2Q7NCj2CPMIzTYKAsAZzL/pZFm5IZWkHD82kLupW0JVh8RrwFNq5y9gxHG3BPMckSpbm0ZTqQoY
XqUc7pCKvStNLvhQCpB8Wp54FHqcwB5LTVErAAAAAAAA
------=_Part_27244483_2037462523.1744728554060--

