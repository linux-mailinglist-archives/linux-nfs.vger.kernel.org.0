Return-Path: <linux-nfs+bounces-17337-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03701CE4968
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Dec 2025 06:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBE84300B2B9
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Dec 2025 05:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA0B2343BE;
	Sun, 28 Dec 2025 05:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="sBvI/NA8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LgOD+jp9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF082AD0C
	for <linux-nfs@vger.kernel.org>; Sun, 28 Dec 2025 05:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766900971; cv=none; b=gpkRkeI9P4J+Z/FwLTM8ocyvkrbTjPlXzJl/QjT+/bVAfZ/nQdkJsP7qWk570fOAIkTtWIGK3BzfCjEL7A9bIFE7SsA/qxApgTOcJxjidpE3NjNtm9upzzv8YY+S8+YpIgpBN3Wfc643LekvpFIuyFXGMglN5q5N81CVqN+JJ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766900971; c=relaxed/simple;
	bh=x5UkAWx8LIjvD2fWbyweULwdJjffVlo1KLsHkHiWE9k=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=km0XJBbXbGCeKObMwbjye1cc98NMNKgT1N4Mp7rMfzWCjX6HNbGYkHeBL51dVkNBmiMLnWzpcF2CffjLgGP8C9yJk2p/3R51xpLobX2jqUJn3ijzUfKCZW3Sq1a1INYWlW10uecx0N7KJJfXFtuBWP2/mGZMyGQXnjivXACSf2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=sBvI/NA8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LgOD+jp9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6AAB7EC025B;
	Sun, 28 Dec 2025 00:49:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 28 Dec 2025 00:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1766900969; x=1766987369; bh=rAUr0mOlWdmHFkJM9aFCZbym3G+v5Omavr3
	pS8bV4Y8=; b=sBvI/NA8q99EZfxXt2y9BZkYYCCs+98JTyJKb51/6cOyBEjtZks
	gtyeefQ9AAekoeb47iBRrWtTLVS1PA8rWNF+nMn/XAsfDs2OBvBXB0dueMJyupQe
	D89MaD7Xk4XUKDpCS3AphTAbGSdw8vJDUEYHIPKT00aQTtmtsIWegN2Wpoy+f2VK
	oTGoA5I+kIx4TDgp76OuuuGYvQrDUpg0EpJomq4WOzIHqbrzJ4jMobItW8zu0Ez7
	YrHqa0+l21nRjvNRnWQsSDs2KPrP9G31gkDr2ORtZ2qbUInfAUGe++9oS94jMH22
	RlS9qE+gVLGk+bQYRnwC6Um+xMTWzp9OUlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766900969; x=
	1766987369; bh=rAUr0mOlWdmHFkJM9aFCZbym3G+v5Omavr3pS8bV4Y8=; b=L
	gOD+jp9SV13g3mb2kTn8AdZb5vIgx2RqbBThoJRnuC/EkvBBJLQMgi75/wzWEihs
	+7K5wIrGwPDED7BcNVKd/t2g5lw7Gg/3idfn2+FxVYDMLbJDY3wvD03PdNxSTaHb
	rMohLm7bxEEEzhh0TTqm7DG8+Yglz1Bgpct3k2E65LquMfK7bNZU1lrpAzYlwWDt
	27VKPzreV4OEs2O7q1WW4AfxelcnBhQcmoBtGZKkGFFrcyCdIHnD6yOZfEw3WvJY
	8kW7bKAThwtRKPj8NJnsZRZek1G6c3WYoQErx1WtxaGEkbFz5aQiqOpDKfl7+GL/
	TGG9MNZ976Tf16SfZrPQQ==
X-ME-Sender: <xms:6cRQacylSCyqLYek9KK2ba9r3osDA77UmTuMVlzd2jdcTEQN6hPedg>
    <xme:6cRQaT8hZddbMjd2y87HWdQ2vqAIsnUCn-sY9WM1w_Sf3hSBZnCie61HXLknwjZUp
    ZvSvLuwc9E6uPncAtrQr448ecbZat34Ozmln797ekxuf0IMabw>
X-ME-Received: <xmr:6cRQaYIcxSLwawdIdyAyCbWZaW-rhqcA-UxWkp7U6V9WQ4yNguTZXnTzjYyIWLYfWlaYiGlMzaBRPgUOHipmV4r97lUjzIv8SaQkv1fun6cy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejfeegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthht
    ohepthhrohhnughmhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegstghougguihhngheshhgrmhhmvghrshhprggtvgdrtghomh
X-ME-Proxy: <xmx:6cRQaRdfT838tHptWxxKPz0BDXr1OxB32coweR10V6PVdeRVam_Dvg>
    <xmx:6cRQaf_147txx_UnUwzSTxTSjR9UhdIqS2NjUJMBEdDCyFzXijBDlw>
    <xmx:6cRQaWr2Vkcoo70TIs_-r2iRYetvXD34g13majcbzxa6Fg_SyEnShQ>
    <xmx:6cRQacCdKqWLwPpelgylRov6YAlAabKK9DuSvknPtQLDe0SWO0VVZQ>
    <xmx:6cRQaRhdI3Yg04QG9j9Ovdgs-KA5_JRcVHIwoKlH2RxxYn2rL60kGXjo>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Dec 2025 00:49:27 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
In-reply-to: <A70E7B41-A5C0-443C-BD16-00E40F145FD2@hammerspace.com>
References: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>,
 <cover.1766848778.git.bcodding@hammerspace.com>,
 <176687677481.16766.96858908648989415@noble.neil.brown.name>,
 <A70E7B41-A5C0-443C-BD16-00E40F145FD2@hammerspace.com>
Date: Sun, 28 Dec 2025 16:49:25 +1100
Message-id: <176690096534.16766.12693781635285919555@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 28 Dec 2025, Benjamin Coddington wrote:
> On 27 Dec 2025, at 18:06, NeilBrown wrote:
>=20
> > On Sun, 28 Dec 2025, Benjamin Coddington wrote:
> >> In order to harden kNFSD against various filehandle manipulation techniq=
ues
> >> the following patches implement a method of reversibly encrypting fileha=
ndle
> >> contents.
> >>
> >> Using the kernel's skcipher AES-CBC, filehandles are encrypted by firstly
> >> hashing the fileid using the fsid as a salt, then using the hashed filei=
d as
> >> the first block to finally hash the fsid.
> >>
> >> The first attempts at this used stack-allocated buffers, but I ran into =
many
> >> memory alignment problems on my arm64 machine that sent me back to using
> >> GFP_KERNEL allocations (here's to you /include/linux/scatterlist.h:210).=
  In
> >> order to avoid constant allocation/freeing, the buffers are allocated on=
ce
> >> for every knfsd thread.  If anyone has suggestions for reducing the numb=
er
> >> of buffers required and their memcpy() operations, I am all ears.
> >>
> >> Currently the code overloads filehandle's auth_type byte.  This seems
> >> appropriate for this purpose, but this implementation does not actually
> >> reject unencrypted filehandles on an export that is giving out encrypted
> >> ones.  I expect we'll want to tighten this up in a future version.
> >>
> >> Comments and critique welcome.
> >
> > Can you say more about the threat-model you are trying to address?
> >
> > I never pursued this idea (despite adding the auth_type byte to the
> > filehandle) because I couldn't think of a scenario where it made a
> > useful difference.
> >
> > If an attacker can inject arbitrary RPC packets into the network in a
> > way that the server will trust them, then it is very likely to be able
> > to snoop filehandles and do a similar amount of damage...  though I'm
> > having trouble remembering that damage that would be?
>=20
> Filehandles are usually pretty easy to reverse engineer.  Once you've seen a
> few, the number of bits you need to manipulate to find new things on the
> filesystem is pretty small.  That means that (forget about MITM - though
> that is still a real threat) even a trusted client might be able to access
> objects outside the export root on the same filesystem.

So this is only seen to be useful when for sub-directory export?

>=20
> This problem is further exacerbated when using kNFSD as a DS for a flexfiles
> setup - the MDS may be performing access checks for objects that the DS does
> not.  Manipulating filehandles to a DS can circumvent those access checks.

Not being familiar with flexfiles and don't know what that means -
though I can imagine that pNFS could add extra complications.

>=20
> I can absolutely add more information on this for subsequent postings.

That would be helpful - thank.

Next question: why are you encrypting the filehandle?  Is there
something you want to hide?

Normally encryption is for privacy and a MAC (message authentication
code) is used for integrity.  Why are you not simply adding a MAC?

With pure encryption you are relying on the fact that changing (or
synthesising) a filehandle will probably produce a badly formatted
handle  - except that you are only encrypting the bytes after the fsid.=20
So there is less redundancy....  Maybe the generation number is enough
to ensure decrypted garbage will never be valid - by it doesn't feel
clean.=20

If we are using encryption it would be nice to encrypt the whole fh.
Then you would have a single key for the server rather than
per-export....

As Chuck suggested: getting review from someone with crypto design
expertise would be a good thing.

Thanks,
NeilBrown

