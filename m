Return-Path: <linux-nfs+bounces-14303-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F0AB538AC
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 18:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C686E7AB7C1
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 16:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EE11A83F9;
	Thu, 11 Sep 2025 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO0ruPj5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0B38DD3
	for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606539; cv=none; b=dr9HtV3DHRapRnbbLo8YjRP2G+KzFnMvQZxegcJer6Az3FQHMTniHHDCTuNV5aInPofWudcY/dpc/vk2LskMJFl26jgLhxaPcJymmKjrJO8Nb7nrgj4UeQK+9A2OKJG0v0XhgKKN0mR+6+rQR7mlCNbgBzxsVHgYpApAo8gC0rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606539; c=relaxed/simple;
	bh=ja4l6tQHfNpkMCIta8k4I1ropneqlWhPUSRbmS5G/VY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Svn/c/dbVDQAo1yqNGHFAD5M9g1SDeQMw8eiI98pTIJROv0xM+yHzilew/u8rUxyOWfh5feQsUWKeoQvsz29PT5/lkT94KVXsIuXi25v2/sjnoMk27gjNKnT84bJ/Uhzz94fS0HrzVdaSkXsuMgiLnSkla8cyucMBr5sYveTtz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fO0ruPj5; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-336ce4a894cso7588701fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757606535; x=1758211335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oQ80rsevTEAVCbWvfZ4aYNxV0MEBLVr92nhBL/c8nOE=;
        b=fO0ruPj5eWk9Oknl7XtM+NmN6HbLHuWwgnJXXHO63rrHfcRlkgWaQaRkEuWmyYXv9+
         ELIbtKc5noQKZYf9mD46OIRB80013VYbZmHi+G1b3a+QGCj4sWeZI9mfbsgpcZKjIPQC
         rA3Iq/IYMGIEnTp5UFYY5wpF9oGQLvGJsn7JZ7LB9MrDoaeSEcwouglnQ0Y2KQkN3LE2
         1IACzvPFuh43dpax9PAaA72J/nSgawOMOkxdeXaA+SsmMBr8O3+5eT7B1bx+wPa7syK9
         Gg+DMbirt+wIpFzolDGNbOkVTiu1eSLBiRyA1KeATqSV3uYCvUS0CODmfa1dzcFXHODm
         ++Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757606535; x=1758211335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQ80rsevTEAVCbWvfZ4aYNxV0MEBLVr92nhBL/c8nOE=;
        b=O1ajwRbY3kkOj7naGHf/+SUKEwoU8fGAWwFi+OOV2QxW3Ux590B6rObifbsay+ilDo
         3e3/EbCV73vzySRfK8nbfRnd6iU7kF2sOIHvVeodZX2bAfiDudh7QAo3cqcjpst+wkdv
         Nk66Hd9tGgzCiOclNPFlekffkjdnm7wDpLo4XNUFQJ+94lg6Z2uw2XSXqWwTt0Tw0xut
         wyJze3fD8L8ijYTe035ao6oWCTOzll8pzKOECLDA+o2Bb5iBbGuWvv/Q8OjUEr69BoOC
         vBmrYqScIo8dPR7oWWsSfZd9SGE0N0x731sGr3yIBLOEhSCuuYxVjFeZ44qPDTnEEoON
         15DQ==
X-Gm-Message-State: AOJu0YzMDcaSar85N7PNnYxzOywA9gQ8owUg2LfFkD1un4oGIDxblbVu
	hr8g+33Z2ywDCckMZ3KAxuPoSAX3vZPpUSD0S2I0T4NcPBfYNFFWXEiy
X-Gm-Gg: ASbGncv5xxxa85rXJWy2D4pwpAOTguwym7b1UR5BpLo7hQFe5tZq47FZCoWERfUDaKU
	ihUDly7vcGpx5Hi7o0JIlqhuTf7r43GJqmX56U09PT3xods6cx69EzFN/22N8ijvAy1yWvSSQOm
	+1ABEMXPkPZSf1fSOporih5Zh0QAqqBWPVek3u1+uO5IBJv8eVLIYZJ3mk9kV7vcPkZE18bhHrt
	kI9aEXrL2rpcguacaIIyK8H5SzVKIfijipjazH/tkOxpvApbPBZ8aEA5RL5ESVUEoNhd2W6D9zf
	wrpgAD8D+MhuJZI9jlW74QUsK9EpzIHXj3d0o7Kf2lyGXNGgTBOh3rdW+2jAx+C14TZchCL1DS1
	P96KRFUbxmX0feEUtI2PkEWdkcRWGDfse1UobldFRxF7axTohW5D3uKAUU4GsHA==
X-Google-Smtp-Source: AGHT+IHYvj7C7RKH/yw36gpiv3e48n0trxYj+pXjOfSK/8iAC0HvWSRW3yA1g5uSHLrEwZ5uSoRcKQ==
X-Received: by 2002:a05:651c:221a:b0:350:adaa:6b93 with SMTP id 38308e7fff4ca-350adaa6d49mr1966491fa.6.1757606534880;
        Thu, 11 Sep 2025 09:02:14 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.148.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1a820665sm3381581fa.33.2025.09.11.09.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 09:02:14 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH] NFSD: Impl multiple extents in block/scsi layoutget
Date: Thu, 11 Sep 2025 19:02:03 +0300
Message-ID: <20250911160208.69086-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch allows the pNFS server to respond with multiple extents
in a layoutget request. As a result, the number of layoutget requests
is significantly reduced for various file access patterns, including
random and parallel writes, avoiding unnecessary load to the server.
On the client side, this improves the performance of writing large
files and allows requesting layouts with minimum length greater than
PAGE_SIZE.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
Checked with smatch, tested on pNFS block volume setup.

 fs/nfsd/blocklayout.c    | 167 +++++++++++++++++++++++++++++----------
 fs/nfsd/blocklayoutxdr.c |  36 ++++++---
 fs/nfsd/blocklayoutxdr.h |   5 ++
 3 files changed, 157 insertions(+), 51 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index fde5539cf6a6..d53f3ec8823a 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -17,48 +17,39 @@
 #define NFSDDBG_FACILITY	NFSDDBG_PNFS
 
 
+/**
+ * nfsd4_block_map_extent - get extent that covers the start of segment
+ * @inode: inode of the file requested by the client
+ * @fhp: handle of the file requested by the client
+ * @seg: layout subrange requested by the client
+ * @minlength: layout min length requested by the client
+ * @bex: output block extent structure
+ *
+ * Get an extent from the file system that starts at @seg->offset or below,
+ * but may be shorter than @seg->length.
+ *
+ * Return values:
+ *   %nfs_ok: Success, @bex is initialized and valid
+ *   %nfserr_layoutunavailable: Failed to get extent for requested @seg
+ *   OS errors converted to NFS errors
+ */
 static __be32
-nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
-		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
+nfsd4_block_map_extent(struct inode *inode, const struct svc_fh *fhp,
+		const struct nfsd4_layout_seg *seg, u64 minlength,
+		struct pnfs_block_extent *bex)
 {
-	struct nfsd4_layout_seg *seg = &args->lg_seg;
 	struct super_block *sb = inode->i_sb;
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
 	error = sb->s_export_op->map_blocks(inode, seg->offset, seg->length,
 					    &iomap, seg->iomode != IOMODE_READ,
 					    &device_generation);
 	if (error) {
 		if (error == -ENXIO)
-			goto out_layoutunavailable;
-		goto out_error;
-	}
-
-	if (iomap.length < args->lg_minlength) {
-		dprintk("pnfsd: extent smaller than minlength\n");
-		goto out_layoutunavailable;
+			return nfserr_layoutunavailable;
+		return nfserrno(error);
 	}
 
 	switch (iomap.type) {
@@ -74,9 +65,9 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
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
@@ -93,27 +84,119 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
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
 
-	seg->offset = iomap.offset;
-	seg->length = iomap.length;
+/**
+ * nfsd4_block_map_segment - get extent array for the requested layout
+ * @inode: inode of the file requested by the client
+ * @fhp: handle of the file requested by the client
+ * @seg: layout range requested by the client
+ * @minlength: layout min length requested by the client
+ * @bl: output array of block extents
+ *
+ * Get an array of consecutive block extents that span the requested
+ * layout range. The resulting range may be shorter than requested if
+ * all preallocated block extents are used.
+ *
+ * Return values:
+ *   %nfs_ok: Success, @bl initialized and valid
+ *   %nfserr_layoutunavailable: Failed to get extents for requested @seg
+ *   OS errors converted to NFS errors
+ */
+static __be32
+nfsd4_block_map_segment(struct inode *inode, const struct svc_fh *fhp,
+		const struct nfsd4_layout_seg *seg, u64 minlength,
+		struct pnfs_block_layout *bl)
+{
+	struct nfsd4_layout_seg subseg = *seg;
+	u32 i;
+	__be32 nfserr;
 
-	dprintk("GET: 0x%llx:0x%llx %d\n", bex->foff, bex->len, bex->es);
-	return 0;
+	for (i = 0; i < bl->nr_extents; i++) {
+		struct pnfs_block_extent *extent = bl->extents + i;
+		u64 extent_len;
+
+		nfserr = nfsd4_block_map_extent(inode, fhp, &subseg,
+				minlength, extent);
+		if (nfserr != nfs_ok)
+			return nfserr;
+
+		extent_len = extent->len - (subseg.offset - extent->foff);
+		if (extent_len >= subseg.length) {
+			bl->nr_extents = i + 1;
+			return nfs_ok;
+		}
+
+		subseg.offset = extent->foff + extent->len;
+		subseg.length -= extent_len;
+	}
+
+	return nfs_ok;
+}
+
+static __be32
+nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
+		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
+{
+	struct nfsd4_layout_seg *seg = &args->lg_seg;
+	u64 seg_length;
+	struct pnfs_block_extent *first_bex, *last_bex;
+	struct pnfs_block_layout *bl;
+	u32 nr_extents_max = PAGE_SIZE / sizeof(bl->extents[0]) - 1;
+	u32 block_size = i_blocksize(inode);
+	__be32 nfserr;
+
+	if (locks_in_grace(SVC_NET(rqstp)))
+		return nfserr_grace;
+
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
+	bl = kzalloc(struct_size(bl, extents, nr_extents_max), GFP_KERNEL);
+	if (!bl)
+		goto out_error;
+	bl->nr_extents = nr_extents_max;
+	args->lg_content = bl;
+
+	nfserr = nfsd4_block_map_segment(inode, fhp, seg,
+			args->lg_minlength, bl);
+	if (nfserr != nfs_ok)
+		goto out_error;
+	first_bex = bl->extents;
+	last_bex = bl->extents + bl->nr_extents - 1;
+
+	nfserr = nfserr_layoutunavailable;
+	seg_length = last_bex->foff + last_bex->len - seg->offset;
+	if (seg_length < args->lg_minlength) {
+		dprintk("pnfsd: extent smaller than minlength\n");
+		goto out_error;
+	}
+
+	seg->offset = first_bex->foff;
+	seg->length = last_bex->foff - first_bex->foff + last_bex->len;
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
diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index e50afe340737..68c112d47cee 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -14,12 +14,25 @@
 #define NFSDDBG_FACILITY	NFSDDBG_PNFS
 
 
+/**
+ * nfsd4_block_encode_layoutget - encode block/scsi layout extent array
+ * @xdr: stream for data encoding
+ * @lgp: layoutget content, actually an array of extents to encode
+ *
+ * This function encodes the opaque loc_body field in the layoutget response.
+ * Since the pnfs_block_layout4 and pnfs_scsi_layout4 structures on the wire
+ * are the same, this function is used by both layout drivers.
+ *
+ * Return values:
+ *   %nfs_ok: Success, all extents encoded into @xdr
+ *   %nfserr_toosmall: Not enough space in @xdr to encode all the data
+ */
 __be32
 nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
 		const struct nfsd4_layoutget *lgp)
 {
-	const struct pnfs_block_extent *b = lgp->lg_content;
-	int len = sizeof(__be32) + 5 * sizeof(__be64) + sizeof(__be32);
+	const struct pnfs_block_layout *bl = lgp->lg_content;
+	u32 i, len = sizeof(__be32) + bl->nr_extents * PNFS_BLOCK_EXTENT_SIZE;
 	__be32 *p;
 
 	p = xdr_reserve_space(xdr, sizeof(__be32) + len);
@@ -27,14 +40,19 @@ nfsd4_block_encode_layoutget(struct xdr_stream *xdr,
 		return nfserr_toosmall;
 
 	*p++ = cpu_to_be32(len);
-	*p++ = cpu_to_be32(1);		/* we always return a single extent */
+	*p++ = cpu_to_be32(bl->nr_extents);
 
-	p = svcxdr_encode_deviceid4(p, &b->vol_id);
-	p = xdr_encode_hyper(p, b->foff);
-	p = xdr_encode_hyper(p, b->len);
-	p = xdr_encode_hyper(p, b->soff);
-	*p++ = cpu_to_be32(b->es);
-	return 0;
+	for (i = 0; i < bl->nr_extents; i++) {
+		const struct pnfs_block_extent *bex = bl->extents + i;
+
+		p = svcxdr_encode_deviceid4(p, &bex->vol_id);
+		p = xdr_encode_hyper(p, bex->foff);
+		p = xdr_encode_hyper(p, bex->len);
+		p = xdr_encode_hyper(p, bex->soff);
+		*p++ = cpu_to_be32(bex->es);
+	}
+
+	return nfs_ok;
 }
 
 static int
diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
index 7d25ef689671..54fe7f517a94 100644
--- a/fs/nfsd/blocklayoutxdr.h
+++ b/fs/nfsd/blocklayoutxdr.h
@@ -21,6 +21,11 @@ struct pnfs_block_range {
 	u64				len;
 };
 
+struct pnfs_block_layout {
+	u32				nr_extents;
+	struct pnfs_block_extent	extents[] __counted_by(nr_extents);
+};
+
 /*
  * Random upper cap for the uuid length to avoid unbounded allocation.
  * Not actually limited by the protocol.
-- 
2.43.0


