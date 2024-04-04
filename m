Return-Path: <linux-nfs+bounces-2639-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 140FE898B5D
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Apr 2024 17:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC920287249
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Apr 2024 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C39412AAE8;
	Thu,  4 Apr 2024 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="bt3aGPh3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC89129A75
	for <linux-nfs@vger.kernel.org>; Thu,  4 Apr 2024 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245439; cv=none; b=iNe4v40t3RQFkS57rDn4HOndAWNU0SqMSijMvaKTKU6YXE3mbV0jhtljb7pCph3jStiLxji08cgTD1O6LtvKxlwULRfIeeNhWtC/Zw6/B4IYcKptXwsY1X2fTfROZ6/CBdQ8HuGDe00gB/Ob6foZ1XLzl5w3589ynHozrJGJS+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245439; c=relaxed/simple;
	bh=a9TNQoKy2U/X+NmusOjVc04CS9ARQOdGs+OAsUFZkgU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GYE7c029yAG5/Rrrv7I0HO03Bd2RpQ5xt7YLM36cGuc6qpJp6AVUGYfK6F19RBOR33k67N8snUCUMQfAYjpk967dUTn8zhCA92zeezxY/Pb4LFQtoT1+dq5fggzg8TivpfNuC2+SjfTH8SMhuOMaRBWBDT1+twPARmASF3Snv6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=bt3aGPh3; arc=none smtp.client-ip=131.169.56.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [IPv6:2001:638:700:1038::1:a6])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 2F341E0BFF
	for <linux-nfs@vger.kernel.org>; Thu,  4 Apr 2024 17:38:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 2F341E0BFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1712245089; bh=60hiH16fbrl7IDkfChNKZ4AbGVMaFX/+KxY48+PpBhQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=bt3aGPh38akTGQINu8QMxEwdEcGFWngzCevjqmM7HGEek3eDovpk74NSEBBerdMd/
	 ZhaVXP9aseySM6hLI9RciMRvIAV+3cCL+BOPi2/8JcPlqYS+NnU4J3VxW5SaSDOPVC
	 oQagLJmCXA5WdRxmp8QJbi0ZBUzE6acm+sKEUiUA=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
	by smtp-buf-3.desy.de (Postfix) with ESMTP id 22F32C0020;
	Thu,  4 Apr 2024 17:38:09 +0200 (CEST)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [194.95.235.47])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 1AEBF120043;
	Thu,  4 Apr 2024 17:38:09 +0200 (CEST)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [131.169.56.82])
	by b1722.mx.srv.dfn.de (Postfix) with ESMTP id 68BDF220039;
	Thu,  4 Apr 2024 17:38:08 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 560FCC0087;
	Thu,  4 Apr 2024 17:38:08 +0200 (CEST)
Date: Thu, 4 Apr 2024 17:38:08 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <1246600035.9928999.1712245088183.JavaMail.zimbra@desy.de>
In-Reply-To: <CALXu0UfExxAtoqnFUYbMG=Mpwc0HU3qtb0vuiygXLf6bt=4AaA@mail.gmail.com>
References: <CALXu0UfExxAtoqnFUYbMG=Mpwc0HU3qtb0vuiygXLf6bt=4AaA@mail.gmail.com>
Subject: Re: Linux NFSv4.1 client with Linux NFSv4.1 server, getting block
 size of exported filesystem?
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_9929000_1540810371.1712245088290"
X-Mailer: Zimbra 9.0.0_GA_4597 (ZimbraWebClient - FF124 (Linux)/9.0.0_GA_4597)
Thread-Topic: Linux NFSv4.1 client with Linux NFSv4.1 server, getting block size of exported filesystem?
Thread-Index: 9AJK3FzFAnAhFWAD5zkqCvWyDjiytg==

------=_Part_9929000_1540810371.1712245088290
Date: Thu, 4 Apr 2024 17:38:08 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <1246600035.9928999.1712245088183.JavaMail.zimbra@desy.de>
In-Reply-To: <CALXu0UfExxAtoqnFUYbMG=Mpwc0HU3qtb0vuiygXLf6bt=4AaA@mail.gmail.com>
References: <CALXu0UfExxAtoqnFUYbMG=Mpwc0HU3qtb0vuiygXLf6bt=4AaA@mail.gmail.com>
Subject: Re: Linux NFSv4.1 client with Linux NFSv4.1 server, getting block
 size of exported filesystem?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4597 (ZimbraWebClient - FF124 (Linux)/9.0.0_GA_4597)
Thread-Topic: Linux NFSv4.1 client with Linux NFSv4.1 server, getting block size of exported filesystem?
Thread-Index: 9AJK3FzFAnAhFWAD5zkqCvWyDjiytg==

Hi Ced,

no, it can not. However, spec defines two attributes,  maxread and maxwrite, that can indicate
client preferred IO request sizes:

https://datatracker.ietf.org/doc/html/rfc5661#section-5.8.2.20

In pNFS case, an additional layout-specific option, that can override those values.

Best regards,
   Tigran.

----- Original Message -----
> From: "Cedric Blancher" <cedric.blancher@gmail.com>
> To: "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
> Sent: Wednesday, 3 April, 2024 19:59:16
> Subject: Linux NFSv4.1 client with Linux NFSv4.1 server, getting block size of exported filesystem?

> Good evening!
> 
> Assuming a Linux 6.6 NFSv4.1 client and a Linux 6.6 NFSv4.1 server,
> can the NFSv4.1 client obtain the exact block size of the exported
> filesystem (e.g. ReiserFS, btrfs, ext4, ...) via fstatat()/stat()?
> 
> Ced
> --
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur

------=_Part_9929000_1540810371.1712245088290
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
MBwGCSqGSIb3DQEJBTEPFw0yNDA0MDQxNTM4MDhaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEID3xMEuz9eZPQ/T3Le5+vE91PJIT
TXDToYnpzdf52B6QMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICACpQQMiMBwh1E9L8zL6ItB1H0vQOgpehlx2RS5OM
IMoz/RsrTE8ddxSBT8kJUZ8WIktTHgmTnlc8yT3PAbZhrI7mgwhKn5B4MN9F2mSH/hyq+BFtH21g
2f/W/SrMfC9k9nofKBimW/lqN5TpSmxvHQIMhItJyM1166Kd+ankZi9CoD97WCkbAEXgmoWhdiY0
wfb/o2cgcTkFL2hqdtkyh0lfL872kUVpMneGBvVTwP/pAjxmsmHQPIpyZLhjAJTVsEZ+CW/Bkga7
mxRQCDoPDfpnUbjiQUDy5F6eVWUYJPxiQaC6bYCCVW5rFUU6UczjVfy0rcL7OUWNF4fhA2s027pY
T0Na17rojQ52yGLjwi4Qy16lN+tdp/ENstQg0tzFVOuHTtkOr8p8urQqwF8KCbM2A7Afh0IYAyo6
rFlBGhNWbVkG3i1sN7KMjhRUiw8RGg076PtFYTSUcVotJ5Lo5CbQ8onS/JvkUmLFIFOTBiBiuNaX
d8/IMJ6ipgMoxQVty1rNdegL8AmBPV6AOh5uGiVfrWyiROSWktqHpTWXwO4v6jj3+7at4FZpxjuV
df8fzAXsj9Sd/bZHCNVXo4lnrPD7fJ5nS6znCjiROAzNl8KFZGkCnwGUnzjqsFfPo9pRtgFAZRef
eHYTvkjiYz9wOF07e5ziZ9d3TrqOZetCczPcAAAAAAAA
------=_Part_9929000_1540810371.1712245088290--

