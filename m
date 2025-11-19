Return-Path: <linux-nfs+bounces-16568-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CEEC706C6
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 18:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 0BB1B2E8FF
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 17:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E2532FA3B;
	Wed, 19 Nov 2025 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b="JWCYlxYF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EB630BB85;
	Wed, 19 Nov 2025 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572772; cv=none; b=ai8cR04K9/yLu4srl0EVf3mBRdWHSO1l6CazE1BX9ORM5mAyxD0ikE6p/L2GbFvhtNzLX1UW+i4IZsk0MQ2wmDksPFufgFQ047F3EQo5UcmNYOxPjcEuAKMAti8eaQIkrMtEL/2Y9EnVgiL71Pya/qkhhUpi5y0LmqSTudqjs6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572772; c=relaxed/simple;
	bh=MBTQO1kNrskXqYjTtI8N6dvD1tr+Bqi+nOScBdtwziE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZQCSi1TdQUFqHCy4Yu0F5bab77zIKWxGvnaWxWyV2joj5lUra6ynejvrlNn/d2GXkglkPH0zbO3t3eZNlaEJeJPpR79bi0ooy+QvRiaFI63WSQZHsFOtVz5M2aF9K+v9xoUogvGiKGvIfIinrOaUsOI98CFlFWZPVIkBSjPhTq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com; spf=pass smtp.mailfrom=tylerwross.com; dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b=JWCYlxYF; arc=none smtp.client-ip=79.135.106.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tylerwross.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tylerwross.com;
	s=protonmail; t=1763572759; x=1763831959;
	bh=L7ZswShgFLmpRnsJX/62t/uQkyo1yopdzbb5yDybnfI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=JWCYlxYFjBkrBhGU+8PgIW03+shECQKWu8/X+P1a1ChDysvyBJL873zq63+c/VKuT
	 /6SoWmIJCCd2okPJju6jEYDJiS3nBG31EVe3BfW8OBX4rZLwC4XLmbH6wrOqSixKQG
	 2DUd9q0nscdh9hNvPQt6ajgmAnpOqKyNH/CcCvLC+vkaTbnLm37UHyZcsT57kkRhcm
	 g1VBPMjLvdjeVggX3M3xxrnfkI0QsbDrqdxprPFvvX458GGVzkaTOWtnINm1g56Jtz
	 b3VBJnRX0sHMxzHFzgQIvs3HK9TZ6vGrewkdieFVfWjuY1jVs7Hf1WIrAFY13OjLJH
	 OyI/qZ1mc1VgQ==
Date: Wed, 19 Nov 2025 17:19:15 +0000
To: Scott Mayhew <smayhew@redhat.com>, Salvatore Bonaccorso <carnil@debian.org>
From: "Tyler W. Ross" <TWR@tylerwross.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, "1120598@bugs.debian.org" <1120598@bugs.debian.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Steve Dickson <steved@redhat.com>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Josefsson <simon@josefsson.org>
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5 NFSv4 client using SHA2
Message-ID: <0e7b3c83-df95-4f5f-b865-85c168274a8d@TylerWRoss.com>
Feedback-ID: 101639484:user:proton
X-Pm-Message-ID: 442ec894d7bb6d6e7ea57276a8a66da3e738fdc0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/19/25 6:36 AM, Scott Mayhew wrote:
> While I still assert that if you want to use the stronger encryption
> types with NFS, then you should prioritize those encryption types higher
> in your kerberos configuration... after discussing this yesterday with
> Olga I think the above scenario should probably work too.

There was no intent or attempt to specify encryption types in the
original configuration. Fiddling with enctypes only came up in the
course of troubleshooting.

This issue was found/replicated by:
1. Configuring a stock Debian 13 client using ipa-client-install against
a freshly deployed Fedora 43 IPA instance.
2. Adding a krb5 NFS entry in fstab
3. Installing and enabling gssproxy (use-gss-proxy=3D1 in nfs.conf)
4. Configuring gssproxy for constrained delegation as described in the
docs:
[service/nfs-client]
  mechs =3D krb5
  cred_store =3D keytab:/etc/krb5.keytab
  cred_store =3D ccache:FILE:/var/lib/gssproxy/clients/krb5cc_%U
  cred_usage =3D initiate
  allow_any_uid =3D yes
  impersonate =3D true
  euid =3D 0
5. Allowing constrained delegation on the IPA/KDC side


I think this should be a working configuration: it shouldn't be
necessary to change the enctypes from default for this to work.
But the above results in the aes256-cts-hmac-sha1-96 machine credential
and aes256-cts-hmac-sha384-192 client ticket situation.


> I just sent a patch that makes that happen, but I forgot to add
> "--in-reply-to" my "git send-email" command, so here's the link:
>=20
> https://lore.kernel.org/linux-nfs/20251119133231.3660975-1-smayhew@redhat=
.com/T/#u

Thanks, Scott.

So it's technically possible for the machine and client credentials to
have mismatched enctypes? There are just assumptions (like the slack
variable calculations) that need to be changed to support that?



I'm also wondering if the gssproxy behavior is correct. I obviously
don't understand all the nuance here, but it appears gssproxy is
requesting the service ticket with a different preference/order of
enctypes -- which leads to this mismatch situation.

Looking at the KDC logs (below), the protocol transition request has
enctypes matching the default permitted_enctypes described in
krb5.conf(5) (i.e., with aes256-cts-hmac-sha1-96 first). But then the
constrained delegation request lists aes256-cts-hmac-sha384-192 first,
which I assume indicates preference and is why that enctype is issued.

Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8463](info): TGS_REQ (8 et=
ypes {aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17), aes256-cts-=
hmac-sha384-192(20), aes128-cts-hmac-sha256-128(19), UNSUPPORTED:des3-hmac-=
sha1(16), DEPRECATED:arcfour-hmac(23), camellia128-cts-cmac(25), camellia25=
6-cts-cmac(26)}) 10.108.2.105: ISSUE: authtime 1763506600, etypes {rep=3Dae=
s256-cts-hmac-sha1-96(18), tkt=3Daes256-cts-hmac-sha384-192(20), ses=3Daes2=
56-cts-hmac-sha1-96(18)}, host/nfsclient.ipa.twrlab.net@IPA.TWRLAB.NET for =
host/nfsclient.ipa.twrlab.net@IPA.TWRLAB.NET
Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8463](info): ... PROTOCOL-=
TRANSITION s4u-client=3Djsmith@IPA.TWRLAB.NET
Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8463](info): closing down =
fd 4
Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8465](info): TGS_REQ (4 et=
ypes {aes256-cts-hmac-sha384-192(20), aes128-cts-hmac-sha256-128(19), aes25=
6-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17)}) 10.108.2.105: ISSUE: =
authtime 1763506600, etypes {rep=3Daes256-cts-hmac-sha1-96(18), tkt=3Daes25=
6-cts-hmac-sha384-192(20), ses=3Daes256-cts-hmac-sha384-192(20)}, host/nfsc=
lient.ipa.twrlab.net@IPA.TWRLAB.NET for nfs/nfssrv.ipa.twrlab.net@IPA.TWRLA=
B.NET
Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8465](info): ... CONSTRAIN=
ED-DELEGATION s4u-client=3Djsmith@IPA.TWRLAB.NET
Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8465](info): closing down =
fd 11


>=20
> -Scott
>=20
>>
>>> That's exactly the case: the machine credential is
>>> aes256-cts-hmac-sha1-96.
>>>
>>> So, taking a step back for context/background: this issue was escalated=
 to
>>> me by someone attempting to use constrained delegation via gssproxy. In=
 the
>>> course of troubleshooting that, we found (by examining the krb5kdc logs=
 on
>>> the IPA server) that the NFS service ticket acquired by gssproxy had an
>>> aes256-cts-hmac-sha384-192 session key.
>>>
>>> Not understanding that the machine and user tickets must having matchin=
g
>>> enctypes, I ended up down this rabbit hole thinking the problem
>>> was with the SHA2 enctypes. Sorry to bring you all with me on that
>>> misadventure.
>>>
>>>
>>>
>>> The actual issue at hand then seems to be that gssproxy is requesting (=
and
>>> receiving) a service ticket with an unusable (for the NFS mount) enctyp=
e,
>>> when performing constrained delegation/S4U2Proxy.
>>>
>>> krb5kdc logs of gssproxy performing S4U2Self and S4U2Proxy:Nov 18 18:06=
:51
>>> directory.ipa.twrlab.net krb5kdc[8463](info): TGS_REQ (8 etypes
>>> {aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17),
>>> aes256-cts-hmac-sha384-192(20), aes128-cts-hmac-sha256-128(19),
>>> UNSUPPORTED:des3-hmac-sha1(16), DEPRECATED:arcfour-hmac(23),
>>> camellia128-cts-cmac(25), camellia256-cts-cmac(26)}) 10.108.2.105: ISSU=
E:
>>> authtime 1763506600, etypes {rep=3Daes256-cts-hmac-sha1-96(18),
>>> tkt=3Daes256-cts-hmac-sha384-192(20), ses=3Daes256-cts-hmac-sha1-96(18)=
},
>>> host/nfsclient.ipa.twrlab.net@IPA.TWRLAB.NET for
>>> host/nfsclient.ipa.twrlab.net@IPA.TWRLAB.NET
>>> Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8463](info):
>>> ... PROTOCOL-TRANSITION s4u-client=3Djsmith@IPA.TWRLAB.NET
>>> Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8463](info): closing d=
own
>>> fd 4
>>> Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8465](info): TGS_REQ (=
4
>>> etypes {aes256-cts-hmac-sha384-192(20), aes128-cts-hmac-sha256-128(19),
>>> aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17)}) 10.108.2.105=
:
>>> ISSUE: authtime 1763506600, etypes {rep=3Daes256-cts-hmac-sha1-96(18),
>>> tkt=3Daes256-cts-hmac-sha384-192(20), ses=3Daes256-cts-hmac-sha384-192(=
20)},
>>> host/nfsclient.ipa.twrlab.net@IPA.TWRLAB.NET for
>>> nfs/nfssrv.ipa.twrlab.net@IPA.TWRLAB.NET
>>> Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8465](info): ...
>>> CONSTRAINED-DELEGATION s4u-client=3Djsmith@IPA.TWRLAB.NET
>>> Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8465](info): closing d=
own
>>> fd 11
>>>
>>>
>>> On the Fedora 43 client, gssproxy also acquires an
>>> aes256-cts-hmac-sha384-192 service ticket, but the machine credential i=
s
>>> aes256-cts-hmac-sha384-192 and everything works as-ex
>>> pected.
>>
>> I'm looping in here the gssproxy maintainer as well. Simon, this is
>> about https://bugs.debian.org/1120598 . I assume there is nothing on
>> gssroxy side which can be done to warn about the situation, quoting
>> again:
>>
>>> The actual issue at hand then seems to be that gssproxy is requesting (=
and
>>> receiving) a service ticket with an unusable (for the NFS mount) enctyp=
e,
>>> when performing constrained delegation/S4U2Proxy.
>>
>> ?
>>
>> Regards,
>> Salvatore
>>
>=20

TWR


