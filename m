Return-Path: <linux-nfs+bounces-11745-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4437DAB891F
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 16:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04031BA1478
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A023C1C861B;
	Thu, 15 May 2025 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="MYLNPL1F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F817B4EC
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318665; cv=none; b=ue5VD+jgYwThDTpGBA05+I0f/VdFvw36keaXVcXGOojiJArbE4ephFvk6pC0hp1oJmrFY7ojT4FXCiEGsLgPa1DMe/TmYGe6SzEcRajWWqY1ICGzwzoD7D068pYIks3MVQlAxxI3DCbDh1E0J82MKcW6YlwoG3tjxvTZCKop58c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318665; c=relaxed/simple;
	bh=/fxDrFK+p9MloplidxnM/LKu8s6iIP+H9dm9kEnH87M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=uM8D9a5UA0YxvcswsE0k9VUyMTW8p445EwWNCVwyEe2wTyOqMuO+kV46er88/DR9q9t8gMMPrNX479J3RjOrJ7S67Br5fj6woOGnDX717GBgh1Mc2MaefmN2apQbQEvAlM97QmWc8hxSRdI00k7y+dWNagqZ6jyml5pKs7WUVDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=MYLNPL1F; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	by smtp-o-3.desy.de (Postfix) with ESMTP id A2D0A11F7AC
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 16:09:07 +0200 (CEST)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 24D1911F74C
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 16:09:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 24D1911F74C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1747318140; bh=/fxDrFK+p9MloplidxnM/LKu8s6iIP+H9dm9kEnH87M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MYLNPL1FJsGxMPWnQbnQxl5f3LoA6xymqMn4/D44ieUt9tBF/TjhYtQDQyrzK/dpc
	 TUhinBLjNf+Uu4ZUHe8W1YUSMr8bod31FSSP50X8O/bFpDlYlcRmXepaN/MS2SIOgL
	 Fu4jXqorK0/bTWVMiKxC29yKH8zn9br3JmIxHw4s=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 1A3781200B0;
	Thu, 15 May 2025 16:09:00 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [IPv6:2001:638:d:c301:acdc:1979:2:e7])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 12C6D40044;
	Thu, 15 May 2025 16:09:00 +0200 (CEST)
Received: from smtp-intra-3.desy.de (smtp-intra-3.desy.de [IPv6:2001:638:700:1038::1:45])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id 7FC5E320093;
	Thu, 15 May 2025 16:08:59 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-3.desy.de (Postfix) with ESMTP id 691A31A0050;
	Thu, 15 May 2025 16:08:59 +0200 (CEST)
Date: Thu, 15 May 2025 16:08:59 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Martin Wege <martin.l.wege@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <902082330.41549553.1747318139215.JavaMail.zimbra@desy.de>
In-Reply-To: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com>
References: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com>
Subject: Re: Why TLS and Kerberos are not useful for NFS security Re: [PATCH
 nfs-utils] exportfs: make "insecure" the default for all exports
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_41549554_561911425.1747318139374"
X-Mailer: Zimbra 9.0.0_GA_4718 (ZimbraWebClient - FF138 (Linux)/9.0.0_GA_4737)
Thread-Topic: Why TLS and Kerberos are not useful for NFS security Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
Thread-Index: 6BS+KUIcrb3Hm1WKDj6yav9Cr/lSSw==

------=_Part_41549554_561911425.1747318139374
Date: Thu, 15 May 2025 16:08:59 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Martin Wege <martin.l.wege@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <902082330.41549553.1747318139215.JavaMail.zimbra@desy.de>
In-Reply-To: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com>
References: <CANH4o6Pvc7wuB0Yh8sEQDRg59_=rUNtnpgJizZ5mmmGNgY5Qrg@mail.gmail.com>
Subject: Re: Why TLS and Kerberos are not useful for NFS security Re: [PATCH
 nfs-utils] exportfs: make "insecure" the default for all exports
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_GA_4718 (ZimbraWebClient - FF138 (Linux)/9.0.0_GA_4737)
Thread-Topic: Why TLS and Kerberos are not useful for NFS security Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
Thread-Index: 6BS+KUIcrb3Hm1WKDj6yav9Cr/lSSw==



----- Original Message -----
> From: "Martin Wege" <martin.l.wege@gmail.com>
> To: "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
> Sent: Wednesday, 14 May, 2025 23:50:00
> Subject: Why TLS and Kerberos are not useful for NFS security Re: [PATCH =
nfs-utils] exportfs: make "insecure" the
> default for all exports

> On Wed, May 14, 2025 at 1:55=E2=80=AFPM NeilBrown <neil@brown.name> wrote=
:
>>
>> On Wed, 14 May 2025, Jeff Layton wrote:
>> Ignoring source ports makes no sense at all unless you enforce some othe=
r
>> authentication, like krb5 or TLS, or unless you *know* that there are no
>> unprivileged processes running on any client machines.
>=20
> I don't like to ruin that party, but this is NOT realistic.
>=20
> 1. Kerberos5 support is HARD to set up, and fragile because not all
> distributions test it on a regular basis. Config is hard, not all
> distributions support all kinds of encryption methods, and Redhat's
> crusade&maintainer mobbing to promote sssd at the expense of other
> solutions left users with a half broken, overcomplicated Windows
> Active Directory clone called sssd, which is an insane overkill for
> most scenarios.
> gssproxy is also a constant source of pain - just Google for the
> Debian bug reports.
>=20
> Short: Lack of test coverage in distros, not working from time to
> time, sssd and gssproxy are more of a problem than a solution.
>=20
> It really only makes sense for very big sites and a support contract
> which covers support and bug fixes for Kerberos5 in NFS+gssproxy.
>=20
>=20
> 2. TLS: Wanna make NFS even slower? Then use NFS with TLS.
>=20
> NFS filesystem over TLS support then feels like working with molasses.
>=20
> Exacerbated by Linux's crazy desire to only support hyper-secure
> post-quantum encryption method (so no fast arcfour, because that is
> "insecure", and everyone is expected to only work with AMD
> Threadripper 3995WX), lack of good threading through the TLS eye of
> the needle, and LACK of support in NFS clients.
>=20
> Interoperability is also a big problem (nay, it's ZERO
> interoperability), as this is basically a Linux kernel client/kernel serv=
er only
> solution.

dCache (a-ka nfs4j) server supports TLS, FreeBSD, ...=20

So, it's not a Linux-only solution.

Tigran.

> libtirpc doesn't support TLS, Ganesha doesn't support TLS, so yeah,
> this is an issue, and not a solution.
>=20
> Fazit: Supporting your argumentation with Kerberos5 or TLS is not gonna f=
ly.
>=20
> Thanks,
> Martin

------=_Part_41549554_561911425.1747318139374
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
MBwGCSqGSIb3DQEJBTEPFw0yNTA1MTUxNDA4NTlaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIOy8LSPYq8AGjh1VE3ggoG5GJkWB
zVJ476ZEEFyHXSucMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICAJDJl2oT3v661OUVSnqsYEEKcWo2hQEEX1DZNqZI
mz793bSLa+VdeO/HG8EIw2ybopmBhiqut0k1LpCuG45xbk1B2cd1NfEs73h+QbiR+tEguWReXsDV
bOgTJHlJuFU0mSAlvzgj2wMlGzqk8wH+lv3G8gBwwVW+Z0b2E3eWoALi4KTlL/c6EXDVt2TcEvTv
kHFRNtY4ww4TmDr/qNg8RsCCg5ZAv4ic+v5y/a1VD2oWM3/EGT6yVcxfXnHzSNovhcHWrFhva9bD
zlQT6bLfL3xHG+x3bNchNqV2LVMPWgvoA4wSVpuoNVWQfit4XWGGEVCD4+k5sy7Xk24UUaGyW5Dc
budzmqGYBswdZVeisL1fs1hQFv9EOtXqc2pwTRTgC9aoemFVI1hlQp+IosJAuDtBInriCI+vQpHY
bVyAOpoSD710V55d6SIEZusnRKmV6FR975vuo89LfYfjquOkm0jcnXGZnE9FtfOD2fbh/GJnM/OD
6hq4CGx6OClvX2jI07hUzo5Zz4Sk0wp+KiHiLTjcz2EMYtdl4rr5gEUgarkr8DQkcHlfsyNsNeaK
SP5HcErPbgpge1WPn2VQ/wQJR5jdW/PLb1HQfPCrVXuGQaWBbKZFrCxetrkv74f3/tsVfm4mFD18
KlqvJr8Hk0KUIDp7S9hN6JGeMwOOaezUC1VkAAAAAAAA
------=_Part_41549554_561911425.1747318139374--

