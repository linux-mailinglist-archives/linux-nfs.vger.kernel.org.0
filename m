Return-Path: <linux-nfs+bounces-16239-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32328C4C771
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 09:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43A41884A1F
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Nov 2025 08:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDE0757EA;
	Tue, 11 Nov 2025 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ceQgBU7E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6102EC557
	for <linux-nfs@vger.kernel.org>; Tue, 11 Nov 2025 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851093; cv=none; b=ja4l6JzNvG63jnfwO+kKqaGHdq97LJ8cJT4pfWZfcmXy7qwEYj91AbxQ5/UeirxlCAbD1LTX8CDzlMknMn8efwYaLg96FGgHzmbhJrGMXTEJfa1Z2x0b3q3FAxuLOYuCsithpyL9XtbPEV7jimRb8TwpcoNaEA1aitfEeK1i3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851093; c=relaxed/simple;
	bh=9p8KVGneuIfGVPdzj7PbuCzE195cU+cWekvecQMWkoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bm+Wxy9F/dN4H+0HqpyvuRvi7gy5BL0ojzGnPkExXjvVdWddcKBdu+HD4zwSNRH2bgyjxF3d0cLyCk3o2tVUYwk+lu1xOpRh1JYXzY8K/hKZmOM684sVKLPNwdFfQn5/k07x5eon6o5yBlK1591JrXxw5Q6/LLs573TJh7aF4H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ceQgBU7E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XzKCuQBSoExlmZ4ZNmlriQFtFsF1dgiVeAVaGU/TxBU=; b=ceQgBU7E+KI3sZrH32ZOhVS0LH
	BTpv7D6EMCMbh6EoGqMn1DHj1B0CAUmQrnrxXwdQw+O5peyt/f6QRCV3K5L/Jml6mDJXu572G3HgM
	H2f1XKtr9arGe2jHJbT2Q94+CvAVAOTNdOggx/QY9RokNgpGd7E8RHH0xom5GG+1Gbs2R7ldtqVQg
	ZL1KYS+7d/GJXc1C8m2znQfX2LGpCg0w4M6ycspfOVAY3WdNN1nbq4MMDPOGpvl9tXjG9w2LBY63z
	S5A6OfAnoQLFkWzA76EybDzKcXVCmuaYq1YBXJHTDm6SS/+Q3qTvrcRiEE7vEhpq8EThcws3AeEMt
	Y84CVB5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIk64-00000006o7o-2RL0;
	Tue, 11 Nov 2025 08:51:28 +0000
Date: Tue, 11 Nov 2025 00:51:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>, NeilBrown <neilb@ownmail.net>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aRL5EPMD9VsG1n3D@infradead.org>
References: <aQ4Sr5M9dk2jGS0D@infradead.org>
 <82be5f47-77df-423d-a4f3-17f83ddb6636@kernel.org>
 <aQ5Q99Kvw0ZE09Th@kernel.org>
 <fb0d6399-ea74-462a-982a-df232e3f4be9@kernel.org>
 <aQ5SSnW9xUWj9xBi@kernel.org>
 <176255273643.634289.15333032218575182744@noble.neil.brown.name>
 <aQ5xkjIzf6uU_zLa@kernel.org>
 <176255894778.634289.2265909350991291087@noble.neil.brown.name>
 <aQ6kkd74pj2aUd8b@kernel.org>
 <2b024928-e078-4414-a062-bbeedfeea5d9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b024928-e078-4414-a062-bbeedfeea5d9@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 10, 2025 at 11:41:09AM -0500, Chuck Lever wrote:
> On 11/7/25 9:01 PM, Mike Snitzer wrote:
> > Q: Case 2 uses DONTCACHE, so case 1 should too right?
> > 
> > A: NO. There is legit benefit to having case 1 use cached buffered IO
> > when issuing its 2 subpage IOs; and that benefit doesn't cause harm> because order-0 page management is not causing the MM problems that
> > NFSD_IO_DIRECT sets out to avoid (whereas higher order cached buffered
> > IO is exactly what both DONTCACHE and NFSD_IO_DIRECT aim to avoid.
> > Otherwise MM spins and spins trying to find adequate free pages,
> > cannot so does dirty writeback and reclaim which causes kswapd and
> > kcompactd to burn cpu, etc).
> 
> Paraphrasing: Each unaligned end (case 1) is always smaller than a page,
> thus it will stick with order-0 allocations (if that byte range is not
> already in the page cache), allocations that are, practically speaking,
> reliable.
> 
> However it might be a stretch to claim that an order-0 allocation
> /never/ drives memory reclaim.

That is of course not true.  order-0 pages of course do drive memory
reclaim.  In fact if you're on a file system without huge folios and
an applications that doesn't use THP, the majority of reclaim is
driven by order 0 allocations.

> What we still don't know is exactly what the extra cost of setting
> DONTCACHE is, even on small writes. Maybe DONTCACHE should be cleared
> for /all/ segments that are smaller than a page?

I suspect the best initial tweak is for every segment or entire write
that is not page aligned in the file, as that is an indicator that
multiple RMW cycles are possible.  At least if we're streaming, but
we don't have that information.  That means all of these cases:

 1) writes smaller than PAGE_SIZE
 2) writes smaller than PAGE_SIZE * 2 but not aligned to PAGE_SIZE
 3) unaligned end segments < PAGE_SIZE

If we want to fine tune, we'd probably expand case 2 a bit as a single
page cache operation on an order 2 pages is going to be faster than
three I/Os most of the time, but compared to the high level discussion
here that's minor details.

> Sidebar: I resist calling such writes poorly formed or misaligned, as
> there seems to be a little (unintended) moralism in those terms. Clients
> must write only what data has changed. Aligning the payload byte ranges
> (using RMW) is incredibly inefficient. So those writes are just as
> correct and valid as writes that are optimally aligned.
> 
> When I hear "poorly formed" write, I think of an NFS WRITE that has
> invalid arguments or corrupted XDR.

On poorly formed I fully agree.  Misaligned OTOH doesn't have such a
negative connotation to me.  Of course "not page aligned vs the file
offset" is more descriptive, but it's also awfully long.


