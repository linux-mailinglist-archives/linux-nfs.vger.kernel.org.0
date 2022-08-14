Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1FA592114
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Aug 2022 17:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240671AbiHNPdb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 Aug 2022 11:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240674AbiHNPcz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 14 Aug 2022 11:32:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C5D1C112
        for <linux-nfs@vger.kernel.org>; Sun, 14 Aug 2022 08:30:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 247A860C58
        for <linux-nfs@vger.kernel.org>; Sun, 14 Aug 2022 15:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6389AC433D6
        for <linux-nfs@vger.kernel.org>; Sun, 14 Aug 2022 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660491004;
        bh=/zZYdCbnjuoFkp8y9UuxHehaWoM728KTTBdb6SaFGMk=;
        h=From:To:Subject:Date:From;
        b=mtKUTvEBZJAeZN9WYAZfPUZA58fR9a/mewZ+SzCiyuBMkO16XKKTUER6WvBKsn0bt
         10+qk+hiEKycqgwI3HFKGvR4z9PjozK0ie9emE9xdya1uyLZ2NYddzcli7wYmgBd6O
         6+s2CPYsdBD8wJjoQyXD2BU//gEuRIjDrJV1Y5iNdPWbjczVR69pNSYJ0n00SUD4EE
         ToPfZMt99tVmVko2J2f039Z9oq+h2O+NroEZpCZJWkUTQ5HwNDWn2NOB3df8rnSGzL
         PPRYA7M9OLDsNUVyUYT2e6TiIkhek6jSLrCXGm0IzekwQDJldehRNms9Ehy7cya4x/
         JZoigbfR6ggAA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFS: Fix another fsync() issue after a server reboot
Date:   Sun, 14 Aug 2022 11:23:15 -0400
Message-Id: <20220814152317.30985-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Currently, when the writeback code detects a server reboot, it redirties
any pages that were not committed to disk, and it sets the flag
NFS_CONTEXT_RESEND_WRITES in the nfs_open_context of the file descriptor
that dirtied the file. While this allows the file descriptor in question
to redrive its own writes, it violates the fsync() requirement that we
should be synchronising all writes to disk.
While the problem is infrequent, we do see corner cases where an
untimely server reboot causes the fsync() call to abandon its attempt to
sync data to disk and causing data corruption issues due to missed error
conditions or similar.

In order to tighted up the client's ability to deal with this situation
without introducing livelocks, add a counter that records the number of
times pages are redirtied due to a server reboot-like condition, and use
that in fsync() to redrive the sync to disk.

Fixes: 2197e9b06c22 ("NFS: Fix up fsync() when the server rebooted")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c          | 15 ++++++---------
 fs/nfs/inode.c         |  1 +
 fs/nfs/write.c         |  6 ++++--
 include/linux/nfs_fs.h |  1 +
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 54237a231687..749e5487df50 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -221,8 +221,10 @@ nfs_file_fsync_commit(struct file *file, int datasync)
 int
 nfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
-	struct nfs_open_context *ctx = nfs_file_open_context(file);
 	struct inode *inode = file_inode(file);
+	struct nfs_inode *nfsi = NFS_I(inode);
+	long save_nredirtied = atomic_long_read(&nfsi->redirtied_pages);
+	long nredirtied;
 	int ret;
 
 	trace_nfs_fsync_enter(inode);
@@ -237,15 +239,10 @@ nfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 		ret = pnfs_sync_inode(inode, !!datasync);
 		if (ret != 0)
 			break;
-		if (!test_and_clear_bit(NFS_CONTEXT_RESEND_WRITES, &ctx->flags))
+		nredirtied = atomic_long_read(&nfsi->redirtied_pages);
+		if (nredirtied == save_nredirtied)
 			break;
-		/*
-		 * If nfs_file_fsync_commit detected a server reboot, then
-		 * resend all dirty pages that might have been covered by
-		 * the NFS_CONTEXT_RESEND_WRITES flag
-		 */
-		start = 0;
-		end = LLONG_MAX;
+		save_nredirtied = nredirtied;
 	}
 
 	trace_nfs_fsync_exit(inode, ret);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b4e46b0ffa2d..bea7c005119c 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -426,6 +426,7 @@ nfs_ilookup(struct super_block *sb, struct nfs_fattr *fattr, struct nfs_fh *fh)
 static void nfs_inode_init_regular(struct nfs_inode *nfsi)
 {
 	atomic_long_set(&nfsi->nrequests, 0);
+	atomic_long_set(&nfsi->redirtied_pages, 0);
 	INIT_LIST_HEAD(&nfsi->commit_info.list);
 	atomic_long_set(&nfsi->commit_info.ncommit, 0);
 	atomic_set(&nfsi->commit_info.rpcs_out, 0);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 4a3796811b4b..989c734cf91d 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1420,10 +1420,12 @@ static void nfs_initiate_write(struct nfs_pgio_header *hdr,
  */
 static void nfs_redirty_request(struct nfs_page *req)
 {
+	struct nfs_inode *nfsi = NFS_I(page_file_mapping(req->wb_page)->host);
+
 	/* Bump the transmission count */
 	req->wb_nio++;
 	nfs_mark_request_dirty(req);
-	set_bit(NFS_CONTEXT_RESEND_WRITES, &nfs_req_openctx(req)->flags);
+	atomic_long_inc(&nfsi->redirtied_pages);
 	nfs_end_page_writeback(req);
 	nfs_release_request(req);
 }
@@ -1904,7 +1906,7 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 		/* We have a mismatch. Write the page again */
 		dprintk_cont(" mismatch\n");
 		nfs_mark_request_dirty(req);
-		set_bit(NFS_CONTEXT_RESEND_WRITES, &nfs_req_openctx(req)->flags);
+		atomic_long_inc(&NFS_I(data->inode)->redirtied_pages);
 	next:
 		nfs_unlock_and_release_request(req);
 		/* Latency breaker */
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index b32ed68e7dc4..f08e581f0161 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -182,6 +182,7 @@ struct nfs_inode {
 		/* Regular file */
 		struct {
 			atomic_long_t	nrequests;
+			atomic_long_t	redirtied_pages;
 			struct nfs_mds_commit_info commit_info;
 			struct mutex	commit_mutex;
 		};
-- 
2.37.1

