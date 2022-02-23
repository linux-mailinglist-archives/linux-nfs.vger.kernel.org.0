Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C834C1D8F
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 22:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbiBWVUC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 16:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241417AbiBWVUB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 16:20:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0D04EA0A
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:19:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1599561650
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B665C340F1
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645651172;
        bh=AU/1BuAYIRPvCSJMRaL7bK15l0+X1t9HvSCk7ukL0FY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=a/t3qLqs2ThixYWZ3AgOZPm5yZ1lxK25+IV13TdqIxy/88Iwq89gJ3qqXCT7tUlQP
         bekjRJVhkqTJ8UbwKPJ7tB38aohKHPmo52NUzb5FTdIPgtPANN9k3lIqKyXUGtC++x
         elSHNFc6fw9qyehPSWqKsw0MYPFCgux2dF9C7K5wsdRfaHaoNwrY6EtQOu7oprXfih
         zAkAPR1KTsoKgyubyVRVfPAG6e8TE7B5398PIy0RkCAs79dTLYxF11f3kUMtMLeakH
         ez0pOovRsFkgbhQu2nHEBLWgmUgyAXHeOCgHRter+WZIoTbpjItXIISyBEzHAtTm0C
         E5nA/HsyKoDlQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 02/21] NFS: Trace lookup revalidation failure
Date:   Wed, 23 Feb 2022 16:12:46 -0500
Message-Id: <20220223211305.296816-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223211305.296816-2-trondmy@kernel.org>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
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

