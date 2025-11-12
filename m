Return-Path: <linux-nfs+bounces-16281-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CF0C501C2
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 01:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260DA3B1CB0
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 00:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81F8C2E0;
	Wed, 12 Nov 2025 00:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1glwZqM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8211235CBC4
	for <linux-nfs@vger.kernel.org>; Wed, 12 Nov 2025 00:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762905995; cv=none; b=Qs0ttH8Nzx4jRuBm+v58AAW51U/PGKkrbLcPb3iBIpn6NyBrIaEC8WDC4QjUjmJFpIzAvpJBMTPXFMsMWhRTM8yY47i/IYxDVEj3/RB+QS6JNf8i1ua78JjdI8TJj++3bWW3IDtUqK7DAThs3H0ySD3QwQt1KleMhhrvXDHKtlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762905995; c=relaxed/simple;
	bh=erG4q3wk9BZPZlp5YgNqoz2NawUBAB/+PyuOiZ4Mlo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX4+T55e/z8Ew92Us+ukruIkTowVrtytSnawGEbHdYPBNyK6V9hQ1RjWc1fNqhafMK20bc2vsoYL8Uk3+fiUfd++hd8oJjq2Qmtk3FKfkElq6E+hrzvtHmulwHpgpTO6Gaolv291qNdjZva3EO38Xo48nhVADoooDD/WB3QwJt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1glwZqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BA7C4CEF5;
	Wed, 12 Nov 2025 00:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762905995;
	bh=erG4q3wk9BZPZlp5YgNqoz2NawUBAB/+PyuOiZ4Mlo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1glwZqMnumqA3JKZEsFx7o+jfTiJMelOdl55IVSUrPvo2Kvx0AXEMGtf7fTszdTl
	 1yKsMPDkcxw/3eMXC3tt3O5J5OM6gaF8bywHLHfdrdu3ANcyBnC4ZDsvrVjhCnVn4p
	 G9ldfPO0XJEJwDc8h77W7uaIPlVoupifalyAMQZGSo2FiJnqf/9XPwOOamkHo2yYKQ
	 y6wWYeYqIia/Ji9PYFy0cs/Wi4NEpfWQcBuRJvwm64Y4CGsBKTAsxZD3jB6M3jJKXL
	 ukfOi5ilaK5R/gptk3Oc3/xtW+oV00S9A9P37UWxRcL5t6ZRxaIHrwziOTjaUJRnwS
	 wqnaY9L699rTw==
Date: Tue, 11 Nov 2025 19:06:34 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aRPPikkia5ZVZxJG@kernel.org>
References: <82be5f47-77df-423d-a4f3-17f83ddb6636@kernel.org>
 <aQ5Q99Kvw0ZE09Th@kernel.org>
 <fb0d6399-ea74-462a-982a-df232e3f4be9@kernel.org>
 <aQ5SSnW9xUWj9xBi@kernel.org>
 <176255273643.634289.15333032218575182744@noble.neil.brown.name>
 <aQ5xkjIzf6uU_zLa@kernel.org>
 <176255894778.634289.2265909350991291087@noble.neil.brown.name>
 <aQ6kkd74pj2aUd8b@kernel.org>
 <2b024928-e078-4414-a062-bbeedfeea5d9@oracle.com>
 <aRL5EPMD9VsG1n3D@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRL5EPMD9VsG1n3D@infradead.org>

On Tue, Nov 11, 2025 at 12:51:28AM -0800, Christoph Hellwig wrote:
> On Mon, Nov 10, 2025 at 11:41:09AM -0500, Chuck Lever wrote:
> > On 11/7/25 9:01 PM, Mike Snitzer wrote:
> > > Q: Case 2 uses DONTCACHE, so case 1 should too right?
> > > 
> > > A: NO. There is legit benefit to having case 1 use cached buffered IO
> > > when issuing its 2 subpage IOs; and that benefit doesn't cause harm> because order-0 page management is not causing the MM problems that
> > > NFSD_IO_DIRECT sets out to avoid (whereas higher order cached buffered
> > > IO is exactly what both DONTCACHE and NFSD_IO_DIRECT aim to avoid.
> > > Otherwise MM spins and spins trying to find adequate free pages,
> > > cannot so does dirty writeback and reclaim which causes kswapd and
> > > kcompactd to burn cpu, etc).
> > 
> > Paraphrasing: Each unaligned end (case 1) is always smaller than a page,
> > thus it will stick with order-0 allocations (if that byte range is not
> > already in the page cache), allocations that are, practically speaking,
> > reliable.
> > 
> > However it might be a stretch to claim that an order-0 allocation
> > /never/ drives memory reclaim.
> 
> That is of course not true.  order-0 pages of course do drive memory
> reclaim.  In fact if you're on a file system without huge folios and
> an applications that doesn't use THP, the majority of reclaim is
> driven by order 0 allocations.

Correct, but order-0 pages aren't the burden on MM that reclaim of
higher order pages causes.

To be clear I didn't say what Chuck paraphrased with "/never/", etc.
But anyway I think we're all in agreement.

> > What we still don't know is exactly what the extra cost of setting
> > DONTCACHE is, even on small writes. Maybe DONTCACHE should be cleared
> > for /all/ segments that are smaller than a page?
> 
> I suspect the best initial tweak is for every segment or entire write
> that is not page aligned in the file, as that is an indicator that
> multiple RMW cycles are possible.  At least if we're streaming, but
> we don't have that information.  That means all of these cases:
> 
>  1) writes smaller than PAGE_SIZE
>  2) writes smaller than PAGE_SIZE * 2 but not aligned to PAGE_SIZE
>  3) unaligned end segments < PAGE_SIZE
> 
> If we want to fine tune, we'd probably expand case 2 a bit as a single
> page cache operation on an order 2 pages is going to be faster than
> three I/Os most of the time, but compared to the high level discussion
> here that's minor details.

I agree, the following should accomplish this.

Would prefer we get this heuristic agreed on so it can land along with
the NFSD_IO_DIRECT WRITE support for the 6.19 merge window.

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 02ff6bd48a18..ce162ae2f985 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1277,6 +1277,12 @@ nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
 	segment->flags = iocb->ki_flags;
 }
 
+/*
+ * Unaligned IO that is smaller than order-2 is best
+ * handled using cached buffered IO rather than DONTCACHE.
+ */
+#define NFSD_DONTCACHE_MIN_BYTES ((PAGE_SIZE << 2) + 1)
+
 static unsigned int
 nfsd_write_dio_iters_init(struct nfsd_file *nf, struct bio_vec *bvec,
 			  unsigned int nvecs, struct kiocb *iocb,
@@ -1284,6 +1290,7 @@ nfsd_write_dio_iters_init(struct nfsd_file *nf, struct bio_vec *bvec,
 			  struct nfsd_write_dio_seg segments[3])
 {
 	u32 offset_align = nf->nf_dio_offset_align;
+	bool use_cached_buffered_fallback = false;
 	loff_t prefix_end, orig_end, middle_end;
 	u32 mem_align = nf->nf_dio_mem_align;
 	size_t prefix, middle, suffix;
@@ -1295,6 +1302,8 @@ nfsd_write_dio_iters_init(struct nfsd_file *nf, struct bio_vec *bvec,
 	 * If alignments are not available, the write is too small,
 	 * or no alignment can be found, fall back to buffered I/O.
 	 */
+	if (total < NFSD_DONTCACHE_MIN_BYTES)
+		use_cached_buffered_fallback = true;
 	if (unlikely(!mem_align || !offset_align) ||
 	    unlikely(total < max(offset_align, mem_align)))
 		goto no_dio;
@@ -1333,12 +1342,29 @@ nfsd_write_dio_iters_init(struct nfsd_file *nf, struct bio_vec *bvec,
 		nfsd_write_dio_seg_init(&segments[nsegs++], bvec, nvecs, total,
 					prefix + middle, suffix, iocb);
 
+	/*
+	 * Unaligned end segments will always use cached buffered IO
+	 * because they are less than PAGE_SIZE.
+	 */
+	if ((prefix || suffix) && use_cached_buffered_fallback) {
+		/*
+		 * This unaligned IO is small enough that it
+		 * warrants fall back to a single cached buffered IO.
+		 */
+		goto no_dio;
+	}
+
 	return nsegs;
 
 no_dio:
 	/* No DIO alignment possible - pack into single non-DIO segment. */
 	nfsd_write_dio_seg_init(&segments[0], bvec, nvecs, total, 0,
 				total, iocb);
+	/* Mark the I/O buffer as evict-able to reduce memory contention. */
+	if (!use_cached_buffered_fallback &&
+	    nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
+		kiocb->ki_flags |= IOCB_DONTCACHE;
+
 	return 1;
 }
 
@@ -1361,16 +1387,9 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
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

