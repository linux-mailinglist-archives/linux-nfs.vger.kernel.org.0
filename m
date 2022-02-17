Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561F74BACBE
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 23:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343924AbiBQWjr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 17:39:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238033AbiBQWjr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 17:39:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E46C169222
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 14:39:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DED38617AD
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 22:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8460FC340EC
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 22:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645137571;
        bh=/CoS4tD/rJneRXLrapypwu6bXV4NqO/k3+cOr74Bynk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=S77UclXYXe/XIWWBFi+k9/xXzI1lDWi03EuqNQB5zPfaJDAQlBilU3oAP9+BcPLA0
         Xfa54X/zyq/uz88Wbif7/MLZkcWS18RNH1WJDMrFeGCdRNou1Che0MtW7qGaJgDfJ0
         rXsSl/eEEjFiYqgc8lTSUxasYcs6bUlR/o4T76i4nsXAz+T9ejH2I/Vvmd1Hws34pF
         TROSX8yHNSDN5+Oe9GuFn5Fr4au/WCnSCEc+dW3ELaI5v51mE71SahwfVJlV3Uyxd/
         5bOoHYC+Bzjnqwm+92qDH/NpYEagDhT0wLvCqgETtei1zuD0JOWPgETUJt2ATYkI/G
         DJ6QdtAh79qBw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 5/5] NFS: Don't ask for readdirplus if files are being written to
Date:   Thu, 17 Feb 2022 17:33:23 -0500
Message-Id: <20220217223323.696173-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217223323.696173-5-trondmy@kernel.org>
References: <20220217223323.696173-1-trondmy@kernel.org>
 <20220217223323.696173-2-trondmy@kernel.org>
 <20220217223323.696173-3-trondmy@kernel.org>
 <20220217223323.696173-4-trondmy@kernel.org>
 <20220217223323.696173-5-trondmy@kernel.org>
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

If a file is being written to, then readdirplus isn't going to help with
retrieving attributes, since we will have to flush out writes anyway in
order to sync the mtime/ctime.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 1bef81f5373a..00500c369c5f 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -837,6 +837,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	int err = 0;
 	bool force_sync = query_flags & AT_STATX_FORCE_SYNC;
 	bool do_update = false;
+	bool record_cache = !nfs_have_writebacks(inode);
 
 	trace_nfs_getattr_enter(inode);
 
@@ -845,7 +846,8 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 			STATX_INO | STATX_SIZE | STATX_BLOCKS;
 
 	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
-		nfs_readdirplus_parent_cache_hit(path->dentry);
+		if (record_cache)
+			nfs_readdirplus_parent_cache_hit(path->dentry);
 		goto out_no_revalidate;
 	}
 
@@ -894,17 +896,18 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	if (request_mask & STATX_BLOCKS)
 		do_update |= cache_validity & NFS_INO_INVALID_BLOCKS;
 
-	if (do_update) {
+	if (record_cache) {
 		/* Update the attribute cache */
-		if (!(server->flags & NFS_MOUNT_NOAC))
+		if (do_update && !(server->flags & NFS_MOUNT_NOAC))
 			nfs_readdirplus_parent_cache_miss(path->dentry);
 		else
 			nfs_readdirplus_parent_cache_hit(path->dentry);
+	}
+	if (do_update) {
 		err = __nfs_revalidate_inode(server, inode);
 		if (err)
 			goto out;
-	} else
-		nfs_readdirplus_parent_cache_hit(path->dentry);
+	}
 out_no_revalidate:
 	/* Only return attributes that were revalidated. */
 	stat->result_mask = nfs_get_valid_attrmask(inode) | request_mask;
-- 
2.35.1

