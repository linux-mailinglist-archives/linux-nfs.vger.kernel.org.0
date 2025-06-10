Return-Path: <linux-nfs+bounces-12230-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3C7AD2B28
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 03:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70BBE7A4894
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 01:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2582B9B7;
	Tue, 10 Jun 2025 01:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBYP2KO0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAAF11712;
	Tue, 10 Jun 2025 01:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749518317; cv=none; b=SvNrpVVRBcHCKljEzslcqUDytXqpEPRHYXpF/20+KyKaS8dGnZ+Eb5afuGFBSHa1Sn86CspukOIzvJXaIxIeS7NsyBzhfCorO4TLOoYVGPNg6FN4o3w+HMulZnwhavQh3nxO4dAmIYrQjKfg1HXuICbveXZqFZc0InRtfTasLKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749518317; c=relaxed/simple;
	bh=VtI9LQEAhHglpCreI1PEBlPw03LfthNFSrTavB4g2Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dpLthVwVrZOw7BFL468gvRBXkFCsGlCMOoUC3MpFOgZD7hsDOMNsL5lNX9byBq1wEAHU4MIHu3Nh3QYAdJbBCxQfvH8JLUNLn4Fc07KTQUDE/HX+mmFNscO06umQFXMd+a1NkvaydYQO9gDuVtakXVjCb+BG3k4JG4VaHPjSqFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBYP2KO0; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54d98aa5981so5912301e87.0;
        Mon, 09 Jun 2025 18:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749518314; x=1750123114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RxX+PCkkyMXrUEwf9p1/+3HkwiMKbAbclkOYXrTzIzg=;
        b=lBYP2KO0dhgYG85urmWh919ljH4rScEdXwCUWpoJCLJnRbZhL9QBtQsnEnVQIn9uZS
         IZhg5fMRRUpvaNuZ/ZPri56X+xRMuHDwx0mg1mMUX1jfH5hR3XvMqaO9Zgi7j1vc3veu
         zWnooKGCtdG/LmJJcUPIXa8re9DvU81+8kerkiRxHkT738a5C7nbfZ9pojP5AJSIFKj+
         WFM8kWV8lYj809Mz+6noQ4k75G2nNjAKzl6uLj24OZeWce1hiuGhqIFZo9OpOgRPe2Vk
         94dn5bIpJe6/I9QIxVwCXqW0fYpkTgMcUjKGm984tW/RS8J8/SxVHITRF3whG8QEba8A
         Enzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749518314; x=1750123114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxX+PCkkyMXrUEwf9p1/+3HkwiMKbAbclkOYXrTzIzg=;
        b=A3pyAIHKnCKKVTomP961/I7q0gBuKx/1zAScp6woZ+yk92A1cf6qLQRYu1onWunZi0
         HN8JQtPMCjrFPQXgbPRnEq2BepiECt+Wq4Lf+zU8sgNsx8EbtL33NVLe1N8/9nViT29+
         km9+e9JB8WIVDzNB22XsocGacTptmvL/hVidBzKDaWWl1pEjOrtVlU8yEqpX8F2wCz/2
         cLh5iOO8GJgxYAa+GQniPAy++SS4xi02BEHNMGOS2nEUpnfkgOWg2kYJUkrCim7axPhf
         p6rdcHf+kR+oIfpDsnWLoqUGL3IP/rPxyb4f1ap62eu3BaYBBkzJEJAxfLBeJJqjK6BL
         HfnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaaYu4AOqIpe0l8d8TOC8fL/5jSwsOzBQRJeDt+N8JrSZ1UrBO24QlU3iEI+81tWfBhzblU0OqMcDG3u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuvyOBgi+xDiECnGFVr7/TjejQpWi9ILflGnQz+GlFDkTNLkdR
	qP7EqXHp4Y96QUpC1V7FrEJ3KQYv6AGTvSUKjedkdfUcm7X3h17108S+
X-Gm-Gg: ASbGncu44MHSHLn7mw87I4nZhLvy9q9pPlfY6pomAFJjc4JoJoi68IX8ZXM9cITkwX+
	6drCoDR3Qq7e/n5+IF7dgC2XGPf7nSYN3rPvMc6clyTvFTZXgZiNvFQX2DRpARDN4ANdagUl7Y7
	ATIMcND8UGlcZvl+EUhHwNLAXZr6H0lcqu6Q6hddWQbaJNuHd69LtfnnhWgIqk8bqXL1ODtSa2i
	LzhqsTxkEGsfeWnUStiv/OX8gK02WW1JGNqLpNfJplpm7ySpnqlHCzkTo1xdtYb2ZPsSU2ZjNus
	K2efAXr/Mn4Es3xgXgaGondizFrWSmZDdK1O/vbNZOFHokXy1pEvkGY2bKbQtDiegoCDS70FSx2
	ISKFeiOb0BVmViA==
X-Google-Smtp-Source: AGHT+IFgPGT1grhGIJqSBAop605KFjAiLEbV/arULczSRZDV3zzMHBbaGWaj0P6cEpjfwBhC+9hDOQ==
X-Received: by 2002:a2e:b88c:0:b0:32a:943d:e43 with SMTP id 38308e7fff4ca-32adfb68040mr36976461fa.22.1749518313503;
        Mon, 09 Jun 2025 18:18:33 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.66.227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32ae1d00c11sm12100261fa.106.2025.06.09.18.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 18:18:32 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH v2] nfsd: Implement large extent array support in pNFS
Date: Tue, 10 Jun 2025 04:18:03 +0300
Message-ID: <20250610011818.3232-1-sergeybashirov@gmail.com>
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

The issue can be reproduced when writing to a 1GB file using FIO with small
block size and large I/O depth. Server returns NFSERR_BADXDR to the client.

Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
Changes in v2:
 - Drop the len argument in *_decode_layoutupdate()
 - Remove lc_up_len field from nfsd4_layoutcommit structure
 - Fix code formatting

 fs/nfsd/blocklayout.c    |  8 ++--
 fs/nfsd/blocklayoutxdr.c | 89 +++++++++++++++++++++++++++++-----------
 fs/nfsd/blocklayoutxdr.h |  8 ++--
 fs/nfsd/nfs4xdr.c        | 11 +++--
 fs/nfsd/xdr4.h           |  3 +-
 5 files changed, 78 insertions(+), 41 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 08a20e5bcf7f..e74c3a19aeb9 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -179,8 +179,8 @@ nfsd4_block_proc_layoutcommit(struct inode *inode,
 	struct iomap *iomaps;
 	int nr_iomaps;
 
-	nr_iomaps = nfsd4_block_decode_layoutupdate(lcp->lc_up_layout,
-			lcp->lc_up_len, &iomaps, i_blocksize(inode));
+	nr_iomaps = nfsd4_block_decode_layoutupdate(&lcp->lc_up_layout,
+			&iomaps, i_blocksize(inode));
 	if (nr_iomaps < 0)
 		return nfserrno(nr_iomaps);
 
@@ -317,8 +317,8 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode,
 	struct iomap *iomaps;
 	int nr_iomaps;
 
-	nr_iomaps = nfsd4_scsi_decode_layoutupdate(lcp->lc_up_layout,
-			lcp->lc_up_len, &iomaps, i_blocksize(inode));
+	nr_iomaps = nfsd4_scsi_decode_layoutupdate(&lcp->lc_up_layout,
+			&iomaps, i_blocksize(inode));
 	if (nr_iomaps < 0)
 		return nfserrno(nr_iomaps);
 
diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index ce78f74715ee..b76dbb119e19 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -113,26 +113,27 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 }
 
 int
-nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
+nfsd4_block_decode_layoutupdate(struct xdr_buf *buf, struct iomap **iomapp,
 		u32 block_size)
 {
 	struct iomap *iomaps;
-	u32 nr_iomaps, i;
+	u32 nr_iomaps, expected, len, i;
+	struct xdr_stream xdr;
+	char scratch[sizeof(struct pnfs_block_extent)];
 
-	if (len < sizeof(u32)) {
-		dprintk("%s: extent array too small: %u\n", __func__, len);
-		return -EINVAL;
-	}
-	len -= sizeof(u32);
-	if (len % PNFS_BLOCK_EXTENT_SIZE) {
-		dprintk("%s: extent array invalid: %u\n", __func__, len);
+	xdr_init_decode(&xdr, buf, buf->head[0].iov_base, NULL);
+	xdr_set_scratch_buffer(&xdr, scratch, sizeof(scratch));
+
+	if (xdr_stream_decode_u32(&xdr, &nr_iomaps)) {
+		dprintk("%s: failed to decode extent array size\n", __func__);
 		return -EINVAL;
 	}
 
-	nr_iomaps = be32_to_cpup(p++);
-	if (nr_iomaps != len / PNFS_BLOCK_EXTENT_SIZE) {
+	len = sizeof(__be32) + xdr_stream_remaining(&xdr);
+	expected = sizeof(__be32) + nr_iomaps * PNFS_BLOCK_EXTENT_SIZE;
+	if (len != expected) {
 		dprintk("%s: extent array size mismatch: %u/%u\n",
-			__func__, len, nr_iomaps);
+			__func__, len, expected);
 		return -EINVAL;
 	}
 
@@ -144,29 +145,54 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 
 	for (i = 0; i < nr_iomaps; i++) {
 		struct pnfs_block_extent bex;
+		ssize_t ret;
 
-		memcpy(&bex.vol_id, p, sizeof(struct nfsd4_deviceid));
-		p += XDR_QUADLEN(sizeof(struct nfsd4_deviceid));
+		ret = xdr_stream_decode_opaque_fixed(&xdr,
+				&bex.vol_id, sizeof(bex.vol_id));
+		if (ret < sizeof(bex.vol_id)) {
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
@@ -185,18 +211,23 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 }
 
 int
-nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
+nfsd4_scsi_decode_layoutupdate(struct xdr_buf *buf, struct iomap **iomapp,
 		u32 block_size)
 {
 	struct iomap *iomaps;
-	u32 nr_iomaps, expected, i;
+	u32 nr_iomaps, expected, len, i;
+	struct xdr_stream xdr;
+	char scratch[sizeof(struct pnfs_block_range)];
 
-	if (len < sizeof(u32)) {
-		dprintk("%s: extent array too small: %u\n", __func__, len);
+	xdr_init_decode(&xdr, buf, buf->head[0].iov_base, NULL);
+	xdr_set_scratch_buffer(&xdr, scratch, sizeof(scratch));
+
+	if (xdr_stream_decode_u32(&xdr, &nr_iomaps)) {
+		dprintk("%s: failed to decode extent array size\n", __func__);
 		return -EINVAL;
 	}
 
-	nr_iomaps = be32_to_cpup(p++);
+	len = sizeof(__be32) + xdr_stream_remaining(&xdr);
 	expected = sizeof(__be32) + nr_iomaps * PNFS_SCSI_RANGE_SIZE;
 	if (len != expected) {
 		dprintk("%s: extent array size mismatch: %u/%u\n",
@@ -213,14 +244,22 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
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
index 4e28ac8f1127..6e603cfec0a7 100644
--- a/fs/nfsd/blocklayoutxdr.h
+++ b/fs/nfsd/blocklayoutxdr.h
@@ -54,9 +54,9 @@ __be32 nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 		const struct nfsd4_getdeviceinfo *gdp);
 __be32 nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
 		const struct nfsd4_layoutget *lgp);
-int nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
-		u32 block_size);
-int nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
-		u32 block_size);
+int nfsd4_block_decode_layoutupdate(struct xdr_buf *buf,
+		struct iomap **iomapp, u32 block_size);
+int nfsd4_scsi_decode_layoutupdate(struct xdr_buf *buf,
+		struct iomap **iomapp, u32 block_size);
 
 #endif /* _NFSD_BLOCKLAYOUTXDR_H */
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 3afcdbed6e14..659e60b85d5f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -604,6 +604,8 @@ static __be32
 nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
 			   struct nfsd4_layoutcommit *lcp)
 {
+	u32 len;
+
 	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_layout_type) < 0)
 		return nfserr_bad_xdr;
 	if (lcp->lc_layout_type < LAYOUT_NFSV4_1_FILES)
@@ -611,13 +613,10 @@ nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
 	if (lcp->lc_layout_type >= LAYOUT_TYPE_MAX)
 		return nfserr_bad_xdr;
 
-	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_up_len) < 0)
+	if (xdr_stream_decode_u32(argp->xdr, &len) < 0)
+		return nfserr_bad_xdr;
+	if (!xdr_stream_subsegment(argp->xdr, &lcp->lc_up_layout, len))
 		return nfserr_bad_xdr;
-	if (lcp->lc_up_len > 0) {
-		lcp->lc_up_layout = xdr_inline_decode(argp->xdr, lcp->lc_up_len);
-		if (!lcp->lc_up_layout)
-			return nfserr_bad_xdr;
-	}
 
 	return nfs_ok;
 }
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index aa2a356da784..02887029a81c 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -630,8 +630,7 @@ struct nfsd4_layoutcommit {
 	u64			lc_last_wr;	/* request */
 	struct timespec64	lc_mtime;	/* request */
 	u32			lc_layout_type;	/* request */
-	u32			lc_up_len;	/* layout length */
-	void			*lc_up_layout;	/* decoded by callback */
+	struct xdr_buf		lc_up_layout;	/* decoded by callback */
 	bool			lc_size_chg;	/* response */
 	u64			lc_newsize;	/* response */
 };
-- 
2.43.0


