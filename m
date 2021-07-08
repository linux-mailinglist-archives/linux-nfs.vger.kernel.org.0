Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3B53BF3F3
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jul 2021 04:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhGHC0B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jul 2021 22:26:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230404AbhGHC0A (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 7 Jul 2021 22:26:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B25EC61CCF
        for <linux-nfs@vger.kernel.org>; Thu,  8 Jul 2021 02:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625710999;
        bh=T2YFfYSgAzoktNAAQzV92mlnnMjffifkbRTK4RkuaBc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=o3kaCHfJaaWJnp2E/UBaIRjy0gCxFl/4d9M/rZSgfBjP9Bw8Ni12QjKYsUnE3fqU0
         N7CSwDQdWWCjA+L/r9nD0oXbMh/KfI9AQq+6fTK3CZCtMn0AuOa2DXxP0+GddoLO5h
         c8Fxt1Ao5WtEMrh+ar3hAZwNZXHw7QKGxIFzc3JPw5D51gqrdilWP+rpyoIRTsTb1v
         a7ePVKPs/kP2ilSkGugBW3YLWG1vU/xv8jU8ssa67y5irFTQgEi8F9n6zb2l9iinjQ
         4+Q+A/jcMo8aRFRCrhK1TKFkSm1B56my5NfdNutMzr3LgP9zM2waMQjET2Ti7KIXKU
         mEwik8r4IBLeg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFS: Label the dentry with a verifier in nfs_rmdir() and nfs_unlink()
Date:   Wed,  7 Jul 2021 22:23:18 -0400
Message-Id: <20210708022318.71364-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210708022318.71364-1-trondmy@kernel.org>
References: <20210708022318.71364-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

After the success of an operation such as rmdir() or unlink(), we expect
to add the dentry back to the dcache as an ordinary negative dentry.
However in NFS, unless it is labelled with the appropriate verifier for
the parent directory state, then nfs_lookup_revalidate will end up
discarding that dentry and forcing a new lookup.

The fix is to ensure that we relabel the dentry appropriately on
success.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index baca036f3890..1ce1fa0a5926 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2197,6 +2197,18 @@ static void nfs_dentry_handle_enoent(struct dentry *dentry)
 		d_delete(dentry);
 }
 
+static void nfs_dentry_remove_handle_error(struct inode *dir,
+					   struct dentry *dentry, int error)
+{
+	switch (error) {
+	case -ENOENT:
+		d_delete(dentry);
+		fallthrough;
+	case 0:
+		nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
+	}
+}
+
 int nfs_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	int error;
@@ -2219,6 +2231,7 @@ int nfs_rmdir(struct inode *dir, struct dentry *dentry)
 		up_write(&NFS_I(d_inode(dentry))->rmdir_sem);
 	} else
 		error = NFS_PROTO(dir)->rmdir(dir, &dentry->d_name);
+	nfs_dentry_remove_handle_error(dir, dentry, error);
 	trace_nfs_rmdir_exit(dir, dentry, error);
 
 	return error;
@@ -2288,9 +2301,8 @@ int nfs_unlink(struct inode *dir, struct dentry *dentry)
 	}
 	spin_unlock(&dentry->d_lock);
 	error = nfs_safe_remove(dentry);
-	if (!error || error == -ENOENT) {
-		nfs_set_verifier(dentry, nfs_save_change_attribute(dir));
-	} else if (need_rehash)
+	nfs_dentry_remove_handle_error(dir, dentry, error);
+	if (need_rehash)
 		d_rehash(dentry);
 out:
 	trace_nfs_unlink_exit(dir, dentry, error);
-- 
2.31.1

