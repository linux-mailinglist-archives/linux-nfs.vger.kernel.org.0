Return-Path: <linux-nfs+bounces-14653-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE15B9ADC7
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 18:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C8E7AA7B8
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530F4313286;
	Wed, 24 Sep 2025 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="aemMC92P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6E31327A
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730885; cv=none; b=OZsPi0VGCjIthwSHKioMAIYGZt+OM5+K18DLVnEUp/6U5BC2nrQb8r16W0VnNGXeCx1ihd0OtpNE1Byp/HDmSNHlzuCxUCKXQ+KB0O1wV7PHLiCU5f8ooUN7oGYH0Hniw3fu9lXbWNdxHXtbPvzBq+iNyt9Z/Yq868Y3XHggK5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730885; c=relaxed/simple;
	bh=X2RuhoA2QRMdOJpax2fYWQpQdF9TPVKL2SHPap3dHfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SIQP2NTMIVE8lJ8CznpBHJw0qimrW6TwFq2dETJo6acefuaFXzBLgfAdkpugl6iQThcQbZNeykSi1PD11vcEJa8NJk0GcI93QT7UdPE+sbhHdjzevUod1CJbiwU5htB95CKwF/s+/SopTZxfibdE/gh7ncuwfg12yT6abKM//Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=aemMC92P; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b2ef8e00becso7020466b.0
        for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758730881; x=1759335681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w46GiiEILOXKoAz6aZ62q6viJpzXvsQEO0aCQOGmCag=;
        b=aemMC92PZF4pfZZWhAFhsB9SUI35WZsC64MzQ9iuP0psdZiLjXNPrv6dG4QJ+7pd26
         7Pza76tl9gZifglGCbc/MUAMfSAmpjLmKtbHQONbTLb9utH/H2GfiMp4cxgS0luEpyX3
         MBVO8nXabdErLEZx30LXcEVh15uLk/gEOfvcdzi81hBMnNtF4dMeyR8/SU/VI8oM+w4B
         legPCoBCyXm2DHY+UvpVl67e2jBvRe+JbG3Hs8H9aKji1LS+frjft+KlxmoDPSp9LMWx
         5dWZosS65HXuGxX2K9e9jpCNH40zZvL0g/MLYJr73zoUTqZKRYGACt7THsFiYpGqdF7k
         0PIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758730881; x=1759335681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w46GiiEILOXKoAz6aZ62q6viJpzXvsQEO0aCQOGmCag=;
        b=aqYah0ZinWKIMgs2K1MuWwjFVHQFPEmGoUAxX57jmj4Mn6EJnn6GOvSlZnTUqRv5o9
         keL4noMn7FeJN/yItgaH/ZhWMOHq+E0PW7UWm3kbK12Kl3RNqGVB4C0hiRJqUNyNITNJ
         cG2MNRg3PK9dRzr3TXJqSRbxV/SbiHs62C4/tIcbLICKIPNb9B4XbGIokFMNHxguHijT
         jyDFCk4a80UXrH+SNjqMqAETEdiIaAtaOL5t/ZnAWv0ZGk+tKt9d6PASIHUD3ua9njRt
         pDVGioAMp67mvH+f5idv9cXIq3sFbF8NrtIf4kWlIc7pOPLpvuUtfacOIOSbPqE+zP+V
         Hc7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3P9zzk3MvqdJOwg8GtenrOMpT40WQiEU5Rl4acn4/itch0Q6cXZLuklrKl8+xtcs/RH3xwuPWCk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlrKVgNQLuSYtpNvRZCBOuG3OgjbzY6nGGBg0VqVLPkiT4Lmbn
	gSVI4ULwvSw3rQ2qrktbY3lANk33cH7U02tP7gV2WF+xTeQy1qUFgd03cNQwkJpdGVc=
X-Gm-Gg: ASbGncteGM4MhtOokHH/lGa8pzZQejQyFPVCMA3fAgGMErQgOGJsa+pjDvBAmCA99Bw
	kAUtvwzFGVFKnQV8ILEKbgL81fKrL5qu2S1YDaDi9gF5/cn00Re99HEl+UeQul8TCoiHczJVPYS
	b0pXC0MeaJ62eyfVrVSRTk4q69d5BbzVDgrmDQDghObOBC//x+Kx9zSA6WI16yE1YGaPSdEQhty
	FeJY16kbRCFZZG23QwT33xQS/zeh1tcrZPCfjCn/sPybOXunjfoG6Apxta1YCmaU1Lu9EtyWZHE
	FLcw2PiyRMf4GlYjJrlNowSkZ22f8RPjz2SJ+f/6PGuPFWyPU2JTAQGZEP9FYWKTJTi26O9/CVq
	58aNyxRMJQq51XvexBY9FiAM=
X-Google-Smtp-Source: AGHT+IEouplmqXj2/2OWFCM5eX9I9xOvNpNojoHEVdiCBgaL4bCxiIPZvqYvzVvxsCW6m7Q99rG6vA==
X-Received: by 2002:a17:907:d26:b0:b0b:47af:1655 with SMTP id a640c23a62f3a-b34bab2db0amr37549366b.15.1758730881085;
        Wed, 24 Sep 2025 09:21:21 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b261bdfe8b1sm1276926766b.70.2025.09.24.09.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 09:21:20 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v4 8/9] NFSv4/flexfiles: Update layout stats & error paths for striped layouts
Date: Wed, 24 Sep 2025 16:20:49 +0000
Message-Id: <20250924162050.634451-9-jcurley@purestorage.com>
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
index 95a5779c32c5..7b95ab1cd140 100644
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
@@ -649,6 +649,7 @@ nfs4_ff_end_busy_timer(struct nfs4_ff_busy_timer *timer, ktime_t now)
 
 static bool
 nfs4_ff_layoutstat_start_io(struct nfs4_ff_layout_mirror *mirror,
+			    u32 dss_id,
 			    struct nfs4_ff_layoutstat *layoutstat,
 			    ktime_t now)
 {
@@ -656,8 +657,8 @@ nfs4_ff_layoutstat_start_io(struct nfs4_ff_layout_mirror *mirror,
 	struct nfs4_flexfile_layout *ffl = FF_LAYOUT_FROM_HDR(mirror->layout);
 
 	nfs4_ff_start_busy_timer(&layoutstat->busy_timer, now);
-	if (!mirror->dss[0].start_time)
-		mirror->dss[0].start_time = now;
+	if (!mirror->dss[dss_id].start_time)
+		mirror->dss[dss_id].start_time = now;
 	if (mirror->report_interval != 0)
 		report_interval = (s64)mirror->report_interval * 1000LL;
 	else if (layoutstats_timer != 0)
@@ -707,13 +708,16 @@ nfs4_ff_layout_stat_io_update_completed(struct nfs4_ff_layoutstat *layoutstat,
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
 
@@ -724,11 +728,12 @@ nfs4_ff_layout_stat_io_start_read(struct inode *inode,
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
@@ -738,13 +743,20 @@ nfs4_ff_layout_stat_io_end_read(struct rpc_task *task,
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
 
@@ -755,6 +767,7 @@ nfs4_ff_layout_stat_io_start_write(struct inode *inode,
 static void
 nfs4_ff_layout_stat_io_end_write(struct rpc_task *task,
 		struct nfs4_ff_layout_mirror *mirror,
+		u32 dss_id,
 		__u64 requested,
 		__u64 completed,
 		enum nfs3_stable_how committed)
@@ -763,25 +776,25 @@ nfs4_ff_layout_stat_io_end_write(struct rpc_task *task,
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
@@ -1214,11 +1227,11 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
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
@@ -1315,9 +1328,9 @@ static int ff_layout_async_handle_error_v3(struct rpc_task *task,
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
@@ -1381,12 +1394,12 @@ static int ff_layout_async_handle_error(struct rpc_task *task,
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
 
@@ -1397,10 +1410,10 @@ static int ff_layout_async_handle_error(struct rpc_task *task,
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
@@ -1409,7 +1422,7 @@ static int ff_layout_async_handle_error(struct rpc_task *task,
 }
 
 static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
-					u32 idx, u64 offset, u64 length,
+					u32 idx, u32 dss_id, u64 offset, u64 length,
 					u32 *op_status, int opnum, int error)
 {
 	struct nfs4_ff_layout_mirror *mirror;
@@ -1447,7 +1460,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 
 	mirror = FF_LAYOUT_COMP(lseg, idx);
 	err = ff_layout_track_ds_error(FF_LAYOUT_FROM_HDR(lseg->pls_layout),
-				       mirror, 0, offset, length, status, opnum,
+				       mirror, dss_id, offset, length, status, opnum,
 				       nfs_io_gfp_mask());
 
 	switch (status) {
@@ -1456,7 +1469,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 	case NFS4ERR_PERM:
 		break;
 	case NFS4ERR_NXIO:
-		ff_layout_mark_ds_unreachable(lseg, idx);
+		ff_layout_mark_ds_unreachable(lseg, idx, dss_id);
 		/*
 		 * Don't return the layout if this is a read and we still
 		 * have layouts to try
@@ -1476,10 +1489,16 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
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
@@ -1489,7 +1508,8 @@ static int ff_layout_read_done_cb(struct rpc_task *task,
 	err = ff_layout_async_handle_error(task, hdr->res.op_status,
 					   hdr->args.context->state,
 					   hdr->ds_clp, hdr->lseg,
-					   hdr->pgio_mirror_idx);
+					   hdr->pgio_mirror_idx,
+					   dss_id);
 
 	trace_nfs4_pnfs_read(hdr, err);
 	clear_bit(NFS_IOHDR_RESEND_PNFS, &hdr->flags);
@@ -1545,23 +1565,47 @@ ff_layout_set_layoutcommit(struct inode *inode,
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
 
@@ -1649,11 +1693,17 @@ static void ff_layout_read_release(void *data)
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
@@ -1663,7 +1713,8 @@ static int ff_layout_write_done_cb(struct rpc_task *task,
 	err = ff_layout_async_handle_error(task, hdr->res.op_status,
 					   hdr->args.context->state,
 					   hdr->ds_clp, hdr->lseg,
-					   hdr->pgio_mirror_idx);
+					   hdr->pgio_mirror_idx,
+					   dss_id);
 
 	trace_nfs4_pnfs_write(hdr, err);
 	clear_bit(NFS_IOHDR_RESEND_PNFS, &hdr->flags);
@@ -1701,9 +1752,11 @@ static int ff_layout_commit_done_cb(struct rpc_task *task,
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
@@ -1711,8 +1764,8 @@ static int ff_layout_commit_done_cb(struct rpc_task *task,
 	}
 
 	err = ff_layout_async_handle_error(task, data->res.op_status,
-					   NULL, data->ds_clp, data->lseg,
-					   data->ds_commit_index);
+					   NULL, data->ds_clp, data->lseg, idx,
+					   dss_id);
 
 	trace_nfs4_pnfs_commit_ds(data, err);
 	switch (err) {
@@ -1731,30 +1784,54 @@ static int ff_layout_commit_done_cb(struct rpc_task *task,
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
 
@@ -1837,10 +1914,16 @@ static void ff_layout_write_release(void *data)
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
 
@@ -1849,6 +1932,7 @@ static void ff_layout_commit_record_layoutstats_done(struct rpc_task *task,
 {
 	struct nfs_page *req;
 	__u64 count = 0;
+	u32 idx, dss_id;
 
 	if (!test_and_clear_bit(NFS_IOHDR_STAT, &cdata->flags))
 		return;
@@ -1857,8 +1941,12 @@ static void ff_layout_commit_record_layoutstats_done(struct rpc_task *task,
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
@@ -2245,25 +2333,28 @@ static void ff_layout_cancel_io(struct pnfs_layout_segment *lseg)
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
 
@@ -2651,11 +2742,11 @@ ff_layout_encode_io_latency(struct xdr_stream *xdr,
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
@@ -2667,13 +2758,17 @@ ff_layout_encode_ff_layoutupdate(struct xdr_stream *xdr,
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
@@ -2697,7 +2792,8 @@ ff_layout_encode_layoutstats(struct xdr_stream *xdr, const void *args,
 static void
 ff_layout_free_layoutstats(struct nfs4_xdr_opaque_data *opaque)
 {
-	struct nfs4_ff_layout_mirror *mirror = opaque->data;
+	struct nfs4_ff_layout_ds_stripe *dss_info = opaque->data;
+	struct nfs4_ff_layout_mirror *mirror = dss_info->mirror;
 
 	ff_layout_put_mirror(mirror);
 }
@@ -2714,37 +2810,47 @@ ff_layout_mirror_prepare_stats(struct pnfs_layout_hdr *lo,
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


