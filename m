Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7434C1966F8
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 16:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgC1Peg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Mar 2020 11:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbgC1Pef (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 28 Mar 2020 11:34:35 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6E0A2073B
        for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2020 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585409675;
        bh=Typ3nTzxTQRHi7G9/zete+2FBPRAhEJYSVRiAt1mO9k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=r4yWllS1pSCIUw5Xn0Ks/iaD8e2tEuxlruBv6OQOnpS9YOIjc6U+VeGQ9Dk5NB7we
         EBIp9H07ieEnWL3fonF9K3qwhJh79o9G73cvBWdHM7yti8CeOw0P+BNetSBdtfKVlM
         5rt/uImUdMmhatnKhuWaDYm7GM2GRDLXiW0Q6QW0=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 04/22] NFSv4/pnfs: Support a list of commit arrays in struct pnfs_ds_commit_info
Date:   Sat, 28 Mar 2020 11:32:02 -0400
Message-Id: <20200328153220.1352010-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200328153220.1352010-4-trondmy@kernel.org>
References: <20200328153220.1352010-1-trondmy@kernel.org>
 <20200328153220.1352010-2-trondmy@kernel.org>
 <20200328153220.1352010-3-trondmy@kernel.org>
 <20200328153220.1352010-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When we have multiple layout segments with different lists of mirrored
data, we need to track the commits on a per layout segment basis.
This patch adds a list to support this tracking in struct
pnfs_ds_commit_info.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c                        |  1 +
 fs/nfs/filelayout/filelayout.c         |  5 ++++-
 fs/nfs/flexfilelayout/flexfilelayout.c |  1 +
 fs/nfs/pnfs.h                          | 11 +++++++++++
 include/linux/nfs_xdr.h                |  1 +
 5 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index ade2435551c8..f9a73febce02 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -305,6 +305,7 @@ static inline struct nfs_direct_req *nfs_direct_req_alloc(void)
 	kref_get(&dreq->kref);
 	init_completion(&dreq->completion);
 	INIT_LIST_HEAD(&dreq->mds_cinfo.list);
+	pnfs_init_ds_commit_info(&dreq->ds_cinfo);
 	dreq->verf.committed = NFS_INVALID_STABLE_HOW;	/* not set yet */
 	INIT_WORK(&dreq->work, nfs_direct_write_schedule_work);
 	spin_lock_init(&dreq->lock);
diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index bd234394a87c..b051d5d320ba 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -1140,7 +1140,10 @@ filelayout_alloc_layout_hdr(struct inode *inode, gfp_t gfp_flags)
 	struct nfs4_filelayout *flo;
 
 	flo = kzalloc(sizeof(*flo), gfp_flags);
-	return flo != NULL ? &flo->generic_hdr : NULL;
+	if (flo == NULL)
+		return NULL;
+	pnfs_init_ds_commit_info(&flo->commit_info);
+	return &flo->generic_hdr;
 }
 
 static void
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 19728206e9c6..c9e79c8e62cd 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -48,6 +48,7 @@ ff_layout_alloc_layout_hdr(struct inode *inode, gfp_t gfp_flags)
 
 	ffl = kzalloc(sizeof(*ffl), gfp_flags);
 	if (ffl) {
+		pnfs_init_ds_commit_info(&ffl->commit_info);
 		INIT_LIST_HEAD(&ffl->error_list);
 		INIT_LIST_HEAD(&ffl->mirrors);
 		ffl->last_report_time = ktime_get();
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index f6b1099aa151..b293afb48d04 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -462,6 +462,12 @@ pnfs_get_ds_info(struct inode *inode)
 	return ld->get_ds_info(inode);
 }
 
+static inline void
+pnfs_init_ds_commit_info(struct pnfs_ds_commit_info *fl_cinfo)
+{
+	INIT_LIST_HEAD(&fl_cinfo->commits);
+}
+
 static inline void
 pnfs_generic_mark_devid_invalid(struct nfs4_deviceid_node *node)
 {
@@ -759,6 +765,11 @@ pnfs_get_ds_info(struct inode *inode)
 	return NULL;
 }
 
+static inline void
+pnfs_init_ds_commit_info(struct pnfs_ds_commit_info *fl_cinfo)
+{
+}
+
 static inline bool
 pnfs_mark_request_commit(struct nfs_page *req, struct pnfs_layout_segment *lseg,
 			 struct nfs_commit_info *cinfo, u32 ds_commit_idx)
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index e91c917c9c1c..9946787eda72 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1280,6 +1280,7 @@ struct pnfs_commit_array {
 };
 
 struct pnfs_ds_commit_info {
+	struct list_head commits;
 	unsigned int nwritten;
 	unsigned int ncommitting;
 	unsigned int nbuckets;
-- 
2.25.1

