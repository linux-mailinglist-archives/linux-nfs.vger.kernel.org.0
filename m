Return-Path: <linux-nfs+bounces-16302-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F2FC534BB
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 17:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8921F62117C
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA9C342530;
	Wed, 12 Nov 2025 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RWOJN0Hz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F060342521
	for <linux-nfs@vger.kernel.org>; Wed, 12 Nov 2025 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959762; cv=none; b=ddQEgXD1dH6dSpxc0M1LbyeODo2SSmlynzps6VRU3onVK0pSBSsE6Svuu8i+teU7TL8ATMy8fODN4to2UMDRwgh5w+IH+PQZjd0lMCFBNEG/s66vQ/zHGg9EL2xsju9LSeZfPlRyzyyzomtUJfTeoE8UcANgVuwT1DYAZvyIWa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959762; c=relaxed/simple;
	bh=DdrdBv5JvQpDA3S7nkdgVHQreMnNqHhFoFyolCkmR6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLvedwBjGiFTpg+f6Vji/knD10vBco8Bu2hBAu4XCym5twWZPpvV3g5qHeiMxWxo+s30i9ieoXPphJSRb23P+rajI3kb95CTJuv1u5YpgqwdYocG9pKuvu4EnZ9DIAxv36G/RPU6gC/PicYoz/BT8GpQAzkqWaNRJLg6NPgBOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RWOJN0Hz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=exyadeP6J8pryxwoXtiCVebVSQcP1cPRU0AflTWql4I=; b=RWOJN0HzXYpdv5hZxCF8tq4UxT
	4fhEAagzs+FXudVSTj19gA5Qzehs2n7XbAlkewaECy+b5nURvzc2w6LzpqcdP9MAnM5ReOJYCJMs6
	hWK79BX7JcS70b+2wnnxLQcSuiwrrkC5PYx1MW1K82kRsT/EBgTrbrtlBNXSyexLMIoqzF9gSsgBf
	SP2flwEIoOgd0ihOHDjulXhKZUobiE7XecwmZANufCwNHZqYhl0D+/lU/iefC0+HXdNG17yXWHskv
	wPfUv8ezk4yagXAjkk6bOU7OZZItlY3SCRX2qzukLOXKUaIBxMW34dZ0EFIYNlZ3+CWjmCjoa6T0h
	m0SyEk8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJCMn-000000090Rw-0JbZ;
	Wed, 12 Nov 2025 15:02:37 +0000
Date: Wed, 12 Nov 2025 07:02:37 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aRShjU_Ti7f2Ci7I@infradead.org>
References: <aQ5Q99Kvw0ZE09Th@kernel.org>
 <fb0d6399-ea74-462a-982a-df232e3f4be9@kernel.org>
 <aQ5SSnW9xUWj9xBi@kernel.org>
 <176255273643.634289.15333032218575182744@noble.neil.brown.name>
 <aQ5xkjIzf6uU_zLa@kernel.org>
 <176255894778.634289.2265909350991291087@noble.neil.brown.name>
 <aQ6kkd74pj2aUd8b@kernel.org>
 <2b024928-e078-4414-a062-bbeedfeea5d9@oracle.com>
 <aRL5EPMD9VsG1n3D@infradead.org>
 <aRPPikkia5ZVZxJG@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRPPikkia5ZVZxJG@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 11, 2025 at 07:06:34PM -0500, Mike Snitzer wrote:
> +	/* Mark the I/O buffer as evict-able to reduce memory contention. */
> +	if (!use_cached_buffered_fallback &&
> +	    nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
> +		kiocb->ki_flags |= IOCB_DONTCACHE;

This won't work, because ki_flags get overwritten by the flags in
the segment layer.  I walked through this to understand all the cases,
and ended up with a slightly different version including long comments
explaining them.  This is also untested, but I'd love to have other
cross check the logic in it:

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index ab46301da4ae..4727235ef43f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1292,12 +1292,23 @@ nfsd_write_dio_iters_init(struct nfsd_file *nf, struct bio_vec *bvec,
 	unsigned int nsegs = 0;
 
 	/*
-	 * Check if direct I/O is feasible for this write request.
-	 * If alignments are not available, the write is too small,
-	 * or no alignment can be found, fall back to buffered I/O.
+	 * If the file system doesn't advertise any alignment requirements,
+	 * don't try to issue direct I/O.  Fall back to uncached buffered
+	 * I/O if possible because we'll assume it is not block based and
+	 * doesn't need read-modify-write cycles.
 	 */
-	if (unlikely(!mem_align || !offset_align) ||
-	    unlikely(total < max(offset_align, mem_align)))
+	if (unlikely(!mem_align || !offset_align)) {
+		if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
+			segments[0].flags |= IOCB_DONTCACHE;
+		goto no_dio;
+	}
+
+	/*
+	 * If the I/O is smaller than the larger of the memory and logical
+	 * offset alignment, it is like to require read-modify-write cycles.
+	 * Issue cached buffered I/O.
+	 */
+	if (unlikely(total < max(offset_align, mem_align)))
 		goto no_dio;
 
 	prefix_end = round_up(offset, offset_align);
@@ -1308,7 +1319,17 @@ nfsd_write_dio_iters_init(struct nfsd_file *nf, struct bio_vec *bvec,
 	middle = middle_end - prefix_end;
 	suffix = orig_end - middle_end;
 
-	if (!middle)
+	/*
+	 * If there is no aligned middle section, or aligned part is tiny,
+	 * issue a single buffered I/O write instead of splitting up the
+	 * write.
+	 *
+	 * Note: the middle section size here is random constant.  I suspect
+	 * when benchmarking it we'd actually end up with a significant larger
+	 * number, with the details depending on hardware.
+	 */
+	if (!middle ||
+	    ((prefix || suffix) && middle < PAGE_SIZE * 2))
 		goto no_dio;
 
 	if (prefix)
@@ -1324,16 +1345,24 @@ nfsd_write_dio_iters_init(struct nfsd_file *nf, struct bio_vec *bvec,
 	 * bvecs generated from RPC receive buffers are contiguous: After
 	 * the first bvec, all subsequent bvecs start at bv_offset zero
 	 * (page-aligned). Therefore, only the first bvec is checked.
+	 *
+	 * If the memory is not aligned at all, but we have a large enough
+	 * logical offset-aligned middle section, try to use uncached buffered
+	 * I/O for that to avoid cache pollution.  If not fall back to a single
+	 * cached buffered I/O for the entire write.
 	 */
-	if (iov_iter_bvec_offset(&segments[nsegs].iter) & (mem_align - 1))
-		goto no_dio;
-	segments[nsegs].flags |= IOCB_DIRECT;
+	if (iov_iter_bvec_offset(&segments[nsegs].iter) & (mem_align - 1)) {
+		if (!(nf->nf_file->f_op->fop_flags & FOP_DONTCACHE))
+			goto no_dio;
+		segments[nsegs].flags |= IOCB_DONTCACHE;
+	} else {
+		segments[nsegs].flags |= IOCB_DIRECT;
+	}
 	nsegs++;
 
 	if (suffix)
 		nfsd_write_dio_seg_init(&segments[nsegs++], bvec, nvecs, total,
 					prefix + middle, suffix, iocb);
-
 	return nsegs;
 
 no_dio:
@@ -1362,16 +1391,9 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		if (kiocb->ki_flags & IOCB_DIRECT)
 			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
 						segments[i].iter.count);
-		else {
+		else
 			trace_nfsd_write_vector(rqstp, fhp, kiocb->ki_pos,
 						segments[i].iter.count);
-			/*
-			 * Mark the I/O buffer as evict-able to reduce
-			 * memory contention.
-			 */
-			if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
-				kiocb->ki_flags |= IOCB_DONTCACHE;
-		}
 
 		host_err = vfs_iocb_iter_write(file, kiocb, &segments[i].iter);
 		if (host_err < 0)

