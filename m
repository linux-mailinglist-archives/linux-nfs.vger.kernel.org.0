Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFBE191DB2
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 00:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgCXXtm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 19:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgCXXtm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 19:49:42 -0400
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net [68.40.189.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FBA02073E
        for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2020 23:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585093781;
        bh=p37VSKP4Th+3RkSkshW4MOTSZ2uTQKxP63nhdF5s+3Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Mzx3ImHOYcykLi0DNgACkNqNFs/6qvL9ceQIdVMhqQj+A9qcu5F3Nd9xyIkRn8Iqx
         OxMLsp0dQvp8C9eKaFiSywbdfGTLxpebT6A2NJ00cqyvVo0JvZCggtDcrHg8/mhHL1
         8qKzVVvmpZ8LWPBxxJEBc8WWwdka9juZSKQlyxeg=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 08/22] NFS/pNFS: Allow O_DIRECT to release the DS commitinfo
Date:   Tue, 24 Mar 2020 19:47:14 -0400
Message-Id: <20200324234728.8997-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324234728.8997-8-trondmy@kernel.org>
References: <20200324234728.8997-1-trondmy@kernel.org>
 <20200324234728.8997-2-trondmy@kernel.org>
 <20200324234728.8997-3-trondmy@kernel.org>
 <20200324234728.8997-4-trondmy@kernel.org>
 <20200324234728.8997-5-trondmy@kernel.org>
 <20200324234728.8997-6-trondmy@kernel.org>
 <20200324234728.8997-7-trondmy@kernel.org>
 <20200324234728.8997-8-trondmy@kernel.org>
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
index 45d3ad1ad4df..226d92761ff1 100644
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
index f6b1099aa151..4ff974631206 100644
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
@@ -462,6 +464,15 @@ pnfs_get_ds_info(struct inode *inode)
 	return ld->get_ds_info(inode);
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
@@ -759,6 +770,11 @@ pnfs_get_ds_info(struct inode *inode)
 	return NULL;
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

