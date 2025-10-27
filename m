Return-Path: <linux-nfs+bounces-15689-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C81E0C0EDA5
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 16:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1AC19C755B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAE8824BD;
	Mon, 27 Oct 2025 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vZEXFVxQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2CF23D7DF
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577540; cv=none; b=mfc6UodTCfer6gqmP7uNstOTu533Lm2qZkEH4Ul/5yjIl6DPifd+aKLoR4NfXLpOGOdWp/D1zIWu/jWFxBLy+baQJq3rRgONSv+spkKsLQHapuGz0q4VIGypmo1CbF++LmVyg/nO1VExDpoiSH72NxZ6w9j9k2PlP3/BRiyV9vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577540; c=relaxed/simple;
	bh=rkkODICC5vQPp0uNgArMboNrfLCybkm7zy4AFMldKnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBpY/1gkZwbXv6xSLGPcM2HRUzzeH8fJYxUqQzavfQvJVtHZ0S836Dnw0xZuvIGllYojuhmCacSyCyqsAXtWqpJ/lFNGKXs9DBf/mAN0iHGM5W3LmjgkjetxPXzoR/dU1x4qIdqQfh5NIm9cXTKnYnZa4Aq8uaOlUrePxW6reVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vZEXFVxQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=glkjvT7CuJUGEhh/3YzDmG1Kx/hnBHxi++cK/D755uo=; b=vZEXFVxQXvXgJuX6nJZihTG6U/
	rECakesY5HC8ODGegxxpAZDbPYwqiGFwK2eIore02712LvE1xZ/IWdV/zc5un2aP8w5igec6eyl/B
	4v36TQlD2VlsgXS936N26FLTMvlZ587pkARxaJrMxk1rq+UrGn36kGkbhgdnt9y5eFbP0owhf22Jb
	r5SN6yuXos6UvlGUupa/P1wL3brXvX2+bMQXEryc3V9vWkAM/YDjSo/F187xicyL4wV2chbabBL0L
	ICmhKWNyRa1I19wFFUL9wQk0EvOgda2wi/VXAtHU4k5SM6HAn5YOjatJR2XrggwUCV8kp53MZiOhx
	09+v+XhA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDOmt-0000000EBo8-42bI;
	Mon, 27 Oct 2025 15:05:35 +0000
Date: Mon, 27 Oct 2025 08:05:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v7 05/14] NFSD: @stable for direct writes is always
 NFS_FILE_SYNC
Message-ID: <aP-KP18TRd8PyzM5@infradead.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-6-cel@kernel.org>
 <aP8n4iqMPie83nYy@infradead.org>
 <3c3774a9-a1f1-46a8-a81f-ebc3dde228c3@kernel.org>
 <aP9zU_9e2VDw4G7I@infradead.org>
 <aP-CW5_egXzHS1jz@kernel.org>
 <aP-DYgcrcd2zSzrI@infradead.org>
 <aP-Ii3DgzEaI5Bw4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-Ii3DgzEaI5Bw4@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 27, 2025 at 10:58:19AM -0400, Mike Snitzer wrote:
> On Mon, Oct 27, 2025 at 07:36:18AM -0700, Christoph Hellwig wrote:
> > On Mon, Oct 27, 2025 at 10:31:55AM -0400, Mike Snitzer wrote:
> > > > that.  High-end enough device won't have one, but a lot of devices that
> > > > people NFS-export do.  For pure overwrites the file system could
> > > > optimize this way by using the FUA flag, and at least the iomap direct
> > > > I/O code does implementation that optimization for that particular case.
> > > 
> > > NFSD_IO_DIRECT isn't meant to be uniformly better for all types of
> > > storage.  Any storage that has a volatile write cache is probably best
> > > served by existing NFSD default (NFSD_IO_BUFFERED).
> > 
> > That's a very odd claim.  Also what does it have to do with the rest of
> > the discussion here?
> 
> What's an odd claim?  That shitty storage shouldn't be the bad apple
> that spoils the bunch?  You seem to be advocating for requiring
> additional NFSD resources as part of the NFSD_IO_DIRECT
> implementation.

What f***ing additional resources?   What "shitty" storage?

> But we could make NFSD's behavior tuneable such that it can signal to
> NFS client NFS_FILE_SYNC or not.

Sure.  If you can come up with a good argument for returning it
for writers that don't requrst it, because in general it's going
to make things slower.

> The goal is to walk before expanding to running with other
> permutations of how to tune NFSD's IO modes.

So don't throw in random other permutations and jut concentrate on
direct I/O instead of opening up a totally new can of worms?

> > Why?
> 
> Because NFSD will then need to hold the IO until the COMMIT operation.
> That requires extra NFSD resurces right?

What I/O does it need to hold?  It just needs to implement a commit that
does a range fsync.  The client will have to still track these I/Os,
but that's fairly light weight and for most cases has huge benefits.

> 
> > > The current approach of using IOCB_DSYNC|IOCB_SYNC have performed
> > > really well on modern NVMe servers.
> > 
> > NVMe does not implement a concept called servers.
> 
> But you're aware that servers have NVMe devices in them.. that's all I
> meant.  All of these NFSD_IO_DIRECT changes have been developed and
> tested in modern servers with 8 NVMe, see:
> https://www.youtube.com/watch?v=tpPFDu9Nuuw

I'm not going to watch videos to reply to a mail thread, so if there
is anything important in that please summarize it.

> (NOTE: results covered in this session did _not_ have the benefit
> of NFSD responding to client with NFS_FILE_SYNC to avoid COMMIT, the
> ability to do so was discussed at Bakeathon and was acted on with
> these latest NFSD Direct patchsets).

Why do you think randomly returning NFS_FILE_SYNC is actually going
to improve things?  Except for one particular corner case I expect
it to make things worse, often much worse.

