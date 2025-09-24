Return-Path: <linux-nfs+bounces-14651-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B23E2B9ADC1
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 18:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD1219C38A6
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE3F1C860E;
	Wed, 24 Sep 2025 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Df51UKIV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F071EF091
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730877; cv=none; b=a36PMyEdMZdcu8OPs1TUZ5QvxngslYu5FKB4ID0/nUrkHSEzWtvG1GtCN35zbFbEs2tR6VQFFneRVguRzE56gI8E2OkSxK6qOeDWfeGUdf1ITxqClTHGFzfxL59SjDW9RNDuq5BPGfjZv3QGN+cL65IC9e5MEsdlsBLEA9NtTXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730877; c=relaxed/simple;
	bh=GF1TeKxV0kxcpMOKDYWp9pors9s8dI31s83hPK3uCwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k4bmKhvlGCCUpVYmg8+vL/OMT3ocYcNjTbn4coEA1vAcJZdYXfcwZb9XPYfXU52uoL4hvy3prJ3vL2Fc2uy+OTt5A6tNIG8dcZmU3SlGJdZRm2Om1IOB+x+Dq5gU5biyPLC15B4u+meDSnVhzfwTvHK+j8LboDtIqyT1FhFGV60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Df51UKIV; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62fa062a1abso11399554a12.2
        for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 09:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758730874; x=1759335674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUc/HjNA9wPztIqMlvFOK/LpPtXOYGD+R7sTVI6Sjt0=;
        b=Df51UKIVB5F6PMdUEQsL/+dSaT+nwyyLEpBGFgqKI06RSeGFElMSkoEHYlx8GCVgoo
         TL44mr9Is94qVMx/RbI5iDN/Lo/jaIo4st6yTThWGFiq1x7gZowHuN1xT2v7ZxfbGeTk
         IHB4QOTW8po/d6IwKndl+XSZEzxgqLrGI5GeVVgyeQ6yWc1J6mmh9YcCIOWEzcGtNioI
         p8b2NwkpEMFAjvtQ2qFSXgNbxGGKVVRaz6tGD+X8Gyh+GbP2ct0yVusokC3KvFJTEKgo
         uS4g1/Wki4bO2OKc1+zNnCZluoUeDSxOFC5wqiESO/F5hRB2Jjg7+pzlZ9wtGScH8bmF
         dotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758730874; x=1759335674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUc/HjNA9wPztIqMlvFOK/LpPtXOYGD+R7sTVI6Sjt0=;
        b=agfD/+HMAS6Y9/+JREAQR341UWKbC5qVzkbU6wXBv0L1iic5qRPximI+SizYNC/TGr
         XUGrrcT2gVHK8FgMqyM3kupCUgLveyhaCGv70zX08BMUdy4DAYjiXJAME4yV2zULzJkQ
         eEDD1iQM/f4SjgjPKbS7qPJuE24vPSt/vy8YulOMV98x7yL9Uk825hUm0UYhp/e63FUk
         Q9H3P+QC/lNSpDYD8GY+qRrNzeAycKOZQQZ8ALfRn9A1vbGUHRLZALPIRs0Tk8/479OB
         tucXZf6GfbZVCpFdEX3R699RLgoeKC3gCQqbqkCjbltRgNMxm9LlnqV/VOCA2DYICoco
         Pydg==
X-Forwarded-Encrypted: i=1; AJvYcCXMTDyHfr53YeDIPY1P5ywQZWa0h2TY0BRtdFOVNpyeK68U0/Qz3m34KGtSeOkrdpA1l41qUMweKJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG23GzwMGs2CIp6qTXWUpPYAAzok5+EZY+813gtttixOh/zL+5
	z/ev7RcTYOWZ7szueqLfREdoyx+ftQXpsoRLpa7lbYUOU4SZcg69bgcnvMgSdul88+EJju2JWkK
	f1gub
X-Gm-Gg: ASbGncsYFLlLjLLgGhhCghwDwRdZ5Ytc45lVYzrhLvYnMEhMmZfY0n0yGHknCGn/L8H
	8Sz2O1S7mij3gMLIIe8lpMuIG1eAek7qAX8H9JFHoF8XNxL76BshcJbz8sQVHbvbfCS7U867Op/
	sBNSOYTu/EyC7UcK1QbohNgqJhd3r9XqKFdMKtLiRkCDray22iZtUL6JaSUjcEliSKGRCx8ruKq
	F0mII6HT8olAwsnUapTrxVZxt7rvkIMHMHo3jy8e9AGpZfXNQgzs1qpiVI8T45M4zQYOHdp5Osu
	pubo8HO/YvUKgZ0yJsGT3OHyTX3NxsLS4W/WwwHI9zNDbqVkbdt7ZNlAYpJvIjjkqUPl4YKS/Jv
	Ll4ddl4DQWdw5G7HBm9wanUQ=
X-Google-Smtp-Source: AGHT+IFSLbbrGHkwyRtg/dAV5tyJIj22BVfUHq77pfu9kydlnzSxGk6jH7tJF4baeaCI8MKS+1poWw==
X-Received: by 2002:a05:6402:14d2:b0:632:d9b:271e with SMTP id 4fb4d7f45d1cf-6349fa7f9e3mr58411a12.22.1758730874205;
        Wed, 24 Sep 2025 09:21:14 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62fae9c5159sm12411007a12.50.2025.09.24.09.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 09:21:13 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v4 6/9] NFSv4/flexfiles: Commit path updates for striped layouts
Date: Wed, 24 Sep 2025 16:20:47 +0000
Message-Id: <20250924162050.634451-7-jcurley@purestorage.com>
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

Updates the commit path to be stripe aware. This required updating
the ds_commit_idx to be stripe aware.

ds_commit_idx == mirror_idx * dss_count + dss_id.

Updates code paths to utilize the new ds_commit_idx and derive dss_id
& mirror_idx where appropriate to contact the correct DS using the
corresponding parameters.

Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 41 ++++++++++++++++----------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 79700c18762c..3e04de09c3c2 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -605,6 +605,18 @@ ff_layout_free_lseg(struct pnfs_layout_segment *lseg)
 	_ff_layout_free_lseg(fls);
 }
 
+static u32 calc_mirror_idx_from_commit(struct pnfs_layout_segment *lseg,
+				       u32 commit_index)
+{
+	return commit_index / FF_LAYOUT_LSEG(lseg)->mirror_array[0]->dss_count;
+}
+
+static u32 calc_dss_id_from_commit(struct pnfs_layout_segment *lseg,
+				   u32 commit_index)
+{
+	return commit_index % FF_LAYOUT_LSEG(lseg)->mirror_array[0]->dss_count;
+}
+
 static void
 nfs4_ff_start_busy_timer(struct nfs4_ff_busy_timer *timer, ktime_t now)
 {
@@ -2094,20 +2106,15 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
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
@@ -2118,7 +2125,7 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	struct nfsd_file *localio;
 	struct nfs4_ff_layout_mirror *mirror;
 	const struct cred *ds_cred;
-	u32 idx;
+	u32 idx, dss_id;
 	int vers, ret;
 	struct nfs_fh *fh;
 
@@ -2126,22 +2133,23 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
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
@@ -2150,12 +2158,12 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
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
@@ -2259,8 +2267,9 @@ ff_layout_setup_ds_info(struct pnfs_ds_commit_info *fl_cinfo,
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


