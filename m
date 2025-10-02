Return-Path: <linux-nfs+bounces-14918-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1F6BB5204
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Oct 2025 22:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DDAA4E6B82
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Oct 2025 20:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046A6296BC1;
	Thu,  2 Oct 2025 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niKD+msE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4667263B
	for <linux-nfs@vger.kernel.org>; Thu,  2 Oct 2025 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437095; cv=none; b=k1ypWlusvWkbrgK4QxXwEGtf1+oPFjZo3XWXj+ttxduvvGCU9z35MyvspRzTX9cWQ0LCh4dYClX/fnihlHCeD8VqIFQFa5MyMgzzk7mfgd7bqsqYrCMQqC5fFgBXH/qTmU4W8m6HJQ0dDnwL0AnNuhARcJZnFiI/8BNPgxqzrOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437095; c=relaxed/simple;
	bh=oFqfX8Z2mJdTJQsFSTDiVyLiBlBkNY9lzw2zoVWVqgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQh00IsRpJ0bubWiVLabZDInSW+E8ic2P4V4WSlRGKUZVkmDIT2O+wuxVLUosAi9lrVD/7u5yNOe/EdiD6qf8XO5wk+B/kRTElXOnFL5w0GLOS9H6X01TdCL6w9+34NL9PWRjo5MN4sI/1MoTI4cWK3fFB71Yse4v4H0uVc7Tp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niKD+msE; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57edfeaa05aso1780338e87.0
        for <linux-nfs@vger.kernel.org>; Thu, 02 Oct 2025 13:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759437092; x=1760041892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnaoVcrd4pwmhUrJPtwORPmWfBFGgKSYQKAf2waxl6w=;
        b=niKD+msEFgjCBdznqEM0W5KpORqIMjRPZWdSvQyWtjyix5xg2oQyb+ZQO5GTon9e76
         5MAQna0YedZiKfPxPmkMco1JLb/6xWRrMultkECQKJiuTpp2q0xnvzyhgM0ynAWyBvcF
         4NodqLTBn1157ZesKABN/FTAVV9Y+f8MZEcmrtRfiZS4tT4HqLJNgqUPi7dU7KMQJxxh
         pmlfNn5MdroGnzmJtGZMWnAcJxAdekCtVBeSBfS0AWhzqz+4hO+2BKLoaUt1HEzDWcBu
         MhdLU1+IQKCAESSu/evhGzFlhvsUyM9Oqh4uivsS50h6bywpoqEskj7DppR006VI9rl6
         aKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759437092; x=1760041892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnaoVcrd4pwmhUrJPtwORPmWfBFGgKSYQKAf2waxl6w=;
        b=GbTu3/ZEC1YQNtrvqISJfhm5n+IJFpi7DMWkcniaI51U/EZSao9b6zliedo6AqTqoy
         daQ9tpUdK8H6m8NJYN3JCSMfYZSIDnmP5sOkAtATymNhm7UGqzpd52Magm7XTrkfzDT4
         y8HTecc0VyqQ+V7LsuGWrq8+eyfVdgRzp8OMOfLWXAcaAGLhjJHO4+ELHs/eFfNCyn0i
         1uOQgE8riztNdCZkPuCczlPvGgZrczoNlUAbFIhBWMp9yhnROGivHnODFBmp7xjVkMNM
         9khP9wU6M5PClwrEvI0lXCKY/BWpVp95CMop3iMOqBHh1DvdCvr1dpMLETU8hPeAN9iD
         vZhA==
X-Gm-Message-State: AOJu0YzkZ1PpNLhAQq7c1b5Q4QSE74XLHmk9fymZsYJKSnIwFzO+GXjC
	A3EIJxfZ1JXWZjSUhVXaF9NbvuL1Xrx+Vj9ykLxrGD8vYmzDqkVVO9nN
X-Gm-Gg: ASbGnctif88T0tNIwOO5zMnK1cFwwqBJ/DCULfiFgpcvabhigWWj4FmyfZ7gSphGAtH
	J/Ah4h2GawnfjHksskoERAWOOD0s8IPmjb96RDZXkv89pP4RadTECX3EppfRK6AMTCDcC2loCKA
	ZzUPFBD0W2YX52n98yPQmv54ptDNH0E9CRcofjp1bBvJ7A02mBXdasC4jreEHunVe8xAgzedZps
	A3x9nXRUhyiQ7qzwBgqtaKMCbcv/ADCoqTJAqwQWsqPa8F5lAOw55H+j3rz4rJy6+eNC0ecKK9B
	UlMN6sXeaTP75q75PZgL6D9O78oyO24IYKPzn/cWE4pZNitoXOJhyFvJiGi2lS+UUkGnBTy3Pne
	MyL/jOPGzn3imykeFSAf3rOsTvgGo7Px9ZDdgqZJ8UrSLSaoSZ/9s7Q1bnSP5qlwqYC9UL+lhn8
	+u
X-Google-Smtp-Source: AGHT+IEcgVk9tVcLruf5PYqQZRtZFzdaqWGCohValC9Aw6pmRxH0sM9m8K8y2YfTPEivEuP7ViNpPA==
X-Received: by 2002:a05:6512:3d0f:b0:57c:90fc:7d3 with SMTP id 2adb3069b0e04-58cbc7764f4mr132824e87.53.1759437091706;
        Thu, 02 Oct 2025 13:31:31 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.163.120])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113f3ddsm1127316e87.52.2025.10.02.13.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:31:31 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH v2 2/4] NFSD/blocklayout: Extract extent mapping from proc_layoutget
Date: Thu,  2 Oct 2025 23:31:12 +0300
Message-ID: <20251002203121.182395-3-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002203121.182395-1-sergeybashirov@gmail.com>
References: <20251002203121.182395-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No changes in functionality. Split the proc_layoutget function to
create a helper function that maps single extent to the requested
range. This helper function is then used to implement support for
multiple extents per LAYOUTGET.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfsd/blocklayout.c | 115 ++++++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 49 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 425648565ab2..35a95501db63 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -17,68 +17,44 @@
 #define NFSDDBG_FACILITY	NFSDDBG_PNFS
 
 
+/*
+ * Get an extent from the file system that starts at offset or below
+ * and may be shorter than the requested length.
+ */
 static __be32
-nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
-		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
+nfsd4_block_map_extent(struct inode *inode, const struct svc_fh *fhp,
+		u64 offset, u64 length, u32 iomode, u64 minlength,
+		struct pnfs_block_extent *bex)
 {
-	struct nfsd4_layout_seg *seg = &args->lg_seg;
 	struct super_block *sb = inode->i_sb;
-	u64 length;
-	u32 block_size = i_blocksize(inode);
-	struct pnfs_block_extent *bex;
 	struct iomap iomap;
 	u32 device_generation = 0;
 	int error;
 
-	if (locks_in_grace(SVC_NET(rqstp)))
-		return nfserr_grace;
-
-	if (seg->offset & (block_size - 1)) {
-		dprintk("pnfsd: I/O misaligned\n");
-		goto out_layoutunavailable;
-	}
-
-	/*
-	 * Some clients barf on non-zero block numbers for NONE or INVALID
-	 * layouts, so make sure to zero the whole structure.
-	 */
-	error = -ENOMEM;
-	bex = kzalloc(sizeof(*bex), GFP_KERNEL);
-	if (!bex)
-		goto out_error;
-	args->lg_content = bex;
-
-	error = sb->s_export_op->map_blocks(inode, seg->offset, seg->length,
-					    &iomap, seg->iomode != IOMODE_READ,
-					    &device_generation);
+	error = sb->s_export_op->map_blocks(inode, offset, length, &iomap,
+			iomode != IOMODE_READ, &device_generation);
 	if (error) {
 		if (error == -ENXIO)
-			goto out_layoutunavailable;
-		goto out_error;
-	}
-
-	length = iomap.offset + iomap.length - seg->offset;
-	if (length < args->lg_minlength) {
-		dprintk("pnfsd: extent smaller than minlength\n");
-		goto out_layoutunavailable;
+			return nfserr_layoutunavailable;
+		return nfserrno(error);
 	}
 
 	switch (iomap.type) {
 	case IOMAP_MAPPED:
-		if (seg->iomode == IOMODE_READ)
+		if (iomode == IOMODE_READ)
 			bex->es = PNFS_BLOCK_READ_DATA;
 		else
 			bex->es = PNFS_BLOCK_READWRITE_DATA;
 		bex->soff = iomap.addr;
 		break;
 	case IOMAP_UNWRITTEN:
-		if (seg->iomode & IOMODE_RW) {
+		if (iomode & IOMODE_RW) {
 			/*
 			 * Crack monkey special case from section 2.3.1.
 			 */
-			if (args->lg_minlength == 0) {
+			if (minlength == 0) {
 				dprintk("pnfsd: no soup for you!\n");
-				goto out_layoutunavailable;
+				return nfserr_layoutunavailable;
 			}
 
 			bex->es = PNFS_BLOCK_INVALID_DATA;
@@ -87,7 +63,7 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 		}
 		fallthrough;
 	case IOMAP_HOLE:
-		if (seg->iomode == IOMODE_READ) {
+		if (iomode == IOMODE_READ) {
 			bex->es = PNFS_BLOCK_NONE_DATA;
 			break;
 		}
@@ -95,27 +71,68 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 	case IOMAP_DELALLOC:
 	default:
 		WARN(1, "pnfsd: filesystem returned %d extent\n", iomap.type);
-		goto out_layoutunavailable;
+		return nfserr_layoutunavailable;
 	}
 
 	error = nfsd4_set_deviceid(&bex->vol_id, fhp, device_generation);
 	if (error)
-		goto out_error;
+		return nfserrno(error);
+
 	bex->foff = iomap.offset;
 	bex->len = iomap.length;
+	return nfs_ok;
+}
+
+static __be32
+nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
+		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
+{
+	struct nfsd4_layout_seg *seg = &args->lg_seg;
+	struct pnfs_block_extent *bex;
+	u64 length;
+	u32 block_size = i_blocksize(inode);
+	__be32 nfserr;
+
+	if (locks_in_grace(SVC_NET(rqstp)))
+		return nfserr_grace;
 
-	seg->offset = iomap.offset;
-	seg->length = iomap.length;
+	nfserr = nfserr_layoutunavailable;
+	if (seg->offset & (block_size - 1)) {
+		dprintk("pnfsd: I/O misaligned\n");
+		goto out_error;
+	}
+
+	/*
+	 * Some clients barf on non-zero block numbers for NONE or INVALID
+	 * layouts, so make sure to zero the whole structure.
+	 */
+	nfserr = nfserrno(-ENOMEM);
+	bex = kzalloc(sizeof(*bex), GFP_KERNEL);
+	if (!bex)
+		goto out_error;
+	args->lg_content = bex;
+
+	nfserr = nfsd4_block_map_extent(inode, fhp, seg->offset, seg->length,
+			seg->iomode, args->lg_minlength, bex);
+	if (nfserr != nfs_ok)
+		goto out_error;
+
+	nfserr = nfserr_layoutunavailable;
+	length = bex->foff + bex->len - seg->offset;
+	if (length < args->lg_minlength) {
+		dprintk("pnfsd: extent smaller than minlength\n");
+		goto out_error;
+	}
+
+	seg->offset = bex->foff;
+	seg->length = bex->len;
 
 	dprintk("GET: 0x%llx:0x%llx %d\n", bex->foff, bex->len, bex->es);
-	return 0;
+	return nfs_ok;
 
 out_error:
 	seg->length = 0;
-	return nfserrno(error);
-out_layoutunavailable:
-	seg->length = 0;
-	return nfserr_layoutunavailable;
+	return nfserr;
 }
 
 static __be32
-- 
2.43.0


