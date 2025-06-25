Return-Path: <linux-nfs+bounces-12769-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17645AE8B69
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 19:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6FC1885E7C
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEFF26B0BC;
	Wed, 25 Jun 2025 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="ijbyLmiD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED42D3074AC
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750872038; cv=none; b=W8WyGr5cVhl+1OoMMI4Kif2yTNnPCm4kRkUhuUNwjkvQY/DlgHpWbBQsVDuCQ21Qf1ye4xM5tGYArAIC5GUYlPEa7FXgJ1wlnUPt68pTDkamXdErzvOEo9BzEwhY+2oE29HYuG/PnnjFDzSukG7oC03mwdSuLhctvNBKiFbwqaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750872038; c=relaxed/simple;
	bh=46kRxz2kzmEgki7nVKFd/TWqzD1wdiWSatuDttfII1Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ta20TzJBQF7ByovSb/zMG8IHs+4YraYISGqhXuBshTjo4Fh0uI5dMmuXn12/GCiiunvJSXlYef2z3xQlqqzQFU+HgtyOqlRif3HY2Ve5QhoLAu+8Cf1gNltDUnRoMQmlb6RqXkPS+rCSzduraFZZ9ailWvCuKwDatTHoldxeGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=ijbyLmiD; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [IPv6:2001:638:700:1038::1:9b])
	by smtp-o-3.desy.de (Postfix) with ESMTP id DA15311F8E0
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 19:20:31 +0200 (CEST)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 175DA13F648
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 19:20:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 175DA13F648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1750872024; bh=Q0T6gH9XZMWG2w25RsZ/BQAcg9aUTDgcVzXy6s9P5N8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ijbyLmiDO8eW/Xqrvn1hoWLT7YIjzO361UB4DNRE053PMDqWTWbokkfsD+oP8yuIS
	 2kTAyM0Ejk+smTgqR25J25GGw1Y6LrNm6Und+QepPM2dqKdosjf5SVdNBMEXG1PmmW
	 wORBBZMfnnNcOkMxLsJjs/7uYGri2yMLfs/w5hQs=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 0A0E0120043;
	Wed, 25 Jun 2025 19:20:24 +0200 (CEST)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [IPv6:2001:638:d:c303:acdc:1979:2:e7])
	by smtp-m-1.desy.de (Postfix) with ESMTP id ED20F40044;
	Wed, 25 Jun 2025 19:20:23 +0200 (CEST)
Received: from smtp-intra-3.desy.de (smtp-intra-3.desy.de [131.169.56.69])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id 9433C10A3CC;
	Wed, 25 Jun 2025 19:20:22 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-3.desy.de (Postfix) with ESMTP id 4E48F1A0041;
	Wed, 25 Jun 2025 19:20:22 +0200 (CEST)
Date: Wed, 25 Jun 2025 19:20:22 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, 
	linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1248643633.14443075.1750872022054.JavaMail.zimbra@desy.de>
In-Reply-To: <20250625080208.1424-1-chenhx.fnst@fujitsu.com>
References: <20250625080208.1424-1-chenhx.fnst@fujitsu.com>
Subject: Re: [PATCH] pynfs: Fix RuntimeError by increasing default
 ca_maxrequests from 8 to 16
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_14443076_547431676.1750872022193"
X-Mailer: Zimbra 9.0.0_GA_4769 (ZimbraWebClient - FF140 (Linux)/9.0.0_GA_4769)
Thread-Topic: pynfs: Fix RuntimeError by increasing default ca_maxrequests from 8 to 16
Thread-Index: N1l2a3uT+tvpIdrT6aEdslFEzxLLVA==

------=_Part_14443076_547431676.1750872022193
Date: Wed, 25 Jun 2025 19:20:22 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, 
	linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1248643633.14443075.1750872022054.JavaMail.zimbra@desy.de>
In-Reply-To: <20250625080208.1424-1-chenhx.fnst@fujitsu.com>
References: <20250625080208.1424-1-chenhx.fnst@fujitsu.com>
Subject: Re: [PATCH] pynfs: Fix RuntimeError by increasing default
 ca_maxrequests from 8 to 16
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4769 (ZimbraWebClient - FF140 (Linux)/9.0.0_GA_4769)
Thread-Topic: pynfs: Fix RuntimeError by increasing default ca_maxrequests from 8 to 16
Thread-Index: N1l2a3uT+tvpIdrT6aEdslFEzxLLVA==


I had a different attempt to address that:

https://lore.kernel.org/all/20250415114814.285400-1-tigran.mkrtchyan@desy.de/\

Tigran.

----- Original Message -----
> From: "Chen Hanxiao" <chenhx.fnst@fujitsu.com>
> To: "Calum Mackay" <calum.mackay@oracle.com>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Wednesday, 25 June, 2025 10:00:59
> Subject: [PATCH] pynfs: Fix RuntimeError by increasing default ca_maxrequests from 8 to 16

> Increased the default value of ca_maxrequests from 8 to 16 to address a
> RuntimeError encountered in DELEG8.
> 
> This change resolves the issue where
> DELEG8 st_delegation.testDelegRevocation
> fails with a RuntimeError: "Out of slots".
> 
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
> nfs4.1/nfs4client.py | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
> index f4fabcc..fa31b34 100644
> --- a/nfs4.1/nfs4client.py
> +++ b/nfs4.1/nfs4client.py
> @@ -390,7 +390,7 @@ class ClientRecord(object):
>                        fore_attrs=None, back_attrs=None, sec=None,
>                        prog=None,
>                        max_retries=1, delay_time=1):
> -        chan_attrs = channel_attrs4(0,8192,8192,8192,128,8,[])
> +        chan_attrs = channel_attrs4(0,8192,8192,8192,128,16,[])
>         if fore_attrs is None:
>             fore_attrs = chan_attrs
>         if back_attrs is None:
> --
> 2.39.1

------=_Part_14443076_547431676.1750872022193
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
MBwGCSqGSIb3DQEJBTEPFw0yNTA2MjUxNzIwMjJaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIE6WER/+PhrKqhwQB9bAxFbeKFv+
hLX6AhcB71LWhsmmMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICACfDO5Ehh64fgav8aWmVwhSuSq1y3aHjR0FB55T0
uW/4T0Urb/dXd+Q5XwcwS3fZa6bBI2/MbXDI+LYnxjoOaEQAOiXz0QhgSbpmozFALxGUr7V8wcle
YdQrdtJMU3NCdzZ9zQAt3D+6Jcervr5SD9P0meqBkkT62JolVSoK5AiAMNMs01mZxGUC5c7fQngH
4uYWUB60KnjCSY9nhuTk4AExT/0CRkTqUAWE75C3sdqEJ9DGmyjMm4xMhHJeWKhk1szAKMcPC556
KJV7R7ipBUkxgLhlOWayD3c7GBWLj+ZiieL7DPXO2EoPCOtjq4DPoxyQTVCEXVcX8UqCQ6rUsFOb
3J96m6Oj8sW2Bw3IGp4w4cGbdZor6ZcDs+aekSC6pfNNkG5nmfSImzLsPsjVvFaryhursFEB+6Lk
pkijDMvnOXRpCSh4LGR0SZ7S5GMRtJ/mIRATYOKq7qPU0ubgfEOosPOAki7wFX12fT46CNGvBWxL
+i5bipG/OiaUlbOcQuf0BfIKczFRzEHiliQjLDR6elQ9Tz/BLT5U4FiLNlR11k92rV70Pl7HAOXf
YFhk/Cd6KhF/hRcIEpHLrXpI7dKSjyoySLjz37GMmkLLeRBP4nCB1LOKLQ9rThyYDqZhn3M3dPNT
F/3uHBnl2i6MD8PQ9BBR7QD4iC7I6BH6BDoPAAAAAAAA
------=_Part_14443076_547431676.1750872022193--

