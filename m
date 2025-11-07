Return-Path: <linux-nfs+bounces-16210-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B221C41FDD
	for <lists+linux-nfs@lfdr.de>; Sat, 08 Nov 2025 00:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A81F3A6DBE
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 23:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84154314D11;
	Fri,  7 Nov 2025 23:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="iZ2/DZKT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="US/eAR8Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD63C34D3B1
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762558955; cv=none; b=AveBBmmX0dWEbcPodxnBfnxmZCxClmpbX0L9QJPWbR8I5g9VN/7PILdnqVvLzJoZnklZoQnw3balk4RwSE+rJnbmqmGKjg1bxcnSvsvalrPKD46grgwyrOCn7Gbe3J0yy8aEet9s22+tM3ry1ePcvIPHPUdVsMWlHOdekZGto5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762558955; c=relaxed/simple;
	bh=djJqZxFgEwrUsbtFmhGe9ypnk27Qz1EWru3CjUdKICI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=gQcAWa+sWzEqbrQWrb5IPQ+jcN5BwrT4TGl3ywd9mXFfmmTUuG/DPax6h419xOvy2/G2jb9d+BI2JeTNLiRXIYORYN17AXfGYz3u5PXeoJQGD98r1YYhiS697ltxUUudUbbJff3gVBQlbCZYajyE+7gBWmjV7ty2/9C3ViPVnA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=iZ2/DZKT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=US/eAR8Q; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id AE1CE1D00196;
	Fri,  7 Nov 2025 18:42:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 07 Nov 2025 18:42:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762558952; x=1762645352; bh=tAjD6Wbtko7JHVQRhAJqJQyWHCv7vYvNT+9
	RwYOhClk=; b=iZ2/DZKTgTF1hJ/WmuPuNt2KaiTFxnP7u3pecKTHoOt04Ydif7O
	FzVhHRPSTim6iNfz9HOIyYLcV4+hc5+J9MhtIMAlGvmaak4Wy4LZt6lddkvhwiF3
	ZEY3dKXMZMf5OA8fOoDWOGaeIFlHBM6R4xDlPxgbItUCPJvgqFtgbTeeidTK6NHC
	o8vLgh/iwq8O3Wt/eDjDp/UB/XjUikAvUNX8ba4GkL4UyLvhDBKA7HsRr4xusWsh
	Pxnr9dSpxHKcsPQFs3vQtPdUjKWygxL7c0O0l2+ZDkwZ0ppJ640T8WvqMTdwvWg3
	dMPhBLkzLYbMyxdzWVmrP3OQPx6OAl2eMxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762558952; x=
	1762645352; bh=tAjD6Wbtko7JHVQRhAJqJQyWHCv7vYvNT+9RwYOhClk=; b=U
	S/eAR8QIKvnXMuIFROcWgfbKRs8i24+W4Kr1G+ZwEValfIqS2I0FkyvW1qU4ouPR
	jpSfjlYZKT3goxV4FZ7DMV7BJa9cqbVhRjWLr8SzMp9PAPbIFkOGT5sVfTUBg73p
	8eCbeM0mSD+Il6WUQqmB1KwVbfCQrAXCoPAbK+6WR1lYrE2OJmSylE62hwywQHJM
	gfXnYC0VGj7JiWKlA9wmqP7fm79EMiAEuwSjLUQtmVZSY46/fYgJPJ7NiLG1EvqA
	RgKoKuL5ZuElaPNsS4Hi/kw42mAFgDa8P4kqhRR6LtEKF8xYH4OxCx1uZPiL7efz
	bP3uNRf7TTDmIxgm8MM/Q==
X-ME-Sender: <xms:6IMOafIkeT4J-XRcARUbhGwgQobyaU4CX02KYN0fkBry1O5IUet4OA>
    <xme:6IMOaVsHko5z4MeOZI83Mx3Ruu1FhL9v-i5gVA4Xm10qnaz55Eu1rzRocigJuo8Kx
    kAYJ4A7d1wZJGQnEyxC3Kc0xYGmEdABBs-x8ULifO8qO_9c>
X-ME-Received: <xmr:6IMOabW4yh-5FIrOS3JxYY62_MupWEgIEZVMG9AoZHsEgy5tVgQROaO1V9Ru6GrTLDYJlfHgmnHN64xjuqCiOMKnUP1ssdqHArU5guJoazVp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledutdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepshhnihhtiigvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    hlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvlheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:6IMOaYj4q_XKlUSjy0G6xNXCuv-j0qtjzJ7Qg2979XWCadwVrxIvyw>
    <xmx:6IMOaboxY6pOhFfWeg8YAOGdFDxwcP2wmnEfF103A49Vm_8eSMTq2Q>
    <xmx:6IMOaWH-AuDw7ag0ZGWXjarL_aicP9DHmBmb_NAgyY3AMPv7QqOJ3Q>
    <xmx:6IMOaY5xRHoh-MM166Hwv3-gG4HGIF9vgon-K45w8kzjmtFqfn45hw>
    <xmx:6IMOaXf28rTNz1Vyg4f1Ypdoqm_bxq9Ay_EGqEdT6NQ4bUqcVkC-aXBT>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 18:42:29 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: "Chuck Lever" <cel@kernel.org>, "Christoph Hellwig" <hch@infradead.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
In-reply-to: <aQ5xkjIzf6uU_zLa@kernel.org>
References: <20251107153422.4373-1-cel@kernel.org>,
 <20251107153422.4373-3-cel@kernel.org>, <aQ4Sr5M9dk2jGS0D@infradead.org>,
 <82be5f47-77df-423d-a4f3-17f83ddb6636@kernel.org>,
 <aQ5Q99Kvw0ZE09Th@kernel.org>,
 <fb0d6399-ea74-462a-982a-df232e3f4be9@kernel.org>,
 <aQ5SSnW9xUWj9xBi@kernel.org>,
 <176255273643.634289.15333032218575182744@noble.neil.brown.name>,
 <aQ5xkjIzf6uU_zLa@kernel.org>
Date: Sat, 08 Nov 2025 10:42:27 +1100
Message-id: <176255894778.634289.2265909350991291087@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 08 Nov 2025, Mike Snitzer wrote:
> On Sat, Nov 08, 2025 at 08:58:56AM +1100, NeilBrown wrote:
> > On Sat, 08 Nov 2025, Mike Snitzer wrote:
> > > On Fri, Nov 07, 2025 at 03:08:11PM -0500, Chuck Lever wrote:
> > > > On 11/7/25 3:05 PM, Mike Snitzer wrote:
> > > > >> Agreed. The cover letter noted that this is still controversial.
> > > > > Only see this, must be missing what you're referring to:
> > > > > 
> > > > >   Changes since v9:
> > > > >   * Unaligned segments no longer use IOCB_DONTCACHE
> > > > 
> > > > From the v11 cover letter:
> > > > 
> > > > > One controversy remains: Whether to set DONTCACHE for the unaligned
> > > > > segments.
> > > 
> > > Ha, blind as a bat...
> > > 
> > > hopefully the rest of my reply helps dispel the controversy
> > > 
> > 
> > Unfortunately I don't think it does.  I don't think it even addresses
> > it.
> > 
> > What Christoph said was:
> > 
> >    I'd like to sort out the discussion on why to set IOCB_DONTCACHE when
> >    nothing is aligned, but not for the non-aligned parts as that is
> >    extremely counter-intuitive.
> > 
> > You gave a lengthy (and probably valid) description on why "not for the
> > non-aligned parts" but don't seem to address the "why to set
> > IOCB_DONTCACHE when nothing is aligned" bit.
> 
> Because if the entire IO is so poorly formed that it cannot be issued
> with DIO then at least we can provide the spirit of what was requested
> from the admin having cared to enable NFSD_IO_DIRECT.

"so poorly formed"...  How can IO be poorly formed in a way that is
worse than not being aligned?

> 
> Those IOs could be quite large.. full WRITE payload.  I have a
> reproducer if you'd like it!

Can they?  How does that work?
From looking at the code I can only see that "Those IOs" are too small
to have any whole pages in them.

Maybe we need a clear description of the sort of IOs that are big enough
that they impose a performance cost on the page-cache, but that somehow
cannot be usefully split into a prefix/middle/suffix where prefix and
suffix are less than a page each.

Thanks,
NeilBrown

> 
> Limiting extensive use of caching buffered IO is pretty important if
> the admin enabled NFSD_IO_DIRECT.
> 
> A misaligned WRITE's non-aligned head and tail are _not_ extensive
> amounts of mmeory.  They are at most 2 individial pages.
> 
> > I can see Christoph's point.
> >
> > Can you please explain why all the arguments you have for avoiding
> > IOCB_DONTCACHE on the non-aligned head and tail do not equally apply
> > when the whole body is assessed as non-aligned.  i.e.  the no_dio label
> > in nfsd_write_dio_iters_init().
> 
> Sure, hopefully I just did above.
> 


