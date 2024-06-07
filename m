Return-Path: <linux-nfs+bounces-3587-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F0990067A
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3271C22D5A
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F85D194A7D;
	Fri,  7 Jun 2024 14:26:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D741667DE
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770414; cv=none; b=OLnrI+ZGCjWu4S/+Z1aH6kqZThFVhjm+pbL/El8skB3vNV5fhyCaB4WFnPhJTOdyxPRmCeP4tZcS/gFOFFLbjq9kK02roOtIVCYRguQwzYJ1XmU+1xAEdPS4/ecckf2ZxY1bo67m8GZNj4kGvCvf20Rvx+1wF4dcgFLQhaLC298=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770414; c=relaxed/simple;
	bh=amhGV0eM29wfHo/NxsXnP4zfpYzz6VFtteyCvaazjTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhduvnFMxC1cu9kAXbkvKiwYEOziqxr7vDZn1boIL3xBbJDSHm7hyJ7HtYwUkmJ9jA7yZ+ROMr4MQOoRf05t2dQ1IthhEOkx0LQEzoxtZEe4tVmOrg8m2RcMrZ5J5QA+QeNHkrvxcRWIgXs9AqM6U7GpsMe8TiDcHCQ4jX0cFSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f93e7ebaf6so1136413a34.2
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770411; x=1718375211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnNYWyXHuhFDL7wZWOuq2QeE/ImTtkP9BLnZljXVaag=;
        b=b1zpqpDVspGEvaWffv262qT1rocviDWsMZG5p/hYSHpsqXdyuQJchuTGsmcpNuboTP
         x07+uF38trAdxeEJIK9QlpzJrUZbP12mTq9Cwbx3cdPhcB29umDfNBQGWp5oW42ypgJO
         mkCa8nU5pUI9klzcwGvg1O3ZZHlqIlpcXnyXqE0kOZiZpvApX/HJr2M7CzY2r2ZPB0Pa
         A5lu29yr18Qph3gfuW+gAQg/HWROT1nuo+m+hkAKyN91ci8sq3zU4eV8hNIqntFZz6eU
         mrvqyVneAez5tDgFQ9ByiEJie1gex4oZESPhxBDWEOhvCCDSCj7KzKA5qs2dnNqhSNwF
         fCYQ==
X-Gm-Message-State: AOJu0YwrlOESZeuTnX22oLFa6aL4PweCpsltkUtkwKqjCImUp9Sd8VG3
	3UDGxqqhGtoiYSbtjWzd8NUC9SeaNWj5yDD9zEEXlbBpi5Cd3EXM61r6A6Spa/i7+48TIpv9oJj
	c2Ou5Uw==
X-Google-Smtp-Source: AGHT+IEOQBaMEAvleppb/EovoeaLiKtKiBcIU94Oi/VyxWJdP6zfronmkNL2Eo+AX+x2swLUqtIL0Q==
X-Received: by 2002:a9d:75c4:0:b0:6f9:57e0:831a with SMTP id 46e09a7af769-6f957e0848cmr2189256a34.33.1717770411314;
        Fri, 07 Jun 2024 07:26:51 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795330b2310sm170869585a.84.2024.06.07.07.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:26:50 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 02/29] nfs: pass nfs_client to nfs_initiate_commit
Date: Fri,  7 Jun 2024 10:26:19 -0400
Message-ID: <20240607142646.20924-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607142646.20924-1-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weston Andros Adamson <dros@primarydata.com>

The nfs_client is needed for localio support.

Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/filelayout/filelayout.c         | 3 ++-
 fs/nfs/flexfilelayout/flexfilelayout.c | 2 +-
 fs/nfs/internal.h                      | 3 ++-
 fs/nfs/pnfs_nfs.c                      | 3 ++-
 fs/nfs/write.c                         | 9 ++++++---
 5 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 43e16e9e0176..0c4a1fbb6a19 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -1009,7 +1009,8 @@ static int filelayout_initiate_commit(struct nfs_commit_data *data, int how)
 	fh = select_ds_fh_from_commit(lseg, data->ds_commit_index);
 	if (fh)
 		data->args.fh = fh;
-	return nfs_initiate_commit(ds_clnt, data, NFS_PROTO(data->inode),
+	return nfs_initiate_commit(ds->ds_clp, ds_clnt, data,
+				   NFS_PROTO(data->inode),
 				   &filelayout_commit_call_ops, how,
 				   RPC_TASK_SOFTCONN);
 out_err:
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 327f1a5c9fbe..dee4bc560b8e 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1948,7 +1948,7 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	if (fh)
 		data->args.fh = fh;
 
-	ret = nfs_initiate_commit(ds_clnt, data, ds->ds_clp->rpc_ops,
+	ret = nfs_initiate_commit(ds->ds_clp, ds_clnt, data, ds->ds_clp->rpc_ops,
 				   vers == 3 ? &ff_layout_commit_call_ops_v3 :
 					       &ff_layout_commit_call_ops_v4,
 				   how, RPC_TASK_SOFTCONN);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index a9c0c29f7804..13c28cae45c5 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -525,7 +525,8 @@ extern void nfs_pageio_init_write(struct nfs_pageio_descriptor *pgio,
 extern void nfs_pageio_reset_write_mds(struct nfs_pageio_descriptor *pgio);
 extern void nfs_commit_free(struct nfs_commit_data *p);
 extern void nfs_commit_prepare(struct rpc_task *task, void *calldata);
-extern int nfs_initiate_commit(struct rpc_clnt *clnt,
+extern int nfs_initiate_commit(struct nfs_client *clp,
+			       struct rpc_clnt *clnt,
 			       struct nfs_commit_data *data,
 			       const struct nfs_rpc_ops *nfs_ops,
 			       const struct rpc_call_ops *call_ops,
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 88e061bd711b..b29b50c2c933 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -534,7 +534,8 @@ pnfs_generic_commit_pagelist(struct inode *inode, struct list_head *mds_pages,
 		list_del(&data->list);
 		if (data->ds_commit_index < 0) {
 			nfs_init_commit(data, NULL, NULL, cinfo);
-			nfs_initiate_commit(NFS_CLIENT(inode), data,
+			nfs_initiate_commit(NFS_SERVER(inode)->nfs_client,
+					    NFS_CLIENT(inode), data,
 					    NFS_PROTO(data->inode),
 					    data->mds_ops, how,
 					    RPC_TASK_CRED_NOREF);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 2329cbb0e446..c9cfa1308264 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1667,7 +1667,9 @@ void nfs_commitdata_release(struct nfs_commit_data *data)
 }
 EXPORT_SYMBOL_GPL(nfs_commitdata_release);
 
-int nfs_initiate_commit(struct rpc_clnt *clnt, struct nfs_commit_data *data,
+int nfs_initiate_commit(struct nfs_client *clp,
+			struct rpc_clnt *rpc_clnt,
+			struct nfs_commit_data *data,
 			const struct nfs_rpc_ops *nfs_ops,
 			const struct rpc_call_ops *call_ops,
 			int how, int flags)
@@ -1681,7 +1683,7 @@ int nfs_initiate_commit(struct rpc_clnt *clnt, struct nfs_commit_data *data,
 	};
 	struct rpc_task_setup task_setup_data = {
 		.task = &data->task,
-		.rpc_client = clnt,
+		.rpc_client = rpc_clnt,
 		.rpc_message = &msg,
 		.callback_ops = call_ops,
 		.callback_data = data,
@@ -1814,7 +1816,8 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 	nfs_init_commit(data, head, NULL, cinfo);
 	if (NFS_SERVER(inode)->nfs_client->cl_minorversion)
 		task_flags = RPC_TASK_MOVEABLE;
-	return nfs_initiate_commit(NFS_CLIENT(inode), data, NFS_PROTO(inode),
+	return nfs_initiate_commit(NFS_SERVER(inode)->nfs_client,
+				   NFS_CLIENT(inode), data, NFS_PROTO(inode),
 				   data->mds_ops, how,
 				   RPC_TASK_CRED_NOREF | task_flags);
 }
-- 
2.44.0


