Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFFE4764C2
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Dec 2021 22:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhLOVo2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Dec 2021 16:44:28 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43036 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhLOVo1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Dec 2021 16:44:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 77AB1CE1F18
        for <linux-nfs@vger.kernel.org>; Wed, 15 Dec 2021 21:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498ADC36AE5
        for <linux-nfs@vger.kernel.org>; Wed, 15 Dec 2021 21:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639604663;
        bh=wTDXRVNqceF7c9KAZEL8gndX3dVGowIjLAtf7VSdjbo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=V8C4GAAKbh58En1+zZnJDzTcQzbkpgOR/k+iKSCfFB1dHdf58wgN2hTo+JyukImBu
         ftJOLBodBfPnApscPDcVWjZnF1U87hXv1sr+UIjG9o1vtVezue3SQ9y3IWdKMn1Zaa
         SwwnKt6blA/goVCDYrWB8huy5thMoJ+Uyv5lxncXyem0yKy0KSJeVbQ6xxPBJsif5I
         o51tTihIePLCelEyK+S7uRN5xiZnFA7uiQ//F3r2X4T0H6y1EHjAuFe68iFjBG8vmQ
         Sz5yZWTvZb+Er112umYhKrpi8BFLbqAbn8c0zX0yU0fLn4C9G+6tl0o9w5O8JQ4BHh
         0u5CjeC0nDbiQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFS: Ensure the server has an up to date ctime before renaming
Date:   Wed, 15 Dec 2021 16:38:16 -0500
Message-Id: <20211215213816.33864-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211215213816.33864-1-trondmy@kernel.org>
References: <20211215213816.33864-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Renaming a file is required by POSIX to update the file ctime, so
ensure that the file data is synced to disk so that we don't clobber the
updated ctime by writing back after creating the hard link.

Fixes: f2c2c552f119 ("NFS: Move delegation recall into the NFSv4 callback for rename_setup()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 4c4fdb208c7b..27f0ad481749 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2470,6 +2470,8 @@ int nfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		}
 	}
 
+	if (S_ISREG(old_inode->i_mode))
+		nfs_sync_inode(old_inode);
 	task = nfs_async_rename(old_dir, new_dir, old_dentry, new_dentry, NULL);
 	if (IS_ERR(task)) {
 		error = PTR_ERR(task);
-- 
2.33.1

