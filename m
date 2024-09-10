Return-Path: <linux-nfs+bounces-6362-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DDB972AB8
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 09:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A017F285411
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 07:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAF3171671;
	Tue, 10 Sep 2024 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="I8F5zbnp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB87917C9EB
	for <linux-nfs@vger.kernel.org>; Tue, 10 Sep 2024 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953348; cv=none; b=FRztFnbVSBFgD9cylGKarl7L8XrV+q9ekT9h4uxUViTyMguI5rFMsPDQM62ng4c0OhEtwsggh+k8UbfrShXRHWu2yoztll0XJSiK0NIgD8Tfl2n4s3mNiKzPChPfc60Et+KjduZ2ktzOLN9zJYslZTGBto9YW0492ZcD2aPvUyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953348; c=relaxed/simple;
	bh=dT82Pz5TNQVFhxtc4znY7nRkOV/BL4gUgVeD2/NwCGM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZJYATh4tTTIFubPTxuu5RpEOlvJrGUfKESCZvJMZGNi9RyO4TVIYqGuXVfDM6sptkY59R7xMNe6C0e2E+0T32ZShNr9ay4VZeBVeuRx2I0WeG6DQALbzgFpcFjVnluae7hVO6/6NokOxGoz/q6Zgtmc8qNd69vr0gTcDTu+ULCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=I8F5zbnp; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [IPv6:2001:638:700:1038::1:9a])
	by smtp-o-3.desy.de (Postfix) with ESMTP id 979B511F867
	for <linux-nfs@vger.kernel.org>; Tue, 10 Sep 2024 09:23:32 +0200 (CEST)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 42E2611F744
	for <linux-nfs@vger.kernel.org>; Tue, 10 Sep 2024 09:23:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 42E2611F744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1725953005; bh=/GvRGtzRi0oRG4BjeluGIJChJ9eAl9e4byeh1cTrets=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=I8F5zbnp8opEbfxpgUshp2OGyU1rr6QyUJIeaRtbu1MZKHXB/sT4H4tSiTDxW9Y/r
	 6X8/Cm3PEqvfKUh/xQlzln3yIMQ5AxygNqxVJjy/ppwmXiZ9JC9UwOmrxJcxMZNBFg
	 TGqU5gMdlLKm7Q6Vzv08Qk6Ci0JBcm+9zKUhyQ4s=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 3535920038;
	Tue, 10 Sep 2024 09:23:25 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [IPv6:2001:638:d:c301:acdc:1979:2:e7])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 2889040044;
	Tue, 10 Sep 2024 09:23:25 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id DBFF7220045;
	Tue, 10 Sep 2024 09:23:23 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 5527D2003F;
	Tue, 10 Sep 2024 09:23:23 +0200 (CEST)
Date: Tue, 10 Sep 2024 09:23:19 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: marc eshel <eshel.marc@gmail.com>
Cc: Olga Kornievskaia <aglo@umich.edu>, 
	schumaker anna <schumaker.anna@gmail.com>, 
	linux-nfs <linux-nfs@vger.kernel.org>, 
	Trond Myklebust <trondmy@hammerspace.com>
Message-ID: <2102290340.59910889.1725952999821.JavaMail.zimbra@desy.de>
In-Reply-To: <b717d82f-7eb4-475b-bd7b-e376172a2b42@gmail.com>
References: <CAN-5tyHXg8=Sv8MS7vJUwG+=Av8oL6Bk_ZDDfwjEf3-R0KT=dg@mail.gmail.com> <685478263.45656552.1723405271880.JavaMail.zimbra@z-mbx-2> <b717d82f-7eb4-475b-bd7b-e376172a2b42@gmail.com>
Subject: Re: NFS client to pNFS DS
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_59910952_1509897232.1725953003255"
X-Mailer: Zimbra 9.0.0_GA_4612 (ZimbraWebClient - FF130 (Linux)/9.0.0_GA_4612)
Thread-Topic: NFS client to pNFS DS
Thread-Index: anyJSxFV4Ckh/M0jAnyLPm/XCnlhTg==

------=_Part_59910952_1509897232.1725953003255
Date: Tue, 10 Sep 2024 09:23:19 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: marc eshel <eshel.marc@gmail.com>
Cc: Olga Kornievskaia <aglo@umich.edu>, 
	schumaker anna <schumaker.anna@gmail.com>, 
	linux-nfs <linux-nfs@vger.kernel.org>, 
	Trond Myklebust <trondmy@hammerspace.com>
Message-ID: <2102290340.59910889.1725952999821.JavaMail.zimbra@desy.de>
In-Reply-To: <b717d82f-7eb4-475b-bd7b-e376172a2b42@gmail.com>
References: <CAN-5tyHXg8=Sv8MS7vJUwG+=Av8oL6Bk_ZDDfwjEf3-R0KT=dg@mail.gmail.com> <685478263.45656552.1723405271880.JavaMail.zimbra@z-mbx-2> <b717d82f-7eb4-475b-bd7b-e376172a2b42@gmail.com>
Subject: Re: NFS client to pNFS DS
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_GA_4612 (ZimbraWebClient - FF130 (Linux)/9.0.0_GA_4612)
Thread-Topic: NFS client to pNFS DS
Thread-Index: anyJSxFV4Ckh/M0jAnyLPm/XCnlhTg==


Hi Marc,

AFAIK, 1M is the max IO size that linux nfs client will use.

linux/nfs_xdr.h:#define NFS_MAX_FILE_IO_SIZE    (1048576U)

Best regards,
   Tigran.

----- Original Message -----
> From: "marc eshel" <eshel.marc@gmail.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>, "Olga Kornievskaia" <aglo@umich.edu>
> Cc: "schumaker anna" <schumaker.anna@gmail.com>, "linux-nfs" <linux-nfs@vger.kernel.org>, "Trond Myklebust"
> <trondmy@hammerspace.com>
> Sent: Tuesday, 10 September, 2024 01:23:43
> Subject: Re: NFS client to pNFS DS

> Can someone explain why the NFS client is reading 1M followed by 2 reads
> of 1/2M and repeats this pattern. For pNFS or NFS4.
> 
> The mount was for 4M rsize=4194304.
> 
> Thanks, Marc.

------=_Part_59910952_1509897232.1725953003255
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
MBwGCSqGSIb3DQEJBTEPFw0yNDA5MTAwNzIzMjNaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIJBB/1idZQtgDa0Zmxfkm5FQmFL2
gsQ7AqC/+cWekWRsMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICAMbTyB9ZNMOTywV3wfmmjXSkI6tmW4biEV9+oMXx
plBt4Jg67k/Y+0uFTe9lFPQOaPM+4xWNzcaN/L3bg8eO3TSlMZBYPO0XoYZy+GvuHCUcRZjdsnLi
N9mte7aeYcNc1eMwGc+z7LbGkpZjRq2rgmXS/658ZEML0Yq/wAYwPH0lGt+jYRJ1PvwnienUPkJy
/OVf/qduHyggjterAesfnvUEkKsuBnkzSLZwUtK7XQOvhRlu61iN9KG9nOL9VkUEzdaDhOEmIHLR
EqNhIKr5EG/hpEZ6HhicpVJaAtpetoetoTeQCCCMGxD7Xr9vslLrzqlLJnSg25s6+W7vM3oayS4x
F0k094mf93xqAyjQ/8WsjV1nCfInNeyEbAOE+/gKahyIsBFjn3ipOdW8hvpgh/rD4xxJHkXKsNLx
ADXln5uhgvZgtoHoUqtBXYI1h7rZVvjfaWiC/MNrBrZzhn81xr2vwFC66m0uvQD3viZcIS7gGZRN
91cUeqcb2nIjwn8/p3qhRNKLldYyRMNVkDKD9dAzk6Hhj0De86hG1YamBYGOrDiIEVechuJFfBo1
PcyQ/zIHUALl5A7yFmX+YaQjgBkBypDYxpVCUrsiMYfGnVWWQgxsoXqtWzkra953XlzbOC4e2i/N
dv8Y3uprf/40qOkUJzH78gFZkNRgoxI9ce56AAAAAAAA
------=_Part_59910952_1509897232.1725953003255--

