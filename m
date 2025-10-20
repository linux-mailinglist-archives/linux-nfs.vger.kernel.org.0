Return-Path: <linux-nfs+bounces-15399-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC93BEFA58
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 09:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0EE189C471
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 07:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522213C17;
	Mon, 20 Oct 2025 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xg8ncWp8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3243A8F7
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 07:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944779; cv=none; b=esue0tbjrk4WNoBRDM2ytVDY5VU6DXkxjD8v7WrPHhk03OBifLu7uBSZqbD0QJpCi8quoIouJIrhGBRkP0DA9GMXwNxD2jS24yKrqCJNQnXBgfcemW4oUJGCPOMClog5Hw2wq0z7ghOf7oddgMHys9VdKn/9Xnhl/3fFLlmdB1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944779; c=relaxed/simple;
	bh=lQfmTnEMS3B7BlbaVb6IOWiT2nLJivaYquet7YDvzv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/K+4+uKQrkZLoOtfu18nWggyf3Mq7stJBUtGbQ19HbcgG3tBbu247jcAT8ZIbEklK/kwbtsGpqzCOkkxexN24bZRqyuQnlllxIDXrbJxvxnZPkv/C/grGWoArVEkRDqDGxBVUCQzXhGNXev2UFDaW4wxC1IHUJaj66WIytmtus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xg8ncWp8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2UU1Wdc225U2NjK2nJ+rCNKYVkTib5DVnPVsOVHj6hg=; b=xg8ncWp83orxqkKJiDkjsF3Pth
	SP+mBCPh5AaZbKcre89hCNyQYurNV1PESPDehrJDCGyr0OA+JziQEpwE4Dkh0Bvxcz/fAT6V/TByp
	BfPB0Z6foYvSGeeY1EHQHCEZry4BgTAUtImlY23OgP89V3TJ/K1hJqZJOw3n6qXqxt8VptCEhck3c
	EMDWBPKIr2LtC2pA8ERDPi7LMb+jWMtbk/LEp3CcVBW4dFTevVHr3pgGnaZfdtS5c0RSO2lR7et+z
	T8uT08qzMsLWYyFhuFB7CH0OsmtxGkYGoDBLm0D/yohqM2/OZ4XtTXt6vFIrrA7QmPINX2yyEcXRZ
	BG0Q7hoQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAkB5-0000000CBja-0DEX;
	Mon, 20 Oct 2025 07:19:35 +0000
Date: Mon, 20 Oct 2025 00:19:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v4 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aPXihwGTiA7bqTsN@infradead.org>
References: <20251018005431.3403-1-cel@kernel.org>
 <20251018005431.3403-3-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018005431.3403-3-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 17, 2025 at 08:54:30PM -0400, Chuck Lever wrote:
> From: Mike Snitzer <snitzer@kernel.org>
> 
> If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
> middle and end as needed. The large middle extent is DIO-aligned and
> the start and/or end are misaligned. Synchronous buffered IO (with
> preference towards using DONTCACHE) is used for the misaligned extents
> and O_DIRECT is used for the middle DIO-aligned extent.

Can you define synchronous better here?  The term is unfortunately
overloaded between synchronous syscalls vs aio/io_uring and O_(D)SYNC
style I/O.  As of now I don't understand which one you mean, especially
with the DONTCACHE reference thrown in, but I guess I'll figure it out
reading the patch.

> If vfs_iocb_iter_write() returns -ENOTBLK, due to its inability to
> invalidate the page cache on behalf of the DIO WRITE, then
> nfsd_issue_write_dio() will fall back to using buffered IO.

Did you see -ENOTBLK leaking out of the file systems?  Because at
least for iomap it is supposed to be an indication that the
file system ->write_iter handler needs to retry using buffered
I/O and never leak to the caller.

> These changes served as the original starting point for the NFS
> client's misaligned O_DIRECT support that landed with
> commit c817248fc831 ("nfs/localio: add proper O_DIRECT support for
> READ and WRITE"). But NFSD's support is simpler because it currently
> doesn't use AIO completion.

I don't understand this paragraph.  What does starting point mean
here?  How does it matter for the patch description?

> +struct nfsd_write_dio {
> +     ssize_t start_len;      /* Length for misaligned first extent */
> +     ssize_t middle_len;     /* Length for DIO-aligned middle extent */
> +     ssize_t end_len;        /* Length for misaligned last extent */
> +};

Looking at how the code is structured later on, it seems like it would
work much better if each of these sections had it's own object with
the len, iov_iter, flag if it's aligned, etc.  Otherwise we have this
structure and lots of arrays of three items passed around.

> +static bool
> +nfsd_iov_iter_aligned_bvec(const struct iov_iter *i, unsigned int addr_mask,
> +                        unsigned int len_mask)

Wouldn't it make sense to track the alignment when building the bio_vec
array instead of doing another walk here touching all cache lines?

> +	if (unlikely(dio_blocksize > PAGE_SIZE))
> +		return false;

Why does this matter?  Can you add a comment explaining it?

> +static int
> +nfsd_buffered_write(struct svc_rqst *rqstp, struct file *file,
> +		    unsigned int nvecs, unsigned long *cnt,
> +		    struct kiocb *kiocb)
> +{
> +	struct iov_iter iter;
> +	int host_err;
> +
> +	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> +	host_err = vfs_iocb_iter_write(file, kiocb, &iter);
> +	if (host_err < 0)
> +		return host_err;
> +	*cnt = host_err;
> +
> +	return 0;


Nothing really buffered here per se, it's just a small wrapper
around vfs_iocb_iter_write.

> +	/*
> +	 * Any buffered IO issued here will be misaligned, use
> +	 * sync IO to ensure it has completed before returning.
> +	 * Also update @stable_how to avoid need for COMMIT.
> +	 */
> +	kiocb->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);

What do you mean with completed before returning?  I guess you
mean writeback actually happening, right?  Why do you need that,
why do you also force it for the direct I/O?

Also IOCB_SYNC is wrong here, as the only thing it does over
IOCB_DSYNC is also forcing back of metadata not needed to find
data (aka timestamps), which I can't see any need for here.

> +	*stable_how = NFS_FILE_SYNC;
> +
> +	*cnt = 0;
> +	for (int i = 0; i < n_iters; i++) {
> +		if (iter_is_dio_aligned[i])
> +			kiocb->ki_flags |= IOCB_DIRECT;
> +		else
> +			kiocb->ki_flags &= ~IOCB_DIRECT;
> +
> +		host_err = vfs_iocb_iter_write(file, kiocb, &iter[i]);
> +		if (host_err < 0) {
> +			/*
> +			 * VFS will return -ENOTBLK if DIO WRITE fails to
> +			 * invalidate the page cache. Retry using buffered IO.
> +			 */
> +			if (unlikely(host_err == -ENOTBLK)) {

The VFS certainly does not, and if it leaks out of a specific file
system we need to fix that.

> +			} else if (unlikely(host_err == -EINVAL)) {
> +				struct inode *inode = d_inode(fhp->fh_dentry);
> +
> +				pr_info_ratelimited("nfsd: Direct I/O alignment failure on %s/%ld\n",
> +						    inode->i_sb->s_id, inode->i_ino);
> +				host_err = -ESERVERFAULT;

-EINVAL can be lot more things than alignment failure.   And more
importantly alignment failures should not happen with the proper
checks in place.


