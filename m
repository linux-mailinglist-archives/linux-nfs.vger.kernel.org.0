Return-Path: <linux-nfs+bounces-14919-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89014BB520A
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Oct 2025 22:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D14484E6B8C
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Oct 2025 20:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D7C299AAF;
	Thu,  2 Oct 2025 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksl+zng1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204D52980A8
	for <linux-nfs@vger.kernel.org>; Thu,  2 Oct 2025 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759437098; cv=none; b=lvgY/00Vn4Q/nJRGet7Y/vPGuGfitgBQ0ItC6k3DzyhCE5MeEtC35Yrm1DUz8rNjEhYlvElsYkDmxQD6z9yNO3sPFeHh5vJFNVVgzex6UbonfihxZ29t00JL8UERtlVEJ12/8z+sT6xFqKH/o4G20B7mOQ3Lbjl4yDeZjfSo0ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759437098; c=relaxed/simple;
	bh=I6rdzfWZcPvJgyeOvLi+c+eLBQbKBQcDt5Nq6d7BpO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feRTPTpKBy7u4mYfZIXWi4KZk6X75J0j747lei97/y2y0dbNHArsYQg6tfomSvV+PE9K7/NKqQc6vNjbzfXUpJrHjcNOglilbWAEFzmavfF2GMU4GVzjgMN380opw6wwWQ/FHxdcEmKgGofV7kXx6KlGWQOfYslRCzDBeUgdnV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksl+zng1; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso1983632e87.1
        for <linux-nfs@vger.kernel.org>; Thu, 02 Oct 2025 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759437094; x=1760041894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URqcz1PqBiajUpbWyyVEtzMSrXQenRBULzsl914p9Po=;
        b=ksl+zng1u11CfgZoTQqtSDgDfh/TYHHl5AEaVeayb5Me6Lf985cacFKHfcfHf6fn0E
         W/nM58KgR6t0SqBbPNQAl+tFBpQJla0yB9A7FomQSY+w2hLTzIviiN+8fGW0Zni0E4jj
         /WJcJiZtsfL6cqjWUR70ckco7bsc4OAj2QVYAt/8ix+dROslb4CFC+dgdEWdiEDNRQF0
         5H0cuWcziVv070KWTcGSP9dWi7GACriPdvft7NmLYaLPpP28hDGsXC5fVFZwWVY16b7Y
         SftGDf33haxBNuO3N1YAiPRsZsC8nm559VyBO6wHrlUHsMJJToBne5V4W+mQfVg+aFPo
         C+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759437094; x=1760041894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URqcz1PqBiajUpbWyyVEtzMSrXQenRBULzsl914p9Po=;
        b=RIm9Dql/cRFCBODFRaLy47PwS2ObU3J9GG559hlq3tK79O0oNRzTQL+6GKqJi4Ansf
         Azx4HVvVyN38sFdGZ57nN2g9ZHjX6W7FJraSkjrCgDHqxwhiS7b4xh0o30gvxmLzg33X
         skPfhlGqVYbk7OX7KRapJ/xsy9yilXp4zQAz+NOgi42zo92fIKYhicFqVf2PdlYTx0aM
         3/3ZJvCw2T8P8f/G0QYjQ5nB6gOcrsPrYGgxAFt8/Z06NF6UyN8dkUWVzDht5DPTj/B1
         7e1BS7oFXPmZpx17F7Bp4bJ8MTWcc/mPbWbNaXcgt9vVjdo5K+RBfMiX32PbuUA2JW8b
         6q+w==
X-Gm-Message-State: AOJu0Yx9iQx77STzaPlCmUwNJv4UlSD372cUOm5KbLbbIue/T79XcLnD
	p4TuuV5+RbdbMUfhNw72rMwVrg3lIUVV7FK0TLoza/a0puYe/Ibw5K/6
X-Gm-Gg: ASbGncsnRJws80F/NXyql928LtcD8wi2lMidugm9P9cMxpNJ7lt9OuhjIZu633jzQNd
	pWbHZ1I58dl8Q42Og9+o7J9av1BR4CfBvyFSJL5Dly7GWi6NMDjARTpO4LzE+U2yKcd/IOLY9/r
	Ztxh7s0IBlIlA3zyuB4/Hnr5HQE4oDKKWIEWK6dxHQRAbvwiw52+WAuib5nn6EpvP6Di/Pay8og
	3qtdxE+0MIHoxl/DttR4+YT3A4fxJB6BKPmMghj0qBL5uuPq8hWSmM+iaaq1hFXaBrpxmBOCdFy
	IDJrLkbz5d6hBywZTWNn/uWHhveQTr7MfBfmQzhp4ixKXcIcYHyL1mpZAVp1UhEbVl3GjZJQBmH
	R35PIGjM0BdFgG3vllgZy6vb20n2Cg9yhPjP4skADnaYWP+Tq0cm7E8fGRJI2s/n8NWhBfjksEj
	2Z
X-Google-Smtp-Source: AGHT+IHWKAwAUfJW+XD+5V5RcRh9IVpwmdya52Ikx8ywWGkiirBkd8RMVHMZ7lX5+YUZDXR0SH0zSQ==
X-Received: by 2002:a05:6512:1322:b0:57d:77a1:715d with SMTP id 2adb3069b0e04-58cbb4417d0mr145968e87.32.1759437094010;
        Thu, 02 Oct 2025 13:31:34 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.163.120])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113f3ddsm1127316e87.52.2025.10.02.13.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:31:33 -0700 (PDT)
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
Subject: [PATCH v2 3/4] NFSD/blocklayout: Introduce layout content structure
Date: Thu,  2 Oct 2025 23:31:13 +0300
Message-ID: <20251002203121.182395-4-sergeybashirov@gmail.com>
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

Add a layout content structure instead of a single extent. The ability
to store and encode an array of extents is then used to implement support
for multiple extents per LAYOUTGET.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfsd/blocklayout.c    | 26 ++++++++++++++++++++++----
 fs/nfsd/blocklayoutxdr.c | 36 +++++++++++++++++++++++++++---------
 fs/nfsd/blocklayoutxdr.h | 14 ++++++++++++++
 3 files changed, 63 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 35a95501db63..6d29ea5e8623 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -88,9 +88,10 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
 {
 	struct nfsd4_layout_seg *seg = &args->lg_seg;
+	struct pnfs_block_layout *bl;
 	struct pnfs_block_extent *bex;
 	u64 length;
-	u32 block_size = i_blocksize(inode);
+	u32 nr_extents_max = 1, block_size = i_blocksize(inode);
 	__be32 nfserr;
 
 	if (locks_in_grace(SVC_NET(rqstp)))
@@ -102,16 +103,33 @@ nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
 		goto out_error;
 	}
 
+	/*
+	 * RFC 8881, section 3.3.17:
+	 *   The layout4 data type defines a layout for a file.
+	 *
+	 * RFC 8881, section 18.43.3:
+	 *   The loga_maxcount field specifies the maximum layout size
+	 *   (in bytes) that the client can handle. If the size of the
+	 *   layout structure exceeds the size specified by maxcount,
+	 *   the metadata server will return the NFS4ERR_TOOSMALL error.
+	 */
+	nfserr = nfserr_toosmall;
+	if (args->lg_maxcount < PNFS_BLOCK_LAYOUT4_SIZE +
+				PNFS_BLOCK_EXTENT_SIZE)
+		goto out_error;
+
 	/*
 	 * Some clients barf on non-zero block numbers for NONE or INVALID
 	 * layouts, so make sure to zero the whole structure.
 	 */
 	nfserr = nfserrno(-ENOMEM);
-	bex = kzalloc(sizeof(*bex), GFP_KERNEL);
-	if (!bex)
+	bl = kzalloc(struct_size(bl, extents, nr_extents_max), GFP_KERNEL);
+	if (!bl)
 		goto out_error;
-	args->lg_content = bex;
+	bl->nr_extents = nr_extents_max;
+	args->lg_content = bl;
 
+	bex = &bl->extents[0];
 	nfserr = nfsd4_block_map_extent(inode, fhp, seg->offset, seg->length,
 			seg->iomode, args->lg_minlength, bex);
 	if (nfserr != nfs_ok)
diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index e50afe340737..196ef4245604 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -14,12 +14,25 @@
 #define NFSDDBG_FACILITY	NFSDDBG_PNFS
 
 
+/**
+ * nfsd4_block_encode_layoutget - encode block/scsi layout extent array
+ * @xdr: stream for data encoding
+ * @lgp: layoutget content, actually an array of extents to encode
+ *
+ * Encode the opaque loc_body field in the layoutget response. Since the
+ * pnfs_block_layout4 and pnfs_scsi_layout4 structures on the wire are
+ * the same, this function is used by both layout drivers.
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
index 7d25ef689671..2e0c6c7d2b42 100644
--- a/fs/nfsd/blocklayoutxdr.h
+++ b/fs/nfsd/blocklayoutxdr.h
@@ -8,6 +8,15 @@
 struct iomap;
 struct xdr_stream;
 
+/* On the wire size of the layout4 struct with zero number of extents */
+#define PNFS_BLOCK_LAYOUT4_SIZE \
+	(sizeof(__be32) * 2 +	/* offset4 */ \
+	 sizeof(__be32) * 2 +	/* length4 */ \
+	 sizeof(__be32) +	/* layoutiomode4 */ \
+	 sizeof(__be32) +	/* layouttype4 */ \
+	 sizeof(__be32) +	/* number of bytes */ \
+	 sizeof(__be32))	/* number of extents */
+
 struct pnfs_block_extent {
 	struct nfsd4_deviceid		vol_id;
 	u64				foff;
@@ -21,6 +30,11 @@ struct pnfs_block_range {
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


