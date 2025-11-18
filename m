Return-Path: <linux-nfs+bounces-16500-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E063C6C097
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 00:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46F9C4ED7E3
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 23:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704DE30DEB5;
	Tue, 18 Nov 2025 23:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b="Js15DNz4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECFA30DD2F
	for <linux-nfs@vger.kernel.org>; Tue, 18 Nov 2025 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763509426; cv=none; b=k5fLufutMAuunNrxnvaVJIp5GfEQSFwdgZPAlH5NfQbAaEm98E7IofOlkn3K3823mvwnFbxldm+k7iqBg73f4HBHVagGW7C4uTxW8Zk5slyl5fRyoKJVOBrZlgDptP7hmvsQc6liEkGoRFgptsOYJ6rCXZInSMh4dX4rYIurW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763509426; c=relaxed/simple;
	bh=LqapEgcOvfD5krFXH08bBKXWHLWbhNwTrT6CgKipjWw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhw/yq0RMUQyHHrrJ5IlZYUBUb+sDOTR4UF/w7yQnRI2VEF3hG6LoAlmf5C1/2DJYly51XmJPDq0G8yalvOq1tJLJtrhp0x/cyM1a0BqSrzvqxqGcWgKCX9SGbYvOPm5YTht9mUln0lzaRylGbF6fMsKrybTorWmtH9snXcpwPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com; spf=pass smtp.mailfrom=tylerwross.com; dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b=Js15DNz4; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tylerwross.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tylerwross.com;
	s=protonmail; t=1763509415; x=1763768615;
	bh=bCXz2IaageQMhS6XdbtqcjxlMn4nkIbLIaVULMcVC9U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Js15DNz4Qs6liGhB1VT/Yq1UkjbnMav4LcQ7noxooLF7yOI/KRQ3URvjmOwKcy1fh
	 aFqFkkJRcgkenX3HyDF9Qx6OjFJIoK+14qrKcw2TP0qZT4mlSCmW+YMOnJGAwVwjxB
	 SyUR07/OANM1p+U+gH7C59oPd1j0FCglmsdUSNu9fZER1Mj5CeHL7RgPfunRF/idcM
	 K0zZituBWu2M24OXbp9nCj3UtU8INbtzXLH+tjAesTus0513fHR47ON2xusttCJ608
	 VSjpW6gnoHVJDGaUHEdkZ6RbnRHd1oZf5yoJp90GFUDdxfztA7BoikBIQk2dFj6MIy
	 jvBPaABn7Okdw==
Date: Tue, 18 Nov 2025 23:43:29 +0000
To: Scott Mayhew <smayhew@redhat.com>
From: "Tyler W. Ross" <TWR@tylerwross.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, Salvatore Bonaccorso <carnil@debian.org>, "1120598@bugs.debian.org" <1120598@bugs.debian.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Steve Dickson <steved@redhat.com>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5 NFSv4 client using SHA2
Message-ID: <85cd9202-dc22-41b8-8a20-e82cd118215f@TylerWRoss.com>
In-Reply-To: <aRyyWy6hO1ueKf5_@aion>
References: <aRZL8kbmfbssOwKF@eldamar.lan> <fVv3cF7Ulh3cKUP17C98gh_uOv9BcMlMpsIh1Nv5_0tdw-75PKiPJgIEP5o2jBVry7orwz7jeiGQenfCbuUxyj5JFstbx3RTFYr223qDmV0=@tylerwross.com> <a6d1435b-f507-49eb-b80c-4322dc7e1157@oracle.com> <Y79HV0VGpScPYqI_dDxeItkX2UZwSdReaUOpIeMeZXq2HLsHf5J_PTQqr7HrBYygICRsn-OB89QPrxPzjgv2smuzTThUPy_3fq_N1NprlUg=@tylerwross.com> <4a63ad3d-b53a-4eab-8ffb-dd206f52c20e@oracle.com> <902ff4995d8e75ad1cd2196bf7d8da42932fba35.camel@kernel.org> <aRunktdq8sJ7Eecj@aion> <db8b1ef4-afbb-4c23-b7f1-9ae688cef363@TylerWRoss.com> <aRyyWy6hO1ueKf5_@aion>
Feedback-ID: 101639484:user:proton
X-Pm-Message-ID: 62ff09ffe1ef4c6c0b9b55182eac4e6f57851e90
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/18/25 10:52 AM, Scott Mayhew wrote:
> Oh!  I see the problem.  If the automatically acquired service ticket
> for a normal user is using aes256-cts-hmac-sha1-96, then I'm assuming
> the machine credential is also using aes256-cts-hmac-sha1-96.
> Run 'klist -ce /tmp/krb5ccmachine_IPA.TWRLAB.NET' to check.  You can't
> use 'kvno -e' to choose a different encryption type.  Why are you doing
> that?

Aha! Thank you!

That's exactly the case: the machine credential is
aes256-cts-hmac-sha1-96.

So, taking a step back for context/background: this issue was escalated=20
to me by someone attempting to use constrained delegation via gssproxy.=20
In the course of troubleshooting that, we found (by examining the=20
krb5kdc logs on the IPA server) that the NFS service ticket acquired by=20
gssproxy had an aes256-cts-hmac-sha384-192 session key.

Not understanding that the machine and user tickets must having matching=20
enctypes, I ended up down this rabbit hole thinking the problem was with=20
the SHA2 enctypes. Sorry to bring you all with me on that misadventure.



The actual issue at hand then seems to be that gssproxy is requesting=20
(and receiving) a service ticket with an unusable (for the NFS mount)=20
enctype, when performing constrained delegation/S4U2Proxy.

krb5kdc logs of gssproxy performing S4U2Self and S4U2Proxy:Nov 18=20
18:06:51 directory.ipa.twrlab.net krb5kdc[8463](info): TGS_REQ (8 etypes=20
{aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17),=20
aes256-cts-hmac-sha384-192(20), aes128-cts-hmac-sha256-128(19),=20
UNSUPPORTED:des3-hmac-sha1(16), DEPRECATED:arcfour-hmac(23),=20
camellia128-cts-cmac(25), camellia256-cts-cmac(26)}) 10.108.2.105:=20
ISSUE: authtime 1763506600, etypes {rep=3Daes256-cts-hmac-sha1-96(18),=20
tkt=3Daes256-cts-hmac-sha384-192(20), ses=3Daes256-cts-hmac-sha1-96(18)},=
=20
host/nfsclient.ipa.twrlab.net@IPA.TWRLAB.NET for=20
host/nfsclient.ipa.twrlab.net@IPA.TWRLAB.NET
Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8463](info): ...=20
PROTOCOL-TRANSITION s4u-client=3Djsmith@IPA.TWRLAB.NET
Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8463](info): closing=20
down fd 4
Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8465](info): TGS_REQ (4=20
etypes {aes256-cts-hmac-sha384-192(20), aes128-cts-hmac-sha256-128(19),=20
aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17)}) 10.108.2.105:=20
ISSUE: authtime 1763506600, etypes {rep=3Daes256-cts-hmac-sha1-96(18),=20
tkt=3Daes256-cts-hmac-sha384-192(20), ses=3Daes256-cts-hmac-sha384-192(20)}=
,=20
host/nfsclient.ipa.twrlab.net@IPA.TWRLAB.NET for=20
nfs/nfssrv.ipa.twrlab.net@IPA.TWRLAB.NET
Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8465](info): ...=20
CONSTRAINED-DELEGATION s4u-client=3Djsmith@IPA.TWRLAB.NET
Nov 18 18:06:51 directory.ipa.twrlab.net krb5kdc[8465](info): closing=20
down fd 11


On the Fedora 43 client, gssproxy also acquires an
aes256-cts-hmac-sha384-192 service ticket, but the machine credential is=20
aes256-cts-hmac-sha384-192 and everything works as-expected.


TWR


