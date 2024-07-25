Return-Path: <linux-nfs+bounces-5052-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCCC93C994
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jul 2024 22:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE289281607
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jul 2024 20:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8899376E0;
	Thu, 25 Jul 2024 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="wHgXNUq/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED342B9C9
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jul 2024 20:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939690; cv=none; b=INsuma01HUtapPLZDZbpshAVbDhEXkBblIDW+OR13NS+ok7i/Ff1D06O0vxCtMk3iuHQ/Qky1JUMOEg3vvTTMou05MKXhIhaoyZEEX2WfY/zkt/c03hIIKcrYXiouIyGkSxuiWErJUwjKQOh+S6hqnl7tDanY/0ItFdy0c09kks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939690; c=relaxed/simple;
	bh=IGqAJUGRtyEFqUqntuu9Eom1R3ypvH/iHR1Jy6Owmw8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=BFZxyVWJbxD+GmWJ/N+1LV0d7L2rnfubHB4YF13DVxYF0XYzQmFc67G9JPYiqdVi+sY/QyHyGp+469b0EbsxB4B4CBvt9xcb/AgfznJUmdcAWPR1oUf1SPorwP+X3VmxEGrnIBlVafdGUH/GHUJ66OcLmNjlKKPVRSv0Uw2CYDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=wHgXNUq/; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 645CA13F648
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jul 2024 22:34:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 645CA13F648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1721939678; bh=m7GXU6s+xZ5ZAvm7n62puJ2//ovdqqjlpWPA6wqFKX0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=wHgXNUq/KtX9QGjuAHOfQeKSAk7eJ76HOzw0gsyn3kcAWoibrGCcB25HTKFonpH4y
	 C5yT3PRV8knAwS08ZD9CHreZ0+lVI/cEOJqWRgmeLlmqTDLiBOnVAtTIZPAVUb0VPV
	 s5Iphr3NCGFTL6m2V/5LXPiXXmqPSRZ5BcS+KIR8=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 4A8E220038;
	Thu, 25 Jul 2024 22:34:38 +0200 (CEST)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [194.95.235.47])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 3E16716003F;
	Thu, 25 Jul 2024 22:34:38 +0200 (CEST)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [IPv6:2001:638:700:1038::1:52])
	by b1722.mx.srv.dfn.de (Postfix) with ESMTP id B3AD2220039;
	Thu, 25 Jul 2024 22:34:36 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 8A84780046;
	Thu, 25 Jul 2024 22:34:36 +0200 (CEST)
Date: Thu, 25 Jul 2024 22:34:36 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Dan Shelton <dan.f.shelton@gmail.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, 
	ms-nfs41-client-devel@lists.sourceforge.net
Message-ID: <814701891.39673338.1721939676245.JavaMail.zimbra@desy.de>
In-Reply-To: <9D5914C6-BF08-4063-BCC7-C2F7458F33EC@oracle.com>
References: <CAKAoaQmG+FRhQquBJzFkr+BHFDCxxKky706Za2+nC9CNf8i10w@mail.gmail.com> <CAN-5tyG+t1Q=Tr0FtTzWhKE-=hLvWOarNn3_ArUt9VYuZ=aauQ@mail.gmail.com> <CAAvCNcBQK+z5=NUN3AmDG6qnEUJvwgF11479TrKwhTEC1qV-fg@mail.gmail.com> <9D5914C6-BF08-4063-BCC7-C2F7458F33EC@oracle.com>
Subject: Re: New NFSv4.2 attribute |FATTR4_TMPFILE| (sort of opposite of
 |FATTR4_OFFLINE|) ?
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_39673339_1310643086.1721939676448"
X-Mailer: Zimbra 9.0.0_GA_4612 (ZimbraWebClient - FF128 (Linux)/9.0.0_GA_4612)
Thread-Topic: New NFSv4.2 attribute |FATTR4_TMPFILE| (sort of opposite of |FATTR4_OFFLINE|) ?
Thread-Index: AQHa3QKuWVeyibac00Wk/nvvcieDf7IEVq+AgACZDoCAArB5gMFm/pk2

------=_Part_39673339_1310643086.1721939676448
Date: Thu, 25 Jul 2024 22:34:36 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Dan Shelton <dan.f.shelton@gmail.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, 
	ms-nfs41-client-devel@lists.sourceforge.net
Message-ID: <814701891.39673338.1721939676245.JavaMail.zimbra@desy.de>
In-Reply-To: <9D5914C6-BF08-4063-BCC7-C2F7458F33EC@oracle.com>
References: <CAKAoaQmG+FRhQquBJzFkr+BHFDCxxKky706Za2+nC9CNf8i10w@mail.gmail.com> <CAN-5tyG+t1Q=Tr0FtTzWhKE-=hLvWOarNn3_ArUt9VYuZ=aauQ@mail.gmail.com> <CAAvCNcBQK+z5=NUN3AmDG6qnEUJvwgF11479TrKwhTEC1qV-fg@mail.gmail.com> <9D5914C6-BF08-4063-BCC7-C2F7458F33EC@oracle.com>
Subject: Re: New NFSv4.2 attribute |FATTR4_TMPFILE| (sort of opposite of
 |FATTR4_OFFLINE|) ?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_GA_4612 (ZimbraWebClient - FF128 (Linux)/9.0.0_GA_4612)
Thread-Topic: New NFSv4.2 attribute |FATTR4_TMPFILE| (sort of opposite of |FATTR4_OFFLINE|) ?
Thread-Index: AQHa3QKuWVeyibac00Wk/nvvcieDf7IEVq+AgACZDoCAArB5gMFm/pk2



----- Original Message -----
> From: "Chuck Lever III" <chuck.lever@oracle.com>
> To: "Dan Shelton" <dan.f.shelton@gmail.com>
> Cc: "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>, ms-nfs41-client=
-devel@lists.sourceforge.net
> Sent: Thursday, 25 July, 2024 18:10:18
> Subject: Re: New NFSv4.2 attribute |FATTR4_TMPFILE| (sort of opposite of =
|FATTR4_OFFLINE|) ?

>> On Jul 23, 2024, at 7:05=E2=80=AFPM, Dan Shelton <dan.f.shelton@gmail.co=
m> wrote:
>>=20
>> On Tue, 23 Jul 2024 at 15:58, Olga Kornievskaia <aglo@umich.edu> wrote:
>>>=20
>>> On Tue, Jul 23, 2024 at 9:17=E2=80=AFAM Roland Mainz <roland.mainz@nrub=
sig.org> wrote:
>>>>=20
>>>> Hi!
>>>>=20
>>>> ----
>>>>=20
>>>> [2nd attempt to send this email]
>>>> The Win32 API has |FILE_ATTRIBUTE_TEMPORARY| (see
>>>> https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi=
-createfilea)
>>>> to optimise for short-lived/small temporary files - would it be useful
>>>> to reflect that in the NFSv4.2 protocol via a |FATTR4_TMPFILE|
>>>> attribute (sort of the opposite of |FATTR4_OFFLINE|, such a
>>>> |FATTR4_TMPFILE| should be ignored by HSM, and flushing to stable
>>>> storage should be relaxed/delayed as long as possible) ?
>>>=20
>>> I think a more appropriate medium for this message is an IETF NFSv4
>>> mailing list
>>=20
>> Where is that list?
>=20
> <nfsv4@ietf.org> is publicly archived, but you have to join to
> post because all posts to that list are treated as contributions
> to the IETF.

Indeed, we are touching on the IETF area of responsibility.

>=20
>=20
>>> as FATTR4_TMPFILE is not a spec attribute.
>>=20
>> I think the question was what the Linux nfsd people think about such
>> an attribute.
>>=20
>> But I also have a related question: Can the Linux nfsv4 client code
>> see the O_TMPFILE flag from openat() syscalls? If that is the case,
>> then O_TMPFILE ----> {FATTR4_TMPFILE, true}, and Linux nfsd can
>> optimise such files too.
>=20
> O_TMPFILE is a little different. open(2) says:
>=20
>       O_TMPFILE (since Linux 3.11)
>              Create an unnamed temporary regular file.  The pathname
>              argument specifies a directory; an unnamed inode will be
>              created in that directory's filesystem.  Anything written
>              to the resulting file will be lost when the last file
>              descriptor is closed, unless the file is given a name.
>=20
> That doesn't seem to be quite the same thing as "create a named
> file but request that the server's HSM to ignore it".
>=20
> Also: an O_ flag is a declaration of an application's intended
> use. A file attribute is persistent across opens. O_TMPFILE might
> apply to writeback style, but it doesn't seem consistent with
> how one might prefer to set HSM policy on a persistent file.
>=20
> There was a recent (but now expired) personal draft that proposed
> adding some fattr4 attributes that enabled clients to control the
> HSM properties of a file. It didn't get a lot of working group
> traction.
>=20
> IMO generally the NFS protocol is about application access to
> file data; administrative operations like HSM policy are left to
> the NFS server and its local storage. You could certainly invent
> an RPC protocol (outside of NFS but using NFS file handles) that
> could be used to set HSM policy remotely (and, of course,
> securely).
>=20
> Wearing my NFSD maintainer cap: Again it is a matter of whether
> there are local file systems on Linux that can store and/or
> make use of such attributes. I'm not aware of a current statx()
> API for controlling HSM policy, but I'm not expert in that area.
> (That doesn't mean there aren't other NFS server implementations
> that could indeed make use of such an attribute).

As a server implementor with an HSM behind. The tape system needs=20
many other attributes, like family, priority, media type,=20
number of copies... A generic QoS attribute that can control
storage system behavior probably makes sense. And then we have
POSIX that doesn't expose it, and user applications that don't
care. But, again, this is an IETF discussion.

Best regards,
   Tigran.

>=20
> As far as delaying data persistence, the client can already
> signal to the server that it doesn't care much about a file's
> content by simply not sending WRITEs or a COMMIT. Sending a
> CLOSE can be preceded by SETATTR(size=3D0) to ensure any already-
> written data is tossed.
>=20
> It feels to me like the client has some control here already,
> which is why I suggested that a proof-of-concept would be a
> useful way to explore the idea and nail down the desired
> semantics before making a full proposal to change the protocol
> standard.
>=20
>=20
> --
> Chuck Lever

------=_Part_39673339_1310643086.1721939676448
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
MBwGCSqGSIb3DQEJBTEPFw0yNDA3MjUyMDM0MzZaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIBaIwFmutqdC90UKsNJ1FHtlSrH5
dBRgOGVLr2Mc0xJDMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICAFb29tEfSmN8YlwpWR/Ql7V9czpagqN523qwv62a
6Nq5lWl94sUsUwPnrFV7Qb+YSCJd2o7E98jkcKojQVfQDL9a2JYcUwvchMSKPodJyFBuVoO9SOd2
p4hUiKH3Qav529h5+TBerjNoFBe2uyyrFnMzUj/LHokoPTzDy2a+ZDEDiIkjVcFNeGFhbHjufDB0
hqC7nDeVrWpfiaUr7KY8kDLREnWE5kId7hZGrK6Rm1Zm0Lp8HIccmqwL/ZveOZYWksL+rOlVZDeU
5CogxqhqrCpYsePN+M1OdoYiuHYhCKhAUK6PlNw0OnhOKxjKqw8eDKLUHN7LPLf5NlqXwNL0LE17
F8ykTxju5tuYm6soMvgN+4vm4pxdTJKZrrgMpO8PV6OJ5eO7ljPstdUoNP85Ts8oamnqE/MRR9At
tIXesSg+yzIJzOtvQZel7bUylPNToBBBHXEJ8yE5hL/gie4oIYOMqFLPmA/CEm7+Jd/NmQs/qEcn
tAztJPzNQK980/GbfuUZ3UywnWLEIHX5JaXtpFT7/ncF693Ur1KpCziN2GW6YuS0BSKlm9L0b0g2
BwQGJKxVJ4gq2BnOP/myy9Xzmc1K/SPZ7tDIKDNv4rGwX3t7k+7tzVIbmLyX/nigCiu5qaQzi87z
Nb7lLHZH2ULZtYEM8In1iu8pBhVcJW1fBvBBAAAAAAAA
------=_Part_39673339_1310643086.1721939676448--

