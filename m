Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463E24764C3
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Dec 2021 22:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhLOVo2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Dec 2021 16:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhLOVo1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Dec 2021 16:44:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB90AC061574
        for <linux-nfs@vger.kernel.org>; Wed, 15 Dec 2021 13:44:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 133D5CE1ED9
        for <linux-nfs@vger.kernel.org>; Wed, 15 Dec 2021 21:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4D5C36AE4
        for <linux-nfs@vger.kernel.org>; Wed, 15 Dec 2021 21:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639604663;
        bh=hbGbrC3SkROGsr2YoBb6ysGMWNyG311Xy2Zhu5rRecc=;
        h=From:To:Subject:Date:From;
        b=XUD4RH7zbmyh13Nn+uqT/6ILZx63SIMUWZTYu9oBx1fKa5zo1NW5n61S9iNxeGU2c
         fSJkH7GpJcLIEyPnOCeHAR51CIsCg3x16Dl72zLMpiuvNUseh+iRzo7qItVNwvtnNF
         Co+nBDJoa+u+4JD9hIkAaRhuSpyaTd/4sFVEFwdxeW7LLafsL0rUCV9FNu5St2AII6
         cPG8mY3IJKgXZkgy+gy3ErLzhdLrXjsE2OXrMBm2ws+OXeKmxRWbF2He4zvI/HrbNg
         JuUO4FeUMBhLhq0uJNZyaDtnGT1IzG0Mg/99Ua7+pYT4UiSBJJoagrjRoLLa2zt6SK
         2LF698iZXEbsQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFS: Ensure the server has an up to date ctime before hardlinking
Date:   Wed, 15 Dec 2021 16:38:15 -0500
Message-Id: <20211215213816.33864-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Creating a hard link is required by POSIX to update the file ctime, so
ensure that the file data is synced to disk so that we don't clobber the
updated ctime by writing back after creating the hard link.

Fixes: 9f7682728728 ("NFS: Move the delegation return down into nfs4_proc_link()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 731d31015b6a..4c4fdb208c7b 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2379,6 +2379,8 @@ nfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
 
 	trace_nfs_link_enter(inode, dir, dentry);
 	d_drop(dentry);
+	if (S_ISREG(inode->i_mode))
+		nfs_sync_inode(inode);
 	error = NFS_PROTO(dir)->link(inode, dir, &dentry->d_name);
 	if (error == 0) {
 		nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
-- 
2.33.1

