Return-Path: <linux-nfs+bounces-4032-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB06990DE80
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 23:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847E428371D
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 21:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2861741CC;
	Tue, 18 Jun 2024 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgchdqzO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AC513DDD2
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746578; cv=none; b=fV8hHBulkfDWAZfEZ/Eb80Pu7Ha8NfKZHCCklxDDq14eJlpTmeLRDZzXA5sWO73VIIkFqNqrOrhiN/YlDoU9v54n/8hjVCc+wDqtlJN8+oHLMCagOMFlRCQkJxbU6hRTxI56BjwcStQyn1fWqMFPZVPwN+6XcfX3bl8S0WJ9MT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746578; c=relaxed/simple;
	bh=t9ZoESyd+AMu7umImdiDBqqjQnkt2ywyRhAUjojWxYg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FQABxmChjT892Eocqua1gEe2KO3LJ6IDifhbg4bzULucNJ4HoArPmp7/H+Odz/QGS2HXP1yWo9vN/ASBcoHXJuVCME+sHwB4dzUGxO8zfmBGUyilEzo0ycvh1IDu8mz3sf3ymgFU9uU+rGEvptZMh0GtnaVhWqxiPJPAtA47nL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgchdqzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3039DC3277B;
	Tue, 18 Jun 2024 21:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718746577;
	bh=t9ZoESyd+AMu7umImdiDBqqjQnkt2ywyRhAUjojWxYg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bgchdqzOsQc2oJQXegiWYzc70WpUy9BNpEBcigS53BJfaUjc7i8t8IzTa5qOebYHa
	 hCfJNV+U8TkkyPjSl6G9e0v1SWekWmaHDqzf7YHpkJc/9+cVPX9KP4UekhXS99rKXB
	 t7N96z4nxrWdWiBydlGutFKMmTZ8Ij0Q9M7aWx6O/gk4rMkVrmO01CFlu3D36ls4V0
	 BSPz//2/sOPHix0u51dKnAw6pMguyr8FupKVg1CyMDJhzviBfjSVg2Fbzn/af0EPPh
	 tinRkc/1m8aG5axZmDvFQu3IuTf0zokZre9d0PbDU7qNaAIshjbIlzkHKTbPwYgzNZ
	 iQOvmOPZAJXmQ==
Message-ID: <c4e88da2d3d5d6a6649bb072f11726e9ece51c82.camel@kernel.org>
Subject: Re: [PATCH v5 13/19] nfs/nfsd: ensure localio server always uses
 its network namespace
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Trond Myklebust
 <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 snitzer@hammerspace.com
Date: Tue, 18 Jun 2024 17:36:15 -0400
In-Reply-To: <20240618201949.81977-14-snitzer@kernel.org>
References: <20240618201949.81977-1-snitzer@kernel.org>
	 <20240618201949.81977-14-snitzer@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 16:19 -0400, Mike Snitzer wrote:
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

I think this too needs to be introduced earlier in the series. Prior to
this point, someone could have LOCALIO enabled in their kernel, no? If
so, then that seems like it may be broken.

I think as a goal, we should ensure that we don't allow someone to turn
on LOCALIO until all of the necessary pieces are in place. Otherwise,
things may be "funny" during a bisect.

> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
> =C2=A0fs/nfs/client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0fs/nfs/localio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 12 ++++++++----
> =C2=A0fs/nfs_common/nfslocalio.c | 15 +++++++++------
> =C2=A0fs/nfsd/localio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 9 +++++----
> =C2=A0fs/nfsd/nfssvc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 1 +
> =C2=A0fs/nfsd/vfs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
> =C2=A0include/linux/nfs_fs_sb.h=C2=A0 |=C2=A0 1 +
> =C2=A0include/linux/nfslocalio.h | 10 ++++++----
> =C2=A08 files changed, 33 insertions(+), 19 deletions(-)
>=20
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index cbabcdf3d785..40077ad08ccb 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -171,6 +171,7 @@ struct nfs_client *nfs_alloc_client(const struct
> nfs_client_initdata *cl_init)
> =C2=A0
> =C2=A0	INIT_LIST_HEAD(&clp->cl_superblocks);
> =C2=A0	clp->cl_rpcclient =3D clp->cl_rpcclient_localio =3D ERR_PTR(-
> EINVAL);
> +	clp->cl_nfssvc_net =3D NULL;
> =C2=A0	clp->nfsd_open_local_fh =3D NULL;
> =C2=A0
> =C2=A0	clp->cl_flags =3D cl_init->init_flags;
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index ddd17549812e..d41130f5a84d 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -132,10 +132,11 @@ EXPORT_SYMBOL_GPL(nfs_server_is_local);
> =C2=A0/*
> =C2=A0 * nfs_local_enable - attempt to enable local i/o for an nfs_client
> =C2=A0 */
> -static void nfs_local_enable(struct nfs_client *clp)
> +static void nfs_local_enable(struct nfs_client *clp, struct net
> *net)
> =C2=A0{
> =C2=A0	if (READ_ONCE(clp->nfsd_open_local_fh)) {
> =C2=A0		set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
> +		clp->cl_nfssvc_net =3D net;
> =C2=A0		trace_nfs_local_enable(clp);
> =C2=A0	}
> =C2=A0}
> @@ -153,6 +154,7 @@ void nfs_local_disable(struct nfs_client *clp)
> =C2=A0			rpc_shutdown_client(clp-
> >cl_rpcclient_localio);
> =C2=A0			clp->cl_rpcclient_localio =3D ERR_PTR(-
> EINVAL);
> =C2=A0		}
> +		clp->cl_nfssvc_net =3D NULL;
> =C2=A0	}
> =C2=A0}
> =C2=A0
> @@ -192,6 +194,7 @@ static bool nfs_local_server_getuuid(struct
> nfs_client *clp, uuid_t *nfsd_uuid)
> =C2=A0void nfs_local_probe(struct nfs_client *clp)
> =C2=A0{
> =C2=A0	uuid_t uuid;
> +	struct net *net =3D NULL;
> =C2=A0
> =C2=A0	if (!localio_enabled)
> =C2=A0		goto unsupported;
> @@ -211,7 +214,7 @@ void nfs_local_probe(struct nfs_client *clp)
> =C2=A0		 * by verifying client's nfsd, with specified uuid,
> is local.
> =C2=A0		 */
> =C2=A0		if (!nfs_local_server_getuuid(clp, &uuid) ||
> -		=C2=A0=C2=A0=C2=A0 !nfsd_uuid_is_local(&uuid))
> +		=C2=A0=C2=A0=C2=A0 !nfsd_uuid_is_local(&uuid, &net))
> =C2=A0			goto unsupported;
> =C2=A0		break;
> =C2=A0	default:
> @@ -219,7 +222,7 @@ void nfs_local_probe(struct nfs_client *clp)
> =C2=A0	}
> =C2=A0
> =C2=A0	dprintk("%s: detected local server.\n", __func__);
> -	nfs_local_enable(clp);
> +	nfs_local_enable(clp, net);
> =C2=A0	return;
> =C2=A0
> =C2=A0unsupported:
> @@ -243,7 +246,8 @@ nfs_local_open_fh(struct nfs_client *clp, const
> struct cred *cred,
> =C2=A0	if (mode & ~(FMODE_READ | FMODE_WRITE))
> =C2=A0		return ERR_PTR(-EINVAL);
> =C2=A0
> -	status =3D clp->nfsd_open_local_fh(clp->cl_rpcclient, cred,
> fh, mode, &filp);
> +	status =3D clp->nfsd_open_local_fh(clp->cl_nfssvc_net, clp-
> >cl_rpcclient,
> +					cred, fh, mode, &filp);
> =C2=A0	if (status < 0) {
> =C2=A0		dprintk("%s: open local file failed error=3D%d\n",
> =C2=A0				__func__, status);
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index c454c4100976..086e09b3ec38 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -12,29 +12,32 @@ MODULE_LICENSE("GPL");
> =C2=A0/*
> =C2=A0 * Global list of nfsd_uuid_t instances, add/remove
> =C2=A0 * is protected by fs/nfsd/nfssvc.c:nfsd_mutex.
> - * Reads are protected RCU read lock (see below).
> + * Reads are protected by RCU read lock (see below).
> =C2=A0 */
> =C2=A0LIST_HEAD(nfsd_uuids);
> =C2=A0EXPORT_SYMBOL(nfsd_uuids);
> =C2=A0
> =C2=A0/* Must be called with RCU read lock held. */
> -static const uuid_t * nfsd_uuid_lookup(const uuid_t *uuid)
> +static const uuid_t * nfsd_uuid_lookup(const uuid_t *uuid,
> +				struct net **netp)
> =C2=A0{
> =C2=A0	nfsd_uuid_t *nfsd_uuid;
> =C2=A0
> =C2=A0	list_for_each_entry_rcu(nfsd_uuid, &nfsd_uuids, list)
> -		if (uuid_equal(&nfsd_uuid->uuid, uuid))
> +		if (uuid_equal(&nfsd_uuid->uuid, uuid)) {
> +			*netp =3D nfsd_uuid->net;
> =C2=A0			return &nfsd_uuid->uuid;
> +		}
> =C2=A0
> =C2=A0	return &uuid_null;
> =C2=A0}
> =C2=A0
> -bool nfsd_uuid_is_local(const uuid_t *uuid)
> +bool nfsd_uuid_is_local(const uuid_t *uuid, struct net **netp)
> =C2=A0{
> =C2=A0	const uuid_t *nfsd_uuid;
> =C2=A0
> =C2=A0	rcu_read_lock();
> -	nfsd_uuid =3D nfsd_uuid_lookup(uuid);
> +	nfsd_uuid =3D nfsd_uuid_lookup(uuid, netp);
> =C2=A0	rcu_read_unlock();
> =C2=A0
> =C2=A0	return !uuid_is_null(nfsd_uuid);
> @@ -51,7 +54,7 @@ EXPORT_SYMBOL_GPL(nfsd_uuid_is_local);
> =C2=A0 * This allows some sanity checking, like giving up on localio if
> nfsd isn't loaded.
> =C2=A0 */
> =C2=A0
> -extern int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
> +extern int nfsd_open_local_fh(struct net *, struct rpc_clnt
> *rpc_clnt,
> =C2=A0			const struct cred *cred, const struct nfs_fh
> *nfs_fh,
> =C2=A0			const fmode_t fmode, struct file **pfilp);
> =C2=A0
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> index 7ecd72406dc0..34678bfed579 100644
> --- a/fs/nfsd/localio.c
> +++ b/fs/nfsd/localio.c
> @@ -103,10 +103,10 @@ nfsd_local_fakerqst_destroy(struct svc_rqst
> *rqstp)
> =C2=A0}
> =C2=A0
> =C2=A0static struct svc_rqst *
> -nfsd_local_fakerqst_create(struct rpc_clnt *rpc_clnt, const struct
> cred *cred)
> +nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt
> *rpc_clnt,
> +			const struct cred *cred)
> =C2=A0{
> =C2=A0	struct svc_rqst *rqstp;
> -	struct net *net =3D rpc_net_ns(rpc_clnt);
> =C2=A0	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> =C2=A0	int status;
> =C2=A0
> @@ -186,7 +186,8 @@ nfsd_local_fakerqst_create(struct rpc_clnt
> *rpc_clnt, const struct cred *cred)
> =C2=A0 * dependency on knfsd. So, there is no forward declaration in a
> header file
> =C2=A0 * for it.
> =C2=A0 */
> -int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
> +int nfsd_open_local_fh(struct net *net,
> +			 struct rpc_clnt *rpc_clnt,
> =C2=A0			 const struct cred *cred,
> =C2=A0			 const struct nfs_fh *nfs_fh,
> =C2=A0			 const fmode_t fmode,
> @@ -203,7 +204,7 @@ int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
> =C2=A0	/* Save creds before calling into nfsd */
> =C2=A0	save_cred =3D get_current_cred();
> =C2=A0
> -	rqstp =3D nfsd_local_fakerqst_create(rpc_clnt, cred);
> +	rqstp =3D nfsd_local_fakerqst_create(net, rpc_clnt, cred);
> =C2=A0	if (IS_ERR(rqstp)) {
> =C2=A0		status =3D PTR_ERR(rqstp);
> =C2=A0		goto out_revertcred;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index a81be9b39399..48bfd3c6d619 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -473,6 +473,7 @@ static int nfsd_startup_net(struct net *net,
> const struct cred *cred)
> =C2=A0#endif
> =C2=A0#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> =C2=A0	INIT_LIST_HEAD(&nn->nfsd_uuid.list);
> +	nn->nfsd_uuid.net =3D net;
> =C2=A0	list_add_tail_rcu(&nn->nfsd_uuid.list, &nfsd_uuids);
> =C2=A0#endif
> =C2=A0	nn->nfsd_net_up =3D true;
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 91c50649a8c7..af07bb146e81 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -160,7 +160,8 @@ __be32		nfsd_permission(struct
> svc_rqst *, struct svc_export *,
> =C2=A0
> =C2=A0void		nfsd_filp_close(struct file *fp);
> =C2=A0
> -int		nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
> +int		nfsd_open_local_fh(struct net *net,
> +				=C2=A0=C2=A0 struct rpc_clnt *rpc_clnt,
> =C2=A0				=C2=A0=C2=A0 const struct cred *cred,
> =C2=A0				=C2=A0=C2=A0 const struct nfs_fh *nfs_fh,
> =C2=A0				=C2=A0=C2=A0 const fmode_t fmode,
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index f5760b05ec87..f47ea512eb0a 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -132,6 +132,7 @@ struct nfs_client {
> =C2=A0	struct timespec64	cl_nfssvc_boot;
> =C2=A0	seqlock_t		cl_boot_lock;
> =C2=A0	struct rpc_clnt *	cl_rpcclient_localio;	/* localio
> RPC client handle */
> +	struct net *	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl_nfssvc_net;
> =C2=A0	nfs_to_nfsd_open_t	nfsd_open_local_fh;
> =C2=A0};
> =C2=A0
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index b8df1b9f248d..c9592ad0afe2 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -8,6 +8,7 @@
> =C2=A0#include <linux/list.h>
> =C2=A0#include <linux/uuid.h>
> =C2=A0#include <linux/nfs.h>
> +#include <net/net_namespace.h>
> =C2=A0
> =C2=A0/*
> =C2=A0 * Global list of nfsd_uuid_t instances, add/remove
> @@ -23,13 +24,14 @@ extern struct list_head nfsd_uuids;
> =C2=A0typedef struct {
> =C2=A0	uuid_t uuid;
> =C2=A0	struct list_head list;
> +	struct net *net; /* nfsd's network namespace */
> =C2=A0} nfsd_uuid_t;
> =C2=A0
> -bool nfsd_uuid_is_local(const uuid_t *uuid);
> +bool nfsd_uuid_is_local(const uuid_t *uuid, struct net **netp);
> =C2=A0
> -typedef int (*nfs_to_nfsd_open_t)(struct rpc_clnt *, const struct
> cred *,
> -				=C2=A0 const struct nfs_fh *, const
> fmode_t,
> -				=C2=A0 struct file **);
> +typedef int (*nfs_to_nfsd_open_t)(struct net *, struct rpc_clnt *,
> +				const struct cred *, const struct
> nfs_fh *,
> +				const fmode_t, struct file **);
> =C2=A0
> =C2=A0nfs_to_nfsd_open_t get_nfsd_open_local_fh(void);
> =C2=A0void put_nfsd_open_local_fh(void);

--=20
Jeff Layton <jlayton@kernel.org>

