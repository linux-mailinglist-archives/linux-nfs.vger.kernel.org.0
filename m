Return-Path: <linux-nfs+bounces-17875-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBB5D1F8F8
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 15:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69A673025584
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 14:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7502DCF61;
	Wed, 14 Jan 2026 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5WabPJg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCA3238D42
	for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402429; cv=none; b=RPE+LKAYMyP5KsdbSk6Tt1NCexiwd4jGDeQV6L5VTYJzNfvJQ/2QTcX8loPO46d0IpITWPOEHY3K5RQUhJoSOteST+q5x5Pm0E3hwI6ttIl+AKFhG2xpCfHyLxux8FAOSXxcIigah5SATDxeikjmzqV93tdqGiOsDSJS0/rzXA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402429; c=relaxed/simple;
	bh=dKXqtMDrfowS5PM8F4WnvcqTFqJ9faO1wS2Eh9+ozYM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jja/3eqXmaMzM/yOdvVOSbRLN1QC/+Ta0Xwj9p5LHAb4EAMS+pxMxUUNr1zHSWP9MKlHq2OLl5/g1KOVpV9FGxFhaQhM/mHz0kXJF/xrHIZiXbWDGt5TYALtJIo7uGx5+ApknSsg4+n66mWGsXtOo7xyNCSeZ9L06XSwZz8Fxrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5WabPJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F07C4CEF7;
	Wed, 14 Jan 2026 14:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768402429;
	bh=dKXqtMDrfowS5PM8F4WnvcqTFqJ9faO1wS2Eh9+ozYM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=o5WabPJgqYxHaQXjn4NV4ZslMafXrHcGWrM8vKdV8ieRaAilLzRj0l4co/eUuRluo
	 0bIggp4MdmM+IDVHLjr6N7ZxQJqLjKQ1guqF/0j1Aefo6lPwAwG9KgQn1E4BN4k0vM
	 zv54PEE4ODbuHi/SIqRQkiOISB444wQey7zYwMZSpm/PYa6wpBA1N39xOngVaROUju
	 FTQ6ra1tPNO4hdRSpBcwv2/tbY5L/jTdNKKqGJJreyrxI77rlGQobfwFQvkaY7AjrQ
	 WcQYbLbZT4fm2KyuFCKDxVWzamt0f8CI2IN0JUGvajQJoa7m4VjrjYQyy7zpEbGY2X
	 2T1Gd0Gh2HwHg==
Message-ID: <a78cf4e4274f8b4e69a3c7bf3aa778ce7cc25f72.camel@kernel.org>
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
From: Trond Myklebust <trondmy@kernel.org>
To: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, Benjamin
 Coddington <bcodding@hammerspace.com>, Eric Biggers <ebiggers@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, Anna
 Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Date: Wed, 14 Jan 2026 09:53:47 -0500
In-Reply-To: <c8ad96c5-1da1-4aeb-8999-2a8b63021a23@kernel.org>
References: <1e92e144-d436-44dd-956f-3125403dfdc8@kernel.org>
	 <ECE1341F-BA8A-4DC7-BC9D-BDD6F10F6013@hammerspace.com>
	 <dc3d8ff3-f68f-4200-a546-605f0f2e3611@kernel.org>
	 <A3F6E0BB-523F-4B99-B583-D6D80E9D7BFB@hammerspace.com>
	 <bf09e1e1-d397-405b-aef8-38c44e6c2840@kernel.org>
	 <BCFA2167-C883-40C8-A718-10B481533943@hammerspace.com>
	 <1c5569bd-fcac-4b55-8e84-3fbc096cdff3@kernel.org>
	 <86B6E978-C67B-4C78-9E5F-6F171FD62F3E@hammerspace.com>
	 <e711e1cb-eb8a-4723-a9af-39ce7d9658dd@app.fastmail.com>
	 <C79886E5-3064-4202-9813-0D79091F78DF@hammerspace.com>
	 <20260114004205.GC2178@quark>
	 <834DBCBA-1CD8-4BA9-81E8-09E621B3F176@hammerspace.com>
	 <a092bf21127a679a32ac9f9c476e7d070667c36b.camel@kernel.org>
	 <c8ad96c5-1da1-4aeb-8999-2a8b63021a23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-14 at 09:19 -0500, Chuck Lever wrote:
> On 1/14/26 8:19 AM, Jeff Layton wrote:
> > On Wed, 2026-01-14 at 07:39 -0500, Benjamin Coddington wrote:
> > > On 13 Jan 2026, at 19:42, Eric Biggers wrote:
> > >=20
> > > > On Tue, Jan 13, 2026 at 05:33:37PM -0500, Benjamin Coddington
> > > > wrote:
> > > > > > - Individual filehandles are small, on the order of 32- or
> > > > > > 64-bytes
> > > > > >=20
> > > > > > - But there are a lot of filehandles, perhaps billions,
> > > > > > that would
> > > > > > =C2=A0 be encrypted or signed by the same key
> > > > > >=20
> > > > > > - The filehandle plaintext is predictable
> > > > >=20
> > > > > Mostly, yes.=C2=A0 I think a strength of the AES-CBC
> > > > > implementation is that each
> > > > > 16-byte block is hashed with the results of the previous
> > > > > block.=C2=A0 So, by
> > > > > starting with the fileid (unique per-file) and then
> > > > > proceeding to the less
> > > > > unique block (fsid + fileid again), the total entropy for
> > > > > each encrypted
> > > > > filehandle is increased.
> > > >=20
> > > > This sort of comment shows that the choice of AES-CBC still
> > > > isn't well
> > > > motivated.=C2=A0 AES-CBC is an unauthenticated encryption algorithm
> > > > that
> > > > protects a message's confidentiality.=C2=A0 It isn't a hash
> > > > function, it
> > > > isn't a MAC, and it doesn't protect a message's authenticity.=C2=A0
> > > > AES-CBC
> > > > will successfully decrypt any ciphertext, even one tampered
> > > > with by an
> > > > attacker, into some plaintext.=C2=A0 You may be confusing AES-CBC
> > > > with
> > > > AES-CBC-MAC.
> > >=20
> > > I'm not confusing them, and you're absolutely correct - if an
> > > encrypted
> > > filehandle were tampered with we'd be relying on the decoded
> > > filehandle
> > > being garbage - the routines to decode the fsid and fileid would
> > > return
> > > errors, because a filehandle's data is meaningful and well-
> > > structured.
> > >=20
> > > That's a big difference from what using a MAC would provide -
> > > immediate
> > > knowledge the filehandle had been modified.
> > >=20
> >=20
> > I think a MAC is a better idea here too:
> >=20
> > One thing that people keep pointing out is that you could
> > potentially
> > sniff traffic and just nab the encrypted filehandles, and match
> > them
> > with inode numbers, etc.
> >=20
> > If you append a MAC though and check it on the server, you could
> > give
> > out filehandles that are limited-use. For instance, with v4, you
> > could
> > salt the hash with the long-form clientid and ensure that that
> > filehandle is only usable by that client. Anyone else gets back
> > NFS4ERR_STALE.
> >=20
> > Couple that with TLS and you'd have a pretty decent guard against
> > sniffing and filehandle guessing attacks.
>=20
> A sniffing attack is easier than guessing a file handle or
> constructing
> one. Neither encrypting a filehandle nor signing it protects against
> sniffing attacks. But using full in-transit encryption does, and we
> have that implemented already.
>=20
> With full in-transit encryption, the plaintext is much much less
> predictable as well.
>=20
> Just sayin'
>=20

Protection against sniffing and protection against spoofing are two
completely orthogonal problems. Please don't muddle the already murky
waters in this thread by confusing the two.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

