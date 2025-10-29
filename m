Return-Path: <linux-nfs+bounces-15748-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A59C18B80
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 08:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DACE3507C9
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 07:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12A42F6198;
	Wed, 29 Oct 2025 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3jFwnQeC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D18C21FF3F
	for <linux-nfs@vger.kernel.org>; Wed, 29 Oct 2025 07:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723467; cv=none; b=RQ4DtlFJQH2SWx+rWedbHDN1TK/yHV3Z/+TMhK1Tqst0ePbx6fnO0URBZli5GiD5xvs0sPzKSiPMnzNsOiOQp+agUDrfL1n5tpCNcvJGs3krhn6RrDPYTSUUrtrGcQFUBHrc6qpQkHnqwivzm+lzniWj6biIVtt8T5iej44d90M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723467; c=relaxed/simple;
	bh=iWmd19OQ2fXndltzo1SP4z+VW/uOl9N6D4oHmF5cEnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoSXYTl30NyvXy6PLFqoZGS4Cibm01LG5T7XplCoUlE/BcSJbqNO4uDU3anO0bURVV8/D7/N70ve/RI1ld6DZHUVKSp5c2ZiL2IwG7ySmyTMpKbU+GP4SRaTbuRjbUUeai2ufOKO3MHU2v0P1t7IZTCYgIBIRwDFNT/vVUugQw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3jFwnQeC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n7RynGsbj6gkE86i/EvwisX+asCvnpwpQ9tP82IGWEo=; b=3jFwnQeC6XgzDMDN0MgiozRKKf
	x/Oz/j0a1WSroVefBIzKXIy3myeqBEGdNgUvLtfEsTGkyleT7H01lFoAOxLD4U+3iwtjl/sszpAq5
	NBDs1WT5Au1Wi1vVLPnjoLMXaZRq0INwPSCWW/TNvO8QPVfVEj46wwhjmFMqM6CPTueBOrkGSOlvJ
	GAsAM4AEONbfveV26iSBhWm4Q62btPDXvWuZa3YbNIxMNWtQ4TDnYixlW99F3gHJeoYGfwebpqmP6
	wKXnGyWpNSgonO7hc/xF4frnRa66vcPIb5StuvjObKSP6mgWoHHOJA0tXP5FpvHG1UVFf2Nos65aP
	z2ifvrtw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE0kY-000000007ce-3oAk;
	Wed, 29 Oct 2025 07:37:42 +0000
Date: Wed, 29 Oct 2025 00:37:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aQHERq4jVwWRNAXo@infradead.org>
References: <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aPvjiwF9vcawuHzi@kernel.org>
 <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
 <aPwSS9NlfqPFqfn2@kernel.org>
 <aP8qPlA7BEN3nlN8@infradead.org>
 <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
 <aP-YV2i8Y9jsrPF9@kernel.org>
 <a221755a-0868-477d-b978-d2c045011977@kernel.org>
 <aQA4AkzjlDybKzCR@kernel.org>
 <1f7b30d2-f806-400f-81d3-80b6c924c410@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f7b30d2-f806-400f-81d3-80b6c924c410@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 28, 2025 at 11:37:52AM -0400, Chuck Lever wrote:
> > Christoph has repeatedly said DSYNC is needed with O_DIRECT, yet you
> > keep removing it.
> 
> That's not what I read. Over the course of three email threads, he wrote
> that:
> 
> - IOCB_DSYNC is always needed when IOCB_SYNC is set, whether or not
>   we're using IOCB_DIRECT.

Yes.

> 
> - in order to guarantee that a direct write is durable, we /either/ need
>   IOCB_DSYNC + IOCB_DIRECT, /or/ IOCB_DIRECT by itself with a follow-up
>   COMMIT.

Yes - although at this level I'd talk about fsync/fdatasync instead of
COMMIT to be more clear.

> - for some commonly deployed media types, IOCB_DSYNC with IOCB_DIRECT
>   might be slower than IOCB_DIRECT followed up with COMMIT.

This is not primarily about media types.  For any allocation write
(append, hole filling, conversion of unwritten extent, out of place
writes due to reflink or a log structured file system), we need to
commit metadata to make data durable.  Any batching of that is huge
efficiency win.  For pure overwrites (file data written before, not
just preallocated, and not on a file system / file writing out of
place), on devices that do not have a volatile write cache,
using IOCB_DSYNC will usually be fast.  Maybe also on some devices
with a write cache if their REQ_FUA implementation is faster than
a full cache flush (which for cheaper SSDs generally is not the case).

> Therefore, we need to carefully justify why the current patches stick
> with only IOCB_DSYNC + IOCB_DIRECT, or decide it's truly not necessary
> to force all NFSD_IO_DIRECT writes to be IOCB_DSYNC.

Yes.  Especially as the client can explicitly ask for stable writes if
it thinks they are applicable, and the client is in a much better
position to decide that as the application tells it!

> Christoph and I (if I may put words in his mouth) both seem to be
> interested in making NFSD_IO_DIRECT useful in contexts other than a very
> specific enterprise-grade server with esoteric NVMe devices and ultra
> high bandwidth networking.

SSDs or hard disks with a non-volatile write cache aren't exactly
esoteric, they are just the more expensive tier.  But for most write
patterns that doesn't help you anyway.


