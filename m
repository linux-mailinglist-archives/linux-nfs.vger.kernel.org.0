Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A535A9E91
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 20:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiIASFu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 14:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiIASFa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 14:05:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D6A2656D
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 11:05:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A61BB828D5
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 18:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD1BC433D7;
        Thu,  1 Sep 2022 18:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662055505;
        bh=mdvtrkHa7qtNgD7qZLusIPKSk3uQZGN16MIvZMxST2E=;
        h=From:To:Cc:Subject:Date:From;
        b=ta5EiAi5pZvTS7/p0Do5O5TBzIb5lXXd+8u6c/WS9GqxFawwb50/5sOXShpzVxM3V
         OaDYX9FKgwTgnZ8ZBW14NU2YsN6Dv175xBDaq3z+baopBBZ924vCq6LX9p+3oB7IJ3
         Q5lc52NBvMV2QsrBZ5gqkc85l/yPBlkPGiRr0YGhf7+yFqrApUg4oAUAvCHxRl9azv
         lAclg5McjW8ie9IjKCyc0/nt4KrLcuSVo9RFNBLeZPTo7htqlKmfB4uL+iXVKbWNP8
         Ourct0Lq4dTH5NYtONL8UkHu+0FBpEU3E7Hl+oqQTxuvAzomMUZiRCBWxeMdJzS7Lk
         DZ4H4C7hFNqjQ==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, cuiyue-fnst@fujitsu.com
Subject: [PATCH v2] NFSv4.2: Update mode bits after ALLOCATE and DEALLOCATE
Date:   Thu,  1 Sep 2022 14:05:03 -0400
Message-Id: <20220901180503.1347290-1-anna@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

The fallocate call invalidates suid and sgid bits as part of normal
operation. We need to mark the mode bits as invalid when using fallocate
with an suid so these will be updated the next time the user looks at them.

This fixes xfstests generic/683 and generic/684.

Reported-by: Yue Cui <cuiyue-fnst@fujitsu.com>
Fixes: 913eca1aea87 ("NFS: Fallocate should use the nfs4_fattr_bitmap")
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/internal.h  | 25 +++++++++++++++++++++++++
 fs/nfs/nfs42proc.c | 13 ++++++++++++-
 fs/nfs/write.c     | 25 -------------------------
 3 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 27c720d71b4e..898dd95bc7a7 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -606,6 +606,31 @@ static inline gfp_t nfs_io_gfp_mask(void)
 	return GFP_KERNEL;
 }
 
+/*
+ * Special version of should_remove_suid() that ignores capabilities.
+ */
+static inline int nfs_should_remove_suid(const struct inode *inode)
+{
+	umode_t mode = inode->i_mode;
+	int kill = 0;
+
+	/* suid always must be killed */
+	if (unlikely(mode & S_ISUID))
+		kill = ATTR_KILL_SUID;
+
+	/*
+	 * sgid without any exec bits is just a mandatory locking mark; leave
+	 * it alone.  If some exec bits are set, it's a real sgid; kill it.
+	 */
+	if (unlikely((mode & S_ISGID) && (mode & S_IXGRP)))
+		kill |= ATTR_KILL_SGID;
+
+	if (unlikely(kill && S_ISREG(mode)))
+		return kill;
+
+	return 0;
+}
+
 /* unlink.c */
 extern struct rpc_task *
 nfs_async_rename(struct inode *old_dir, struct inode *new_dir,
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 068c45b3bc1a..23023ddf75d1 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -56,6 +56,7 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 	struct nfs42_falloc_res res = {
 		.falloc_server	= server,
 	};
+	unsigned int invalid = 0;
 	int status;
 
 	msg->rpc_argp = &args;
@@ -78,10 +79,20 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 
 	status = nfs4_call_sync(server->client, server, msg,
 				&args.seq_args, &res.seq_res, 0);
+
+	if (!res.falloc_fattr->valid)
+		invalid |= NFS_INO_INVALID_ATTR;
+	if (nfs_should_remove_suid(inode))
+		invalid |= NFS_INO_INVALID_MODE;
+	if (invalid) {
+		spin_lock(&inode->i_lock);
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
+		spin_unlock(&inode->i_lock);
+	}
+
 	if (status == 0)
 		status = nfs_post_op_update_inode_force_wcc(inode,
 							    res.falloc_fattr);
-
 	if (msg->rpc_proc == &nfs4_procedures[NFSPROC4_CLNT_ALLOCATE])
 		trace_nfs4_fallocate(inode, &args, status);
 	else
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 1843fa235d9b..f41d24b54fd1 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1496,31 +1496,6 @@ void nfs_commit_prepare(struct rpc_task *task, void *calldata)
 	NFS_PROTO(data->inode)->commit_rpc_prepare(task, data);
 }
 
-/*
- * Special version of should_remove_suid() that ignores capabilities.
- */
-static int nfs_should_remove_suid(const struct inode *inode)
-{
-	umode_t mode = inode->i_mode;
-	int kill = 0;
-
-	/* suid always must be killed */
-	if (unlikely(mode & S_ISUID))
-		kill = ATTR_KILL_SUID;
-
-	/*
-	 * sgid without any exec bits is just a mandatory locking mark; leave
-	 * it alone.  If some exec bits are set, it's a real sgid; kill it.
-	 */
-	if (unlikely((mode & S_ISGID) && (mode & S_IXGRP)))
-		kill |= ATTR_KILL_SGID;
-
-	if (unlikely(kill && S_ISREG(mode)))
-		return kill;
-
-	return 0;
-}
-
 static void nfs_writeback_check_extend(struct nfs_pgio_header *hdr,
 		struct nfs_fattr *fattr)
 {
-- 
2.37.2

