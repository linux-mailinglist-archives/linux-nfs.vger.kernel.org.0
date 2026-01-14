Return-Path: <linux-nfs+bounces-17881-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0BDD1FCC4
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 16:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB0C6303835E
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 15:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD60B39E6E2;
	Wed, 14 Jan 2026 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmla190C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B7939E6CC
	for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404948; cv=none; b=AnWue+TvyEycgxS8WUZ5coJTlqYR3cKDVCLrXlO778ROs2SfoQ4KeNfdCV0aSMdmjwGwm0omJuUE+/ruz7xmnisJYHT6lMEYkOjBVEhZ/5TMSsMqtR/vJqJWA8sojWfGuSS5gjAY++ipT/RLruKwz43odFDpcoyApcVbTEZlkds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404948; c=relaxed/simple;
	bh=4R7yYhNzbEb3DbrELXL0p2WhQ6FD0zlfbMuqRCPJvjI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iFpspb5x4/FmATcBOdg8qpDNj7vrWaE5EA1yWfYHScYDesZ4vdGkxpO8BgPigVasvmP9HwRHxvWCr4f69RjjO5hG404Tbmc+F2V4RgexyTKkinkzipLscnCbxYYiVacZ7KhEZ67aE/FgLVkqWea1d1Les+LPRcNEpN2mpJ0Ifck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmla190C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD13C16AAE;
	Wed, 14 Jan 2026 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768404947;
	bh=4R7yYhNzbEb3DbrELXL0p2WhQ6FD0zlfbMuqRCPJvjI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nmla190CZ9MVQZ8khJjCep82aBWRqDi1Y5MvCkVkFW+lTlvVTM5aE5KxAju3QNoS+
	 DHdX2rcu4D/G+Iurem+c1ECtcJs3fN6YplT5ie/yhLWEyfY67mRWsC/aRwGl+RfX28
	 yJFQMJwHBNFwYnSa6QFc/Oqa9/IrJxzB2oyYSGpen4BuVyjdEFx0R+qm662KM3q6Oc
	 Azrv4j5yWfnZSTpZqUua11/8Y8IdjxhjHIujtUIclzanpv1C15xKsyldKCmhmDYhiT
	 auUly+PEIKsXfrfnZGjUx0sn44kML73NIT3zUREh9GkafyyjITDEuikhybR8ZPoAP/
	 /BuOYA36EiJIQ==
Message-ID: <d982f950ef0291076801b23cfd53ae8da1b31c00.camel@kernel.org>
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
From: Trond Myklebust <trondmy@kernel.org>
To: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, Benjamin
 Coddington <bcodding@hammerspace.com>, Eric Biggers <ebiggers@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, Anna
 Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Date: Wed, 14 Jan 2026 10:35:45 -0500
In-Reply-To: <becabe80-b2e3-4210-bda1-77721f56113b@app.fastmail.com>
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
	 <a78cf4e4274f8b4e69a3c7bf3aa778ce7cc25f72.camel@kernel.org>
	 <becabe80-b2e3-4210-bda1-77721f56113b@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-14 at 10:04 -0500, Chuck Lever wrote:
>=20
>=20
> On Wed, Jan 14, 2026, at 9:53 AM, Trond Myklebust wrote:
> > On Wed, 2026-01-14 at 09:19 -0500, Chuck Lever wrote:
> > > On 1/14/26 8:19 AM, Jeff Layton wrote:
> > > > On Wed, 2026-01-14 at 07:39 -0500, Benjamin Coddington wrote:
> > > > > On 13 Jan 2026, at 19:42, Eric Biggers wrote:
> > > > >=20
> > > > > > On Tue, Jan 13, 2026 at 05:33:37PM -0500, Benjamin
> > > > > > Coddington
> > > > > > wrote:
> > > > > > > > - Individual filehandles are small, on the order of 32-
> > > > > > > > or
> > > > > > > > 64-bytes
> > > > > > > >=20
> > > > > > > > - But there are a lot of filehandles, perhaps billions,
> > > > > > > > that would
> > > > > > > > =C2=A0 be encrypted or signed by the same key
> > > > > > > >=20
> > > > > > > > - The filehandle plaintext is predictable
> > > > > > >=20
> > > > > > > Mostly, yes.=C2=A0 I think a strength of the AES-CBC
> > > > > > > implementation is that each
> > > > > > > 16-byte block is hashed with the results of the previous
> > > > > > > block.=C2=A0 So, by
> > > > > > > starting with the fileid (unique per-file) and then
> > > > > > > proceeding to the less
> > > > > > > unique block (fsid + fileid again), the total entropy for
> > > > > > > each encrypted
> > > > > > > filehandle is increased.
> > > > > >=20
> > > > > > This sort of comment shows that the choice of AES-CBC still
> > > > > > isn't well
> > > > > > motivated.=C2=A0 AES-CBC is an unauthenticated encryption
> > > > > > algorithm
> > > > > > that
> > > > > > protects a message's confidentiality.=C2=A0 It isn't a hash
> > > > > > function, it
> > > > > > isn't a MAC, and it doesn't protect a message's
> > > > > > authenticity.=C2=A0
> > > > > > AES-CBC
> > > > > > will successfully decrypt any ciphertext, even one tampered
> > > > > > with by an
> > > > > > attacker, into some plaintext.=C2=A0 You may be confusing AES-
> > > > > > CBC
> > > > > > with
> > > > > > AES-CBC-MAC.
> > > > >=20
> > > > > I'm not confusing them, and you're absolutely correct - if an
> > > > > encrypted
> > > > > filehandle were tampered with we'd be relying on the decoded
> > > > > filehandle
> > > > > being garbage - the routines to decode the fsid and fileid
> > > > > would
> > > > > return
> > > > > errors, because a filehandle's data is meaningful and well-
> > > > > structured.
> > > > >=20
> > > > > That's a big difference from what using a MAC would provide -
> > > > > immediate
> > > > > knowledge the filehandle had been modified.
> > > > >=20
> > > >=20
> > > > I think a MAC is a better idea here too:
> > > >=20
> > > > One thing that people keep pointing out is that you could
> > > > potentially
> > > > sniff traffic and just nab the encrypted filehandles, and match
> > > > them
> > > > with inode numbers, etc.
> > > >=20
> > > > If you append a MAC though and check it on the server, you
> > > > could
> > > > give
> > > > out filehandles that are limited-use. For instance, with v4,
> > > > you
> > > > could
> > > > salt the hash with the long-form clientid and ensure that that
> > > > filehandle is only usable by that client. Anyone else gets back
> > > > NFS4ERR_STALE.
> > > >=20
> > > > Couple that with TLS and you'd have a pretty decent guard
> > > > against
> > > > sniffing and filehandle guessing attacks.
> > >=20
> > > A sniffing attack is easier than guessing a file handle or
> > > constructing
> > > one. Neither encrypting a filehandle nor signing it protects
> > > against
> > > sniffing attacks. But using full in-transit encryption does, and
> > > we
> > > have that implemented already.
> > >=20
> > > With full in-transit encryption, the plaintext is much much less
> > > predictable as well.
> > >=20
> > > Just sayin'
> > >=20
> >=20
> > Protection against sniffing and protection against spoofing are two
> > completely orthogonal problems. Please don't muddle the already
> > murky
> > waters in this thread by confusing the two.
>=20
> They're not orthogonal here.
>=20
> Your stated goal is to protect against directly accessing
> openly-permitted files under directories that are narrowly
> permitted.
>=20
> One way to access such a file is to guess the filehandle.
>=20
> Another way is to sniff the filehandle from the wire.
>=20
> Wire sniffing is cheaper, and signing a filehandle does not
> protect from that attack. Signing filehandles would force
> attackers to use sniffing, thus defeating any protection
> provided by signing.
>=20
> That's highly relevant to the effectiveness of filehandle
> signing, IMO.
>=20

knfsd already supports TLS as a method for protecting data on the wire.
However while TLS can provide some authentication features via mtls, it
is not fine grained enough for the purposes of providing secure access
for the flexfiles protocol.

The orthogonal problem that we're looking to solve is when a trusted
client is shared by multiple users who are trusted to access different
data sets. If they can set up a TLS connection (or if there is no need
to set up TLS because network access is trusted through other methods),
then the users can currently just iterate through sets of valid
filehandles in order to brute force access to data sets that they are
not supposed to see.
We cannot use krb5 as a solution here because the flexfiles protocol
does not currently support that, and because pNFS authorisation at the
data server is not based on user authentication, but on proof that the
user holds a valid layout.
If the filehandle is unguessable in that situation, then that does
suffice as proof that the user holds a layout.



