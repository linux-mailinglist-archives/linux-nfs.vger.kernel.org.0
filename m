Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA3E3ED83F
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Aug 2021 16:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhHPOAp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Aug 2021 10:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhHPOAX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Aug 2021 10:00:23 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4621AC0613A4
        for <linux-nfs@vger.kernel.org>; Mon, 16 Aug 2021 06:59:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id BF16F4F7C; Mon, 16 Aug 2021 09:59:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BF16F4F7C
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     daire@dneg.com, linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 3/8] nlm: minor refactoring
Date:   Mon, 16 Aug 2021 09:59:22 -0400
Message-Id: <1629122367-18541-4-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1629122367-18541-1-git-send-email-bfields@redhat.com>
References: <1629122367-18541-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

---
 fs/lockd/svclock.c | 16 ++++++++--------
 fs/lockd/svcsubs.c |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 1781fc5e9091..bc1cf31f3cce 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -474,8 +474,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 	__be32			ret;
 
 	dprintk("lockd: nlmsvc_lock(%s/%ld, ty=%d, pi=%d, %Ld-%Ld, bl=%d)\n",
-				locks_inode(file->f_file)->i_sb->s_id,
-				locks_inode(file->f_file)->i_ino,
+				nlmsvc_file_inode(file)->i_sb->s_id,
+				nlmsvc_file_inode(file)->i_ino,
 				lock->fl.fl_type, lock->fl.fl_pid,
 				(long long)lock->fl.fl_start,
 				(long long)lock->fl.fl_end,
@@ -581,8 +581,8 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 	struct nlm_lockowner	*test_owner;
 
 	dprintk("lockd: nlmsvc_testlock(%s/%ld, ty=%d, %Ld-%Ld)\n",
-				locks_inode(file->f_file)->i_sb->s_id,
-				locks_inode(file->f_file)->i_ino,
+				nlmsvc_file_inode(file)->i_sb->s_id,
+				nlmsvc_file_inode(file)->i_ino,
 				lock->fl.fl_type,
 				(long long)lock->fl.fl_start,
 				(long long)lock->fl.fl_end);
@@ -644,8 +644,8 @@ nlmsvc_unlock(struct net *net, struct nlm_file *file, struct nlm_lock *lock)
 	int	error;
 
 	dprintk("lockd: nlmsvc_unlock(%s/%ld, pi=%d, %Ld-%Ld)\n",
-				locks_inode(file->f_file)->i_sb->s_id,
-				locks_inode(file->f_file)->i_ino,
+				nlmsvc_file_inode(file)->i_sb->s_id,
+				nlmsvc_file_inode(file)->i_ino,
 				lock->fl.fl_pid,
 				(long long)lock->fl.fl_start,
 				(long long)lock->fl.fl_end);
@@ -673,8 +673,8 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_file *file, struct nlm_lock *l
 	int status = 0;
 
 	dprintk("lockd: nlmsvc_cancel(%s/%ld, pi=%d, %Ld-%Ld)\n",
-				locks_inode(file->f_file)->i_sb->s_id,
-				locks_inode(file->f_file)->i_ino,
+				nlmsvc_file_inode(file)->i_sb->s_id,
+				nlmsvc_file_inode(file)->i_ino,
 				lock->fl.fl_pid,
 				(long long)lock->fl.fl_start,
 				(long long)lock->fl.fl_end);
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index bbd2bdde4bea..2558598610a9 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -45,7 +45,7 @@ static inline void nlm_debug_print_fh(char *msg, struct nfs_fh *f)
 
 static inline void nlm_debug_print_file(char *msg, struct nlm_file *file)
 {
-	struct inode *inode = locks_inode(file->f_file);
+	struct inode *inode = nlmsvc_file_inode(file);
 
 	dprintk("lockd: %s %s/%ld\n",
 		msg, inode->i_sb->s_id, inode->i_ino);
@@ -415,7 +415,7 @@ nlmsvc_match_sb(void *datap, struct nlm_file *file)
 {
 	struct super_block *sb = datap;
 
-	return sb == locks_inode(file->f_file)->i_sb;
+	return sb == nlmsvc_file_inode(file)->i_sb;
 }
 
 /**
-- 
2.31.1

