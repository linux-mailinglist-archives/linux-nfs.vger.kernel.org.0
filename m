Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D581966FD
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 16:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgC1Pei (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Mar 2020 11:34:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgC1Peh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 28 Mar 2020 11:34:37 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B13FA20748
        for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2020 15:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585409676;
        bh=vutH3/YReiNFiYTDSRW2/u7raVAoGoT4cTuq6TCiAtk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=miqghEpXJ8w7AZRyxyLvBN6eK0c68MB30GvrswnnsQZy9clekwsNkLrLqPrVAHzFt
         Fc6ikZD/wEfKgB74Am8OYSBRKAaS+Xe4LC7gCVex24mYqLif+M0aPo8QdnE+3qH+XN
         +btv3g0wT9aoQOMEw7u3Q2cNEtNluBF4aA2INy24=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 08/22] NFS/pNFS: Allow O_DIRECT to release the DS commitinfo
Date:   Sat, 28 Mar 2020 11:32:06 -0400
Message-Id: <20200328153220.1352010-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200328153220.1352010-8-trondmy@kernel.org>
References: <20200328153220.1352010-1-trondmy@kernel.org>
 <20200328153220.1352010-2-trondmy@kernel.org>
 <20200328153220.1352010-3-trondmy@kernel.org>
 <20200328153220.1352010-4-trondmy@kernel.org>
 <20200328153220.1352010-5-trondmy@kernel.org>
 <20200328153220.1352010-6-trondmy@kernel.org>
 <20200328153220.1352010-7-trondmy@kernel.org>
 <20200328153220.1352010-8-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add a pNFS callback to allow the O_DIRECT code to release the DS
commitinfo when freeing the dreq.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c |  1 +
 fs/nfs/pnfs.h   | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index f9a73febce02..7ef7f71ae315 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -317,6 +317,7 @@ static void nfs_direct_req_free(struct kref *kref)
 {
 	struct nfs_direct_req *dreq = container_of(kref, struct nfs_direct_req, kref);
 
+	pnfs_release_ds_info(&dreq->ds_cinfo, dreq->inode);
 	nfs_free_pnfs_ds_cinfo(&dreq->ds_cinfo);
 	if (dreq->l_ctx != NULL)
 		nfs_put_lock_context(dreq->l_ctx);
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index b293afb48d04..2ec97b419b56 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -149,6 +149,8 @@ struct pnfs_layoutdriver_type {
 	const struct nfs_pageio_ops *pg_write_ops;
 
 	struct pnfs_ds_commit_info *(*get_ds_info) (struct inode *inode);
+	void (*release_ds_info)(struct pnfs_ds_commit_info *,
+				struct inode *inode);
 	void (*mark_request_commit) (struct nfs_page *req,
 				     struct pnfs_layout_segment *lseg,
 				     struct nfs_commit_info *cinfo,
@@ -468,6 +470,15 @@ pnfs_init_ds_commit_info(struct pnfs_ds_commit_info *fl_cinfo)
 	INIT_LIST_HEAD(&fl_cinfo->commits);
 }
 
+static inline void
+pnfs_release_ds_info(struct pnfs_ds_commit_info *fl_cinfo, struct inode *inode)
+{
+	struct pnfs_layoutdriver_type *ld = NFS_SERVER(inode)->pnfs_curr_ld;
+
+	if (ld != NULL && ld->release_ds_info != NULL)
+		ld->release_ds_info(fl_cinfo, inode);
+}
+
 static inline void
 pnfs_generic_mark_devid_invalid(struct nfs4_deviceid_node *node)
 {
@@ -770,6 +781,11 @@ pnfs_init_ds_commit_info(struct pnfs_ds_commit_info *fl_cinfo)
 {
 }
 
+static inline void
+pnfs_release_ds_info(struct pnfs_ds_commit_info *fl_cinfo, struct inode *inode)
+{
+}
+
 static inline bool
 pnfs_mark_request_commit(struct nfs_page *req, struct pnfs_layout_segment *lseg,
 			 struct nfs_commit_info *cinfo, u32 ds_commit_idx)
-- 
2.25.1

