Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0D0191DAD
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 00:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCXXtk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 19:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgCXXtj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 19:49:39 -0400
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net [68.40.189.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 625172073E
        for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2020 23:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585093779;
        bh=xHWBf0eqI5OhgRxmiUyN/XIxypyT+fzgs4uxipL4d7Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Jbx+ah7W+O601HYTNqH4S5MJ1k8vw3KYCdIgckPC1CxfoCRfteaH4dP+sUsdDPSoo
         WMvoVNpD8+Rp78HjJY0u/PRNY8YYYe6dK3HmGX8n+dXeHhfqvGX5qfYbyrBVCP26Qw
         GILG0F/vMSeO2Uyu/o07LUsikK885DqxigPJhYmQ=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 04/22] NFSv4/pnfs: Support a list of commit arrays in struct pnfs_ds_commit_info
Date:   Tue, 24 Mar 2020 19:47:10 -0400
Message-Id: <20200324234728.8997-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324234728.8997-4-trondmy@kernel.org>
References: <20200324234728.8997-1-trondmy@kernel.org>
 <20200324234728.8997-2-trondmy@kernel.org>
 <20200324234728.8997-3-trondmy@kernel.org>
 <20200324234728.8997-4-trondmy@kernel.org>
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
 fs/nfs/direct.c                        | 1 +
 fs/nfs/filelayout/filelayout.c         | 5 ++++-
 fs/nfs/flexfilelayout/flexfilelayout.c | 1 +
 include/linux/nfs_xdr.h                | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index ade2435551c8..45d3ad1ad4df 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -305,6 +305,7 @@ static inline struct nfs_direct_req *nfs_direct_req_alloc(void)
 	kref_get(&dreq->kref);
 	init_completion(&dreq->completion);
 	INIT_LIST_HEAD(&dreq->mds_cinfo.list);
+	INIT_LIST_HEAD(&dreq->ds_cinfo.commits);
 	dreq->verf.committed = NFS_INVALID_STABLE_HOW;	/* not set yet */
 	INIT_WORK(&dreq->work, nfs_direct_write_schedule_work);
 	spin_lock_init(&dreq->lock);
diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index bd234394a87c..7bd02efbe19a 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -1140,7 +1140,10 @@ filelayout_alloc_layout_hdr(struct inode *inode, gfp_t gfp_flags)
 	struct nfs4_filelayout *flo;
 
 	flo = kzalloc(sizeof(*flo), gfp_flags);
-	return flo != NULL ? &flo->generic_hdr : NULL;
+	if (flo == NULL)
+		return NULL;
+	INIT_LIST_HEAD(&flo->commit_info.commits);
+	return &flo->generic_hdr;
 }
 
 static void
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 19728206e9c6..c7cccdd746e4 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -48,6 +48,7 @@ ff_layout_alloc_layout_hdr(struct inode *inode, gfp_t gfp_flags)
 
 	ffl = kzalloc(sizeof(*ffl), gfp_flags);
 	if (ffl) {
+		INIT_LIST_HEAD(&ffl->commit_info.commits);
 		INIT_LIST_HEAD(&ffl->error_list);
 		INIT_LIST_HEAD(&ffl->mirrors);
 		ffl->last_report_time = ktime_get();
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

