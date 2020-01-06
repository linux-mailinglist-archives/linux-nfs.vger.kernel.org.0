Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4EF131959
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 21:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgAFU1h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 15:27:37 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39441 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgAFU1g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 15:27:36 -0500
Received: by mail-yb1-f193.google.com with SMTP id b12so286048ybg.6
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 12:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XwK2+X71Ax+UMgRwJ/UWo/h1i3e43wnDp+/h+mUQKxk=;
        b=t6me65tSkZQw+v1jxJW6CaE/AUP2b22EdESpejENumKdwQuPDRxTSzGzNyBfau1RdK
         op2UvEvlp6l52R6k+CTljhifWvvQh88Fdrz5mVv+xLhvTZkF9PpXypovcOdLgLOAMHxY
         Bd3uryeggEvcfrCYWDj10u+tWticRkV7gZH1DO/9X4dzn/qATVwtcG+CE9m8/UAdCMfZ
         6P/I5FccNw5eASp9uTS9vonKvGrMJTvnJ5K40j8FZBUO2tmOnZkI6bo+F3cFLBg50ZYv
         XpsK4cSz8OU5lDILEvYhxWqgaYkKUy5OUcPQVBDZtbMJRONRIY3qs4c8QRhw8/qxPotN
         VzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XwK2+X71Ax+UMgRwJ/UWo/h1i3e43wnDp+/h+mUQKxk=;
        b=QZ7RRNKcJOVanMbty66IV4QwQm9obWtjnDpf5nyiec1/LhDcjYiSSmahOQHo7MVdS0
         Qv2F4Y6OQ4SZSlCVCa7k8uFJffp7v1XVEBy4/ImM55P3oHk7+pS03wQZZWjpN5Wjco20
         pD0zySBTU+DkHk6wQtLzg6mSBDjSrX8m/djusMbFWVM8yQMKcFiCLgeszIr1VMI73ZVd
         FG6Vm6vrzB0W/eNm49Xd6zp6bhHkULBSPOJn7upmwtc6R6p0sE02w6pvnpbx6w4iUutj
         kGifGFtkft2gEqqyAG3sbaJbjWMEPio5yLtEKxs/uq1pyfkHwHcxK+bOPsJhS7ZW2e2C
         7eOQ==
X-Gm-Message-State: APjAAAXAABq4WfgNIYx4DQg7iuvYctp3doCa2CQuJvpQk373i1gLY+GQ
        bamHYuLVE4s+470XNH54LA==
X-Google-Smtp-Source: APXvYqzPJHFBO7EVT1d3jkyW3ebV9iI3+XIpfwIz7Ryw6NYP+mzkLdvtzwVjM8C04LLQf0G428P1tQ==
X-Received: by 2002:a25:6cd6:: with SMTP id h205mr41352448ybc.301.1578342455187;
        Mon, 06 Jan 2020 12:27:35 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l200sm28723579ywl.106.2020.01.06.12.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:27:34 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 08/15] pNFS/flexfiles: Record resend attempts on I/O failure
Date:   Mon,  6 Jan 2020 15:25:07 -0500
Message-Id: <20200106202514.785483-9-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106202514.785483-8-trond.myklebust@hammerspace.com>
References: <20200106202514.785483-1-trond.myklebust@hammerspace.com>
 <20200106202514.785483-2-trond.myklebust@hammerspace.com>
 <20200106202514.785483-3-trond.myklebust@hammerspace.com>
 <20200106202514.785483-4-trond.myklebust@hammerspace.com>
 <20200106202514.785483-5-trond.myklebust@hammerspace.com>
 <20200106202514.785483-6-trond.myklebust@hammerspace.com>
 <20200106202514.785483-7-trond.myklebust@hammerspace.com>
 <20200106202514.785483-8-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the attempt to do pNFS fails, then record what action we
take to recover (resend, reset to pnfs or reset to mds).

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 6 +++---
 fs/nfs/nfs4trace.h                     | 8 +++++++-
 fs/nfs/pnfs.h                          | 8 ++++----
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 5657b7f2611f..3163b78b1d2c 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1321,7 +1321,6 @@ static int ff_layout_read_done_cb(struct rpc_task *task,
 	int new_idx = hdr->pgio_mirror_idx;
 	int err;
 
-	trace_nfs4_pnfs_read(hdr, task->tk_status);
 	if (task->tk_status < 0)
 		ff_layout_io_track_ds_error(hdr->lseg, hdr->pgio_mirror_idx,
 					    hdr->args.offset, hdr->args.count,
@@ -1331,6 +1330,7 @@ static int ff_layout_read_done_cb(struct rpc_task *task,
 					   hdr->ds_clp, hdr->lseg,
 					   hdr->pgio_mirror_idx);
 
+	trace_nfs4_pnfs_read(hdr, err);
 	clear_bit(NFS_IOHDR_RESEND_PNFS, &hdr->flags);
 	clear_bit(NFS_IOHDR_RESEND_MDS, &hdr->flags);
 	switch (err) {
@@ -1494,7 +1494,6 @@ static int ff_layout_write_done_cb(struct rpc_task *task,
 	loff_t end_offs = 0;
 	int err;
 
-	trace_nfs4_pnfs_write(hdr, task->tk_status);
 	if (task->tk_status < 0)
 		ff_layout_io_track_ds_error(hdr->lseg, hdr->pgio_mirror_idx,
 					    hdr->args.offset, hdr->args.count,
@@ -1504,6 +1503,7 @@ static int ff_layout_write_done_cb(struct rpc_task *task,
 					   hdr->ds_clp, hdr->lseg,
 					   hdr->pgio_mirror_idx);
 
+	trace_nfs4_pnfs_write(hdr, err);
 	clear_bit(NFS_IOHDR_RESEND_PNFS, &hdr->flags);
 	clear_bit(NFS_IOHDR_RESEND_MDS, &hdr->flags);
 	switch (err) {
@@ -1537,7 +1537,6 @@ static int ff_layout_commit_done_cb(struct rpc_task *task,
 {
 	int err;
 
-	trace_nfs4_pnfs_commit_ds(data, task->tk_status);
 	if (task->tk_status < 0)
 		ff_layout_io_track_ds_error(data->lseg, data->ds_commit_index,
 					    data->args.offset, data->args.count,
@@ -1546,6 +1545,7 @@ static int ff_layout_commit_done_cb(struct rpc_task *task,
 	err = ff_layout_async_handle_error(task, NULL, data->ds_clp,
 					   data->lseg, data->ds_commit_index);
 
+	trace_nfs4_pnfs_commit_ds(data, err);
 	switch (err) {
 	case -NFS4ERR_RESET_TO_PNFS:
 		pnfs_generic_prepare_to_resend_writes(data);
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index a291877c0c32..a467f49989f2 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -155,6 +155,9 @@ TRACE_DEFINE_ENUM(NFS4ERR_WRONG_CRED);
 TRACE_DEFINE_ENUM(NFS4ERR_WRONG_TYPE);
 TRACE_DEFINE_ENUM(NFS4ERR_XDEV);
 
+TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_MDS);
+TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_PNFS);
+
 #define show_nfsv4_errors(error) \
 	__print_symbolic(error, \
 		{ NFS4_OK, "OK" }, \
@@ -305,7 +308,10 @@ TRACE_DEFINE_ENUM(NFS4ERR_XDEV);
 		{ NFS4ERR_WRONGSEC, "WRONGSEC" }, \
 		{ NFS4ERR_WRONG_CRED, "WRONG_CRED" }, \
 		{ NFS4ERR_WRONG_TYPE, "WRONG_TYPE" }, \
-		{ NFS4ERR_XDEV, "XDEV" })
+		{ NFS4ERR_XDEV, "XDEV" }, \
+		/* ***** Internal to Linux NFS client ***** */ \
+		{ NFS4ERR_RESET_TO_MDS, "RESET_TO_MDS" }, \
+		{ NFS4ERR_RESET_TO_PNFS, "RESET_TO_PNFS" })
 
 #define show_open_flags(flags) \
 	__print_flags(flags, "|", \
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index f8a38065c7e4..0fafdadc9c8d 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -79,6 +79,10 @@ enum pnfs_try_status {
 	PNFS_TRY_AGAIN     = 2,
 };
 
+/* error codes for internal use */
+#define NFS4ERR_RESET_TO_MDS   12001
+#define NFS4ERR_RESET_TO_PNFS  12002
+
 #ifdef CONFIG_NFS_V4_1
 
 #define LAYOUT_NFSV4_1_MODULE_PREFIX "nfs-layouttype4"
@@ -91,10 +95,6 @@ enum pnfs_try_status {
 #define NFS4_DEF_DS_RETRANS 5
 #define PNFS_DEVICE_RETRY_TIMEOUT (120*HZ)
 
-/* error codes for internal use */
-#define NFS4ERR_RESET_TO_MDS   12001
-#define NFS4ERR_RESET_TO_PNFS  12002
-
 enum {
 	NFS_LAYOUT_RO_FAILED = 0,	/* get ro layout failed stop trying */
 	NFS_LAYOUT_RW_FAILED,		/* get rw layout failed stop trying */
-- 
2.24.1

