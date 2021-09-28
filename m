Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AFD41B91B
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Sep 2021 23:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242820AbhI1VTh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Sep 2021 17:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241482AbhI1VTg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Sep 2021 17:19:36 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82B7C06161C
        for <linux-nfs@vger.kernel.org>; Tue, 28 Sep 2021 14:17:56 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 950F46CEE; Tue, 28 Sep 2021 17:17:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 950F46CEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632863875;
        bh=T72PTg8STJEmQ+RkBGojSFoRr7YhN0yQqsqtIeepmpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f62vclgJwr6aF31+WXxV1mcr7DwJstZCNiIBxoAWe5TMHjd3+/EKv5QK/qikcWGiX
         WTpsfqIg6ewP2fo+dSc7YO+hpRltgxfK0r4y3qefmwiXfd17FAEThNI+95CguPyK/F
         sxUiv0DByWr36+T+vU2lC/ebBrn+2EKWkQxcKr1o=
Date:   Tue, 28 Sep 2021 17:17:55 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] gss: remove legacy gssd upcall pipe
Message-ID: <20210928211755.GI25415@fieldses.org>
References: <20210928193442.GF25415@fieldses.org>
 <20210928193756.GG25415@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928193756.GG25415@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 28, 2021 at 03:37:56PM -0400, J. Bruce Fields wrote:
> Just an odd todo I keep forgetting:
> 
> On Tue, Sep 28, 2021 at 03:34:42PM -0400, bfields wrote:
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > This code exists only for compatibility with nfs-utils before
> > 0cfdc66de043 "gssd: handle new client upcall" (which first appeared in
> > nfs-utils version 1.2.2, in 2019).  After 12 years, maybe it's time to
> > drop that compatibility code.
> 
> There's probably more that could go too.  It wasn't immediately obvious
> to me whether the code that waits for an open at the start of
> gss_{refresh,create}_upcall is still useful.

Eh, I think that can all go too.

--b.

 include/linux/sunrpc/rpc_pipe_fs.h |  1 -
 net/sunrpc/auth_gss/auth_gss.c     | 75 +-------------------------------------
 net/sunrpc/rpc_pipe.c              |  7 ----
 3 files changed, 1 insertion(+), 82 deletions(-)

diff --git a/include/linux/sunrpc/rpc_pipe_fs.h b/include/linux/sunrpc/rpc_pipe_fs.h
index cd188a527d16..f8a11d1cfbf8 100644
--- a/include/linux/sunrpc/rpc_pipe_fs.h
+++ b/include/linux/sunrpc/rpc_pipe_fs.h
@@ -36,7 +36,6 @@ struct rpc_pipe_ops {
 	ssize_t (*upcall)(struct file *, struct rpc_pipe_msg *, char __user *, size_t);
 	ssize_t (*downcall)(struct file *, const char __user *, size_t);
 	void (*release_pipe)(struct inode *);
-	int (*open_pipe)(struct inode *);
 	void (*destroy_msg)(struct rpc_pipe_msg *);
 };
 
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 8929178410e7..71fd2fb7c5fb 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -77,10 +77,6 @@ struct gss_auth {
 	const char *target_name;
 };
 
-/* pipe_version >= 0 if and only if someone has a pipe open. */
-static DEFINE_SPINLOCK(pipe_version_lock);
-static struct rpc_wait_queue pipe_version_rpc_waitqueue;
-static DECLARE_WAIT_QUEUE_HEAD(pipe_version_waitqueue);
 static void gss_put_auth(struct gss_auth *gss_auth);
 
 static void gss_free_ctx(struct gss_cl_ctx *);
@@ -246,38 +242,11 @@ struct gss_upcall_msg {
 	char databuf[UPCALL_BUF_LEN];
 };
 
-static int get_pipe_version(struct net *net)
-{
-	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
-	int ret;
-
-	spin_lock(&pipe_version_lock);
-	if (sn->pipe_version >= 0) {
-		atomic_inc(&sn->pipe_users);
-		ret = 0;
-	} else
-		ret = -EAGAIN;
-	spin_unlock(&pipe_version_lock);
-	return ret;
-}
-
-static void put_pipe_version(struct net *net)
-{
-	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
-
-	if (atomic_dec_and_lock(&sn->pipe_users, &pipe_version_lock)) {
-		sn->pipe_version = -1;
-		spin_unlock(&pipe_version_lock);
-	}
-}
-
 static void
 gss_release_msg(struct gss_upcall_msg *gss_msg)
 {
-	struct net *net = gss_msg->auth->net;
 	if (!refcount_dec_and_test(&gss_msg->count))
 		return;
-	put_pipe_version(net);
 	BUG_ON(!list_empty(&gss_msg->list));
 	if (gss_msg->ctx != NULL)
 		gss_put_ctx(gss_msg->ctx);
@@ -480,9 +449,6 @@ gss_alloc_msg(struct gss_auth *gss_auth,
 	gss_msg = kzalloc(sizeof(*gss_msg), GFP_NOFS);
 	if (gss_msg == NULL)
 		goto err;
-	err = get_pipe_version(gss_auth->net);
-	if (err < 0)
-		goto err_free_msg;
 	gss_msg->pipe = gss_auth->gss_pipe->pipe;
 	INIT_LIST_HEAD(&gss_msg->list);
 	rpc_init_wait_queue(&gss_msg->rpc_waitqueue, "RPCSEC_GSS upcall waitq");
@@ -495,12 +461,10 @@ gss_alloc_msg(struct gss_auth *gss_auth,
 		gss_msg->service_name = kstrdup_const(service_name, GFP_NOFS);
 		if (!gss_msg->service_name) {
 			err = -ENOMEM;
-			goto err_put_pipe_version;
+			goto err_free_msg;
 		}
 	}
 	return gss_msg;
-err_put_pipe_version:
-	put_pipe_version(gss_auth->net);
 err_free_msg:
 	kfree(gss_msg);
 err:
@@ -556,8 +520,6 @@ gss_refresh_upcall(struct rpc_task *task)
 		/* XXX: warning on the first, under the assumption we
 		 * shouldn't normally hit this case on a refresh. */
 		warn_gssd();
-		rpc_sleep_on_timeout(&pipe_version_rpc_waitqueue,
-				task, NULL, jiffies + (15 * HZ));
 		err = -EAGAIN;
 		goto out;
 	}
@@ -590,14 +552,12 @@ static inline int
 gss_create_upcall(struct gss_auth *gss_auth, struct gss_cred *gss_cred)
 {
 	struct net *net = gss_auth->net;
-	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
 	struct rpc_pipe *pipe;
 	struct rpc_cred *cred = &gss_cred->gc_base;
 	struct gss_upcall_msg *gss_msg;
 	DEFINE_WAIT(wait);
 	int err;
 
-retry:
 	err = 0;
 	/* if gssd is down, just skip upcalling altogether */
 	if (!gssd_running(net)) {
@@ -606,17 +566,6 @@ gss_create_upcall(struct gss_auth *gss_auth, struct gss_cred *gss_cred)
 		goto out;
 	}
 	gss_msg = gss_setup_upcall(gss_auth, cred);
-	if (PTR_ERR(gss_msg) == -EAGAIN) {
-		err = wait_event_interruptible_timeout(pipe_version_waitqueue,
-				sn->pipe_version >= 0, 15 * HZ);
-		if (sn->pipe_version < 0) {
-			warn_gssd();
-			err = -EACCES;
-		}
-		if (err < 0)
-			goto out;
-		goto retry;
-	}
 	if (IS_ERR(gss_msg)) {
 		err = PTR_ERR(gss_msg);
 		goto out;
@@ -743,27 +692,9 @@ gss_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 	return err;
 }
 
-static int gss_pipe_open(struct inode *inode)
-{
-	struct net *net = inode->i_sb->s_fs_info;
-	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
-
-	spin_lock(&pipe_version_lock);
-	if (sn->pipe_version < 0) {
-		sn->pipe_version = 1;
-		rpc_wake_up(&pipe_version_rpc_waitqueue);
-		wake_up(&pipe_version_waitqueue);
-	}
-	atomic_inc(&sn->pipe_users);
-	spin_unlock(&pipe_version_lock);
-	return 0;
-
-}
-
 static void
 gss_pipe_release(struct inode *inode)
 {
-	struct net *net = inode->i_sb->s_fs_info;
 	struct rpc_pipe *pipe = RPC_I(inode)->pipe;
 	struct gss_upcall_msg *gss_msg;
 
@@ -781,8 +712,6 @@ gss_pipe_release(struct inode *inode)
 		goto restart;
 	}
 	spin_unlock(&pipe->lock);
-
-	put_pipe_version(net);
 }
 
 static void
@@ -2113,7 +2042,6 @@ static const struct rpc_pipe_ops gss_upcall_ops_v1 = {
 	.upcall		= gss_v1_upcall,
 	.downcall	= gss_pipe_downcall,
 	.destroy_msg	= gss_pipe_destroy_msg,
-	.open_pipe	= gss_pipe_open,
 	.release_pipe	= gss_pipe_release,
 };
 
@@ -2148,7 +2076,6 @@ static int __init init_rpcsec_gss(void)
 	err = register_pernet_subsys(&rpcsec_gss_net_ops);
 	if (err)
 		goto out_svc_exit;
-	rpc_init_wait_queue(&pipe_version_rpc_waitqueue, "gss pipe version");
 	return 0;
 out_svc_exit:
 	gss_svc_shutdown();
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index ee5336d73fdd..f34bafb0dbd3 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -213,19 +213,12 @@ static int
 rpc_pipe_open(struct inode *inode, struct file *filp)
 {
 	struct rpc_pipe *pipe;
-	int first_open;
 	int res = -ENXIO;
 
 	inode_lock(inode);
 	pipe = RPC_I(inode)->pipe;
 	if (pipe == NULL)
 		goto out;
-	first_open = pipe->nreaders == 0 && pipe->nwriters == 0;
-	if (first_open && pipe->ops->open_pipe) {
-		res = pipe->ops->open_pipe(inode);
-		if (res)
-			goto out;
-	}
 	if (filp->f_mode & FMODE_READ)
 		pipe->nreaders++;
 	if (filp->f_mode & FMODE_WRITE)
