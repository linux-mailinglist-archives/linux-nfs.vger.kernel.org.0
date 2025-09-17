Return-Path: <linux-nfs+bounces-14533-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC6CB81D55
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 22:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC451C22CD0
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 20:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17A92868AF;
	Wed, 17 Sep 2025 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KRSoKu0i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC127A92D
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142136; cv=none; b=sSsDRP0qlUd2uR8fW2jEhaxL3c/7hQYwnKq+k5vMQpRS/3A1MYULsQZSA2kNYYyaLpYgIL/+pGJ6gpuPgXBCtGx9Fkibt0h7jJIo7VuDgsoV/fnmJz3vTb7Xk8XZUzg5Vu+tovU7cssqxGqrtyT9sNdASLOV//uYqB0mYP/pCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142136; c=relaxed/simple;
	bh=FSW0TckeQNTbbnhrIggyEKYl1RMmlgo2i1/2B3pVjiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jwpZMVnp1phjr+w28Cz3CjrrlKC8v+NO1UlKMIM5Mx9Vlw4CN1MGfHaubb+0Zhh5PcvQCfsOn/i71oEI7BEakVlAw49kieWuv+zVrpkI11i9J/G3HTNwCpplHoJgP6BfUNBQINNasMKfowDBQX8YdWN6AVzwqnS6LEocg5goJjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KRSoKu0i; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62733e779bbso300312a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 13:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758142132; x=1758746932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxEoKeK9lNk5l3e3M/2HJsd7WOUx0q5fhHLKmQvLliM=;
        b=KRSoKu0i/d+wQfZIk90fsGlxAc2NIQg1RFG0YqxV1IEO+kD+iKyrdcKD/rGj9EcomW
         So4RjxaQIA9cwKhEav8H0+UXRkcY+AuD2/97NZNAu0mHw1uYKPgv4ONzqMZJrDJy8qbT
         FsIpccGVhLulK+MVvZ3UWlvNqjUKjoOFcW3GWKMUEgbwOWMgtLxzyJj8qc9ayxrTBrRV
         zTMwask1fAHGH4PB63AKSPgpnupzBoqCHxT3epFDrzBb5J+vIdt1ERKpqZJzcZcBn3Sk
         31uqESkAxVCF4v/QIkw86fg5m7fbjXRA9GtQRqW6evqwcArMaeYPLykwE/PktnQOnqdu
         pGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758142132; x=1758746932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxEoKeK9lNk5l3e3M/2HJsd7WOUx0q5fhHLKmQvLliM=;
        b=rYEHZ7HBvGY+HrHyNpnRLIGwgFoX0Ss9ir0L6pZYDqI4Jov+7WDjT3P+YZqFOtzUWK
         U530Q3VZCC1HzmE4+6CORCMMEu+Vy24/0LJywIfyVztvZ6ysYcgPHU6C2FMMv5eBKrPJ
         ya1JWe5aUSdUuqRgA4JkVYJ2h03BFWhfIQsHLIkQNuQDOLuqM4UhHeLoan4NpZo+2zPk
         CzjXf++SEUKb+a2lDqC2haV7pJPMvYRbeGxLB9xXDVw3k2qWb7Dbv8kwRyZcwNp4n5L2
         Znlg50zLlIL8FuSYKoVXUsVrIXHEhCvsWqYkJNPkcyODMgikOKJ3HB28fUTlY8jsVoqU
         gsuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmoh/yJ76WnW9z7E4dO/nAVS/prVTuxio+o2SxNLks7HkD6J+3xRbFPxOP9qyCumyItzTA7BL55tM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/MxvHWdo3wI5DykUwFnLlG6OJ85uRCw8FRg/INJE/hf14k2Z0
	1YGVD4DdKupUsM2c33jRrfsev7a4F1p7c+XytNi7PQxqOXMcmH8j6/h4ksJgGDZG1hs=
X-Gm-Gg: ASbGncuT0BsS5YYA/B5T+kHYrsvFIQj5T8InaW6rmZSKDeC/EdqziccYnciCgv32HVN
	kzqiRsQXd3F8izH+n759cEzdCeDkNs6pU8jaMSZ8rlaLQYQkIIXfHc2yIrEAvzCIgE92tjxO5ud
	0NkGPXjccFt2LbjZgK9WzX8SvTxybdzfd267Y0eAPAlrSfgR722uy+x8DQpD45OEqE/2ICLnWFm
	nu8ZEH6rCNpXUSacNRc01VPBHnJDp3CoKNQJLjKjTR2S8HwTD0KR/dRoHm1gFqCWnsQWAvDnrvv
	Ic/r70tZDzaGD9ypx105qZZR32P5/muWTa2RjtfcsEjSieIbGlR7/jk50d/UQcuoO4SMNqFM9G9
	TNQ+G9eoGAI2rSJ5m3NRC75zrKvV7MydJMA==
X-Google-Smtp-Source: AGHT+IFcaUjcbNaWen0TbI9KAvRCpAQ32a3Ac2SQPjyij03ECDVT7o5//sazS14kJfKcOFqhkusuQQ==
X-Received: by 2002:a17:907:3f0a:b0:b0c:6cae:51e3 with SMTP id a640c23a62f3a-b1bb8ca5382mr410736066b.35.1758142132148;
        Wed, 17 Sep 2025 13:48:52 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fcfe88bc3sm42505366b.51.2025.09.17.13.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 13:48:51 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 8/9] NFSv4/flexfiles: Update layout stats & error paths for striped layouts
Date: Wed, 17 Sep 2025 20:48:26 +0000
Message-Id: <20250917204827.495253-9-jcurley@purestorage.com>
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
index 696589d191e5..28d982af4450 100644
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


