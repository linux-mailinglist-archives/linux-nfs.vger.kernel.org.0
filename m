Return-Path: <linux-nfs+bounces-14562-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0184CB84DBD
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 15:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2355B1C8355A
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 13:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52FD303CBE;
	Thu, 18 Sep 2025 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="K4X2nLkE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6CA305946
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202416; cv=none; b=o2CFDJO38UjQQhofrG85X6mQjjhzvpGpV6NdHir9K3QXZKbZDgChQH+/k4wd9kpoxn0p+d/sBcl64JeaXxol2myN4c0HrEra6a3FLoCnXOlqSTKN4g9AtWHsfDPrpzuOMdSXBYpCgxGgM9J0/glfxIt8t17+l9roE5iIN+6Tl3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202416; c=relaxed/simple;
	bh=92ekgt582Kq9xQqc4O52WVpj1zdeoCBDoZMS+T0e5jA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g6d0AEfqzn52ZNDBvarkV/i6zVLK0bM3ijMSQi41M7Ht2LOOlOYSGhP1wvHAhC7F5e+y2yx4Z5exHWVdUdqBeak5Sgna1ytHdqdOGEsNONFQn3hJ4ih9x7ErAHKljdFpqJ5sqOIuKHP5aOPbud8gOYDtX3O9soLt1cwSWoRWhO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=K4X2nLkE; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b0b6bf0097aso178161566b.1
        for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 06:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758202413; x=1758807213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOFzwaGQJQCzu//MD0aOFsMVtu5lvpALLWeoTdl77OQ=;
        b=K4X2nLkEwA4vp0sy91ERi1OqJe5x3Ih6kzvCSqRK13Cktbl4PexzfoBbYr6PKIuogQ
         0NWQPkRlWKDelFpYp4UyODzt98lPOIFrMtTAz0KgUtXaic4u+xuJELODrxnlctTCgdzV
         t9uhdSHvqnlnNrxsOztZriFj6F6mNC17H31olqvL1g05j2igkia3HRQOO6r9+jdnJLZ+
         qrgQadCxg9tFFl4vv20Yh/zrNBw8YL0IhIVA3diN/6SVGt7jBDg2ATO6Y/rxxg0/J+9A
         uM59K0LKPcxD5tJfqy0FLgmzQ933pRDp+8ig4/x2IXdCUh+EYzDfWbUFBbC/0tcqzLoi
         MOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202413; x=1758807213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOFzwaGQJQCzu//MD0aOFsMVtu5lvpALLWeoTdl77OQ=;
        b=mdQKN+41h5yHqCsbnTrG9DS7Xh2ZY22lmefFk5MzWv/Jnp6FqbKblCIzz71kcrir0Z
         0hlLUvPg1Gg61fBkyic6BwZe8BqCqusZF4Kj74xdEesjiWptCpaDzXuG8ZPrnWzsgoMA
         i6H9/NXyp1O+8tShYOwD537FHhAfgrwcVHFc33SKs51JSizMfazBNpK0ew1uahyZA3ME
         zDr1Vf147HKlosK8fEcqE2cxpO2uHhKpnrfKU4wM4M+UhB2hbQLvLuQApb998RqGekkA
         zBfHOJJrMg33igiFCu/1nQ2I69vCKGWInjloM4HPl5w+dFylqw1A8z/BinX89C8oLYcV
         4xrA==
X-Forwarded-Encrypted: i=1; AJvYcCXXoUKi6LFU/89CyHsZDSU7C/H8mUNgA1WA/gytm36FCpJQLFfJfYhdz2gsgIEBjf5uIthFKxEAv2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAEkkKx9iyUvdmZ/lhcOa/8rjbnRDZRUnsapyi9NQwZRTgXWAE
	pu5ADGz3qvcf8WyqV3yNDPmI6WfAgc7hZfjPpp8WfY3bka7PtEFbofq8i4gdGkums4cms3Gjp+7
	eSDCQ
X-Gm-Gg: ASbGncvq5/AmcaykVuesPAwSiITVV5ZLOB9Af+sZcZdnGvicTGRws5QU2JxUJYUYu1O
	dJly0O85/A/u99ZAQdhv93znWSgJQdc50TO5Q95sLCXJECCAXIy3vsHXQ/skryKdMZIRSI/8gBo
	hAutCuwa+4caKyqp/qYKAPQSZtSDgttIF5fMu6tqRWzjUnblNreABvQLDSOSmXGQMn6xpLrokEK
	IOEvHIJC/bh9ElrysDmxThvu7W+GWKkVpGgzJhLXSbuNibbpBtNwL9fvAA3el1AjeMyaCluTA4b
	VJOKrjeBc4YTEFLBuvS+gaez7OJQWAxGjbeKfkuzhaRk4CFesZPMpmCqOgDg39Rz0bshzryjAJY
	wQ8DDPFm7ZER76xTBE+JxI0kZ/7KetkK+bBFi5U5aKv/1pMLAE47y
X-Google-Smtp-Source: AGHT+IFe9jI2mR7eTI3rd9GriUhejMuOZErxFUGIeyO3tsD0sWNxq/WbLeuouZ5RSp9VtvvbTZKQgQ==
X-Received: by 2002:a17:907:97c7:b0:b23:6920:8748 with SMTP id a640c23a62f3a-b236920986bmr92082866b.6.1758202413045;
        Thu, 18 Sep 2025 06:33:33 -0700 (PDT)
Received: from localhost ([208.88.158.129])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fc890c5fdsm198395166b.47.2025.09.18.06.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 06:33:32 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v3 6/9] NFSv4/flexfiles: Commit path updates for striped layouts
Date: Thu, 18 Sep 2025 13:33:07 +0000
Message-Id: <20250918133310.508943-7-jcurley@purestorage.com>
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

Updates the commit path to be stripe aware. This required updating
the ds_commit_idx to be stripe aware.

ds_commit_idx == mirror_idx * dss_count + dss_id.

Updates code paths to utilize the new ds_commit_idx and derive dss_id
& mirror_idx where appropriate to contact the correct DS using the
corresponding parameters.

Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 49 +++++++++++++++++---------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 79700c18762c..b061e7a576cf 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -605,6 +605,26 @@ ff_layout_free_lseg(struct pnfs_layout_segment *lseg)
 	_ff_layout_free_lseg(fls);
 }
 
+static u32 calc_mirror_idx_from_commit(struct pnfs_layout_segment *lseg,
+				       u32 commit_index)
+{
+	struct nfs4_ff_layout_segment *flseg = FF_LAYOUT_LSEG(lseg);
+	u64 mirror_idx = commit_index;
+
+	do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
+
+	return mirror_idx;
+}
+
+static u32 calc_dss_id_from_commit(struct pnfs_layout_segment *lseg,
+				   u32 commit_index)
+{
+	struct nfs4_ff_layout_segment *flseg = FF_LAYOUT_LSEG(lseg);
+	u64 mirror_idx = commit_index;
+
+	return do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
+}
+
 static void
 nfs4_ff_start_busy_timer(struct nfs4_ff_busy_timer *timer, ktime_t now)
 {
@@ -2094,20 +2114,15 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	return PNFS_NOT_ATTEMPTED;
 }
 
-static u32 calc_ds_index_from_commit(struct pnfs_layout_segment *lseg, u32 i)
-{
-	return i;
-}
-
 static struct nfs_fh *
-select_ds_fh_from_commit(struct pnfs_layout_segment *lseg, u32 i)
+select_ds_fh_from_commit(struct pnfs_layout_segment *lseg, u32 i, u32 dss_id)
 {
 	struct nfs4_ff_layout_segment *flseg = FF_LAYOUT_LSEG(lseg);
 
 	/* FIXME: Assume that there is only one NFS version available
 	 * for the DS.
 	 */
-	return &flseg->mirror_array[i]->dss[0].fh_versions[0];
+	return &flseg->mirror_array[i]->dss[dss_id].fh_versions[0];
 }
 
 static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
@@ -2118,7 +2133,7 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	struct nfsd_file *localio;
 	struct nfs4_ff_layout_mirror *mirror;
 	const struct cred *ds_cred;
-	u32 idx;
+	u32 idx, dss_id;
 	int vers, ret;
 	struct nfs_fh *fh;
 
@@ -2126,22 +2141,23 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	    test_bit(NFS_LSEG_LAYOUTRETURN, &lseg->pls_flags)))
 		goto out_err;
 
-	idx = calc_ds_index_from_commit(lseg, data->ds_commit_index);
+	idx = calc_mirror_idx_from_commit(lseg, data->ds_commit_index);
 	mirror = FF_LAYOUT_COMP(lseg, idx);
-	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, 0, true);
+	dss_id = calc_dss_id_from_commit(lseg, data->ds_commit_index);
+	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, dss_id, true);
 	if (!ds)
 		goto out_err;
 
 	ds_clnt = nfs4_ff_find_or_create_ds_client(mirror, ds->ds_clp,
-						   data->inode, 0);
+						   data->inode, dss_id);
 	if (IS_ERR(ds_clnt))
 		goto out_err;
 
-	ds_cred = ff_layout_get_ds_cred(mirror, &lseg->pls_range, data->cred, 0);
+	ds_cred = ff_layout_get_ds_cred(mirror, &lseg->pls_range, data->cred, dss_id);
 	if (!ds_cred)
 		goto out_err;
 
-	vers = nfs4_ff_layout_ds_version(mirror, 0);
+	vers = nfs4_ff_layout_ds_version(mirror, dss_id);
 
 	dprintk("%s ino %lu, how %d cl_count %d vers %d\n", __func__,
 		data->inode->i_ino, how, refcount_read(&ds->ds_clp->cl_count),
@@ -2150,12 +2166,12 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	data->cred = ds_cred;
 	refcount_inc(&ds->ds_clp->cl_count);
 	data->ds_clp = ds->ds_clp;
-	fh = select_ds_fh_from_commit(lseg, data->ds_commit_index);
+	fh = select_ds_fh_from_commit(lseg, idx, dss_id);
 	if (fh)
 		data->args.fh = fh;
 
 	/* Start IO accounting for local commit */
-	localio = ff_local_open_fh(lseg, idx, 0, ds->ds_clp, ds_cred, fh,
+	localio = ff_local_open_fh(lseg, idx, dss_id, ds->ds_clp, ds_cred, fh,
 				   FMODE_READ|FMODE_WRITE);
 	if (localio) {
 		data->task.tk_start = ktime_get();
@@ -2259,8 +2275,9 @@ ff_layout_setup_ds_info(struct pnfs_ds_commit_info *fl_cinfo,
 	struct nfs4_ff_layout_segment *flseg = FF_LAYOUT_LSEG(lseg);
 	struct inode *inode = lseg->pls_layout->plh_inode;
 	struct pnfs_commit_array *array, *new;
+	u32 size = flseg->mirror_array_cnt * flseg->mirror_array[0]->dss_count;
 
-	new = pnfs_alloc_commit_array(flseg->mirror_array_cnt,
+	new = pnfs_alloc_commit_array(size,
 				      nfs_io_gfp_mask());
 	if (new) {
 		spin_lock(&inode->i_lock);
-- 
2.34.1


