Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7AC13195D
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 21:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgAFU1m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 15:27:42 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40558 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgAFU1m (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 15:27:42 -0500
Received: by mail-yb1-f196.google.com with SMTP id a2so22630901ybr.7
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 12:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhbqhr3KRzyAH7VtiiYgrivI7REdC1kMaQXc64L62Iw=;
        b=P1OUVxKB+O8KJqrh3//V1akx4JSBcfhdysb8L8gNzHaCnjLg5i5qxUVpYhHrwvVwrv
         h1WkfemgHOJ9cX/rrnVW9na3zDu9/ZuQAqPZZbqVZvij4z8S8H1wGsBQN7D6wuVSx7bC
         /mLJIXrMg7nesDxY17ToWYAQmOS9Za4Zg+I1utKp3LRGx6OHu7R4hNCYOC4VPRMXNxmg
         K0/hLEqm547F3HD+gje06sh7THDK8GfrHNiKf989olYgVIDyZEfWQEyjChz8pPTqkyGw
         ckQ80qZfSx9gjlT6TLbDmmnN6eJFiuIivu0/v4Xa4oENLcAZKurOkC1Bpq5WgSC7BW+H
         qTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhbqhr3KRzyAH7VtiiYgrivI7REdC1kMaQXc64L62Iw=;
        b=JpQgTMA8BJJNns09nb6Df54/6vFzkDTs8vl8j6w8bcQPwYLSvYolMgNt1eoqGZl19k
         KL5gOOavUuQtQBKQoTlbZ9i3AXgojRMTJsJMlx/UeCqAJV2r7+26zVToO9Gw1bB8aXfw
         hzq+kAHTj8rpxxsp2kViImJIKBrcjMr3+I9nt9xvVfyEYKgx9+xZsp6H2oRaB1j0p0dW
         RKkHPIvjQI/O8YEQ45+J31VF3W2vvrJX8JaSftHu6XVvuDvHFv6q55TowmF8vbYP2dUr
         TLucWM9kfxM4ndHC9Aw+BNxApc14e7YXLj6Nb/gLbHZ32sYFz96KBSLDcroXlguYb7uE
         iaCg==
X-Gm-Message-State: APjAAAW8X6Ee3296x3kBoYpsCJUy5Em64caavJsBS0y3NdhOXALWXT8N
        PvC/YQxead/frJTP66S40lIC4Z1Amw==
X-Google-Smtp-Source: APXvYqyKmoPyRdyjm7eMh2kxxf7w76CL8tIg4I/hOD6OJdk+v6cCoOCLYkBF1r/gSA6s3gqxYMs9eg==
X-Received: by 2002:a25:447:: with SMTP id 68mr70282290ybe.432.1578342460661;
        Mon, 06 Jan 2020 12:27:40 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l200sm28723579ywl.106.2020.01.06.12.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:27:40 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 12/15] pNFS/flexfiles: Add tracing for layout errors
Date:   Mon,  6 Jan 2020 15:25:11 -0500
Message-Id: <20200106202514.785483-13-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106202514.785483-12-trond.myklebust@hammerspace.com>
References: <20200106202514.785483-1-trond.myklebust@hammerspace.com>
 <20200106202514.785483-2-trond.myklebust@hammerspace.com>
 <20200106202514.785483-3-trond.myklebust@hammerspace.com>
 <20200106202514.785483-4-trond.myklebust@hammerspace.com>
 <20200106202514.785483-5-trond.myklebust@hammerspace.com>
 <20200106202514.785483-6-trond.myklebust@hammerspace.com>
 <20200106202514.785483-7-trond.myklebust@hammerspace.com>
 <20200106202514.785483-8-trond.myklebust@hammerspace.com>
 <20200106202514.785483-9-trond.myklebust@hammerspace.com>
 <20200106202514.785483-10-trond.myklebust@hammerspace.com>
 <20200106202514.785483-11-trond.myklebust@hammerspace.com>
 <20200106202514.785483-12-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trace layout errors for pNFS/flexfiles on read/write/commit operations.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c |  28 +++++--
 fs/nfs/nfs4trace.c                     |   4 +
 fs/nfs/nfs4trace.h                     | 109 +++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 3163b78b1d2c..bb9148b83166 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1266,9 +1266,10 @@ static int ff_layout_async_handle_error(struct rpc_task *task,
 
 static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 					int idx, u64 offset, u64 length,
-					u32 status, int opnum, int error)
+					u32 *op_status, int opnum, int error)
 {
 	struct nfs4_ff_layout_mirror *mirror;
+	u32 status = *op_status;
 	int err;
 
 	if (status == 0) {
@@ -1286,10 +1287,10 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -ENOBUFS:
 		case -EPIPE:
 		case -EPERM:
-			status = NFS4ERR_NXIO;
+			*op_status = status = NFS4ERR_NXIO;
 			break;
 		case -EACCES:
-			status = NFS4ERR_ACCESS;
+			*op_status = status = NFS4ERR_ACCESS;
 			break;
 		default:
 			return;
@@ -1321,11 +1322,14 @@ static int ff_layout_read_done_cb(struct rpc_task *task,
 	int new_idx = hdr->pgio_mirror_idx;
 	int err;
 
-	if (task->tk_status < 0)
+	if (task->tk_status < 0) {
 		ff_layout_io_track_ds_error(hdr->lseg, hdr->pgio_mirror_idx,
 					    hdr->args.offset, hdr->args.count,
-					    hdr->res.op_status, OP_READ,
+					    &hdr->res.op_status, OP_READ,
 					    task->tk_status);
+		trace_ff_layout_read_error(hdr);
+	}
+
 	err = ff_layout_async_handle_error(task, hdr->args.context->state,
 					   hdr->ds_clp, hdr->lseg,
 					   hdr->pgio_mirror_idx);
@@ -1494,11 +1498,14 @@ static int ff_layout_write_done_cb(struct rpc_task *task,
 	loff_t end_offs = 0;
 	int err;
 
-	if (task->tk_status < 0)
+	if (task->tk_status < 0) {
 		ff_layout_io_track_ds_error(hdr->lseg, hdr->pgio_mirror_idx,
 					    hdr->args.offset, hdr->args.count,
-					    hdr->res.op_status, OP_WRITE,
+					    &hdr->res.op_status, OP_WRITE,
 					    task->tk_status);
+		trace_ff_layout_write_error(hdr);
+	}
+
 	err = ff_layout_async_handle_error(task, hdr->args.context->state,
 					   hdr->ds_clp, hdr->lseg,
 					   hdr->pgio_mirror_idx);
@@ -1537,11 +1544,14 @@ static int ff_layout_commit_done_cb(struct rpc_task *task,
 {
 	int err;
 
-	if (task->tk_status < 0)
+	if (task->tk_status < 0) {
 		ff_layout_io_track_ds_error(data->lseg, data->ds_commit_index,
 					    data->args.offset, data->args.count,
-					    data->res.op_status, OP_COMMIT,
+					    &data->res.op_status, OP_COMMIT,
 					    task->tk_status);
+		trace_ff_layout_commit_error(data);
+	}
+
 	err = ff_layout_async_handle_error(task, NULL, data->ds_clp,
 					   data->lseg, data->ds_commit_index);
 
diff --git a/fs/nfs/nfs4trace.c b/fs/nfs/nfs4trace.c
index 1a8f376b3f73..d9ac556bebcf 100644
--- a/fs/nfs/nfs4trace.c
+++ b/fs/nfs/nfs4trace.c
@@ -24,4 +24,8 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pnfs_mds_fallback_read_done);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pnfs_mds_fallback_write_done);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pnfs_mds_fallback_read_pagelist);
 EXPORT_TRACEPOINT_SYMBOL_GPL(pnfs_mds_fallback_write_pagelist);
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_read_error);
+EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_write_error);
+EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_commit_error);
 #endif
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index a467f49989f2..d39897daa284 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2117,6 +2117,115 @@ DEFINE_PNFS_LAYOUT_EVENT(pnfs_mds_fallback_write_done);
 DEFINE_PNFS_LAYOUT_EVENT(pnfs_mds_fallback_read_pagelist);
 DEFINE_PNFS_LAYOUT_EVENT(pnfs_mds_fallback_write_pagelist);
 
+DECLARE_EVENT_CLASS(nfs4_flexfiles_io_event,
+		TP_PROTO(
+			const struct nfs_pgio_header *hdr
+		),
+
+		TP_ARGS(hdr),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, error)
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(loff_t, offset)
+			__field(u32, count)
+			__field(int, stateid_seq)
+			__field(u32, stateid_hash)
+			__string(dstaddr, hdr->ds_clp ?
+				rpc_peeraddr2str(hdr->ds_clp->cl_rpcclient,
+					RPC_DISPLAY_ADDR) : "unknown")
+		),
+
+		TP_fast_assign(
+			const struct inode *inode = hdr->inode;
+
+			__entry->error = hdr->res.op_status;
+			__entry->fhandle = nfs_fhandle_hash(hdr->args.fh);
+			__entry->fileid = NFS_FILEID(inode);
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->offset = hdr->args.offset;
+			__entry->count = hdr->args.count;
+			__entry->stateid_seq =
+				be32_to_cpu(hdr->args.stateid.seqid);
+			__entry->stateid_hash =
+				nfs_stateid_hash(&hdr->args.stateid);
+			__assign_str(dstaddr, hdr->ds_clp ?
+				rpc_peeraddr2str(hdr->ds_clp->cl_rpcclient,
+					RPC_DISPLAY_ADDR) : "unknown");
+		),
+
+		TP_printk(
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"offset=%llu count=%u stateid=%d:0x%08x dstaddr=%s",
+			-__entry->error,
+			show_nfsv4_errors(__entry->error),
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle,
+			__entry->offset, __entry->count,
+			__entry->stateid_seq, __entry->stateid_hash,
+			__get_str(dstaddr)
+		)
+);
+
+#define DEFINE_NFS4_FLEXFILES_IO_EVENT(name) \
+	DEFINE_EVENT(nfs4_flexfiles_io_event, name, \
+			TP_PROTO( \
+				const struct nfs_pgio_header *hdr \
+			), \
+			TP_ARGS(hdr))
+DEFINE_NFS4_FLEXFILES_IO_EVENT(ff_layout_read_error);
+DEFINE_NFS4_FLEXFILES_IO_EVENT(ff_layout_write_error);
+
+TRACE_EVENT(ff_layout_commit_error,
+		TP_PROTO(
+			const struct nfs_commit_data *data
+		),
+
+		TP_ARGS(data),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, error)
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(u64, fileid)
+			__field(loff_t, offset)
+			__field(u32, count)
+			__string(dstaddr, data->ds_clp ?
+				rpc_peeraddr2str(data->ds_clp->cl_rpcclient,
+					RPC_DISPLAY_ADDR) : "unknown")
+		),
+
+		TP_fast_assign(
+			const struct inode *inode = data->inode;
+
+			__entry->error = data->res.op_status;
+			__entry->fhandle = nfs_fhandle_hash(data->args.fh);
+			__entry->fileid = NFS_FILEID(inode);
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->offset = data->args.offset;
+			__entry->count = data->args.count;
+			__assign_str(dstaddr, data->ds_clp ?
+				rpc_peeraddr2str(data->ds_clp->cl_rpcclient,
+					RPC_DISPLAY_ADDR) : "unknown");
+		),
+
+		TP_printk(
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"offset=%llu count=%u dstaddr=%s",
+			-__entry->error,
+			show_nfsv4_errors(__entry->error),
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle,
+			__entry->offset, __entry->count,
+			__get_str(dstaddr)
+		)
+);
+
+
 #endif /* CONFIG_NFS_V4_1 */
 
 #endif /* _TRACE_NFS4_H */
-- 
2.24.1

