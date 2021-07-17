Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5313CC4C2
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Jul 2021 19:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhGQRXz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 17 Jul 2021 13:23:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232828AbhGQRXz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 17 Jul 2021 13:23:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0149D61002;
        Sat, 17 Jul 2021 17:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626542458;
        bh=N3G3NiVUjTCiY+tdpZHdz09FNW1fKXk7tFUNLmVTacI=;
        h=From:To:Cc:Subject:Date:From;
        b=Dkzsr9yOe1OBmctlYsb02l9cCxbkx1mesE8KRm5RxU0azhZ52Sbp5BDjkGa2VslVT
         pH0FcVxbP5Hx2Kp/YEVdA3q+2/DaX8IZVRmzJbD8RbZ6/K3kwOwaoMPnWtggAGBBvn
         zeUG3i+gQE5oJIwnxQgjkAJLK3pmZvMRGKsEOC9i9HBkfRq3XtpkOsqF8JxptKNrmN
         RqKtUxyQBTKigP1kTjID+HBw6smHYfSpyetvXcjthTj3eLgRNAv1qcW0fQxuQF29fq
         BQ2Bju3GWp4ZAgvW7SGeQlm6wUbr8IUyHb7nymcyfOoyyg79WumwWp2zF7iB8DTC6X
         ASfanZasR5KfA==
From:   trondmy@kernel.org
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Convert rpc_client refcount to use refcount_t
Date:   Sat, 17 Jul 2021 13:20:52 -0400
Message-Id: <20210717172052.232420-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

There are now tools in the refcount library that allow us to convert the
client shutdown code.

Reported-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/clnt.h          |  3 ++-
 net/sunrpc/auth_gss/gss_rpc_upcall.c |  2 +-
 net/sunrpc/clnt.c                    | 22 ++++++++++------------
 net/sunrpc/debugfs.c                 |  2 +-
 net/sunrpc/rpc_pipe.c                |  2 +-
 5 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 8b5d5c97553e..b2edd5fc2f0c 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -14,6 +14,7 @@
 #include <linux/socket.h>
 #include <linux/in.h>
 #include <linux/in6.h>
+#include <linux/refcount.h>
 
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/sunrpc/sched.h>
@@ -35,7 +36,7 @@ struct rpc_sysfs_client;
  * The high-level client handle
  */
 struct rpc_clnt {
-	atomic_t		cl_count;	/* Number of references */
+	refcount_t		cl_count;	/* Number of references */
 	unsigned int		cl_clid;	/* client id */
 	struct list_head	cl_clients;	/* Global list of clients */
 	struct list_head	cl_tasks;	/* List of tasks */
diff --git a/net/sunrpc/auth_gss/gss_rpc_upcall.c b/net/sunrpc/auth_gss/gss_rpc_upcall.c
index d1c003a25b0f..61c276bddaf2 100644
--- a/net/sunrpc/auth_gss/gss_rpc_upcall.c
+++ b/net/sunrpc/auth_gss/gss_rpc_upcall.c
@@ -160,7 +160,7 @@ static struct rpc_clnt *get_gssp_clnt(struct sunrpc_net *sn)
 	mutex_lock(&sn->gssp_lock);
 	clnt = sn->gssp_clnt;
 	if (clnt)
-		atomic_inc(&clnt->cl_count);
+		refcount_inc(&clnt->cl_count);
 	mutex_unlock(&sn->gssp_lock);
 	return clnt;
 }
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 8b4de70e8ead..9952fc0b1de6 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -167,7 +167,7 @@ static int rpc_clnt_skip_event(struct rpc_clnt *clnt, unsigned long event)
 	case RPC_PIPEFS_MOUNT:
 		if (clnt->cl_pipedir_objects.pdh_dentry != NULL)
 			return 1;
-		if (atomic_read(&clnt->cl_count) == 0)
+		if (refcount_read(&clnt->cl_count) == 0)
 			return 1;
 		break;
 	case RPC_PIPEFS_UMOUNT:
@@ -419,7 +419,7 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
 	clnt->cl_rtt = &clnt->cl_rtt_default;
 	rpc_init_rtt(&clnt->cl_rtt_default, clnt->cl_timeout->to_initval);
 
-	atomic_set(&clnt->cl_count, 1);
+	refcount_set(&clnt->cl_count, 1);
 
 	if (nodename == NULL)
 		nodename = utsname()->nodename;
@@ -431,7 +431,7 @@ static struct rpc_clnt * rpc_new_client(const struct rpc_create_args *args,
 	if (err)
 		goto out_no_path;
 	if (parent)
-		atomic_inc(&parent->cl_count);
+		refcount_inc(&parent->cl_count);
 
 	trace_rpc_clnt_new(clnt, xprt, program->name, args->servername);
 	return clnt;
@@ -918,18 +918,16 @@ rpc_free_client(struct rpc_clnt *clnt)
 static struct rpc_clnt *
 rpc_free_auth(struct rpc_clnt *clnt)
 {
-	if (clnt->cl_auth == NULL)
-		return rpc_free_client(clnt);
-
 	/*
 	 * Note: RPCSEC_GSS may need to send NULL RPC calls in order to
 	 *       release remaining GSS contexts. This mechanism ensures
 	 *       that it can do so safely.
 	 */
-	atomic_inc(&clnt->cl_count);
-	rpcauth_release(clnt->cl_auth);
-	clnt->cl_auth = NULL;
-	if (atomic_dec_and_test(&clnt->cl_count))
+	if (clnt->cl_auth != NULL) {
+		rpcauth_release(clnt->cl_auth);
+		clnt->cl_auth = NULL;
+	}
+	if (refcount_dec_and_test(&clnt->cl_count))
 		return rpc_free_client(clnt);
 	return NULL;
 }
@@ -943,7 +941,7 @@ rpc_release_client(struct rpc_clnt *clnt)
 	do {
 		if (list_empty(&clnt->cl_tasks))
 			wake_up(&destroy_wait);
-		if (!atomic_dec_and_test(&clnt->cl_count))
+		if (refcount_dec_not_one(&clnt->cl_count))
 			break;
 		clnt = rpc_free_auth(clnt);
 	} while (clnt != NULL);
@@ -1082,7 +1080,7 @@ void rpc_task_set_client(struct rpc_task *task, struct rpc_clnt *clnt)
 	if (clnt != NULL) {
 		rpc_task_set_transport(task, clnt);
 		task->tk_client = clnt;
-		atomic_inc(&clnt->cl_count);
+		refcount_inc(&clnt->cl_count);
 		if (clnt->cl_softrtry)
 			task->tk_flags |= RPC_TASK_SOFT;
 		if (clnt->cl_softerr)
diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index 56029e3af6ff..79995eb95927 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -90,7 +90,7 @@ static int tasks_open(struct inode *inode, struct file *filp)
 		struct seq_file *seq = filp->private_data;
 		struct rpc_clnt *clnt = seq->private = inode->i_private;
 
-		if (!atomic_inc_not_zero(&clnt->cl_count)) {
+		if (!refcount_inc_not_zero(&clnt->cl_count)) {
 			seq_release(inode, filp);
 			ret = -EINVAL;
 		}
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 09c000d490a1..ee5336d73fdd 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -423,7 +423,7 @@ rpc_info_open(struct inode *inode, struct file *file)
 		spin_lock(&file->f_path.dentry->d_lock);
 		if (!d_unhashed(file->f_path.dentry))
 			clnt = RPC_I(inode)->private;
-		if (clnt != NULL && atomic_inc_not_zero(&clnt->cl_count)) {
+		if (clnt != NULL && refcount_inc_not_zero(&clnt->cl_count)) {
 			spin_unlock(&file->f_path.dentry->d_lock);
 			m->private = clnt;
 		} else {
-- 
2.31.1

