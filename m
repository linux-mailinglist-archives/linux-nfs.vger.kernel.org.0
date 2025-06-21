Return-Path: <linux-nfs+bounces-12613-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9B8AE2A63
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 18:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B1D168E27
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 16:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157A5221F24;
	Sat, 21 Jun 2025 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0+oiqH6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27B5221734;
	Sat, 21 Jun 2025 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750524876; cv=none; b=Pv0rzrYME1qegjf8E+kSNfrzpswWEC+ziQpLQoN+FswNjCZLJja2615+oLN3E8SjX7/R7fkrim7d1KUBm4Zzo7WT36jzwVcLXfOHwbrae/e8RvlFyVftOUGj6sOJWoNIGWUUxcMEuDM+RdU+iEei/BIrs3Ao4p64YJxtMzfk4es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750524876; c=relaxed/simple;
	bh=4eRVc6rD9gjdsfVqZ1QbtYGgtX/Zf/r3nDCJ7poTGks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hc70Of+bhS5ArFDH5yUtNIYouXMgWTWo/JYiuHHE9NIhuysv4ddr1iWa+N2qgWlhTFWMg/rGzB0803fH11SmsJC4y6XA2y9yJE2Z/GiXUGlBQtWgvfDGm0+uFlg9q7xk/IPxu7ljSnvGTWx2m069q850MNUvNZHg5bdHe35oHWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0+oiqH6; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b855b468bso26561021fa.3;
        Sat, 21 Jun 2025 09:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750524872; x=1751129672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsfz605PNjp0JEhM9uqqx3WrIgIqKxd7NBR6gmw6yM8=;
        b=Y0+oiqH6nrN7JVA4w519kttC+dNaPsGr8evlnsplHyydD0imxGHF/lwcnlPuDJZB8I
         nUsZ7X9tCNFxbHR8VUE3lzTQ724LpX/6arpjadyHWIqsusFqzVmrMWBbyuZ3kMgPAK4Y
         h0QNjj3tLPtwwuArf8TTuIMN2RGFsSkw2Po4wxaR7XwpewNUi7hTZ9JOC/jupsNDXPrW
         b3GGrgj/2DgStdK7TpvCn5lxVe+NH7m8uNvx/z8yLlLx5wCj48ZR/meGHhDN+La+N7Kg
         eOUeK0vO+bWPemo9ygIKN7CWC1X36hLtuIWXGl8yniQJ7XIQM9pVszU4VBlGCif6yvYc
         pT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750524872; x=1751129672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsfz605PNjp0JEhM9uqqx3WrIgIqKxd7NBR6gmw6yM8=;
        b=daK5DmHeMkZdawUE/uzccdiysZZzTq6S1zezYexbe4X68kDT113OmYp8onDdh9IF4W
         g9djfd9EHdRs37KksuWRJt+zOQXDNsTHX+pUiFN3+x4SzrIBURL6MROcnCB8u3W6DfJl
         muzvlc4ZW8j2VDR0iZ/wSxShWBT39m0Ki086xM5gcCzBUQSJU+3vU2vukUgoGW6rYmY/
         yksdCQwrG/lkQgM4iGbPcjYFUVY3OpnJmwObc3sUQzmgAmW8m7j/3Uvul2XzEIJPNgp1
         CAkF9TJ4NoLAKeVjzMle/kY08RypaiXZ2ryc9dS+dsXKkUE3Mx6R1qKUrbBN/Yon2RrS
         Jj2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZgNg74fl5dKstoTXaquXyCQp81AND11lwK0CReV/G56fr8qKs0+DnH7sDordFlXovQV1h+Zxx/neT0pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC3YDUZsbGrcy0BSSwO+XQd9chQdM4243Yxuc6tgYgdljSagki
	Zg08X/s9Ax7ol7wm/WK65+CJHS0/EC5K3Z3xVysyfAARQGZevioQYrAk
X-Gm-Gg: ASbGncukXCpXTuk9/QYYqC60d7A2pAR+t9UZ1bmuA/smFBX/cuXsCuoIxY0XsVDw102
	a7YFG+ESousE82V0T5vrAovjh2FiiBqaJOd+CF97otlcIdG6T+Zs85L3VAUVY8k0yxMd++XzV6h
	Jx8ciT0N3sS+E/UMXT/QIO+JI3APSq8o5JDLww2QBdAS29i27iZ5jgTVGgEiTbtbsY+bkQDlEuE
	sL4jqoHVux8faBbuWFk13JCBtwxw5yh75muJT/GXgyQA0bYb+9avfDQmSbvj60ZcPIWzjA2yK9i
	sBQ89QmXL6qm0pSj+7mvVswe5G2tu/qAdr7hWLSV347L6qWysUMBwhCcQOh08ksF1yE2GTp9K5e
	5Lq40x203M24DAZfr2DRsD8W0
X-Google-Smtp-Source: AGHT+IHjH7oKQ0Dl4+V8eGpNb1D6dr5yUp50yontXR8w4uysbdJR07IsvgUn1zWU/WGVB768hEuiEg==
X-Received: by 2002:a05:651c:553:b0:32c:a097:414b with SMTP id 38308e7fff4ca-32ca0974c6bmr1943811fa.19.1750524871763;
        Sat, 21 Jun 2025 09:54:31 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([85.174.201.55])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980c72ecsm6948661fa.84.2025.06.21.09.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 09:54:31 -0700 (PDT)
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
Subject: [PATCH v4 2/2] nfsd: Implement large extent array support in pNFS
Date: Sat, 21 Jun 2025 19:52:45 +0300
Message-ID: <20250621165409.147744-3-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621165409.147744-1-sergeybashirov@gmail.com>
References: <20250621165409.147744-1-sergeybashirov@gmail.com>
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
 fs/nfsd/blocklayout.c    | 20 ++++++----
 fs/nfsd/blocklayoutxdr.c | 86 +++++++++++++++++++++++++++-------------
 fs/nfsd/blocklayoutxdr.h |  4 +-
 fs/nfsd/nfs4proc.c       |  2 +-
 fs/nfsd/nfs4xdr.c        | 11 +++--
 fs/nfsd/pnfs.h           |  1 +
 fs/nfsd/xdr4.h           |  3 +-
 7 files changed, 80 insertions(+), 47 deletions(-)

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
index bcf21fde9120..266b2737882e 100644
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
@@ -128,25 +127,24 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
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
@@ -155,24 +153,48 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 
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
 
@@ -185,13 +207,12 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
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
@@ -203,21 +224,22 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
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
@@ -229,14 +251,22 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
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
@@ -247,5 +277,5 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
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


