Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7BA422D85
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 18:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhJEQMg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 12:12:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236259AbhJEQMg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 5 Oct 2021 12:12:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 879716126A
        for <linux-nfs@vger.kernel.org>; Tue,  5 Oct 2021 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633450245;
        bh=8FJCMBdaJcwHhmtTOPTDpez9ZiFg+Yirbda9tnIqJpQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=b2qqdGN3iLQwaAG+4n1n48Mj26FBnhP6wAgIjgZ5VVpvCavASl4vE767IMT3uzKpQ
         lrK0BtNm4h/OwpmDcKy9WijOANC+k0Snes2J82NndP7tEiSrn+2BwUNrwxB7LlBXZS
         O2/eH6nPn8ZqE0hT6Y5jx3w/9+ETCKz54boqMWKl3wzIuzW+JSVvF+VCzJaySYFPFS
         +2IEmH69ZVeyt14yQeACarpXrCGFhpfF7QmDCdxO0zWZZp0033dPWdN+LrQ55gcR97
         Mgang+xN9jxDQMDon5Txc6RO4W7/tbyKB4ruc5XesxluYpMk9+rgRCKYEtCLyawOgc
         vutGwjfNCh+aQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFS: Fix up commit deadlocks
Date:   Tue,  5 Oct 2021 12:10:36 -0400
Message-Id: <20211005161036.1054428-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211005161036.1054428-1-trondmy@kernel.org>
References: <20211005161036.1054428-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If O_DIRECT bumps the commit_info rpcs_out field, then that could lead
to fsync() hangs. The fix is to ensure that O_DIRECT calls
nfs_commit_end().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c        | 2 +-
 fs/nfs/pnfs_nfs.c      | 2 --
 fs/nfs/write.c         | 9 ++++++---
 include/linux/nfs_fs.h | 1 +
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 2e894fec036b..3c0335c15a73 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -620,7 +620,7 @@ static void nfs_direct_commit_complete(struct nfs_commit_data *data)
 		nfs_unlock_and_release_request(req);
 	}
 
-	if (atomic_dec_and_test(&cinfo.mds->rpcs_out))
+	if (nfs_commit_end(cinfo.mds))
 		nfs_direct_write_complete(dreq);
 }
 
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 02bd6e83961d..316f68f96e57 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -468,7 +468,6 @@ pnfs_bucket_alloc_ds_commits(struct list_head *list,
 				goto out_error;
 			data->ds_commit_index = i;
 			list_add_tail(&data->list, list);
-			atomic_inc(&cinfo->mds->rpcs_out);
 			nreq++;
 		}
 		mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
@@ -520,7 +519,6 @@ pnfs_generic_commit_pagelist(struct inode *inode, struct list_head *mds_pages,
 		data->ds_commit_index = -1;
 		list_splice_init(mds_pages, &data->pages);
 		list_add_tail(&data->list, &list);
-		atomic_inc(&cinfo->mds->rpcs_out);
 		nreq++;
 	}
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 38f181e1343a..465220f47142 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1673,10 +1673,13 @@ static void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
 	atomic_inc(&cinfo->rpcs_out);
 }
 
-static void nfs_commit_end(struct nfs_mds_commit_info *cinfo)
+bool nfs_commit_end(struct nfs_mds_commit_info *cinfo)
 {
-	if (atomic_dec_and_test(&cinfo->rpcs_out))
+	if (atomic_dec_and_test(&cinfo->rpcs_out)) {
 		wake_up_var(&cinfo->rpcs_out);
+		return true;
+	}
+	return false;
 }
 
 void nfs_commitdata_release(struct nfs_commit_data *data)
@@ -1776,6 +1779,7 @@ void nfs_init_commit(struct nfs_commit_data *data,
 	data->res.fattr   = &data->fattr;
 	data->res.verf    = &data->verf;
 	nfs_fattr_init(&data->fattr);
+	nfs_commit_begin(cinfo->mds);
 }
 EXPORT_SYMBOL_GPL(nfs_init_commit);
 
@@ -1822,7 +1826,6 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 
 	/* Set up the argument struct */
 	nfs_init_commit(data, head, NULL, cinfo);
-	atomic_inc(&cinfo->mds->rpcs_out);
 	if (NFS_SERVER(inode)->nfs_client->cl_minorversion)
 		task_flags = RPC_TASK_MOVEABLE;
 	return nfs_initiate_commit(NFS_CLIENT(inode), data, NFS_PROTO(inode),
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 5893b986fa3b..140187b57db8 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -574,6 +574,7 @@ extern int nfs_wb_page_cancel(struct inode *inode, struct page* page);
 extern int  nfs_commit_inode(struct inode *, int);
 extern struct nfs_commit_data *nfs_commitdata_alloc(bool never_fail);
 extern void nfs_commit_free(struct nfs_commit_data *data);
+bool nfs_commit_end(struct nfs_mds_commit_info *cinfo);
 
 static inline int
 nfs_have_writebacks(struct inode *inode)
-- 
2.31.1

