Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2F949D5A3
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 23:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiAZWsI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jan 2022 17:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiAZWsH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jan 2022 17:48:07 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D7DC06161C
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jan 2022 14:48:07 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 65D0E70BB; Wed, 26 Jan 2022 17:48:06 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 65D0E70BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1643237286;
        bh=zcIfCYiNwLysDu98KIMpFNBdd4cCgI5pU9PkyPYCw9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xohl2PoT37s6NNbSmvjFFL8g25oqSIhejF+t1C7i7loU0woJFZhsRpJws3T4v+ky0
         WvFng4OPWeaWaS96T9J/oRtu5+Z13B0ZZ+ABiOoA+c0XZ+fBBckXBo1KLsh0lVSALb
         TDtJBmlTCAlGF8Xo1rINEzdZfYcZf0nmvxzQxFSI=
Date:   Wed, 26 Jan 2022 17:48:06 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3] gss: remove legacy gssd upcall pipe
Message-ID: <20220126224806.GE29832@fieldses.org>
References: <20210928193442.GF25415@fieldses.org>
 <20210928193756.GG25415@fieldses.org>
 <20210928211755.GI25415@fieldses.org>
 <20211001133014.GA959@fieldses.org>
 <20211003000720.GB15758@fieldses.org>
 <20211123165704.GE8978@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123165704.GE8978@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 23, 2021 at 11:57:04AM -0500, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> This code exists only for compatibility with nfs-utils before
> 0cfdc66de043 "gssd: handle new client upcall" (which first appeared in
> nfs-utils version 1.2.2, in 2009).  After 12 years, maybe it's time to
> drop that compatibility code.

Are you interested in this?  Should I resend?

--b.

> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  include/linux/sunrpc/rpc_pipe_fs.h |   1 -
>  net/sunrpc/auth_gss/auth_gss.c     | 165 ++---------------------------
>  net/sunrpc/rpc_pipe.c              |   7 --
>  3 files changed, 7 insertions(+), 166 deletions(-)
> 
> On Sat, Oct 02, 2021 at 08:07:20PM -0400, J. Bruce Fields wrote:
> > (Whoops, somebody just pointed out a typo'd a year--that 2019 should
> > obviously be 2009.
> 
> Resending with that typo fixed.  Can we get this in 5.17?  I think it'd
> make life just a little easier for the next person that has to mess with
> this code.
> 
> --b.
> 
> diff --git a/include/linux/sunrpc/rpc_pipe_fs.h b/include/linux/sunrpc/rpc_pipe_fs.h
> index cd188a527d16..f8a11d1cfbf8 100644
> --- a/include/linux/sunrpc/rpc_pipe_fs.h
> +++ b/include/linux/sunrpc/rpc_pipe_fs.h
> @@ -36,7 +36,6 @@ struct rpc_pipe_ops {
>  	ssize_t (*upcall)(struct file *, struct rpc_pipe_msg *, char __user *, size_t);
>  	ssize_t (*downcall)(struct file *, const char __user *, size_t);
>  	void (*release_pipe)(struct inode *);
> -	int (*open_pipe)(struct inode *);
>  	void (*destroy_msg)(struct rpc_pipe_msg *);
>  };
>  
> diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
> index 5f42aa5fc612..71fd2fb7c5fb 100644
> --- a/net/sunrpc/auth_gss/auth_gss.c
> +++ b/net/sunrpc/auth_gss/auth_gss.c
> @@ -73,24 +73,13 @@ struct gss_auth {
>  	enum rpc_gss_svc service;
>  	struct rpc_clnt *client;
>  	struct net *net;
> -	/*
> -	 * There are two upcall pipes; dentry[1], named "gssd", is used
> -	 * for the new text-based upcall; dentry[0] is named after the
> -	 * mechanism (for example, "krb5") and exists for
> -	 * backwards-compatibility with older gssd's.
> -	 */
> -	struct gss_pipe *gss_pipe[2];
> +	struct gss_pipe *gss_pipe;
>  	const char *target_name;
>  };
>  
> -/* pipe_version >= 0 if and only if someone has a pipe open. */
> -static DEFINE_SPINLOCK(pipe_version_lock);
> -static struct rpc_wait_queue pipe_version_rpc_waitqueue;
> -static DECLARE_WAIT_QUEUE_HEAD(pipe_version_waitqueue);
>  static void gss_put_auth(struct gss_auth *gss_auth);
>  
>  static void gss_free_ctx(struct gss_cl_ctx *);
> -static const struct rpc_pipe_ops gss_upcall_ops_v0;
>  static const struct rpc_pipe_ops gss_upcall_ops_v1;
>  
>  static inline struct gss_cl_ctx *
> @@ -253,38 +242,11 @@ struct gss_upcall_msg {
>  	char databuf[UPCALL_BUF_LEN];
>  };
>  
> -static int get_pipe_version(struct net *net)
> -{
> -	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
> -	int ret;
> -
> -	spin_lock(&pipe_version_lock);
> -	if (sn->pipe_version >= 0) {
> -		atomic_inc(&sn->pipe_users);
> -		ret = sn->pipe_version;
> -	} else
> -		ret = -EAGAIN;
> -	spin_unlock(&pipe_version_lock);
> -	return ret;
> -}
> -
> -static void put_pipe_version(struct net *net)
> -{
> -	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
> -
> -	if (atomic_dec_and_lock(&sn->pipe_users, &pipe_version_lock)) {
> -		sn->pipe_version = -1;
> -		spin_unlock(&pipe_version_lock);
> -	}
> -}
> -
>  static void
>  gss_release_msg(struct gss_upcall_msg *gss_msg)
>  {
> -	struct net *net = gss_msg->auth->net;
>  	if (!refcount_dec_and_test(&gss_msg->count))
>  		return;
> -	put_pipe_version(net);
>  	BUG_ON(!list_empty(&gss_msg->list));
>  	if (gss_msg->ctx != NULL)
>  		gss_put_ctx(gss_msg->ctx);
> @@ -385,31 +347,6 @@ gss_upcall_callback(struct rpc_task *task)
>  	gss_release_msg(gss_msg);
>  }
>  
> -static void gss_encode_v0_msg(struct gss_upcall_msg *gss_msg,
> -			      const struct cred *cred)
> -{
> -	struct user_namespace *userns = cred->user_ns;
> -
> -	uid_t uid = from_kuid_munged(userns, gss_msg->uid);
> -	memcpy(gss_msg->databuf, &uid, sizeof(uid));
> -	gss_msg->msg.data = gss_msg->databuf;
> -	gss_msg->msg.len = sizeof(uid);
> -
> -	BUILD_BUG_ON(sizeof(uid) > sizeof(gss_msg->databuf));
> -}
> -
> -static ssize_t
> -gss_v0_upcall(struct file *file, struct rpc_pipe_msg *msg,
> -		char __user *buf, size_t buflen)
> -{
> -	struct gss_upcall_msg *gss_msg = container_of(msg,
> -						      struct gss_upcall_msg,
> -						      msg);
> -	if (msg->copied == 0)
> -		gss_encode_v0_msg(gss_msg, file->f_cred);
> -	return rpc_pipe_generic_upcall(file, msg, buf, buflen);
> -}
> -
>  static int gss_encode_v1_msg(struct gss_upcall_msg *gss_msg,
>  				const char *service_name,
>  				const char *target_name,
> @@ -507,17 +444,12 @@ gss_alloc_msg(struct gss_auth *gss_auth,
>  		kuid_t uid, const char *service_name)
>  {
>  	struct gss_upcall_msg *gss_msg;
> -	int vers;
>  	int err = -ENOMEM;
>  
>  	gss_msg = kzalloc(sizeof(*gss_msg), GFP_NOFS);
>  	if (gss_msg == NULL)
>  		goto err;
> -	vers = get_pipe_version(gss_auth->net);
> -	err = vers;
> -	if (err < 0)
> -		goto err_free_msg;
> -	gss_msg->pipe = gss_auth->gss_pipe[vers]->pipe;
> +	gss_msg->pipe = gss_auth->gss_pipe->pipe;
>  	INIT_LIST_HEAD(&gss_msg->list);
>  	rpc_init_wait_queue(&gss_msg->rpc_waitqueue, "RPCSEC_GSS upcall waitq");
>  	init_waitqueue_head(&gss_msg->waitqueue);
> @@ -529,12 +461,10 @@ gss_alloc_msg(struct gss_auth *gss_auth,
>  		gss_msg->service_name = kstrdup_const(service_name, GFP_NOFS);
>  		if (!gss_msg->service_name) {
>  			err = -ENOMEM;
> -			goto err_put_pipe_version;
> +			goto err_free_msg;
>  		}
>  	}
>  	return gss_msg;
> -err_put_pipe_version:
> -	put_pipe_version(gss_auth->net);
>  err_free_msg:
>  	kfree(gss_msg);
>  err:
> @@ -590,8 +520,6 @@ gss_refresh_upcall(struct rpc_task *task)
>  		/* XXX: warning on the first, under the assumption we
>  		 * shouldn't normally hit this case on a refresh. */
>  		warn_gssd();
> -		rpc_sleep_on_timeout(&pipe_version_rpc_waitqueue,
> -				task, NULL, jiffies + (15 * HZ));
>  		err = -EAGAIN;
>  		goto out;
>  	}
> @@ -624,14 +552,12 @@ static inline int
>  gss_create_upcall(struct gss_auth *gss_auth, struct gss_cred *gss_cred)
>  {
>  	struct net *net = gss_auth->net;
> -	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
>  	struct rpc_pipe *pipe;
>  	struct rpc_cred *cred = &gss_cred->gc_base;
>  	struct gss_upcall_msg *gss_msg;
>  	DEFINE_WAIT(wait);
>  	int err;
>  
> -retry:
>  	err = 0;
>  	/* if gssd is down, just skip upcalling altogether */
>  	if (!gssd_running(net)) {
> @@ -640,17 +566,6 @@ gss_create_upcall(struct gss_auth *gss_auth, struct gss_cred *gss_cred)
>  		goto out;
>  	}
>  	gss_msg = gss_setup_upcall(gss_auth, cred);
> -	if (PTR_ERR(gss_msg) == -EAGAIN) {
> -		err = wait_event_interruptible_timeout(pipe_version_waitqueue,
> -				sn->pipe_version >= 0, 15 * HZ);
> -		if (sn->pipe_version < 0) {
> -			warn_gssd();
> -			err = -EACCES;
> -		}
> -		if (err < 0)
> -			goto out;
> -		goto retry;
> -	}
>  	if (IS_ERR(gss_msg)) {
>  		err = PTR_ERR(gss_msg);
>  		goto out;
> @@ -777,44 +692,9 @@ gss_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
>  	return err;
>  }
>  
> -static int gss_pipe_open(struct inode *inode, int new_version)
> -{
> -	struct net *net = inode->i_sb->s_fs_info;
> -	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
> -	int ret = 0;
> -
> -	spin_lock(&pipe_version_lock);
> -	if (sn->pipe_version < 0) {
> -		/* First open of any gss pipe determines the version: */
> -		sn->pipe_version = new_version;
> -		rpc_wake_up(&pipe_version_rpc_waitqueue);
> -		wake_up(&pipe_version_waitqueue);
> -	} else if (sn->pipe_version != new_version) {
> -		/* Trying to open a pipe of a different version */
> -		ret = -EBUSY;
> -		goto out;
> -	}
> -	atomic_inc(&sn->pipe_users);
> -out:
> -	spin_unlock(&pipe_version_lock);
> -	return ret;
> -
> -}
> -
> -static int gss_pipe_open_v0(struct inode *inode)
> -{
> -	return gss_pipe_open(inode, 0);
> -}
> -
> -static int gss_pipe_open_v1(struct inode *inode)
> -{
> -	return gss_pipe_open(inode, 1);
> -}
> -
>  static void
>  gss_pipe_release(struct inode *inode)
>  {
> -	struct net *net = inode->i_sb->s_fs_info;
>  	struct rpc_pipe *pipe = RPC_I(inode)->pipe;
>  	struct gss_upcall_msg *gss_msg;
>  
> @@ -832,8 +712,6 @@ gss_pipe_release(struct inode *inode)
>  		goto restart;
>  	}
>  	spin_unlock(&pipe->lock);
> -
> -	put_pipe_version(net);
>  }
>  
>  static void
> @@ -1039,30 +917,14 @@ gss_create_new(const struct rpc_auth_create_args *args, struct rpc_clnt *clnt)
>  	err = rpcauth_init_credcache(auth);
>  	if (err)
>  		goto err_put_mech;
> -	/*
> -	 * Note: if we created the old pipe first, then someone who
> -	 * examined the directory at the right moment might conclude
> -	 * that we supported only the old pipe.  So we instead create
> -	 * the new pipe first.
> -	 */
>  	gss_pipe = gss_pipe_get(clnt, "gssd", &gss_upcall_ops_v1);
>  	if (IS_ERR(gss_pipe)) {
>  		err = PTR_ERR(gss_pipe);
>  		goto err_destroy_credcache;
>  	}
> -	gss_auth->gss_pipe[1] = gss_pipe;
> -
> -	gss_pipe = gss_pipe_get(clnt, gss_auth->mech->gm_name,
> -			&gss_upcall_ops_v0);
> -	if (IS_ERR(gss_pipe)) {
> -		err = PTR_ERR(gss_pipe);
> -		goto err_destroy_pipe_1;
> -	}
> -	gss_auth->gss_pipe[0] = gss_pipe;
> +	gss_auth->gss_pipe = gss_pipe;
>  
>  	return gss_auth;
> -err_destroy_pipe_1:
> -	gss_pipe_free(gss_auth->gss_pipe[1]);
>  err_destroy_credcache:
>  	rpcauth_destroy_credcache(auth);
>  err_put_mech:
> @@ -1081,8 +943,7 @@ gss_create_new(const struct rpc_auth_create_args *args, struct rpc_clnt *clnt)
>  static void
>  gss_free(struct gss_auth *gss_auth)
>  {
> -	gss_pipe_free(gss_auth->gss_pipe[0]);
> -	gss_pipe_free(gss_auth->gss_pipe[1]);
> +	gss_pipe_free(gss_auth->gss_pipe);
>  	gss_mech_put(gss_auth->mech);
>  	put_net(gss_auth->net);
>  	kfree(gss_auth->target_name);
> @@ -1117,10 +978,8 @@ gss_destroy(struct rpc_auth *auth)
>  		spin_unlock(&gss_auth_hash_lock);
>  	}
>  
> -	gss_pipe_free(gss_auth->gss_pipe[0]);
> -	gss_auth->gss_pipe[0] = NULL;
> -	gss_pipe_free(gss_auth->gss_pipe[1]);
> -	gss_auth->gss_pipe[1] = NULL;
> +	gss_pipe_free(gss_auth->gss_pipe);
> +	gss_auth->gss_pipe = NULL;
>  	rpcauth_destroy_credcache(auth);
>  
>  	gss_put_auth(gss_auth);
> @@ -2179,19 +2038,10 @@ static const struct rpc_credops gss_nullops = {
>  	.crstringify_acceptor	= gss_stringify_acceptor,
>  };
>  
> -static const struct rpc_pipe_ops gss_upcall_ops_v0 = {
> -	.upcall		= gss_v0_upcall,
> -	.downcall	= gss_pipe_downcall,
> -	.destroy_msg	= gss_pipe_destroy_msg,
> -	.open_pipe	= gss_pipe_open_v0,
> -	.release_pipe	= gss_pipe_release,
> -};
> -
>  static const struct rpc_pipe_ops gss_upcall_ops_v1 = {
>  	.upcall		= gss_v1_upcall,
>  	.downcall	= gss_pipe_downcall,
>  	.destroy_msg	= gss_pipe_destroy_msg,
> -	.open_pipe	= gss_pipe_open_v1,
>  	.release_pipe	= gss_pipe_release,
>  };
>  
> @@ -2226,7 +2076,6 @@ static int __init init_rpcsec_gss(void)
>  	err = register_pernet_subsys(&rpcsec_gss_net_ops);
>  	if (err)
>  		goto out_svc_exit;
> -	rpc_init_wait_queue(&pipe_version_rpc_waitqueue, "gss pipe version");
>  	return 0;
>  out_svc_exit:
>  	gss_svc_shutdown();
> diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
> index 3ecc194c21ef..633a66bc5df9 100644
> --- a/net/sunrpc/rpc_pipe.c
> +++ b/net/sunrpc/rpc_pipe.c
> @@ -213,19 +213,12 @@ static int
>  rpc_pipe_open(struct inode *inode, struct file *filp)
>  {
>  	struct rpc_pipe *pipe;
> -	int first_open;
>  	int res = -ENXIO;
>  
>  	inode_lock(inode);
>  	pipe = RPC_I(inode)->pipe;
>  	if (pipe == NULL)
>  		goto out;
> -	first_open = pipe->nreaders == 0 && pipe->nwriters == 0;
> -	if (first_open && pipe->ops->open_pipe) {
> -		res = pipe->ops->open_pipe(inode);
> -		if (res)
> -			goto out;
> -	}
>  	if (filp->f_mode & FMODE_READ)
>  		pipe->nreaders++;
>  	if (filp->f_mode & FMODE_WRITE)
> -- 
> 2.33.1
