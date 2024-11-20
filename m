Return-Path: <linux-nfs+bounces-8149-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10959D3AAA
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 13:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C3CDB21C13
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 12:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B0716A92D;
	Wed, 20 Nov 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="fhPRdtgD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D3199FC9
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732105230; cv=none; b=IVAMsip5JW2oYZGQBXippsc9s5kUFdGvMfeQ/dIC5l6cN02AV8QoXqrBVPMxBouLRTyK6zHkMImaHPnoxkQhzQ3ZcB5e23lAVvTeJ0YmjOfXc2KcIOby9Ft+nwDZ8I5zD4OiEWeUeO7ZeIpFHAl5Bmg4VW4Y/0IeBwe+SpIW1KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732105230; c=relaxed/simple;
	bh=OlY/eF1Qe7WSVDNuxDUfI/TH4d8L3O4+zwK8qJ3Dsxs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=tb2hBuNf++S1WKazfPNT2nj6JKx3XKD1zDVFP3pdSL1isNr3oByMPP2oJOlPplM9uKhU+POQh2Qk6ZTpG78uMW7tVhbWavEKe9eQVaxwJObyBnFo5iQg7XWz0QIzI615eHqxJiqhbhkLkGWT+KHP4abtNJz59KlkNA9/j4op/mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=fhPRdtgD; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [IPv6:2001:638:700:1038::1:9a])
	by smtp-o-3.desy.de (Postfix) with ESMTP id A01E411F85C
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 13:11:36 +0100 (CET)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 3AEC411F749
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 13:11:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 3AEC411F749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1732104689; bh=OlY/eF1Qe7WSVDNuxDUfI/TH4d8L3O4+zwK8qJ3Dsxs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fhPRdtgDzet+GQ2bUYHAr9m6tno3IRtvm83eWYHDnSRAv8WttJg17MUk+/FAiO0Qq
	 W7IHlFh3Jo9nbbDa1MF3sjJ9ENe3JCtAUiu3hK0upvmHk6CIrx1orUHsokYrWniVQs
	 zhbmosoCqAZ7MvnYoUSAAPmAZlIN20JWbeIUMySA=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 2C53220038;
	Wed, 20 Nov 2024 13:11:29 +0100 (CET)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [IPv6:2001:638:d:c303:acdc:1979:2:e7])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 1FD6B40044;
	Wed, 20 Nov 2024 13:11:29 +0100 (CET)
Received: from smtp-intra-3.desy.de (smtp-intra-3.desy.de [131.169.56.69])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id 3BBA4102BF0;
	Wed, 20 Nov 2024 13:11:28 +0100 (CET)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-3.desy.de (Postfix) with ESMTP id 1F3241A003E;
	Wed, 20 Nov 2024 13:11:28 +0100 (CET)
Date: Wed, 20 Nov 2024 13:11:27 +0100 (CET)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <506312331.38625272.1732104687826.JavaMail.zimbra@desy.de>
In-Reply-To: <CALXu0Ud49Sze09H-Xp-UG24Zwfeo44gd=Txo3kbgDpCgcyApWQ@mail.gmail.com>
References: <d5b8d3d6c7592808ad1332ae8c7c2f2cc9635550.camel@kernel.org> <ec60bdca5eea7d459ce81144914f7bd56cd747a9.camel@hammerspace.com> <4210AE90-97EE-4B32-AC67-1DB80082D4CC@oracle.com> <CALXu0Ud49Sze09H-Xp-UG24Zwfeo44gd=Txo3kbgDpCgcyApWQ@mail.gmail.com>
Subject: Re: OPEN_XOR_DELEGATION performance problems
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_38625273_120357614.1732104688036"
X-Mailer: Zimbra 9.0.0_GA_4612 (ZimbraWebClient - FF132 (Linux)/9.0.0_GA_4612)
Thread-Topic: OPEN_XOR_DELEGATION performance problems
Thread-Index: pqg92cEf6JyazBDGHeCH2++ofDHO7A==

------=_Part_38625273_120357614.1732104688036
Date: Wed, 20 Nov 2024 13:11:27 +0100 (CET)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <506312331.38625272.1732104687826.JavaMail.zimbra@desy.de>
In-Reply-To: <CALXu0Ud49Sze09H-Xp-UG24Zwfeo44gd=Txo3kbgDpCgcyApWQ@mail.gmail.com>
References: <d5b8d3d6c7592808ad1332ae8c7c2f2cc9635550.camel@kernel.org> <ec60bdca5eea7d459ce81144914f7bd56cd747a9.camel@hammerspace.com> <4210AE90-97EE-4B32-AC67-1DB80082D4CC@oracle.com> <CALXu0Ud49Sze09H-Xp-UG24Zwfeo44gd=Txo3kbgDpCgcyApWQ@mail.gmail.com>
Subject: Re: OPEN_XOR_DELEGATION performance problems
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_GA_4612 (ZimbraWebClient - FF132 (Linux)/9.0.0_GA_4612)
Thread-Topic: OPEN_XOR_DELEGATION performance problems
Thread-Index: pqg92cEf6JyazBDGHeCH2++ofDHO7A==

Unfortunately, for now, nfs4j doesn't support any type of delegation.

Tigran.

----- Original Message -----
> From: "Cedric Blancher" <cedric.blancher@gmail.com>
> To: "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>, "Tiramisu Mokka=
" <kofemann@gmail.com>
> Sent: Wednesday, 20 November, 2024 08:39:00
> Subject: Re: OPEN_XOR_DELEGATION performance problems

> On Tue, 19 Nov 2024 at 17:31, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>>
>>
>>
>> > On Nov 19, 2024, at 10:09=E2=80=AFAM, Trond Myklebust <trondmy@hammers=
pace.com> wrote:
>> >
>> > On Tue, 2024-11-19 at 06:45 -0500, Jeff Layton wrote:
>> >> We attempted to implement the "delstid" draft for v6.13, but have had
>> >> to drop the patches for it. After merge, we got a couple of reports
>> >> of
>> >> a performance issue due to the OPEN_XOR_DELEGATION patch:
>> >>
>> >>
>> >> https://lore.kernel.org/linux-nfs/202409161645.d44bced5-oliver.sang@i=
ntel.com/
>> >>
>> >> Once we enable OPEN_XOR_DELEGATION support, the fsmark "App Overhead"
>> >> statistic spikes significantly. The kernel patch for this is very
>> >> simple, and doesn't seem likely to cause a performance issue on its
>> >> own. My theory is that this test is one that causes the client to
>> >> return the delegation, and since it doesn't have an open stateid, it
>> >> has to reestablish one during the test run, and that causes the app
>> >> overhead stat to spike.
>> >>
>> >> Trond, Tom, Mike -- I know that the HS Anvil has support for
>> >> OPEN_XOR_DELEGATION. If you run the fsmark test against it with that
>> >> support both enabled and disabled (either on the client or server
>> >> side), do you see a similar spike in "App Overhead"?
>> >>
>> >> If so, then I suspect we need to consider limiting the use of that
>> >> flag
>> >> in some cases. I have no idea what heuristic we'd use to decide this
>> >> though.
>> >
>> > As already stated when we discussed this at Bakeathon: the server is
>> > still in charge of heuristics w.r.t. whether or not there may be
>> > contention for the file. The OPEN_XOR_DELEGATION flag changes nothing
>> > in that respect.
>>
>> fsmark is a single-client test. There should be no contention
>> for any files during this test.
>>
>>
>> > Yes, I'm sure you can find tests which cause recalls of delegations,
>> > and those will be marginally slower when the client has to re-establis=
h
>> > an open stateid.
>>
>> The fsmark result regressed 92%.
>>
>>
>> > However the issue with those tests is that they are
>> > deliberately setting up a situation where the server ideally shouldn't
>> > be handing out a delegation at all.
>> >
>> > Furthermore, this is no different than a situation where the client
>> > used a delegation to cache the open (i.e. avoid sending an OPEN call)
>> > after the application closed the file and then later re-opened it.
>> > So the point is that this is not a situation that is unique to
>> > OPEN_XOR_DELEGATION. It is just a consequence of the client's ability
>> > to cache open state.
>>
>> The regression was bisected to Jeff's XOR patch on two
>> separate occasions. This does indeed appear to be a
>> situation that is unique to OPEN_XOR_DELEGATION.
>>
>> It's possible that our theory of the failure is wrong.
>> As developers of the only other server implementation of
>> OPEN_XOR_DELEGATION, can Hammerspace help us troubleshoot
>> this issue?
>>
>=20
> Doesn't Tigran's dcache.org nfs4j server also support OPEN_XOR_DELEGATION=
?
>=20
> Ced
> --
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur

------=_Part_38625273_120357614.1732104688036
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
MBwGCSqGSIb3DQEJBTEPFw0yNDExMjAxMjExMjhaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEICL7poctEJ5PIzw8f1XPK3jSxMNX
3epmlEts/GxkVd0LMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICAEVsW/dr03NXZkAYdAbxc5GucpLFPV8iK6Kmcfcd
t4IBA/ljrj8vl8JxNUHfCaLWeULPdaaZSUki/8IywZQRu1YR4wo4dy2q4cXThQjZNEKtpxepLsAp
Q2nNPZgKfTqKsnK1G+ZtdFw7NOPaRjCaEOweRA4kXJ+spZEgOjo1X5iBeBcVSIaTYaTAj4k8r1xE
d37u1M/Rs5cJ+P3/BUDfFd0bmvU5oZI1MnlF8K+BkSVL+jCE7WafodZjvjm/oUArsBoy/Ywh9ZEc
15+i0e1LiqLIxmLfIPWYyTHUekMkqA9lRrs8RC0o+zbVVOb0A648GvUGJP1XqvSmG1Zf1/YkaDgv
wCakrOovUBe+3104HigMywQnk/mI8ZEfbyj+pkZK37jtozR9kBlTtROJGD8NiYP+rwnvP7t/YFdO
9LcO/n6EQAKnFaanqb64Pb1/KpoznpXxPsrMbSlr1XFZF1W9W3c1CAFkmgEdfUYJ4vRrbif2G5+M
aRuaj4qUDN6ue4r3vR4VZ91bf65G3GKuqFIalyawDa/CFyLxccZQCa6Sey3eW7+8IYDRaOoisgrf
t/vc3eCevirOooDsa0ySFKB2NKwlWKlp8adm2J7jq1Vay703rhz2SyPMelQUu3MZNpaOHPS6xBX5
IEgJWlu++1/8C8RnZBVcktmyE/yZhlfp4z/FAAAAAAAA
------=_Part_38625273_120357614.1732104688036--

