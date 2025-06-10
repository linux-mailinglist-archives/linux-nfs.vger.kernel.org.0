Return-Path: <linux-nfs+bounces-12259-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46167AD3A03
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 15:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3D827A6DD1
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 13:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEF92918F1;
	Tue, 10 Jun 2025 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="pUX9jXX3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565CD28B3FF
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563710; cv=none; b=P5Qk8pLBemLVrtFz7L1hcHhzu9Lpn7BFUZjuWnJiOj/VlwZIPkEGDrQDjX64Kz0+1rR1CcfKzAN+dAWEfeDUWFd9gzQxVFG3t+mh5cUmq4xAKKTIK1UHV2A1kEBVm1hT/8uYMF1//XNlD3TSICJhyFGhbJ0o80GBnTozu0iVpHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563710; c=relaxed/simple;
	bh=MfEJWqHHEKWsJuY1/vUJjFttoLnipJ4gX2W00L/kzbU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Ne7OSnuFwq/HuFzrbSdIR590I0yGV0eyLNI1pfp184Ad5Y/vHhekHdOxbOWmUkojrVdMKLqxjTo0R14PP87AHXJXy+TmW7AYmwi2+W4TDJC8iurV4YKMqrfT9OQ43pWlWkzoEbiApHDncjjeLz9Pc+8PoqnI3YeEKqzv/+wDvMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=pUX9jXX3; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 5446613F653
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 15:55:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 5446613F653
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1749563705; bh=8YYrX0lQmIxxtaZALHQSkvnv/+ePnhxOqycKA6rHJD4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=pUX9jXX3HDQj6rCY5ffRSeV88uDOvyyQgCqci2s9a6MBWLQOM1BnuUIVSOg53DETP
	 Z9NaVZph5tHKWmZhIDz5dnw0zpG8HDfRVDst9vuGqa042q013t7h5bqjHgx1HDU4I1
	 PQ0udCtWSZn85ZSYX7snMEdexBVdov3VoOllQOrY=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 4703520046;
	Tue, 10 Jun 2025 15:55:05 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [194.95.233.47])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 3C4A516003F;
	Tue, 10 Jun 2025 15:55:05 +0200 (CEST)
Received: from smtp-intra-3.desy.de (smtp-intra-3.desy.de [IPv6:2001:638:700:1038::1:45])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id AF207320096;
	Tue, 10 Jun 2025 15:55:04 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-3.desy.de (Postfix) with ESMTP id 5DE181A0041;
	Tue, 10 Jun 2025 15:55:04 +0200 (CEST)
Date: Tue, 10 Jun 2025 15:55:04 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>
Message-ID: <1488667048.5476965.1749563704151.JavaMail.zimbra@desy.de>
In-Reply-To: <F3C7A0A4-E8DB-406A-89FF-C44CA9201D44@redhat.com>
References: <20250610093451.835089-1-tigran.mkrtchyan@desy.de> <F3C7A0A4-E8DB-406A-89FF-C44CA9201D44@redhat.com>
Subject: Re: [PATCH] pnfs: add pnfs_ds_connect trace point
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_5476968_632767656.1749563704315"
X-Mailer: Zimbra 9.0.0_GA_4769 (ZimbraWebClient - FF139 (Linux)/9.0.0_GA_4769)
Thread-Topic: pnfs: add pnfs_ds_connect trace point
Thread-Index: lh81C7wa2lJcnz7PA6NbNwUCxUmCHQ==

------=_Part_5476968_632767656.1749563704315
Date: Tue, 10 Jun 2025 15:55:04 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>
Message-ID: <1488667048.5476965.1749563704151.JavaMail.zimbra@desy.de>
In-Reply-To: <F3C7A0A4-E8DB-406A-89FF-C44CA9201D44@redhat.com>
References: <20250610093451.835089-1-tigran.mkrtchyan@desy.de> <F3C7A0A4-E8DB-406A-89FF-C44CA9201D44@redhat.com>
Subject: Re: [PATCH] pnfs: add pnfs_ds_connect trace point
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4769 (ZimbraWebClient - FF139 (Linux)/9.0.0_GA_4769)
Thread-Topic: pnfs: add pnfs_ds_connect trace point
Thread-Index: lh81C7wa2lJcnz7PA6NbNwUCxUmCHQ==



----- Original Message -----
> From: "Benjamin Coddington" <bcodding@redhat.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>, "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>
> Sent: Tuesday, 10 June, 2025 14:47:23
> Subject: Re: [PATCH] pnfs: add pnfs_ds_connect trace point

> On 10 Jun 2025, at 5:34, Tigran Mkrtchyan wrote:
> 
>> this trace point aims expose pnfs ds connect status
> 
> This tracepoint aims to expose pNFS DS connect status?

Thanks, Ben.

I can send v2 if desired.

Best regards,
   Tigran.

> 
>>
>> Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
> 
> 
> Logic looks correct,
> 
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
> 
> Ben

------=_Part_5476968_632767656.1749563704315
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
MBwGCSqGSIb3DQEJBTEPFw0yNTA2MTAxMzU1MDRaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIHIieZTp1gxd9mzD1oUsowcb5TyV
BrXfvujDrdSl2/95MDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICAJbONPR/GKk0/Hnj9mwHXaXmo5d7XhNYCPPMd0q6
MW0cIUwUlUeDHZK4gQsZlbUD/JZbbkpzXBFi26uWgCF0zdu+ao2Sx63im673ERFvXDVvklU7lYyk
s6LklQvc/j73xPKMh5tsCmNXccRbIiUko+vskj7pqqtQrhNF7nfqSeN05oxxgqPs9yJF1XuPPmgp
3ZA80rWy26XmoDvu6G3ZbEsOrc8RjM2/hCVPGhhxA+yeZ+jWn55Io7R7DUCGoSCMPoTyKH8QOzYc
1aizMeF1pnzeW08sRARJIAmO4CjymjSBGnj2LO282jDzOpt6C7wAwZn3HepxSUF0Gx5Ic7obNrE9
wiSRzuCvEGs3ZKJGbdBeBcf2JnNPXedc2HqN8TYKN5zIqhiRGuYN1T5ZVaVSshKlK/R0vAErimMY
aWL6t2Wa3wWHys8kR5SJMkV6R0rvE5VS3AUnr4ECbhNvanfgIJkT9w9e9skj1XeRqKHJEvkuRG+4
rYJoDY1dsFln0dMzFhpxEXMoMTlgMXaCEQ+N8NwxYVjp1SyjijZUV+WjoA4jXVOxepSerTDOqNqR
+myevcNGdTzLYe1c+rlFQlYQYobP7drAz6CtKRvYtzgy5NqRCcsBncStTUuziLc/wXwbEMRbZ14e
gyvbBf2DrfWV3ZasB/ltfsrUalYzv5Yq33tkAAAAAAAA
------=_Part_5476968_632767656.1749563704315--

