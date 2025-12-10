Return-Path: <linux-nfs+bounces-17020-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A966CB18EB
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 01:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85EC9307A21A
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Dec 2025 00:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9401EDA03;
	Wed, 10 Dec 2025 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OorA0uhX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A4B1EBA19
	for <linux-nfs@vger.kernel.org>; Wed, 10 Dec 2025 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765328395; cv=none; b=HV1mPnaTfO4+thdqmH+i7KMJ2LfD7tvvkSFIxkuH1rj/rUylotHghJd+dUpyOs8u/+mW+3hFHj3UVAEtxKoYsw/ehUOWnXpHASpYEOFdZ2O2MrCSvomHTFD5cUzRWOE5ek5uE5PAzN1EL5Iy22VAmY3nfhA2xWBn3GL7tlLKWbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765328395; c=relaxed/simple;
	bh=AlQD/OnVmPLTIHwT1VTIUlJS1GyYs3AGDo9o1BH7Zoo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uW+77S8PzYXmHzW4FPkgFFT9UaKfTs8nifK7ixGM+R/AIc28NfYpcSbeaN3W4xQ18U9V6By163WAbNUZ/vZxF3nJl3XCYFwwOkaB3kClBwKSsZhsH2xX5PA7ylEnE1Av1RgUdxp92w6WqztsE33PMyuhupZAno4RWwCdDK81PCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OorA0uhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8D3C116B1;
	Wed, 10 Dec 2025 00:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765328395;
	bh=AlQD/OnVmPLTIHwT1VTIUlJS1GyYs3AGDo9o1BH7Zoo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=OorA0uhXY9u9DOm16bd4vi0VvVsqEnwR208GjstDSholGA8FXm7NboKcb+xLH9rJE
	 ec0u2aY/KqrDkWkm4EX6Y8CFzR92T0sAcHPAP/WLsQz0edQ285/gYXoHFC2uucaN94
	 XqDxFbfgkZ2nfgbHDTmucKHBOkD5uOuoW/0tG5l7SwlE9h8bLC93hT+IYMGykCqddt
	 mAh387j7t/ofB1uViPizOJdrz4XwqN7e9dV3uLGP2aDjkLZ+5+/WON7/1sbmwlLhYw
	 uRjJecFqQecFf120+25AU6rVu72+w7HlqnzdszYMdzI4WuQgjegKWMS1CJRSVUfgPt
	 2ZEgpHG8mZCaQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id F315EF40078;
	Tue,  9 Dec 2025 19:59:53 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 09 Dec 2025 19:59:53 -0500
X-ME-Sender: <xms:CcY4aUMKYHMp3g4k_O70bVy_CAsnHMff2tO5PhvOR7mhTw5Tfahukw>
    <xme:CcY4aVxkb9TtVX1WfgIMN5XNWrstiOZmtz-C5Mt09sozfuy6c88999EwPsy0oQGnj
    JfZp2Pi80w5cdua_1SavdieCLd8V6miSXPJH75_OXtDsg81mGl1MMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvuddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheplhhoghhhhihrsehhrg
    hmmhgvrhhsphgrtggvrdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepohhk
    ohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmsehtrghlphgvhi
    drtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:CcY4adhVx9aFP6HOuvHHBk4GKPxzYgbbzWX2okYTnTclXMoICSwFYQ>
    <xmx:CcY4acC6CHKYnzygrmAPsAX-zCKUrv0QXEboZauRN57q3v2lgMrIZg>
    <xmx:CcY4aTuSvjYTq2BX_ZfVD6Z_sf60scBTpNe3VAicp5CfVy4F4CoK8w>
    <xmx:CcY4aQdDoV-lQhqGK-ulkh2DwONS7LrzcXdF5MaHXcaYG0BH30pScg>
    <xmx:CcY4aY8kGflUJiOQXDuhxCQxcYPnpEJosm8j4_qKXoQzTNcGoYvRXh4t>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D1788780054; Tue,  9 Dec 2025 19:59:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A76hygnRXIHN
Date: Tue, 09 Dec 2025 19:59:00 -0500
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Thomas Haynes" <loghyr@hammerspace.com>
Message-Id: <87fc84f5-b905-4a19-abc7-a6677179ba15@app.fastmail.com>
In-Reply-To: <176531654526.16766.8587255373456590272@noble.neil.brown.name>
References: <20251208194428.174229-1-cel@kernel.org>
 <176522973244.16766.13514511634601889702@noble.neil.brown.name>
 <ce9714c8-1558-4201-b3a5-bf73567282be@app.fastmail.com>
 <176523482003.16766.5991961928943612885@noble.neil.brown.name>
 <1510f19f-6bfa-47c4-a7fb-0f6fa8f723a1@app.fastmail.com>
 <88a43961-144f-4e11-ab35-2957f00067e8@app.fastmail.com>
 <176531654526.16766.8587255373456590272@noble.neil.brown.name>
Subject: Re: [PATCH v1] NFSD: Use struct knfsd_fh in struct pnfs_ff_layout
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Dec 9, 2025, at 4:42 PM, NeilBrown wrote:
> On Tue, 09 Dec 2025, Chuck Lever wrote:
>
>> NFS3_FHSIZE, for instance, would be defined in both linux/nfs3.h
>> and include/linux/sunrpc/xdrgen/nfs3.h .
>
> Ok, I think this might be getting close to a central issue.
> I think you want the .x file to become the source for all the various
> constants and types with the generated .h files included where needed
> and, significantly, any existing .h files which define the same name NOT
> included in those places.

Yes, that's the path I'm on. The largest confounding factor is the
headers that are shared between client and server implementations.


> That sounds like a good long-term goal, but it isn't clear to me that we
> want to jump straight there.

I don't intend to jump straight there... but if you want to see long
chains of patches that motivate some of these changes, some jumping
will have to occur (even if only as RFC).

Jumping (ie, flag days) might be necessary when replacing NFSv2
components because these are used throughout the implementation
of all three NFS versions. It's actually somewhat less complex for
NFSv3 and NFSv4.

-- 
Chuck Lever

