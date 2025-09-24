Return-Path: <linux-nfs+bounces-14650-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB263B9ADBE
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 18:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF5A19C528C
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970F71C860E;
	Wed, 24 Sep 2025 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NxTVpyQG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9BE30CDAA
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730874; cv=none; b=io3zo1xOL2El0oun6mcPTgqgkiAJc8dFLFgGUsF94aBYyCQ1Gkx2PciqhWDSw4sMEuvokkHeHoNi35cNyFRbZHk6SxGBMJCuE6xhoU/CRq+bLn9Y8hrbS5IIFB+OyEaw3fhB58lifET0TeK9lDDAIama6a+cMhssyXHDanH13WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730874; c=relaxed/simple;
	bh=E6toPwqmDJkpFawV1tGmdkuMJo0mNgiQ12F34q4J2aI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U/ucBP72bwIDNf39TJ2Pu6sNSGJ5oSzD8R0m8xn4luSm+CpHwIT3BEoC7QkgdcPmKTV8mpZxtDFVn0ks3bTTySWaGRiw9wWz/C2AuMX1nTPCfkiMRLUmSbcP24Fdmg+w1Ih/6PmD5owpEmFTn5NrJ9knnGPl04XXQ+GGsyKOvzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NxTVpyQG; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62fa8d732daso11167586a12.3
        for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 09:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758730871; x=1759335671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DxqhLAwCPsv2k0UdKEGAo0Up8dCDuBhVt4kaJL6RGg=;
        b=NxTVpyQGMoh56lmF7fFy7bLJRAk4zQfNuL14VsJpIWVgWNhOesHPCatEuRXQdt7jih
         o5fatw6eYHwm7V4geplZSpaikN9/xJTs0mpesIfaqbZaQTzzWplUZ1BRT76totlt6lnd
         gNUbtF62Iy7UvR/+JjTYOFW4gBhLc+Gjz65hHMG6PXj7Gu1/sVetS5pQpLSU3qzinuYd
         RUeNp1Y24tltFTllU+FgxP1FSvy3XJ9HCTwsWmyyXMpKRcl3c2ewE7tGZQLDSTTRV96k
         3F1nj03nA8FdNe0x71jYEZkgoCudfM18I8iEO+785o45McoUVzjFhGEJyrh1zrQF2aiU
         OF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758730871; x=1759335671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DxqhLAwCPsv2k0UdKEGAo0Up8dCDuBhVt4kaJL6RGg=;
        b=qmd6Ai7AcNOSZ75aKBsWlx/cCXgEX6RrlBKpuJm5pe+D57wZGiRg23/dfy1g7VquoB
         aGZXd4b4ukUzWKIx44Ga0jcFwqCr78UzIVKG5/NbwfuNUxgXqURrrWpknkhrXADig4aJ
         Y0Zw7p3OJisUMV3h4qsgNIRB9EiZ3EZWk2mZbfiMZfb6MPXNjw9jrou/PbI9FUVNaqm1
         9G1ka1qrEwUMUe+GCBhShPFzSkOrDVKxqOuXyWTl1wSEBNNAwA81LDTGBGPfV0l2NU73
         67SbLwFdB1QfBVF5iwEvmZySbPVM2UOjaPssCRm2Tbyw1/CqtftL/1ELMtenezAP9SvV
         HtjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQdVRqFBGjFqYGRYNF5amIYQhjA6XtsMAZJ4D8lJtBXdIGWOPZyZVC+dLaVfqTvAHk1ZxP+vYva1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiQff1K+Td0RVyNIRaX3Pqx9QNtnd/OuIx6HdVLhfdjw07P4yo
	kt5OFd0IL7mozdkMZwyCFtJanl6FF1xIQz0Vs+ISss63Qw5qwJTCiqqTCoDWkx8pGaA=
X-Gm-Gg: ASbGncvd69F+ScAlGRVAsU3dp9zMCLK9l/OH0H8Od5dgQ5257kGZwQmAkqptagwwV5j
	elRKhMyeMMgmmT5CrUKW8EQAFpT9i3A0paGq0zt+uLJuw3lMonxkGmAw39LFNgOj+FxIuf2nK4G
	IA709OkSMW6Z/AbD/nqsBPmeOdA4DBsgwLhNfqDR6JGuzT20SvIZrchHsMGsKi1jRzvmy0YDs/T
	CnECAG0Y6yRekdn47p2qIcp3V7l6IPfmowdBwdjD4lGKUWitHPgAFDxmKfKV/iUkfQhEU6swAot
	bEdiLzvvZUKw2W0d5Ht70ZklbYwS/InTa5UqOTOqmBrDbUaUwZgUzrp9ogcakvw6Ps/qHMGEqsf
	lGDG6weuRgmXd2M/yH0ou71E=
X-Google-Smtp-Source: AGHT+IF5eY13bpgK/QrFFe2k/VMl8mKJJc9cRzB1oFXB00wdbi+gbMGCoPMRmm+jFhDt93B2AAM2ZQ==
X-Received: by 2002:a17:907:72d1:b0:b04:5b3d:c305 with SMTP id a640c23a62f3a-b34bac24387mr35326666b.17.1758730870924;
        Wed, 24 Sep 2025 09:21:10 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b27d7eeafc7sm1123140066b.86.2025.09.24.09.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 09:21:10 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v4 5/9] NFSv4/flexfiles: Read path updates for striped layouts
Date: Wed, 24 Sep 2025 16:20:46 +0000
Message-Id: <20250924162050.634451-6-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924162050.634451-1-jcurley@purestorage.com>
References: <20250924162050.634451-1-jcurley@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates read path to calculate and use dss_id to direct IO to the
appropriate stripe DS.

Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 122 ++++++++++++++++++++-----
 1 file changed, 98 insertions(+), 24 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index a2a3821f190c..79700c18762c 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -770,6 +770,7 @@ ff_layout_mark_ds_reachable(struct pnfs_layout_segment *lseg, u32 idx)
 static struct nfs4_pnfs_ds *
 ff_layout_choose_ds_for_read(struct pnfs_layout_segment *lseg,
 			     u32 start_idx, u32 *best_idx,
+			     u32 offset, u32 *dss_id,
 			     bool check_device)
 {
 	struct nfs4_ff_layout_segment *fls = FF_LAYOUT_LSEG(lseg);
@@ -780,12 +781,16 @@ ff_layout_choose_ds_for_read(struct pnfs_layout_segment *lseg,
 	/* mirrors are initially sorted by efficiency */
 	for (idx = start_idx; idx < fls->mirror_array_cnt; idx++) {
 		mirror = FF_LAYOUT_COMP(lseg, idx);
-		ds = nfs4_ff_layout_prepare_ds(lseg, mirror, 0, false);
+		*dss_id = nfs4_ff_layout_calc_dss_id(
+			fls->stripe_unit,
+			fls->mirror_array[idx]->dss_count,
+			offset);
+		ds = nfs4_ff_layout_prepare_ds(lseg, mirror, *dss_id, false);
 		if (!ds)
 			continue;
 
 		if (check_device &&
-		    nfs4_test_deviceid_unavailable(&mirror->dss[0].mirror_ds->id_node))
+		    nfs4_test_deviceid_unavailable(&mirror->dss[*dss_id].mirror_ds->id_node))
 			continue;
 
 		*best_idx = idx;
@@ -797,42 +802,52 @@ ff_layout_choose_ds_for_read(struct pnfs_layout_segment *lseg,
 
 static struct nfs4_pnfs_ds *
 ff_layout_choose_any_ds_for_read(struct pnfs_layout_segment *lseg,
-				 u32 start_idx, u32 *best_idx)
+				 u32 start_idx, u32 *best_idx,
+				 u32 offset, u32 *dss_id)
 {
-	return ff_layout_choose_ds_for_read(lseg, start_idx, best_idx, false);
+	return ff_layout_choose_ds_for_read(lseg, start_idx, best_idx,
+					    offset, dss_id, false);
 }
 
 static struct nfs4_pnfs_ds *
 ff_layout_choose_valid_ds_for_read(struct pnfs_layout_segment *lseg,
-				   u32 start_idx, u32 *best_idx)
+				   u32 start_idx, u32 *best_idx,
+				   u32 offset, u32 *dss_id)
 {
-	return ff_layout_choose_ds_for_read(lseg, start_idx, best_idx, true);
+	return ff_layout_choose_ds_for_read(lseg, start_idx, best_idx,
+					    offset, dss_id, true);
 }
 
 static struct nfs4_pnfs_ds *
 ff_layout_choose_best_ds_for_read(struct pnfs_layout_segment *lseg,
-				  u32 start_idx, u32 *best_idx)
+				  u32 start_idx, u32 *best_idx,
+				  u32 offset, u32 *dss_id)
 {
 	struct nfs4_pnfs_ds *ds;
 
-	ds = ff_layout_choose_valid_ds_for_read(lseg, start_idx, best_idx);
+	ds = ff_layout_choose_valid_ds_for_read(lseg, start_idx, best_idx,
+						offset, dss_id);
 	if (ds)
 		return ds;
-	return ff_layout_choose_any_ds_for_read(lseg, start_idx, best_idx);
+	return ff_layout_choose_any_ds_for_read(lseg, start_idx, best_idx,
+						offset, dss_id);
 }
 
 static struct nfs4_pnfs_ds *
 ff_layout_get_ds_for_read(struct nfs_pageio_descriptor *pgio,
-			  u32 *best_idx)
+			  u32 *best_idx,
+			  u32 offset,
+			  u32 *dss_id)
 {
 	struct pnfs_layout_segment *lseg = pgio->pg_lseg;
 	struct nfs4_pnfs_ds *ds;
 
 	ds = ff_layout_choose_best_ds_for_read(lseg, pgio->pg_mirror_idx,
-					       best_idx);
+					       best_idx, offset, dss_id);
 	if (ds || !pgio->pg_mirror_idx)
 		return ds;
-	return ff_layout_choose_best_ds_for_read(lseg, 0, best_idx);
+	return ff_layout_choose_best_ds_for_read(lseg, 0, best_idx,
+						 offset, dss_id);
 }
 
 static void
@@ -851,6 +866,56 @@ ff_layout_pg_get_read(struct nfs_pageio_descriptor *pgio,
 	}
 }
 
+static bool
+ff_layout_lseg_is_striped(const struct nfs4_ff_layout_segment *fls)
+{
+	return fls->mirror_array[0]->dss_count > 1;
+}
+
+/*
+ * ff_layout_pg_test(). Called by nfs_can_coalesce_requests()
+ *
+ * Return 0 if @req cannot be coalesced into @pgio, otherwise return the number
+ * of bytes (maximum @req->wb_bytes) that can be coalesced.
+ */
+static size_t
+ff_layout_pg_test(struct nfs_pageio_descriptor *pgio, struct nfs_page *prev,
+		  struct nfs_page *req)
+{
+	unsigned int size;
+	u64 p_stripe, r_stripe;
+	u32 stripe_offset;
+	u64 segment_offset = pgio->pg_lseg->pls_range.offset;
+	u32 stripe_unit = FF_LAYOUT_LSEG(pgio->pg_lseg)->stripe_unit;
+
+	/* calls nfs_generic_pg_test */
+	size = pnfs_generic_pg_test(pgio, prev, req);
+	if (!size)
+		return 0;
+	else if (!ff_layout_lseg_is_striped(FF_LAYOUT_LSEG(pgio->pg_lseg)))
+		return size;
+
+	/* see if req and prev are in the same stripe */
+	if (prev) {
+		p_stripe = (u64)req_offset(prev) - segment_offset;
+		r_stripe = (u64)req_offset(req) - segment_offset;
+		do_div(p_stripe, stripe_unit);
+		do_div(r_stripe, stripe_unit);
+
+		if (p_stripe != r_stripe)
+			return 0;
+	}
+
+	/* calculate remaining bytes in the current stripe */
+	div_u64_rem((u64)req_offset(req) - segment_offset,
+			stripe_unit,
+			&stripe_offset);
+	WARN_ON_ONCE(stripe_offset > stripe_unit);
+	if (stripe_offset >= stripe_unit)
+		return 0;
+	return min(stripe_unit - (unsigned int)stripe_offset, size);
+}
+
 static void
 ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 			struct nfs_page *req)
@@ -858,7 +923,7 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 	struct nfs_pgio_mirror *pgm;
 	struct nfs4_ff_layout_mirror *mirror;
 	struct nfs4_pnfs_ds *ds;
-	u32 ds_idx;
+	u32 ds_idx, dss_id;
 
 	if (NFS_SERVER(pgio->pg_inode)->flags &
 			(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR))
@@ -879,7 +944,8 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 	/* Reset wb_nio, since getting layout segment was successful */
 	req->wb_nio = 0;
 
-	ds = ff_layout_get_ds_for_read(pgio, &ds_idx);
+	ds = ff_layout_get_ds_for_read(pgio, &ds_idx,
+				       req_offset(req), &dss_id);
 	if (!ds) {
 		if (!ff_layout_no_fallback_to_mds(pgio->pg_lseg))
 			goto out_mds;
@@ -891,7 +957,7 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 
 	mirror = FF_LAYOUT_COMP(pgio->pg_lseg, ds_idx);
 	pgm = &pgio->pg_mirrors[0];
-	pgm->pg_bsize = mirror->dss[0].mirror_ds->ds_versions[0].rsize;
+	pgm->pg_bsize = mirror->dss[dss_id].mirror_ds->ds_versions[0].rsize;
 
 	pgio->pg_mirror_idx = ds_idx;
 	return;
@@ -1029,7 +1095,7 @@ ff_layout_pg_get_mirror_write(struct nfs_pageio_descriptor *desc, u32 idx)
 
 static const struct nfs_pageio_ops ff_layout_pg_read_ops = {
 	.pg_init = ff_layout_pg_init_read,
-	.pg_test = pnfs_generic_pg_test,
+	.pg_test = ff_layout_pg_test,
 	.pg_doio = pnfs_generic_pg_readpages,
 	.pg_cleanup = pnfs_generic_pg_cleanup,
 };
@@ -1084,8 +1150,10 @@ static void ff_layout_resend_pnfs_read(struct nfs_pgio_header *hdr)
 {
 	u32 idx = hdr->pgio_mirror_idx + 1;
 	u32 new_idx = 0;
+	u32 dss_id = 0;
 
-	if (ff_layout_choose_any_ds_for_read(hdr->lseg, idx, &new_idx))
+	if (ff_layout_choose_any_ds_for_read(hdr->lseg, idx, &new_idx,
+					     hdr->args.offset, &dss_id))
 		ff_layout_send_layouterror(hdr->lseg);
 	else
 		pnfs_error_mark_layout_for_return(hdr->inode, hdr->lseg);
@@ -1879,26 +1947,31 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	u32 idx = hdr->pgio_mirror_idx;
 	int vers;
 	struct nfs_fh *fh;
+	u32 dss_id;
 
 	dprintk("--> %s ino %lu pgbase %u req %zu@%llu\n",
 		__func__, hdr->inode->i_ino,
 		hdr->args.pgbase, (size_t)hdr->args.count, offset);
 
 	mirror = FF_LAYOUT_COMP(lseg, idx);
-	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, 0, false);
+	dss_id = nfs4_ff_layout_calc_dss_id(
+		FF_LAYOUT_LSEG(lseg)->stripe_unit,
+		mirror->dss_count,
+		offset);
+	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, dss_id, false);
 	if (!ds)
 		goto out_failed;
 
 	ds_clnt = nfs4_ff_find_or_create_ds_client(mirror, ds->ds_clp,
-						   hdr->inode, 0);
+						   hdr->inode, dss_id);
 	if (IS_ERR(ds_clnt))
 		goto out_failed;
 
-	ds_cred = ff_layout_get_ds_cred(mirror, &lseg->pls_range, hdr->cred, 0);
+	ds_cred = ff_layout_get_ds_cred(mirror, &lseg->pls_range, hdr->cred, dss_id);
 	if (!ds_cred)
 		goto out_failed;
 
-	vers = nfs4_ff_layout_ds_version(mirror, 0);
+	vers = nfs4_ff_layout_ds_version(mirror, dss_id);
 
 	dprintk("%s USE DS: %s cl_count %d vers %d\n", __func__,
 		ds->ds_remotestr, refcount_read(&ds->ds_clp->cl_count), vers);
@@ -1906,11 +1979,11 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	hdr->pgio_done_cb = ff_layout_read_done_cb;
 	refcount_inc(&ds->ds_clp->cl_count);
 	hdr->ds_clp = ds->ds_clp;
-	fh = nfs4_ff_layout_select_ds_fh(mirror, 0);
+	fh = nfs4_ff_layout_select_ds_fh(mirror, dss_id);
 	if (fh)
 		hdr->args.fh = fh;
 
-	nfs4_ff_layout_select_ds_stateid(mirror, 0, &hdr->args.stateid);
+	nfs4_ff_layout_select_ds_stateid(mirror, dss_id, &hdr->args.stateid);
 
 	/*
 	 * Note that if we ever decide to split across DSes,
@@ -1920,7 +1993,8 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	hdr->mds_offset = offset;
 
 	/* Start IO accounting for local read */
-	localio = ff_local_open_fh(lseg, idx, 0, ds->ds_clp, ds_cred, fh, FMODE_READ);
+	localio = ff_local_open_fh(lseg, idx, dss_id, ds->ds_clp, ds_cred, fh,
+				FMODE_READ);
 	if (localio) {
 		hdr->task.tk_start = ktime_get();
 		ff_layout_read_record_layoutstats_start(&hdr->task, hdr);
-- 
2.34.1


