Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387354AE14F
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 19:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385313AbiBHSpK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 13:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385321AbiBHSpB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 13:45:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC38CC03FEDC
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 10:44:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8757960DFF
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 18:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F9AC004E1;
        Tue,  8 Feb 2022 18:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644345889;
        bh=bcwD14xEuE8U1chEKjNelzR9KFTDCtuFVC8COole5gA=;
        h=From:To:Cc:Subject:Date:From;
        b=mJNbAXJ1eY9oKDJgdwAnyHB79lBTLTIjFXwDxOvsLjZfF5w6tKroey7FR1X2B1npp
         WjObu6HwR3L3RYjWdDun0a2gObR8AjCZCULq9T7WwJVo86V+BXkIrFeYkO4+LMhHx9
         ap3vfq3d6J/gfUU88OGfnkgOHJHxZnCMGVNQG2GLNn3hIPr8Z+WtXu4xC/v6PALBdI
         YpKI86Ni2nwKBdDz38VvostRw6TEjGAON2M/gnFWfWblrED14Oiw23jf/7meMtZFgJ
         8Cwbn0Hui1EuSSOx/MhiPpGQXJSKD297LPK0peUD2Iz5+cd7BEOj4FiR5RLfGii83N
         aGYvjsAzroy8A==
From:   trondmy@kernel.org
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: LOOKUP_DIRECTORY is also ok with symlinks
Date:   Tue,  8 Feb 2022 13:38:23 -0500
Message-Id: <20220208183823.1391397-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Commit ac795161c936 (NFSv4: Handle case where the lookup of a directory
fails) [1], part of Linux since 5.17-rc2, introduced a regression, where
a symbolic link on an NFS mount to a directory on another NFS does not
resolve(?) the first time it is accessed:

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Fixes: ac795161c936 ("NFSv4: Handle case where the lookup of a directory fails")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e128503728f2..6dee4e12d381 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2051,14 +2051,14 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (!res) {
 		inode = d_inode(dentry);
 		if ((lookup_flags & LOOKUP_DIRECTORY) && inode &&
-		    !S_ISDIR(inode->i_mode))
+		    !(S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)))
 			res = ERR_PTR(-ENOTDIR);
 		else if (inode && S_ISREG(inode->i_mode))
 			res = ERR_PTR(-EOPENSTALE);
 	} else if (!IS_ERR(res)) {
 		inode = d_inode(res);
 		if ((lookup_flags & LOOKUP_DIRECTORY) && inode &&
-		    !S_ISDIR(inode->i_mode)) {
+		    !(S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))) {
 			dput(res);
 			res = ERR_PTR(-ENOTDIR);
 		} else if (inode && S_ISREG(inode->i_mode)) {
-- 
2.34.1

