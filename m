Return-Path: <linux-nfs+bounces-14561-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF30B84DAE
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 15:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAB53B179D
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 13:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC7D148832;
	Thu, 18 Sep 2025 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="J88MwVsZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36283081CF
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202413; cv=none; b=jDpv8Ylu3nIt995Atw06uIv3ytyGddnUm5Y4MdKKS4Ckzly3sK5vXH6I6JzLXSYHmD/uncgpa8AjCKsRkaLEvPFCIr4UyQwXPnZVnRCN6Jac39zQa+GyEii7XfAj6PziQIDP0lQqx9N3nvhXNpzPPeiCjS49Vkwma6ZyPoV6bjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202413; c=relaxed/simple;
	bh=E6toPwqmDJkpFawV1tGmdkuMJo0mNgiQ12F34q4J2aI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FoCnN7DMw1UtcJOXy0hYF29el4zmgO53hcvGgjUhDdUcZDAkEJ9rGzQL7m12fcB+uVdr6nG+DCNwUsgmJ3TTa+ueD/OnveL8D93FHuoUrtffTv/+bfdqs9KoVuP8k6O1ctXL2uyO+KiyNeAHhsNgWgh5hWhujp8xiODbE1eNcZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=J88MwVsZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b07d4d24d09so170747666b.2
        for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758202410; x=1758807210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DxqhLAwCPsv2k0UdKEGAo0Up8dCDuBhVt4kaJL6RGg=;
        b=J88MwVsZssZktXG4AofWR9bMVLQZqPEW6cS/PnNPHCLw5B3OO2lVcJN3WVCIXIRQWh
         3SNqbg6fjn0CHsX+9h9ypzSPiExKcXcn4Vh3bNVLS7A48biE5u53oN4MoaMw6AFp21xS
         EoAcn6xexqzXWMTcVGc+QXunBds+jup5+PLLdVavFfYCZ/qFk9OGZ+kb3O1oGsI9mqNi
         chRrkW2cOgV26gqQhaxJJQ8/jJFfXEa9ViNblEgwMOwB6R9ceohc6DSfbhdsRWToWMjZ
         bjmS+QM27rC7WdN4dOdtEY27EmjSR7jZrXpJcUkV6R6AF88PURwgRAdGMQ3zDKLHbd8G
         LhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202410; x=1758807210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DxqhLAwCPsv2k0UdKEGAo0Up8dCDuBhVt4kaJL6RGg=;
        b=ISjsHZnSp7p3ShdwN1N02UMYxD0NX4hdehQJLN2Xn3vZPPd9AILMazlfhV8D2rF9O7
         43e0QjZpTiJ6CNXEH8EuisTK/LWg3+VEnjriwHv+FKVP7N534L0wdj2HhHoy8GpGXxh0
         fWIy/OZJcc1d6ShhNzWRAgMIZfjFkALWPG8rgzXJg75GTsO2ljGIqz6BG5GI6yZMuFjm
         iUmdMusYDN05Zp/f/yJy8T5WKAlNpCE5ZxQ8AeEDNRAgstjWR6uTv5W98KED99+WKWzd
         IK4lkJEwL3lNKJe7zXSJ+6b+KFcpo1lBkwMtKLppNcSphdCuU86zANhy91WiPdn9M7vf
         J6aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXitjDuTx5xpQ1l/bWVFYyVFC92pI0xdMk9w7C46MSxUmr0SmkbpWl19Gl5w74qdw3jbWHPIDAuZ98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/CbSPSPI7XzQqjpbMOA9/zzd3LQuAhEoGVpsxMMV5vgP2MPv
	o+SB7LVANMD4wCJ2osTgEPRa93J+YU+jL0H53SZ197NcxIAfw4ORG8FalS/Hju/Ji00=
X-Gm-Gg: ASbGncvMJfERiunw5sAywxa54W2KQnzQ1M70u+eW5jt0+la1x15vUM7INhZsXFKPuC+
	Gxj9H7O8hGuoZ0yhaKwplfIn+9d1uGpiFRy9JJycFpro16vL9DZOg/sBHr7laUBXqwqde0lt2bl
	bXE2VePYrGtYQv5/xLkrWRaeOFNAd0gjO2Ozi7TFyA0XsrKF2NOKorkilj+vt0FXAqrMHfJESdJ
	RL9h/fj2VtJgwFwLNrtdEtfJK5LGyvq8jb5hE7By+WQSwBgtgKImZ2XncNHpsJ8AcLQbeWLyx5L
	pvCI4gl6UFkl6IjYlYzWYxdolV6bEM7uqmoAf47SIFJMOR2EJewI5MSztQOoJf11AXCDuAUUF+v
	mEh049lasCtFg4YItgZZh2Io7LTFW0iJx6U6vWxoAWYFIYoG/1sAM
X-Google-Smtp-Source: AGHT+IGzsO3hUTSpCoWWKqofNoEk0+xGicKpE5n6BEfOLl4ptr1fP7OgVPFcB719zc2xpaakc4YHhQ==
X-Received: by 2002:a17:907:c23:b0:af9:3116:e0f6 with SMTP id a640c23a62f3a-b1bbb15ca71mr664169866b.53.1758202409839;
        Thu, 18 Sep 2025 06:33:29 -0700 (PDT)
Received: from localhost ([208.88.158.129])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fc5f382a5sm198298466b.12.2025.09.18.06.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 06:33:29 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v3 5/9] NFSv4/flexfiles: Read path updates for striped layouts
Date: Thu, 18 Sep 2025 13:33:06 +0000
Message-Id: <20250918133310.508943-6-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918133310.508943-1-jcurley@purestorage.com>
References: <20250918133310.508943-1-jcurley@purestorage.com>
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


