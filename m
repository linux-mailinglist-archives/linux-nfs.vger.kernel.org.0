Return-Path: <linux-nfs+bounces-15707-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CDDC0F7D7
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 17:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A4C19A3C2E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 16:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CEE30FC31;
	Mon, 27 Oct 2025 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uvb43Zfo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C73F301482
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584351; cv=none; b=jcTfnRpW8Aq9CpoChBwGCXpWQC1+bo36xSE/jYz0Wh/3QKs/Lr4Q1aYNvCWwLiP/gI5ptZJP8vVYe+YtrQCGGvZYUR7BYHC0pgkAeGi2dmYSpCrsQrTjbmqPqtD1aw1VLkj/ZyYl5dLheNgBIfcRumia7DkbAb9AhkR8NnxKHtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584351; c=relaxed/simple;
	bh=1he9ch15QDTU5PnGwZC09GMINY18GuwiMtrii+2VjMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocFyPIZnIsn1dS4wdqzAIm8kSPYXiFTmNlD/NzOwUo2yihsBEV+2nLcFPFIi8HltIq4g2H9y2JCULlmv6zq6nYQgYzgH8IomGdJ9J+jK9VrL4g/KvzVIBa88yy21BxHv1dG7Fg3ACFXn9TcV0VxNsXSXEKSHD+zQHDP3Ytbes9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uvb43Zfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD80C4CEF1;
	Mon, 27 Oct 2025 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761584349;
	bh=1he9ch15QDTU5PnGwZC09GMINY18GuwiMtrii+2VjMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uvb43ZfoVRyUip5eNBqgZ/cP0rnljyRQeC3JkC6WBjm/3kNuUC1R1Jap5gwm+QYI7
	 WOj09o9AMEwDVfQqmPZ9nOGUGnVXFQ2lJQqpeTxzAR2wus0HtNG0BCqRx1r8RhfKQY
	 NAadPI4tvCxueYp6Spdyikbo2RHS//rztvTvr0RsFvBLIIMtjcviMchV7cVppzWdu5
	 LTPhVMEE8eVryrGn+KyJQiT1RA6veDdGgzKJ3qFPMIO+8n5sLPitdHokw6uA/oEcgB
	 qnJyBW9yR6+w/o9Tqr69d7wurFVgiofU4N837sLCFfT06Hv8NMrWDHN12bTm0rGgtL
	 hjg5YzrQB7wiQ==
Date: Mon, 27 Oct 2025 12:59:08 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aP-k3IcqEG7kLtfI@kernel.org>
References: <20251024144306.35652-15-cel@kernel.org>
 <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aPvjiwF9vcawuHzi@kernel.org>
 <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
 <aPwSS9NlfqPFqfn2@kernel.org>
 <aP8qPlA7BEN3nlN8@infradead.org>
 <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
 <fc8e4689-ca7e-45e5-882f-aaa0946e1df7@kernel.org>
 <aP-bVnJ-teH1x5eK@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-bVnJ-teH1x5eK@kernel.org>

On Mon, Oct 27, 2025 at 12:18:30PM -0400, Mike Snitzer wrote:
> On Mon, Oct 27, 2025 at 09:48:23AM -0400, Chuck Lever wrote:
> > On 10/27/25 6:50 AM, Jeff Layton wrote:
> > > On Mon, 2025-10-27 at 01:15 -0700, Christoph Hellwig wrote:
> > >> On Fri, Oct 24, 2025 at 07:56:59PM -0400, Mike Snitzer wrote:
> > >>> Really, even ignoring all the quirkiness of this: that O_DIRECT can
> > >>> fallback to buffered, and we need IOCB_DSYNC|IOCB_SYNC for our use of
> > >>> buffered IO when NFSD_IO_DIRECT configured to ensure data has hit
> > >>> stable storage -- that's enough justification.  Bit circular but
> > >>> compelling to prove the need.. albeit wordy and a lot to unpack.
> > >> You always need IOCB_DSYNC for data to hit stable storage, both for
> > >> buffered and direct I/O.  You need IOCB_SYNC in addition to also sync
> > >> out the timestamps, which I think we now agree we need.  I still don't
> > >> understand why using direct I/O implies that we want NFS stable writes
> > >> and not two-stage writes, though.
> > > That's certainly a possibility too. Consider the case where we have a
> > > WRITE with unaligned parts at both ends. This set so far just does the
> > > ends as synchronous I/Os.
> > > 
> > > We could do the end bits as non-synchronous writes, and follow up with
> > > a vfs_fsync_range() call before returning NFS_FILE_SYNC.
> > 
> > What concerns me a bit is that the code that handles unaligned ends
> > is careful to issue the vfs_iocb_iter_writes in file offset order. Are
> > we OK to use IOCB_DSYNC for the unaligned parts but IOCB_DIRECT +
> > subsequent COMMIT for the direct I/O middle segment?
> 
> LOCALIO's misaligned DIO will issue head/tail followed by O_DIRECT
> middle (via AIO completion of that aligned middle).  So out of order
> relative to file offset.

Doing things out of order does make for needing code to avoid
advancing the file offset in response to misaligned end completing but
middle ends up having a short write.

I think that'd be one can of worms NFSD would need to take on if you
do wan to follow through with getting away from using
IOCB_DYNC|IOCB_SYNC and returning NFS_FILE_SYNC back to the client.

Mike

