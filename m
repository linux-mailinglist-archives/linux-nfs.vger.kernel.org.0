Return-Path: <linux-nfs+bounces-16207-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBE5C41DD7
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 23:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3EA8434A0A2
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 22:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAE8302CC0;
	Fri,  7 Nov 2025 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="iu3sfu2+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yWmg7GrN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A682FFDF4;
	Fri,  7 Nov 2025 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555802; cv=none; b=mEiBf07PZbHM/RpSQtm2C+qKEsHONefXwLnnHuneiKhOWYtyi5R1zvd8HiQmpyGUdjyQU8TRe4zHkcZFdEdKVaEBkfIrYd93WbR5vO/rFMHSERDGAB4bX1uUpTJe6XuWq9HS2fYQDpKV7gF4Jh9J7EGPiqioLUJYxMWsrPMRkHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555802; c=relaxed/simple;
	bh=Aeo/VzE1/UV207VY7Gch3A/3nfTb68ooL8dPoD/Cfgk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=lG9Sp7m19ZgC92YogBUF+xX8tQlzn7ENci82l99xy7Xwr0yzZi8kTqWSdxlx/rO+HMsKPF7aFk/POvCT6HPdJxt+Osu2dLlIVgBAIH13wLyux8I1T05fgJreFwoKleCzbbPjn/j+85asqYlggGHdLCvBWh3bfEDxC6MaJkMtWAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=iu3sfu2+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yWmg7GrN; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 15C9C7A01B6;
	Fri,  7 Nov 2025 17:49:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 07 Nov 2025 17:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762555798; x=1762642198; bh=aCExvVff/T1beCIBhfJtcWSIpIUbwYfLTD4
	NHxXGVdI=; b=iu3sfu2+YJ7TYN2VUmigtGfTH6CAMsDtvQD4TAhwLUVySVkqkpJ
	QGUMOHAORfsvpT4qVHU8fgcgWuhWEQu7LMu+CAKvU0MANY24xEFhQ8xsEaUbnzWx
	seyCzCPRbb5ulphgJ7HfL8KgdOMzAcj6LZTba3B0QLO4RGv+1GhINuN2blWSFCI1
	ivqS4UQOvvrYkOmPeCIS7XQWTQIzHDMnqk+lBmck47W6KCiP7RrBwFLI5zACLlvc
	8U3YBhj0n1g+Gx7OR4Aey3RQkLRZCa4+hkZjZZjMBFOiOdjmmckw43n9rfJo7qck
	jzeAI5dyCkpuEX+75UOXBBhe6kkojcwlaSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762555798; x=
	1762642198; bh=aCExvVff/T1beCIBhfJtcWSIpIUbwYfLTD4NHxXGVdI=; b=y
	Wmg7GrNix50DzyxmmMWAJUoJyrI3nwULpuLdidrebuh9iswgamFWc0BgPE105k+L
	VCSlOAH+QT2nt39mYC4nq/JiJsdqoSiYv7x6QAYS6joHqaWdhw/v5PHjAttJz2YH
	eBCblF14XzqdXzeS5ggIhwopdUbV3KrWxxjkxmqI21LzYAOIXynAyGncq4oHGRFW
	7mzqzMj+3zilAEXuvmLykreM4AJybeek38fwU2HCdDcPQXxQ2XuXlEWrGbhJQdOq
	lKMThsAxIWA+0FRYyQCVGMpR3736QUjbTl5+aORhUQXzxRKaS0MP6ZsMTfQOcvdQ
	hmhattUrbaXkgM+yIuO+w==
X-ME-Sender: <xms:lncOaRzQIDkTa-CRCRh4xZmJ2SYpjHrmJHTDfxrmT_PXKDRe58KOyg>
    <xme:lncOadTBedDKvxcHedF0VgEA7eu5ZvaLJ-o0yCVL2eTe0OAfNk-Xm1g9hzlu0WrfY
    AWaH0hmazOqWBvjPZROQHI15pzS5sSBNavC6LLielthZdJbWJI>
X-ME-Received: <xmr:lncOadhPLzKIB0pEmS33mhes9fK5QTTvGX2CJhSAlfIHJqE9bfxGoaF0F8Ol-gjUNh-0JK0LDARj8r1CIoUHq9XW0q74bq9UUZbunGSwSY8R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledtledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epgeehfeevheehteetudehjeduiefhueehieevvdejkeeufeevkeelieffffduhfevnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgrsghlvg
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhf
    ohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsphgvvggutghrrggtkhgvrheshhhothhmrghilhdrtghomhdprhgt
    phhtthhopegurghvihgurdhlrghighhhthdrlhhinhhugiesghhmrghilhdrtghomhdprh
    gtphhtthhopegurghvihgurdhlrghighhhthesrggtuhhlrggsrdgtohhm
X-ME-Proxy: <xmx:lncOaUnvtP20W8uSG4C8mVFJ6jFF0wSgG_yWQ1P13vF9czCfqZCR5g>
    <xmx:lncOaQtNbwFjr7hXu8207q0mYuOO9iPywfuQAPT0iCX5mHBhFWfM2A>
    <xmx:lncOaSZlTDlM_1AWJvzq4pzotmDI5dOcEU6hqOlazDo6YTbvctdNEQ>
    <xmx:lncOaQBl77wqtwFAkQDUI6In3xYAZaWblNM_I_TrP3679hKJNdn6eg>
    <xmx:lncOaVLv1GPoSSc8pWS15F-PsDNKcMz8lR1C0ds9hUl1c4l49aMkoaot>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 17:49:55 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "David Laight" <david.laight.linux@gmail.com>
Cc: "Chuck Lever" <cel@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "David Laight" <David.Laight@ACULAB.COM>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Linux List Kernel Mailing" <linux-kernel@vger.kernel.org>,
 speedcracker@hotmail.com
Subject: Re: Compile Error fs/nfsd/nfs4state.o - clamp() low limit slotsize
 greater than high limit total_avail/scale_factor
In-reply-to: <20251107114324.33fd69f3@pumpkin>
References: <bbba88825d7b2b06031c1b085d76787a2502d70e.camel@kernel.org>,
 <37bc1037-37d8-4168-afc9-da8e2d1dd26b@kernel.org>,
 <20251106192210.1b6a3ca0@pumpkin>,
 <176251424056.634289.13464296772500147856@noble.neil.brown.name>,
 <20251107114324.33fd69f3@pumpkin>
Date: Sat, 08 Nov 2025 09:49:49 +1100
Message-id: <176255578949.634289.10177595719141795960@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 07 Nov 2025, David Laight wrote:
> On Fri, 07 Nov 2025 22:17:20 +1100
> NeilBrown <neilb@ownmail.net> wrote:
> 
> > On Fri, 07 Nov 2025, David Laight wrote:
> > > On Thu, 6 Nov 2025 09:33:28 -0500
> > > Chuck Lever <cel@kernel.org> wrote:
> > >   
> > > > FYI
> > > > 
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=220745  
> > > 
> > > Ugg - that code is horrid.
> > > It seems to have got deleted since, but it is:
> > > 
> > > 	u32 slotsize = slot_bytes(ca);
> > > 	u32 num = ca->maxreqs;
> > > 	unsigned long avail, total_avail;
> > > 	unsigned int scale_factor;
> > > 
> > > 	spin_lock(&nfsd_drc_lock);
> > > 	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
> > > 		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> > > 	else
> > > 		/* We have handed out more space than we chose in
> > > 		 * set_max_drc() to allow.  That isn't really a
> > > 		 * problem as long as that doesn't make us think we
> > > 		 * have lots more due to integer overflow.
> > > 		 */
> > > 		total_avail = 0;
> > > 	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
> > > 	/*
> > > 	 * Never use more than a fraction of the remaining memory,
> > > 	 * unless it's the only way to give this client a slot.
> > > 	 * The chosen fraction is either 1/8 or 1/number of threads,
> > > 	 * whichever is smaller.  This ensures there are adequate
> > > 	 * slots to support multiple clients per thread.
> > > 	 * Give the client one slot even if that would require
> > > 	 * over-allocation--it is better than failure.
> > > 	 */
> > > 	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
> > > 
> > > 	avail = clamp_t(unsigned long, avail, slotsize,
> > > 			total_avail/scale_factor);
> > > 	num = min_t(int, num, avail / slotsize);
> > > 	num = max_t(int, num, 1);
> > > 
> > > Lets rework it a bit...
> > > 	if (nfsd_drc_max_mem > nfsd_drc_mem_used) {
> > > 		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> > > 		avail = min(NFSD_MAX_MEM_PER_SESSION, total_avail);
> > > 		avail = clamp(avail, n + sizeof(xxx), total_avail/8)
> > > 	} else {
> > > 		total_avail = 0;
> > > 		avail = 0;
> > > 		avail = clamp(0, n + sizeof(xxx), 0);
> > > 	}
> > > 
> > > Neither of those clamp() are sane at all - should be clamp(val, lo, hi)
> > > with 'lo <= hi' otherwise the result is dependant on the order of the
> > > comparisons.
> > > The compiler sees the second one and rightly bleats.  
> > 
> > In fact only gcc-9 bleats.
> 
> That is probably why it didn't get picked up earlier.
> 
> > gcc-7 gcc-10 gcc-13 gcc-15
> > all seem to think it is fine.
> 
> Which, of course, it isn't...

I've now had a proper look at your analysis of the code - thanks.

I agree that the code is unclear (at best) and that if it were still
upstream I would want to fix it.  However is does function correctly.

As you say, when min > max, the result of clamp(val, min, max) depends
on the order of comparison, and we know what the order of comparison is
because we can look at the code for clamp().

Currently it is 

	((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))

which will use max when max is below val and min.
Previously it was 
	min((typeof(val))max(val, lo), hi)
which also will use max when it is below val and min

Before that it was 
#define clamp_t(type, val, min, max) ({                \
       type __val = (val);                     \
       type __min = (min);                     \
       type __max = (max);                     \
       __val = __val < __min ? __min: __val;   \
       __val > __max ? __max: __val; })

which also uses max when that is less that val and min.

So I think the nfsd code has always worked correctly.  That is not
sufficient for mainline - there we want it to also be robust and
maintainable. But for stable kernels it should be sufficient.
Adding a patch to "stable" kernels which causes working code to fail to
compile does not seem, to me, to be in the spirit of "stability".
(Have the "clamp" checking in mainline, finding problems there,
and backporting the fixes to stable seems to me to be the best way
to use these checking improvements to improve "stable").

Thanks,
NeilBrown

