Return-Path: <linux-nfs+bounces-12776-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CB9AE8C56
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 20:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC3F4A14A4
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 18:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB5A25C6EF;
	Wed, 25 Jun 2025 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="ifQ92Ggg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DE825C81F
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875998; cv=none; b=fy3aXOjoDLm+Kf/gRvQjQs3VwFhPNkzDblW2W6klaIaEMOoi7vyvwZ2y0wX+tNn5fEkoF8gKc8P7k9hW0UYaRxhDlVEclemr3Tf9v9lgnl62zTGiQkQezNNLkj0hAF7ktAlGJETyxuTbH+Qd4WdBNix4xVtLTA0QuB4RU+Liuk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875998; c=relaxed/simple;
	bh=CO9lavWrEiFwq3biz7JOApzyEFJ8y5f8brceB6DYlgs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=U1gecneq2+pd6WDS9CCFjI+hO38UywEfQ2dZqVjE/U+pfY2O/PtchOOmmghNvwvvRvQ6EFdh2i0wWoirXyfiQxRJAZtFlrMV4V0zKwlSK0Tuo3l4LwBPCXw7Ff6FQIUOPorEYvsioyPci+jVIXnTFT7F+cH6oCeD5gGbMstaE6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=ifQ92Ggg; arc=none smtp.client-ip=131.169.56.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-1.desy.de (Postfix) with ESMTP id D24D511F749
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 20:26:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de D24D511F749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1750875993; bh=OZr/5pirABA7qlqDDIztOXYA8gp9gcuB0uNWbb3IG/0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ifQ92GggrzrUS3rZ7u8zzNgWfkQ9t406EOF2TKauizSgEII/rKiSGEo1BkUhZDsSA
	 o1bG37UzYqYv1guolz6aVrcodW+zaHeiquZLMffea5yWEr91NEQBDpzkZ6VekzSEvb
	 dct/6FIJaWuZyTZNrRINPKImKYZL2SIXTLHOhqfk=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id C46AF120043;
	Wed, 25 Jun 2025 20:26:33 +0200 (CEST)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [194.95.235.47])
	by smtp-m-2.desy.de (Postfix) with ESMTP id B91DE16003F;
	Wed, 25 Jun 2025 20:26:33 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by b1722.mx.srv.dfn.de (Postfix) with ESMTP id A46C3160058;
	Wed, 25 Jun 2025 20:26:31 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 4DD9920044;
	Wed, 25 Jun 2025 20:26:31 +0200 (CEST)
Date: Wed, 25 Jun 2025 20:26:31 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chen Hanxiao <chenhx.fnst@fujitsu.com>, 
	Calum Mackay <calum.mackay@oracle.com>, 
	linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1605056536.14463638.1750875991126.JavaMail.zimbra@desy.de>
In-Reply-To: <782448d09ed170e097e112434848c771e08b017b.camel@kernel.org>
References: <20250625080208.1424-1-chenhx.fnst@fujitsu.com> <782448d09ed170e097e112434848c771e08b017b.camel@kernel.org>
Subject: Re: [PATCH] pynfs: Fix RuntimeError by increasing default
 ca_maxrequests from 8 to 16
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_14463639_2086259342.1750875991252"
X-Mailer: Zimbra 9.0.0_GA_4769 (ZimbraWebClient - FF140 (Linux)/9.0.0_GA_4769)
Thread-Topic: pynfs: Fix RuntimeError by increasing default ca_maxrequests from 8 to 16
Thread-Index: YcQuUGc3aU5SD3BmNTbStCYRh97CaA==

------=_Part_14463639_2086259342.1750875991252
Date: Wed, 25 Jun 2025 20:26:31 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chen Hanxiao <chenhx.fnst@fujitsu.com>, 
	Calum Mackay <calum.mackay@oracle.com>, 
	linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1605056536.14463638.1750875991126.JavaMail.zimbra@desy.de>
In-Reply-To: <782448d09ed170e097e112434848c771e08b017b.camel@kernel.org>
References: <20250625080208.1424-1-chenhx.fnst@fujitsu.com> <782448d09ed170e097e112434848c771e08b017b.camel@kernel.org>
Subject: Re: [PATCH] pynfs: Fix RuntimeError by increasing default
 ca_maxrequests from 8 to 16
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4769 (ZimbraWebClient - FF140 (Linux)/9.0.0_GA_4769)
Thread-Topic: pynfs: Fix RuntimeError by increasing default ca_maxrequests from 8 to 16
Thread-Index: YcQuUGc3aU5SD3BmNTbStCYRh97CaA==


I guess this is the same issue that I tried to address with

https://lore.kernel.org/all/20250415114814.285400-1-tigran.mkrtchyan@desy.de/

DELEG 8 goes into a retry loop if the server responds NFS4ERR_DELAY when the server tries to recall the delegation and responds with NFS4ERR_DELAY to the client. The handling of a compound call will retry and re-use the slot.
The handling of DELEG8 will retry, too, but use a new slot. AFAIKS, slots are never freed:


```
$ git grep slot.inuse -- nfs4.1/nfs4client.py                                                                                         
nfs4.1/nfs4client.py:                if not slot.inuse:
nfs4.1/nfs4client.py:                    slot.inuse = True
```



So fails...


```
    def choose_slot(self):
        self.lock.acquire()
        try:
            for slot in self.slots:
                if not slot.inuse:
                    slot.inuse = True
                    return slot
            raise RuntimeError("Out of slots")
        finally:
            self.lock.release()
```

It looks like all the tests up to now have issued less than ca_maxrequests:)

The proper fix probably should be someting like:

diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
index f4fabcc..fe404cd 100644
--- a/nfs4.1/nfs4client.py
+++ b/nfs4.1/nfs4client.py
@@ -551,6 +551,7 @@ class SessionRecord(object):
                 # operation itself receives NFS4ERR_DELAY
                 slot, seq_op = self._prepare_compound(saved_kwargs)
             time.sleep(delay_time)
+        slot.inuse = False
         res = self.remove_seq_op(res)
         return res



Tigran.

----- Original Message -----
> From: "Jeff Layton" <jlayton@kernel.org>
> To: "Chen Hanxiao" <chenhx.fnst@fujitsu.com>, "Calum Mackay" <calum.mackay@oracle.com>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Wednesday, 25 June, 2025 15:58:51
> Subject: Re: [PATCH] pynfs: Fix RuntimeError by increasing default ca_maxrequests from 8 to 16

> On Wed, 2025-06-25 at 16:00 +0800, Chen Hanxiao wrote:
>> Increased the default value of ca_maxrequests from 8 to 16 to address a
>> RuntimeError encountered in DELEG8.
>> 
>> This change resolves the issue where
>> DELEG8 st_delegation.testDelegRevocation
>> fails with a RuntimeError: "Out of slots".
>> 
>> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
>> ---
>>  nfs4.1/nfs4client.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
>> index f4fabcc..fa31b34 100644
>> --- a/nfs4.1/nfs4client.py
>> +++ b/nfs4.1/nfs4client.py
>> @@ -390,7 +390,7 @@ class ClientRecord(object):
>>                         fore_attrs=None, back_attrs=None, sec=None,
>>                         prog=None,
>>                         max_retries=1, delay_time=1):
>> -        chan_attrs = channel_attrs4(0,8192,8192,8192,128,8,[])
>> +        chan_attrs = channel_attrs4(0,8192,8192,8192,128,16,[])
>>          if fore_attrs is None:
>>              fore_attrs = chan_attrs
>>          if back_attrs is None:
> 
> Increasing the size should be harmless, but it doesn't look like DELEG8
> does a lot of concurrent RPCs. How is this running out of slots?
> 
> --
> Jeff Layton <jlayton@kernel.org>

------=_Part_14463639_2086259342.1750875991252
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
MBwGCSqGSIb3DQEJBTEPFw0yNTA2MjUxODI2MzFaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIDqYN0xxGAqMRCLF/nXiJD0J8UPd
Pcn1vb22V7y4JAMZMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICACIPt5xDcbY+0cH8YPKCn7z6hiKbDWDHPwX8dR0T
05rUCHjASokwL/bWIiyngU5e4ggJV+vZZklZLFy7r/GYDZMGQNZEc/TOpUZxJiXDK2vvLisagodc
fixfp0UyuzqnLvBj3u/JZCX+sWHm0OyQzlXI46kvov8d+bd5jBUuYFN3lCzsFUtCkQOPaCzVpy1Q
5YOm4ENORctDaTKCIshBnPnMoycnNcbZiezR/nQkqLtXcM3qlrKx6iIMXPkjUwftE6e3TaBYuXcn
Ydeba5aIFLliyJtO1hAVUG5370U08OdrMe157iJ46nRQXU1SlIsLfobpl3b51iCd9invCGwf4/IH
b+ayTEeteaJpg1NZn3w0o7k7q3xjNJwJ1Lz+MtEPiZJhvbWWRtPIyvdjhcGuLAdFUuRKrP1X1Zsw
za4069VGoNFf5J5mxRAQlEFn0QGUwLTSPGEKRhP5VRC+dvitgmllbFrhW6f46T6p8TbQvLeW9RFZ
49Zk6gmjP6BxNr56keOlpzeHNt99tE8LUs9ximPb4hE0lJ/oyWZe/yir+770Cfb3Doo6ILz6tNb4
LtBa25RehDwFTNQaDMqUoqX9sG+l4n0Hxd95O37goM1zIJQCDiFj8i9g9mFGCqsQhTYeREiu+I2f
EJANvacxQodddfD2fpBIvRCX0AiMR+cUJlX3AAAAAAAA
------=_Part_14463639_2086259342.1750875991252--

