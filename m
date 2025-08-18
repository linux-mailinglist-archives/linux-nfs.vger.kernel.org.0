Return-Path: <linux-nfs+bounces-13759-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EACB2B3F2
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 00:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4BE07A63A0
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 22:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AB927A924;
	Mon, 18 Aug 2025 22:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AIpuWUE9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0B8246BB0
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 22:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755554922; cv=none; b=IR0Eanfsh/o7XqCkkpLJem+erO5j3YgtGGG5nIZISfVz3mmvXWquVTgWNoZbtwkbdn06cbN0UDz1CjidOAloix9Iwl0mjAPozg8FRO2tv63O59Ou2Z1F2TPhSY56ijAKZOx3ustXk3vWpH8wQJIZd7QjvN+KsYuqzyJ5vHYKMhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755554922; c=relaxed/simple;
	bh=bVn9gQtCUqsmViWRAWsKqF5KCqll0kpd25hgS1nKvZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWYbgLvtVAlShoR/M6IJ1i0Vp/53FKNkvROlLQMLkiM17MDTDr2lPr1BS//HHkpFBl7Ri017RYusbXe63J3/8zAL/osDFOHWOqfxwZbwQuSuFPWY8sRnEa9maOynD5DW3OqqOqcEllSjbs8TaTiNpDO6URiyzmUksnpdwSR09Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AIpuWUE9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb72d5409so742682066b.0
        for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 15:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1755554919; x=1756159719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAEdUsPK+XpV1KGxoRR5Z/BdB7Xe8ZWcX7qKQ0ivh10=;
        b=AIpuWUE96A3GEbrmTe9CV/kvEIT8/5f3XESacxORIYrX5JxzbigRT2z5wtJs/v2Gnn
         fqC735RulG/AnqC8J3+wkaJbx9/gr2DEhtZ3lRppfElT6wGqwbWjz727GwXnfns2sPjh
         +pcmBofgUvz+cm4jtBJF0dR5rOpyGGRY+Rd/eWxS7opOOBwBCPHoL4qC6zJNmO3vcFFg
         mEW4qJZJ5gYcLlyg3IOMXKUrOVZZyZDzuda8QFW4z6Q1T2Ks5m37nUadsj4zKNL/2p7m
         Gq8a7x1s5G19XNeYq6UqTxnzuaFIK14Z+2Y8tFr4SYx+RbRlA7CQfN0Td+9yjFBpbFYf
         JLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755554919; x=1756159719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAEdUsPK+XpV1KGxoRR5Z/BdB7Xe8ZWcX7qKQ0ivh10=;
        b=lcy3aMzI+UVg5OYSVOq7HeMArSIiCGb3+vmalrz/OtGlmOSeNB6RTmL/ZULkAcbqMs
         tbCQY7tVk5pC0zR/WvkjMqk+FkAm7kvp/EX73yNuv5Syjje2Lg4Xx6O+1x29vAtLyPrK
         raGkdA90Qsll680PAZfYsfg6Adh607lfSZH8jtFMaLve5X3WVBwb39zjnDDB+he+uTYC
         JzDsMoa1XgoqZliIwGzjXL5Dn/yAM78XZ/LapOpcpft+LvmKyf08b/xwZjMYLVv/qzVt
         Dxb5T106qaRBPSDpDY8ZLR8L+j8SPDG+dZrkXckeE/Km+sgPdat55y4q9+FzJ6oLdd+I
         4b2g==
X-Forwarded-Encrypted: i=1; AJvYcCV4PueIev8cuGTyn5MgOzWhxmqPYElTrzqY8Zu2VOJRN+/xMBmH2BRvDkyBmPy9raGK+H3oApmF9gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUG29TE6OHpItCkx28Avx1SAlJVqTDXoqpQm9XGrrGzDYz04OO
	FV2n1NzQ/DuC5BC0Jtl/jt028EAFPDQrKxhQfXw0ANVLLlvpIZ/7R1NbJMoTg1UP984=
X-Gm-Gg: ASbGncvG0MC0YVSDjj02SvctK8vl2SVWRWW2z+GCyGH73e2lENnHus5nkdXVNytCDoi
	zgjSyn8oGWxOKHnK20rSDckRSnvdWUjOXLFSRCB4k5eAMmAG0+Lv3RS50POkdhoYlSO4SMaU+qQ
	xeQ8KjaH1bRvFI/84t3PBD2aAgXpegR6UWNauqsTv2eaQlI5OqRicuK9S5Rv8VAlNsKZ7pNWwUb
	vTCsLfpd3v7W4vpTXF7QavlMzC8cFJei52+D+hoRCFPOmIuP7zPdsl9S2c36ok5/QHajJZpMKl8
	ccdMbtPXoaagg45kK0KDtgDirNMr6GyWpMyAp5n/twbQ1VGjR9zm1CxwTuKenv/ep9W1vqaUh+u
	vNyEpCTjzISCamNW8plNQC2rrq5Tx5oPOJwj9n4u4nJQ7
X-Google-Smtp-Source: AGHT+IFENY9ZS7gpStefNmbwSNuZyBTNGwKrnEVNEhMhkuwKGPrcxSic1Fsa9oVWaLlQ5HU2TRqCWQ==
X-Received: by 2002:a17:907:9410:b0:af9:4282:d38a with SMTP id a640c23a62f3a-afddcbad946mr29828266b.21.1755554918711;
        Mon, 18 Aug 2025 15:08:38 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afcdce53c3bsm869692266b.23.2025.08.18.15.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 15:08:38 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 6/9] NFSv4/flexfiles: Commit path updates for striped layouts
Date: Mon, 18 Aug 2025 22:07:47 +0000
Message-Id: <20250818220750.47085-7-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818220750.47085-1-jcurley@purestorage.com>
References: <20250818220750.47085-1-jcurley@purestorage.com>
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


