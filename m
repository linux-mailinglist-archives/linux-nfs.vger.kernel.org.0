Return-Path: <linux-nfs+bounces-15414-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ED5BF2695
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 18:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABDC188442E
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 16:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1AC287505;
	Mon, 20 Oct 2025 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSTozqEX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C72874E9
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977628; cv=none; b=QnuYN6l/XZjwqEwpUP7MALPW79S9lryNCSjerdRQhJ2KJSVrEbimInrYbbKEDUAGHRRZocgu+oyL182WXgXnNS8yVAbWc6urc35tj01+s5+/ywvTfyxDhXn8uivA71oxtTJ95RlfX6Hti3VI+uF4VsYYMY8XPgIxbZEsZ8AGaIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977628; c=relaxed/simple;
	bh=jWvUcxn0FfM72EXxJ+4PcUIlI5eOVa6A8BSCszzuKHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDuDaOpU3WxX004eNNqj8mQll0W6G8nvorfRD5TxGVWN1d2PwScDXKN5v2elmDMuZ1PuYTN7zdWEXfc2lHPWg/SG9OLXSwqpW3YkPG05SZ/VKxLMVuzuP4zDLIpd7dW+76tSy8hZ9VUNzFWzOrZv8BvfPweqHqKRy7vAo4b7ba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSTozqEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C89C4CEFE;
	Mon, 20 Oct 2025 16:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977626;
	bh=jWvUcxn0FfM72EXxJ+4PcUIlI5eOVa6A8BSCszzuKHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GSTozqEXAjMuIZ5P2F6wY1scyUq9Zm2nSubDzdZAvYgsHKcKWfjkKW25lmWiyV4Lz
	 mLi7VYDGPLnYxq/SJ2+y7T0jDgl527LAXOR0vCPv+Qw+Q4dxy863AGIpigsBQNF+uS
	 dCE7qKdv6W51dMKqCQ5jvVRhOGsAB658BMF2mk1ggWVBDTVWijbC1+dTgojeOVXLrB
	 1eUNo1+AUMallq0yEgZZmMMG+P4k3UI/51h4i4t9knnocvnEi2h3BQOiRt8I12/G9f
	 RshMkZD6GOikw20q3skRMo/5K7+/5PPh31F6rrwxgstzQMUcNS2d3RXNW1G3dMtdZT
	 DOHRTiJvr7LOw==
Date: Mon, 20 Oct 2025 12:27:04 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aPZi2DXtdELwjTu2@kernel.org>
References: <20251018005431.3403-1-cel@kernel.org>
 <20251018005431.3403-3-cel@kernel.org>
 <aPXihwGTiA7bqTsN@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPXihwGTiA7bqTsN@infradead.org>

On Mon, Oct 20, 2025 at 12:19:35AM -0700, Christoph Hellwig wrote:
> On Fri, Oct 17, 2025 at 08:54:30PM -0400, Chuck Lever wrote:
> > From: Mike Snitzer <snitzer@kernel.org>
> > 
> > If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
> > middle and end as needed. The large middle extent is DIO-aligned and
> > the start and/or end are misaligned. Synchronous buffered IO (with
> > preference towards using DONTCACHE) is used for the misaligned extents
> > and O_DIRECT is used for the middle DIO-aligned extent.
> 
> Can you define synchronous better here?  The term is unfortunately
> overloaded between synchronous syscalls vs aio/io_uring and O_(D)SYNC
> style I/O.  As of now I don't understand which one you mean, especially
> with the DONTCACHE reference thrown in, but I guess I'll figure it out
> reading the patch.

It clearly talks about synchronous IO.  DONTCACHE just happens to be
the buffered IO that'll be used if supported.

I don't see anything that needs changing here.

> > If vfs_iocb_iter_write() returns -ENOTBLK, due to its inability to
> > invalidate the page cache on behalf of the DIO WRITE, then
> > nfsd_issue_write_dio() will fall back to using buffered IO.
> 
> Did you see -ENOTBLK leaking out of the file systems?  Because at
> least for iomap it is supposed to be an indication that the
> file system ->write_iter handler needs to retry using buffered
> I/O and never leak to the caller.

fs/iomap/direct-io.c:__iomap_dio_rw() will return -ENOTBLK on its own.

> > These changes served as the original starting point for the NFS
> > client's misaligned O_DIRECT support that landed with
> > commit c817248fc831 ("nfs/localio: add proper O_DIRECT support for
> > READ and WRITE"). But NFSD's support is simpler because it currently
> > doesn't use AIO completion.
> 
> I don't understand this paragraph.  What does starting point mean
> here?  How does it matter for the patch description?

This patch's NFSD changes were starting point for NFS commit
c817248fc831

How does it matter that this NFSD code served as the basis for NFS
code that has been merged?  I thought it useful context.

> > +struct nfsd_write_dio {
> > +     ssize_t start_len;      /* Length for misaligned first extent */
> > +     ssize_t middle_len;     /* Length for DIO-aligned middle extent */
> > +     ssize_t end_len;        /* Length for misaligned last extent */
> > +};
> 
> Looking at how the code is structured later on, it seems like it would
> work much better if each of these sections had it's own object with
> the len, iov_iter, flag if it's aligned, etc.  Otherwise we have this
> structure and lots of arrays of three items passed around.

I did look at doing that, really isn't much better. And 2 isn't lots.

But not opposed to revisiting it.

Would prefer that cleanup, if done, to happen with an incremental
follow-up patch.

> > +static bool
> > +nfsd_iov_iter_aligned_bvec(const struct iov_iter *i, unsigned int addr_mask,
> > +                        unsigned int len_mask)
> 
> Wouldn't it make sense to track the alignment when building the bio_vec
> array instead of doing another walk here touching all cache lines?

Yes, that is the conventional wisdom that justified Keith removing
iov_iter_aligned.  But for NFSD's WRITE payload the bio_vec is built
outside of the fs/nfsd/vfs.c code.  Could be there is a natural way to
clean this up (to make the sunrpc layer to conditionally care about
alignment) but I didn't confront that yet.

Room for follow-on improvement to be sure.

> > +	if (unlikely(dio_blocksize > PAGE_SIZE))
> > +		return false;
> 
> Why does this matter?  Can you add a comment explaining it?

I did/do have concerns that a bug in the storage driver could expose
dio_offset_align that is far too large and so bounded dio_blocksize to
a conservative size.  What is a better constant to check?

But... for trusted storage and drivers, probably doesn't matter and
could be removed.

I split the check out:

        if (unlikely(dio_blocksize > PAGE_SIZE))
                return false;
        if (unlikely(len < dio_blocksize))
                return false;

could've been:

        if (unlikely(dio_blocksize > PAGE_SIZE || len < dio_blocksize))
                return false;

physical blocksizes larger than PAGE_SIZE are coming (or here?) but
overall this initial NFSD O_DIRECT support isn't meant to concern
itself with such exotics at this point.

> > +static int
> > +nfsd_buffered_write(struct svc_rqst *rqstp, struct file *file,
> > +		    unsigned int nvecs, unsigned long *cnt,
> > +		    struct kiocb *kiocb)
> > +{
> > +	struct iov_iter iter;
> > +	int host_err;
> > +
> > +	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> > +	host_err = vfs_iocb_iter_write(file, kiocb, &iter);
> > +	if (host_err < 0)
> > +		return host_err;
> > +	*cnt = host_err;
> > +
> > +	return 0;
> 
> 
> Nothing really buffered here per se, it's just a small wrapper
> around vfs_iocb_iter_write.

Its factored out code with in a named function. Name fit its purpose.

> > +	/*
> > +	 * Any buffered IO issued here will be misaligned, use
> > +	 * sync IO to ensure it has completed before returning.
> > +	 * Also update @stable_how to avoid need for COMMIT.
> > +	 */
> > +	kiocb->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
> 
> What do you mean with completed before returning?  I guess you
> mean writeback actually happening, right?  Why do you need that,
> why do you also force it for the direct I/O?

The IO needs to have reached stable storage.

Changing these flags when IOCB_DIRECT used doesn't seem needed.

Open to suggestions, could be I'm being too heavy but the goal is to
ensure the misaligned ends (head and tail) have hit the storage.

> Also IOCB_SYNC is wrong here, as the only thing it does over
> IOCB_DSYNC is also forcing back of metadata not needed to find
> data (aka timestamps), which I can't see any need for here.

Well, we're eliding any followup SYNC from the NFS client by setting
stable_how to NFS_FILE_SYNC, so I made sure to use SYNC:

> > +	*stable_how = NFS_FILE_SYNC;
> > +
> > +	*cnt = 0;
> > +	for (int i = 0; i < n_iters; i++) {
> > +		if (iter_is_dio_aligned[i])
> > +			kiocb->ki_flags |= IOCB_DIRECT;
> > +		else
> > +			kiocb->ki_flags &= ~IOCB_DIRECT;
> > +
> > +		host_err = vfs_iocb_iter_write(file, kiocb, &iter[i]);
> > +		if (host_err < 0) {
> > +			/*
> > +			 * VFS will return -ENOTBLK if DIO WRITE fails to
> > +			 * invalidate the page cache. Retry using buffered IO.
> > +			 */
> > +			if (unlikely(host_err == -ENOTBLK)) {
> 
> The VFS certainly does not, and if it leaks out of a specific file
> system we need to fix that.

As I said above, fs/iomap/direct-io.c:__iomap_dio_rw() does.

> > +			} else if (unlikely(host_err == -EINVAL)) {
> > +				struct inode *inode = d_inode(fhp->fh_dentry);
> > +
> > +				pr_info_ratelimited("nfsd: Direct I/O alignment failure on %s/%ld\n",
> > +						    inode->i_sb->s_id, inode->i_ino);
> > +				host_err = -ESERVERFAULT;
> 
> -EINVAL can be lot more things than alignment failure.   And more
> importantly alignment failures should not happen with the proper
> checks in place.

Regardless, the most likely outcome from issing what should be aligned
DIO only to get -EINVAL is exactly what is addressed with this
_unlikely_ error handling: misaligned IO.. should happen but bugs
happen (or optimization happens, e.g. in the future to fold alignment
checking into sunrpc's WRITE bio_vec creation, and in turn bugs could
happen).

Not submitting a new version of this patch until/unless there is clear
feedback there is something in this v4 that really cannot stand.

Thanks for your review!

