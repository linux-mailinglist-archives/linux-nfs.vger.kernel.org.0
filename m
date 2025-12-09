Return-Path: <linux-nfs+bounces-17013-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF10FCB1396
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Dec 2025 22:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E6233007E71
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Dec 2025 21:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67766306496;
	Tue,  9 Dec 2025 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="M6tMCG1O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q6PfeEt7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C40275105
	for <linux-nfs@vger.kernel.org>; Tue,  9 Dec 2025 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765316555; cv=none; b=GzeyPOkDlhn18Z2uZrMuuUIK0d/DiydloeHn8bNJYgLcaAkdF3Rww77lamk2iGSmVj1Afhafqorw8bwab4N6dlN1rPk9qjFts5vN7GQugjb13lEvgq/1mQu1z9XS8b/6TjlwoZkZr7gSciWnrEkKpaAUM22EiRU/v9zM/8Cy150=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765316555; c=relaxed/simple;
	bh=0uz6BDCaRcaUULFk1AMtWGC1BiUs80BrkEHdNTXKecU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=PyDi/SGFbUUsvmabECIGRNJxcV3iNp1ylDpUoDvf8UqQJXafV2zxbjMEtftUW515D7HnT9shiwxtnwp+IsMf+MvZ6O4oln7NKf3utdGJ0rn0g6755LW4zqbkWVkci63ytPd0ht86PmKE0anSzyiC79THnpmahc8qlp6tDY5vyVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=M6tMCG1O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q6PfeEt7; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E2B051D000BF;
	Tue,  9 Dec 2025 16:42:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 09 Dec 2025 16:42:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1765316551; x=1765402951; bh=C+0z/TEqZvCU2yU01ztLf5m4qPcbEi02Qwn
	naAyoBAw=; b=M6tMCG1Ohj/p87RlU0Z2ltFV4hzM0cK0WXMKA3uiFnkS5Z446+1
	VgI2ldndpT/5xtLpEv/c1whO1YU7PxUIBTrMzEQNKZOs0HXpJjcO1uWGgllpk6sQ
	w/fBliGdZ11ICtkLYykXB+lLulHu6mjJfH0oAzzoSgV04zWp4p0GkRNOaAOH6LyR
	zo77h98SkL6WOULhaXrOkurkSj8Pyx88fzfbe6HIonG3Oa3Hd3u9sFmi75hg2xw6
	4TCJIv4U8WpOy9PFM3zGiMLMI1eVhmHsSJilf6haNNHBqUEfy+LU5mag81jf+v3B
	0cayfXkHYwSlt0eByd8Dr3DwiMONAIvLD7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765316551; x=
	1765402951; bh=C+0z/TEqZvCU2yU01ztLf5m4qPcbEi02QwnnaAyoBAw=; b=Q
	6PfeEt7TcdPS68WYTvK+ZN8+vJG7m7ZbVqcV8xlrOqfgw7EpaAJlu8PKrqgAN2w4
	QPDadxHmQbYmC9M2kPYknV40un5KRNvAX1LA/I2cA+I+aKMz7F2ZTlw0elXSPOpP
	Hmv/Jokl37hRtk1qHRR5wjWnUZJBQEDU9ABABLVolC3O+SIqNEIq3X2VKCFR2at4
	R4AkWYI+WUi9JZU48MIVLAv8l7O451Cuj1UlIp26cyOQ1RrF1j7tQVzrnNwE4luj
	TFPW2tNGHM2FWVUEtVNb0oViwBKSikn4pCcNngUMU1C5AaC10dphTfO4FqIasERJ
	stgqHKUI4uNkMqCBYK0vg==
X-ME-Sender: <xms:x5c4aVqdmIWfMyMQBpg2k3HxNYYv9Y0cIAXeA7Jxx9el3nQ2RI7Rgg>
    <xme:x5c4aWvWuqgzLHKySEG2J82mWYPl74cWjuIueYinpYThpTaKNTz0fkvXiRwfbgToS
    ql2CAUHwUCG-spr3oG_wgP8YMj2rpVvr8kRLT86zUjPonMdnf4>
X-ME-Received: <xmr:x5c4aYYrYrwltn9tvC-jd8rDO6E-rVPgJMog6YdQH2y1DgmzSpeC9SEIdwYonYGPiQvONJYcFk_uo4Oy9W3ujkAf7TaYLeJB4GvythbclvN9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvg
    hlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhghhihrheshhgrmhhmvghrshhp
    rggtvgdrtghomh
X-ME-Proxy: <xmx:x5c4adYJWDGvd7rLJzCHo7MzZH6esD-XcdGR-Noi7NNsq3jitmkyGA>
    <xmx:x5c4aZkC2ejdaCC95mzljm_scZ2tcMtjooGOB7hQKYSWEkkqncLRuA>
    <xmx:x5c4aQ2PfxB5QfJ7LlTOewG1U5cUQE2Hh2GslQ-x1caMMDGIJJs5lw>
    <xmx:x5c4aR3nlEmPeTugB0yCPg_oyjzI9AJZ89ESgcea-P20qqQKkPOJ9g>
    <xmx:x5c4aZVcS8z_VxdOgRZDepwFdNzVuNJhOnPvPI2diStRD7GxeiTxXCfV>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 16:42:28 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Thomas Haynes" <loghyr@hammerspace.com>
Subject: Re: [PATCH v1] NFSD: Use struct knfsd_fh in struct pnfs_ff_layout
In-reply-to: <88a43961-144f-4e11-ab35-2957f00067e8@app.fastmail.com>
References: <20251208194428.174229-1-cel@kernel.org>,
 <176522973244.16766.13514511634601889702@noble.neil.brown.name>,
 <ce9714c8-1558-4201-b3a5-bf73567282be@app.fastmail.com>,
 <176523482003.16766.5991961928943612885@noble.neil.brown.name>,
 <1510f19f-6bfa-47c4-a7fb-0f6fa8f723a1@app.fastmail.com>,
 <88a43961-144f-4e11-ab35-2957f00067e8@app.fastmail.com>
Date: Wed, 10 Dec 2025 08:42:25 +1100
Message-id: <176531654526.16766.8587255373456590272@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 09 Dec 2025, Chuck Lever wrote:
>=20
> On Mon, Dec 8, 2025, at 6:13 PM, Chuck Lever wrote:
> > On Mon, Dec 8, 2025, at 6:00 PM, NeilBrown wrote:
> >> On Tue, 09 Dec 2025, Chuck Lever wrote:
> >>> On Mon, Dec 8, 2025, at 4:35 PM, NeilBrown wrote:
> >>> > Now that "struct knfsd_fh" doesn't encode info about the fh format th=
at
> >>> > knfsd uses, would it instead make sense to discard it and use "struct
> >>> > nfs_fh" throughout NFSD?
> >>>=20
> >>> Based on the effort I've already put into dealing with just ssc, I
> >>> think that would be a monumental change, and I'm not convinced it's
> >>> worth the cost.
> >>>=20
> >>> What's more, it would move in the wrong direction. Stapling the client
> >>> and server implementations together by using the same headers makes
> >>> the code more difficult to modify without touching both trees in a
> >>> rather invasive way.
>=20
> OK. If we want to go the other way (replace knfsd_fh with nfs_fh
> throughout NFSD) then I'd rather keep only the struct and the
> CRC hash function in a single header to avoid pulling in a lot
> of junk that only a few consumers need.

This thing that I keep thinking of the is "enum nfs_stat".  I don't
think we want two copies of that in the kernel.  It is currently in
uapi/nfs.h and so in nfs.h

>=20
> However there is still the problem of how large to make the
> structure's data field. Right now it's NFS4_FHSIZE, but that means
> you have to somehow include the header that defines NFS4_FHSIZE,
> and that pulls in a lot more stuff than we really need or want.
> It's difficult to separate the file handle structure from the rest
> of the protocol.

"128".
I don't think this *needs* to be NFS4_FHSIZE (though it will have the
same value).

#define NFS_MAXFHSIZE		128

works for me.

>=20
> NFS3_FHSIZE, for instance, would be defined in both linux/nfs3.h
> and include/linux/sunrpc/xdrgen/nfs3.h .

Ok, I think this might be getting close to a central issue.
I think you want the .x file to become the source for all the various
constants and types with the generated .h files included where needed
and, significantly, any existing .h files which define the same name NOT
included in those places.

That sounds like a good long-term goal, but it isn't clear to me that we
want to jump straight there.

In the first instance, I think the main value of generating code from
xdr is the code - not the declarations.

What barriers are there to NOT using the .h files generated by xdrgen?

 linux/nfs3.h includes
> uapi/linux/nfs3.h. And fs/nfsd/nfsd.h includes linux/nfs.h,
> linux/nfs3.h, and linux/nfs4.h, so there's no escape from the
> uapi headers. (I'm not sure why NFS uapi headers have the
> protocol bits in them; shouldn't they have only the admin UI
> APIs?).
>=20
> I don't think any of this would be terribly obvious to reviewers
> even if the series had more patches. You basically have to go
> spelunking to discover it.
>=20
> A different way to slice this would be to make the subsystem-
> agnostic NFS file handle merely a size and pointer to a buffer
> (like struct xdr_netobj). Then both the client and server
> implementations can use either static arrays or dynamically
> allocated buffers, and they can get their maximum size
> constants from wherever they like.

I don't think the extra indirection of using the xdr_netobj approach for
filehandle is a good idea.

Thanks,
NeilBrown


