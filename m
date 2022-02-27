Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638574C5FCE
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiB0XTR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiB0XTP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:19:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4E822529
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:18:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 441FAB80CE0
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE48C340F2
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646003915;
        bh=AU/1BuAYIRPvCSJMRaL7bK15l0+X1t9HvSCk7ukL0FY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=S4ZLcAceOCdZ43kFGMLknFt95GO1mrxc/Vb3/9YpLH6xU9wfnR/06A7mvf+Qnpx6O
         fn3oY+iKnuxGdj6YebFmH4Ba1jleLFawcTAcIo55qYQSxFG1f3L1HXkpgr3K8VEJMi
         2eTk5u1FRWkMAupy/WcdIEqLkeSjn+zzrs/YeY13mJiuful4ATcfpcFeoLBvdcwqVf
         M+PF77zSmO2TQOz97JNJmi74BrPwp7SAxxqDoG3brNM1WaAy8rKPsdpGe3OKaEpEeM
         bXL4rQg5vOOueieJNo6Xm8nwBrdlBr68BXh2wWgQWg/3BmEDl1zNqDXlAdFdWvX9fb
         Wtyw7YxvC5tyA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 03/27] NFS: Trace lookup revalidation failure
Date:   Sun, 27 Feb 2022 18:12:03 -0500
Message-Id: <20220227231227.9038-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227231227.9038-3-trondmy@kernel.org>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Enable tracing of lookup revalidation failures.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ebddc736eac2..1aa55cac9d9a 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1474,9 +1474,7 @@ nfs_lookup_revalidate_done(struct inode *dir, struct dentry *dentry,
 {
 	switch (error) {
 	case 1:
-		dfprintk(LOOKUPCACHE, "NFS: %s(%pd2) is valid\n",
-			__func__, dentry);
-		return 1;
+		break;
 	case 0:
 		/*
 		 * We can't d_drop the root of a disconnected tree:
@@ -1485,13 +1483,10 @@ nfs_lookup_revalidate_done(struct inode *dir, struct dentry *dentry,
 		 * inodes on unmount and further oopses.
 		 */
 		if (inode && IS_ROOT(dentry))
-			return 1;
-		dfprintk(LOOKUPCACHE, "NFS: %s(%pd2) is invalid\n",
-				__func__, dentry);
-		return 0;
+			error = 1;
+		break;
 	}
-	dfprintk(LOOKUPCACHE, "NFS: %s(%pd2) lookup returned error %d\n",
-				__func__, dentry, error);
+	trace_nfs_lookup_revalidate_exit(dir, dentry, 0, error);
 	return error;
 }
 
@@ -1623,9 +1618,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 		goto out_bad;
 
 	trace_nfs_lookup_revalidate_enter(dir, dentry, flags);
-	error = nfs_lookup_revalidate_dentry(dir, dentry, inode);
-	trace_nfs_lookup_revalidate_exit(dir, dentry, flags, error);
-	return error;
+	return nfs_lookup_revalidate_dentry(dir, dentry, inode);
 out_valid:
 	return nfs_lookup_revalidate_done(dir, dentry, inode, 1);
 out_bad:
-- 
2.35.1

