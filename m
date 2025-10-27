Return-Path: <linux-nfs+bounces-15655-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD468C0D076
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 11:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D582634C928
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 10:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12122F6194;
	Mon, 27 Oct 2025 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IVg6hFYI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2B52F12CE
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761562543; cv=none; b=HkuJvQR//2y/eTRshD5xxfqfhSEKXyyHP+dHpiNtEL0kV/6HXfW8xN0OSjlk/1sRQw3R9zkeFQLwt79HmFVXdbI60G0ecF5sKuMrexixjmr+q24t7PJIH1K1q6Zw14EynMn4SSKcTEy0sP8235ys2UujXlg6GVriD25UpugUscM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761562543; c=relaxed/simple;
	bh=a4t24dTNBdqLFTNVmg+2Zwt7gf7ISssxEGzcV5kbdvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psBK1yQigE40tSKL/FOULyeK5Om0bi0l1vlEEPZdlhg/KMoWgutShQMXYvPaqj3R05tVA88hyj0TKJITxDq30UFo46an9OjJB0808YTG7pZC+FVYOqfQHUKm3glDRZmUHL2svv+1iuOL/s+/5WQeyLdlnKab0er1cjHOvcWDNlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IVg6hFYI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DezmDp3asapGyBhs76RDtf4sHpmsIXHkTlIwb5yW0ws=; b=IVg6hFYIjdaryB8Rf0JFtBjGwZ
	sMOvjTaNxiXnYt+2qIa6ftkc787Op3K3zFmLBWjsJbfXLZKrPZe9BUiwvx/8RhwlWUtJU7Dzyci2H
	G0JpG2Wg9gospWDguyflnix1JRUEXzVEmt3tM5WnNuO7fIjlYOVCUTJUoo8Zex440gOWUVRSpu01a
	6kQxJgw+QwVaOLcs+w28ahELbVsflMtubsCXxwyf2mQn8uyiQn2bJn3uMIwXrnfTtfYW2MOU5d/Wm
	mtTmR4/zp2mqpndnkbHa4Vs2Owu5oNakiVMnxSyE8q5mHT0Vqzx3ZLVa6pFnfUmF0x+DytBCPSoLB
	e79OIsEw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDKt1-0000000Dh1p-0uzk;
	Mon, 27 Oct 2025 10:55:39 +0000
Date: Mon, 27 Oct 2025 03:55:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>, Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aP9Pqx329OCVXlaJ@infradead.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-15-cel@kernel.org>
 <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aPvjiwF9vcawuHzi@kernel.org>
 <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
 <aPwSS9NlfqPFqfn2@kernel.org>
 <aP8qPlA7BEN3nlN8@infradead.org>
 <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 27, 2025 at 06:50:03AM -0400, Jeff Layton wrote:
> > buffered and direct I/O.  You need IOCB_SYNC in addition to also sync
> > out the timestamps, which I think we now agree we need.  I still don't
> > understand why using direct I/O implies that we want NFS stable writes
> > and not two-stage writes, though.
> 
> That's certainly a possibility too. Consider the case where we have a
> WRITE with unaligned parts at both ends. This set so far just does the
> ends as synchronous I/Os.
> 
> We could do the end bits as non-synchronous writes, and follow up with
> a vfs_fsync_range() call before returning NFS_FILE_SYNC.
> 
> We could also just return NFS_FILE_UNSTABLE and let the client follow
> up with a commit when the write is unaligned. That may be the most
> efficient scheme if you have a client streaming unaligned writes to the
> server without gaps.

It's also the most efficient use for most direct I/O writes.

I'm really confused what the promote to stable writes things is trying
to solve.  If the clients wants to do O_(D)SYNC writes it can ask for
STABLE writes itself, no need to do magic on the server.

> > You also need IOCB_DSYNC for direct I/O to hit the media if you want
> > to return NFS_FILE_SYNC.  But I still don't understand why we want or
> > need to return NFS_FILE_SYNC to start with.
> 
> NFS_FILE_SYNC is not required here, but it's better if we can return
> that. If the server returns NFS_FILE_SYNC there is no need for the
> client to follow up with a COMMIT.

Yes, but the server had to do a lot more expensive work for every
write.  And the client can just ask for stable if it wants that.


