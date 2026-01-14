Return-Path: <linux-nfs+bounces-17878-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34031D1F9DA
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 16:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36F91300A7AD
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 15:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4AE314D21;
	Wed, 14 Jan 2026 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5S9dpBf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892EC2DE6F9
	for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768403174; cv=none; b=TPlQs2GN3Nq7KkB+/kfOQ6sfGh+qQ4XEYEVabX2eTsu+36oKXmBIKRlpeaadhSqkMgCT7jCLByfmzwFXYxHu+9D5DLAUpzSKHQaWzDU7Mm6+a4wUBe0huB+EYXy7B+jVLvDRUkW55CDsFFNr7h1IaHQdfPnMadejTk8aTlWX0cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768403174; c=relaxed/simple;
	bh=SEcQRxFwviHoDEPdFjSTMaGAOFYIZhKgP5ofMTOHSeE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MEl062fAwRpyh8A6FMcF76XpyHuwssJ6XmjdDZBxeyMvf+Hc9vAgH+dsKUDyZ2BOmWw7dsY3yH/J8vMYDbumHY0MYI5UeQ/bhcz6P3ilUSs6hShC78BpVv55B9e3tfhUJU6XK0dn1OnrR6JleFvHKsLZ23qXKqXHo32ImhetkKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5S9dpBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEFAC16AAE;
	Wed, 14 Jan 2026 15:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768403173;
	bh=SEcQRxFwviHoDEPdFjSTMaGAOFYIZhKgP5ofMTOHSeE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=I5S9dpBfwYRGwoxPp9TOeOu2F6sD+rIvgs6Yb74x1QsGIBbru6xErtyz/iHZ3Xx6h
	 3mCJYm1o3wWpLE3cu+MypyG05v0Mf/rRRzelYquhXBmVkA666d9UlkLW35Yql6k4R7
	 W2WnpmcNQrWOhb4G7+nQ1Hg4GIHY/AB2Z3/HNGm9ofJPrf3imZtegPPrLQRW9YYSdp
	 aigf74a2pODKk49UeGyx3FHQi2/xj4jYe/1zBBvBWLsKrer5nWTC55dClSQwhok6Ai
	 uJLUhP6yN3VKX2efm445dpOLTi+LfBq5/+kmCYJj0SFq1xFmHMKtaxDZUimThBtY3b
	 fm1yj1Fnov3Ig==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id BCFECF40068;
	Wed, 14 Jan 2026 10:06:11 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 14 Jan 2026 10:06:11 -0500
X-ME-Sender: <xms:47BnaRosIbAi790tVW0wbKyDSKEuK4QgP8ejke4soChis3RXUz8HUQ>
    <xme:47Bnaef2Rdu42YvasvdHD2ojSijNErtalJ6J94zkRwbBWhKQvNAoTCLwE75FAcaTy
    oTtrFRi817VlVWja4QmT1ylICXyZsGs3Gj0oXjWDcEcV0LojKxOEUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdefgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegstghougguihhngh
    eshhgrmhhmvghrshhprggtvgdrtghomhdprhgtphhtthhopegrnhhnrgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepvggsihhgghgvrhhssehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtrhhonhgu
    mhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorh
    grtghlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:47BnaV-Ny6oUamapSUFvA4pQvB0g-7V5YH7Zmk3r1gFxeTKcjrJbXg>
    <xmx:47BnaTupK8S3eRjwgRv7XLFbo1mpBPDbvgW2or9rEaVV_3ASBwLImw>
    <xmx:47BnaZqeRBUTJmXjiVgryWaaDy_dSbVedjxiXmF6FAxcBLZ-pGmRmg>
    <xmx:47BnaXrhZVfzX81OMS7w9FcGyhnFdmrpFlmluSsrkrLS1cAtrI6LgA>
    <xmx:47BnaYbtL-q4R6oBTvJr8KWHzsUKgLDUStPP11QngK4sA9EbSXGHIEmB>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9D820780075; Wed, 14 Jan 2026 10:06:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhR4-OOkCaFZ
Date: Wed, 14 Jan 2026 10:04:48 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Trond Myklebust" <trondmy@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Eric Biggers" <ebiggers@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Anna Schumaker" <anna@kernel.org>, linux-nfs@vger.kernel.org
Message-Id: <becabe80-b2e3-4210-bda1-77721f56113b@app.fastmail.com>
In-Reply-To: <a78cf4e4274f8b4e69a3c7bf3aa778ce7cc25f72.camel@kernel.org>
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
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Jan 14, 2026, at 9:53 AM, Trond Myklebust wrote:
> On Wed, 2026-01-14 at 09:19 -0500, Chuck Lever wrote:
>> On 1/14/26 8:19 AM, Jeff Layton wrote:
>> > On Wed, 2026-01-14 at 07:39 -0500, Benjamin Coddington wrote:
>> > > On 13 Jan 2026, at 19:42, Eric Biggers wrote:
>> > >=20
>> > > > On Tue, Jan 13, 2026 at 05:33:37PM -0500, Benjamin Coddington
>> > > > wrote:
>> > > > > > - Individual filehandles are small, on the order of 32- or
>> > > > > > 64-bytes
>> > > > > >=20
>> > > > > > - But there are a lot of filehandles, perhaps billions,
>> > > > > > that would
>> > > > > > =C2=A0 be encrypted or signed by the same key
>> > > > > >=20
>> > > > > > - The filehandle plaintext is predictable
>> > > > >=20
>> > > > > Mostly, yes.=C2=A0 I think a strength of the AES-CBC
>> > > > > implementation is that each
>> > > > > 16-byte block is hashed with the results of the previous
>> > > > > block.=C2=A0 So, by
>> > > > > starting with the fileid (unique per-file) and then
>> > > > > proceeding to the less
>> > > > > unique block (fsid + fileid again), the total entropy for
>> > > > > each encrypted
>> > > > > filehandle is increased.
>> > > >=20
>> > > > This sort of comment shows that the choice of AES-CBC still
>> > > > isn't well
>> > > > motivated.=C2=A0 AES-CBC is an unauthenticated encryption algor=
ithm
>> > > > that
>> > > > protects a message's confidentiality.=C2=A0 It isn't a hash
>> > > > function, it
>> > > > isn't a MAC, and it doesn't protect a message's authenticity.=C2=A0
>> > > > AES-CBC
>> > > > will successfully decrypt any ciphertext, even one tampered
>> > > > with by an
>> > > > attacker, into some plaintext.=C2=A0 You may be confusing AES-C=
BC
>> > > > with
>> > > > AES-CBC-MAC.
>> > >=20
>> > > I'm not confusing them, and you're absolutely correct - if an
>> > > encrypted
>> > > filehandle were tampered with we'd be relying on the decoded
>> > > filehandle
>> > > being garbage - the routines to decode the fsid and fileid would
>> > > return
>> > > errors, because a filehandle's data is meaningful and well-
>> > > structured.
>> > >=20
>> > > That's a big difference from what using a MAC would provide -
>> > > immediate
>> > > knowledge the filehandle had been modified.
>> > >=20
>> >=20
>> > I think a MAC is a better idea here too:
>> >=20
>> > One thing that people keep pointing out is that you could
>> > potentially
>> > sniff traffic and just nab the encrypted filehandles, and match
>> > them
>> > with inode numbers, etc.
>> >=20
>> > If you append a MAC though and check it on the server, you could
>> > give
>> > out filehandles that are limited-use. For instance, with v4, you
>> > could
>> > salt the hash with the long-form clientid and ensure that that
>> > filehandle is only usable by that client. Anyone else gets back
>> > NFS4ERR_STALE.
>> >=20
>> > Couple that with TLS and you'd have a pretty decent guard against
>> > sniffing and filehandle guessing attacks.
>>=20
>> A sniffing attack is easier than guessing a file handle or
>> constructing
>> one. Neither encrypting a filehandle nor signing it protects against
>> sniffing attacks. But using full in-transit encryption does, and we
>> have that implemented already.
>>=20
>> With full in-transit encryption, the plaintext is much much less
>> predictable as well.
>>=20
>> Just sayin'
>>=20
>
> Protection against sniffing and protection against spoofing are two
> completely orthogonal problems. Please don't muddle the already murky
> waters in this thread by confusing the two.

They're not orthogonal here.

Your stated goal is to protect against directly accessing
openly-permitted files under directories that are narrowly
permitted.

One way to access such a file is to guess the filehandle.

Another way is to sniff the filehandle from the wire.

Wire sniffing is cheaper, and signing a filehandle does not
protect from that attack. Signing filehandles would force
attackers to use sniffing, thus defeating any protection
provided by signing.

That's highly relevant to the effectiveness of filehandle
signing, IMO.


--=20
Chuck Lever

