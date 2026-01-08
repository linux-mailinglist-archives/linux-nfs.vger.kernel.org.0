Return-Path: <linux-nfs+bounces-17595-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2B9D00809
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 01:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05D84302035F
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 00:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2161DC1AB;
	Thu,  8 Jan 2026 00:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="mBAe7kig";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jBcpv5eS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A453814F70
	for <linux-nfs@vger.kernel.org>; Thu,  8 Jan 2026 00:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767833812; cv=none; b=T87QUl+vc5ivucQHsSSFrOMAjGnqm+qxejNKMR6Sxr1vhinN491hm2riS6NqZH0af4YSqnpy2Ejg67LQJp8qz89aPKSpHSufF8HoOhxoqXnolQwVeJijPvUF6zQDLctzhRdaYzq6+Em1bThaGx6sGOPW+j7LQDjBldhgFf/QtYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767833812; c=relaxed/simple;
	bh=iqE5oTINWyg3PbFmhzPTIbNNtgaoge115rYOdNPtV+I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ffLjC3AqWskxzC79t5J62syJFzfxQzpbb+1dCBL+IARGrEVIjN8NQ9AJ63UkFAb+8h/aJOePqH64kj0qSqZ/019dCasSRnMm/vtHKyUgzGhAwNUNuFKlwlFuUwUKrGc4PwvVFwHtvbnJGRvA/yettuSfU05Sg14PeonLGV/1vs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=mBAe7kig; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jBcpv5eS; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 790351D00094;
	Wed,  7 Jan 2026 19:56:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 07 Jan 2026 19:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1767833808; x=1767920208; bh=aiqyEyvAxDYTcQlzJPcRN6H2vt8cfa6gjFp
	RebPjUNs=; b=mBAe7kig3VUiIm6nEZwhA6Bmzv8N9OXPcBueGvirYzP2omKQiQP
	R29I1pGm7bgtCw+82w1ANsakRT06jQW9aiBBZHyG9/IBJFPBBVThHea/qwvZzX1x
	lHmMMu6fUgZ5hcbRTHXsydUvYtlFh5CBzUrnUfTo1+EAAliSeY5Q3NFdHkhUXmEd
	aJzrQOHiNRtZlTWtWT3yWPV54nGvknXQTZpnT53rcvp9ZZsg5gc+GtPSjdcexJfJ
	yDjsF2fmDeDBOh162reMxVv8JZ8SZnkC87JI9Kzyz44pO26OFl+3aCIkRSjZZ9Qj
	ye6hnWc8Unp1rQKD3D5hi4BR0wBV724H1QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767833808; x=
	1767920208; bh=aiqyEyvAxDYTcQlzJPcRN6H2vt8cfa6gjFpRebPjUNs=; b=j
	Bcpv5eSpnib2bAWkbap8JtWyihrwibk3DlUIIpdNWowoUteu/B7/tRCn5xsIWuKy
	K1f2+WtpJHtJU7cu5gTWZMhxgE9+jZAx6Zj+HHdkXiMDpTG+bOnNz7hnY4h4fU5T
	gz6PDfTkgatx4z2N0cIGN96XabdBM7YgKTLczv32hTrEqkd007T+hvMcPvwFbYgs
	dSry5+gD9n/gbsRT7t/Wo+YOleSfozQhYc20KsHYCNM9X6LkhcKTY4TRTsJO1afq
	4Hc/KAWn6gafdBNzIq7S4CmX3szNai2oC2r+pogMUHo+hfWAo9Gm9VK3Lme6AmXZ
	dLRW2NGaUz9Tv62+renmQ==
X-ME-Sender: <xms:zwBfaQe1_snOJkLKUKqmTZLDQ9n6_C8vrEl1ubE7Wj1JbeVHhHT1hg>
    <xme:zwBfaRRZ9FqhazBsl2zW-hPVy1gm3BBnTDBvvkhAk3Ex0CnpP-EL389KQyDw8DxO0
    k9lu7aiFk5d4-d87bSl_7VvtNDQXpbT4ljtPp0WH2gUcEaGNfM>
X-ME-Received: <xmr:zwBfaXujDkwCUQF9-ls9AaMVNuIpuAYlyINvYkz7hQFiYU6jnX3mO7mhUO42T82VMU9EA4aK7-VU8-t-cWYF-N7hswTnonosSkl9DnJ_8uN5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdegheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheptggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlhiesihhnfh
    hrrgguvggrugdrohhrghdprhgtphhtthhopehhtghhsehinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:zwBfaSc7aV2EFKeoq9g5FkYTmO64CGggM77TiB3ckw1zjNqcUyhVtw>
    <xmx:zwBfaRbIJdPuGPUzGg_WxfkmldxHcyirCJOSUsxyU8ruSp7xgxMW5A>
    <xmx:zwBfaUbz2UEw_mo2TZ_W1SG9xFFUUsoswH6IW7ezP5bz-FdPngHCbg>
    <xmx:zwBfaWLJqFXR_l4JAUBiuRr15cpYDWNEoyJV7UkxOjBv0E9CmWJHug>
    <xmx:0ABfaTiMpx3qW0V6bZSqL10uya9ONfFGYWpIjC-ABNP7Htt2rTuGxTcF>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 19:56:45 -0500 (EST)
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
Cc: "Christoph Hellwig" <hch@infradead.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v5] NFSD: Track SCSI Persistent Registration Fencing per
 Client with xarray
In-reply-to: <9e127bfa-e4c9-4e06-b5ad-bb375e7d8e2b@app.fastmail.com>
References: <20251227042437.671409-1-cel@kernel.org>,
 <aV6HHwrkoR4OE5qc@infradead.org>,
 <9e127bfa-e4c9-4e06-b5ad-bb375e7d8e2b@app.fastmail.com>
Date: Thu, 08 Jan 2026 11:56:42 +1100
Message-id: <176783380243.16766.17752014824707434037@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 08 Jan 2026, Chuck Lever wrote:
>=20
> On Wed, Jan 7, 2026, at 11:17 AM, Christoph Hellwig wrote:
> > On Fri, Dec 26, 2025 at 11:24:37PM -0500, Chuck Lever wrote:
> >
> >> @@ -342,6 +343,20 @@ nfsd4_block_get_device_info_scsi(struct super_block=
 *sb,
> >>  		goto out_free_dev;
> >>  	}
> >> =20
> >> +	/*
> >> +	 * xa_store() is idempotent -- the device is added exactly once
> >> +	 * to a client's cl_dev_fences no matter how many times
> >> +	 * nfsd4_block_get_device_info_scsi() is invoked. This prevents
> >> +	 * adding more entries to cl_dev_fences than there are devices on
> >> +	 * the server. XA_MARK_0 tracks whether the device has been fenced.
> >> +	 */
> >
> > Only in the most abstract way, xa_store actually stores the new
> > entry/value and returns the old one.  In other words, this does
> > quite a bit of work for the non-initial GETDEVICEINFO.
>=20
> The comment is misleading then, and should be clarified.
>=20
> But should the code use xa_insert instead of xa_store ?

or xa_cmpxchg() to replace NULL with a value??

NeilBrown

