Return-Path: <linux-nfs+bounces-6031-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B94A9655DC
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 05:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A95283753
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 03:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECBA13BAF1;
	Fri, 30 Aug 2024 03:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLQiAvjR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3974313B297
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 03:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724989619; cv=none; b=osEIKGuhsZdOyvzzTZFg69+bdhBT+mH8/dmSirPH1dACimh0jbFq8WxQZ6gEwwDenSmXYkw3ig4kkDQ2CcFoQKhlZyZ+Sg4xiPG3LU+zI/kSHjgxwdMvkqPbrc1ku6rCQKAW9suhbjFbn/ZdmepU7/otJjA3X45fbSSUWLlSAKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724989619; c=relaxed/simple;
	bh=qcKsBi7x71yDp4mwGT1AftDEjxv9IsqU9W/COfaG+m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBbUkFjoWGGg9vjrFzF+ZeAOQ7+Qfe6gam4DpsH7LBmwVPDudlx+Y0TZbtRH6nTDemALuOXGe95d9KR/2q7uWA3uXuzHrfNOaPG/TvQclWAuWoXXey3FFCe3QBxv5xGyCrbzMJKrIW+ZuoBhwSx3MFTGA108VLSMvktnqvuV/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLQiAvjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84747C4CEC4;
	Fri, 30 Aug 2024 03:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724989618;
	bh=qcKsBi7x71yDp4mwGT1AftDEjxv9IsqU9W/COfaG+m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iLQiAvjRVwKbm8LrQpvnOckNxtRQUdZgbS14XluzKQXm/Lj7nppJfCPmSBzPN/rtY
	 ++4vUoZfAlwlmhlfzuBbMNZ/iJYNGVi2cTs4iq+nay5hvau6AJyXcNyv6LEd8yOp1p
	 emM3p3K3nSVuqo5d0OROHkl08HvTVylrw9rKDDVGsuZ5Or3umQ6uITI9r5N2xgfx8K
	 prx+Pa8Q9Z0QdSMzVJq+xck24+UK5kt1kDhBRdJoXTNZ4rThTH9Wc+S7d0FgqfIJAs
	 9m2JdC4XouHrcIW4ypy/QQD/PlMNqAo38wrSrSZzkvjMbfen/Za3U07GwR5+kIUtUt
	 BJY/smvusFaAQ==
Date: Thu, 29 Aug 2024 23:46:57 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v14-plus 00/25] Address netns refcount issues for localio
Message-ID: <ZtFAsaKRujMZo4NU@kernel.org>
References: <20240830023531.29421-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830023531.29421-1-neilb@suse.de>

On Fri, Aug 30, 2024 at 12:20:13PM +1000, NeilBrown wrote:
> Following are revised versions of 6 patches from the v14 localio series.
> 
> The issue addressed is net namespace refcounting.
> 
> We don't want to keep a long-term counted reference in the client
> because that prevents a server container from completely shutting down.
> 
> So we avoid taking a reference at all and rely on the per-cpu reference
> to the server being sufficient to keep the net-ns active.  This involves
> allowing the net-ns exit code to iterate all active clients and clear
> their ->net pointers (which they need to find the per-cpu-refcount for
> the nfs_serv).
> 
> So:
>  - embed nfs_uuid_t in nfs_client.  This provides a list_head that can
>    be used to find the client.  It does add the actual uuid to nfs_client
>    so it is bigger than needed.  If that is really a problem we can find
>    a fix.
> 
>  - When the nfs server confirms that the uuid is local, it moves the
>    nfs_uuid_t onto a per-net-ns list.
> 
>  - When the net-ns is shutting down - in a "pre_exit" handler, all these
>    nfS_uuid_t have their ->net cleared.  There is an rcu_synchronize()
>    call between pre_exit() handlers and exit() handlers so and caller
>    that sees ->net as not NULL can safely check the ->counter
> 
>  - We now pass the nfs_uuid_t to nfsd_open_local_fh() so it can safely
>    look at ->net in a private rcu_read_lock() section.
> 
> I have compile tested this code but nothing more.

Wow, nicely done.  I will go over it in much more detail and test.

For the benefit of others, here is a single incremental diff relative
to v14:

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 6a4b605cc943..4903f5ff5758 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -181,8 +181,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	seqlock_init(&clp->cl_boot_lock);
 	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
-	clp->cl_nfssvc_net = NULL;
-	clp->cl_nfssvc_dom = NULL;
+	clp->cl_uuid.net = NULL;
 	spin_lock_init(&clp->cl_localio_lock);
 #endif /* CONFIG_NFS_LOCALIO */
 
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 40521da422f7..55622084d5c2 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -120,15 +120,13 @@ const struct rpc_program nfslocalio_program = {
 /*
  * nfs_local_enable - enable local i/o for an nfs_client
  */
-static void nfs_local_enable(struct nfs_client *clp, nfs_uuid_t *nfs_uuid)
+static void nfs_local_enable(struct nfs_client *clp)
 {
 	spin_lock(&clp->cl_localio_lock);
 
 	if (unlikely(!get_nfs_to_nfsd_symbols()))
 		goto out;
 	set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
-	rcu_assign_pointer(clp->cl_nfssvc_net, nfs_uuid->net);
-	rcu_assign_pointer(clp->cl_nfssvc_dom, nfs_uuid->dom);
 	trace_nfs_local_enable(clp);
 out:
 	spin_unlock(&clp->cl_localio_lock);
@@ -139,25 +137,12 @@ static void nfs_local_enable(struct nfs_client *clp, nfs_uuid_t *nfs_uuid)
  */
 void nfs_local_disable(struct nfs_client *clp)
 {
-	struct net *cl_nfssvc_net;
-	struct auth_domain *cl_nfssvc_dom;
-
 	spin_lock(&clp->cl_localio_lock);
 	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
 		trace_nfs_local_disable(clp);
 		put_nfs_to_nfsd_symbols();
 
-		cl_nfssvc_net = rcu_dereference(clp->cl_nfssvc_net);
-		if (cl_nfssvc_net) {
-			put_net(cl_nfssvc_net);
-			RCU_INIT_POINTER(clp->cl_nfssvc_net, NULL);
-		}
-
-		cl_nfssvc_dom = rcu_dereference(clp->cl_nfssvc_dom);
-		if (cl_nfssvc_dom) {
-			auth_domain_put(cl_nfssvc_dom);
-			RCU_INIT_POINTER(clp->cl_nfssvc_dom, NULL);
-		}
+		nfs_uuid_invalidate_one_client(&clp->cl_uuid);
 	}
 	spin_unlock(&clp->cl_localio_lock);
 }
@@ -179,8 +164,7 @@ static struct rpc_clnt *nfs_init_localioclient(struct nfs_client *clp)
 	return rpcclient_localio;
 }
 
-static bool nfs_server_uuid_is_local(struct nfs_client *clp,
-				     nfs_uuid_t *nfs_uuid)
+static bool nfs_server_uuid_is_local(struct nfs_client *clp)
 {
 	u8 uuid[UUID_SIZE];
 	struct rpc_message msg = {
@@ -193,7 +177,7 @@ static bool nfs_server_uuid_is_local(struct nfs_client *clp,
 	if (IS_ERR(rpcclient_localio))
 		return false;
 
-	export_uuid(uuid, &nfs_uuid->uuid);
+	export_uuid(uuid, &clp->cl_uuid.uuid);
 
 	msg.rpc_proc = &nfs_localio_procedures[LOCALIOPROC_UUID_IS_LOCAL];
 	status = rpc_call_sync(rpcclient_localio, &msg, 0);
@@ -202,7 +186,7 @@ static bool nfs_server_uuid_is_local(struct nfs_client *clp,
 	rpc_shutdown_client(rpcclient_localio);
 
 	/* Server is only local if it initialized required struct members */
-	if (status || !nfs_uuid->net || !nfs_uuid->dom)
+	if (status || !clp->cl_uuid.net || !clp->cl_uuid.dom)
 		return false;
 
 	return true;
@@ -215,8 +199,6 @@ static bool nfs_server_uuid_is_local(struct nfs_client *clp,
  */
 void nfs_local_probe(struct nfs_client *clp)
 {
-	nfs_uuid_t nfs_uuid;
-
 	/* Disallow localio if disabled via sysfs or AUTH_SYS isn't used */
 	if (!localio_enabled ||
 	    clp->cl_rpcclient->cl_auth->au_flavor != RPC_AUTH_UNIX) {
@@ -229,10 +211,10 @@ void nfs_local_probe(struct nfs_client *clp)
 		nfs_local_disable(clp);
 	}
 
-	nfs_uuid_begin(&nfs_uuid);
-	if (nfs_server_uuid_is_local(clp, &nfs_uuid))
-		nfs_local_enable(clp, &nfs_uuid);
-	nfs_uuid_end(&nfs_uuid);
+	nfs_uuid_begin(&clp->cl_uuid);
+	if (nfs_server_uuid_is_local(clp))
+		nfs_local_enable(clp);
+	nfs_uuid_end(&clp->cl_uuid);
 }
 EXPORT_SYMBOL_GPL(nfs_local_probe);
 
@@ -245,8 +227,6 @@ struct nfs_localio_ctx *
 nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		  struct nfs_fh *fh, const fmode_t mode)
 {
-	struct net *cl_nfssvc_net;
-	struct auth_domain *cl_nfssvc_dom;
 	struct nfs_localio_ctx *localio;
 	int status;
 
@@ -255,15 +235,8 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 	if (mode & ~(FMODE_READ | FMODE_WRITE))
 		return NULL;
 
-	rcu_read_lock();
-	cl_nfssvc_net = rcu_dereference(clp->cl_nfssvc_net);
-	cl_nfssvc_dom = rcu_dereference(clp->cl_nfssvc_dom);
-	if (unlikely(!cl_nfssvc_net || !cl_nfssvc_dom))
-		localio = ERR_PTR(-ENXIO);
-	else
-		localio = nfs_to.nfsd_open_local_fh(cl_nfssvc_net, cl_nfssvc_dom,
-						    clp->cl_rpcclient, cred, fh, mode);
-	rcu_read_unlock();
+	localio = nfs_to.nfsd_open_local_fh(&clp->cl_uuid,
+					    clp->cl_rpcclient, cred, fh, mode);
 	if (IS_ERR(localio)) {
 		status = PTR_ERR(localio);
 		trace_nfs_local_open_fh(fh, mode, status);
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index cc30fdb0cb46..8545ee75f756 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -11,11 +11,11 @@
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("NFS localio protocol bypass support");
 
-DEFINE_MUTEX(nfs_uuid_mutex);
+static DEFINE_SPINLOCK(nfs_uuid_lock);
 
 /*
  * Global list of nfs_uuid_t instances, add/remove
- * is protected by nfs_uuid_mutex.
+ * is protected by nfs_uuid_lock.
  * Reads are protected by RCU read lock (see below).
  */
 LIST_HEAD(nfs_uuids);
@@ -26,17 +26,19 @@ void nfs_uuid_begin(nfs_uuid_t *nfs_uuid)
 	nfs_uuid->dom = NULL;
 	uuid_gen(&nfs_uuid->uuid);
 
-	mutex_lock(&nfs_uuid_mutex);
+	spin_lock(&nfs_uuid_lock);
 	list_add_tail_rcu(&nfs_uuid->list, &nfs_uuids);
-	mutex_unlock(&nfs_uuid_mutex);
+	spin_unlock(&nfs_uuid_lock);
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_begin);
 
 void nfs_uuid_end(nfs_uuid_t *nfs_uuid)
 {
-	mutex_lock(&nfs_uuid_mutex);
-	list_del_rcu(&nfs_uuid->list);
-	mutex_unlock(&nfs_uuid_mutex);
+	if (nfs_uuid->net == NULL) {
+		spin_lock(&nfs_uuid_lock);
+		list_del_init(&nfs_uuid->list);
+		spin_unlock(&nfs_uuid_lock);
+	}
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_end);
 
@@ -45,34 +47,66 @@ static nfs_uuid_t * nfs_uuid_lookup(const uuid_t *uuid)
 {
 	nfs_uuid_t *nfs_uuid;
 
-	list_for_each_entry_rcu(nfs_uuid, &nfs_uuids, list)
+	list_for_each_entry(nfs_uuid, &nfs_uuids, list)
 		if (uuid_equal(&nfs_uuid->uuid, uuid))
 			return nfs_uuid;
 
 	return NULL;
 }
 
-bool nfs_uuid_is_local(const uuid_t *uuid, struct net *net, struct auth_domain *dom)
+void nfs_uuid_is_local(const uuid_t *uuid, struct list_head *list,
+		       struct net *net, struct auth_domain *dom)
 {
-	bool is_local = false;
 	nfs_uuid_t *nfs_uuid;
 
-	rcu_read_lock();
+	spin_lock(&nfs_uuid_lock);
 	nfs_uuid = nfs_uuid_lookup(uuid);
 	if (nfs_uuid) {
-		nfs_uuid->net = maybe_get_net(net);
-		if (nfs_uuid->net) {
-			is_local = true;
-			kref_get(&dom->ref);
-			nfs_uuid->dom = dom;
-		}
+		kref_get(&dom->ref);
+		nfs_uuid->dom = dom;
+		/* We don't hold a ref on the net, but instead put
+		 * ourselves on a list so the net pointer can be
+		 * invalidated.
+		 */
+		list_move(&nfs_uuid->list, list);
+		nfs_uuid->net = net;
 	}
-	rcu_read_unlock();
-
-	return is_local;
+	spin_unlock(&nfs_uuid_lock);
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
 
+static void nfs_uuid_put_locked(nfs_uuid_t *nfs_uuid)
+{
+	if (nfs_uuid->net)
+		put_net(nfs_uuid->net);
+	nfs_uuid->net = NULL;
+	if (nfs_uuid->dom)
+		auth_domain_put(nfs_uuid->dom);
+	nfs_uuid->dom = NULL;
+	list_del_init(&nfs_uuid->list);
+}
+
+void nfs_uuid_invalidate_clients(struct list_head *list)
+{
+	nfs_uuid_t *nfs_uuid, *tmp;
+
+	spin_lock(&nfs_uuid_lock);
+	list_for_each_entry_safe(nfs_uuid, tmp, list, list)
+		nfs_uuid_put_locked(nfs_uuid);
+	spin_unlock(&nfs_uuid_lock);
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_clients);
+
+void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid)
+{
+	if (nfs_uuid->net) {
+		spin_lock(&nfs_uuid_lock);
+		nfs_uuid_put_locked(nfs_uuid);
+		spin_unlock(&nfs_uuid_lock);
+	}
+}
+EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_one_client);
+
 /*
  * The nfs localio code needs to call into nfsd using various symbols (below),
  * but cannot be statically linked, because that will make the nfs module
@@ -100,7 +134,7 @@ static void put_##NFSD_SYMBOL(void)			\
 
 /* The nfs localio code needs to call into nfsd to map filehandle -> struct nfsd_file */
 extern struct nfs_localio_ctx *
-nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_clnt *,
+nfsd_open_local_fh(nfs_uuid_t *, struct rpc_clnt *,
 		   const struct cred *, const struct nfs_fh *, const fmode_t);
 DEFINE_NFS_TO_NFSD_SYMBOL(nfsd_open_local_fh);
 
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index a192bbe308df..491bf5017d34 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -42,13 +42,14 @@
  * nfsd_serv_put (via nfs_localio_ctx_free).
  */
 struct nfs_localio_ctx *
-nfsd_open_local_fh(struct net *cl_nfssvc_net, struct auth_domain *cl_nfssvc_dom,
+nfsd_open_local_fh(nfs_uuid_t *uuid,
 		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
 		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
 {
 	int mayflags = NFSD_MAY_LOCALIO;
 	int status = 0;
-	struct nfsd_net *nn;
+	struct nfsd_net *nn = NULL;
+	struct net *net;
 	struct svc_cred rq_cred;
 	struct svc_fh fh;
 	struct nfs_localio_ctx *localio;
@@ -64,12 +65,20 @@ nfsd_open_local_fh(struct net *cl_nfssvc_net, struct auth_domain *cl_nfssvc_dom,
 	/*
 	 * Not running in nfsd context, so must safely get reference on nfsd_serv.
 	 * But the server may already be shutting down, if so disallow new localio.
+	 * uuid->net is NOT a counted reference, but rcu_read_lock() ensures that if
+	 * uuid->net is not NULL, then nfsd_serv_try_get() is safe and if that succeeds
+	 * we will have an implied reference to the net.
 	 */
-	nn = net_generic(cl_nfssvc_net, nfsd_net_id);
-	if (unlikely(!nfsd_serv_try_get(nn))) {
+	rcu_read_lock();
+	net = READ_ONCE(uuid->net);
+	if (net)
+		nn = net_generic(net, nfsd_net_id);
+	if (unlikely(!nn || !nfsd_serv_try_get(nn))) {
+		rcu_read_unlock();
 		status = -ENXIO;
 		goto out_nfsd_serv;
 	}
+	rcu_read_unlock();
 
 	/* nfs_fh -> svc_fh */
 	fh_init(&fh, NFS4_FHSIZE);
@@ -83,7 +92,7 @@ nfsd_open_local_fh(struct net *cl_nfssvc_net, struct auth_domain *cl_nfssvc_dom,
 
 	svcauth_map_clnt_to_svc_cred_local(rpc_clnt, cred, &rq_cred);
 
-	beres = nfsd_file_acquire_local(cl_nfssvc_net, &rq_cred, cl_nfssvc_dom,
+	beres = nfsd_file_acquire_local(uuid->net, &rq_cred, uuid->dom,
 					&fh, mayflags, &localio->nf);
 	if (beres) {
 		status = nfs_stat_to_errno(be32_to_cpu(beres));
@@ -123,9 +132,11 @@ struct localio_uuidarg {
 static __be32 localio_proc_uuid_is_local(struct svc_rqst *rqstp)
 {
 	struct localio_uuidarg *argp = rqstp->rq_argp;
+	struct net *net = SVC_NET(rqstp);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	(void) nfs_uuid_is_local(&argp->uuid, SVC_NET(rqstp),
-				 rqstp->rq_client);
+	nfs_uuid_is_local(&argp->uuid, &nn->local_clients,
+			  net, rqstp->rq_client);
 
 	return rpc_success;
 }
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index e2d953f21dde..9c65db8d3f44 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -216,6 +216,8 @@ struct nfsd_net {
 	/* last time an admin-revoke happened for NFSv4.0 */
 	time64_t		nfs40_last_revoke;
 
+	/* Local clients to be invalidated when net is shut down */
+	struct list_head	local_clients;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 64c1b4d649bc..01e383d692ab 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -18,6 +18,7 @@
 #include <linux/sunrpc/svc.h>
 #include <linux/module.h>
 #include <linux/fsnotify.h>
+#include <linux/nfslocalio.h>
 
 #include "idmap.h"
 #include "nfsd.h"
@@ -2257,6 +2258,7 @@ static __net_init int nfsd_net_init(struct net *net)
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
 	nfsd_proc_stat_init(net);
+	INIT_LIST_HEAD(&nn->local_clients);
 
 	return 0;
 
@@ -2268,6 +2270,19 @@ static __net_init int nfsd_net_init(struct net *net)
 	return retval;
 }
 
+/**
+ * nfsd_net_pre_exit - Disconnect localio clients from net namespace
+ * @net: a network namespace that is about to be destroyed
+ *
+ * This invalidated ->net pointers held by localio clients
+ * while they can still safely access nn->counter.
+ */
+static __net_exit void nfsd_net_pre_exit(struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	nfs_uuid_invalidate_clients(&nn->local_clients);
+}
 /**
  * nfsd_net_exit - Release the nfsd_net portion of a net namespace
  * @net: a network namespace that is about to be destroyed
@@ -2285,6 +2300,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
 
 static struct pernet_operations nfsd_net_ops = {
 	.init = nfsd_net_init,
+	.pre_exit = nfsd_net_pre_exit,
 	.exit = nfsd_net_exit,
 	.id   = &nfsd_net_id,
 	.size = sizeof(struct nfsd_net),
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index e12310dd5f4c..2ecceb8b9d3d 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -8,6 +8,7 @@
 
 #include <linux/fs.h>
 #include <linux/posix_acl.h>
+#include <linux/nfslocalio.h>
 #include "nfsfh.h"
 #include "nfsd.h"
 
@@ -161,7 +162,7 @@ __be32		nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 void		nfsd_filp_close(struct file *fp);
 
 struct nfs_localio_ctx *
-nfsd_open_local_fh(struct net *, struct auth_domain *,
+nfsd_open_local_fh(nfs_uuid_t *,
 		   struct rpc_clnt *, const struct cred *,
 		   const struct nfs_fh *, const fmode_t);
 
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index fc7982fc218c..b43e3e067e44 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -131,8 +131,7 @@ struct nfs_client {
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	struct timespec64	cl_nfssvc_boot;
 	seqlock_t		cl_boot_lock;
-	struct net __rcu *	cl_nfssvc_net;
-	struct auth_domain __rcu * cl_nfssvc_dom;
+	nfs_uuid_t		cl_uuid;
 	spinlock_t		cl_localio_lock;
 #endif /* CONFIG_NFS_LOCALIO */
 };
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 68f5b39f1940..e196f716a2f5 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -28,7 +28,10 @@ typedef struct {
 
 void nfs_uuid_begin(nfs_uuid_t *);
 void nfs_uuid_end(nfs_uuid_t *);
-bool nfs_uuid_is_local(const uuid_t *, struct net *, struct auth_domain *);
+void nfs_uuid_is_local(const uuid_t *, struct list_head *,
+		       struct net *, struct auth_domain *);
+void nfs_uuid_invalidate_clients(struct list_head *list);
+void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid);
 
 struct nfsd_file;
 struct nfsd_net;
@@ -39,7 +42,7 @@ struct nfs_localio_ctx {
 };
 
 typedef struct nfs_localio_ctx *
-(*nfs_to_nfsd_open_local_fh_t)(struct net *, struct auth_domain *,
+(*nfs_to_nfsd_open_local_fh_t)(nfs_uuid_t *,
 			       struct rpc_clnt *, const struct cred *,
 			       const struct nfs_fh *, const fmode_t);
 typedef struct nfsd_file * (*nfs_to_nfsd_file_get_t)(struct nfsd_file *);

