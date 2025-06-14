Return-Path: <linux-nfs+bounces-12466-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1293AAD9E32
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Jun 2025 18:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0B83AE7F8
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Jun 2025 15:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CFC2D9ED3;
	Sat, 14 Jun 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yla+sO6f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCEE1DDC08;
	Sat, 14 Jun 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749916801; cv=none; b=Krx5JePWa/Yvok2pZ58SIWYUzI6hi/z94kIuDpV24wyiwEBBgJB/klhopjtu4wosQt+0T30tL/EDyN9C75SYJoYv6pcNGvlKukcJWhbIZNQgEiMwEcDrhl7y3f3xSdVCmOB6pEA/obdzFEWeluPst8b18R/9FmnYfo6+CF/5MD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749916801; c=relaxed/simple;
	bh=KEx7hoirPdt47g221rjcs8BuO4+mJTP7vxekWFv/7fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hjmS2jm2ZKzsnYwhSOAFLyfuZrAp/kwONlTY/OTxL2RDbOyCJSvpvNTEjaDz38bQZJB/tsnHenzTY4UZL4/ubfUOBO54Kp/6T9AGKythg2pyI+jdJFx0BHpvV+CGN7kriyV8b9A8/f2lJrjHHMASb9xq4wANTfwQzKHxmJ7aqAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yla+sO6f; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32b43cce9efso12395991fa.3;
        Sat, 14 Jun 2025 08:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749916798; x=1750521598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ug0a7NlfbA8HxZxwF5wvPqDhYNOxOmP7Ys12tQJRGJk=;
        b=Yla+sO6fo7/4RFAx99y9ofUZGAstbdYxJC7kIVglzQPumqpbVYdySwvoOl+p0TTomB
         o5wHmJFX2R0ghoeguvATQ6cDoCkixD3QzpH/NRXEu2c6INZX1iMChXYCG+iRKhVUnck1
         PIDiquhMBS5OPYO5CUXAAJfOk0WtFUk1XF8pYcoursX8wNftSzB7Trq5LXjBDBZGPfTb
         13uPt+E+DOXh8YbhBFElepTuY1yYzzk6csFLSBEwRSRBsOyjmRLfRWm8laLvBEMlNpMQ
         wGuy5aciII4EXlOF1JtVvkO9RHq314RL7yw57ViWJd1zQOQYrOaCBAmEXJY9WHsEbO8G
         +8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749916798; x=1750521598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ug0a7NlfbA8HxZxwF5wvPqDhYNOxOmP7Ys12tQJRGJk=;
        b=SfsEdsOnnzkUD/e+gtqTtPkj9FJE//V2AnA33aRWvuFaQeTdbUbR6kRbpB1wMDlfVl
         pOg5vwg+I7+MlzYHCb3RFNxX/kb8f/l3JXS9qh+hoW4AuQ0ebQ20nH0AtUGlYxMMgEih
         uPqiQg3rJZ3RPsuiCIG4XgDctDhXWx7KPLoLVARa+ODcnf7uM42ywZiedsPp4JenDTsZ
         LimMDf7rCkuEWuVyET6RCacblZxbuSll39uPGr0Jc8IY/BubmiIXMwv/8IYkht5NYH9N
         JJITcLy4C7T1WE7n8tVfVjV3Q+8YkEa+v3kFKot5Y/Z8/UVbGpq7DQ9fQo/9N8i2EYMu
         3a5w==
X-Forwarded-Encrypted: i=1; AJvYcCXYwVKPmfm/mi5FqOtiJ72GMOKX/FdTDc5oR8hF5O3ZHtMCKzsBcerTiI/uDE6apwtN+aUcOrs6zzMX1zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCoxbP0VHOQcNmHFwKKJiTndYOk9inYlZJT17RMLueepC9OiBk
	8Wb1zHabluaw3GAsz05AeAJsmhqqWS8R07tzMVit8L4x43MaS0NeYQLMYMeqrnpf
X-Gm-Gg: ASbGncsTDY3RpRPEW2TVgXiW/I64UERmNzmjGXP9T3sPP02b22pRcvst49zorkRO4Xf
	2XHIDHQfbFYZqCZ4hR4PZtx1H5v/V78JOx/9eFzg6LzMofbVmzxq35n0uOVo0/IdHZvUGDRvoLt
	kGu5JXCHwbBD7mZ0K3L/2Ag9oORdMzD4241wsYz3uA6E6TCZNim9OT5vadg5jmXX+A3pRvoSA45
	0Wex2kzSJQ/yU5XxoUjjDXuVkCW0zdzCSHffOt1dM/Pz3zRC5A9qi29VLNEU7lg2yz/S6glg/Ff
	lk67Ulzzcb/o4DyzY01Zmsq5RhPb0hRBdSkvXmpM+9xqFwZH4m47l+HybETOISuHaYlF9ipfeVk
	EA7fJMRahV/hOhg==
X-Google-Smtp-Source: AGHT+IHD3ojF6DhRsYa/1El4O2X3XWFqL7qp3UnWxRXvLIScWF+MKtlSgVVSSuq75HNe5HLJt4Fmjw==
X-Received: by 2002:a2e:a99a:0:b0:32a:74db:fe73 with SMTP id 38308e7fff4ca-32b4a6dc1ccmr9864981fa.28.1749916797430;
        Sat, 14 Jun 2025 08:59:57 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.218.196])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b33170c8asm9067761fa.67.2025.06.14.08.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 08:59:57 -0700 (PDT)
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
Subject: [PATCH v3] nfsd: Implement large extent array support in pNFS
Date: Sat, 14 Jun 2025 18:59:48 +0300
Message-ID: <20250614155950.116302-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pNFS client in the block or scsi layout mode sends layoutcommit
to MDS, a variable length array of modified extents is supplied within
the request. This patch allows the server to accept such extent arrays
if they do not fit within single memory page.

The issue can be reproduced when writing to a 1GB file using FIO with
O_DIRECT, 4K block and large I/O depth without preallocation of the
file. In this case, the server returns NFSERR_BADXDR to the client.

Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
Changes in v3:
 - Prerequisite: [v3] nfsd: Use correct error code when decoding extents
 - Drop dprintk()
 - Use svcxdr_init_decode() to init subbuf
 - Tested manually the block layout driver using FIO

 fs/nfsd/blocklayout.c    |  20 ++++---
 fs/nfsd/blocklayoutxdr.c | 118 ++++++++++++++++++++-------------------
 fs/nfsd/blocklayoutxdr.h |   4 +-
 fs/nfsd/nfs4proc.c       |   2 +-
 fs/nfsd/nfs4xdr.c        |  11 ++--
 fs/nfsd/pnfs.h           |   1 +
 fs/nfsd/xdr4.h           |   3 +-
 7 files changed, 83 insertions(+), 76 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 19078a043e85..54fbe157f84a 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -173,16 +173,18 @@ nfsd4_block_proc_getdeviceinfo(struct super_block *sb,
 }
 
 static __be32
-nfsd4_block_proc_layoutcommit(struct inode *inode,
+nfsd4_block_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
 		struct nfsd4_layoutcommit *lcp)
 {
 	struct iomap *iomaps;
 	int nr_iomaps;
 	__be32 nfserr;
 
-	nfserr = nfsd4_block_decode_layoutupdate(lcp->lc_up_layout,
-			lcp->lc_up_len, &iomaps, &nr_iomaps,
-			i_blocksize(inode));
+	memcpy(&rqstp->rq_arg, &lcp->lc_up_layout, sizeof(struct xdr_buf));
+	svcxdr_init_decode(rqstp);
+
+	nfserr = nfsd4_block_decode_layoutupdate(&rqstp->rq_arg_stream,
+			&iomaps, &nr_iomaps, i_blocksize(inode));
 	if (nfserr != nfs_ok)
 		return nfserr;
 
@@ -313,16 +315,18 @@ nfsd4_scsi_proc_getdeviceinfo(struct super_block *sb,
 	return nfserrno(nfsd4_block_get_device_info_scsi(sb, clp, gdp));
 }
 static __be32
-nfsd4_scsi_proc_layoutcommit(struct inode *inode,
+nfsd4_scsi_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
 		struct nfsd4_layoutcommit *lcp)
 {
 	struct iomap *iomaps;
 	int nr_iomaps;
 	__be32 nfserr;
 
-	nfserr = nfsd4_scsi_decode_layoutupdate(lcp->lc_up_layout,
-			lcp->lc_up_len, &iomaps, &nr_iomaps,
-			i_blocksize(inode));
+	memcpy(&rqstp->rq_arg, &lcp->lc_up_layout, sizeof(struct xdr_buf));
+	svcxdr_init_decode(rqstp);
+
+	nfserr = nfsd4_scsi_decode_layoutupdate(&rqstp->rq_arg_stream,
+			&iomaps, &nr_iomaps, i_blocksize(inode));
 	if (nfserr != nfs_ok)
 		return nfserr;
 
diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index 669ff8e6e966..266b2737882e 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -114,8 +114,7 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 
 /**
  * nfsd4_block_decode_layoutupdate - decode the block layout extent array
- * @p: pointer to the xdr data
- * @len: number of bytes to decode
+ * @xdr: subbuf set to the encoded array
  * @iomapp: pointer to store the decoded extent array
  * @nr_iomapsp: pointer to store the number of extents
  * @block_size: alignment of extent offset and length
@@ -128,68 +127,74 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
  *
  * Return values:
  *   %nfs_ok: Successful decoding, @iomapp and @nr_iomapsp are valid
- *   %nfserr_bad_xdr: The encoded array in @p is invalid
+ *   %nfserr_bad_xdr: The encoded array in @xdr is invalid
  *   %nfserr_inval: An unaligned extent found
  *   %nfserr_delay: Failed to allocate memory for @iomapp
  */
 __be32
-nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
+nfsd4_block_decode_layoutupdate(struct xdr_stream *xdr, struct iomap **iomapp,
 		int *nr_iomapsp, u32 block_size)
 {
 	struct iomap *iomaps;
-	u32 nr_iomaps, i;
+	u32 nr_iomaps, expected, len, i;
+	__be32 nfserr;
 
-	if (len < sizeof(u32)) {
-		dprintk("%s: extent array too small: %u\n", __func__, len);
+	if (xdr_stream_decode_u32(xdr, &nr_iomaps))
 		return nfserr_bad_xdr;
-	}
-	len -= sizeof(u32);
-	if (len % PNFS_BLOCK_EXTENT_SIZE) {
-		dprintk("%s: extent array invalid: %u\n", __func__, len);
-		return nfserr_bad_xdr;
-	}
 
-	nr_iomaps = be32_to_cpup(p++);
-	if (nr_iomaps != len / PNFS_BLOCK_EXTENT_SIZE) {
-		dprintk("%s: extent array size mismatch: %u/%u\n",
-			__func__, len, nr_iomaps);
+	len = sizeof(__be32) + xdr_stream_remaining(xdr);
+	expected = sizeof(__be32) + nr_iomaps * PNFS_BLOCK_EXTENT_SIZE;
+	if (len != expected)
 		return nfserr_bad_xdr;
-	}
 
 	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
-	if (!iomaps) {
-		dprintk("%s: failed to allocate extent array\n", __func__);
+	if (!iomaps)
 		return nfserr_delay;
-	}
 
 	for (i = 0; i < nr_iomaps; i++) {
 		struct pnfs_block_extent bex;
+		ssize_t ret;
 
-		memcpy(&bex.vol_id, p, sizeof(struct nfsd4_deviceid));
-		p += XDR_QUADLEN(sizeof(struct nfsd4_deviceid));
+		ret = xdr_stream_decode_opaque_fixed(xdr,
+				&bex.vol_id, sizeof(bex.vol_id));
+		if (ret < sizeof(bex.vol_id)) {
+			nfserr = nfserr_bad_xdr;
+			goto fail;
+		}
 
-		p = xdr_decode_hyper(p, &bex.foff);
+		if (xdr_stream_decode_u64(xdr, &bex.foff)) {
+			nfserr = nfserr_bad_xdr;
+			goto fail;
+		}
 		if (bex.foff & (block_size - 1)) {
-			dprintk("%s: unaligned offset 0x%llx\n",
-				__func__, bex.foff);
+			nfserr = nfserr_inval;
+			goto fail;
+		}
+
+		if (xdr_stream_decode_u64(xdr, &bex.len)) {
+			nfserr = nfserr_bad_xdr;
 			goto fail;
 		}
-		p = xdr_decode_hyper(p, &bex.len);
 		if (bex.len & (block_size - 1)) {
-			dprintk("%s: unaligned length 0x%llx\n",
-				__func__, bex.foff);
+			nfserr = nfserr_inval;
+			goto fail;
+		}
+
+		if (xdr_stream_decode_u64(xdr, &bex.soff)) {
+			nfserr = nfserr_bad_xdr;
 			goto fail;
 		}
-		p = xdr_decode_hyper(p, &bex.soff);
 		if (bex.soff & (block_size - 1)) {
-			dprintk("%s: unaligned disk offset 0x%llx\n",
-				__func__, bex.soff);
+			nfserr = nfserr_inval;
+			goto fail;
+		}
+
+		if (xdr_stream_decode_u32(xdr, &bex.es)) {
+			nfserr = nfserr_bad_xdr;
 			goto fail;
 		}
-		bex.es = be32_to_cpup(p++);
 		if (bex.es != PNFS_BLOCK_READWRITE_DATA) {
-			dprintk("%s: incorrect extent state %d\n",
-				__func__, bex.es);
+			nfserr = nfserr_inval;
 			goto fail;
 		}
 
@@ -202,13 +207,12 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	return nfs_ok;
 fail:
 	kfree(iomaps);
-	return nfserr_inval;
+	return nfserr;
 }
 
 /**
  * nfsd4_scsi_decode_layoutupdate - decode the scsi layout extent array
- * @p: pointer to the xdr data
- * @len: number of bytes to decode
+ * @xdr: subbuf set to the encoded array
  * @iomapp: pointer to store the decoded extent array
  * @nr_iomapsp: pointer to store the number of extents
  * @block_size: alignment of extent offset and length
@@ -220,49 +224,49 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
  *
  * Return values:
  *   %nfs_ok: Successful decoding, @iomapp and @nr_iomapsp are valid
- *   %nfserr_bad_xdr: The encoded array in @p is invalid
+ *   %nfserr_bad_xdr: The encoded array in @xdr is invalid
  *   %nfserr_inval: An unaligned extent found
  *   %nfserr_delay: Failed to allocate memory for @iomapp
  */
 __be32
-nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
+nfsd4_scsi_decode_layoutupdate(struct xdr_stream *xdr, struct iomap **iomapp,
 		int *nr_iomapsp, u32 block_size)
 {
 	struct iomap *iomaps;
-	u32 nr_iomaps, expected, i;
+	u32 nr_iomaps, expected, len, i;
+	__be32 nfserr;
 
-	if (len < sizeof(u32)) {
-		dprintk("%s: extent array too small: %u\n", __func__, len);
+	if (xdr_stream_decode_u32(xdr, &nr_iomaps))
 		return nfserr_bad_xdr;
-	}
 
-	nr_iomaps = be32_to_cpup(p++);
+	len = sizeof(__be32) + xdr_stream_remaining(xdr);
 	expected = sizeof(__be32) + nr_iomaps * PNFS_SCSI_RANGE_SIZE;
-	if (len != expected) {
-		dprintk("%s: extent array size mismatch: %u/%u\n",
-			__func__, len, expected);
+	if (len != expected)
 		return nfserr_bad_xdr;
-	}
 
 	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
-	if (!iomaps) {
-		dprintk("%s: failed to allocate extent array\n", __func__);
+	if (!iomaps)
 		return nfserr_delay;
-	}
 
 	for (i = 0; i < nr_iomaps; i++) {
 		u64 val;
 
-		p = xdr_decode_hyper(p, &val);
+		if (xdr_stream_decode_u64(xdr, &val)) {
+			nfserr = nfserr_bad_xdr;
+			goto fail;
+		}
 		if (val & (block_size - 1)) {
-			dprintk("%s: unaligned offset 0x%llx\n", __func__, val);
+			nfserr = nfserr_inval;
 			goto fail;
 		}
 		iomaps[i].offset = val;
 
-		p = xdr_decode_hyper(p, &val);
+		if (xdr_stream_decode_u64(xdr, &val)) {
+			nfserr = nfserr_bad_xdr;
+			goto fail;
+		}
 		if (val & (block_size - 1)) {
-			dprintk("%s: unaligned length 0x%llx\n", __func__, val);
+			nfserr = nfserr_inval;
 			goto fail;
 		}
 		iomaps[i].length = val;
@@ -273,5 +277,5 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	return nfs_ok;
 fail:
 	kfree(iomaps);
-	return nfserr_inval;
+	return nfserr;
 }
diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
index 15b3569f3d9a..7d25ef689671 100644
--- a/fs/nfsd/blocklayoutxdr.h
+++ b/fs/nfsd/blocklayoutxdr.h
@@ -54,9 +54,9 @@ __be32 nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 		const struct nfsd4_getdeviceinfo *gdp);
 __be32 nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
 		const struct nfsd4_layoutget *lgp);
-__be32 nfsd4_block_decode_layoutupdate(__be32 *p, u32 len,
+__be32 nfsd4_block_decode_layoutupdate(struct xdr_stream *xdr,
 		struct iomap **iomapp, int *nr_iomapsp, u32 block_size);
-__be32 nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len,
+__be32 nfsd4_scsi_decode_layoutupdate(struct xdr_stream *xdr,
 		struct iomap **iomapp, int *nr_iomapsp, u32 block_size);
 
 #endif /* _NFSD_BLOCKLAYOUTXDR_H */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f13abbb13b38..873cd667477c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2533,7 +2533,7 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 		lcp->lc_size_chg = false;
 	}
 
-	nfserr = ops->proc_layoutcommit(inode, lcp);
+	nfserr = ops->proc_layoutcommit(inode, rqstp, lcp);
 	nfs4_put_stid(&ls->ls_stid);
 out:
 	return nfserr;
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
diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
index 925817f66917..dfd411d1f363 100644
--- a/fs/nfsd/pnfs.h
+++ b/fs/nfsd/pnfs.h
@@ -35,6 +35,7 @@ struct nfsd4_layout_ops {
 			const struct nfsd4_layoutget *lgp);
 
 	__be32 (*proc_layoutcommit)(struct inode *inode,
+			struct svc_rqst *rqstp,
 			struct nfsd4_layoutcommit *lcp);
 
 	void (*fence_client)(struct nfs4_layout_stateid *ls,
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


