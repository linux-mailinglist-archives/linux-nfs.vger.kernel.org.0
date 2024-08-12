Return-Path: <linux-nfs+bounces-5307-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E6994E730
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 08:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031B4280234
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 06:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577E51509A0;
	Mon, 12 Aug 2024 06:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b="0nKeDJk/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C6A4C9F
	for <linux-nfs@vger.kernel.org>; Mon, 12 Aug 2024 06:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445541; cv=none; b=pqkYXbvAvSlNE3hrVrpSj/4NQanOW5ux2n67lvsWLMDoNQ/ZQNAL+QYklkhHfb+muW1HskPY8pfP/ojUQYu9mJgWXVBNlz4xzGl5UgU2Z5YWCREftTmYGW++l92ofR+ZLaM3AyUjkZqvTnDylMe+FVPec5WI4obylOAWbY4koGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445541; c=relaxed/simple;
	bh=4WeL4ehB8/QnVudWfvxbh9DXQuB7hA8ZhFoulhF61rQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Odm3P3tigu5ZhDhg0lmVTvb+X/gI8h0tiYA80VBmIAf18DxoISxW2djqfYUa3o3EWp393VP8+PsbLoWD6d7nksWbHCefqErb1zyUA3x2aMHBUL+5WwsXKlx0wy5ligMSQdI/LPB/bfAZ3dQJhvuZZ04YBvj6ZwS8Amks27l3tn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de; spf=pass smtp.mailfrom=desy.de; dkim=pass (1024-bit key) header.d=desy.de header.i=@desy.de header.b=0nKeDJk/; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desy.de
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 8571413F648
	for <linux-nfs@vger.kernel.org>; Mon, 12 Aug 2024 08:52:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 8571413F648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
	t=1723445534; bh=pXaXoHTDYCm7AWw4nmwBm316icqLHgiNyGZVkjPH5fY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=0nKeDJk/+sbl8vO8symdgggYgwPsAJw1rJ/qvMe3GbMO4Mn4oq4Q+GIInKqF2G9LI
	 exoBjyrxlDnVcm+7Yy0X/8nBU1TNtUz85uNNAX4HABCcrsqy5yfD5Yo3ViCRanxq5v
	 In6BLxmcy3V8LI7YgEg0py/ygTwPEWyT1BC9qtGs=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 6DC1020038;
	Mon, 12 Aug 2024 08:52:14 +0200 (CEST)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [194.95.233.47])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 616AB16003F;
	Mon, 12 Aug 2024 08:52:14 +0200 (CEST)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [131.169.56.83])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id 73ED9220043;
	Mon, 12 Aug 2024 08:52:08 +0200 (CEST)
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 900CE2003F;
	Mon, 12 Aug 2024 08:52:07 +0200 (CEST)
Date: Mon, 12 Aug 2024 08:52:05 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: marc eshel <eshel.marc@gmail.com>
Cc: Olga Kornievskaia <aglo@umich.edu>, 
	schumaker anna <schumaker.anna@gmail.com>, 
	linux-nfs <linux-nfs@vger.kernel.org>, 
	Trond Myklebust <trondmy@hammerspace.com>
Message-ID: <1030980705.45726678.1723445525556.JavaMail.zimbra@desy.de>
In-Reply-To: <24bf013f-78af-4d05-80ae-1b35ed54c6a0@gmail.com>
References: <CAN-5tyHXg8=Sv8MS7vJUwG+=Av8oL6Bk_ZDDfwjEf3-R0KT=dg@mail.gmail.com> <685478263.45656552.1723405271880.JavaMail.zimbra@z-mbx-2> <24bf013f-78af-4d05-80ae-1b35ed54c6a0@gmail.com>
Subject: Re: NFS client to pNFS DS
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
	boundary="----=_Part_45726681_323893000.1723445527495"
X-Mailer: Zimbra 9.0.0_GA_4612 (ZimbraWebClient - FF128 (Linux)/9.0.0_GA_4612)
Thread-Topic: NFS client to pNFS DS
Thread-Index: GqS4n0O0Fx94uPeqCZ7xDKI//a471A==

------=_Part_45726681_323893000.1723445527495
Date: Mon, 12 Aug 2024 08:52:05 +0200 (CEST)
From: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To: marc eshel <eshel.marc@gmail.com>
Cc: Olga Kornievskaia <aglo@umich.edu>, 
	schumaker anna <schumaker.anna@gmail.com>, 
	linux-nfs <linux-nfs@vger.kernel.org>, 
	Trond Myklebust <trondmy@hammerspace.com>
Message-ID: <1030980705.45726678.1723445525556.JavaMail.zimbra@desy.de>
In-Reply-To: <24bf013f-78af-4d05-80ae-1b35ed54c6a0@gmail.com>
References: <CAN-5tyHXg8=Sv8MS7vJUwG+=Av8oL6Bk_ZDDfwjEf3-R0KT=dg@mail.gmail.com> <685478263.45656552.1723405271880.JavaMail.zimbra@z-mbx-2> <24bf013f-78af-4d05-80ae-1b35ed54c6a0@gmail.com>
Subject: Re: NFS client to pNFS DS
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_GA_4612 (ZimbraWebClient - FF128 (Linux)/9.0.0_GA_4612)
Thread-Topic: NFS client to pNFS DS
Thread-Index: GqS4n0O0Fx94uPeqCZ7xDKI//a471A==



----- Original Message -----
> From: "marc eshel" <eshel.marc@gmail.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>, "Olga Kornievskaia" <a=
glo@umich.edu>
> Cc: "schumaker anna" <schumaker.anna@gmail.com>, "linux-nfs" <linux-nfs@v=
ger.kernel.org>, "Trond Myklebust"
> <trondmy@hammerspace.com>
> Sent: Sunday, 11 August, 2024 21:50:36
> Subject: Re: NFS client to pNFS DS

> On 8/11/24 12:41 PM, Mkrtchyan, Tigran wrote:
>>> On 10. Aug 2024, at 23:20, Olga Kornievskaia <aglo@umich.edu> wrote:
>>>
>>> =EF=BB=BFOn Fri, Aug 9, 2024 at 12:27=E2=80=AFPM marc eshel <eshel.marc=
@gmail.com> wrote:
>>>>
>>>> On 8/9/24 8:15 AM, Olga Kornievskaia wrote:
>>>>> On Fri, Aug 9, 2024 at 10:09=E2=80=AFAM marc eshel <eshel.marc@gmail.=
com> wrote:
>>>>>> Thanks for the replies, I am a little rusty with debugging NFS but t=
his what I
>>>>>> see when the NFS client tried to create a session with the DS.
>>>>>>
>>>>>> Ganesha was configured for sec=3Dsys and the client mount had the op=
tion sec=3Dsys,
>>>>>> I assume flavor 390004 means it was trying to use krb5i.
>>>>> For 4.1, the client will always try to do state operations with krb5i
>>>>> even when sec=3Dsys when the client detects that it's configured to d=
o
>>>>> Kerberos (ie., gssd is running). This context creation is triggered
>>>>> regardless of whether the rpc client is used for MDS or DS.
>>>>>
>>>>> My question to you: is the MDS configured with Kerberos but the DS
>>>>> isn't? And also, does this lead to a failure?
>>>> Both MDS DS are configured for sec=3Dsys and it is leading to client
>>>> switching from DS to MDS so yes, it is pNFS failure. What I see on the
>>>> DS is the client creating a session and than imminently destroying it
>>>> before committing it. If the is something else that I can debug I will
>>>> be happy to.
>>> pnfs failure is unexpected. I'm pretty confident that a non-kerberos
>>> configured client can do normal pnfs with sec=3Dsys. I can help debug,
>> Yes, I can confirm that. All RHEL kernels and weekly -rc kernels from Li=
nus
>> works as expected. We mount always with sec=3Dsys, and despite the fact,=
 that
>> hosts configured to support kerberos due to AFS and GPFS, the access to =
DSes is
>> never an issue and never tries to use kerberos.
>>
>> Tigran.
>=20
> Hi Tigran,
>=20
> It is possible that it is failing back to MDS for another reason and the
> error message that I see is not the reason for the failure. Are you
> using pNFS with Ganesha and GPFS?
>=20
> Marc.

Hi Marc,

pNFS is used exclusively with dCache. Can you provide the packet capture
of failing pNFS traffic, like mount + cp + umount?

Best regards,
   Tigran.

>=20
>>
>>> if you want to send me a network trace and tracepoint output. Btw what
>>> kernel/distro are you using?
>>>
>>>> Marc.
>>>>
>>>>>> Jul 30 11:10:58 svl-marcrh-node-1 kernel: RPC: Couldn't create
>>>>>> auth handle (flavor 390004)
>>>>>>
>>>>>> Marc.
>>>>>>
>>>>>> On 8/9/24 6:06 AM, Anna Schumaker wrote:
>>>>>>
>>>>>> On Thu, Aug 8, 2024 at 6:07=E2=80=AFPM Olga Kornievskaia <aglo@umich=
.edu> wrote:
>>>>>>
>>>>>> On Mon, Aug 5, 2024 at 5:51=E2=80=AFPM marc eshel <eshel.marc@gmail.=
com> wrote:
>>>>>>
>>>>>> Hi Trond,
>>>>>>
>>>>>> Will the Linux NFS client try to us krb5i regardless of the MDS
>>>>>> configuration?
>>>>>>
>>>>>> Is there any option to avoid it?
>>>>>>
>>>>>> I was under the impression the linux client has no way of choosing a
>>>>>> different auth_gss security flavor for the DS than the MDS. Meaning
>>>>>>
>>>>>> That's a good point, I completely missed that this is specifically f=
or the DS.
>>>>>>
>>>>>> that if mount command has say sec=3Dkrb5i then both MDS and DS
>>>>>> connections have to do krb5i and if say the DS isn't configured for
>>>>>> Kerberos, then IO would fallback to MDS. I no longer have a pnfs
>>>>>>
>>>>>> That's what I would expect, too.
>>>>>>
>>>>>> server to verify whether or not what I say is true but that is what =
my
>>>>>> memory tells me is the case.
>>>>>>
>>>>>>
>>>>>> Thanks, Marc.
>>>>>>
>>>>>> ul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node
>>>>>> stripe count 1
>>>>>> Jul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_nod=
e
>>>>>> ds_num 1
>>>>>> Jul 30 11:10:58 svl-marcrh-node-1 kernel: RPC: Couldn't create
>>>>>> auth handle (flavor 390004)
>>>>>>

------=_Part_45726681_323893000.1723445527495
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
MBwGCSqGSIb3DQEJBTEPFw0yNDA4MTIwNjUyMDhaMC0GCSqGSIb3DQEJNDEgMB4wDQYJYIZIAWUD
BAIBBQChDQYJKoZIhvcNAQELBQAwLwYJKoZIhvcNAQkEMSIEIMj4UGJTK8MN+RtIjJrTdr4p2FMQ
pcb5se1tWR7Y2h1fMDQGCSqGSIb3DQEJDzEnMCUwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MAcGBSsOAwIHMA0GCSqGSIb3DQEBCwUABIICAH10YmMWlcNYZrnPzb/DYvZEr6x2Zx3bPJzc4D5g
jDG/iHROshe83FLvHermp7Rne/K6yYv/FoKiIwdgnl9LvuKBIHRvX8Ic5jKqzr//yd60wbupvg97
iIeLTRbSYRJb86ZvRIw89ZYFdQpB0gAoSOQjp9cy2Py+gdb+UaPY1FN5qYOXNwjQOzLA/oh2TNEP
gdm1pCExDCp/zHeSZqTQztWUP5ACYQc9wuYtvbLNXf9ZY9hPDf0j+gGjo3UzAS61RHOHfgEKeEw3
NpcZdDq5Z+8SN5r5ICAT/NZTRHsdV1qfE6Ya9TsPSLQRyR9UVHiBKjc+FPPumMoljj2B9+djlRsP
GOmjOWIF7X5aRU0lgINnupjmnQAMWYvSJjrHcZk3gz+ayHfPX/95UG365O2eyND/onsm78gGgOom
rr205j1D8nLFEPLKab/dO/kIq1Yma9BoJbkeI4zgZMKl7yO8FNTz5IxW6NVSKa0Hr6K31dOgqBeE
wNLv5sfx/g9b8BuJqAxGd01o0dtPqEwSJ59KLOFeB7NRCOWxfMfuAImC3l5JSDLY5Q2ZC+g/EvSm
IYAE01161O4G0iwunkWetmvdc4F61k44Nb6LDAVUkF+V8RHtgDLNxRhmSxogMPdOMO46ObsqOgSx
+lC9Cnquime37r8eMoxzQdZGuqJuY/YTNc+FAAAAAAAA
------=_Part_45726681_323893000.1723445527495--

