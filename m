Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DA661E575
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Nov 2022 20:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiKFTJI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Nov 2022 14:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiKFTJI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Nov 2022 14:09:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295206464
        for <linux-nfs@vger.kernel.org>; Sun,  6 Nov 2022 11:09:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5C5460CF5
        for <linux-nfs@vger.kernel.org>; Sun,  6 Nov 2022 19:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C106CC433D6;
        Sun,  6 Nov 2022 19:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667761746;
        bh=QunM5lI6lxdAhZd95G3NK9COwpbDdh+RMwxj3rOUJwg=;
        h=From:To:Cc:Subject:Date:From;
        b=AmvB2OkbuSVezfseVmd/2dVOVAHx/xvBg8h071tzpnnXbLjuWCeoIvD1gZAUFD2gM
         RvoBAWTmQlx6hLFBDDdQgQBr/3Dpf0cqukCDfRUYFiptlVOOjFjCfd4Z33pgTcCfKO
         rfcKrD/2xWDUkuh2zDf9P8Iuw3Pnhvvcpk/+YsUuJ+DG2KnVlaqxuZBhQr4uSvOTQW
         1pY2Fvz4EvkOUmhqd8pSROHGbzVmbmoalcccaW3yUxNpemK8BYrKYPcl2QdnVIBmVA
         g9qHwOXilYHM0G2/W8DVWEJpeE5FJCmhbQskZMNkuaKjtsXQhx3j6jN2J2j2g2wULc
         e6qGsrfoQ6/Fg==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH] lockd: set other missing fields when unlocking files
Date:   Sun,  6 Nov 2022 14:02:39 -0500
Message-Id: <20221106190239.404803-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

vfs_lock_file() expects the struct file_lock to be fully initialised by
the caller. Re-exported NFSv3 has been seen to Oops if the fl_file field
is NULL.

Fixes: aec158242b87 ("lockd: set fl_owner when unlocking files")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/lockd/svcsubs.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index e1c4617de771..3515f17eaf3f 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -176,7 +176,7 @@ nlm_delete_file(struct nlm_file *file)
 	}
 }
 
-static int nlm_unlock_files(struct nlm_file *file, fl_owner_t owner)
+static int nlm_unlock_files(struct nlm_file *file, const struct file_lock *fl)
 {
 	struct file_lock lock;
 
@@ -184,12 +184,15 @@ static int nlm_unlock_files(struct nlm_file *file, fl_owner_t owner)
 	lock.fl_type  = F_UNLCK;
 	lock.fl_start = 0;
 	lock.fl_end   = OFFSET_MAX;
-	lock.fl_owner = owner;
-	if (file->f_file[O_RDONLY] &&
-	    vfs_lock_file(file->f_file[O_RDONLY], F_SETLK, &lock, NULL))
+	lock.fl_owner = fl->fl_owner;
+	lock.fl_pid   = fl->fl_pid;
+	lock.fl_flags = FL_POSIX;
+
+	lock.fl_file = file->f_file[O_RDONLY];
+	if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NULL))
 		goto out_err;
-	if (file->f_file[O_WRONLY] &&
-	    vfs_lock_file(file->f_file[O_WRONLY], F_SETLK, &lock, NULL))
+	lock.fl_file = file->f_file[O_WRONLY];
+	if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NULL))
 		goto out_err;
 	return 0;
 out_err:
@@ -226,7 +229,7 @@ nlm_traverse_locks(struct nlm_host *host, struct nlm_file *file,
 		if (match(lockhost, host)) {
 
 			spin_unlock(&flctx->flc_lock);
-			if (nlm_unlock_files(file, fl->fl_owner))
+			if (nlm_unlock_files(file, fl))
 				return 1;
 			goto again;
 		}
-- 
2.38.1

