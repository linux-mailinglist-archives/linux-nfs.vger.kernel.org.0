Return-Path: <linux-nfs+bounces-14951-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D40BB654A
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 11:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C0B3BAB0E
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 09:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF1C2DCF50;
	Fri,  3 Oct 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVt6pl5U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D412D5426
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482688; cv=none; b=CONVOzyCnlQwcIpyyTWiEeVyuGhR8jSVPhBUzYtZuTltU6FOUWfsl8XAv8frsfVBJcmxzh/brrfnhK4RBebIGtCRchD5lMMn0tq1kGEfQ+TtqlEenJF6tFcR+szuyslRMhXtxOS6f2Fy5bZxcAwzBBnv4S5IejWmRyV6I1jRm8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482688; c=relaxed/simple;
	bh=4Q3QaDycZlayj+5emorjUsIeZOosRc/NtSQvzYPykDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZWL8BSGRLa6jSulmfRnQh+k70YIHguFpQRvuPhzTc7us6cFdozodT8+9/FiNZOkwqu7T3sG7E+u7iofbFaekGkUdlQpFNHXJirN85TA64FUbd1PdC0AO+8S0XuHXXHF66iNSJYC0fdmXNvOWPQsYAEMo2iHoiKggCblKwGsUvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVt6pl5U; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-373a1ab2081so16702971fa.3
        for <linux-nfs@vger.kernel.org>; Fri, 03 Oct 2025 02:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759482685; x=1760087485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eQrJ6U8zwJxNRHxnkX4GFTCD/jiPljD9W/O4v8njYs=;
        b=IVt6pl5UXE6PGHfSGbO+/hCZKaod176tZKEJaXBH0G2ru0SWWU8BSMLQFaZNEOPWT1
         s2ByQ9WKW3vxvOknLR7LTvtAiS9RDiR5kvp+tilyaXdxMQSBxbzRDt7W6NkHx+XpkvN1
         BU/jxVT2crmk74Lj6ITz/NwA8vjtNVAOV1FZseNLfB67MVISwx/evzMH6g7Lu2msWbn/
         kcgPKru/Dgg5/dYsxAQkrHbOCOGfvS8PvhDsSwClt1leOENe8bpbAm59qn2DsX1dHX62
         zZzGctG51V2OBr8kvQIuA1c+1m4BXiBLBpOqr6aWVTCQtjEdEdJ1EJOdKGEa1cpjeQq1
         Kv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759482685; x=1760087485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eQrJ6U8zwJxNRHxnkX4GFTCD/jiPljD9W/O4v8njYs=;
        b=DwJFC2+GT45qXn24sD0mo3roI/NE77f32N96wTNYBu4OB3GMpkNHS7sok19O5WwOAR
         068sn3kid00sZkVjLK5w9boro/u+QYPfta3Xw/B+djaZLdkXmxdYj+362NSoiWxEom58
         JJMsVyjGigcSQ+9hwgrdhWD6ggqFhfe8uWw/iot1C8iGm1UPVv9qbMV+b7RFrYiB8DyY
         GNwzjZiTlaxa17sswqkUZfn2p2AKN/5rfY5LWfJrvTGm2R2Q2HFVvUptZVLww3M2nGWD
         SFsRyn+c3mw8/cnVznlxe3yRfLHiHyoQ6nhcLGT+CvtRtNzis5TIkImJ22rOTjmdXiMP
         Gi/A==
X-Gm-Message-State: AOJu0YyV2Obg8gHpTvMnHYTmWuFTc6yIPyQ+jf+4YKPD500vTxKvWAEH
	gQgkwPed0RyPmlAtNon+K3d0TkfGZj1X5KlkrJSqvy2rAxhsUAVdIMeS
X-Gm-Gg: ASbGnctIDi0zHSQvY5fo3hXHucgqEEMiamvHMhXuFY22MSaNDwsg+GLshdHZ3UOPcVc
	cEL5ItNy+CT0yn1gaCo1Jih+36HAlCgqkkfamo8uljCziupl3nfB0LrVYuvJyB5+DMShtHo54j8
	k51FPwL4oqoWWil5I1UbuLV7wdniPxAJVBoL4tlT7USGEUA8uthQpt57EqqA3LqwiqJ9PpZWf69
	bRXans6pwhG7fsO1+Nav6juE8gxT/Kbvk3fYYiNKG6/8O86tAINzEBTkocNlNV+P4Zgp5qw727C
	+MnLpY5jVP1qJV8u68iHnUqC+K/syMWENE9/hdFUE+jmeI6nj8MqVoCHaIL2maiEkde53JprulG
	jWOf+ZeLA5ek1u2nlz2DTaUbhYfNXdmpAEXj/ZqJM1ofPSgHkaNUXDTj/3o7f4333lrihX7SFNq
	vY
X-Google-Smtp-Source: AGHT+IEwOBi8H8vI0VnTgYiKNK/rmJrnMUq9+SV+Hm3XBxJGlKzU1nvTZo6tqvELeVVre05Nb9QfRg==
X-Received: by 2002:a2e:bc8c:0:b0:337:e5fc:d2d with SMTP id 38308e7fff4ca-374c37eb3f8mr7161301fa.24.1759482684821;
        Fri, 03 Oct 2025 02:11:24 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([46.159.163.120])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba444480sm13498971fa.30.2025.10.03.02.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:11:24 -0700 (PDT)
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
	Sergey Bashirov <sergeybashirov@gmail.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 3/4] NFSD/blocklayout: Introduce layout content structure
Date: Fri,  3 Oct 2025 12:11:05 +0300
Message-ID: <20251003091115.184075-4-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003091115.184075-1-sergeybashirov@gmail.com>
References: <20251003091115.184075-1-sergeybashirov@gmail.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


