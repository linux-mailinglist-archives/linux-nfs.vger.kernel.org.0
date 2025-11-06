Return-Path: <linux-nfs+bounces-16152-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1268AC3D220
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 20:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3F934E061D
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 19:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003A12BE65F;
	Thu,  6 Nov 2025 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iotc4Bv5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF0824468C
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762455743; cv=none; b=MDjy4E2fOwNdKYJHl2+EvfiSqWbzWRnYYqFWARwZR/KJjQXi0gvEXAzVGLdcsIApgZUNh2qRypttjcyKotluxwWzl1Y3jZlL9BUGaex182TOtYx5ic52iWvGsA1mXsQimiwAEWwxeWHZROT4Ueb2+HrghgWEKAZS8izNgEkCBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762455743; c=relaxed/simple;
	bh=rYHY41ykr3V/FYI8PRVPgs65smRAnNcCYSoBTgsFRwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slgDsm5v6/exQYSYZ0UAo/Y+D6E7hQUufED2vl6swwMLxRVub1fSvd0JEzZ6BjQkBXJmNCJ/hmmMLYqj89oaRxa1VVMEfFNpYulB6emYk+uRkN6xEWo3YpU7LZsBXhdhrVaUC+iJl4izXfdVIUR4OKnsFWvvweV9Xol0TCi6bJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iotc4Bv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22614C116B1;
	Thu,  6 Nov 2025 19:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762455743;
	bh=rYHY41ykr3V/FYI8PRVPgs65smRAnNcCYSoBTgsFRwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iotc4Bv59n20eg2rx00J4wLoE5UVK97Sk14w3a+ucaCzHBVugs9VJdU/s4TefELqd
	 RZ2fr6CcTYTikq0VB+m3DDMq7KCJHn1/1w/NVJknBNost8tbT3bCW7WzzeXXVxlT61
	 62mFBRNc4JZNQi6PxrYxFfnxtgIcehQ0HMp+ry6FyoYE6L2Smk2OLDewTtg1Gv7pC1
	 6PgugfQraWdIwVgxguoeEaDfx1IzW8koWpZ9Da04ctpYSkbe/0gWylt6ethnVr66aG
	 vUyokTVT4fKtCuwINVx7vwWvoPK5D5RgNaKImmWHhLxNK+09zK6URKjyimWoLpJ/do
	 rNJSY4zjFTp8g==
Date: Thu, 6 Nov 2025 14:02:22 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v10 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aQzwvqlD0xiYjMCW@kernel.org>
References: <20251105192806.77093-1-cel@kernel.org>
 <20251105192806.77093-5-cel@kernel.org>
 <176242391124.634289.8771352649615589358@noble.neil.brown.name>
 <aQyfgfWu8kPfe1uA@infradead.org>
 <aQyn-_GSL_z3a9to@infradead.org>
 <aQzRdTcyc2nhTWqj@kernel.org>
 <e0723227-6984-4c04-be7c-c3be852a8607@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0723227-6984-4c04-be7c-c3be852a8607@kernel.org>

On Thu, Nov 06, 2025 at 01:10:17PM -0500, Chuck Lever wrote:
> On 11/6/25 11:48 AM, Mike Snitzer wrote:
> >>  no_dio:
> >>  	/*
> >>  	 * No DIO alignment possible - pack into single non-DIO segment.
> >> -	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT.
> >>  	 */
> >> -	if (args->nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
> >> -		args->flags_buffered |= IOCB_DONTCACHE;
> >> -	nfsd_write_dio_seg_init(&args->segment[0], bvec, nvecs, total,
> >> -				0, total);
> >> -	args->nsegs = 1;
> >> +	nfsd_write_dio_seg_init(&segments[0], bvec, nvecs, total,
> >> +				0, total, iocb);
> >> +	return 1;
> >>  }
> > Selectively pushing the flag twiddling out to nfsd_direct_write()
> > ignores that we don't want to use DONTCACHE for the unaligned
> > prefix/suffix. Chuck and I discussed this a fair bit 1-2 days ago.
> 
> Agreed. I fixed this up after applying Christoph's patch.

OK, here is the incremental I just came up with, but sounds like
you're all set:

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 6fce4f08a4d4..db86b31e0c10 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1272,6 +1272,19 @@ static unsigned long iov_iter_bvec_offset(const struct iov_iter *iter)
 	return (unsigned long)(iter->bvec->bv_offset + iter->iov_offset);
 }
 
+/*
+ * Check if the bvec iterator is aligned for direct I/O.
+ *
+ * bvecs generated from RPC receive buffers are contiguous: After the first
+ * bvec, all subsequent bvecs start at bv_offset zero (page-aligned).
+ * Therefore, only the first bvec is checked.
+ */
+static bool
+nfsd_iov_iter_aligned_bvec(const struct iov_iter *iter, unsigned int addr_mask)
+{
+	return (iov_iter_bvec_offset(iter) & addr_mask) == 0;
+}
+
 static void
 nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
 			struct bio_vec *bvec, unsigned int nvecs,
@@ -1324,16 +1337,8 @@ nfsd_write_dio_iters_init(struct nfsd_file *nf, struct bio_vec *bvec,
 
 	nfsd_write_dio_seg_init(&segments[nsegs], bvec, nvecs,
 				total, prefix, middle, iocb);
-
-	/*
-	 * Check if the bvec iterator is aligned for direct I/O.
-	 *
-	 * bvecs generated from RPC receive buffers are contiguous: After the
-	 * first bvec, all subsequent bvecs start at bv_offset zero
-	 * (page-aligned).
-	 * Therefore, only the first bvec is checked.
-	 */
-	if (iov_iter_bvec_offset(&segments[nsegs].iter) & (mem_align - 1))
+	if (!nfsd_iov_iter_aligned_bvec(&segments[nsegs].iter,
+					(mem_align - 1)))
 		goto no_dio;
 	segments[nsegs].flags |= IOCB_DIRECT;
 	nsegs++;
@@ -1348,9 +1353,12 @@ nfsd_write_dio_iters_init(struct nfsd_file *nf, struct bio_vec *bvec,
 no_dio:
 	/*
 	 * No DIO alignment possible - pack into single non-DIO segment.
+	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT.
 	 */
 	nfsd_write_dio_seg_init(&segments[0], bvec, nvecs, total,
 				0, total, iocb);
+	if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
+		segments[0].flags |= IOCB_DONTCACHE;
 	return 1;
 }
 
@@ -1370,16 +1378,9 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	*cnt = 0;
 	for (i = 0; i < nsegs; i++) {
 		kiocb->ki_flags = segments[i].flags;
-		if (kiocb->ki_flags & IOCB_DIRECT) {
+		if (kiocb->ki_flags & IOCB_DIRECT)
 			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
 						segments[i].iter.count);
-		} else if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE) {
-			/*
-			 * IOCB_DONTCACHE preserves the intent of
-			 * NFSD_IO_DIRECT.
-			 */
-			kiocb->ki_flags |= IOCB_DONTCACHE;
-		}
 
 		host_err = vfs_iocb_iter_write(file, kiocb, &segments[i].iter);
 		if (host_err < 0)

