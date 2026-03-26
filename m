Return-Path: <linux-nfs+bounces-20428-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJIqOMlRxWmD9QQAu9opvQ
	(envelope-from <linux-nfs+bounces-20428-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 16:33:29 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8B93379FD
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 16:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D567330B8345
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 15:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0068A37F8BA;
	Thu, 26 Mar 2026 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASd2As1e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9046347516;
	Thu, 26 Mar 2026 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538641; cv=none; b=ZDah0AseTuJlo/AvWlelgqNK8DMG3MLIf7vOOLzo7RZ7FqQo3b3aR2drGZQ3mroaNwAQpEWF7PkBg8nENUpX85xCODKx5Wb3zpM7DxpfTdno0c2H1rE+0R8rxSLylmm7YkksEtzlAG8fixNqO89IjUTgwKH3mKi+PnNQeSA4aio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538641; c=relaxed/simple;
	bh=uzBxhpARfo+cByqFAr4qtGU7seLYatmUFHSkZ/t2D4c=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=iIoaK2Be01NcY9lS4J7ETcWZRheYmPhmAzPLtxaMni6JI75oqs3YdmCzQnoAP+jl6lmonT4+JKqlICgPjs0gURooheLBZJPND7wPPNd2/7p3/j6DJt33f8+tOTb6Vbnw5gKyYShACHyGSJldhhhqjBfo1H/z6MvNjmVXZ7DeaLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASd2As1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2241C116C6;
	Thu, 26 Mar 2026 15:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774538641;
	bh=uzBxhpARfo+cByqFAr4qtGU7seLYatmUFHSkZ/t2D4c=;
	h=Subject:From:To:Cc:Date:From;
	b=ASd2As1egjr08oxav7A34W0TRAaalHYlnazzzydkAJaQD9NYtChjid1b+l+DqMPzC
	 agmkdXqeUdOxtfTv2TG+Vw588PBqObVc1U78jDt3F94ccBLnSXY381wy8euw3Ue1oe
	 K0NJp4wo8qC+w81AI2mM/ItqHUVTmfKub4sNbA0K7wq3Lv+hf9dhKn6YoydNC+zt4H
	 3+6AZYnNvahwOKkGU0XbRMFh85zI1cExUqyAi30LGGd4yH81h09OmQiXRyawlIijX7
	 Z9YH51/JKAYawd3xBmyWzteL9npsbGiMGGhGzMNjN70OTLI4TgcPMCeRfDqdQOcyFL
	 BUd/0dfjkgn/w==
Message-ID: <4ebbd194ccfb3bcea6225d926b4c9f339e21c813.camel@kernel.org>
Subject: A comparison of the new nfsd iomodes (and an experimental one)
From: Jeff Layton <jlayton@kernel.org>
To: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Mike Snitzer <snitzer@kernel.org>,
  Jens Axboe <axboe@kernel.dk>
Date: Thu, 26 Mar 2026 11:23:58 -0400
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20428-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,markdownpastebin.com:url]
X-Rspamd-Queue-Id: 7D8B93379FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I've been doing some benchmarking of the new nfsd iomodes, using
different fio-based workloads.

The results have been interesting, but one thing that stands out is
that RWF_DONTCACHE is absolutely terrible for streaming write
workloads. That prompted me to experiment with a new iomode that added
some optimizations (DONTCACHE_LAZY).

The results along with Claude's analysis are here:

    https://markdownpastebin.com/?id=3D387375d00b5443b3a2e37d58a062331f

He gets a bit out over his skis on the upstream plan, but tl;dr is that
DONTCACHE_LAZY (which is DONTCACHE with some optimizations) outperforms
the other write iomodes.

The core DONTCACHE_LAZY patch is below. I doubt we'll want a new iomode
long-term. What we'll probably want to do is modify DONTCACHE to work
like DONTCACHE_LAZY:

-------------------8<-------------------

[PATCH] mm: add IOCB_DONTCACHE_LAZY and RWF_DONTCACHE_LAZY

IOCB_DONTCACHE flushes all dirty pages on every write via
filemap_flush_range() with nr_to_write=3DLONG_MAX.  Under concurrent
writers, this creates severe serialization: every writer contends on
the writeback submission path, leading to catastrophic throughput
collapse (~1 GB/s vs ~10 GB/s for buffered) and multi-second tail
latency.

Add IOCB_DONTCACHE_LAZY as a gentler alternative with two mechanisms:

 1. Skip-if-busy: check mapping_tagged(PAGECACHE_TAG_WRITEBACK) before
    flushing.  If writeback is already in progress on the mapping, the
    flush is skipped entirely, eliminating writeback submission
    contention between concurrent writers.

 2. Proportional cap: when flushing does occur, cap nr_to_write to the
    number of pages just written.  This prevents any single write from
    triggering a full-file flush that would starve concurrent readers.

Together these mechanisms rate-limit writeback to match the incoming
write rate while avoiding I/O bursts that cause tail latency spikes.

Like IOCB_DONTCACHE, pages touched under IOCB_DONTCACHE_LAZY are
marked for eviction (dropbehind) to keep page cache usage bounded.

Also add RWF_DONTCACHE_LAZY (0x200) as a user-visible pwritev2/io_uring
flag that maps to IOCB_DONTCACHE_LAZY.  The flag follows the same
validation as RWF_DONTCACHE: the filesystem must support FOP_DONTCACHE,
DAX is not supported, and RWF_DONTCACHE and RWF_DONTCACHE_LAZY are
mutually exclusive.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/iomap/buffered-io.c  |  2 +-
 include/linux/fs.h      | 18 ++++++++++++++++--
 include/linux/pagemap.h |  2 +-
 include/uapi/linux/fs.h |  6 +++++-
 mm/filemap.c            | 40 +++++++++++++++++++++++++++++++++++++---
 5 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e3bedcbb5f1ea..069d4378bf457 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1185,7 +1185,7 @@ iomap_file_buffered_write(struct kiocb *iocb, struct =
iov_iter *i,
=20
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iter.flags |=3D IOMAP_NOWAIT;
-	if (iocb->ki_flags & IOCB_DONTCACHE)
+	if (iocb->ki_flags & (IOCB_DONTCACHE | IOCB_DONTCACHE_LAZY))
 		iter.flags |=3D IOMAP_DONTCACHE;
=20
 	while ((ret =3D iomap_iter(&iter, ops)) > 0)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 94695ce5e25b5..04ff531473e82 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -359,6 +359,7 @@ struct readahead_control;
 /* kiocb is a read or write operation submitted by fs/aio.c. */
 #define IOCB_AIO_RW		(1 << 22)
 #define IOCB_HAS_METADATA	(1 << 23)
+#define IOCB_DONTCACHE_LAZY	(__force int) RWF_DONTCACHE_LAZY
=20
 /* for use in trace events */
 #define TRACE_IOCB_STRINGS \
@@ -376,7 +377,8 @@ struct readahead_control;
 	{ IOCB_NOIO,		"NOIO" }, \
 	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }, \
 	{ IOCB_AIO_RW,		"AIO_RW" }, \
-	{ IOCB_HAS_METADATA,	"AIO_HAS_METADATA" }
+	{ IOCB_HAS_METADATA,	"AIO_HAS_METADATA" }, \
+	{ IOCB_DONTCACHE_LAZY,	"DONTCACHE_LAZY" }
=20
 struct kiocb {
 	struct file		*ki_filp;
@@ -2589,6 +2591,8 @@ extern int __must_check file_write_and_wait_range(str=
uct file *file,
 						loff_t start, loff_t end);
 int filemap_flush_range(struct address_space *mapping, loff_t start,
 		loff_t end);
+int filemap_dontcache_writeback_range(struct address_space *mapping,
+		loff_t start, loff_t end, ssize_t nr_written);
=20
 static inline int file_write_and_wait(struct file *file)
 {
@@ -2626,6 +2630,12 @@ static inline ssize_t generic_write_sync(struct kioc=
b *iocb, ssize_t count)
=20
 		filemap_flush_range(mapping, iocb->ki_pos - count,
 				iocb->ki_pos - 1);
+	} else if (iocb->ki_flags & IOCB_DONTCACHE_LAZY) {
+		struct address_space *mapping =3D iocb->ki_filp->f_mapping;
+
+		filemap_dontcache_writeback_range(mapping,
+				iocb->ki_pos - count,
+				iocb->ki_pos - 1, count);
 	}
=20
 	return count;
@@ -3393,13 +3403,17 @@ static inline int kiocb_set_rw_flags(struct kiocb *=
ki, rwf_t flags,
 		if (!(ki->ki_filp->f_mode & FMODE_CAN_ATOMIC_WRITE))
 			return -EOPNOTSUPP;
 	}
-	if (flags & RWF_DONTCACHE) {
+	if (flags & (RWF_DONTCACHE | RWF_DONTCACHE_LAZY)) {
 		/* file system must support it */
 		if (!(ki->ki_filp->f_op->fop_flags & FOP_DONTCACHE))
 			return -EOPNOTSUPP;
 		/* DAX mappings not supported */
 		if (IS_DAX(ki->ki_filp->f_mapping->host))
 			return -EOPNOTSUPP;
+		/* can't use both at once */
+		if ((flags & (RWF_DONTCACHE | RWF_DONTCACHE_LAZY)) =3D=3D
+		    (RWF_DONTCACHE | RWF_DONTCACHE_LAZY))
+			return -EINVAL;
 	}
 	kiocb_flags |=3D (__force int) (flags & RWF_SUPPORTED);
 	if (flags & RWF_SYNC)
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 9f5c4e8b4a7d3..3539a7b4ed53c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -798,7 +798,7 @@ static inline struct folio *write_begin_get_folio(const=
 struct kiocb *iocb,
=20
         fgp_flags |=3D fgf_set_order(len);
=20
-        if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
+        if (iocb && iocb->ki_flags & (IOCB_DONTCACHE | IOCB_DONTCACHE_LAZY=
))
                 fgp_flags |=3D FGP_DONTCACHE;
=20
         return __filemap_get_folio(mapping, index, fgp_flags,
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 66ca526cf786c..74f7c75901e0c 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -434,10 +434,14 @@ typedef int __bitwise __kernel_rwf_t;
 /* prevent pipe and socket writes from raising SIGPIPE */
 #define RWF_NOSIGNAL	((__force __kernel_rwf_t)0x00000100)
=20
+/* buffered IO that drops the cache after reading or writing data,
+ * with rate-limited writeback (skip if writeback already in progress) */
+#define RWF_DONTCACHE_LAZY	((__force __kernel_rwf_t)0x00000200)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
 			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
-			 RWF_DONTCACHE | RWF_NOSIGNAL)
+			 RWF_DONTCACHE | RWF_NOSIGNAL | RWF_DONTCACHE_LAZY)
=20
 #define PROCFS_IOCTL_MAGIC 'f'
=20
diff --git a/mm/filemap.c b/mm/filemap.c
index 9697e12dfbdcc..448bee3f3f1ce 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -440,6 +440,40 @@ int filemap_flush_range(struct address_space *mapping,=
 loff_t start,
 }
 EXPORT_SYMBOL_GPL(filemap_flush_range);
=20
+/**
+ * filemap_dontcache_writeback_range - rate-limited writeback for dontcach=
e I/O
+ * @mapping:	target address_space
+ * @start:	byte offset to start writeback
+ * @end:	byte offset to end writeback (inclusive)
+ * @nr_written:	number of bytes just written by the caller
+ *
+ * Kick writeback for dontcache I/O, but avoid piling on if writeback is
+ * already in progress.  When writeback is kicked, limit the number of pag=
es
+ * submitted to be proportional to the amount just written, rather than
+ * flushing the entire dirty range.
+ *
+ * This reduces tail latency compared to filemap_flush_range() which submi=
ts
+ * writeback for all dirty pages on every call, creating queue contention
+ * under concurrent writers.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+int filemap_dontcache_writeback_range(struct address_space *mapping,
+				      loff_t start, loff_t end,
+				      ssize_t nr_written)
+{
+	long nr;
+
+	/* If writeback is already active, don't pile on */
+	if (mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
+		return 0;
+
+	nr =3D (nr_written + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	return filemap_writeback(mapping, start, end, WB_SYNC_NONE, &nr,
+			WB_REASON_BACKGROUND);
+}
+EXPORT_SYMBOL_GPL(filemap_dontcache_writeback_range);
+
 /**
  * filemap_flush - mostly a non-blocking flush
  * @mapping:	target address_space
@@ -2633,7 +2667,7 @@ static int filemap_create_folio(struct kiocb *iocb, s=
truct folio_batch *fbatch)
 	folio =3D filemap_alloc_folio(mapping_gfp_mask(mapping), min_order, NULL)=
;
 	if (!folio)
 		return -ENOMEM;
-	if (iocb->ki_flags & IOCB_DONTCACHE)
+	if (iocb->ki_flags & (IOCB_DONTCACHE | IOCB_DONTCACHE_LAZY))
 		__folio_set_dropbehind(folio);
=20
 	/*
@@ -2680,7 +2714,7 @@ static int filemap_readahead(struct kiocb *iocb, stru=
ct file *file,
=20
 	if (iocb->ki_flags & IOCB_NOIO)
 		return -EAGAIN;
-	if (iocb->ki_flags & IOCB_DONTCACHE)
+	if (iocb->ki_flags & (IOCB_DONTCACHE | IOCB_DONTCACHE_LAZY))
 		ractl.dropbehind =3D 1;
 	page_cache_async_ra(&ractl, folio, last_index - folio->index);
 	return 0;
@@ -2712,7 +2746,7 @@ static int filemap_get_pages(struct kiocb *iocb, size=
_t count,
 			return -EAGAIN;
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			flags =3D memalloc_noio_save();
-		if (iocb->ki_flags & IOCB_DONTCACHE)
+		if (iocb->ki_flags & (IOCB_DONTCACHE | IOCB_DONTCACHE_LAZY))
 			ractl.dropbehind =3D 1;
 		page_cache_sync_ra(&ractl, last_index - index);
 		if (iocb->ki_flags & IOCB_NOWAIT)

