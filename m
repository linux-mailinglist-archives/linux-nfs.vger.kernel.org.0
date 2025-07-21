Return-Path: <linux-nfs+bounces-13164-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AF0B0CAA4
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jul 2025 20:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015401AA029A
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jul 2025 18:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBB82E1C65;
	Mon, 21 Jul 2025 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1GQZWUe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3564689;
	Mon, 21 Jul 2025 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753123275; cv=none; b=KpGUsTwyf6cB5srLT7RErdXNRT6wjBONCq1ra0EjtDLYN0bBSdZcLw7kUxgaSpkCBICSUrqBwmJ+Yrp7yjY5LyDpdblkdu8/jPWHv7S1fOyIYtQmRBRvKjOVcQkQo5CIVtBv3foBbS6IDb30GYSeZ9T2taSXChPq+3z+EFG1L+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753123275; c=relaxed/simple;
	bh=X8RrdoGZJJ/ArrYT9sqHv1YcbRqlHhV9rd2oLa4bPCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwBDmaH7Y+/HzSaWNlQLgbzSRM5x9dN23nqpugEuzLEv1LD5vFQfqYzRKKrXRWydKjLZsY5LuvDi4jhJELTbtTy2kSEVUMKNiNo0NhmD2fcB25lbqVP/T3WWMAs5FYI7S4iL11lCFqdwE0CeC7gYPy/u+kURr815Tgom5Fqev70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1GQZWUe; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553c31542b1so4125028e87.2;
        Mon, 21 Jul 2025 11:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753123271; x=1753728071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bp1xgBus0eMI112J4jpW4b2/Rbf+tgsxUk4xlLf6Taw=;
        b=Y1GQZWUeUekhKkI79vpCLweASVAFcdZqwtRHel0ZLRukdxNyg/6vgbP63kNbBAA5LE
         ja9/OaUAbwdRmVezUzl466FhdAI4k3CF5Rpwt6hEeLd86ZqyPFCryN8BaHDzexo57fJ5
         XN10iG3nDo5+6mmdZ9rZKL4jleqU7vCYKruITHvbPM6PknXXZqHqF/mWu7m5Qj9E6Q5O
         8p42/NiIW37DaLPuCs6h20u03n4wDoFcrR7TbpIr8yH5DDLGSfjptPEbaX65usCU5Iyd
         TtJxHPEJoJTmzwg6X8E9WQ10jidd9MQWaxWWofC7xaP3pECgaj4Tmx+ZIkpsPDYDF05i
         9fWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753123271; x=1753728071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bp1xgBus0eMI112J4jpW4b2/Rbf+tgsxUk4xlLf6Taw=;
        b=H7Z4cHKUUXZn9gjiA6PJ7N8UXHW54zEpf1n5wZ97U2zw1dM8jqIKsZ9Z9D9b0nLjhQ
         ywnyrnC6ICSOpcdfefxVnfIoV1Tfnsm5UQmx+I4BE4Wy5youXUcZgb8z+XWTWo/lqttY
         HB7rSCBkoLgZYY1puTJ/xglUDTXGNJl1mNuhlVd9EPJdhVHax265V0Eozu0HX62AyTI/
         A7LSzdjOrioz4Jo4uxpCeD8LPqsz0rS1HWz4MunsjemckVECUgeMW9QUpM1CNswtJY+J
         J84Pa2kGy5NzTIIWkXz1b72rFWpe4wXJoYJAa3kZQBd6uuWuWqP5vhph1LgD3k1K/5LP
         +3gg==
X-Forwarded-Encrypted: i=1; AJvYcCV4zTZJiOfyc1KR1wYufbl/aQGcJqN1AMkexY17yqUTwFiIo/Vlz6ExtnhVqVGIHfj2SJE+4d91bM9bWUw=@vger.kernel.org, AJvYcCXu8b0Pw5ksTTmNr792TKVmi8n9FDP71oZMGjvL3IvqGNhTK5Bq14ehl+RcoOlLq8WA24Flne1u4gCW@vger.kernel.org
X-Gm-Message-State: AOJu0YziyHeSrcPrszpTMCYJW08M8EQAe0KxLOlgLamIUNxsmO1e+7b5
	1Po+YGo43PrCdThC3ZvxSbxj4EmQCXWr7iMLCtk6qgqLbXLQt2HNfSgv
X-Gm-Gg: ASbGncuxW5F5Zzt683iZztH4YwyP4ROGcBFjHUCcmYvl+QON3J6a+dH6GqbMhKA/cRR
	MVfqqSJKd8wru2wyJw89ZhfB3iC5EMf9lV/MLJNOusoq+ImWS5Ogmr2rOw7TCxoJW6d+qzYb2s6
	pMgivbDfR986Yv5M1JkRMrOMTBQicES9XUVzNzCmu7VACE2UyThTBRRhKEZ4aVdNnLAa/GKRVkG
	Xf+A6FR78sLBw4DZxpx4NqTNXNvawP2KkaLe0AdAv88nQoMS1z5KxJbu9vQOyy/+R6W+QJnVuc7
	zsIB4HU/RKWlQFJYITPxM+idGZmNq/XIjK8E6LMRJyXwB0Eog/7LMxar5w6uUsD7lo7vq87M/ub
	qxGXJYMH3eynWTzHH9nRuEhYVq/EU1Lts1vkjUflQv9nINE0M
X-Google-Smtp-Source: AGHT+IHePJa5GnmkstS+XqiEhPBXkefRbSRHn5uMcwmlefXBCcychKy7ciNs5HiA9wFt4LDh1sLE/Q==
X-Received: by 2002:ac2:5682:0:b0:553:2698:99c5 with SMTP id 2adb3069b0e04-55a23f723dbmr6264326e87.39.1753123271324;
        Mon, 21 Jul 2025 11:41:11 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.122.38])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a910546bsm14116661fa.42.2025.07.21.11.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 11:41:11 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: [PATCH 1/2] NFSD: Implement large extent array support in pNFS
Date: Mon, 21 Jul 2025 21:40:55 +0300
Message-ID: <20250721184105.137015-2-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721184105.137015-1-sergeybashirov@gmail.com>
References: <20250721184105.137015-1-sergeybashirov@gmail.com>
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfsd/blocklayout.c    | 20 ++++++----
 fs/nfsd/blocklayoutxdr.c | 83 +++++++++++++++++++++++++++-------------
 fs/nfsd/blocklayoutxdr.h |  4 +-
 fs/nfsd/nfs4proc.c       |  2 +-
 fs/nfsd/nfs4xdr.c        | 11 +++---
 fs/nfsd/pnfs.h           |  1 +
 fs/nfsd/xdr4.h           |  3 +-
 7 files changed, 78 insertions(+), 46 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 19078a043e85c..4c936132eb440 100644
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
+	rqstp->rq_arg = lcp->lc_up_layout;
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
+	rqstp->rq_arg = lcp->lc_up_layout;
+	svcxdr_init_decode(rqstp);
+
+	nfserr = nfsd4_scsi_decode_layoutupdate(&rqstp->rq_arg_stream,
+			&iomaps, &nr_iomaps, i_blocksize(inode));
 	if (nfserr != nfs_ok)
 		return nfserr;
 
diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index 18de37ff28916..e50afe3407371 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -113,8 +113,7 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 
 /**
  * nfsd4_block_decode_layoutupdate - decode the block layout extent array
- * @p: pointer to the xdr data
- * @len: number of bytes to decode
+ * @xdr: subbuf set to the encoded array
  * @iomapp: pointer to store the decoded extent array
  * @nr_iomapsp: pointer to store the number of extents
  * @block_size: alignment of extent offset and length
@@ -127,25 +126,24 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
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
 
-	if (len < sizeof(u32))
-		return nfserr_bad_xdr;
-	len -= sizeof(u32);
-	if (len % PNFS_BLOCK_EXTENT_SIZE)
+	if (xdr_stream_decode_u32(xdr, &nr_iomaps))
 		return nfserr_bad_xdr;
 
-	nr_iomaps = be32_to_cpup(p++);
-	if (nr_iomaps != len / PNFS_BLOCK_EXTENT_SIZE)
+	len = sizeof(__be32) + xdr_stream_remaining(xdr);
+	expected = sizeof(__be32) + nr_iomaps * PNFS_BLOCK_EXTENT_SIZE;
+	if (len != expected)
 		return nfserr_bad_xdr;
 
 	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
@@ -155,21 +153,44 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	for (i = 0; i < nr_iomaps; i++) {
 		struct pnfs_block_extent bex;
 
-		p = svcxdr_decode_deviceid4(p, &bex.vol_id);
-		p = xdr_decode_hyper(p, &bex.foff);
+		if (nfsd4_decode_deviceid4(xdr, &bex.vol_id)) {
+			nfserr = nfserr_bad_xdr;
+			goto fail;
+		}
+
+		if (xdr_stream_decode_u64(xdr, &bex.foff)) {
+			nfserr = nfserr_bad_xdr;
+			goto fail;
+		}
 		if (bex.foff & (block_size - 1)) {
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
+			nfserr = nfserr_inval;
 			goto fail;
 		}
 
@@ -182,13 +203,12 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
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
@@ -200,21 +220,22 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
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
 
-	if (len < sizeof(u32))
+	if (xdr_stream_decode_u32(xdr, &nr_iomaps))
 		return nfserr_bad_xdr;
 
-	nr_iomaps = be32_to_cpup(p++);
+	len = sizeof(__be32) + xdr_stream_remaining(xdr);
 	expected = sizeof(__be32) + nr_iomaps * PNFS_SCSI_RANGE_SIZE;
 	if (len != expected)
 		return nfserr_bad_xdr;
@@ -226,14 +247,22 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	for (i = 0; i < nr_iomaps; i++) {
 		u64 val;
 
-		p = xdr_decode_hyper(p, &val);
+		if (xdr_stream_decode_u64(xdr, &val)) {
+			nfserr = nfserr_bad_xdr;
+			goto fail;
+		}
 		if (val & (block_size - 1)) {
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
+			nfserr = nfserr_inval;
 			goto fail;
 		}
 		iomaps[i].length = val;
@@ -244,5 +273,5 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	return nfs_ok;
 fail:
 	kfree(iomaps);
-	return nfserr_inval;
+	return nfserr;
 }
diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
index 15b3569f3d9ad..7d25ef689671f 100644
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
index 04b8856d06157..656b2e7d88407 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2520,7 +2520,7 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 		lcp->lc_size_chg = false;
 	}
 
-	nfserr = ops->proc_layoutcommit(inode, lcp);
+	nfserr = ops->proc_layoutcommit(inode, rqstp, lcp);
 	nfs4_put_stid(&ls->ls_stid);
 out:
 	return nfserr;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index cbbb61fcdd499..8b68f74a8cf08 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -592,6 +592,8 @@ static __be32
 nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
 			   struct nfsd4_layoutcommit *lcp)
 {
+	u32 len;
+
 	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_layout_type) < 0)
 		return nfserr_bad_xdr;
 	if (lcp->lc_layout_type < LAYOUT_NFSV4_1_FILES)
@@ -599,13 +601,10 @@ nfsd4_decode_layoutupdate4(struct nfsd4_compoundargs *argp,
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
index 925817f669176..dfd411d1f363f 100644
--- a/fs/nfsd/pnfs.h
+++ b/fs/nfsd/pnfs.h
@@ -35,6 +35,7 @@ struct nfsd4_layout_ops {
 			const struct nfsd4_layoutget *lgp);
 
 	__be32 (*proc_layoutcommit)(struct inode *inode,
+			struct svc_rqst *rqstp,
 			struct nfsd4_layoutcommit *lcp);
 
 	void (*fence_client)(struct nfs4_layout_stateid *ls,
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index e65b552bf5f5a..d4b48602b2b0c 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -664,8 +664,7 @@ struct nfsd4_layoutcommit {
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


