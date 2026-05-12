Return-Path: <linux-nfs+bounces-21487-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MQGMEDBAmovwQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21487-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 07:57:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C40651A878
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 07:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B12030BBB2A
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 05:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6123F54BD;
	Tue, 12 May 2026 05:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zOhBM88a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E1B3FE669;
	Tue, 12 May 2026 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564266; cv=none; b=P/Fet2lSxwR5c0f8lIyjwHtpyJpu1hf8ZoM3VmcpIa7jtnbk8MwjS4t0wEkfLtVR78WDe4z1GbmwCwhCyNWsFibROvV53/5MbvZAJEggtCmPxrlx/rEMNYLUF93bGyFKYNPzeBxKkibt1COb/Fvw3sTetRMEBsYGhYGyefv6s+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564266; c=relaxed/simple;
	bh=zdIGJe7Kb5ghymw/ENcOFkEKCHRYXJK+Gf3ipQvVw+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kx9KTZSyOsCQco9w5fYzfkERz6cZukmniAAMvtYsK4vjEK0qgFwtohIgvzkfcNnFJJmD02rVP1FZEXSBUZ4Op0hKGOzNSSlUQA1JygCXrdC7isYbbamRZxJWWelcE9v/If1ydzBJ3wegZ9CoD4GuAGQhr5V79dRGWUbPiXsFm9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zOhBM88a; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ev7MltnomSEjjmIrAClD1smxf1HDQkp+MmOA2POEN6A=; b=zOhBM88aoj3+RmnJTzDvDvX5oq
	9MzT6jc6jjaEccKxyQYyttFDbnopfvJYVRTvD8rnrI3Ljs3ORV4RDMFYqZF0hzK1GyoLlju8YU49c
	dnoc07+jiOkMGYudxEb756NG3xXZ2I4+ryFlzH/OCqMIE6PWkPy8ypBzQ2eo/PcP0REfgJB0rK+Ht
	Q1mnJjTvGTg1lgE6PiC2A4TxfqdYU4PRtOUemJ2/oREQHvCceIpP6h2RCBmZUElPNeD0lluN0F4ym
	3kmCUQ2sDP38uOsiipbmNekSLq9daxjQS9H420VZrcOfYp1xO+fG6rF3yDlpNsMTGI63uZXnHkWuD
	7UfSxpEg==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMfoE-0000000FfQG-1Tlu;
	Tue, 12 May 2026 05:37:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong " <djwong@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	David Sterba <dsterba@suse.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH 08/12] swap,iomap: simplify iomap_swapfile_iter
Date: Tue, 12 May 2026 07:35:24 +0200
Message-ID: <20260512053625.2950900-9-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512053625.2950900-1-hch@lst.de>
References: <20260512053625.2950900-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 1C40651A878
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21487-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email,lst.de:mid,infradead.org:dkim]
X-Rspamd-Action: no action

add_swap_extent already coalesces multiple extents, no need to duplicate
that in the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/swapfile.c | 104 +++++++++++++-------------------------------
 1 file changed, 31 insertions(+), 73 deletions(-)

diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index cf354fdfb7c3..a4e0ca462cc4 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -6,57 +6,32 @@
 #include <linux/iomap.h>
 #include <linux/swap.h>
 
-/* Swapfile activation */
-
-struct iomap_swapfile_info {
-	struct iomap iomap;		/* accumulated iomap */
-	struct swap_info_struct *sis;
-	unsigned long nr_pages;		/* number of pages collected */
-	struct file *file;
-};
-
-/*
- * Collect physical extents for this swap file.  Physical extents reported to
- * the swap code must be trimmed to align to a page boundary.  The logical
- * offset within the file is irrelevant since the swapfile code maps logical
- * page numbers of the swap device to the physical page-aligned extents.
- */
-static int iomap_swapfile_add_extent(struct iomap_swapfile_info *isi)
-{
-	struct iomap *iomap = &isi->iomap;
-	uint64_t first_ppage;
-	uint64_t next_ppage;
-
-	/*
-	 * Round the start up and the end down so that the physical
-	 * extent aligns to a page boundary.
-	 */
-	first_ppage = ALIGN(iomap->addr, PAGE_SIZE) >> PAGE_SHIFT;
-	next_ppage = ALIGN_DOWN(iomap->addr + iomap->length, PAGE_SIZE) >>
-			PAGE_SHIFT;
-	return add_swap_extent(isi->sis, next_ppage - first_ppage, first_ppage);
-}
-
-static int iomap_swapfile_fail(struct iomap_swapfile_info *isi, const char *str)
+static int iomap_swapfile_fail(struct file *file, const char *str)
 {
 	char *buf, *p = ERR_PTR(-ENOMEM);
 
 	buf = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (buf)
-		p = file_path(isi->file, buf, PATH_MAX);
+		p = file_path(file, buf, PATH_MAX);
 	pr_err("swapon: file %s %s\n", IS_ERR(p) ? "<unknown>" : p, str);
 	kfree(buf);
 	return -EINVAL;
 }
 
 /*
- * Accumulate iomaps for this swap file.  We have to accumulate iomaps because
- * swap only cares about contiguous page-aligned physical extents and makes no
- * distinction between written and unwritten extents.
+ * Report physical extents for this swap file.  Physical extents reported to the
+ * swap code must be trimmed to align to a page boundary.  The logical offset
+ * within the file is irrelevant since the swapfile code maps logical page
+ * numbers of the swap device to the physical page-aligned extents.
  */
-static int iomap_swapfile_iter(struct iomap_iter *iter,
-		struct iomap *iomap, struct iomap_swapfile_info *isi)
+static int iomap_swapfile_iter(struct iomap_iter *iter, struct file *file,
+		struct swap_info_struct *sis)
 {
+	struct iomap *iomap = &iter->iomap;
+	uint64_t first_ppage;
+	uint64_t next_ppage;
+	int error;
+
 	switch (iomap->type) {
 	case IOMAP_MAPPED:
 	case IOMAP_UNWRITTEN:
@@ -64,35 +39,31 @@ static int iomap_swapfile_iter(struct iomap_iter *iter,
 		break;
 	case IOMAP_INLINE:
 		/* No inline data. */
-		return iomap_swapfile_fail(isi, "is inline");
+		return iomap_swapfile_fail(file, "is inline");
 	default:
-		return iomap_swapfile_fail(isi, "has unallocated extents");
+		return iomap_swapfile_fail(file, "has unallocated extents");
 	}
 
 	/* No uncommitted metadata or shared blocks. */
 	if (iomap->flags & IOMAP_F_DIRTY)
-		return iomap_swapfile_fail(isi, "is not committed");
+		return iomap_swapfile_fail(file, "is not committed");
 	if (iomap->flags & IOMAP_F_SHARED)
-		return iomap_swapfile_fail(isi, "has shared extents");
+		return iomap_swapfile_fail(file, "has shared extents");
 
 	/* Only one bdev per swap file. */
-	if (iomap->bdev != isi->sis->bdev)
-		return iomap_swapfile_fail(isi, "outside the main device");
-
-	if (isi->iomap.length == 0) {
-		/* No accumulated extent, so just store it. */
-		memcpy(&isi->iomap, iomap, sizeof(isi->iomap));
-	} else if (isi->iomap.addr + isi->iomap.length == iomap->addr) {
-		/* Append this to the accumulated extent. */
-		isi->iomap.length += iomap->length;
-	} else {
-		/* Otherwise, add the retained iomap and store this one. */
-		int error = iomap_swapfile_add_extent(isi);
-		if (error)
-			return error;
-		memcpy(&isi->iomap, iomap, sizeof(isi->iomap));
-	}
+	if (iomap->bdev != sis->bdev)
+		return iomap_swapfile_fail(file, "outside the main device");
 
+	/*
+	 * Round the start up and the end down so that the physical extent
+	 * aligns to a page boundary.
+	 */
+	first_ppage = ALIGN(iomap->addr, PAGE_SIZE) >> PAGE_SHIFT;
+	next_ppage = ALIGN_DOWN(iomap->addr + iomap->length, PAGE_SIZE) >>
+			PAGE_SHIFT;
+	error = add_swap_extent(sis, next_ppage - first_ppage, first_ppage);
+	if (error)
+		return error;
 	return iomap_iter_advance_full(iter);
 }
 
@@ -110,10 +81,6 @@ int iomap_swap_activate(struct file *file, struct swap_info_struct *sis,
 		.len	= ALIGN_DOWN(i_size_read(inode), PAGE_SIZE),
 		.flags	= IOMAP_REPORT,
 	};
-	struct iomap_swapfile_info isi = {
-		.sis = sis,
-		.file = file,
-	};
 	int ret;
 
 	/*
@@ -125,16 +92,7 @@ int iomap_swap_activate(struct file *file, struct swap_info_struct *sis,
 		return ret;
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_swapfile_iter(&iter, &iter.iomap, &isi);
-	if (ret < 0)
-		return ret;
-
-	if (isi.iomap.length) {
-		ret = iomap_swapfile_add_extent(&isi);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+		iter.status = iomap_swapfile_iter(&iter, file, sis);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_swap_activate);
-- 
2.53.0


