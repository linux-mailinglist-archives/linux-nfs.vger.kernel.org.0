Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B99E119CD51
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2020 01:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389586AbgDBXHQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Apr 2020 19:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388715AbgDBXHQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 2 Apr 2020 19:07:16 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D78A32073B
        for <linux-nfs@vger.kernel.org>; Thu,  2 Apr 2020 23:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585868836;
        bh=tBe1xn5UtOjC6jEuHaEQeUMbqhQsKbohIVkjXsLrBXY=;
        h=From:To:Subject:Date:From;
        b=1N2AkPI4zkGEVhh8CJp4dioOVwQppS3nZgUkfvgFyzZ1roBiQmwOXUagkVcb5CWwF
         7+AyT+PmiyRR6somp0GOqxsqTBqm0g/iNvv1wMMZLboiQgpvXLn5NuWhOz4cv5N2uh
         5tqu6yS+w0gQyfaTYDDkfdN8OZ4maL0kc+TVrrpc=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] NFS: finish_automount() requires us to hold 2 refs to the mount record
Date:   Thu,  2 Apr 2020 19:05:06 -0400
Message-Id: <20200402230507.795151-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We must not return from nfs_d_automount() without holding 2 references
to the mount record. Doing so, will trigger the BUG() in finish_automount().
Also ensure that we don't try to reschedule the automount timer with
a negative or zero timeout value.

Fixes: 22a1ae9a93fb ("NFS: If nfs_mountpoint_expiry_timeout < 0, do not expire submounts")
Cc: stable@vger.kernel.org # v5.5+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/namespace.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index da67820462f2..fe19ae280262 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -145,6 +145,7 @@ struct vfsmount *nfs_d_automount(struct path *path)
 	struct vfsmount *mnt = ERR_PTR(-ENOMEM);
 	struct nfs_server *server = NFS_SERVER(d_inode(path->dentry));
 	struct nfs_client *client = server->nfs_client;
+	int timeout = READ_ONCE(nfs_mountpoint_expiry_timeout);
 	int ret;
 
 	if (IS_ROOT(path->dentry))
@@ -190,12 +191,12 @@ struct vfsmount *nfs_d_automount(struct path *path)
 	if (IS_ERR(mnt))
 		goto out_fc;
 
-	if (nfs_mountpoint_expiry_timeout < 0)
+	mntget(mnt); /* prevent immediate expiration */
+	if (timeout <= 0)
 		goto out_fc;
 
-	mntget(mnt); /* prevent immediate expiration */
 	mnt_set_expiry(mnt, &nfs_automount_list);
-	schedule_delayed_work(&nfs_automount_task, nfs_mountpoint_expiry_timeout);
+	schedule_delayed_work(&nfs_automount_task, timeout);
 
 out_fc:
 	put_fs_context(fc);
@@ -233,10 +234,11 @@ const struct inode_operations nfs_referral_inode_operations = {
 static void nfs_expire_automounts(struct work_struct *work)
 {
 	struct list_head *list = &nfs_automount_list;
+	int timeout = READ_ONCE(nfs_mountpoint_expiry_timeout);
 
 	mark_mounts_for_expiry(list);
-	if (!list_empty(list))
-		schedule_delayed_work(&nfs_automount_task, nfs_mountpoint_expiry_timeout);
+	if (!list_empty(list) && timeout > 0)
+		schedule_delayed_work(&nfs_automount_task, timeout);
 }
 
 void nfs_release_automount_timer(void)
-- 
2.25.1

