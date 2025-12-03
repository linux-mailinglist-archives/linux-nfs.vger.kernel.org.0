Return-Path: <linux-nfs+bounces-16871-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B266EC9F62A
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 15:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 63191300775C
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 14:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154B3303A1E;
	Wed,  3 Dec 2025 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8NGb+D8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EE4302166
	for <linux-nfs@vger.kernel.org>; Wed,  3 Dec 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773697; cv=none; b=nIYr1KtXzfzT90wbkCJppXevMWIr+yvy+pYJJ15NCs/c54UWIy6cLayiIAoagD50AYlRqIopeHJqZz9xeD2A9CIOMo1To8N5X9s2Dh6FDvJlRZiA10UAOn0G/ry/Aw0D15k3EA6em3+MZ0nc5SJgM6NvHWrGzsTfBZXd8DsrVaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773697; c=relaxed/simple;
	bh=J5occkpU/0qdNMTyKLXz45WN7D2JqZZ9VpRzhUXuFXU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=je5OWuirxWjKngPgW81RUGj545XrCbaIwR3VKLSKRLZD3hGHOhFnMPTfLCCm978Jh73xTPBWnFvGjX7UX9Qj6wVrSlcg1D6fMW6jB801kq0KPz4sX4xe+C/S/50vUDJJaLf7MGLEO7fdHFGXuxsFNM6DmJMpxuU26ps74U+3su4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8NGb+D8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F192C4CEF5
	for <linux-nfs@vger.kernel.org>; Wed,  3 Dec 2025 14:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764773696;
	bh=J5occkpU/0qdNMTyKLXz45WN7D2JqZZ9VpRzhUXuFXU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=a8NGb+D8uk4xi4NPkghcaiWyUohZ5U8Cw1sLMTbnGh0wB2oiaY2cMSImtbaLX8NCo
	 RY6hADhUOMxpTvKE1qaqgXc5/oy+eRmcMtVW4TJPwH87PBM8ANUwncAVC1JfQ7Or1r
	 eb2wNro+XHq2Gc4HTcqMcuHCG1UgAX1ZOmaEmCNG9XnNfDK5KqAs4IJ8DshacgxIHL
	 Hqhpk9ad7xyJlNFQmE1leZ10qkfmcy7YmfxTQ6P6XVfcJJE8n/utKAFT61b0X9JIPO
	 ibo+DfD+qVl8RfPcMAA3h9422xnw3u58tuEvw1wbejFeb0312UD0Bz4PgspjwmXjRN
	 62EmernmBhhKw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8379AF40068;
	Wed,  3 Dec 2025 09:54:55 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 03 Dec 2025 09:54:55 -0500
X-ME-Sender: <xms:P08waT1071ySN-zo8lCOVV9CSoiDbB9psc4ZLSLo2KhE6n9ORpkBCA>
    <xme:P08wac4fLp6cnN4TY3jd04jMQ0ke0dD_MxXE-lm_iqIuLW-HQSBmK4kLS1e17EMRS
    QuWd8I22QYXxgURZrXnwPtwG56eJFGlKGN2gfs6kfRwKpCQAHEO6XY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgtkhcu
    nfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklh
    gvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleelleeh
    ledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdr
    tghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtth
    hopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhesthgr
    lhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:P08waQPpfNj1Ba4V8XPC1zN8_J4-Pi1cud1h7Vi7Gv1sURL_Nu5bjg>
    <xmx:P08waXpW-12tk_f_w_a7Dmaxn9GtSKpWFEeq6QM54fm1w0MVzHq7Cg>
    <xmx:P08waVdC4p_FDO4QuDHXUaNrFNh0wiJnsNt6LzMPERgm7C95qObFgw>
    <xmx:P08wadTIcUd-qUtMKpYvi7euTOnTBsk2CNjiAKxUY6jhcvsDCTgd1w>
    <xmx:P08waeZVKxWvZ58RseXx5gvaQdPhhvCQSuAMWbE3jvejHdpcTjvvXVmF>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 63A9E780054; Wed,  3 Dec 2025 09:54:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AW-f6n96Aybc
Date: Wed, 03 Dec 2025 09:54:35 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>
Cc: "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <079ef086-fa1c-4a9f-b011-e47547b4e3bc@app.fastmail.com>
In-Reply-To: <eaaa46486ec7b1273adfc1a3bdbf11cb1f557e40.camel@kernel.org>
References: <20251202224208.4449-1-cel@kernel.org>
 <176471811359.16766.18131279195615642514@noble.neil.brown.name>
 <dc25626e-fae0-401b-93ed-1c4fdf34186c@app.fastmail.com>
 <176472909957.16766.8691035364646019081@noble.neil.brown.name>
 <eaaa46486ec7b1273adfc1a3bdbf11cb1f557e40.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] nfsd: prevent write delegations when client has existing
 opens
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Dec 3, 2025, at 7:26 AM, Jeff Layton wrote:
> On Wed, 2025-12-03 at 13:31 +1100, NeilBrown wrote:
>> On Wed, 03 Dec 2025, Chuck Lever wrote:
>> >=20
>> > On Tue, Dec 2, 2025, at 6:28 PM, NeilBrown wrote:
>> > > On Wed, 03 Dec 2025, Chuck Lever wrote:
>> > > > From: Chuck Lever <chuck.lever@oracle.com>
>> > > >=20
>> > > > When a client holds an existing OPEN stateid for a file and then
>> > > > requests a new OPEN that could receive a write delegation, the
>> > > > server must not grant that delegation. A write delegation promi=
ses
>> > > > the client it can handle "all opens" locally, but this promise =
is
>> > > > violated when the server is already tracking open state for that
>> > > > same client.
>> > >=20
>> > > Can you please spell out how the promise is violated?
>> > > Where RFC 8881, section 10.4 says
>> > >=20
>> > >    An OPEN_DELEGATE_WRITE delegation allows the client to handle,=
 on its
>> > >    own, all opens.=20
>> > >=20
>> > > I interpret that to mean that all open *requests* from the applic=
ation can
>> > > now be handled without reference to the server.
>> > > I don't think that "all opens" can reasonably refer to "all exist=
ing or
>> > > future open state for the file".  Is that how you interpret it?
>> >=20
>> > It is: as long as a client holds a write delegation stateid, that=E2=
=80=99s a
>> > promise that the server will inform that client when any other clie=
nt
>> > wants to open that file. In other words, an NFS server can=E2=80=99=
t offer a
>> > write delegation to a client if there is another OPEN on that file.
>>=20
>> Agreed: "other" client and "another" OPEN.
>>=20
>> >=20
>> > The issue here is about an OPEN that occurred in the past and is st=
ill
>> > active, not a future OPEN. NFSD was checking for OPENs that other
>> > clients had for a file before offering a write delegation, but it d=
oes not
>> > currently check if the /requesting client/ itself has an OPEN state=
id for
>> > that file.
>> >=20
>>=20
>> I don't see a problem with offering a write delegation when the client
>> previously had the same file open.
>> Note that a client only ever has one stateid for any given file.  If =
it
>> opens the same file again, it will get the same stateid - with seqid
>> incremented.  If it closes the stateid, then it will not have that fi=
le
>> open at all any more.

> I agree with Neil here (despite my questioning this on our call
> yesterday).
>
> Conceptually, granting a write delegation to a client that already
> holds an open stateid for the file doesn't seem problematic. Before
> returning that delegation, the client would need to establish open
> stateids for any opens that it had granted locally. If it already holds
> an open stateid though, then that isn't a problem IMO -- it just has a
> head start on establishing them before a DELEGRETURN.

Then you prefer the v1 patch that reuses the nfsd_file already
in fi_fds[O_RDONLY], and we can drop the addition of the
WARN_ON_ONCE ?


--=20
Chuck Lever

