Return-Path: <linux-nfs+bounces-3586-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6CB900679
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2361C1C22CAF
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCE3194AD3;
	Fri,  7 Jun 2024 14:26:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA3E194A7D
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770412; cv=none; b=EnAJ1KiIRsidgMZQzU39QZ4U/HJ6WYZwon4LFsx5IDzhmGcUQ/1O30yPjtvXViGFHPMwln+Siz7PL7ba6uBlTMvZcihuYqYpATiZHbvPlmUpQeLhI8tbXgDG0H3afyZZd9dFAOehs1KOuOU88g27dJDfre6bpif3wgHW5Ywf6jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770412; c=relaxed/simple;
	bh=0hD4p+RsLXXmIp/p7P+GiqGXMgQTU+kym+vazbNcDwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGcrvb3gXEMlHtbh03q3xX0eI+nWyOKNAMeLoo7vNitKHPQ7TIHKcpHqmLZJFcBu8KNWeodEBZ3R1JMj95VsL+FbLouc2vP/54QDX8bTSUIrf2pxJzx/uS+OCZddwIq32Ks58MntD0SNEJ97D6ZurvsjeRdqGLiTV4gXS+7q64o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f9475abde6so1272959a34.3
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770410; x=1718375210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USn/QLhozc2jhp0VH80LWJyVynJZNtqHCfecPyiFPC4=;
        b=ONVpEJZMMYvqTgafH/jEwVBSZFl9Ih8tDbC5UM9eGc+F6CJbFUBD6ZmT3d7K623QZf
         DUNZGs8xrQTZ/Qq7fLH66XXYP0cyhXxNN+plLJNy/EFVWpxirF7DPCo/NIVCdx5wKelH
         oxF6FSRTV1MnXuefmYDVvDpaYfLcwsJOGfN4QVEDe65I9nLFwXa2L3MKaO1iuHIc/Ztm
         E2pQvhRSeRHtjXWhtOh80m0qUKN1URrKCyOm37/Y7PaURSEpG6rDJkt2mJRPTHZVbS6z
         85XpqTLe0k0WbZ4WnVq/Cr/roDIq0UuWv4Wq6kmH4nS9LtqStgdvqI9yQyrCfGGre5ia
         sDjw==
X-Gm-Message-State: AOJu0Yyz5KPqFf9TuR8XPCT+EzDpW+eAFgycEoHayrEIx3RQrr+KY+m+
	tfTzYMx+RWFhp6WCTgA3geW4bDx+rC+YhVJ7LZD6Vp+10NWnfjq2qZfXmCHuJOtUcmBAKKiv8A2
	ZVJUfmg==
X-Google-Smtp-Source: AGHT+IE6sIBJWLN4L/mMTj/JpFUCaVTJDGOhhgKG6Wrq02dziFATQGj0dP3wmHZ8Eo8L8yWb9psgig==
X-Received: by 2002:a54:4094:0:b0:3d2:dca:4031 with SMTP id 5614622812f47-3d210d6264fmr2376561b6e.15.1717770409770;
        Fri, 07 Jun 2024 07:26:49 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f624895sm17691286d6.17.2024.06.07.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:26:49 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 01/29] nfs: pass nfs_client to nfs_initiate_pgio
Date: Fri,  7 Jun 2024 10:26:18 -0400
Message-ID: <20240607142646.20924-2-snitzer@kernel.org>
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
 fs/nfs/filelayout/filelayout.c         |  4 ++--
 fs/nfs/flexfilelayout/flexfilelayout.c |  6 ++++--
 fs/nfs/internal.h                      |  5 +++--
 fs/nfs/pagelist.c                      | 10 ++++++----
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 29d84dc66ca3..43e16e9e0176 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -486,7 +486,7 @@ filelayout_read_pagelist(struct nfs_pgio_header *hdr)
 	hdr->mds_offset = offset;
 
 	/* Perform an asynchronous read to ds */
-	nfs_initiate_pgio(ds_clnt, hdr, hdr->cred,
+	nfs_initiate_pgio(ds->ds_clp, ds_clnt, hdr, hdr->cred,
 			  NFS_PROTO(hdr->inode), &filelayout_read_call_ops,
 			  0, RPC_TASK_SOFTCONN);
 	return PNFS_ATTEMPTED;
@@ -528,7 +528,7 @@ filelayout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	hdr->args.offset = filelayout_get_dserver_offset(lseg, offset);
 
 	/* Perform an asynchronous write */
-	nfs_initiate_pgio(ds_clnt, hdr, hdr->cred,
+	nfs_initiate_pgio(ds->ds_clp, ds_clnt, hdr, hdr->cred,
 			  NFS_PROTO(hdr->inode), &filelayout_write_call_ops,
 			  sync, RPC_TASK_SOFTCONN);
 	return PNFS_ATTEMPTED;
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 24188af56d5b..327f1a5c9fbe 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1803,7 +1803,8 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	hdr->mds_offset = offset;
 
 	/* Perform an asynchronous read to ds */
-	nfs_initiate_pgio(ds_clnt, hdr, ds_cred, ds->ds_clp->rpc_ops,
+	nfs_initiate_pgio(ds->ds_clp, ds_clnt, hdr, ds_cred,
+			  ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_read_call_ops_v3 :
 				      &ff_layout_read_call_ops_v4,
 			  0, RPC_TASK_SOFTCONN);
@@ -1871,7 +1872,8 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	hdr->args.offset = offset;
 
 	/* Perform an asynchronous write */
-	nfs_initiate_pgio(ds_clnt, hdr, ds_cred, ds->ds_clp->rpc_ops,
+	nfs_initiate_pgio(ds->ds_clp, ds_clnt, hdr, ds_cred,
+			  ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_write_call_ops_v3 :
 				      &ff_layout_write_call_ops_v4,
 			  sync, RPC_TASK_SOFTCONN);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 9f0f4534744b..a9c0c29f7804 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -306,8 +306,9 @@ extern const struct nfs_pageio_ops nfs_pgio_rw_ops;
 struct nfs_pgio_header *nfs_pgio_header_alloc(const struct nfs_rw_ops *);
 void nfs_pgio_header_free(struct nfs_pgio_header *);
 int nfs_generic_pgio(struct nfs_pageio_descriptor *, struct nfs_pgio_header *);
-int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header *hdr,
-		      const struct cred *cred, const struct nfs_rpc_ops *rpc_ops,
+int nfs_initiate_pgio(struct nfs_client *clp, struct rpc_clnt *rpc_clnt,
+		      struct nfs_pgio_header *hdr, const struct cred *cred,
+		      const struct nfs_rpc_ops *rpc_ops,
 		      const struct rpc_call_ops *call_ops, int how, int flags);
 void nfs_free_request(struct nfs_page *req);
 struct nfs_pgio_mirror *
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 6efb5068c116..d9b795c538cd 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -844,8 +844,9 @@ static void nfs_pgio_prepare(struct rpc_task *task, void *calldata)
 		rpc_exit(task, err);
 }
 
-int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header *hdr,
-		      const struct cred *cred, const struct nfs_rpc_ops *rpc_ops,
+int nfs_initiate_pgio(struct nfs_client *clp, struct rpc_clnt *rpc_clnt,
+		      struct nfs_pgio_header *hdr, const struct cred *cred,
+		      const struct nfs_rpc_ops *rpc_ops,
 		      const struct rpc_call_ops *call_ops, int how, int flags)
 {
 	struct rpc_task *task;
@@ -855,7 +856,7 @@ int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header *hdr,
 		.rpc_cred = cred,
 	};
 	struct rpc_task_setup task_setup_data = {
-		.rpc_client = clnt,
+		.rpc_client = rpc_clnt,
 		.task = &hdr->task,
 		.rpc_message = &msg,
 		.callback_ops = call_ops,
@@ -1070,7 +1071,8 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 	if (ret == 0) {
 		if (NFS_SERVER(hdr->inode)->nfs_client->cl_minorversion)
 			task_flags = RPC_TASK_MOVEABLE;
-		ret = nfs_initiate_pgio(NFS_CLIENT(hdr->inode),
+		ret = nfs_initiate_pgio(NFS_SERVER(hdr->inode)->nfs_client,
+					NFS_CLIENT(hdr->inode),
 					hdr,
 					hdr->cred,
 					NFS_PROTO(hdr->inode),
-- 
2.44.0


