Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA32041B7AE
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Sep 2021 21:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242418AbhI1Tjg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Sep 2021 15:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242394AbhI1Tjg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Sep 2021 15:39:36 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5006C06161C
        for <linux-nfs@vger.kernel.org>; Tue, 28 Sep 2021 12:37:56 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 267961C81; Tue, 28 Sep 2021 15:37:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 267961C81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632857876;
        bh=ePjlpEa8Bu0T/OvFcWBKNjP2Zf9R4VqxfES3FE//Yuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xosb0fhXbp2SAVaXDluYbn03gcE5WHxjVV9QRhasSfApXQe9JxQtG63vWqN8ggEka
         DtXRvjcVJi77xYzL3wSo9Yfrqgk/0SutC44e2O5q+nue8aZFIrrF8niUCGw6l8JIJj
         fwr3mFoni2QIa7otJAZ2ddeHtoAB3410movg9qxA=
Date:   Tue, 28 Sep 2021 15:37:56 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] gss: remove legacy gssd upcall pipe
Message-ID: <20210928193756.GG25415@fieldses.org>
References: <20210928193442.GF25415@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928193442.GF25415@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Just an odd todo I keep forgetting:

On Tue, Sep 28, 2021 at 03:34:42PM -0400, bfields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> This code exists only for compatibility with nfs-utils before
> 0cfdc66de043 "gssd: handle new client upcall" (which first appeared in
> nfs-utils version 1.2.2, in 2019).  After 12 years, maybe it's time to
> drop that compatibility code.

There's probably more that could go too.  It wasn't immediately obvious
to me whether the code that waits for an open at the start of
gss_{refresh,create}_upcall is still useful.

--b.

> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  net/sunrpc/auth_gss/auth_gss.c | 102 ++++-----------------------------
>  1 file changed, 12 insertions(+), 90 deletions(-)
> 
> diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
> index 5f42aa5fc612..8929178410e7 100644
> --- a/net/sunrpc/auth_gss/auth_gss.c
> +++ b/net/sunrpc/auth_gss/auth_gss.c
> @@ -73,13 +73,7 @@ struct gss_auth {
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
> @@ -90,7 +84,6 @@ static DECLARE_WAIT_QUEUE_HEAD(pipe_version_waitqueue);
>  static void gss_put_auth(struct gss_auth *gss_auth);
>  
>  static void gss_free_ctx(struct gss_cl_ctx *);
> -static const struct rpc_pipe_ops gss_upcall_ops_v0;
>  static const struct rpc_pipe_ops gss_upcall_ops_v1;
>  
>  static inline struct gss_cl_ctx *
> @@ -261,7 +254,7 @@ static int get_pipe_version(struct net *net)
>  	spin_lock(&pipe_version_lock);
>  	if (sn->pipe_version >= 0) {
>  		atomic_inc(&sn->pipe_users);
> -		ret = sn->pipe_version;
> +		ret = 0;
>  	} else
>  		ret = -EAGAIN;
>  	spin_unlock(&pipe_version_lock);
> @@ -385,31 +378,6 @@ gss_upcall_callback(struct rpc_task *task)
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
> @@ -507,17 +475,15 @@ gss_alloc_msg(struct gss_auth *gss_auth,
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
> +	err = get_pipe_version(gss_auth->net);
>  	if (err < 0)
>  		goto err_free_msg;
> -	gss_msg->pipe = gss_auth->gss_pipe[vers]->pipe;
> +	gss_msg->pipe = gss_auth->gss_pipe->pipe;
>  	INIT_LIST_HEAD(&gss_msg->list);
>  	rpc_init_wait_queue(&gss_msg->rpc_waitqueue, "RPCSEC_GSS upcall waitq");
>  	init_waitqueue_head(&gss_msg->waitqueue);
> @@ -777,38 +743,21 @@ gss_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
>  	return err;
>  }
>  
> -static int gss_pipe_open(struct inode *inode, int new_version)
> +static int gss_pipe_open(struct inode *inode)
>  {
>  	struct net *net = inode->i_sb->s_fs_info;
>  	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
> -	int ret = 0;
>  
>  	spin_lock(&pipe_version_lock);
>  	if (sn->pipe_version < 0) {
> -		/* First open of any gss pipe determines the version: */
> -		sn->pipe_version = new_version;
> +		sn->pipe_version = 1;
>  		rpc_wake_up(&pipe_version_rpc_waitqueue);
>  		wake_up(&pipe_version_waitqueue);
> -	} else if (sn->pipe_version != new_version) {
> -		/* Trying to open a pipe of a different version */
> -		ret = -EBUSY;
> -		goto out;
>  	}
>  	atomic_inc(&sn->pipe_users);
> -out:
>  	spin_unlock(&pipe_version_lock);
> -	return ret;
> -
> -}
> -
> -static int gss_pipe_open_v0(struct inode *inode)
> -{
> -	return gss_pipe_open(inode, 0);
> -}
> +	return 0;
>  
> -static int gss_pipe_open_v1(struct inode *inode)
> -{
> -	return gss_pipe_open(inode, 1);
>  }
>  
>  static void
> @@ -1039,30 +988,14 @@ gss_create_new(const struct rpc_auth_create_args *args, struct rpc_clnt *clnt)
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
> @@ -1081,8 +1014,7 @@ gss_create_new(const struct rpc_auth_create_args *args, struct rpc_clnt *clnt)
>  static void
>  gss_free(struct gss_auth *gss_auth)
>  {
> -	gss_pipe_free(gss_auth->gss_pipe[0]);
> -	gss_pipe_free(gss_auth->gss_pipe[1]);
> +	gss_pipe_free(gss_auth->gss_pipe);
>  	gss_mech_put(gss_auth->mech);
>  	put_net(gss_auth->net);
>  	kfree(gss_auth->target_name);
> @@ -1117,10 +1049,8 @@ gss_destroy(struct rpc_auth *auth)
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
> @@ -2179,19 +2109,11 @@ static const struct rpc_credops gss_nullops = {
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
> +	.open_pipe	= gss_pipe_open,
>  	.release_pipe	= gss_pipe_release,
>  };
>  
> -- 
> 2.31.1
> 
