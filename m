Return-Path: <linux-nfs+bounces-4031-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C0990DE74
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 23:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4125AB222C2
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 21:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103C616D32D;
	Tue, 18 Jun 2024 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ekr6IYXM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7DE13AA44
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746370; cv=none; b=fQxvnK2v9W1NfjOdRgYWN57YuF+ptCqift8V3+zR+dt6bd7BaLaD35Wqe2lJOSLk57X6dA6OIuC7t4GlgfAYi2i64wEskmRrPQVzdSZN+DvDn93/SB5zRd5T/90WwW36sx9+RF9rInhca7/KdHQHLtHhuHsiOTOK90PxAPuuqHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746370; c=relaxed/simple;
	bh=OK/3VDykefQ0/P/2fI/XST+V/9dzHWu3tvFIzS6ZJUQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mx2shbXS7hC1Q/qQ5ZCZJvgH5zx3KpboU/VAO6J1hmI/q0tPn9+l2jw77HOHVfhhTo9Hv83Sl2f8IIIx7FT2U7EgmmjKeJZ9vL95B9+wfay+5IlUJMrd3G/8hgfsg8hk1eOKAUxgqO6juCHYwga7RKjwU3ELrwxuRbpf7cwNsH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ekr6IYXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01D2C3277B;
	Tue, 18 Jun 2024 21:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718746369;
	bh=OK/3VDykefQ0/P/2fI/XST+V/9dzHWu3tvFIzS6ZJUQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Ekr6IYXMbmyT4gxEin0IYHsBcYYIVgQfS1IC9XHIRSLmE+xMU1jwYGvL1roA7dbFl
	 3BPPg+1Y0YzeN1+G4ar9zH1Ra25/YLYSLnjSZ0fVRWBjsbRMuZzWVvB/5ziQVhbNDT
	 mhM24/FbBzdRJsN77bsHCfP5FVQ6Ol0MGwMyDTgBBvxbUAPKmKsvMUtPjx3Q7rMOTo
	 KzIuxlqxRY1J3irlVHap4CgZvvOMSa7SlUwXGWk0gpkBpJ6sEqhrqDZAFCB2nfLtQF
	 Q/EJe9w7vCZormoE8yN/5HwA6bxY7Hx0eNc0gn7yrqCGns9OV3TH5qPHGvih8QBy/h
	 K9Ng3dBynT7zg==
Message-ID: <ecad096a9a2273a9fbc5cb5a2ea4fc74c81e795f.camel@kernel.org>
Subject: Re: [PATCH v5 12/19] nfs/localio: move managing nfsd_open_local_fh
 symbol to nfs_common
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Trond Myklebust
 <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 snitzer@hammerspace.com
Date: Tue, 18 Jun 2024 17:32:47 -0400
In-Reply-To: <20240618201949.81977-13-snitzer@kernel.org>
References: <20240618201949.81977-1-snitzer@kernel.org>
	 <20240618201949.81977-13-snitzer@kernel.org>
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
> Get nfsd_open_local_fh and store it in rpc_client during client
> creation, put the symbol during nfs_local_disable -- which is also
> called during client destruction.
>=20
> Eliminates the need for nfs_local_open_ctx and extra locking and
> refcounting work in fs/nfs/localio.c
>=20
> Also makes it so the reference to the nfsd_open_local_fh symbol is
> managed by the nfs_common module instead of the nfs client modules.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
> =C2=A0fs/nfs/client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0fs/nfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 -
> =C2=A0fs/nfs/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 18 +++++---
> =C2=A0fs/nfs/localio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 86 +++-----------------------------------
> =C2=A0fs/nfs_common/nfslocalio.c | 26 ++++++++++++
> =C2=A0include/linux/nfs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 4 --
> =C2=A0include/linux/nfs_fs_sb.h=C2=A0 |=C2=A0 2 +
> =C2=A0include/linux/nfslocalio.h |=C2=A0 8 ++++
> =C2=A08 files changed, 54 insertions(+), 92 deletions(-)
>=20
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 7044b8b3b332..cbabcdf3d785 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -171,6 +171,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_=
client_initdata *cl_init)
> =C2=A0
> =C2=A0	INIT_LIST_HEAD(&clp->cl_superblocks);
> =C2=A0	clp->cl_rpcclient =3D clp->cl_rpcclient_localio =3D ERR_PTR(-EINVA=
L);
> +	clp->nfsd_open_local_fh =3D NULL;
> =C2=A0
> =C2=A0	clp->cl_flags =3D cl_init->init_flags;
> =C2=A0	clp->cl_proto =3D cl_init->proto;
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 4f88b860494f..f9923cbf6058 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -2499,7 +2499,6 @@ static int __init init_nfs_fs(void)
> =C2=A0	if (err)
> =C2=A0		goto out1;
> =C2=A0
> -	nfs_local_init();
> =C2=A0	err =3D register_nfs_fs();
> =C2=A0	if (err)
> =C2=A0		goto out0;
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index fb2fb59e7ed0..d30a2e63063c 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -464,15 +464,22 @@ nfs_init_localioclient(struct nfs_client *clp,
> =C2=A0		goto out;
> =C2=A0	clp->cl_rpcclient_localio =3D rpc_bind_new_program(clp->cl_rpcclie=
nt,
> =C2=A0							 program, vers);
> +	if (IS_ERR(clp->cl_rpcclient_localio))
> +		goto out;
> +	/* No errors! Assume that localio is supported */
> +	clp->nfsd_open_local_fh =3D get_nfsd_open_local_fh();
> +	if (!clp->nfsd_open_local_fh) {
> +		rpc_shutdown_client(clp->cl_rpcclient_localio);
> +		clp->cl_rpcclient_localio =3D ERR_PTR(-EINVAL);
> +	}
> =C2=A0out:
> -	dfprintk_rcu(CLIENT, "%s: server (%s) %s NFSv%u LOCALIO\n", __func__,
> -		rpc_peeraddr2str(clp->cl_rpcclient, RPC_DISPLAY_ADDR),
> -		(IS_ERR(clp->cl_rpcclient_localio) ?
> -		 "does not support" : "supports"), vers);
> +	dfprintk_rcu(CLIENT, "%s: server (%s) %s NFSv%u LOCALIO, nfsd_open_loca=
l_fh is %s.\n",
> +		__func__, rpc_peeraddr2str(clp->cl_rpcclient, RPC_DISPLAY_ADDR),
> +		(IS_ERR(clp->cl_rpcclient_localio) ? "does not support" : "supports"),=
 vers,
> +		(clp->nfsd_open_local_fh ? "set" : "not set"));
> =C2=A0}
> =C2=A0
> =C2=A0/* localio.c */
> -extern void nfs_local_init(void);
> =C2=A0extern void nfs_local_disable(struct nfs_client *);
> =C2=A0extern void nfs_local_probe(struct nfs_client *);
> =C2=A0extern struct file *nfs_local_open_fh(struct nfs_client *, const st=
ruct cred *,
> @@ -489,7 +496,6 @@ extern int nfs_local_commit(struct file *, struct nfs=
_commit_data *,
> =C2=A0extern bool nfs_server_is_local(const struct nfs_client *clp);
> =C2=A0
> =C2=A0#else
> -static inline void nfs_local_init(void) {}
> =C2=A0static inline void nfs_local_disable(struct nfs_client *clp) {}
> =C2=A0static inline void nfs_local_probe(struct nfs_client *clp) {}
> =C2=A0static inline struct file *nfs_local_open_fh(struct nfs_client *clp=
,
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 54c41933173c..ddd17549812e 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -29,26 +29,6 @@
> =C2=A0
> =C2=A0#define NFSDBG_FACILITY		NFSDBG_VFS
> =C2=A0
> -extern int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct cred *cred,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct nfs_fh *nfs_fh, const fmo=
de_t fmode,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct file **pfilp);
> -/*
> - * The localio code needs to call into nfsd to do the filehandle -> stru=
ct path
> - * mapping, but cannot be statically linked, because that will make the =
nfs
> - * module depend on the nfsd module.
> - *
> - * Instead, do dynamic linking to the nfsd module. This way the nfs modu=
le
> - * will only hold a reference on nfsd when it's actually in use. This al=
so
> - * allows some sanity checking, like giving up on localio if nfsd isn't =
loaded.
> - */
> -
> -struct nfs_local_open_ctx {
> -	spinlock_t lock;
> -	nfs_to_nfsd_open_t open_f;
> -	atomic_t refcount;
> -};
> -
> =C2=A0struct nfs_local_kiocb {
> =C2=A0	struct kiocb		kiocb;
> =C2=A0	struct bio_vec		*bvec;
> @@ -135,8 +115,6 @@ nfs4errno(int errno)
> =C2=A0	return NFS4ERR_SERVERFAULT;
> =C2=A0}
> =C2=A0
> -static struct nfs_local_open_ctx __local_open_ctx __read_mostly;
> -
> =C2=A0static bool localio_enabled __read_mostly =3D true;
> =C2=A0module_param(localio_enabled, bool, 0644);
> =C2=A0
> @@ -151,65 +129,12 @@ bool nfs_server_is_local(const struct nfs_client *c=
lp)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(nfs_server_is_local);
> =C2=A0
> -void
> -nfs_local_init(void)
> -{
> -	struct nfs_local_open_ctx *ctx =3D &__local_open_ctx;
> -
> -	ctx->open_f =3D NULL;
> -	spin_lock_init(&ctx->lock);
> -	atomic_set(&ctx->refcount, 0);
> -}
> -
> -static bool
> -nfs_local_get_lookup_ctx(void)
> -{
> -	struct nfs_local_open_ctx *ctx =3D &__local_open_ctx;
> -	nfs_to_nfsd_open_t fn =3D NULL;
> -
> -	spin_lock(&ctx->lock);
> -	if (ctx->open_f =3D=3D NULL) {
> -		spin_unlock(&ctx->lock);
> -
> -		fn =3D symbol_request(nfsd_open_local_fh);
> -		if (!fn)
> -			return false;
> -
> -		spin_lock(&ctx->lock);
> -		/* catch race */
> -		if (ctx->open_f =3D=3D NULL) {
> -			ctx->open_f =3D fn;
> -			fn =3D NULL;
> -		}
> -	}
> -	atomic_inc(&ctx->refcount);
> -	spin_unlock(&ctx->lock);
> -	if (fn)
> -		symbol_put(nfsd_open_local_fh);
> -	return true;
> -}
> -
> -static void
> -nfs_local_put_lookup_ctx(void)
> -{
> -	struct nfs_local_open_ctx *ctx =3D &__local_open_ctx;
> -	nfs_to_nfsd_open_t fn;
> -
> -	if (atomic_dec_and_lock(&ctx->refcount, &ctx->lock)) {
> -		fn =3D ctx->open_f;
> -		ctx->open_f =3D NULL;
> -		spin_unlock(&ctx->lock);
> -		if (fn)
> -			symbol_put(nfsd_open_local_fh);
> -	}
> -}
> -


It seems like the new nfs_common infrastructure should be added earlier
in the series so you don't need to rip out the code above.

> =C2=A0/*
> =C2=A0 * nfs_local_enable - attempt to enable local i/o for an nfs_client
> =C2=A0 */
> =C2=A0static void nfs_local_enable(struct nfs_client *clp)
> =C2=A0{
> -	if (nfs_local_get_lookup_ctx()) {
> +	if (READ_ONCE(clp->nfsd_open_local_fh)) {
> =C2=A0		set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
> =C2=A0		trace_nfs_local_enable(clp);
> =C2=A0	}
> @@ -218,12 +143,12 @@ static void nfs_local_enable(struct nfs_client *clp=
)
> =C2=A0/*
> =C2=A0 * nfs_local_disable - disable local i/o for an nfs_client
> =C2=A0 */
> -void
> -nfs_local_disable(struct nfs_client *clp)
> +void nfs_local_disable(struct nfs_client *clp)
> =C2=A0{
> =C2=A0	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
> =C2=A0		trace_nfs_local_disable(clp);
> -		nfs_local_put_lookup_ctx();
> +		put_nfsd_open_local_fh();
> +		clp->nfsd_open_local_fh =3D NULL;
> =C2=A0		if (!IS_ERR(clp->cl_rpcclient_localio)) {
> =C2=A0			rpc_shutdown_client(clp->cl_rpcclient_localio);
> =C2=A0			clp->cl_rpcclient_localio =3D ERR_PTR(-EINVAL);
> @@ -312,14 +237,13 @@ struct file *
> =C2=A0nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
> =C2=A0		=C2=A0 struct nfs_fh *fh, const fmode_t mode)
> =C2=A0{
> -	struct nfs_local_open_ctx *ctx =3D &__local_open_ctx;
> =C2=A0	struct file *filp;
> =C2=A0	int status;
> =C2=A0
> =C2=A0	if (mode & ~(FMODE_READ | FMODE_WRITE))
> =C2=A0		return ERR_PTR(-EINVAL);
> =C2=A0
> -	status =3D ctx->open_f(clp->cl_rpcclient, cred, fh, mode, &filp);
> +	status =3D clp->nfsd_open_local_fh(clp->cl_rpcclient, cred, fh, mode, &=
filp);
> =C2=A0	if (status < 0) {
> =C2=A0		dprintk("%s: open local file failed error=3D%d\n",
> =C2=A0				__func__, status);
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index f214cc6754a1..c454c4100976 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -40,3 +40,29 @@ bool nfsd_uuid_is_local(const uuid_t *uuid)
> =C2=A0	return !uuid_is_null(nfsd_uuid);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(nfsd_uuid_is_local);
> +
> +/*
> + * The nfs localio code needs to call into nfsd to do the filehandle -> =
struct path
> + * mapping, but cannot be statically linked, because that will make the =
nfs module
> + * depend on the nfsd module.
> + *
> + * Instead, do dynamic linking to the nfsd module (via nfs_common module=
). The
> + * nfs_common module will only hold a reference on nfsd when localio is =
in use.
> + * This allows some sanity checking, like giving up on localio if nfsd i=
sn't loaded.
> + */
> +
> +extern int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
> +			const struct cred *cred, const struct nfs_fh *nfs_fh,
> +			const fmode_t fmode, struct file **pfilp);
> +
> +nfs_to_nfsd_open_t get_nfsd_open_local_fh(void)
> +{
> +	return symbol_request(nfsd_open_local_fh);
> +}
> +EXPORT_SYMBOL_GPL(get_nfsd_open_local_fh);
> +
> +void put_nfsd_open_local_fh(void)
> +{
> +	symbol_put(nfsd_open_local_fh);
> +}
> +EXPORT_SYMBOL_GPL(put_nfsd_open_local_fh);
> diff --git a/include/linux/nfs.h b/include/linux/nfs.h
> index 2dacfe9742c6..64ed672a0b34 100644
> --- a/include/linux/nfs.h
> +++ b/include/linux/nfs.h
> @@ -48,10 +48,6 @@ enum nfs3_stable_how {
> =C2=A0	NFS_INVALID_STABLE_HOW =3D -1
> =C2=A0};
> =C2=A0
> -typedef int (*nfs_to_nfsd_open_t)(struct rpc_clnt *, const struct cred *=
,
> -				=C2=A0 const struct nfs_fh *, const fmode_t,
> -				=C2=A0 struct file **);
> -
> =C2=A0#ifdef CONFIG_CRC32
> =C2=A0/**
> =C2=A0 * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index efcdb4d8e9de..f5760b05ec87 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -8,6 +8,7 @@
> =C2=A0#include <linux/wait.h>
> =C2=A0#include <linux/nfs_xdr.h>
> =C2=A0#include <linux/sunrpc/xprt.h>
> +#include <linux/nfslocalio.h>
> =C2=A0
> =C2=A0#include <linux/atomic.h>
> =C2=A0#include <linux/refcount.h>
> @@ -131,6 +132,7 @@ struct nfs_client {
> =C2=A0	struct timespec64	cl_nfssvc_boot;
> =C2=A0	seqlock_t		cl_boot_lock;
> =C2=A0	struct rpc_clnt *	cl_rpcclient_localio;	/* localio RPC client hand=
le */
> +	nfs_to_nfsd_open_t	nfsd_open_local_fh;
> =C2=A0};
> =C2=A0
> =C2=A0/*
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index d0bbacd0adcf..b8df1b9f248d 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -7,6 +7,7 @@
> =C2=A0
> =C2=A0#include <linux/list.h>
> =C2=A0#include <linux/uuid.h>
> +#include <linux/nfs.h>
> =C2=A0
> =C2=A0/*
> =C2=A0 * Global list of nfsd_uuid_t instances, add/remove
> @@ -26,4 +27,11 @@ typedef struct {
> =C2=A0
> =C2=A0bool nfsd_uuid_is_local(const uuid_t *uuid);
> =C2=A0
> +typedef int (*nfs_to_nfsd_open_t)(struct rpc_clnt *, const struct cred *=
,
> +				=C2=A0 const struct nfs_fh *, const fmode_t,
> +				=C2=A0 struct file **);
> +
> +nfs_to_nfsd_open_t get_nfsd_open_local_fh(void);
> +void put_nfsd_open_local_fh(void);
> +
> =C2=A0#endif=C2=A0 /* __LINUX_NFSLOCALIO_H */

--=20
Jeff Layton <jlayton@kernel.org>

