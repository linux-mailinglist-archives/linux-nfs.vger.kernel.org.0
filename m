Return-Path: <linux-nfs+bounces-13894-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA51EB34E08
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 23:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C7E486E79
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 21:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40167277C8D;
	Mon, 25 Aug 2025 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WdtMx9Wl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676302868A9
	for <linux-nfs@vger.kernel.org>; Mon, 25 Aug 2025 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157272; cv=none; b=rS9oC8Ky9GRFYghfXiA8yDfxTd6ndoNKEPmTLQE2e4840fKvZjMs1KBVFwoz53OXn3f9RR+sp0ISOUBO29JYkkR4L6++QKY9GMfQRymHPxpSV0OhWmacZV7jW6qvlI4eKyPnsagZ9TXiaApxMhltmq56q0zxOOoLQs2SulnyVOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157272; c=relaxed/simple;
	bh=bVn9gQtCUqsmViWRAWsKqF5KCqll0kpd25hgS1nKvZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AQP5jl8LcEBxmjuir8sio+fa5KkXF4JRt6yrFSnC3Mk/voy+xSH3/PbZfNj5GOiUntRhvbFlo4FXtz1NBCMRyBwW9i4fFKCP4WnthpyM4gYQyCxah0OYms5tM+W3b+DHCJCx82wkUgp9+ilyuW/1pxMdVByhGGManMcXEt9aVGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WdtMx9Wl; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61c3360bbaeso3014110a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 25 Aug 2025 14:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756157269; x=1756762069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAEdUsPK+XpV1KGxoRR5Z/BdB7Xe8ZWcX7qKQ0ivh10=;
        b=WdtMx9Wl94AnJWLl5mLYdSyUqvqieSXa3bTYZR+kk3aUfhDen7yV6hQ9HZcOl+j775
         SfeLMT5KHiwAWJ8UIvHtPH60z09Ks4QWRnOjJxSTKX4d6uSe1fICOw9lHdZgn3wYrw4a
         N3gFWokpiaY5gWhGO/J+G4JrApmp3mIc/4/D3v4BgxpkwCfQrKlzsoEH2j/pp4VFt8B0
         3iKyNQUXJd1/f5zHsBDP18D3QCD+52zvrPaiCFGsoyj9wfQm6vs/eF9BXe7eXiHGDRcX
         WmIjroIyzOwlhYWxjLbBD1RD1rz8RgDmmzya3ljYeSzw/PROHHS2ZrLr55gG4la9oZOE
         yD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756157269; x=1756762069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAEdUsPK+XpV1KGxoRR5Z/BdB7Xe8ZWcX7qKQ0ivh10=;
        b=l1fC4dW6xriitFFSvC+nk3glLtF3VDYeiULBTXnZS37/Z370+/5IxiELq3cksJWp2E
         NT8OoB2aNz1UaOJuoAfkacr5KOmaVRY8J+utaxoyQ1Q3V/9B0bBFzmrFxHku3CnEVrs6
         Or6jnORFf1+BvDqdA4M09KuElatvQTibd/4b7u6RxqAZquwpCWWxq4bZU8HW6ce5mBSm
         LJBEK6b6PXaFEOTpbM5rlC5rxy/Hix57oluZ1EAiRZFd0HDbWXBbaJhQHvrQ9oQdCEfE
         wd2xRc4i+MKg3SVU5BCJp5ttIDFuk1WLABtmIZQrOApzPAII/hcczBxYomaDZh6kHJKN
         7R+A==
X-Forwarded-Encrypted: i=1; AJvYcCXUAFLp9OzDSg6QnRsMRdWM84DDgehnKtNkteXgNNB5eMwo6S0oDnu5gXM1gm/mCposU+DF5Sj8zao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygynsgx6O9TgtdMen9yux3xUirngH9JX5aQu3I8nXwM8cwfhCZ
	ecXlUzmJTimZ9ol4qOf5eRW7857bRjEMVmnT8QhYRODcortbPvGI5qt3dg5zIOKLwHw=
X-Gm-Gg: ASbGncs84PIS0ozv1bIVQs3TqcWdGtEpdcWO1aoqKT+ZrklD6AgpUEa7XzvVPkAX3T4
	LpW/0R/4JCuq98jeF8mJB/8mHUbL9WA2JYTLSO/p/lq0DCt+Gi6Fqs9+qEZdfu63tnpdb6Dmlf6
	a9e4wMYVUWFcqQsn5DltX5S5hTOxmcgY6prii74vrfdVvR8BYINxhS2bN50FcjxMCvRBKB//kzK
	a+LX0lFs/bprslGV0s8/XIrWPYDFFqQoN5PF0lpufNJ9uBvtVfh5VUsbGEIsxoWG70df+h56UOq
	D7pZSEtBktc4lSsFlesC8lhTO5NSBi0pom1e0g411PKaWlmJYXkreMBaEpMfC0f5aOZd1tXP3mo
	zt19f/tVBLFft5KMBGUKEyuc=
X-Google-Smtp-Source: AGHT+IHEDqYH1qCbXwEo4rtYphLG5vOUucOwmRn5srU/DdgOGaTdKG4UXbdD7unBnNwPBTRVkyMpfQ==
X-Received: by 2002:a05:6402:26c2:b0:61c:7ba4:8bce with SMTP id 4fb4d7f45d1cf-61c7ba4902bmr2711596a12.24.1756157268582;
        Mon, 25 Aug 2025 14:27:48 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61c312aeb15sm5589042a12.19.2025.08.25.14.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 14:27:48 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v1 6/9] NFSv4/flexfiles: Commit path updates for striped layouts
Date: Mon, 25 Aug 2025 21:27:26 +0000
Message-Id: <20250825212729.4833-7-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825212729.4833-1-jcurley@purestorage.com>
References: <20250825212729.4833-1-jcurley@purestorage.com>
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


