Return-Path: <linux-nfs+bounces-17568-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D872CFFB2F
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 20:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BB2932642D4
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 18:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A836934D3A5;
	Wed,  7 Jan 2026 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nU7J+3Mg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837D134D394
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798884; cv=none; b=j+tZhm7YJApsQyYspAgnBef/L9+keP1+UI+Zidit8e/0Gd5lM9ktBMrgn4wVQe2+s0PMbTqYkcnNqpISFWbBluk4NKcWsu0KSKMYJk8oQX+vgdwHo6gmNT97ccq5CGMOQLTlPGtrcNMcJPJOq+9XXuthNixsbd4xxnyyZGIdmDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798884; c=relaxed/simple;
	bh=LZu0VjM09rQ+PpAAlTkTeRoEnhfmcr/o3Od9ck+Xc4s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ekbitQlN1UcJtnd4xhE+pQgf73mPmwoJbHMzj/W9vaslhFmibfYyhKprPEvBUcqRWnnRBQOXSR2p6OwK+p2totUzbjXFtj+qxDIHyuBLo3uyvu43QFspIh8beYlVNe1aAzHQB3PJM4b4vvhzIyV5u/Ys1h9uarCv3O/gGznVQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nU7J+3Mg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C96C4CEF1;
	Wed,  7 Jan 2026 15:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767798884;
	bh=LZu0VjM09rQ+PpAAlTkTeRoEnhfmcr/o3Od9ck+Xc4s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nU7J+3MgPYcD6NtK+8bsijrwjoKYPgmZrlQ12UjYiU6yNxuwXqtV0r4y8HjPeekgl
	 RYH4TbIWMx4WOXhg7cKlN4eTxbZOtQ2ubTSdBsZuzluRWgMHcQh2HLICebVzKLozjU
	 mThN0PU+kZT6C63gTscn8HBqLsbN9Tr3Y12IsfvBXjpN9h+M4MI+IALZTZRlU6MpVS
	 LWozCkuzjaYcPjRfHV0hwi5gZ5SFk/nRTHu5rBvWljBRmdTeUqSxHRY3bjTZlsZa8M
	 qG+c8+RE/WM5GvPI/59KulX8mb80RR9J/oql8bJfdSgslvxYZ88kUh0UDx2t+Tj7zr
	 mP9bZI5nDWuXg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1122DF4006A;
	Wed,  7 Jan 2026 10:14:43 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 07 Jan 2026 10:14:43 -0500
X-ME-Sender: <xms:Y3heaUHES1SNr3abGZWzomJ_Gq34ZP0gu28qOS3Xq2mwR83UUgR_Gg>
    <xme:Y3heaYLJDxyPFBbTZuOCKqYEOhNdctVuJ83LefnKaJ4nfEgQcQCZC6JrffxsBZhx_
    uHIS7We_7midoObJsAxPVUOhZwoB7137z5j6nJW-xC3-D6iu1aG_O5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprhhitghkrdhmrggtkhhlvghmsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Y3heaay9g0eNPJn2X2MUJz4fpD_INeFh9sK8HIFg6VRFfWaeHyqcBQ>
    <xmx:Y3heaUOT6vlhwur7v1QmdxBng69k8tCuTXHEsT2wsYIm5iiUqTBGSA>
    <xmx:Y3heaT5jue7skyggy7rOCRqNIouLcXaAGLjx1oBtJ1AmpvBnWDyZ3g>
    <xmx:Y3headPg2BI-f7Ui0jtxG6J-EmMkOQf4he9x1PFSAKEBssY9cGM27A>
    <xmx:Y3heaZn-bfiONw1ZHIXq7t4_HVePmGN6fURIa5z0rZeJeRaroNg20y60>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E9352780054; Wed,  7 Jan 2026 10:14:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AOkYyh3N-hyZ
Date: Wed, 07 Jan 2026 10:13:17 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Rick Macklem" <rick.macklem@gmail.com>
Cc: "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Message-Id: <31d5bce8-c4df-42e1-a1a7-37c5b9fc8078@app.fastmail.com>
In-Reply-To: 
 <CAM5tNy5KjQSgRxiOiFHe_3ZCu5v8-ibQ8GfDkscVohLNjgnABA@mail.gmail.com>
References: 
 <CAM5tNy4Waqfaqu7kgtnSNrdyR0jBSzJ76tMTbGJPq4HGbBKHiQ@mail.gmail.com>
 <679b3c2a-b70c-4364-a362-fa5eefbf3af3@app.fastmail.com>
 <CAM5tNy5KjQSgRxiOiFHe_3ZCu5v8-ibQ8GfDkscVohLNjgnABA@mail.gmail.com>
Subject: Re: Limit on # of ACEs in a POSIX draft ACL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, Jan 6, 2026, at 6:44 PM, Rick Macklem wrote:
> On Tue, Jan 6, 2026 at 8:37=E2=80=AFAM Chuck Lever <cel@kernel.org> wr=
ote:
>>
>>
>>
>> On Tue, Jan 6, 2026, at 11:02 AM, Rick Macklem wrote:
>> > Hi,
>> >
>> > When I did the POSIX draft ACL patches, I mistakenly
>> > thought that NFS_MAX_ACL_ENTRIES was a generic
>> > limit that the code should follow.
>> > Chuck informed me that it is the limit for the NFS_ACL
>> > protocol.
>> >
>> > For the server side, the limit seems to be whatever the
>> > server file system can handle, which is detected
>> > later when a setting the ACL is done.
>> > For encoding, there is the generic limit, which is
>> > the maximum size an RPC messages can be (for NFSv4.2).
>> >
>> > For the client, the limit is more important, since it sets
>> > the number of pages to allocate for a large ACL which
>> > cannot be encoded inline.
>> >
>> > So, I think having a sanity limit is needed, at least for
>> > the client.
>>
>> The Linux client does something special with ACL operations:
>> the transport/XDR layer allocates the pages as the reply is
>> read from the transport. It already does this for both
>> NFS_ACL and NFSv4.
>>
>> I don't think there's anything different needed for this case.
> There may be a better way (and I coded this some time ago),
> but I needed an array for the page references, so I could free
> them.

Again, that problem should already be solved in the current
code, although it's possible I'm missing your point.


> If you take a look for NFS4_ACL_MAXPAGES in patch #8
> for the client stuff, you'll see what I mean.
>
> NFS4_ACL_MAXPAGES is calculated from NFS_ACL_MAX_ENTRIES
> and IDMAP_NAMESZ in patch #3.

NFS_ACL_MAX_ENTRIES is an NFS_ACL protocol constant, it's not
related to any sort of implementation limit. So it is, IMHO,
not appropriate to apply to either NFSv4 ACLs or NFSv4.2 POSIX
draft ACLs. That's just me with my architect's hat on.

The thing that is new about NFSv4 is that NFS_ACL ACEs are fixed
in size because they encode "who" identities as UID/GID numbers.
In NFSv4, "who" identities are variable-length strings. It's
really quite impossible for receivers to guess how large these
things are before they land in memory. (It might be better for
the NFS layers to treat ACLs like directories, whose XDR
representation has similar characteristics).

As you pointed out, the file systems where the ACLs are stored
are going to hit their storage limits far sooner than the wire
protocol will become a bottleneck. We just don't have any good
ways for the NFS layers to bound and sanity check incoming ACL
streams though.


--=20
Chuck Lever

