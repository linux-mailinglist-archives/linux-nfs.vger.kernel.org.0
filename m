Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E0B33A14C
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Mar 2021 22:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbhCMVJP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Mar 2021 16:09:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234299AbhCMVIt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 13 Mar 2021 16:08:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 149B96157E;
        Sat, 13 Mar 2021 21:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615669729;
        bh=zbGdaw7qizh4MZvSBnBCylvPPdbAZYhaY/eo1FBRb6s=;
        h=From:To:Cc:Subject:Date:From;
        b=RaA6it2gIPQ5UzQBh7ru2TtUHTpVNwkrtK3KqcqF2NSksUF6dhR41mIjoxiZgFJPA
         JSGOFmfvz9Z5qFLOLzJUxWEdYEUZhRUb6u6q0Lt16nueXOF0vHMCvxeTNRbRwTdqN/
         5lMxURUl2WRhQRb9Holqk4brM9kvFyq+Vj3JY0ty9QWkWyRSkCRgWr+0Dyyt3FTsBy
         crYQC9xf7oekm78JUNDKGABDhSVO7anvQ50qpj1iP8E77m3DbZyc/6eB2aTo0STX+O
         SNXUMRuQToqLOZF4qQgeGYZdVadFbPsP4m1pCVL86vZ4JxMF4rwurrXK2di7/rWJuQ
         +bK6h1/PeWwYw==
From:   trondmy@kernel.org
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: Ensure knfsd shuts down when the "nfsd" pseudofs is unmounted
Date:   Sat, 13 Mar 2021 16:08:47 -0500
Message-Id: <20210313210847.569041-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

In order to ensure that knfsd threads don't linger once the nfsd
pseudofs is unmounted (e.g. when the container is killed) we let
nfsd_umount() shut down those threads and wait for them to exit.

This also should ensure that we don't need to do a kernel mount of
the pseudofs, since the thread lifetime is now limited by the
lifetime of the filesystem.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/netns.h     |  6 +++---
 fs/nfsd/nfs4state.c |  8 +-------
 fs/nfsd/nfsctl.c    | 14 ++------------
 fs/nfsd/nfsd.h      |  3 +--
 fs/nfsd/nfssvc.c    | 35 ++++++++++++++++++++++++++++++++++-
 5 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index c330f5bd0cf3..a75abeb1e698 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -51,9 +51,6 @@ struct nfsd_net {
 	bool grace_ended;
 	time64_t boot_time;
 
-	/* internal mount of the "nfsd" pseudofilesystem: */
-	struct vfsmount *nfsd_mnt;
-
 	struct dentry *nfsd_client_dir;
 
 	/*
@@ -130,6 +127,9 @@ struct nfsd_net {
 	wait_queue_head_t ntf_wq;
 	atomic_t ntf_refcnt;
 
+	/* Allow umount to wait for nfsd state cleanup */
+	struct completion nfsd_shutdown_complete;
+
 	/*
 	 * clientid and stateid data for construction of net unique COPY
 	 * stateids.
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 423fd6683f3a..8bf840661d67 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7346,14 +7346,9 @@ nfs4_state_start_net(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	int ret;
 
-	ret = get_nfsdfs(net);
-	if (ret)
-		return ret;
 	ret = nfs4_state_create_net(net);
-	if (ret) {
-		mntput(nn->nfsd_mnt);
+	if (ret)
 		return ret;
-	}
 	locks_start_grace(net, &nn->nfsd4_manager);
 	nfsd4_client_tracking_init(net);
 	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size == 0)
@@ -7423,7 +7418,6 @@ nfs4_state_shutdown_net(struct net *net)
 
 	nfsd4_client_tracking_exit(net);
 	nfs4_state_destroy_net(net);
-	mntput(nn->nfsd_mnt);
 }
 
 void
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ef86ed23af82..02ff7f762e2d 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1416,6 +1416,8 @@ static void nfsd_umount(struct super_block *sb)
 {
 	struct net *net = sb->s_fs_info;
 
+	nfsd_shutdown_threads(net);
+
 	kill_litter_super(sb);
 	put_net(net);
 }
@@ -1428,18 +1430,6 @@ static struct file_system_type nfsd_fs_type = {
 };
 MODULE_ALIAS_FS("nfsd");
 
-int get_nfsdfs(struct net *net)
-{
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-	struct vfsmount *mnt;
-
-	mnt =  vfs_kern_mount(&nfsd_fs_type, SB_KERNMOUNT, "nfsd", NULL);
-	if (IS_ERR(mnt))
-		return PTR_ERR(mnt);
-	nn->nfsd_mnt = mnt;
-	return 0;
-}
-
 #ifdef CONFIG_PROC_FS
 static int create_proc_exports_entry(void)
 {
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 8bdc37aa2c2e..27c1308ffc2b 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -93,13 +93,12 @@ int		nfsd_get_nrthreads(int n, int *, struct net *);
 int		nfsd_set_nrthreads(int n, int *, struct net *);
 int		nfsd_pool_stats_open(struct inode *, struct file *);
 int		nfsd_pool_stats_release(struct inode *, struct file *);
+void		nfsd_shutdown_threads(struct net *net);
 
 void		nfsd_destroy(struct net *net);
 
 bool		i_am_nfsd(void);
 
-int get_nfsdfs(struct net *);
-
 struct nfsdfs_client {
 	struct kref cl_ref;
 	void (*cl_release)(struct kref *kref);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 6de406322106..f014b7aa0726 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -596,6 +596,37 @@ static const struct svc_serv_ops nfsd_thread_sv_ops = {
 	.svo_module		= THIS_MODULE,
 };
 
+static void nfsd_complete_shutdown(struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	WARN_ON(!mutex_is_locked(&nfsd_mutex));
+
+	nn->nfsd_serv = NULL;
+	complete(&nn->nfsd_shutdown_complete);
+}
+
+void nfsd_shutdown_threads(struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv;
+
+	mutex_lock(&nfsd_mutex);
+	serv = nn->nfsd_serv;
+	if (serv == NULL) {
+		mutex_unlock(&nfsd_mutex);
+		return;
+	}
+
+	svc_get(serv);
+	/* Kill outstanding nfsd threads */
+	serv->sv_ops->svo_setup(serv, NULL, 0);
+	nfsd_destroy(net);
+	mutex_unlock(&nfsd_mutex);
+	/* Wait for shutdown of nfsd_serv to complete */
+	wait_for_completion(&nn->nfsd_shutdown_complete);
+}
+
 bool i_am_nfsd(void)
 {
 	return kthread_func(current) == nfsd;
@@ -618,11 +649,13 @@ int nfsd_create_serv(struct net *net)
 						&nfsd_thread_sv_ops);
 	if (nn->nfsd_serv == NULL)
 		return -ENOMEM;
+	init_completion(&nn->nfsd_shutdown_complete);
 
 	nn->nfsd_serv->sv_maxconn = nn->max_connections;
 	error = svc_bind(nn->nfsd_serv, net);
 	if (error < 0) {
 		svc_destroy(nn->nfsd_serv);
+		nfsd_complete_shutdown(net);
 		return error;
 	}
 
@@ -671,7 +704,7 @@ void nfsd_destroy(struct net *net)
 		svc_shutdown_net(nn->nfsd_serv, net);
 	svc_destroy(nn->nfsd_serv);
 	if (destroy)
-		nn->nfsd_serv = NULL;
+		nfsd_complete_shutdown(net);
 }
 
 int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
-- 
2.30.2

