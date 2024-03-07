Return-Path: <linux-nfs+bounces-2231-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6D48750D5
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Mar 2024 14:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C3B28A48F
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Mar 2024 13:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B8412CDBE;
	Thu,  7 Mar 2024 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="kUQxHFDI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5294412AAFD
	for <linux-nfs@vger.kernel.org>; Thu,  7 Mar 2024 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819288; cv=none; b=g2YOkMpYjkxXQZczdJJcsIg9MBRXYqDVQL6pRE4vbSg18gQNUIZf3zJtbwnuRm9g0wWcY9k3vSuq4Q37MuiIgnayqBSw3t4C6zb+NFQkG5237bh8jdZlCl8vR5vufXWFj5/3hLt2223GTrPCrp3tczlCPtI/C1DGx1zCQdWVOwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819288; c=relaxed/simple;
	bh=vqidyJ974PD8NUygnZb3BcLqM+hLo/Pkpkn/fNRc5Fc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QJbaJDSFGAkrxKOgcurn2bw0JGF2sMNc7yS8pyHgnhVU8y3RSbe1LEU1yhVODjHTNt4Y5A8h3YFv23vwpxRwaHS/8GuqT8nWTRAtMFgetcM4S6+OmegdBHGFgur62/vIu2b26BmaNjZJJieaqAFp5QpB+44jkZ6OwQlRkrnZboA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=kUQxHFDI; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-3.desy.de (Postfix) with ESMTP id 25090608F4
	for <linux-nfs@vger.kernel.org>; Thu,  7 Mar 2024 14:39:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de 25090608F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1709818770; bh=YGl0pyZrSuXSE/Yu0rx35vaoANzLmGb397QuS+yCdkE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=kUQxHFDIW3LmWzl1YykcsffAGJgk37fO7+aJbHlf4CwQfiD8KsXCD72XAgpwGuSJ0
	 sDgLGCz84Jn9dQetqozgq25zhRvAJcoAjl1Jv51lM1X8MmeGfgTf5msJvQo1gapwy1
	 TX5of/i5FwT7IO85x1jGxhmu5xNrHRDa41wHt0VU=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 1A07B120040;
	Thu,  7 Mar 2024 14:39:30 +0100 (CET)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [IPv6:2001:638:d:c302:acdc:1979:2:e7])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 11BDA120043;
	Thu,  7 Mar 2024 14:39:30 +0100 (CET)
Received: from smtp-intra-3.desy.de (smtp-intra-3.desy.de [131.169.56.69])
	by b1722.mx.srv.dfn.de (Postfix) with ESMTP id 708BB220039;
	Thu,  7 Mar 2024 14:39:29 +0100 (CET)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-3.desy.de (Postfix) with ESMTP id 5A92080746;
	Thu,  7 Mar 2024 14:39:29 +0100 (CET)
Date: Thu, 7 Mar 2024 14:39:25 +0100 (CET)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Martin Wege <martin.l.wege@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <1001845535.26063.1709818765823.JavaMail.zimbra@desy.de>
In-Reply-To: <CANH4o6OxmxNXNhbZ6THwPVAtfkbkdYyQUMRGCX_=Ssb1gTUXJg@mail.gmail.com>
References: <CANH4o6OxmxNXNhbZ6THwPVAtfkbkdYyQUMRGCX_=Ssb1gTUXJg@mail.gmail.com>
Subject: Re: export(5) all_squash, only new files squashed, or all uid/gids?
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_26134_666539453.1709818769214"
X-Mailer: Zimbra 9.0.0_GA_4597 (ZimbraWebClient - FF123 (Linux)/9.0.0_GA_4583)
Thread-Topic: export(5) all_squash, only new files squashed, or all uid/gids?
Thread-Index: eQMPdBI9K03ttHFWWODk42rKp22DLg==

------=_Part_26134_666539453.1709818769214
Date: Thu, 7 Mar 2024 14:39:25 +0100 (CET)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Martin Wege <martin.l.wege@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <1001845535.26063.1709818765823.JavaMail.zimbra@desy.de>
In-Reply-To: <CANH4o6OxmxNXNhbZ6THwPVAtfkbkdYyQUMRGCX_=Ssb1gTUXJg@mail.gmail.com>
References: <CANH4o6OxmxNXNhbZ6THwPVAtfkbkdYyQUMRGCX_=Ssb1gTUXJg@mail.gmail.com>
Subject: Re: export(5) all_squash, only new files squashed, or all uid/gids?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4597 (ZimbraWebClient - FF123 (Linux)/9.0.0_GA_4583)
Thread-Topic: export(5) all_squash, only new files squashed, or all uid/gids?
Thread-Index: eQMPdBI9K03ttHFWWODk42rKp22DLg==

Hi Martin,

The option all_squash does not affect files or directories.
It replaces RPC request credentials sent by nfs client with
user nobody:nobody. The newly created files will be owned by
nobody:nobody, if parent directory permission
(and export rules) allow to do so.

Best regards,
   Tigran.



----- Original Message -----
> From: "Martin Wege" <martin.l.wege@gmail.com>
> To: "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
> Sent: Sunday, 3 March, 2024 14:31:37
> Subject: export(5) all_squash, only new files squashed, or all uid/gids?

> Hello,
> 
> How does the export(5) option all_squash export option work? Does it
> only squash the uid/gid of new files to nobody/nogroup, or will it
> turn the uid/gids of all existing files in the exported tree to
> nobody/nogroup?
> 
> Thanks,
> Martin

------=_Part_26134_666539453.1709818769214
Content-Type: application/pkcs7-signature; name=smime.p7s; smime-type=signed-data
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCAMIIH
XzCCBUegAwIBAgIQWCKDCq74or/A6r3iyeFcUzANBgkqhkiG9w0BAQwFADBVMQswCQYDVQQGEwJO
TDEZMBcGA1UEChMQR0VBTlQgVmVyZW5pZ2luZzErMCkGA1UEAxMiR0VBTlQgVENTIEF1dGhlbnRp
Y2F0aW9uIFJTQSBDQSA0QjAeFw0yMzExMjkxMTUwMjRaFw0yNDEyMjgxMTUwMjRaMIGpMRMwEQYK
CZImiZPyLGQBGRMDb3JnMRYwFAYKCZImiZPyLGQBGRMGdGVyZW5hMRMwEQYKCZImiZPyLGQBGRMD
dGNzMQswCQYDVQQGEwJERTEuMCwGA1UEChMlRGV1dHNjaGVzIEVsZWt0cm9uZW4tU3luY2hyb3Ry
b24gREVTWTEoMCYGA1UEAwwfVGlncmFuIE1rcnRjaHlhbiB0aWdyYW5AZGVzeS5kZTCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANIlFsEQpmV0zy2TtESnOX3d0a17dmceoaYpX2Sn9gwd
obCTBa2Ud/YsGJOuGMb/v1kO/4RyvlXTJFAI4Ui8GJf68MpkMHosIVzisWSPfsBnfWPxgwDTITuS
dwdviezHtvw8HM/Ksv1vjBODQcPgxBJCL/HUswzXEJEetYnnMwzBzLPHyTIuCmlJWRuTtFxNKeTN
yeMzCfm/lsoHI7cch6N+/cFzYGBl9fAKA67iLjlw+2p4IxsycFPi0PGpIxnb6N9vnTmpO9yybaoQ
KuQppnfm9cF8m6AaNoE16JqRcdxgpNbtfZTencbHnwlKukpBLGrlZcFdo/BPzjN0uBHK/W9YPMv1
MOtPaZF0rcjf2FiYUASRUNemOxCu2hkkUvN7UzPuFPszTt4Z4GF/7T76xh7jFQZnBVT8duwbvRDF
q/7rwHN7ZkSpXvIamqojIseNiBTOwC+0L3SaGQYN60JkQx+d+XoMFcFsm6mnyykwv5l2s3rXgQ7G
f73YgNG14esVa82Pbb6Rk43cUcay3DpWAlz7U/bODzePJ1pQcgpHuLJ78u2Sv2n5+YQg9huoGm6N
7eKfucPubjFE4Lpqp9O/I8IJBTwK0KNHSDOB0SFn3vaC6bt/kLGgbpsWW0yv+PzZyqmvYFZXTjlT
tgv3q86kM1sWSgCd/tuxuwWDkv2RHfbvAgMBAAGjggHUMIIB0DAfBgNVHSMEGDAWgBQQMuoC4vzP
6lYlVIfDmPXog9bFJDAOBgNVHQ8BAf8EBAMCBaAwCQYDVR0TBAIwADAdBgNVHSUEFjAUBggrBgEF
BQcDAgYIKwYBBQUHAwQwRQYDVR0gBD4wPDAMBgoqhkiG90wFAgIFMA0GCyqGSIb3TAUCAwMDMA0G
CyqGSIb3TAUCAwECMA4GDCsGAQQBgcRaAgMCAjBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8vY3Js
LmVudGVycHJpc2Uuc2VjdGlnby5jb20vR0VBTlRUQ1NBdXRoZW50aWNhdGlvblJTQUNBNEIuY3Js
MIGRBggrBgEFBQcBAQSBhDCBgTBPBggrBgEFBQcwAoZDaHR0cDovL2NydC5lbnRlcnByaXNlLnNl
Y3RpZ28uY29tL0dFQU5UVENTQXV0aGVudGljYXRpb25SU0FDQTRCLmNydDAuBggrBgEFBQcwAYYi
aHR0cDovL29jc3AuZW50ZXJwcmlzZS5zZWN0aWdvLmNvbTAjBgNVHREEHDAagRh0aWdyYW4ubWty
dGNoeWFuQGRlc3kuZGUwHQYDVR0OBBYEFAKakYwt5EgoalXKWoNDPhs+2W3/MA0GCSqGSIb3DQEB
DAUAA4ICAQBlAH4oPlVJWw5MWlmenHfZE/N2Ep7tU89SXGQaIZoADcgr0Uzm1+wNIs7Qon9CovjH
dZ+7zAF1/gDdfYXy+odOMq1xjSeSwHcjuUarzndM1S0uV9DIr4SCRyXf+JP5aaOwVDpoV7JWlp+U
ptDsBqjEpB+nV2M9LlgRLBp4cdxKu6n/fjJkChR9hd+lDo9bGnR9Uj3KpYWq8GHpoNumUUjSz9A+
qPTYh4cAqRP12nk5Gqjs+ZnsG4j3EM/QFHQbQUtim0jQAA8TJ6whO7gpLKBuYfqXOdwgHT7Lgsw6
KMjhJSZs37WCOjj0mwmSzVAlX7FMmDimZt/lI7kpDfUtYHK+F8c11FxH2yZbrhjaa2rB3qXv4hIB
hrhbt/TNTra8D9C8s3CzxU1FvpREW2VuULyEf36g7ZDcUGom3md/kJFKWqj92KET7JcMp4K79aW/
s65vvcxXDJX6hWiBDkGBFX5Vqy4ni39zo6X9edqRxkJQIN7d4xFhihUvcUo4oLSeybfYNr+RY+tC
/s2PvoUHBsXqfrR5gjo7wz+CBh2O9JSA0g1OvGOpCdTw/EZ00gs4sOTU9heD3x5PzP0DJI+0DM/u
NUH0v918lSJP8zE1N4PjNO1FeqA0l95tQe231ZOZSbd+3EfDjWmvWnPneL2xo+MSXqBDSW4Ua88m
2C2tFcwvOwAAMYIDZTCCA2ECAQEwaTBVMQswCQYDVQQGEwJOTDEZMBcGA1UEChMQR0VBTlQgVmVy
ZW5pZ2luZzErMCkGA1UEAxMiR0VBTlQgVENTIEF1dGhlbnRpY2F0aW9uIFJTQSBDQSA0QgIQWCKD
Cq74or/A6r3iyeFcUzANBglghkgBZQMEAgEFAKCBzjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yNDAzMDcxMzM5MjlaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEINnsyjMC9VJPTz3A3iG6xZkw/8AZ
prZLR84prk1F7uvZMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICAAzQQo4dbvAXBGN9N/RQDLnrfuz5E8UPjuTNfGZI
WSMKqhIu3yS0aqJNNVeIGYGZEgl464YVmPxgUJiv2N2GEU1mKbBgmW05Ao2EhN+SuL3QdsWhf7fR
VvD39xsY4fi6BVB4MUo4p4y0Sbt95pqIUzzgeqNDDWlPBQjqDxSDNOIbCCYQS/kaSXmx6R+w3Zuv
NFDonHIJaoYH29b2ut90m0h0Y7SOZb5uDdBOkaPbFWk48euyS3/f+RFzKuHXsdp2yMHZCJDHxEs+
O/9Uxr2t0WjQurVc6M0GN34U9aHV3gUL/ysqSe9Ne0juIf88dN1rULkGXjgqmSGW1fH22GAIGZSz
ybngcpf/oReHo7rTm7isc12kfUguwqB3qdVj/c602XdWmC0eqC/C0bqTHDjdd8EHkhmJRBELkemN
3edwhrmMhDGZZumQarHUi9sML9GTnvfw6BQm+hXH48Yj22FEgLiM8hGS5jC5L0QJxnGVi6OemPQ2
UzSBZ0C4z+jEhk0nu1Dl+F2URlTTKO69tSTPC+oIP1/8RCWzaUXb40pslgWbQJjj9rrgria4fQQw
ygIHaBa0J2B32AdE8u6TEHUAOlCHUALu18Nzqj6eHwA+dXhDY8YwZFC7KmI5D8G/P64MBCs0DULu
Bxi6twXk7u9LdSXI2WRYyy6MEgcLagslEslkAAAAAAAA
------=_Part_26134_666539453.1709818769214--

