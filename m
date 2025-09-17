Return-Path: <linux-nfs+bounces-14531-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF746B81D4C
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 22:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3C74614B0
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 20:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75897293C44;
	Wed, 17 Sep 2025 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ViZi5vH2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AA92868AF
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142130; cv=none; b=b+SstYLlT855etqWbMDpZnSHSMM7LKfs0LYg3XqAIMac30CVXv94YXUaDBFaSZ7c2cJGe5xDWLQU6eWcTXH7cmW44QpE1xOfrXDSTULHX08Q91jEJ7Q3zGIwxsT++3r/w2qFjApMrXPjISW/76Ar5HED3xGe/o9sZZY4Vv65tjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142130; c=relaxed/simple;
	bh=bVn9gQtCUqsmViWRAWsKqF5KCqll0kpd25hgS1nKvZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hcEJzmWQnknV32ZJiXWrfdZEXXnvU4/eyskmW2J76mL2t/yzLuh9TwLK60ShPRckB3Z0vErUwktKo9vES80ozPKosouoOQMCB3XD8Kl9semVp007zFDZIGSDugeCU8XdITckHiIlB7r2VV5ojwwWbqdxf5Vd49+n5wXygWf4vzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ViZi5vH2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-625e1dfc43dso281354a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 13:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758142127; x=1758746927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAEdUsPK+XpV1KGxoRR5Z/BdB7Xe8ZWcX7qKQ0ivh10=;
        b=ViZi5vH2CY5LlalVmI9DamwP07pIyXutvs/p1ev0E0NauH36u+DLQgafpFTO2l0Ew+
         zEMwRChxJv5YhY5ixsLADPO6taNBnCTrlyQBNHQmU9dT4YymAH2fDCcMKdGVTb/jfE4R
         p+zno5yKWxtDtzAWHrQIi1nXd+Bf0uOMg2bRXfxmoSJfbQPYKQC9O3IdQkZ8gi8sXXSf
         mnj4S4V2leqY+g5GT7ADxC59bmebahgUp7tZMlNYMvP2kzcbfeMxl4BFFoeEsfxajSKp
         vd4ZPhQ8+kdk/+i8ZhXQ0B8su8q0DifDmrBtP4IFoDi4C14oEiKZUoOqITtAZwCMkHFN
         qlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758142127; x=1758746927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAEdUsPK+XpV1KGxoRR5Z/BdB7Xe8ZWcX7qKQ0ivh10=;
        b=cxvVt1JzBheKGF7SwFHf8iRSR2E1lEKPUOIGsHiztQX6qwPpKpgc669Wnu+zR2vTd0
         3a7rS5PqOy7pzln1OWJ4+/u4EimLaqdSrg47ixXmwk2Xe1TLJh9BHyUju8CeiD+T5ScT
         tH2NgLI87KOKwrZdqV9j9L22N9SBLKxDN7uH1iyHKV+TcabhaPd84ba7E7G6HyAjYmbB
         Pg5OAY5HVaI+YSCqH443pQZN8Yaav8/Mv+n8nAC1hhWHVibwDPr6zqhVIzWrU9mmu0Fx
         AHw9qz4QjyHRMmbjmukBoJpPHVYqoQE4LG/f28cZfLHHOEGtm2B48W848OYm9Xs/c6CO
         CROg==
X-Forwarded-Encrypted: i=1; AJvYcCUr+0pEuNaAXX7AQxDkNQzgYDbEQfqSLk1R0GoRwiXh+hMBy5d6gs4NBDHGTb0V5oq/JP5Kk9AAhy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytlJizi/B5yqWb6p38f8wnhFFIGyejr5LBfACa8/jDyPafVWKL
	9D5iJ7WfTyM1bRXkepEZpDHSnT9PeWVHWmTSE4JdlbE5EqE9QLD9vmPBpPh2XXcYCQs=
X-Gm-Gg: ASbGncseZNCqL9Ae309/7+aZltqzxe9p/E6VOkkD2nypOJKRN2gsJwM5b1qRNIt7z3O
	gLtpmRd1eV6J71qJPgxwOw/i+7PHr3AameZEtgvGSAPFeiF1UHpVLeTFF2G4byvE4SoB51Ci5pc
	kpTsieCoaVbI7jqnIDH/vTUWT6oc3jQnZ6VnfdE2/vvbLxvmhaWBen+HmK9qLvV2LY7bgRXbqLL
	9R0ZPQtDKXB7FnjtFtu6a74OPOkv6ckU43+ZKUzteyi523jSGtUOtmsb1EyC4bjvia3l5zlVqRm
	ICBmePDs4uexF8MdvPRR+x71IKiSFnL2HGjH/ljm1VVxNWRQX8xo4ZY4dQW5Ylhd06jdTeJ70gy
	1BDaHZ1donk0R86hUpGLLk+nVq0MSycLM9g==
X-Google-Smtp-Source: AGHT+IH4cvkzrzM7wRdeTANEfKQ7MmVrUFN8E3TWgXGhT0hIWHK/vqtB00bQxieVuPWoFHlvO1TvfQ==
X-Received: by 2002:a05:6402:13cd:b0:628:f23f:1cd7 with SMTP id 4fb4d7f45d1cf-62f8443504bmr3273475a12.23.1758142126689;
        Wed, 17 Sep 2025 13:48:46 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62fa5d0f397sm218895a12.12.2025.09.17.13.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 13:48:46 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 6/9] NFSv4/flexfiles: Commit path updates for striped layouts
Date: Wed, 17 Sep 2025 20:48:24 +0000
Message-Id: <20250917204827.495253-7-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917204827.495253-1-jcurley@purestorage.com>
References: <20250917204827.495253-1-jcurley@purestorage.com>
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
index 79700c18762c..b0d870359536 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -605,6 +605,26 @@ ff_layout_free_lseg(struct pnfs_layout_segment *lseg)
 	_ff_layout_free_lseg(fls);
 }
 
+static u32 calc_mirror_idx_from_commit(struct pnfs_layout_segment *lseg,
+				       u32 commit_index)
+{
+	struct nfs4_ff_layout_segment *flseg = FF_LAYOUT_LSEG(lseg);
+	u32 mirror_idx = commit_index;
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
+	u32 mirror_idx = commit_index;
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


