Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13484C4DDA
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 19:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiBYSfR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 13:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiBYSfM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 13:35:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36091A8CBD
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 10:34:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B622B8330A
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C3BC340F0
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645814077;
        bh=AU/1BuAYIRPvCSJMRaL7bK15l0+X1t9HvSCk7ukL0FY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gVISJcBtZNd1IGj/sC+E0wTTpkNTDPlB2WGsscRF/m+KBRK2NAGEN8pGsqDiye9iW
         ycL0YbDBOc07RA6J7h0ieXGkKOMdqA7LcuX63f6D3kDwgXKhhgVrzsEy4+7BbaYBe8
         USzf2T0feE69+bSZ/sjessRpgcU+pRXF2MX1P8rUGSGGl8FdNeywBPZHapa4mSPK90
         0yTYNRLcDEpt8w+ZGV+qUuG8ltcV7Tx6UhYtx2cLbyBrxsrV/X+UQUq8JSbALVmFVb
         3goJPcGe1jjGUkfITjv0oBOM8EKtkY4clZ99juUeZvBdfhIGV4DtO2Uqcaiks/LaVc
         DnRCy3v8BAdeg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 03/24] NFS: Trace lookup revalidation failure
Date:   Fri, 25 Feb 2022 13:28:08 -0500
Message-Id: <20220225182829.1236093-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225182829.1236093-3-trondmy@kernel.org>
References: <20220225182829.1236093-1-trondmy@kernel.org>
 <20220225182829.1236093-2-trondmy@kernel.org>
 <20220225182829.1236093-3-trondmy@kernel.org>
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

