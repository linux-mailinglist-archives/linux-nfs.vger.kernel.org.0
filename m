Return-Path: <linux-nfs+bounces-12088-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF07ACDEA2
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 15:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1964189AA2C
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 13:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B96528FA9F;
	Wed,  4 Jun 2025 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2SG9gJc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E5529116C
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749042501; cv=none; b=bCSIG7DJZIpCsrRLXv79cm0w6cd+L6gOBz+Yj5TCRCPIjTlRB6llGkdK3Iy0/eTgKEzFV41XxaasFuwb939ffKscWSs0+AvVz5FGxAzyYFBxPFBitE7u1UIcuZw/pQVkHvFEMVhkbyn+09rOgNQX1Isq3llYCfSf/Tdv632t+cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749042501; c=relaxed/simple;
	bh=1Kr5JhssjO7jafV4Cup6QVRE32b37Y54o3XKjiywQxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHJ0Jb15edx63VEtmdQnmAMoJFItRU+68LVhREPX/ELrgpopr4aABypbbSXaMrCfyB6+4RGHdUli8uVxCF7Y74KjlY3T+aS0pgL+aWqTCz4K+afwKKK5EDVgAva8dYk5TOK93pUdM/PvXeWNCNL+vapy/aFiXBKKS+cLp1cqBxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2SG9gJc; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5534edc646dso3687389e87.1
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jun 2025 06:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749042497; x=1749647297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gAFs5xBwEdthDuNA5MuVPcy3Wrqm4PKfmgoJJ771v8s=;
        b=Y2SG9gJcZyQF/HbT+Om0WmqEH5TCxSDHiRrrINcJxB1sFhCL74b+WYCCDdxLeeOGy4
         BRgtWv6EBu9fQhq69jRfPaApyISPJzAhHWaynojKkH9TEUMGv+M5iOCIfKoo0W4hWigq
         cc1ogmYXDtY9Bo9B7i4EEcKgpXPr0F2t5mZ842Kf4+wZLvHm9qin2WoTr+5wBSCq6Brf
         FoRNf6zryRuGXCEYK0dm39slGO4Okh4/TVKOoxhLBIb1k4mxiDf2flNHQur3lzgBCwvu
         n7Dl1KBDIQvfiPUZKTCFlDGpcy45YNaRau/d99wfBqLhM/Uu323jgiCr4e0qiiOeT3Ww
         YtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749042497; x=1749647297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAFs5xBwEdthDuNA5MuVPcy3Wrqm4PKfmgoJJ771v8s=;
        b=hgJp4DexJsSeGOYpfsf+4BjPZWJnijbYYFtLHmYPqKfSdTgx86HL13rcyJMa3rBAC6
         GdcRPNb3YxTfvec7GjZIyGbM1qKOfXxhoorVZiThMR8Sbz4CI185UgvyQTOjBo/zXRM9
         LHKii93YP6woE4wDdde6JFP3IPmI9wqmHFid60xnC66mXasKyns5URmWjhngtsFKEmPj
         5RB+0931p+pqvLOxa80mH7D6b4YVYC8HHkYNMWJigXLx5cnj2LvGijmRI8lW+n9tbADe
         LHrupTeUSqtw3YSGRFkxw35w2AK5xTA6SGStH+A5MD/ZBiVtbMtwlpyOlvCcnID7QRqR
         KUjg==
X-Gm-Message-State: AOJu0Yx1vGrttR+HRq48zCJJa65dK2WVEb1Hqa99esXwUbiX+3hIQ6Nt
	SDJ1w2Z8wllBAKPyXcHGlk5CBO1Yh+kVoUv4q4CFcUzY5HVN4KcsWvQF
X-Gm-Gg: ASbGncs1tG7bIfTWWaadtjVDIa87ZM3XmT6s12/P4h9dvrkBLd3znznKXpIndrKqY3V
	nGzCIfMBw3GJR4hhpppdKuB4YDI0THVRPi8NjtYkM+zM4hHdZVEZKcmK/XN2g8F+RB+wP08Q5uu
	J2jfZX4PxqVOdXoKCg/gGRkcW+Gitb9tTjFR9u/vafx+QGYpqJLpB3CxWEBtShax8QdjbVlx6I9
	58wIr4rYPdL2j6ovbVXd6U9CXbL7Kkm5FgEa48D4IZrpJhJU/nq81DmL6c+Z+DzYMjIsT6Lco4d
	mGcAP25iPZdmPmfHodCgL9eV413sRqPf40nvIcSRFRNCfO2bukI7FnXMpAQHn+HC7kAZOIcSeUA
	ZtG4IbeLF6YKDBB+JRERdD1iRyw==
X-Google-Smtp-Source: AGHT+IG0ZEWpj41MPHO39amLZSAecLMplFiqtNx5QiAc/bANLsprDHJWcsT+qFszIP5YeDJxuBeW9g==
X-Received: by 2002:a05:6512:108e:b0:553:50f6:ebcd with SMTP id 2adb3069b0e04-55356ae56a2mr855394e87.10.1749042496634;
        Wed, 04 Jun 2025 06:08:16 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([178.34.114.148])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5533791cdcesm2327084e87.164.2025.06.04.06.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 06:08:16 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: "J . Bruce Fields" <bfields@fieldses.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: [PATCH] nfsd: Implement large extent array support in pNFS
Date: Wed,  4 Jun 2025 16:07:08 +0300
Message-ID: <20250604130809.52931-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pNFS client in block layout mode sends layoutcommit RPC to MDS,
a variable length array of modified extents is supplied within request.
This patch allows NFS server to accept such extent arrays if they do not
fit within single memory page.

Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfsd/blocklayout.c    | 12 ++++---
 fs/nfsd/blocklayoutxdr.c | 78 ++++++++++++++++++++++++++++++++--------
 fs/nfsd/blocklayoutxdr.h |  8 ++---
 fs/nfsd/nfs4xdr.c        |  7 ++--
 fs/nfsd/xdr4.h           |  2 +-
 5 files changed, 79 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index e5c0982a381d..d40a0860fcf6 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -179,8 +179,10 @@ nfsd4_block_proc_layoutcommit(struct inode *inode,
 	struct iomap *iomaps;
 	int nr_iomaps;
 
-	nr_iomaps = nfsd4_block_decode_layoutupdate(lcp->lc_up_layout,
-			lcp->lc_up_len, &iomaps, i_blocksize(inode));
+	nr_iomaps = nfsd4_block_decode_layoutupdate(&lcp->lc_up_layout,
+						    lcp->lc_up_len,
+						    &iomaps,
+						    i_blocksize(inode));
 	if (nr_iomaps < 0)
 		return nfserrno(nr_iomaps);
 
@@ -317,8 +319,10 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode,
 	struct iomap *iomaps;
 	int nr_iomaps;
 
-	nr_iomaps = nfsd4_scsi_decode_layoutupdate(lcp->lc_up_layout,
-			lcp->lc_up_len, &iomaps, i_blocksize(inode));
+	nr_iomaps = nfsd4_scsi_decode_layoutupdate(&lcp->lc_up_layout,
+						   lcp->lc_up_len,
+						   &iomaps,
+						   i_blocksize(inode));
 	if (nr_iomaps < 0)
 		return nfserrno(nr_iomaps);
 
diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index 442543304930..e3e3d79c8b4f 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -103,11 +103,13 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 }
 
 int
-nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
-		u32 block_size)
+nfsd4_block_decode_layoutupdate(struct xdr_buf *buf, u32 len,
+				struct iomap **iomapp, u32 block_size)
 {
+	struct xdr_stream xdr;
 	struct iomap *iomaps;
 	u32 nr_iomaps, i;
+	char scratch[sizeof(struct pnfs_block_extent)];
 
 	if (len < sizeof(u32)) {
 		dprintk("%s: extent array too small: %u\n", __func__, len);
@@ -119,7 +121,15 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 		return -EINVAL;
 	}
 
-	nr_iomaps = be32_to_cpup(p++);
+	xdr_init_decode(&xdr, buf, buf->head[0].iov_base, NULL);
+	xdr_set_scratch_buffer(&xdr, scratch, sizeof(scratch));
+
+	if (xdr_stream_decode_u32(&xdr, &nr_iomaps)) {
+		dprintk("%s: failed to decode extent array length\n",
+			__func__);
+		return -EINVAL;
+	}
+
 	if (nr_iomaps != len / PNFS_BLOCK_EXTENT_SIZE) {
 		dprintk("%s: extent array size mismatch: %u/%u\n",
 			__func__, len, nr_iomaps);
@@ -135,28 +145,51 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	for (i = 0; i < nr_iomaps; i++) {
 		struct pnfs_block_extent bex;
 
-		memcpy(&bex.vol_id, p, sizeof(struct nfsd4_deviceid));
-		p += XDR_QUADLEN(sizeof(struct nfsd4_deviceid));
+		if (xdr_stream_decode_opaque_fixed(&xdr, &bex.vol_id, sizeof(bex.vol_id)) <
+		    sizeof(bex.vol_id)) {
+			dprintk("%s: failed to decode device id for entry %u\n",
+				__func__, i);
+			goto fail;
+		}
 
-		p = xdr_decode_hyper(p, &bex.foff);
+		if (xdr_stream_decode_u64(&xdr, &bex.foff)) {
+			dprintk("%s: failed to decode offset for entry %u\n",
+				__func__, i);
+			goto fail;
+		}
 		if (bex.foff & (block_size - 1)) {
 			dprintk("%s: unaligned offset 0x%llx\n",
 				__func__, bex.foff);
 			goto fail;
 		}
-		p = xdr_decode_hyper(p, &bex.len);
+
+		if (xdr_stream_decode_u64(&xdr, &bex.len)) {
+			dprintk("%s: failed to decode length for entry %u\n",
+				__func__, i);
+			goto fail;
+		}
 		if (bex.len & (block_size - 1)) {
 			dprintk("%s: unaligned length 0x%llx\n",
 				__func__, bex.foff);
 			goto fail;
 		}
-		p = xdr_decode_hyper(p, &bex.soff);
+
+		if (xdr_stream_decode_u64(&xdr, &bex.soff)) {
+			dprintk("%s: failed to decode soffset for entry %u\n",
+				__func__, i);
+			goto fail;
+		}
 		if (bex.soff & (block_size - 1)) {
 			dprintk("%s: unaligned disk offset 0x%llx\n",
 				__func__, bex.soff);
 			goto fail;
 		}
-		bex.es = be32_to_cpup(p++);
+
+		if (xdr_stream_decode_u32(&xdr, &bex.es)) {
+			dprintk("%s: failed to decode estate for entry %u\n",
+				__func__, i);
+			goto fail;
+		}
 		if (bex.es != PNFS_BLOCK_READWRITE_DATA) {
 			dprintk("%s: incorrect extent state %d\n",
 				__func__, bex.es);
@@ -175,18 +208,27 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 }
 
 int
-nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
-		u32 block_size)
+nfsd4_scsi_decode_layoutupdate(struct xdr_buf *buf, u32 len,
+			       struct iomap **iomapp, u32 block_size)
 {
+	struct xdr_stream xdr;
 	struct iomap *iomaps;
 	u32 nr_iomaps, expected, i;
+	char scratch[sizeof(u64)];
 
 	if (len < sizeof(u32)) {
 		dprintk("%s: extent array too small: %u\n", __func__, len);
 		return -EINVAL;
 	}
 
-	nr_iomaps = be32_to_cpup(p++);
+	xdr_init_decode(&xdr, buf, buf->head[0].iov_base, NULL);
+	xdr_set_scratch_buffer(&xdr, scratch, sizeof(scratch));
+
+	if (xdr_stream_decode_u32(&xdr, &nr_iomaps)) {
+		dprintk("%s: failed to decode extent array length\n", __func__);
+		return -EINVAL;
+	}
+
 	expected = sizeof(__be32) + nr_iomaps * PNFS_SCSI_RANGE_SIZE;
 	if (len != expected) {
 		dprintk("%s: extent array size mismatch: %u/%u\n",
@@ -203,14 +245,22 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	for (i = 0; i < nr_iomaps; i++) {
 		u64 val;
 
-		p = xdr_decode_hyper(p, &val);
+		if (xdr_stream_decode_u64(&xdr, &val)) {
+			dprintk("%s: failed to decode offset for entry %u\n",
+				__func__, i);
+			goto fail;
+		}
 		if (val & (block_size - 1)) {
 			dprintk("%s: unaligned offset 0x%llx\n", __func__, val);
 			goto fail;
 		}
 		iomaps[i].offset = val;
 
-		p = xdr_decode_hyper(p, &val);
+		if (xdr_stream_decode_u64(&xdr, &val)) {
+			dprintk("%s: failed to decode length for entry %u\n",
+				__func__, i);
+			goto fail;
+		}
 		if (val & (block_size - 1)) {
 			dprintk("%s: unaligned length 0x%llx\n", __func__, val);
 			goto fail;
diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
index bc5166bfe46b..c4c8139b8e96 100644
--- a/fs/nfsd/blocklayoutxdr.h
+++ b/fs/nfsd/blocklayoutxdr.h
@@ -54,9 +54,9 @@ __be32 nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 		struct nfsd4_getdeviceinfo *gdp);
 __be32 nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
 		struct nfsd4_layoutget *lgp);
-int nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
-		u32 block_size);
-int nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
-		u32 block_size);
+int nfsd4_block_decode_layoutupdate(struct xdr_buf *buf, u32 len,
+		struct iomap **iomapp, u32 block_size);
+int nfsd4_scsi_decode_layoutupdate(struct xdr_buf *buf, u32 len,
+		struct iomap **iomapp, u32 block_size);
 
 #endif /* _NFSD_BLOCKLAYOUTXDR_H */
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5a93a5db4fb0..81f42dc75b95 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -592,11 +592,8 @@ nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
 
 	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_up_len) < 0)
 		return nfserr_bad_xdr;
-	if (lcp->lc_up_len > 0) {
-		lcp->lc_up_layout = xdr_inline_decode(argp->xdr, lcp->lc_up_len);
-		if (!lcp->lc_up_layout)
-			return nfserr_bad_xdr;
-	}
+	if (!xdr_stream_subsegment(argp->xdr, &lcp->lc_up_layout, lcp->lc_up_len))
+		return nfserr_bad_xdr;
 
 	return nfs_ok;
 }
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 846ab6df9d48..8516a1a6b46d 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -492,7 +492,7 @@ struct nfsd4_layoutcommit {
 	struct timespec64	lc_mtime;	/* request */
 	u32			lc_layout_type;	/* request */
 	u32			lc_up_len;	/* layout length */
-	void			*lc_up_layout;	/* decoded by callback */
+	struct xdr_buf		lc_up_layout;	/* request, decoded by callback */
 	u32			lc_size_chg;	/* boolean for response */
 	u64			lc_newsize;	/* response */
 };
-- 
2.43.0


