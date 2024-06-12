Return-Path: <linux-nfs+bounces-3686-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E199904AAA
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 07:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E89281F17
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 05:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415633770D;
	Wed, 12 Jun 2024 05:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oYXUBQqB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9HJhdkx4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oYXUBQqB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9HJhdkx4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC9A374EA
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 05:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718169129; cv=none; b=Lh2I/PGP/te3jgXrzXd0VVIC2DScBlgCRBMivrWxFu03IQlkk+BpylQcP8+g+AjKC5cAsersI3L2Tp/F/8cMZY2eKBFBdvZ6ybfR/0mBiYyLiUfzYjtl6IIFpC13AbeorkjAvor7jQ+LH3VRJoQEqigDPN8OLzkA5XLq1lEjEj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718169129; c=relaxed/simple;
	bh=zNOgYFxKOL8jSooSlAcTlpkP6NhgpqsdS9d5+Ryg4KM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qKD8LU+bvS4csz9CAjHShoRj9tL7uy5F6sdRW/SbudrBVRe4ug7kedmHMH9aTB6wpZXclFSD1/5JlqDdhGY25TzhqCLZMggGTpYE07kU9Hhv1k/D/kjLcu3/ufhKuuOxxooebEZFpB6cNJNrtZlznTZfTz5jNktWwR23cQd1h9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oYXUBQqB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9HJhdkx4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oYXUBQqB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9HJhdkx4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 36E5D33EC3;
	Wed, 12 Jun 2024 05:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718169126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZAY8390AnHXU2ZCc6Q+AkTjRxoYhvMGf/9Z3viqERE=;
	b=oYXUBQqB/hWjDNN5u6lcZWm9VtAcDaTD1NtRKZZBeH8/Ac0IlWd5YaQ6xPi9VNnZX2SbSx
	URAFxCPaPYXVwffpbeXR8Zaxq+2ou93Z6cQGbFnPObwRzYiyQir5lbXMYrTXx4q71BjS0z
	Pm7E1IDqc2mOJ9GYoyFiD7HKteR8nAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718169126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZAY8390AnHXU2ZCc6Q+AkTjRxoYhvMGf/9Z3viqERE=;
	b=9HJhdkx4NWFQfM7S+RE1SOJ93qehyxxtrlmcOPrfOQPbvjuHWPe+E7kowUsak46fTcdBeD
	8noP4WAxVOPEG7Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718169126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZAY8390AnHXU2ZCc6Q+AkTjRxoYhvMGf/9Z3viqERE=;
	b=oYXUBQqB/hWjDNN5u6lcZWm9VtAcDaTD1NtRKZZBeH8/Ac0IlWd5YaQ6xPi9VNnZX2SbSx
	URAFxCPaPYXVwffpbeXR8Zaxq+2ou93Z6cQGbFnPObwRzYiyQir5lbXMYrTXx4q71BjS0z
	Pm7E1IDqc2mOJ9GYoyFiD7HKteR8nAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718169126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZAY8390AnHXU2ZCc6Q+AkTjRxoYhvMGf/9Z3viqERE=;
	b=9HJhdkx4NWFQfM7S+RE1SOJ93qehyxxtrlmcOPrfOQPbvjuHWPe+E7kowUsak46fTcdBeD
	8noP4WAxVOPEG7Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86445137DF;
	Wed, 12 Jun 2024 05:12:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CLeqCiMuaWY8KAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Jun 2024 05:12:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [RFC PATCH v2 15/15] nfs/nfsd: ensure localio server always uses
 its network namespace
In-reply-to: <20240612030752.31754-16-snitzer@kernel.org>
References: <20240612030752.31754-1-snitzer@kernel.org>,
 <20240612030752.31754-16-snitzer@kernel.org>
Date: Wed, 12 Jun 2024 15:11:59 +1000
Message-id: <171816911947.14261.1594458914894199821@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Wed, 12 Jun 2024, Mike Snitzer wrote:
> Pass the stored cl_nfssvc_net from the client to the server as first
> argument to nfsd_open_local_fh() to ensure the proper network
> namespace is used for localio.
>=20
> Otherwise, before this commit, the nfs_client's network namespace was
> used (as extracted from the client's cl_rpcclient). This is clearly
> not going to allow proper functionality if the client and server
> happen to have disjoint network namespaces.
>=20
> Elected to not rename the nfsd_uuid_t structure despite it growing a
> non-uuid member. Can revisit later.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/client.c            |  1 +
>  fs/nfs/localio.c           |  7 +++++--
>  fs/nfs_common/nfslocalio.c | 15 +++++++++------
>  fs/nfsd/localio.c          |  9 +++++----
>  fs/nfsd/nfssvc.c           |  1 +
>  fs/nfsd/vfs.h              |  3 ++-
>  include/linux/nfs_fs_sb.h  |  1 +
>  include/linux/nfslocalio.h | 10 ++++++----
>  8 files changed, 30 insertions(+), 17 deletions(-)
>=20
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 00044d7eda48..4ca2245c8e2c 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -171,6 +171,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_cl=
ient_initdata *cl_init)
> =20
>  	INIT_LIST_HEAD(&clp->cl_superblocks);
>  	clp->cl_rpcclient =3D clp->cl_rpcclient_localio =3D ERR_PTR(-EINVAL);
> +	clp->cl_nfssvc_net =3D NULL;
>  	clp->nfsd_open_local_fh =3D NULL;
> =20
>  	clp->cl_flags =3D cl_init->init_flags;
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index bd81b0afdbda..2d3ed9953ae2 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -189,6 +189,7 @@ static bool nfs_local_server_getuuid(struct nfs_client =
*clp, uuid_t *nfsd_uuid)
>  void nfs_local_probe(struct nfs_client *clp)
>  {
>  	uuid_t uuid;
> +	struct net *net =3D NULL;
> =20
>  	if (!localio_enabled)
>  		return;
> @@ -204,8 +205,9 @@ void nfs_local_probe(struct nfs_client *clp)
>  		if (!nfs_local_server_getuuid(clp, &uuid))
>  			return;
>  		/* Verify client's nfsd, with specififed uuid, is local */
> -		if (!nfsd_uuid_is_local(&uuid))
> +		if (!nfsd_uuid_is_local(&uuid, &net))
>  			return;
> +		clp->cl_nfssvc_net =3D net;
>  		break;
>  	default:
>  		return; /* localio not supported */
> @@ -231,7 +233,8 @@ nfs_local_open_fh(struct nfs_client *clp, const struct =
cred *cred,
>  	if (mode & ~(FMODE_READ | FMODE_WRITE))
>  		return ERR_PTR(-EINVAL);
> =20
> -	status =3D clp->nfsd_open_local_fh(clp->cl_rpcclient, cred, fh, mode, &fi=
lp);
> +	status =3D clp->nfsd_open_local_fh(clp->cl_nfssvc_net, clp->cl_rpcclient,
> +					cred, fh, mode, &filp);
>  	if (status < 0) {
>  		dprintk("%s: open local file failed error=3D%d\n",
>  				__func__, status);
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index c454c4100976..086e09b3ec38 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -12,29 +12,32 @@ MODULE_LICENSE("GPL");
>  /*
>   * Global list of nfsd_uuid_t instances, add/remove
>   * is protected by fs/nfsd/nfssvc.c:nfsd_mutex.
> - * Reads are protected RCU read lock (see below).
> + * Reads are protected by RCU read lock (see below).
>   */
>  LIST_HEAD(nfsd_uuids);
>  EXPORT_SYMBOL(nfsd_uuids);
> =20
>  /* Must be called with RCU read lock held. */
> -static const uuid_t * nfsd_uuid_lookup(const uuid_t *uuid)
> +static const uuid_t * nfsd_uuid_lookup(const uuid_t *uuid,
> +				struct net **netp)
>  {
>  	nfsd_uuid_t *nfsd_uuid;
> =20
>  	list_for_each_entry_rcu(nfsd_uuid, &nfsd_uuids, list)
> -		if (uuid_equal(&nfsd_uuid->uuid, uuid))
> +		if (uuid_equal(&nfsd_uuid->uuid, uuid)) {
> +			*netp =3D nfsd_uuid->net;
>  			return &nfsd_uuid->uuid;
> +		}

You probably need a get_net() call here to be sure the netns doesn't
disappear on you.  And a matching put_net() somewhere.

But if the server you were talking to were in some container, that might
stop you from shutting down and restarting that container.

I think it would be better to do the "fh + server uuid -> struct file *"
lookup on each request and if that is too slow, make it faster with some
caching and some rhashtable or whatever.  i.e.  don't hold a reference
to anything in the server.  The longest ref you can hold is to the
struct file, and that only until the IO completes.

NeilBrown


> =20
>  	return &uuid_null;
>  }
> =20
> -bool nfsd_uuid_is_local(const uuid_t *uuid)
> +bool nfsd_uuid_is_local(const uuid_t *uuid, struct net **netp)
>  {
>  	const uuid_t *nfsd_uuid;
> =20
>  	rcu_read_lock();
> -	nfsd_uuid =3D nfsd_uuid_lookup(uuid);
> +	nfsd_uuid =3D nfsd_uuid_lookup(uuid, netp);
>  	rcu_read_unlock();
> =20
>  	return !uuid_is_null(nfsd_uuid);
> @@ -51,7 +54,7 @@ EXPORT_SYMBOL_GPL(nfsd_uuid_is_local);
>   * This allows some sanity checking, like giving up on localio if nfsd isn=
't loaded.
>   */
> =20
> -extern int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
> +extern int nfsd_open_local_fh(struct net *, struct rpc_clnt *rpc_clnt,
>  			const struct cred *cred, const struct nfs_fh *nfs_fh,
>  			const fmode_t fmode, struct file **pfilp);
> =20
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> index 866e8c8a5548..a8a18f940a7e 100644
> --- a/fs/nfsd/localio.c
> +++ b/fs/nfsd/localio.c
> @@ -39,10 +39,10 @@ nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
>  }
> =20
>  static struct svc_rqst *
> -nfsd_local_fakerqst_create(struct rpc_clnt *rpc_clnt, const struct cred *c=
red)
> +nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
> +			const struct cred *cred)
>  {
>  	struct svc_rqst *rqstp;
> -	struct net *net =3D rpc_net_ns(rpc_clnt);
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>  	int status;
> =20
> @@ -127,7 +127,8 @@ nfsd_local_fakerqst_create(struct rpc_clnt *rpc_clnt, c=
onst struct cred *cred)
>   * dependency on knfsd. So, there is no forward declaration in a header fi=
le
>   * for it.
>   */
> -int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
> +int nfsd_open_local_fh(struct net *net,
> +			 struct rpc_clnt *rpc_clnt,
>  			 const struct cred *cred,
>  			 const struct nfs_fh *nfs_fh,
>  			 const fmode_t fmode,
> @@ -144,7 +145,7 @@ int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
>  	/* Save creds before calling into nfsd */
>  	save_cred =3D get_current_cred();
> =20
> -	rqstp =3D nfsd_local_fakerqst_create(rpc_clnt, cred);
> +	rqstp =3D nfsd_local_fakerqst_create(net, rpc_clnt, cred);
>  	if (IS_ERR(rqstp)) {
>  		status =3D PTR_ERR(rqstp);
>  		goto out_revertcred;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 22fb16258d44..fbe072dc53c0 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -473,6 +473,7 @@ static int nfsd_startup_net(struct net *net, const stru=
ct cred *cred)
>  #endif
>  #if defined(CONFIG_NFSD_V3_LOCALIO) || defined(CONFIG_NFSD_V4_LOCALIO)
>  	INIT_LIST_HEAD(&nn->nfsd_uuid.list);
> +	nn->nfsd_uuid.net =3D net;
>  	list_add_tail_rcu(&nn->nfsd_uuid.list, &nfsd_uuids);
>  #endif
>  	nn->nfsd_net_up =3D true;
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 91c50649a8c7..af07bb146e81 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -160,7 +160,8 @@ __be32		nfsd_permission(struct svc_rqst *, struct svc_e=
xport *,
> =20
>  void		nfsd_filp_close(struct file *fp);
> =20
> -int		nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
> +int		nfsd_open_local_fh(struct net *net,
> +				   struct rpc_clnt *rpc_clnt,
>  				   const struct cred *cred,
>  				   const struct nfs_fh *nfs_fh,
>  				   const fmode_t fmode,
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index f5760b05ec87..f47ea512eb0a 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -132,6 +132,7 @@ struct nfs_client {
>  	struct timespec64	cl_nfssvc_boot;
>  	seqlock_t		cl_boot_lock;
>  	struct rpc_clnt *	cl_rpcclient_localio;	/* localio RPC client handle */
> +	struct net *	        cl_nfssvc_net;
>  	nfs_to_nfsd_open_t	nfsd_open_local_fh;
>  };
> =20
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index b8df1b9f248d..c9592ad0afe2 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -8,6 +8,7 @@
>  #include <linux/list.h>
>  #include <linux/uuid.h>
>  #include <linux/nfs.h>
> +#include <net/net_namespace.h>
> =20
>  /*
>   * Global list of nfsd_uuid_t instances, add/remove
> @@ -23,13 +24,14 @@ extern struct list_head nfsd_uuids;
>  typedef struct {
>  	uuid_t uuid;
>  	struct list_head list;
> +	struct net *net; /* nfsd's network namespace */
>  } nfsd_uuid_t;
> =20
> -bool nfsd_uuid_is_local(const uuid_t *uuid);
> +bool nfsd_uuid_is_local(const uuid_t *uuid, struct net **netp);
> =20
> -typedef int (*nfs_to_nfsd_open_t)(struct rpc_clnt *, const struct cred *,
> -				  const struct nfs_fh *, const fmode_t,
> -				  struct file **);
> +typedef int (*nfs_to_nfsd_open_t)(struct net *, struct rpc_clnt *,
> +				const struct cred *, const struct nfs_fh *,
> +				const fmode_t, struct file **);
> =20
>  nfs_to_nfsd_open_t get_nfsd_open_local_fh(void);
>  void put_nfsd_open_local_fh(void);
> --=20
> 2.44.0
>=20
>=20
>=20


