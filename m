Return-Path: <linux-nfs+bounces-14564-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E5FB84E06
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 15:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80CB5B605D3
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 13:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D10211C;
	Thu, 18 Sep 2025 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NF6iau6x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E3D515
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202423; cv=none; b=lY/e6YGSnCaz6WpcbzGDvR+JMaDaqdPrVoUNv7ktWOY4IE0MYILezCVBtIWiSK4jZqf8unv/K46OyAnFbMDhVPPz8kAUSgKutZe8JnfhiX1pUGxKiNi9l06aCrZeCgfE6W+nbC7Cg1a+9pB3U1WAVmbDzdVbQObJsJcw4A67FOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202423; c=relaxed/simple;
	bh=yG79RcLeLh8NZgHHq6fEPrN6mIdrYAzSaa3mMewAgS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wgf/5Swpoc8NWxXMMMUW3EW5+onee1pEGfTUCfJidK147996C7jyBrQSejcrddJZnxTw2IFNobalNvh9b9dCCXbMjDHA6aaD5D1YupCxVm39XMWtTKMI0X1m5mwbbkQsTJYWJDn9EtVDqJ1zvXz/D0aWitgLaeSAlE7SeiM8ABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NF6iau6x; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62f0bf564e4so1119690a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 06:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758202420; x=1758807220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqsXTrCjBaG2L/JC16f+4TqWh7675qYIclByh3xao/Y=;
        b=NF6iau6xHg+ef/8oZXw4YOhnzSgN/uIDq+hMr4T2o67Y3l1BU7fU2GjcxO2tz6wHhx
         c1xCYJoSDDR+HyjJLkBbhFjun/CafRQg4iN2e8hC/0yWSC0ZJVCUwZDMJf7g4mVCZE5M
         qguMixzDuW/UCBOQwu8YATrAPQrvKm65E+Sn6LxBApbesbW330dELGV2d5hy8v2q8aCo
         K9XzLqqpUjQLZO2V2Frb+LwOpphog/DPQ7QRDDi0XO/lWDBtVTBX7Isz9RWiH/E8CCBu
         hQ8DGt0zF640wicdUxs9NZrZVoK2IvStRPEaZly6Tqrp8V3SOTGj12dNeB/ljoDh4WDR
         7EGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202420; x=1758807220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqsXTrCjBaG2L/JC16f+4TqWh7675qYIclByh3xao/Y=;
        b=kWQwipA3fVPCZv50H++W8G7Jgxu0hZ2F1Lv1fFRWUutevcFOO6BVdmA3JUoxJkyYMn
         w19AklzqIr6w1sEt4lsnyih3Z8o+PIMPyTzT2lk0bSqq0pBDwXyh2JXh63Xr6vg8h4Ji
         Q/Ov2B/20d1Y3xHgEQhAnl/X08lItL2KScrjibL7eRQYNNGV7zZ76UpZ5U3p+IOW8fhd
         mB7zTnno+JM0+aSAAyL+AdlDDjzZaVim8/K2GJW/gPKWRG383pFSNtjLvH8/tddINp1K
         Rp1+euIgAndNLa5rZ05VWYOYaoJPmcXPGiOjTmy5QEpcvB2KHTypLu56DgHDETzOFkM5
         oSFw==
X-Forwarded-Encrypted: i=1; AJvYcCVTAWRrsiSVLxHFKP6KPM/hhQNNzALIyTCTMKUQnieRgfIk6XL+NoO5GjECYAUWSKWfYMg96q8N5LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKzN+MQLU17Fl+X34vEQaCrWrfa99K26QhAdVCbaBleITukcaB
	dUjKvrIGKll4I0ssxuBLtjnAtglJu5oejx5tX0kTDojVjG6KirVQ9incq59HUMH9yUs=
X-Gm-Gg: ASbGncveiNcFwFjTfYsKlgx7xYG8kAMeowP0W7kCV8HeUvKY6EjvnYqlbOqBQDjU5LU
	F9gxof12C7cza7bnM2UhgQxRqWKG1CgR4vph2VshBNs5TZvoI9t8bCY4bR1CZW6RY2+49E4t2aG
	mM4bsehOkAj51DkCV+wEBdbXk4uZcHy0twI7+pscBEkbrGXb6tVaSpZlSKWNOEU0CgqIrCsStpA
	U9gIzn4tD736D8MeEVyQK0Z+VCgh652bSFI7OcVIKgtbiDJpFI6dH3n9OeDVyvkq7/GRZty3zrH
	a/N3gliko1guj8J6ZJN7cSL9aE3d0agEzbC+LYyq7RnItXFl03z7D2OWaUHas+Q48ta62CV+Fi8
	RuAySFP1JIXtwtvd9MOLY147aHdI95G9tYY3VlBvH1A==
X-Google-Smtp-Source: AGHT+IHoG3DwcI7azk+sEMTXqJooz9aVQh3TAr4+TRZpWPIhnbPRuQSYWxb0uXi9MeRSKQ/wD8agyw==
X-Received: by 2002:a05:6402:52c1:b0:61a:8941:2686 with SMTP id 4fb4d7f45d1cf-62f84024f14mr5688323a12.15.1758202419607;
        Thu, 18 Sep 2025 06:33:39 -0700 (PDT)
Received: from localhost ([208.88.158.129])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62fa5d4189bsm1455617a12.19.2025.09.18.06.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 06:33:39 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v3 8/9] NFSv4/flexfiles: Update layout stats & error paths for striped layouts
Date: Thu, 18 Sep 2025 13:33:09 +0000
Message-Id: <20250918133310.508943-9-jcurley@purestorage.com>
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

Updates the layout stats logic to be stripe aware. Read and write
stats are accumulated on a per DS stripe basis. Also updates error
paths to use dss_id where appropraite.

Limitations:

1. The layout stats structure is still statically sized to 4 and there
is no deduplication logic for deviceids that may appear more than once
in a striped layout.

Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 312 +++++++++++++++++--------
 1 file changed, 209 insertions(+), 103 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 5c4aebe9b905..fa1214659df7 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -47,7 +47,7 @@ ff_layout_mirror_prepare_stats(struct pnfs_layout_hdr *lo,
 			       int dev_limit, enum nfs4_ff_op_type type);
 static void ff_layout_encode_ff_layoutupdate(struct xdr_stream *xdr,
 			      const struct nfs42_layoutstat_devinfo *devinfo,
-			      struct nfs4_ff_layout_mirror *mirror);
+			      struct nfs4_ff_layout_ds_stripe *dss_info);
 
 static struct pnfs_layout_hdr *
 ff_layout_alloc_layout_hdr(struct inode *inode, gfp_t gfp_flags)
@@ -657,6 +657,7 @@ nfs4_ff_end_busy_timer(struct nfs4_ff_busy_timer *timer, ktime_t now)
 
 static bool
 nfs4_ff_layoutstat_start_io(struct nfs4_ff_layout_mirror *mirror,
+			    u32 dss_id,
 			    struct nfs4_ff_layoutstat *layoutstat,
 			    ktime_t now)
 {
@@ -664,8 +665,8 @@ nfs4_ff_layoutstat_start_io(struct nfs4_ff_layout_mirror *mirror,
 	struct nfs4_flexfile_layout *ffl = FF_LAYOUT_FROM_HDR(mirror->layout);
 
 	nfs4_ff_start_busy_timer(&layoutstat->busy_timer, now);
-	if (!mirror->dss[0].start_time)
-		mirror->dss[0].start_time = now;
+	if (!mirror->dss[dss_id].start_time)
+		mirror->dss[dss_id].start_time = now;
 	if (mirror->report_interval != 0)
 		report_interval = (s64)mirror->report_interval * 1000LL;
 	else if (layoutstats_timer != 0)
@@ -715,13 +716,16 @@ nfs4_ff_layout_stat_io_update_completed(struct nfs4_ff_layoutstat *layoutstat,
 static void
 nfs4_ff_layout_stat_io_start_read(struct inode *inode,
 		struct nfs4_ff_layout_mirror *mirror,
+		u32 dss_id,
 		__u64 requested, ktime_t now)
 {
 	bool report;
 
 	spin_lock(&mirror->lock);
-	report = nfs4_ff_layoutstat_start_io(mirror, &mirror->dss[0].read_stat, now);
-	nfs4_ff_layout_stat_io_update_requested(&mirror->dss[0].read_stat, requested);
+	report = nfs4_ff_layoutstat_start_io(
+		mirror, dss_id, &mirror->dss[dss_id].read_stat, now);
+	nfs4_ff_layout_stat_io_update_requested(
+		&mirror->dss[dss_id].read_stat, requested);
 	set_bit(NFS4_FF_MIRROR_STAT_AVAIL, &mirror->flags);
 	spin_unlock(&mirror->lock);
 
@@ -732,11 +736,12 @@ nfs4_ff_layout_stat_io_start_read(struct inode *inode,
 static void
 nfs4_ff_layout_stat_io_end_read(struct rpc_task *task,
 		struct nfs4_ff_layout_mirror *mirror,
+		u32 dss_id,
 		__u64 requested,
 		__u64 completed)
 {
 	spin_lock(&mirror->lock);
-	nfs4_ff_layout_stat_io_update_completed(&mirror->dss[0].read_stat,
+	nfs4_ff_layout_stat_io_update_completed(&mirror->dss[dss_id].read_stat,
 			requested, completed,
 			ktime_get(), task->tk_start);
 	set_bit(NFS4_FF_MIRROR_STAT_AVAIL, &mirror->flags);
@@ -746,13 +751,20 @@ nfs4_ff_layout_stat_io_end_read(struct rpc_task *task,
 static void
 nfs4_ff_layout_stat_io_start_write(struct inode *inode,
 		struct nfs4_ff_layout_mirror *mirror,
+		u32 dss_id,
 		__u64 requested, ktime_t now)
 {
 	bool report;
 
 	spin_lock(&mirror->lock);
-	report = nfs4_ff_layoutstat_start_io(mirror, &mirror->dss[0].write_stat, now);
-	nfs4_ff_layout_stat_io_update_requested(&mirror->dss[0].write_stat, requested);
+	report = nfs4_ff_layoutstat_start_io(
+		mirror,
+		dss_id,
+		&mirror->dss[dss_id].write_stat,
+		now);
+	nfs4_ff_layout_stat_io_update_requested(
+		&mirror->dss[dss_id].write_stat,
+		requested);
 	set_bit(NFS4_FF_MIRROR_STAT_AVAIL, &mirror->flags);
 	spin_unlock(&mirror->lock);
 
@@ -763,6 +775,7 @@ nfs4_ff_layout_stat_io_start_write(struct inode *inode,
 static void
 nfs4_ff_layout_stat_io_end_write(struct rpc_task *task,
 		struct nfs4_ff_layout_mirror *mirror,
+		u32 dss_id,
 		__u64 requested,
 		__u64 completed,
 		enum nfs3_stable_how committed)
@@ -771,25 +784,25 @@ nfs4_ff_layout_stat_io_end_write(struct rpc_task *task,
 		requested = completed = 0;
 
 	spin_lock(&mirror->lock);
-	nfs4_ff_layout_stat_io_update_completed(&mirror->dss[0].write_stat,
+	nfs4_ff_layout_stat_io_update_completed(&mirror->dss[dss_id].write_stat,
 			requested, completed, ktime_get(), task->tk_start);
 	set_bit(NFS4_FF_MIRROR_STAT_AVAIL, &mirror->flags);
 	spin_unlock(&mirror->lock);
 }
 
 static void
-ff_layout_mark_ds_unreachable(struct pnfs_layout_segment *lseg, u32 idx)
+ff_layout_mark_ds_unreachable(struct pnfs_layout_segment *lseg, u32 idx, u32 dss_id)
 {
-	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx, 0);
+	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx, dss_id);
 
 	if (devid)
 		nfs4_mark_deviceid_unavailable(devid);
 }
 
 static void
-ff_layout_mark_ds_reachable(struct pnfs_layout_segment *lseg, u32 idx)
+ff_layout_mark_ds_reachable(struct pnfs_layout_segment *lseg, u32 idx, u32 dss_id)
 {
-	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx, 0);
+	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx, dss_id);
 
 	if (devid)
 		nfs4_mark_deviceid_available(devid);
@@ -1222,11 +1235,11 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 					   struct nfs4_state *state,
 					   struct nfs_client *clp,
 					   struct pnfs_layout_segment *lseg,
-					   u32 idx)
+					   u32 idx, u32 dss_id)
 {
 	struct pnfs_layout_hdr *lo = lseg->pls_layout;
 	struct inode *inode = lo->plh_inode;
-	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx, 0);
+	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx, dss_id);
 	struct nfs4_slot_table *tbl = &clp->cl_session->fc_slot_table;
 
 	switch (op_status) {
@@ -1323,9 +1336,9 @@ static int ff_layout_async_handle_error_v3(struct rpc_task *task,
 					   u32 op_status,
 					   struct nfs_client *clp,
 					   struct pnfs_layout_segment *lseg,
-					   u32 idx)
+					   u32 idx, u32 dss_id)
 {
-	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx, 0);
+	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx, dss_id);
 
 	switch (op_status) {
 	case NFS_OK:
@@ -1389,12 +1402,12 @@ static int ff_layout_async_handle_error(struct rpc_task *task,
 					struct nfs4_state *state,
 					struct nfs_client *clp,
 					struct pnfs_layout_segment *lseg,
-					u32 idx)
+					u32 idx, u32 dss_id)
 {
 	int vers = clp->cl_nfs_mod->rpc_vers->number;
 
 	if (task->tk_status >= 0) {
-		ff_layout_mark_ds_reachable(lseg, idx);
+		ff_layout_mark_ds_reachable(lseg, idx, dss_id);
 		return 0;
 	}
 
@@ -1405,10 +1418,10 @@ static int ff_layout_async_handle_error(struct rpc_task *task,
 	switch (vers) {
 	case 3:
 		return ff_layout_async_handle_error_v3(task, op_status, clp,
-						       lseg, idx);
+						       lseg, idx, dss_id);
 	case 4:
 		return ff_layout_async_handle_error_v4(task, op_status, state,
-						       clp, lseg, idx);
+						       clp, lseg, idx, dss_id);
 	default:
 		/* should never happen */
 		WARN_ON_ONCE(1);
@@ -1417,7 +1430,7 @@ static int ff_layout_async_handle_error(struct rpc_task *task,
 }
 
 static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
-					u32 idx, u64 offset, u64 length,
+					u32 idx, u32 dss_id, u64 offset, u64 length,
 					u32 *op_status, int opnum, int error)
 {
 	struct nfs4_ff_layout_mirror *mirror;
@@ -1455,7 +1468,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 
 	mirror = FF_LAYOUT_COMP(lseg, idx);
 	err = ff_layout_track_ds_error(FF_LAYOUT_FROM_HDR(lseg->pls_layout),
-				       mirror, 0, offset, length, status, opnum,
+				       mirror, dss_id, offset, length, status, opnum,
 				       nfs_io_gfp_mask());
 
 	switch (status) {
@@ -1464,7 +1477,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 	case NFS4ERR_PERM:
 		break;
 	case NFS4ERR_NXIO:
-		ff_layout_mark_ds_unreachable(lseg, idx);
+		ff_layout_mark_ds_unreachable(lseg, idx, dss_id);
 		/*
 		 * Don't return the layout if this is a read and we still
 		 * have layouts to try
@@ -1484,10 +1497,16 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 static int ff_layout_read_done_cb(struct rpc_task *task,
 				struct nfs_pgio_header *hdr)
 {
+	struct nfs4_ff_layout_segment *flseg = FF_LAYOUT_LSEG(hdr->lseg);
+	u32 dss_id = nfs4_ff_layout_calc_dss_id(
+		flseg->stripe_unit,
+		flseg->mirror_array[hdr->pgio_mirror_idx]->dss_count,
+		hdr->args.offset);
 	int err;
 
 	if (task->tk_status < 0) {
-		ff_layout_io_track_ds_error(hdr->lseg, hdr->pgio_mirror_idx,
+		ff_layout_io_track_ds_error(hdr->lseg,
+					    hdr->pgio_mirror_idx, dss_id,
 					    hdr->args.offset, hdr->args.count,
 					    &hdr->res.op_status, OP_READ,
 					    task->tk_status);
@@ -1497,7 +1516,8 @@ static int ff_layout_read_done_cb(struct rpc_task *task,
 	err = ff_layout_async_handle_error(task, hdr->res.op_status,
 					   hdr->args.context->state,
 					   hdr->ds_clp, hdr->lseg,
-					   hdr->pgio_mirror_idx);
+					   hdr->pgio_mirror_idx,
+					   dss_id);
 
 	trace_nfs4_pnfs_read(hdr, err);
 	clear_bit(NFS_IOHDR_RESEND_PNFS, &hdr->flags);
@@ -1553,23 +1573,47 @@ ff_layout_set_layoutcommit(struct inode *inode,
 static void ff_layout_read_record_layoutstats_start(struct rpc_task *task,
 		struct nfs_pgio_header *hdr)
 {
+	struct nfs4_ff_layout_mirror *mirror;
+	u32 dss_id;
+
 	if (test_and_set_bit(NFS_IOHDR_STAT, &hdr->flags))
 		return;
-	nfs4_ff_layout_stat_io_start_read(hdr->inode,
-			FF_LAYOUT_COMP(hdr->lseg, hdr->pgio_mirror_idx),
-			hdr->args.count,
-			task->tk_start);
+
+	mirror = FF_LAYOUT_COMP(hdr->lseg, hdr->pgio_mirror_idx);
+	dss_id = nfs4_ff_layout_calc_dss_id(
+		FF_LAYOUT_LSEG(hdr->lseg)->stripe_unit,
+		mirror->dss_count,
+		hdr->args.offset);
+
+	nfs4_ff_layout_stat_io_start_read(
+		hdr->inode,
+		mirror,
+		dss_id,
+		hdr->args.count,
+		task->tk_start);
 }
 
 static void ff_layout_read_record_layoutstats_done(struct rpc_task *task,
 		struct nfs_pgio_header *hdr)
 {
+	struct nfs4_ff_layout_mirror *mirror;
+	u32 dss_id;
+
 	if (!test_and_clear_bit(NFS_IOHDR_STAT, &hdr->flags))
 		return;
-	nfs4_ff_layout_stat_io_end_read(task,
-			FF_LAYOUT_COMP(hdr->lseg, hdr->pgio_mirror_idx),
-			hdr->args.count,
-			hdr->res.count);
+
+	mirror = FF_LAYOUT_COMP(hdr->lseg, hdr->pgio_mirror_idx);
+	dss_id = nfs4_ff_layout_calc_dss_id(
+		FF_LAYOUT_LSEG(hdr->lseg)->stripe_unit,
+		mirror->dss_count,
+		hdr->args.offset);
+
+	nfs4_ff_layout_stat_io_end_read(
+		task,
+		mirror,
+		dss_id,
+		hdr->args.count,
+		hdr->res.count);
 	set_bit(NFS_LSEG_LAYOUTRETURN, &hdr->lseg->pls_flags);
 }
 
@@ -1657,11 +1701,17 @@ static void ff_layout_read_release(void *data)
 static int ff_layout_write_done_cb(struct rpc_task *task,
 				struct nfs_pgio_header *hdr)
 {
+	struct nfs4_ff_layout_segment *flseg = FF_LAYOUT_LSEG(hdr->lseg);
+	u32 dss_id = nfs4_ff_layout_calc_dss_id(
+		flseg->stripe_unit,
+		flseg->mirror_array[hdr->pgio_mirror_idx]->dss_count,
+		hdr->args.offset);
 	loff_t end_offs = 0;
 	int err;
 
 	if (task->tk_status < 0) {
-		ff_layout_io_track_ds_error(hdr->lseg, hdr->pgio_mirror_idx,
+		ff_layout_io_track_ds_error(hdr->lseg,
+					    hdr->pgio_mirror_idx, dss_id,
 					    hdr->args.offset, hdr->args.count,
 					    &hdr->res.op_status, OP_WRITE,
 					    task->tk_status);
@@ -1671,7 +1721,8 @@ static int ff_layout_write_done_cb(struct rpc_task *task,
 	err = ff_layout_async_handle_error(task, hdr->res.op_status,
 					   hdr->args.context->state,
 					   hdr->ds_clp, hdr->lseg,
-					   hdr->pgio_mirror_idx);
+					   hdr->pgio_mirror_idx,
+					   dss_id);
 
 	trace_nfs4_pnfs_write(hdr, err);
 	clear_bit(NFS_IOHDR_RESEND_PNFS, &hdr->flags);
@@ -1709,9 +1760,11 @@ static int ff_layout_commit_done_cb(struct rpc_task *task,
 				     struct nfs_commit_data *data)
 {
 	int err;
+	u32 idx = calc_mirror_idx_from_commit(data->lseg, data->ds_commit_index);
+	u32 dss_id = calc_dss_id_from_commit(data->lseg, data->ds_commit_index);
 
 	if (task->tk_status < 0) {
-		ff_layout_io_track_ds_error(data->lseg, data->ds_commit_index,
+		ff_layout_io_track_ds_error(data->lseg, idx, dss_id,
 					    data->args.offset, data->args.count,
 					    &data->res.op_status, OP_COMMIT,
 					    task->tk_status);
@@ -1719,8 +1772,8 @@ static int ff_layout_commit_done_cb(struct rpc_task *task,
 	}
 
 	err = ff_layout_async_handle_error(task, data->res.op_status,
-					   NULL, data->ds_clp, data->lseg,
-					   data->ds_commit_index);
+					   NULL, data->ds_clp, data->lseg, idx,
+					   dss_id);
 
 	trace_nfs4_pnfs_commit_ds(data, err);
 	switch (err) {
@@ -1739,30 +1792,54 @@ static int ff_layout_commit_done_cb(struct rpc_task *task,
 	}
 
 	ff_layout_set_layoutcommit(data->inode, data->lseg, data->lwb);
-
 	return 0;
 }
 
 static void ff_layout_write_record_layoutstats_start(struct rpc_task *task,
 		struct nfs_pgio_header *hdr)
 {
+	struct nfs4_ff_layout_mirror *mirror;
+	u32 dss_id;
+
 	if (test_and_set_bit(NFS_IOHDR_STAT, &hdr->flags))
 		return;
-	nfs4_ff_layout_stat_io_start_write(hdr->inode,
-			FF_LAYOUT_COMP(hdr->lseg, hdr->pgio_mirror_idx),
-			hdr->args.count,
-			task->tk_start);
+
+	mirror = FF_LAYOUT_COMP(hdr->lseg, hdr->pgio_mirror_idx);
+	dss_id = nfs4_ff_layout_calc_dss_id(
+		FF_LAYOUT_LSEG(hdr->lseg)->stripe_unit,
+		mirror->dss_count,
+		hdr->args.offset);
+
+	nfs4_ff_layout_stat_io_start_write(
+		hdr->inode,
+		mirror,
+		dss_id,
+		hdr->args.count,
+		task->tk_start);
 }
 
 static void ff_layout_write_record_layoutstats_done(struct rpc_task *task,
 		struct nfs_pgio_header *hdr)
 {
+	struct nfs4_ff_layout_mirror *mirror;
+	u32 dss_id;
+
 	if (!test_and_clear_bit(NFS_IOHDR_STAT, &hdr->flags))
 		return;
-	nfs4_ff_layout_stat_io_end_write(task,
-			FF_LAYOUT_COMP(hdr->lseg, hdr->pgio_mirror_idx),
-			hdr->args.count, hdr->res.count,
-			hdr->res.verf->committed);
+
+	mirror = FF_LAYOUT_COMP(hdr->lseg, hdr->pgio_mirror_idx);
+	dss_id = nfs4_ff_layout_calc_dss_id(
+		FF_LAYOUT_LSEG(hdr->lseg)->stripe_unit,
+		mirror->dss_count,
+		hdr->args.offset);
+
+	nfs4_ff_layout_stat_io_end_write(
+		task,
+		mirror,
+		dss_id,
+		hdr->args.count,
+		hdr->res.count,
+		hdr->res.verf->committed);
 	set_bit(NFS_LSEG_LAYOUTRETURN, &hdr->lseg->pls_flags);
 }
 
@@ -1845,10 +1922,16 @@ static void ff_layout_write_release(void *data)
 static void ff_layout_commit_record_layoutstats_start(struct rpc_task *task,
 		struct nfs_commit_data *cdata)
 {
+	u32 idx, dss_id;
+
 	if (test_and_set_bit(NFS_IOHDR_STAT, &cdata->flags))
 		return;
+
+	idx = calc_mirror_idx_from_commit(cdata->lseg, cdata->ds_commit_index);
+	dss_id = calc_dss_id_from_commit(cdata->lseg, cdata->ds_commit_index);
 	nfs4_ff_layout_stat_io_start_write(cdata->inode,
-			FF_LAYOUT_COMP(cdata->lseg, cdata->ds_commit_index),
+			FF_LAYOUT_COMP(cdata->lseg, idx),
+			dss_id,
 			0, task->tk_start);
 }
 
@@ -1857,6 +1940,7 @@ static void ff_layout_commit_record_layoutstats_done(struct rpc_task *task,
 {
 	struct nfs_page *req;
 	__u64 count = 0;
+	u32 idx, dss_id;
 
 	if (!test_and_clear_bit(NFS_IOHDR_STAT, &cdata->flags))
 		return;
@@ -1865,8 +1949,12 @@ static void ff_layout_commit_record_layoutstats_done(struct rpc_task *task,
 		list_for_each_entry(req, &cdata->pages, wb_list)
 			count += req->wb_bytes;
 	}
+
+	idx = calc_mirror_idx_from_commit(cdata->lseg, cdata->ds_commit_index);
+	dss_id = calc_dss_id_from_commit(cdata->lseg, cdata->ds_commit_index);
 	nfs4_ff_layout_stat_io_end_write(task,
-			FF_LAYOUT_COMP(cdata->lseg, cdata->ds_commit_index),
+			FF_LAYOUT_COMP(cdata->lseg, idx),
+			dss_id,
 			count, count, NFS_FILE_SYNC);
 	set_bit(NFS_LSEG_LAYOUTRETURN, &cdata->lseg->pls_flags);
 }
@@ -2253,25 +2341,28 @@ static void ff_layout_cancel_io(struct pnfs_layout_segment *lseg)
 	struct nfs4_pnfs_ds *ds;
 	struct nfs_client *ds_clp;
 	struct rpc_clnt *clnt;
-	u32 idx;
+	u32 idx, dss_id;
 
 	for (idx = 0; idx < flseg->mirror_array_cnt; idx++) {
 		mirror = flseg->mirror_array[idx];
-		mirror_ds = mirror->dss[0].mirror_ds;
-		if (IS_ERR_OR_NULL(mirror_ds))
-			continue;
-		ds = mirror->dss[0].mirror_ds->ds;
-		if (!ds)
-			continue;
-		ds_clp = ds->ds_clp;
-		if (!ds_clp)
-			continue;
-		clnt = ds_clp->cl_rpcclient;
-		if (!clnt)
-			continue;
-		if (!rpc_cancel_tasks(clnt, -EAGAIN, ff_layout_match_io, lseg))
-			continue;
-		rpc_clnt_disconnect(clnt);
+		for (dss_id = 0; dss_id < mirror->dss_count; dss_id++) {
+			mirror_ds = mirror->dss[dss_id].mirror_ds;
+			if (IS_ERR_OR_NULL(mirror_ds))
+				continue;
+			ds = mirror->dss[dss_id].mirror_ds->ds;
+			if (!ds)
+				continue;
+			ds_clp = ds->ds_clp;
+			if (!ds_clp)
+				continue;
+			clnt = ds_clp->cl_rpcclient;
+			if (!clnt)
+				continue;
+			if (!rpc_cancel_tasks(clnt, -EAGAIN,
+					      ff_layout_match_io, lseg))
+				continue;
+			rpc_clnt_disconnect(clnt);
+		}
 	}
 }
 
@@ -2659,11 +2750,11 @@ ff_layout_encode_io_latency(struct xdr_stream *xdr,
 static void
 ff_layout_encode_ff_layoutupdate(struct xdr_stream *xdr,
 			      const struct nfs42_layoutstat_devinfo *devinfo,
-			      struct nfs4_ff_layout_mirror *mirror)
+			      struct nfs4_ff_layout_ds_stripe *dss_info)
 {
 	struct nfs4_pnfs_ds_addr *da;
-	struct nfs4_pnfs_ds *ds = mirror->dss[0].mirror_ds->ds;
-	struct nfs_fh *fh = &mirror->dss[0].fh_versions[0];
+	struct nfs4_pnfs_ds *ds = dss_info->mirror_ds->ds;
+	struct nfs_fh *fh = &dss_info->fh_versions[0];
 	__be32 *p;
 
 	da = list_first_entry(&ds->ds_addrs, struct nfs4_pnfs_ds_addr, da_node);
@@ -2675,13 +2766,17 @@ ff_layout_encode_ff_layoutupdate(struct xdr_stream *xdr,
 	p = xdr_reserve_space(xdr, 4 + fh->size);
 	xdr_encode_opaque(p, fh->data, fh->size);
 	/* ff_io_latency4 read */
-	spin_lock(&mirror->lock);
-	ff_layout_encode_io_latency(xdr, &mirror->dss[0].read_stat.io_stat);
+	spin_lock(&dss_info->mirror->lock);
+	ff_layout_encode_io_latency(xdr,
+				    &dss_info->read_stat.io_stat);
 	/* ff_io_latency4 write */
-	ff_layout_encode_io_latency(xdr, &mirror->dss[0].write_stat.io_stat);
-	spin_unlock(&mirror->lock);
+	ff_layout_encode_io_latency(xdr,
+				    &dss_info->write_stat.io_stat);
+	spin_unlock(&dss_info->mirror->lock);
 	/* nfstime4 */
-	ff_layout_encode_nfstime(xdr, ktime_sub(ktime_get(), mirror->dss[0].start_time));
+	ff_layout_encode_nfstime(xdr,
+				 ktime_sub(ktime_get(),
+					   dss_info->start_time));
 	/* bool */
 	p = xdr_reserve_space(xdr, 4);
 	*p = cpu_to_be32(false);
@@ -2705,7 +2800,8 @@ ff_layout_encode_layoutstats(struct xdr_stream *xdr, const void *args,
 static void
 ff_layout_free_layoutstats(struct nfs4_xdr_opaque_data *opaque)
 {
-	struct nfs4_ff_layout_mirror *mirror = opaque->data;
+	struct nfs4_ff_layout_ds_stripe *dss_info = opaque->data;
+	struct nfs4_ff_layout_mirror *mirror = dss_info->mirror;
 
 	ff_layout_put_mirror(mirror);
 }
@@ -2722,37 +2818,47 @@ ff_layout_mirror_prepare_stats(struct pnfs_layout_hdr *lo,
 {
 	struct nfs4_flexfile_layout *ff_layout = FF_LAYOUT_FROM_HDR(lo);
 	struct nfs4_ff_layout_mirror *mirror;
+	struct nfs4_ff_layout_ds_stripe *dss_info;
 	struct nfs4_deviceid_node *dev;
-	int i = 0;
+	int i = 0, dss_id;
 
 	list_for_each_entry(mirror, &ff_layout->mirrors, mirrors) {
-		if (i >= dev_limit)
-			break;
-		if (IS_ERR_OR_NULL(mirror->dss[0].mirror_ds))
-			continue;
-		if (!test_and_clear_bit(NFS4_FF_MIRROR_STAT_AVAIL,
-					&mirror->flags) &&
-		    type != NFS4_FF_OP_LAYOUTRETURN)
-			continue;
-		/* mirror refcount put in cleanup_layoutstats */
-		if (!refcount_inc_not_zero(&mirror->ref))
-			continue;
-		dev = &mirror->dss[0].mirror_ds->id_node;
-		memcpy(&devinfo->dev_id, &dev->deviceid, NFS4_DEVICEID4_SIZE);
-		devinfo->offset = 0;
-		devinfo->length = NFS4_MAX_UINT64;
-		spin_lock(&mirror->lock);
-		devinfo->read_count = mirror->dss[0].read_stat.io_stat.ops_completed;
-		devinfo->read_bytes = mirror->dss[0].read_stat.io_stat.bytes_completed;
-		devinfo->write_count = mirror->dss[0].write_stat.io_stat.ops_completed;
-		devinfo->write_bytes = mirror->dss[0].write_stat.io_stat.bytes_completed;
-		spin_unlock(&mirror->lock);
-		devinfo->layout_type = LAYOUT_FLEX_FILES;
-		devinfo->ld_private.ops = &layoutstat_ops;
-		devinfo->ld_private.data = mirror;
-
-		devinfo++;
-		i++;
+		for (dss_id = 0; dss_id < mirror->dss_count; ++dss_id) {
+			dss_info = &mirror->dss[dss_id];
+			if (i >= dev_limit)
+				break;
+			if (IS_ERR_OR_NULL(dss_info->mirror_ds))
+				continue;
+			if (!test_and_clear_bit(NFS4_FF_MIRROR_STAT_AVAIL,
+						&mirror->flags) &&
+			    type != NFS4_FF_OP_LAYOUTRETURN)
+				continue;
+			/* mirror refcount put in cleanup_layoutstats */
+			if (!refcount_inc_not_zero(&mirror->ref))
+				continue;
+			dev = &dss_info->mirror_ds->id_node;
+			memcpy(&devinfo->dev_id,
+			       &dev->deviceid,
+			       NFS4_DEVICEID4_SIZE);
+			devinfo->offset = 0;
+			devinfo->length = NFS4_MAX_UINT64;
+			spin_lock(&mirror->lock);
+			devinfo->read_count =
+			    dss_info->read_stat.io_stat.ops_completed;
+			devinfo->read_bytes =
+			    dss_info->read_stat.io_stat.bytes_completed;
+			devinfo->write_count =
+			    dss_info->write_stat.io_stat.ops_completed;
+			devinfo->write_bytes =
+			    dss_info->write_stat.io_stat.bytes_completed;
+			spin_unlock(&mirror->lock);
+			devinfo->layout_type = LAYOUT_FLEX_FILES;
+			devinfo->ld_private.ops = &layoutstat_ops;
+			devinfo->ld_private.data = &mirror->dss[dss_id];
+
+			devinfo++;
+			i++;
+		}
 	}
 	return i;
 }
-- 
2.34.1


