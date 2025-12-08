Return-Path: <linux-nfs+bounces-17002-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73842CAE5F6
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Dec 2025 00:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB7A53006733
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Dec 2025 23:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CD3231845;
	Mon,  8 Dec 2025 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="cBMLk95E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BowmWkWK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECF21F09A8
	for <linux-nfs@vger.kernel.org>; Mon,  8 Dec 2025 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765234830; cv=none; b=gLVF7oqq2Lv7eKXf2surdc0xlWJmiFLxqnl08OBX7Ug+iVJIx+p8F0gSb1n8bq1Ebj0JPt2meBiaJxemxXJaT33K8rl13KsAAuM6eVmdTvqGNmqE3SKvoCGn4y+HbPEdKGsLxCluu+8UanSajpCrlDuh22ywB0bgcNfEvErrBGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765234830; c=relaxed/simple;
	bh=cb4uCPZ40S80I/TeTVv4P3wyAcN+vmtaB/oNuEABowI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=oXrRZApmr9dgCybIz5bF6iQp8ApdRa8QHv2rDPS+FgFBWG5hBdGLI028ENhxJYG0jN5aRvC7z+svQF93km3EDyKAPaMfBqKSMl1vPdVuETYGdjVIGXTAoVPb8BbFy2/eXe/ii6gco1rQdq9hex6sFFVeCjOg36LWw6fyggT0rlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=cBMLk95E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BowmWkWK; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E81C97A00B3;
	Mon,  8 Dec 2025 18:00:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 08 Dec 2025 18:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1765234825; x=1765321225; bh=tgdvFDA0XYOGLvKnzxCqXuZfb7G/6orwWAc
	cQeDvoxU=; b=cBMLk95EeqLKLKxuM7sNYrq9LlabhaU3CJxGdjLIG1u/ZiS+K+X
	7JQSVilJCVGz79nVHaIjQxWMpe5AfhPi8jcEIHzaGvkxbAT/4NyQij2mVhiebceG
	CdbcM5E0jLzDZRVOhsCikGv6FbrwnumDqiQnrVJ3BeVIp+sTC05UO1IQ1SpCqh6j
	mXrXnCeyJTFlsnhTWuEzZHqPkXeQg89o/sxmZ9osek0pCq0jNVOYHOHUs+PB3UDX
	uXWeiRfEcaZXu8IAnYOdd3ZLSDbP6evf4DYJU7PybKPMZ8SeQJrpt9uJdoVEb1s1
	sHV409XcL9bD5KA7Lfjf1cdJnupDVIcuuHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765234825; x=
	1765321225; bh=tgdvFDA0XYOGLvKnzxCqXuZfb7G/6orwWAccQeDvoxU=; b=B
	owmWkWKgJD3qa2WWQOYfA1hWLcfLsImh66c3knfTbQtKg49jFxhvZgUeAX3bN1zP
	73pywykvQnLWrpMYw06AO94sJtFTcQl5i8FMzokm1Pt4OAodz6pNKa88TOGnrL5+
	2HXaj73WOgeqEY5b5pbVVwMsiDYFqjb05bTm6YuSElOwtdBQK2k+/LPPvp6JYfIb
	1Nr5h0QeWzS2O1QDeQ/nrqjw6pT/1VewdKeKzLb557AfJPeOVLASk4yVJecRbyDf
	B5/VivnN86Y7CStCTASw1ES76mIqLkbrxLtfCOmHLoR+6y6DD0N2C8WlzVV/Dwu0
	JnsfLQ5WmHdoW5Xu0CnpA==
X-ME-Sender: <xms:iVg3abYyV8h79b6pZJDfn7erAKPk_YgL1_MD1ENljQGPYIjGddCmPQ>
    <xme:iVg3aZcW4cZCvSREJ_I2pSe434IzVp-kFoSo3AyZAVeBLD91FAznX45zVcmZ3IgNY
    oBDP_1fBzZAEeGDF-1tlTIOMG3LDieLvpS2ohJzdNB1cw1EyQ>
X-ME-Received: <xmr:iVg3aUIG40D8RL0Vv2kIAHiJgBKu1iRTD79BkspwCMxd_Mv3A9VgyGxKwLZO1-j2mk-1ZGFeDtWrdZGOETmMVzwfMVlR1ZWrpdsIecKilf-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthejredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duteefhfduveehvdefueefvdffkeevkefgtdefgffgkeehjeeghfetiefhgffgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvg
    hlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhghhihrheshhgrmhhmvghrshhp
    rggtvgdrtghomh
X-ME-Proxy: <xmx:iVg3aeITCg4lJQJqpAIbNHbvkBmaD0hMSCuxhir1r7tbLSYAMX_6Ig>
    <xmx:iVg3abURvoBbM9GjvcHidQ0cO-jhE6zSVLOLLiTKui9yVDiBLlvwZQ>
    <xmx:iVg3afklar7BHt34agzLbPesGjIk-hILrKE9WWIaWMKim_3LbpKtjg>
    <xmx:iVg3aZkxn-PCOLCE5JZXQ3g-L_I90cP105qc4zVDso43TzC_5XKZ8A>
    <xmx:iVg3aTGOuI8KEBNthY2LQyCqMje8kP7LqrbkSQsJqwH3CsE5mdxQg_W5>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 18:00:23 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
In-reply-to: <ce9714c8-1558-4201-b3a5-bf73567282be@app.fastmail.com>
References: <20251208194428.174229-1-cel@kernel.org>,
 <176522973244.16766.13514511634601889702@noble.neil.brown.name>,
 <ce9714c8-1558-4201-b3a5-bf73567282be@app.fastmail.com>
Date: Tue, 09 Dec 2025 10:00:20 +1100
Message-id: <176523482003.16766.5991961928943612885@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 09 Dec 2025, Chuck Lever wrote:
> 
> On Mon, Dec 8, 2025, at 4:35 PM, NeilBrown wrote:
> > On Tue, 09 Dec 2025, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >> 
> >> In NFSD's pNFS flexfile layout implementation, struct pnfs_ff_layout
> >> defines a struct nfs_fh field. This comes from <linux/nfs.h> :
> >> 
> >> > /*
> >> >  * This is the kernel NFS client file handle representation
> >> >  */
> >> > #define NFS_MAXFHSIZE           128
> >> > struct nfs_fh {
> >> >         unsigned short          size;
> >> >         unsigned char           data[NFS_MAXFHSIZE];
> >> > };
> >> 
> >> But NFSD has an equivalent struct, knfsd_fh.
> >> 
> >> To reduce cross-subsystem header dependencies, avoid using a struct
> >> defined by the kernel's NFS client implementation in NFSD's flexfile
> >> layout implementation.
> >
> > linux/nfs.h appears to be mostly generic-nfs stuff, rather than being
> > client specific.
> > If this change allowed us to remove "#include <linux/nfs.h>" from nfsd
> > code, then it would be a good change, but I don't see that it does.
> 
> This change is part of a longer series I'm working on that enables
> the removal of linux/nfs.h from parts of the NFSD code base. The
> other two spots that need attention are localio and server-to-server
> copy. I'm not planning to do anything to localio.

So why separate this patch out from the series?

> 
> 
> > Now that "struct knfsd_fh" doesn't encode info about the fh format that
> > knfsd uses, would it instead make sense to discard it and use "struct
> > nfs_fh" throughout NFSD?
> 
> Based on the effort I've already put into dealing with just ssc, I
> think that would be a monumental change, and I'm not convinced it's
> worth the cost.
> 
> What's more, it would move in the wrong direction. Stapling the client
> and server implementations together by using the same headers makes
> the code more difficult to modify without touching both trees in a
> rather invasive way.

Are we planning to get rid of nfs2.h nfs3.h nfs4.h too?

> 
> What I'm trying to do right at the moment is convert NFSD's NFSv2 and
> NFSv3 implementations over to use xdrgen. Getting rid of linux/nfs.h
> and other such dependencies is a firm pre-requisite for that.

This might be useful content to put in the commit message, though not as
useful as providing the whole series (once it is ready) - then we could
see *why* there is that firm pre-requisite.

I think this current patch could only stand on its own if it removed the
#include of nfs.h from nfsd.h and added it just the those .c files which
still needed it.  That would make it more clear that progress was being
made.

Thanks,
NeilBrown

