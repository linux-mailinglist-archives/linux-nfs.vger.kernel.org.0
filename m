Return-Path: <linux-nfs+bounces-14529-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32454B81D49
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 22:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8664618A3
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 20:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03A02BDC33;
	Wed, 17 Sep 2025 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GQy+NLc9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDBE2868AF
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 20:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142125; cv=none; b=TKU3oJTRIeeLR+heuPinB2nX48iB7a63hC3JS244xjI/Niv090Pod3GJ3n0TV4fJfZMU9vsp3d512uT5b03OFnP17QncsXogRfISXtb7sSQIAoGalEcXTH7rhkSwr8uRBxr5t9+kfnrpBKMgQzFKYcyx5h/JjrL69VlP1RpMWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142125; c=relaxed/simple;
	bh=HAv1Oq3echWEw4N76O++LFWAV0lxJ9FHxDSsUVICYsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bBztZyci6pyef5Z+n4pmaS3A9V9LDqXmP8AXtEoKemjem5YEHeN2S5seHcxbd0czLNQsWDCY8DxPyTL+8MeNV8u9LVS6ruyCBrZGpzEDt7/Q3ZwZLfCAhhI47AN4wY+5xD2anHjBMLiSsil5rwnTkSVEmTjgK+i3VXOc0uaKsZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GQy+NLc9; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62f0bf564e4so240678a12.3
        for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 13:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758142121; x=1758746921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8eyCi2eEh+fos1BAI8hD18UM07G2hxzKJ4qJww6O0M=;
        b=GQy+NLc99OLdByxQ5QytCgD/TTz9jnXFXTGoUxj7K/06FYr5YgnyHB7XqfGgDIm7Br
         YCLooI8QkseXGbqb/sBNpgKPAZuvXj2iALVss9BzFOKFkwXUDInda1S/fD+nAnJQvH8J
         GwYpJ1L37AVyQUZxUVgJfmefqInkyzIjNqUVZxkEph99nGmxks6Ti6H7bM5bFSSu0ZdA
         qg4qwyO4ocxUIcVlkiwhZ1xGGNiN+C1yWrZCYnRORaroYHYo/PM1Q0TUQ0/JBHHv6n2u
         XbEILTQljDtQy4bcibElGCS6HUo4SwsyxKfCeuaV2hOYnbLbCLvOfIIiAH9eq7suP8jx
         naYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758142121; x=1758746921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8eyCi2eEh+fos1BAI8hD18UM07G2hxzKJ4qJww6O0M=;
        b=FIxpS4hqrt9f+Mz6W/Mgi5k8IYHyb+ptDo0a3M3aQxYztUMZfFtQ7wKh6RNcWaQd7l
         15EMSALgqh988NyZUi6JYCzleW116hifrlrFn1l4AYIaThbrGDL9/06CJmh6hVSoOhtz
         ms2lCnVDgAG0sBY6BfEH9/qG7iTNj5+dAdQgMOydCeMlUUoxfNXc07wNoRyPV2z4/rga
         E0PHUaOr+dTcXZ2Ogdw6piP1OpeK0xO2cYh10HvdV6jpcjJjbxZ2fdA+71hXSCn5NRJ/
         k6A+KxIx+KNCY/s2Nk9CnFp+0TxGnNPDL6BoIBkVmjIF/3TkAaE2iKzZPNqaUodA/6kx
         GN1A==
X-Forwarded-Encrypted: i=1; AJvYcCVJgLMYorkwPw7IInu0+cDWkm7gYYkHK6ggy5fi7Ho5rPZTA/jH3BzVpD70Cmk4b/gjPHmIvI7YZUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrbeYcRvyKouBNxTSW2H1P8sG4lm6oFO+NbPtDKJ9UBqIZcxg6
	F/7mt7/FBmj95MApqq6UuuEVdai77UkC368YAPUCRvqof7BBJQlwxKviEgji8HrPFVM=
X-Gm-Gg: ASbGnctPAcrLTcXevFcUvmYDXbI8DfiX8jqEtTJc2thDe46yJg57tiZQRjPOVJMVkvF
	4QIczE7gMLTgqp/dwoDh8SP2Uc9mhMmlERH+bCY/tDqKZo7JGTp0QkYEwDKqDa7v/rtixfAQxRW
	vJocBR4Trxd+QTv6MvkHKGaHd7xkpxIcYyKNmEd9EnfI987sh4MdXbsIhQ3h6YvFuVYN/yK/Z8S
	AELe/o10L7NMBOh3qY4vB6pMkXf1FsoAB8PhbGGrW/ybSTCFyIo5FGVQqAMLuuWDUGCov21vknF
	kQUgKxJJFSrpg3d4xeoWMswebgyeqOnItdfmRqZv61iMdIDZcu2ouNpj6TjOiEpw4IJh+hlapxN
	ZH+tXYub1lIVc0XrGOCxe++Jv0fIuyiVlVg==
X-Google-Smtp-Source: AGHT+IGyK+IDbu98HhLnA9LM7aNoC0jfD0ZxcUOn6NdP+fiSBkDAArZeLIv9SiKZCJzNlvCLBnIdVA==
X-Received: by 2002:a17:906:6a22:b0:afe:7909:f42a with SMTP id a640c23a62f3a-b1bc1bf3286mr414378466b.51.1758142121344;
        Wed, 17 Sep 2025 13:48:41 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fcfe88b5csm44536266b.57.2025.09.17.13.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 13:48:41 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 4/9] NFSv4/flexfiles: Update low level helper functions to be DS stripe aware.
Date: Wed, 17 Sep 2025 20:48:22 +0000
Message-Id: <20250917204827.495253-5-jcurley@purestorage.com>
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

Updates common helper functions to be dss_id aware. Most cases simply
add a dss_id parameter. The has_available functions have been updated
with a loop.

Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c    |  56 +++++------
 fs/nfs/flexfilelayout/flexfilelayout.h    |  39 +++++---
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 111 ++++++++++++----------
 3 files changed, 117 insertions(+), 89 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 46a765bf05c3..a2a3821f190c 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -164,14 +164,14 @@ decode_name(struct xdr_stream *xdr, u32 *id)
 }
 
 static struct nfsd_file *
-ff_local_open_fh(struct pnfs_layout_segment *lseg, u32 ds_idx,
+ff_local_open_fh(struct pnfs_layout_segment *lseg, u32 ds_idx, u32 dss_id,
 		 struct nfs_client *clp, const struct cred *cred,
 		 struct nfs_fh *fh, fmode_t mode)
 {
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	struct nfs4_ff_layout_mirror *mirror = FF_LAYOUT_COMP(lseg, ds_idx);
 
-	return nfs_local_open_fh(clp, cred, fh, &mirror->dss[0].nfl, mode);
+	return nfs_local_open_fh(clp, cred, fh, &mirror->dss[dss_id].nfl, mode);
 #else
 	return NULL;
 #endif
@@ -752,7 +752,7 @@ nfs4_ff_layout_stat_io_end_write(struct rpc_task *task,
 static void
 ff_layout_mark_ds_unreachable(struct pnfs_layout_segment *lseg, u32 idx)
 {
-	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx);
+	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx, 0);
 
 	if (devid)
 		nfs4_mark_deviceid_unavailable(devid);
@@ -761,7 +761,7 @@ ff_layout_mark_ds_unreachable(struct pnfs_layout_segment *lseg, u32 idx)
 static void
 ff_layout_mark_ds_reachable(struct pnfs_layout_segment *lseg, u32 idx)
 {
-	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx);
+	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx, 0);
 
 	if (devid)
 		nfs4_mark_deviceid_available(devid);
@@ -780,7 +780,7 @@ ff_layout_choose_ds_for_read(struct pnfs_layout_segment *lseg,
 	/* mirrors are initially sorted by efficiency */
 	for (idx = start_idx; idx < fls->mirror_array_cnt; idx++) {
 		mirror = FF_LAYOUT_COMP(lseg, idx);
-		ds = nfs4_ff_layout_prepare_ds(lseg, mirror, false);
+		ds = nfs4_ff_layout_prepare_ds(lseg, mirror, 0, false);
 		if (!ds)
 			continue;
 
@@ -953,7 +953,7 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 
 	for (i = 0; i < pgio->pg_mirror_count; i++) {
 		mirror = FF_LAYOUT_COMP(pgio->pg_lseg, i);
-		ds = nfs4_ff_layout_prepare_ds(pgio->pg_lseg, mirror, true);
+		ds = nfs4_ff_layout_prepare_ds(pgio->pg_lseg, mirror, 0, true);
 		if (!ds) {
 			if (!ff_layout_no_fallback_to_mds(pgio->pg_lseg))
 				goto out_mds;
@@ -1125,7 +1125,7 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 {
 	struct pnfs_layout_hdr *lo = lseg->pls_layout;
 	struct inode *inode = lo->plh_inode;
-	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx);
+	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx, 0);
 	struct nfs4_slot_table *tbl = &clp->cl_session->fc_slot_table;
 
 	switch (op_status) {
@@ -1224,7 +1224,7 @@ static int ff_layout_async_handle_error_v3(struct rpc_task *task,
 					   struct pnfs_layout_segment *lseg,
 					   u32 idx)
 {
-	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx);
+	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx, 0);
 
 	switch (op_status) {
 	case NFS_OK:
@@ -1354,7 +1354,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 
 	mirror = FF_LAYOUT_COMP(lseg, idx);
 	err = ff_layout_track_ds_error(FF_LAYOUT_FROM_HDR(lseg->pls_layout),
-				       mirror, offset, length, status, opnum,
+				       mirror, 0, offset, length, status, opnum,
 				       nfs_io_gfp_mask());
 
 	switch (status) {
@@ -1885,20 +1885,20 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 		hdr->args.pgbase, (size_t)hdr->args.count, offset);
 
 	mirror = FF_LAYOUT_COMP(lseg, idx);
-	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, false);
+	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, 0, false);
 	if (!ds)
 		goto out_failed;
 
 	ds_clnt = nfs4_ff_find_or_create_ds_client(mirror, ds->ds_clp,
-						   hdr->inode);
+						   hdr->inode, 0);
 	if (IS_ERR(ds_clnt))
 		goto out_failed;
 
-	ds_cred = ff_layout_get_ds_cred(mirror, &lseg->pls_range, hdr->cred);
+	ds_cred = ff_layout_get_ds_cred(mirror, &lseg->pls_range, hdr->cred, 0);
 	if (!ds_cred)
 		goto out_failed;
 
-	vers = nfs4_ff_layout_ds_version(mirror);
+	vers = nfs4_ff_layout_ds_version(mirror, 0);
 
 	dprintk("%s USE DS: %s cl_count %d vers %d\n", __func__,
 		ds->ds_remotestr, refcount_read(&ds->ds_clp->cl_count), vers);
@@ -1906,11 +1906,11 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	hdr->pgio_done_cb = ff_layout_read_done_cb;
 	refcount_inc(&ds->ds_clp->cl_count);
 	hdr->ds_clp = ds->ds_clp;
-	fh = nfs4_ff_layout_select_ds_fh(mirror);
+	fh = nfs4_ff_layout_select_ds_fh(mirror, 0);
 	if (fh)
 		hdr->args.fh = fh;
 
-	nfs4_ff_layout_select_ds_stateid(mirror, &hdr->args.stateid);
+	nfs4_ff_layout_select_ds_stateid(mirror, 0, &hdr->args.stateid);
 
 	/*
 	 * Note that if we ever decide to split across DSes,
@@ -1920,7 +1920,7 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	hdr->mds_offset = offset;
 
 	/* Start IO accounting for local read */
-	localio = ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh, FMODE_READ);
+	localio = ff_local_open_fh(lseg, idx, 0, ds->ds_clp, ds_cred, fh, FMODE_READ);
 	if (localio) {
 		hdr->task.tk_start = ktime_get();
 		ff_layout_read_record_layoutstats_start(&hdr->task, hdr);
@@ -1959,20 +1959,20 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	u32 idx = hdr->pgio_mirror_idx;
 
 	mirror = FF_LAYOUT_COMP(lseg, idx);
-	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, true);
+	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, 0, true);
 	if (!ds)
 		goto out_failed;
 
 	ds_clnt = nfs4_ff_find_or_create_ds_client(mirror, ds->ds_clp,
-						   hdr->inode);
+						   hdr->inode, 0);
 	if (IS_ERR(ds_clnt))
 		goto out_failed;
 
-	ds_cred = ff_layout_get_ds_cred(mirror, &lseg->pls_range, hdr->cred);
+	ds_cred = ff_layout_get_ds_cred(mirror, &lseg->pls_range, hdr->cred, 0);
 	if (!ds_cred)
 		goto out_failed;
 
-	vers = nfs4_ff_layout_ds_version(mirror);
+	vers = nfs4_ff_layout_ds_version(mirror, 0);
 
 	dprintk("%s ino %lu sync %d req %zu@%llu DS: %s cl_count %d vers %d\n",
 		__func__, hdr->inode->i_ino, sync, (size_t) hdr->args.count,
@@ -1983,11 +1983,11 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	refcount_inc(&ds->ds_clp->cl_count);
 	hdr->ds_clp = ds->ds_clp;
 	hdr->ds_commit_idx = idx;
-	fh = nfs4_ff_layout_select_ds_fh(mirror);
+	fh = nfs4_ff_layout_select_ds_fh(mirror, 0);
 	if (fh)
 		hdr->args.fh = fh;
 
-	nfs4_ff_layout_select_ds_stateid(mirror, &hdr->args.stateid);
+	nfs4_ff_layout_select_ds_stateid(mirror, 0, &hdr->args.stateid);
 
 	/*
 	 * Note that if we ever decide to split across DSes,
@@ -1996,7 +1996,7 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	hdr->args.offset = offset;
 
 	/* Start IO accounting for local write */
-	localio = ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh,
+	localio = ff_local_open_fh(lseg, idx, 0, ds->ds_clp, ds_cred, fh,
 				   FMODE_READ|FMODE_WRITE);
 	if (localio) {
 		hdr->task.tk_start = ktime_get();
@@ -2054,20 +2054,20 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 
 	idx = calc_ds_index_from_commit(lseg, data->ds_commit_index);
 	mirror = FF_LAYOUT_COMP(lseg, idx);
-	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, true);
+	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, 0, true);
 	if (!ds)
 		goto out_err;
 
 	ds_clnt = nfs4_ff_find_or_create_ds_client(mirror, ds->ds_clp,
-						   data->inode);
+						   data->inode, 0);
 	if (IS_ERR(ds_clnt))
 		goto out_err;
 
-	ds_cred = ff_layout_get_ds_cred(mirror, &lseg->pls_range, data->cred);
+	ds_cred = ff_layout_get_ds_cred(mirror, &lseg->pls_range, data->cred, 0);
 	if (!ds_cred)
 		goto out_err;
 
-	vers = nfs4_ff_layout_ds_version(mirror);
+	vers = nfs4_ff_layout_ds_version(mirror, 0);
 
 	dprintk("%s ino %lu, how %d cl_count %d vers %d\n", __func__,
 		data->inode->i_ino, how, refcount_read(&ds->ds_clp->cl_count),
@@ -2081,7 +2081,7 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 		data->args.fh = fh;
 
 	/* Start IO accounting for local commit */
-	localio = ff_local_open_fh(lseg, idx, ds->ds_clp, ds_cred, fh,
+	localio = ff_local_open_fh(lseg, idx, 0, ds->ds_clp, ds_cred, fh,
 				   FMODE_READ|FMODE_WRITE);
 	if (localio) {
 		data->task.tk_start = ktime_get();
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
index 14640452713b..142324d6d5c5 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.h
+++ b/fs/nfs/flexfilelayout/flexfilelayout.h
@@ -157,12 +157,12 @@ FF_LAYOUT_COMP(struct pnfs_layout_segment *lseg, u32 idx)
 }
 
 static inline struct nfs4_deviceid_node *
-FF_LAYOUT_DEVID_NODE(struct pnfs_layout_segment *lseg, u32 idx)
+FF_LAYOUT_DEVID_NODE(struct pnfs_layout_segment *lseg, u32 idx, u32 dss_id)
 {
 	struct nfs4_ff_layout_mirror *mirror = FF_LAYOUT_COMP(lseg, idx);
 
 	if (mirror != NULL) {
-		struct nfs4_ff_layout_ds *mirror_ds = mirror->dss[0].mirror_ds;
+		struct nfs4_ff_layout_ds *mirror_ds = mirror->dss[dss_id].mirror_ds;
 
 		if (!IS_ERR_OR_NULL(mirror_ds))
 			return &mirror_ds->id_node;
@@ -189,9 +189,22 @@ ff_layout_no_read_on_rw(struct pnfs_layout_segment *lseg)
 }
 
 static inline int
-nfs4_ff_layout_ds_version(const struct nfs4_ff_layout_mirror *mirror)
+nfs4_ff_layout_ds_version(const struct nfs4_ff_layout_mirror *mirror, u32 dss_id)
 {
-	return mirror->dss[0].mirror_ds->ds_versions[0].version;
+	return mirror->dss[dss_id].mirror_ds->ds_versions[0].version;
+}
+
+static inline u32
+nfs4_ff_layout_calc_dss_id(const u64 stripe_unit, const u32 dss_count, const loff_t offset)
+{
+	u64 tmp = offset;
+
+	if (dss_count == 1 || stripe_unit == 0)
+		return 0;
+
+	do_div(tmp, stripe_unit);
+
+	return do_div(tmp, dss_count);
 }
 
 struct nfs4_ff_layout_ds *
@@ -200,9 +213,9 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 void nfs4_ff_layout_put_deviceid(struct nfs4_ff_layout_ds *mirror_ds);
 void nfs4_ff_layout_free_deviceid(struct nfs4_ff_layout_ds *mirror_ds);
 int ff_layout_track_ds_error(struct nfs4_flexfile_layout *flo,
-			     struct nfs4_ff_layout_mirror *mirror, u64 offset,
-			     u64 length, int status, enum nfs_opnum4 opnum,
-			     gfp_t gfp_flags);
+			     struct nfs4_ff_layout_mirror *mirror,
+			     u32 dss_id, u64 offset, u64 length, int status,
+			     enum nfs_opnum4 opnum, gfp_t gfp_flags);
 void ff_layout_send_layouterror(struct pnfs_layout_segment *lseg);
 int ff_layout_encode_ds_ioerr(struct xdr_stream *xdr, const struct list_head *head);
 void ff_layout_free_ds_ioerr(struct list_head *head);
@@ -211,23 +224,27 @@ unsigned int ff_layout_fetch_ds_ioerr(struct pnfs_layout_hdr *lo,
 		struct list_head *head,
 		unsigned int maxnum);
 struct nfs_fh *
-nfs4_ff_layout_select_ds_fh(struct nfs4_ff_layout_mirror *mirror);
+nfs4_ff_layout_select_ds_fh(struct nfs4_ff_layout_mirror *mirror, u32 dss_id);
 void
 nfs4_ff_layout_select_ds_stateid(const struct nfs4_ff_layout_mirror *mirror,
-		nfs4_stateid *stateid);
+				 u32 dss_id,
+				 nfs4_stateid *stateid);
 
 struct nfs4_pnfs_ds *
 nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 			  struct nfs4_ff_layout_mirror *mirror,
+			  u32 dss_id,
 			  bool fail_return);
 
 struct rpc_clnt *
 nfs4_ff_find_or_create_ds_client(struct nfs4_ff_layout_mirror *mirror,
 				 struct nfs_client *ds_clp,
-				 struct inode *inode);
+				 struct inode *inode,
+				 u32 dss_id);
 const struct cred *ff_layout_get_ds_cred(struct nfs4_ff_layout_mirror *mirror,
 					 const struct pnfs_layout_range *range,
-					 const struct cred *mdscred);
+					 const struct cred *mdscred,
+					 u32 dss_id);
 bool ff_layout_avoid_mds_available_ds(struct pnfs_layout_segment *lseg);
 bool ff_layout_avoid_read_on_rw(struct pnfs_layout_segment *lseg);
 
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index f8ac9d8bd380..1d030b3a7008 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -250,16 +250,16 @@ ff_layout_add_ds_error_locked(struct nfs4_flexfile_layout *flo,
 }
 
 int ff_layout_track_ds_error(struct nfs4_flexfile_layout *flo,
-			     struct nfs4_ff_layout_mirror *mirror, u64 offset,
-			     u64 length, int status, enum nfs_opnum4 opnum,
-			     gfp_t gfp_flags)
+			     struct nfs4_ff_layout_mirror *mirror,
+			     u32 dss_id, u64 offset, u64 length, int status,
+			     enum nfs_opnum4 opnum, gfp_t gfp_flags)
 {
 	struct nfs4_ff_layout_ds_err *dserr;
 
 	if (status == 0)
 		return 0;
 
-	if (IS_ERR_OR_NULL(mirror->dss[0].mirror_ds))
+	if (IS_ERR_OR_NULL(mirror->dss[dss_id].mirror_ds))
 		return -EINVAL;
 
 	dserr = kmalloc(sizeof(*dserr), gfp_flags);
@@ -271,8 +271,8 @@ int ff_layout_track_ds_error(struct nfs4_flexfile_layout *flo,
 	dserr->length = length;
 	dserr->status = status;
 	dserr->opnum = opnum;
-	nfs4_stateid_copy(&dserr->stateid, &mirror->dss[0].stateid);
-	memcpy(&dserr->deviceid, &mirror->dss[0].mirror_ds->id_node.deviceid,
+	nfs4_stateid_copy(&dserr->stateid, &mirror->dss[dss_id].stateid);
+	memcpy(&dserr->deviceid, &mirror->dss[dss_id].mirror_ds->id_node.deviceid,
 	       NFS4_DEVICEID4_SIZE);
 
 	spin_lock(&flo->generic_hdr.plh_inode->i_lock);
@@ -282,14 +282,14 @@ int ff_layout_track_ds_error(struct nfs4_flexfile_layout *flo,
 }
 
 static const struct cred *
-ff_layout_get_mirror_cred(struct nfs4_ff_layout_mirror *mirror, u32 iomode)
+ff_layout_get_mirror_cred(struct nfs4_ff_layout_mirror *mirror, u32 iomode, u32 dss_id)
 {
 	const struct cred *cred, __rcu **pcred;
 
 	if (iomode == IOMODE_READ)
-		pcred = &mirror->dss[0].ro_cred;
+		pcred = &mirror->dss[dss_id].ro_cred;
 	else
-		pcred = &mirror->dss[0].rw_cred;
+		pcred = &mirror->dss[dss_id].rw_cred;
 
 	rcu_read_lock();
 	do {
@@ -304,43 +304,45 @@ ff_layout_get_mirror_cred(struct nfs4_ff_layout_mirror *mirror, u32 iomode)
 }
 
 struct nfs_fh *
-nfs4_ff_layout_select_ds_fh(struct nfs4_ff_layout_mirror *mirror)
+nfs4_ff_layout_select_ds_fh(struct nfs4_ff_layout_mirror *mirror, u32 dss_id)
 {
 	/* FIXME: For now assume there is only 1 version available for the DS */
-	return &mirror->dss[0].fh_versions[0];
+	return &mirror->dss[dss_id].fh_versions[0];
 }
 
 void
 nfs4_ff_layout_select_ds_stateid(const struct nfs4_ff_layout_mirror *mirror,
-		nfs4_stateid *stateid)
+				 u32 dss_id,
+				 nfs4_stateid *stateid)
 {
-	if (nfs4_ff_layout_ds_version(mirror) == 4)
-		nfs4_stateid_copy(stateid, &mirror->dss[0].stateid);
+	if (nfs4_ff_layout_ds_version(mirror, dss_id) == 4)
+		nfs4_stateid_copy(stateid, &mirror->dss[dss_id].stateid);
 }
 
 static bool
 ff_layout_init_mirror_ds(struct pnfs_layout_hdr *lo,
-			 struct nfs4_ff_layout_mirror *mirror)
+			 struct nfs4_ff_layout_mirror *mirror,
+			 u32 dss_id)
 {
 	if (mirror == NULL)
 		goto outerr;
-	if (mirror->dss[0].mirror_ds == NULL) {
+	if (mirror->dss[dss_id].mirror_ds == NULL) {
 		struct nfs4_deviceid_node *node;
 		struct nfs4_ff_layout_ds *mirror_ds = ERR_PTR(-ENODEV);
 
 		node = nfs4_find_get_deviceid(NFS_SERVER(lo->plh_inode),
-				&mirror->dss[0].devid, lo->plh_lc_cred,
+				&mirror->dss[dss_id].devid, lo->plh_lc_cred,
 				GFP_KERNEL);
 		if (node)
 			mirror_ds = FF_LAYOUT_MIRROR_DS(node);
 
 		/* check for race with another call to this function */
-		if (cmpxchg(&mirror->dss[0].mirror_ds, NULL, mirror_ds) &&
+		if (cmpxchg(&mirror->dss[dss_id].mirror_ds, NULL, mirror_ds) &&
 		    mirror_ds != ERR_PTR(-ENODEV))
 			nfs4_put_deviceid_node(node);
 	}
 
-	if (IS_ERR(mirror->dss[0].mirror_ds))
+	if (IS_ERR(mirror->dss[dss_id].mirror_ds))
 		goto outerr;
 
 	return true;
@@ -352,6 +354,7 @@ ff_layout_init_mirror_ds(struct pnfs_layout_hdr *lo,
  * nfs4_ff_layout_prepare_ds - prepare a DS connection for an RPC call
  * @lseg: the layout segment we're operating on
  * @mirror: layout mirror describing the DS to use
+ * @dss_id: DS stripe id to select stripe to use
  * @fail_return: return layout on connect failure?
  *
  * Try to prepare a DS connection to accept an RPC call. This involves
@@ -368,6 +371,7 @@ ff_layout_init_mirror_ds(struct pnfs_layout_hdr *lo,
 struct nfs4_pnfs_ds *
 nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 			  struct nfs4_ff_layout_mirror *mirror,
+			  u32 dss_id,
 			  bool fail_return)
 {
 	struct nfs4_pnfs_ds *ds = NULL;
@@ -376,10 +380,10 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 	unsigned int max_payload;
 	int status;
 
-	if (!ff_layout_init_mirror_ds(lseg->pls_layout, mirror))
+	if (!ff_layout_init_mirror_ds(lseg->pls_layout, mirror, dss_id))
 		goto noconnect;
 
-	ds = mirror->dss[0].mirror_ds->ds;
+	ds = mirror->dss[dss_id].mirror_ds->ds;
 	if (READ_ONCE(ds->ds_clp))
 		goto out;
 	/* matching smp_wmb() in _nfs4_pnfs_v3/4_ds_connect */
@@ -388,10 +392,10 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 	/* FIXME: For now we assume the server sent only one version of NFS
 	 * to use for the DS.
 	 */
-	status = nfs4_pnfs_ds_connect(s, ds, &mirror->dss[0].mirror_ds->id_node,
+	status = nfs4_pnfs_ds_connect(s, ds, &mirror->dss[dss_id].mirror_ds->id_node,
 			     dataserver_timeo, dataserver_retrans,
-			     mirror->dss[0].mirror_ds->ds_versions[0].version,
-			     mirror->dss[0].mirror_ds->ds_versions[0].minor_version);
+			     mirror->dss[dss_id].mirror_ds->ds_versions[0].version,
+			     mirror->dss[dss_id].mirror_ds->ds_versions[0].minor_version);
 
 	/* connect success, check rsize/wsize limit */
 	if (!status) {
@@ -404,15 +408,15 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 		max_payload =
 			nfs_block_size(rpc_max_payload(ds->ds_clp->cl_rpcclient),
 				       NULL);
-		if (mirror->dss[0].mirror_ds->ds_versions[0].rsize > max_payload)
-			mirror->dss[0].mirror_ds->ds_versions[0].rsize = max_payload;
-		if (mirror->dss[0].mirror_ds->ds_versions[0].wsize > max_payload)
-			mirror->dss[0].mirror_ds->ds_versions[0].wsize = max_payload;
+		if (mirror->dss[dss_id].mirror_ds->ds_versions[0].rsize > max_payload)
+			mirror->dss[dss_id].mirror_ds->ds_versions[0].rsize = max_payload;
+		if (mirror->dss[dss_id].mirror_ds->ds_versions[0].wsize > max_payload)
+			mirror->dss[dss_id].mirror_ds->ds_versions[0].wsize = max_payload;
 		goto out;
 	}
 noconnect:
 	ff_layout_track_ds_error(FF_LAYOUT_FROM_HDR(lseg->pls_layout),
-				 mirror, lseg->pls_range.offset,
+				 mirror, dss_id, lseg->pls_range.offset,
 				 lseg->pls_range.length, NFS4ERR_NXIO,
 				 OP_ILLEGAL, GFP_NOIO);
 	ff_layout_send_layouterror(lseg);
@@ -426,12 +430,13 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 const struct cred *
 ff_layout_get_ds_cred(struct nfs4_ff_layout_mirror *mirror,
 		      const struct pnfs_layout_range *range,
-		      const struct cred *mdscred)
+		      const struct cred *mdscred,
+		      u32 dss_id)
 {
 	const struct cred *cred;
 
-	if (mirror && !mirror->dss[0].mirror_ds->ds_versions[0].tightly_coupled) {
-		cred = ff_layout_get_mirror_cred(mirror, range->iomode);
+	if (mirror && !mirror->dss[dss_id].mirror_ds->ds_versions[0].tightly_coupled) {
+		cred = ff_layout_get_mirror_cred(mirror, range->iomode, dss_id);
 		if (!cred)
 			cred = get_cred(mdscred);
 	} else {
@@ -445,15 +450,17 @@ ff_layout_get_ds_cred(struct nfs4_ff_layout_mirror *mirror,
  * @mirror: pointer to the mirror
  * @ds_clp: nfs_client for the DS
  * @inode: pointer to inode
+ * @dss_id: DS stripe id
  *
  * Find or create a DS rpc client with th MDS server rpc client auth flavor
  * in the nfs_client cl_ds_clients list.
  */
 struct rpc_clnt *
 nfs4_ff_find_or_create_ds_client(struct nfs4_ff_layout_mirror *mirror,
-				 struct nfs_client *ds_clp, struct inode *inode)
+				 struct nfs_client *ds_clp, struct inode *inode,
+				 u32 dss_id)
 {
-	switch (mirror->dss[0].mirror_ds->ds_versions[0].version) {
+	switch (mirror->dss[dss_id].mirror_ds->ds_versions[0].version) {
 	case 3:
 		/* For NFSv3 DS, flavor is set when creating DS connections */
 		return ds_clp->cl_rpcclient;
@@ -559,18 +566,20 @@ static bool ff_read_layout_has_available_ds(struct pnfs_layout_segment *lseg)
 {
 	struct nfs4_ff_layout_mirror *mirror;
 	struct nfs4_deviceid_node *devid;
-	u32 idx;
+	u32 idx, dss_id;
 
 	for (idx = 0; idx < FF_LAYOUT_MIRROR_COUNT(lseg); idx++) {
 		mirror = FF_LAYOUT_COMP(lseg, idx);
 		if (mirror) {
-			if (!mirror->dss[0].mirror_ds)
-				return true;
-			if (IS_ERR(mirror->dss[0].mirror_ds))
-				continue;
-			devid = &mirror->dss[0].mirror_ds->id_node;
-			if (!nfs4_test_deviceid_unavailable(devid))
-				return true;
+			for (dss_id = 0; dss_id < mirror->dss_count; dss_id++) {
+				if (!mirror->dss[dss_id].mirror_ds)
+					return true;
+				if (IS_ERR(mirror->dss[dss_id].mirror_ds))
+					continue;
+				devid = &mirror->dss[dss_id].mirror_ds->id_node;
+				if (!nfs4_test_deviceid_unavailable(devid))
+					return true;
+			}
 		}
 	}
 
@@ -581,17 +590,19 @@ static bool ff_rw_layout_has_available_ds(struct pnfs_layout_segment *lseg)
 {
 	struct nfs4_ff_layout_mirror *mirror;
 	struct nfs4_deviceid_node *devid;
-	u32 idx;
+	u32 idx, dss_id;
 
 	for (idx = 0; idx < FF_LAYOUT_MIRROR_COUNT(lseg); idx++) {
 		mirror = FF_LAYOUT_COMP(lseg, idx);
-		if (!mirror || IS_ERR(mirror->dss[0].mirror_ds))
-			return false;
-		if (!mirror->dss[0].mirror_ds)
-			continue;
-		devid = &mirror->dss[0].mirror_ds->id_node;
-		if (nfs4_test_deviceid_unavailable(devid))
-			return false;
+		for (dss_id = 0; dss_id < mirror->dss_count; dss_id++) {
+			if (!mirror || IS_ERR(mirror->dss[dss_id].mirror_ds))
+				return false;
+			if (!mirror->dss[dss_id].mirror_ds)
+				continue;
+			devid = &mirror->dss[dss_id].mirror_ds->id_node;
+			if (nfs4_test_deviceid_unavailable(devid))
+				return false;
+		}
 	}
 
 	return FF_LAYOUT_MIRROR_COUNT(lseg) != 0;
-- 
2.34.1


