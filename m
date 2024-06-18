Return-Path: <linux-nfs+bounces-4030-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC2690DE64
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 23:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78161C220D8
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 21:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2830178CEC;
	Tue, 18 Jun 2024 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/vSiCIF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9987713AA44
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746105; cv=none; b=DORDuJ4r5d2l9gVIVNN6d9ORC3JXU1jvcBgDaU5tOOx4NMOtKLEIbrXMk6HtamrP+7dqDa4IqRrDFKvhkWeIX9ZH15QcYUDPFEgQffDFWvMFB5mynHVmf0rNBbKjFthyEiqkF9eKTVwEZCfsauVosb1hSAhcXk6VubkqC0Zppn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746105; c=relaxed/simple;
	bh=VxDHUC0XO5d1mDxomWNPTQZ/r1rEHe6n0sM9djd69Yc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q0V7DbL6nf4sv//zv/eVo+c2LVKEZXak/vs/TE1Ps6wgmuJHiJzsZyUuoL7MYWnn4qawdc02c8gwyOqSGlfuNLhrM7Ll6T7P3PHOwVwqSXp5RaissAP075zdh2L2Ed4t9RQE3PYORUAgrJ7ih+6m3zw8Hba47HC4HTMRgTMe/44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/vSiCIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D148C3277B;
	Tue, 18 Jun 2024 21:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718746105;
	bh=VxDHUC0XO5d1mDxomWNPTQZ/r1rEHe6n0sM9djd69Yc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=W/vSiCIFkeAD5s4DXLoPz+5QI72ZM/+YQlMw14eb0oaISrfo6JZIBUZwKeHEZyZfS
	 3GY9k8WFqqTVhjSIfDvKoFZqzBrcRpU7Uh1LTIO24SWs4H01xCBY7EyUxJvLxOKvxg
	 ON+Ei8yzpRQtNO5hTfebt8p/j6NkiqvtkpvymZ3dXz2zzFYuGfUsmiBSuVCxeNfvep
	 vdSzus06jq3toXLmJmSYjmSCFGIIzkJVKp/nVWls4xwzEt5DzHU9N6Er5t6apo+Sph
	 Qehf2QmZqiKKLpeaMXYZJ3p/JcuZPx+cF36U485286yfp0uUKlX6//UymK8ILWWxm8
	 8Le5OZOkq/A1g==
Message-ID: <a2b853837f318af2c23ea024cbf1b2743faead3a.camel@kernel.org>
Subject: Re: [PATCH v5 06/19] nfs/nfsd: add "localio" support
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Trond Myklebust
 <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 snitzer@hammerspace.com
Date: Tue, 18 Jun 2024 17:28:22 -0400
In-Reply-To: <20240618201949.81977-7-snitzer@kernel.org>
References: <20240618201949.81977-1-snitzer@kernel.org>
	 <20240618201949.81977-7-snitzer@kernel.org>
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
> From: Weston Andros Adamson <dros@primarydata.com>
>=20
> Add client support for bypassing NFS for localhost reads, writes, and
> commits. This is only useful when the client and the server are
> running on the same host.
>=20
> nfs_local_probe() is stubbed out, later commits will enable client and
> server handshake via a LOCALIO protocol extension.
>=20
> This has dynamic binding with the nfsd module. Localio will only work
> if nfsd is already loaded.
>=20
> The "localio_enabled" nfs kernel module parameter can be used to
> disable and enable the ability to use localio support.
>=20
> Also, tracepoints were added for nfs_local_open_fh, nfs_local_enable
> and nfs_local_disable.
>=20
> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Peng Tao <tao.peng@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
> =C2=A0fs/nfs/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0fs/nfs/client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 7 +
> =C2=A0fs/nfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +
> =C2=A0fs/nfs/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 53 +++
> =C2=A0fs/nfs/localio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 797 ++++++++++++++++++++++++++++++++++++++
> =C2=A0fs/nfs/nfstrace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 61 +++
> =C2=A0fs/nfs/pagelist.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 3 +
> =C2=A0fs/nfs/write.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0fs/nfsd/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
> =C2=A0fs/nfsd/filecache.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 2 +-
> =C2=A0fs/nfsd/localio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 243 ++++++++++++
> =C2=A0fs/nfsd/trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 3 +-
> =C2=A0fs/nfsd/vfs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +
> =C2=A0include/linux/nfs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 6 +
> =C2=A0include/linux/nfs_fs.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0include/linux/nfs_fs_sb.h |=C2=A0=C2=A0 5 +
> =C2=A0include/linux/nfs_xdr.h=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A017 files changed, 1199 insertions(+), 2 deletions(-)
> =C2=A0create mode 100644 fs/nfs/localio.c
> =C2=A0create mode 100644 fs/nfsd/localio.c
>=20
> diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
> index 5f6db37f461e..9fb2f2cac87e 100644
> --- a/fs/nfs/Makefile
> +++ b/fs/nfs/Makefile
> @@ -13,6 +13,7 @@ nfs-y=C2=A0			:=3D client.o dir.o file.o getroot.o inod=
e.o super.o \
> =C2=A0nfs-$(CONFIG_ROOT_NFS)	+=3D nfsroot.o
> =C2=A0nfs-$(CONFIG_SYSCTL)	+=3D sysctl.o
> =C2=A0nfs-$(CONFIG_NFS_FSCACHE) +=3D fscache.o
> +nfs-$(CONFIG_NFS_LOCALIO) +=3D localio.o
> =C2=A0
> =C2=A0obj-$(CONFIG_NFS_V2) +=3D nfsv2.o
> =C2=A0nfsv2-y :=3D nfs2super.o proc.o nfs2xdr.o
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index de77848ae654..9170e6036fd2 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -178,6 +178,10 @@ struct nfs_client *nfs_alloc_client(const struct nfs=
_client_initdata *cl_init)
> =C2=A0	clp->cl_max_connect =3D cl_init->max_connect ? cl_init->max_connec=
t : 1;
> =C2=A0	clp->cl_net =3D get_net(cl_init->net);
> =C2=A0
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +	seqlock_init(&clp->cl_boot_lock);
> +	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
> +#endif
> =C2=A0	clp->cl_principal =3D "*";
> =C2=A0	clp->cl_xprtsec =3D cl_init->xprtsec;
> =C2=A0	return clp;
> @@ -233,6 +237,8 @@ static void pnfs_init_server(struct nfs_server *serve=
r)
> =C2=A0 */
> =C2=A0void nfs_free_client(struct nfs_client *clp)
> =C2=A0{
> +	nfs_local_disable(clp);
> +
> =C2=A0	/* -EIO all pending I/O */
> =C2=A0	if (!IS_ERR(clp->cl_rpcclient))
> =C2=A0		rpc_shutdown_client(clp->cl_rpcclient);
> @@ -424,6 +430,7 @@ struct nfs_client *nfs_get_client(const struct nfs_cl=
ient_initdata *cl_init)
> =C2=A0			list_add_tail(&new->cl_share_link,
> =C2=A0					&nn->nfs_client_list);
> =C2=A0			spin_unlock(&nn->nfs_client_lock);
> +			nfs_local_probe(new);
> =C2=A0			return rpc_ops->init_client(new, cl_init);
> =C2=A0		}
> =C2=A0
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index acef52ecb1bb..4f88b860494f 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -39,6 +39,7 @@
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/compat.h>
> =C2=A0#include <linux/freezer.h>
> +#include <linux/file.h>
> =C2=A0#include <linux/uaccess.h>
> =C2=A0#include <linux/iversion.h>
> =C2=A0
> @@ -1053,6 +1054,7 @@ struct nfs_open_context *alloc_nfs_open_context(str=
uct dentry *dentry,
> =C2=A0	ctx->lock_context.open_context =3D ctx;
> =C2=A0	INIT_LIST_HEAD(&ctx->list);
> =C2=A0	ctx->mdsthreshold =3D NULL;
> +	ctx->local_filp =3D NULL;
> =C2=A0	return ctx;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(alloc_nfs_open_context);
> @@ -1084,6 +1086,8 @@ static void __put_nfs_open_context(struct nfs_open_=
context *ctx, int is_sync)
> =C2=A0	nfs_sb_deactive(sb);
> =C2=A0	put_rpccred(rcu_dereference_protected(ctx->ll_cred, 1));
> =C2=A0	kfree(ctx->mdsthreshold);
> +	if (!IS_ERR_OR_NULL(ctx->local_filp))
> +		fput(ctx->local_filp);
> =C2=A0	kfree_rcu(ctx, rcu_head);
> =C2=A0}
> =C2=A0
> @@ -2495,6 +2499,7 @@ static int __init init_nfs_fs(void)
> =C2=A0	if (err)
> =C2=A0		goto out1;
> =C2=A0
> +	nfs_local_init();
> =C2=A0	err =3D register_nfs_fs();
> =C2=A0	if (err)
> =C2=A0		goto out0;
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 958c8de072e2..c933421eb6af 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -451,6 +451,59 @@ extern void nfs_set_cache_invalid(struct inode *inod=
e, unsigned long flags);
> =C2=A0extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
> =C2=A0extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode=
);
> =C2=A0
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +/* localio.c */
> +extern void nfs_local_init(void);
> +extern void nfs_local_disable(struct nfs_client *);
> +extern void nfs_local_probe(struct nfs_client *);
> +extern struct file *nfs_local_open_fh(struct nfs_client *, const struct =
cred *,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfs_fh *, const fmode_t);
> +extern struct file *nfs_local_file_open(struct nfs_client *clp,
> +					const struct cred *cred,
> +					struct nfs_fh *fh,
> +					struct nfs_open_context *ctx);
> +extern int nfs_local_doio(struct nfs_client *, struct file *,
> +			=C2=A0 struct nfs_pgio_header *,
> +			=C2=A0 const struct rpc_call_ops *);
> +extern int nfs_local_commit(struct file *, struct nfs_commit_data *,
> +			=C2=A0=C2=A0=C2=A0 const struct rpc_call_ops *, int);
> +extern bool nfs_server_is_local(const struct nfs_client *clp);
> +
> +#else
> +static inline void nfs_local_init(void) {}
> +static inline void nfs_local_disable(struct nfs_client *clp) {}
> +static inline void nfs_local_probe(struct nfs_client *clp) {}
> +static inline struct file *nfs_local_open_fh(struct nfs_client *clp,
> +					const struct cred *cred,
> +					struct nfs_fh *fh,
> +					const fmode_t mode)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +static inline struct file *nfs_local_file_open(struct nfs_client *clp,
> +					const struct cred *cred,
> +					struct nfs_fh *fh,
> +					struct nfs_open_context *ctx)
> +{
> +	return NULL;
> +}
> +static inline int nfs_local_doio(struct nfs_client *clp, struct file *fi=
lep,
> +				struct nfs_pgio_header *hdr,
> +				const struct rpc_call_ops *call_ops)
> +{
> +	return -EINVAL;
> +}
> +static inline int nfs_local_commit(struct file *filep, struct nfs_commit=
_data *data,
> +				const struct rpc_call_ops *call_ops, int how)
> +{
> +	return -EINVAL;
> +}
> +static inline bool nfs_server_is_local(const struct nfs_client *clp)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_NFS_LOCALIO */
> +
> =C2=A0/* super.c */
> =C2=A0extern const struct super_operations nfs_sops;
> =C2=A0bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflav=
or_t);
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> new file mode 100644
> index 000000000000..286cd0ded1b6
> --- /dev/null
> +++ b/fs/nfs/localio.c
> @@ -0,0 +1,797 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NFS client support for local clients to bypass network stack
> + *
> + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
> + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/vfs.h>
> +#include <linux/file.h>
> +#include <linux/inet.h>
> +#include <linux/sunrpc/addr.h>
> +#include <linux/inetdevice.h>
> +#include <net/addrconf.h>
> +#include <linux/module.h>
> +#include <linux/bvec.h>
> +
> +#include <linux/nfs.h>
> +#include <linux/nfs_fs.h>
> +#include <linux/nfs_xdr.h>
> +
> +#include "internal.h"
> +#include "pnfs.h"
> +#include "nfstrace.h"
> +
> +#define NFSDBG_FACILITY		NFSDBG_VFS
> +
> +extern int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct cred *cred,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct nfs_fh *nfs_fh, const fmo=
de_t fmode,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct file **pfilp);
> +/*
> + * The localio code needs to call into nfsd to do the filehandle -> stru=
ct path
> + * mapping, but cannot be statically linked, because that will make the =
nfs
> + * module depend on the nfsd module.
> + *
> + * Instead, do dynamic linking to the nfsd module. This way the nfs modu=
le
> + * will only hold a reference on nfsd when it's actually in use. This al=
so
> + * allows some sanity checking, like giving up on localio if nfsd isn't =
loaded.
> + */
> +
> +struct nfs_local_open_ctx {
> +	spinlock_t lock;
> +	nfs_to_nfsd_open_t open_f;
> +	atomic_t refcount;
> +};
> +
> +struct nfs_local_kiocb {
> +	struct kiocb		kiocb;
> +	struct bio_vec		*bvec;
> +	struct nfs_pgio_header	*hdr;
> +	struct work_struct	work;
> +};
> +
> +struct nfs_local_fsync_ctx {
> +	struct file		*filp;
> +	struct nfs_commit_data	*data;
> +	struct work_struct	work;
> +	struct kref		kref;
> +	struct completion	*done;
> +};
> +static void nfs_local_fsync_work(struct work_struct *work);
> +
> +/*
> + * We need to translate between nfs status return values and
> + * the local errno values which may not be the same.
> + */
> +static struct {
> +	__u32 stat;
> +	int errno;
> +} nfs_errtbl[] =3D {
> +	{ NFS4_OK,		0		},
> +	{ NFS4ERR_PERM,		-EPERM		},
> +	{ NFS4ERR_NOENT,	-ENOENT		},
> +	{ NFS4ERR_IO,		-EIO		},
> +	{ NFS4ERR_NXIO,		-ENXIO		},
> +	{ NFS4ERR_FBIG,		-E2BIG		},
> +	{ NFS4ERR_STALE,	-EBADF		},
> +	{ NFS4ERR_ACCESS,	-EACCES		},
> +	{ NFS4ERR_EXIST,	-EEXIST		},
> +	{ NFS4ERR_XDEV,		-EXDEV		},
> +	{ NFS4ERR_MLINK,	-EMLINK		},
> +	{ NFS4ERR_NOTDIR,	-ENOTDIR	},
> +	{ NFS4ERR_ISDIR,	-EISDIR		},
> +	{ NFS4ERR_INVAL,	-EINVAL		},
> +	{ NFS4ERR_FBIG,		-EFBIG		},
> +	{ NFS4ERR_NOSPC,	-ENOSPC		},
> +	{ NFS4ERR_ROFS,		-EROFS		},
> +	{ NFS4ERR_NAMETOOLONG,	-ENAMETOOLONG	},
> +	{ NFS4ERR_NOTEMPTY,	-ENOTEMPTY	},
> +	{ NFS4ERR_DQUOT,	-EDQUOT		},
> +	{ NFS4ERR_STALE,	-ESTALE		},
> +	{ NFS4ERR_STALE,	-EOPENSTALE	},
> +	{ NFS4ERR_DELAY,	-ETIMEDOUT	},
> +	{ NFS4ERR_DELAY,	-ERESTARTSYS	},
> +	{ NFS4ERR_DELAY,	-EAGAIN		},
> +	{ NFS4ERR_DELAY,	-ENOMEM		},
> +	{ NFS4ERR_IO,		-ETXTBSY	},
> +	{ NFS4ERR_IO,		-EBUSY		},
> +	{ NFS4ERR_BADHANDLE,	-EBADHANDLE	},
> +	{ NFS4ERR_BAD_COOKIE,	-EBADCOOKIE	},
> +	{ NFS4ERR_NOTSUPP,	-EOPNOTSUPP	},
> +	{ NFS4ERR_TOOSMALL,	-ETOOSMALL	},
> +	{ NFS4ERR_SERVERFAULT,	-ESERVERFAULT	},
> +	{ NFS4ERR_SERVERFAULT,	-ENFILE		},
> +	{ NFS4ERR_IO,		-EREMOTEIO	},
> +	{ NFS4ERR_IO,		-EUCLEAN	},
> +	{ NFS4ERR_PERM,		-ENOKEY		},
> +	{ NFS4ERR_BADTYPE,	-EBADTYPE	},
> +	{ NFS4ERR_SYMLINK,	-ELOOP		},
> +	{ NFS4ERR_DEADLOCK,	-EDEADLK	},
> +};
> +
> +/*
> + * Convert an NFS error code to a local one.
> + * This one is used jointly by NFSv2 and NFSv3.
> + */
> +static __u32
> +nfs4errno(int errno)
> +{
> +	unsigned int i;
> +	for (i =3D 0; i < ARRAY_SIZE(nfs_errtbl); i++) {
> +		if (nfs_errtbl[i].errno =3D=3D errno)
> +			return nfs_errtbl[i].stat;
> +	}
> +	/* If we cannot translate the error, the recovery routines should
> +	 * handle it.
> +	 * Note: remaining NFSv4 error codes have values > 10000, so should
> +	 * not conflict with native Linux error codes.
> +	 */
> +	return NFS4ERR_SERVERFAULT;
> +}
> +
> +static struct nfs_local_open_ctx __local_open_ctx __read_mostly;
> +
> +static bool localio_enabled __read_mostly =3D true;
> +module_param(localio_enabled, bool, 0644);
> +
> +bool nfs_server_is_local(const struct nfs_client *clp)
> +{
> +	return test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags) !=3D 0 &&
> +		localio_enabled;
> +}
> +EXPORT_SYMBOL_GPL(nfs_server_is_local);
> +
> +void
> +nfs_local_init(void)
> +{
> +	struct nfs_local_open_ctx *ctx =3D &__local_open_ctx;
> +
> +	ctx->open_f =3D NULL;
> +	spin_lock_init(&ctx->lock);
> +	atomic_set(&ctx->refcount, 0);
> +}
> +
> +static bool
> +nfs_local_get_lookup_ctx(void)
> +{
> +	struct nfs_local_open_ctx *ctx =3D &__local_open_ctx;
> +	nfs_to_nfsd_open_t fn =3D NULL;
> +
> +	spin_lock(&ctx->lock);
> +	if (ctx->open_f =3D=3D NULL) {
> +		spin_unlock(&ctx->lock);
> +
> +		fn =3D symbol_request(nfsd_open_local_fh);
> +		if (!fn)
> +			return false;
> +
> +		spin_lock(&ctx->lock);
> +		/* catch race */
> +		if (ctx->open_f =3D=3D NULL) {
> +			ctx->open_f =3D fn;
> +			fn =3D NULL;
> +		}
> +	}
> +	atomic_inc(&ctx->refcount);
> +	spin_unlock(&ctx->lock);
> +	if (fn)
> +		symbol_put(nfsd_open_local_fh);
> +	return true;
> +}
> +
> +static void
> +nfs_local_put_lookup_ctx(void)
> +{
> +	struct nfs_local_open_ctx *ctx =3D &__local_open_ctx;
> +	nfs_to_nfsd_open_t fn;
> +
> +	if (atomic_dec_and_lock(&ctx->refcount, &ctx->lock)) {
> +		fn =3D ctx->open_f;
> +		ctx->open_f =3D NULL;
> +		spin_unlock(&ctx->lock);
> +		if (fn)
> +			symbol_put(nfsd_open_local_fh);
> +	}
> +}
> +
> +/*
> + * nfs_local_enable - attempt to enable local i/o for an nfs_client
> + */
> +static void nfs_local_enable(struct nfs_client *clp)
> +{
> +	if (nfs_local_get_lookup_ctx()) {
> +		set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
> +		trace_nfs_local_enable(clp);
> +	}
> +}
> +
> +/*
> + * nfs_local_disable - disable local i/o for an nfs_client
> + */
> +void
> +nfs_local_disable(struct nfs_client *clp)
> +{
> +	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
> +		trace_nfs_local_disable(clp);
> +		nfs_local_put_lookup_ctx();
> +	}
> +}
> +
> +/*
> + * nfs_local_probe - probe local i/o support for an nfs_client
> + */
> +void
> +nfs_local_probe(struct nfs_client *clp)
> +{
> +	bool enable =3D false;
> +
> +	if (enable)
> +		nfs_local_enable(clp);
> +}
> +EXPORT_SYMBOL_GPL(nfs_local_probe);
> +
> +/*
> + * nfs_local_open_fh - open a local filehandle
> + *
> + * Returns a pointer to a struct file or an ERR_PTR
> + */
> +struct file *
> +nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
> +		=C2=A0 struct nfs_fh *fh, const fmode_t mode)
> +{
> +	struct nfs_local_open_ctx *ctx =3D &__local_open_ctx;
> +	struct file *filp;
> +	int status;
> +
> +	if (mode & ~(FMODE_READ | FMODE_WRITE))
> +		return ERR_PTR(-EINVAL);
> +
> +	status =3D ctx->open_f(clp->cl_rpcclient, cred, fh, mode, &filp);
> +	if (status < 0) {
> +		dprintk("%s: open local file failed error=3D%d\n",
> +				__func__, status);
> +		trace_nfs_local_open_fh(fh, mode, status);
> +		switch (status) {
> +		case -ENXIO:
> +			nfs_local_disable(clp);
> +			fallthrough;
> +		case -ETIMEDOUT:
> +			status =3D -EAGAIN;
> +		}
> +		filp =3D ERR_PTR(status);
> +	}
> +	return filp;
> +}
> +EXPORT_SYMBOL_GPL(nfs_local_open_fh);
> +
> +static struct bio_vec *
> +nfs_bvec_alloc_and_import_pagevec(struct page **pagevec,
> +		unsigned int npages, gfp_t flags)
> +{
> +	struct bio_vec *bvec, *p;
> +
> +	bvec =3D kmalloc_array(npages, sizeof(*bvec), flags);
> +	if (bvec !=3D NULL) {
> +		for (p =3D bvec; npages > 0; p++, pagevec++, npages--) {
> +			p->bv_page =3D *pagevec;
> +			p->bv_len =3D PAGE_SIZE;
> +			p->bv_offset =3D 0;
> +		}
> +	}
> +	return bvec;
> +}
> +
> +static void
> +nfs_local_iocb_free(struct nfs_local_kiocb *iocb)
> +{
> +	kfree(iocb->bvec);
> +	kfree(iocb);
> +}
> +
> +static struct nfs_local_kiocb *
> +nfs_local_iocb_alloc(struct nfs_pgio_header *hdr, struct file *filp,
> +		gfp_t flags)
> +{
> +	struct nfs_local_kiocb *iocb;
> +
> +	iocb =3D kmalloc(sizeof(*iocb), flags);
> +	if (iocb =3D=3D NULL)
> +		return NULL;
> +	iocb->bvec =3D nfs_bvec_alloc_and_import_pagevec(hdr->page_array.pageve=
c,
> +			hdr->page_array.npages, flags);
> +	if (iocb->bvec =3D=3D NULL) {
> +		kfree(iocb);
> +		return NULL;
> +	}
> +	init_sync_kiocb(&iocb->kiocb, filp);
> +	iocb->kiocb.ki_pos =3D hdr->args.offset;
> +	iocb->hdr =3D hdr;
> +	/* FIXME: NFS_IOHDR_ODIRECT isn't ever set */
> +	if (test_bit(NFS_IOHDR_ODIRECT, &hdr->flags))
> +		iocb->kiocb.ki_flags |=3D IOCB_DIRECT|IOCB_DSYNC;
> +	iocb->kiocb.ki_flags &=3D ~IOCB_APPEND;
> +	return iocb;
> +}
> +
> +static void
> +nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, in=
t dir)
> +{
> +	struct nfs_pgio_header *hdr =3D iocb->hdr;
> +
> +	if (hdr->args.pgbase !=3D 0) {
> +		iov_iter_bvec(i, dir, iocb->bvec,
> +				hdr->page_array.npages,
> +				hdr->args.count + hdr->args.pgbase);
> +		iov_iter_advance(i, hdr->args.pgbase);
> +	} else
> +		iov_iter_bvec(i, dir, iocb->bvec,
> +				hdr->page_array.npages, hdr->args.count);
> +}
> +
> +static void
> +nfs_local_hdr_release(struct nfs_pgio_header *hdr,
> +		const struct rpc_call_ops *call_ops)
> +{
> +	call_ops->rpc_call_done(&hdr->task, hdr);
> +	call_ops->rpc_release(hdr);
> +}
> +
> +static void
> +nfs_local_pgio_init(struct nfs_pgio_header *hdr,
> +		const struct rpc_call_ops *call_ops)
> +{
> +	hdr->task.tk_ops =3D call_ops;
> +	if (!hdr->task.tk_start)
> +		hdr->task.tk_start =3D ktime_get();
> +}
> +
> +static void
> +nfs_local_pgio_done(struct nfs_pgio_header *hdr, long status)
> +{
> +	if (status >=3D 0) {
> +		hdr->res.count =3D status;
> +		hdr->res.op_status =3D NFS4_OK;
> +		hdr->task.tk_status =3D 0;
> +	} else {
> +		hdr->res.op_status =3D nfs4errno(status);
> +		hdr->task.tk_status =3D status;
> +	}
> +}
> +
> +static void
> +nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
> +{
> +	struct nfs_pgio_header *hdr =3D iocb->hdr;
> +
> +	fput(iocb->kiocb.ki_filp);
> +	nfs_local_iocb_free(iocb);
> +	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
> +}
> +
> +static void
> +nfs_local_read_aio_complete_work(struct work_struct *work)
> +{
> +	struct nfs_local_kiocb *iocb =3D container_of(work,
> +			struct nfs_local_kiocb, work);
> +
> +	nfs_local_pgio_release(iocb);
> +}
> +
> +/*
> + * Complete the I/O from iocb->kiocb.ki_complete()
> + *
> + * Note that this function can be called from a bottom half context,
> + * hence we need to queue the fput() etc to a workqueue
> + */
> +static void
> +nfs_local_pgio_complete(struct nfs_local_kiocb *iocb)
> +{
> +	queue_work(nfsiod_workqueue, &iocb->work);
> +}
> +
> +static void
> +nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
> +{
> +	struct nfs_pgio_header *hdr =3D iocb->hdr;
> +	struct file *filp =3D iocb->kiocb.ki_filp;
> +
> +	nfs_local_pgio_done(hdr, status);
> +
> +	if (hdr->res.count !=3D hdr->args.count ||
> +	=C2=A0=C2=A0=C2=A0 hdr->args.offset + hdr->res.count >=3D i_size_read(f=
ile_inode(filp)))
> +		hdr->res.eof =3D true;
> +
> +	dprintk("%s: read %ld bytes eof %d.\n", __func__,
> +			status > 0 ? status : 0, hdr->res.eof);
> +}
> +
> +static void
> +nfs_local_read_aio_complete(struct kiocb *kiocb, long ret)
> +{
> +	struct nfs_local_kiocb *iocb =3D container_of(kiocb,
> +			struct nfs_local_kiocb, kiocb);
> +
> +	nfs_local_read_done(iocb, ret);
> +	nfs_local_pgio_complete(iocb);
> +}
> +
> +static int
> +nfs_do_local_read(struct nfs_pgio_header *hdr, struct file *filp,
> +		const struct rpc_call_ops *call_ops)
> +{
> +	struct nfs_local_kiocb *iocb;
> +	struct iov_iter iter;
> +	ssize_t status;
> +
> +	dprintk("%s: vfs_read count=3D%u pos=3D%llu\n",
> +		__func__, hdr->args.count, hdr->args.offset);
> +
> +	iocb =3D nfs_local_iocb_alloc(hdr, filp, GFP_KERNEL);
> +	if (iocb =3D=3D NULL)
> +		return -ENOMEM;
> +	nfs_local_iter_init(&iter, iocb, READ);
> +
> +	nfs_local_pgio_init(hdr, call_ops);
> +	hdr->res.eof =3D false;
> +
> +	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> +		INIT_WORK(&iocb->work, nfs_local_read_aio_complete_work);
> +		iocb->kiocb.ki_complete =3D nfs_local_read_aio_complete;
> +	}
> +
> +	status =3D filp->f_op->read_iter(&iocb->kiocb, &iter);
> +	if (status !=3D -EIOCBQUEUED) {
> +		nfs_local_read_done(iocb, status);
> +		nfs_local_pgio_release(iocb);
> +	}
> +	return 0;
> +}
> +
> +static void
> +nfs_copy_boot_verifier(struct nfs_write_verifier *verifier, struct inode=
 *inode)
> +{
> +	struct nfs_client *clp =3D NFS_SERVER(inode)->nfs_client;
> +	u32 *verf =3D (u32 *)verifier->data;
> +	int seq =3D 0;
> +
> +	do {
> +		read_seqbegin_or_lock(&clp->cl_boot_lock, &seq);
> +		verf[0] =3D (u32)clp->cl_nfssvc_boot.tv_sec;
> +		verf[1] =3D (u32)clp->cl_nfssvc_boot.tv_nsec;
> +	} while (need_seqretry(&clp->cl_boot_lock, seq));
> +	done_seqretry(&clp->cl_boot_lock, seq);
> +}
> +
> +static void
> +nfs_reset_boot_verifier(struct inode *inode)
> +{
> +	struct nfs_client *clp =3D NFS_SERVER(inode)->nfs_client;
> +
> +	write_seqlock(&clp->cl_boot_lock);
> +	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
> +	write_sequnlock(&clp->cl_boot_lock);
> +}
> +
> +static void
> +nfs_set_local_verifier(struct inode *inode,
> +		struct nfs_writeverf *verf,
> +		enum nfs3_stable_how how)
> +{
> +
> +	nfs_copy_boot_verifier(&verf->verifier, inode);
> +	verf->committed =3D how;
> +}
> +
> +static void
> +nfs_get_vfs_attr(struct file *filp, struct nfs_fattr *fattr)
> +{
> +	struct kstat stat;
> +
> +	if (fattr !=3D NULL && vfs_getattr(&filp->f_path, &stat,
> +					 STATX_INO |
> +					 STATX_ATIME |
> +					 STATX_MTIME |
> +					 STATX_CTIME |
> +					 STATX_SIZE |
> +					 STATX_BLOCKS,
> +					 AT_STATX_SYNC_AS_STAT) =3D=3D 0) {
> +		fattr->valid =3D NFS_ATTR_FATTR_FILEID |
> +			NFS_ATTR_FATTR_CHANGE |
> +			NFS_ATTR_FATTR_SIZE |
> +			NFS_ATTR_FATTR_ATIME |
> +			NFS_ATTR_FATTR_MTIME |
> +			NFS_ATTR_FATTR_CTIME |
> +			NFS_ATTR_FATTR_SPACE_USED;
> +		fattr->fileid =3D stat.ino;
> +		fattr->size =3D stat.size;
> +		fattr->atime =3D stat.atime;
> +		fattr->mtime =3D stat.mtime;
> +		fattr->ctime =3D stat.ctime;
> +		fattr->change_attr =3D nfs_timespec_to_change_attr(&fattr->ctime);
> +		fattr->du.nfs3.used =3D stat.blocks << 9;
> +	}
> +}
> +
> +static void
> +nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
> +{
> +	struct nfs_pgio_header *hdr =3D iocb->hdr;
> +
> +	dprintk("%s: wrote %ld bytes.\n", __func__, status > 0 ? status : 0);
> +
> +	/* Handle short writes as if they are ENOSPC */
> +	if (status > 0 && status < hdr->args.count) {
> +		hdr->mds_offset +=3D status;
> +		hdr->args.offset +=3D status;
> +		hdr->args.pgbase +=3D status;
> +		hdr->args.count -=3D status;
> +		nfs_set_pgio_error(hdr, -ENOSPC, hdr->args.offset);
> +		status =3D -ENOSPC;
> +	}
> +	if (status < 0)
> +		nfs_reset_boot_verifier(hdr->inode);
> +	nfs_local_pgio_done(hdr, status);
> +}
> +
> +static void
> +nfs_local_write_aio_complete_work(struct work_struct *work)
> +{
> +	struct nfs_local_kiocb *iocb =3D container_of(work,
> +			struct nfs_local_kiocb, work);
> +
> +	nfs_get_vfs_attr(iocb->kiocb.ki_filp, iocb->hdr->res.fattr);
> +	nfs_local_pgio_release(iocb);
> +}
> +
> +static void
> +nfs_local_write_aio_complete(struct kiocb *kiocb, long ret)
> +{
> +	struct nfs_local_kiocb *iocb =3D container_of(kiocb,
> +			struct nfs_local_kiocb, kiocb);
> +
> +	nfs_local_write_done(iocb, ret);
> +	nfs_local_pgio_complete(iocb);
> +}
> +
> +static int
> +nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
> +		const struct rpc_call_ops *call_ops)
> +{
> +	struct nfs_local_kiocb *iocb;
> +	struct iov_iter iter;
> +	ssize_t status;
> +
> +	dprintk("%s: vfs_write count=3D%u pos=3D%llu %s\n",
> +		__func__, hdr->args.count, hdr->args.offset,
> +		(hdr->args.stable =3D=3D NFS_UNSTABLE) ?=C2=A0 "unstable" : "stable");
> +
> +	iocb =3D nfs_local_iocb_alloc(hdr, filp, GFP_NOIO);
> +	if (iocb =3D=3D NULL)
> +		return -ENOMEM;
> +	nfs_local_iter_init(&iter, iocb, WRITE);
> +
> +	switch (hdr->args.stable) {
> +	default:
> +		break;
> +	case NFS_DATA_SYNC:
> +		iocb->kiocb.ki_flags |=3D IOCB_DSYNC;
> +		break;
> +	case NFS_FILE_SYNC:
> +		iocb->kiocb.ki_flags |=3D IOCB_DSYNC|IOCB_SYNC;
> +	}
> +	nfs_local_pgio_init(hdr, call_ops);
> +
> +	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> +		INIT_WORK(&iocb->work, nfs_local_write_aio_complete_work);
> +		iocb->kiocb.ki_complete =3D nfs_local_write_aio_complete;
> +	}
> +
> +	nfs_set_local_verifier(hdr->inode, hdr->res.verf, hdr->args.stable);
> +
> +	file_start_write(filp);
> +	status =3D filp->f_op->write_iter(&iocb->kiocb, &iter);
> +	file_end_write(filp);
> +	if (status !=3D -EIOCBQUEUED) {
> +		nfs_local_write_done(iocb, status);
> +		nfs_get_vfs_attr(filp, hdr->res.fattr);
> +		nfs_local_pgio_release(iocb);
> +	}
> +	return 0;
> +}
> +
> +static struct file *
> +nfs_local_file_open_cached(struct nfs_client *clp, const struct cred *cr=
ed,
> +			=C2=A0=C2=A0 struct nfs_fh *fh, struct nfs_open_context *ctx)
> +{
> +	struct file *filp =3D ctx->local_filp;
> +
> +	if (!filp) {
> +		struct file *new =3D nfs_local_open_fh(clp, cred, fh, ctx->mode);
> +		if (IS_ERR_OR_NULL(new))
> +			return NULL;
> +		/* try to put this one in the slot */
> +		filp =3D cmpxchg(&ctx->local_filp, NULL, new);
> +		if (filp !=3D NULL)
> +			fput(new);
> +		else
> +			filp =3D new;
> +	}
> +	return get_file(filp);
> +}
> +
> +struct file *
> +nfs_local_file_open(struct nfs_client *clp, const struct cred *cred,
> +		=C2=A0=C2=A0=C2=A0 struct nfs_fh *fh, struct nfs_open_context *ctx)
> +{
> +	if (!nfs_server_is_local(clp))
> +		return NULL;
> +	return nfs_local_file_open_cached(clp, cred, fh, ctx);
> +}
> +
> +int
> +nfs_local_doio(struct nfs_client *clp, struct file *filp,
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfs_pgio_header *hdr,
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct rpc_call_ops *call_op=
s)
> +{
> +	int status =3D 0;
> +
> +	if (!hdr->args.count)
> +		goto out_fput;
> +	/* Don't support filesystems without read_iter/write_iter */
> +	if (!filp->f_op->read_iter || !filp->f_op->write_iter) {
> +		nfs_local_disable(clp);
> +		status =3D -EAGAIN;
> +		goto out_fput;
> +	}
> +
> +	switch (hdr->rw_mode) {
> +	case FMODE_READ:
> +		status =3D nfs_do_local_read(hdr, filp, call_ops);
> +		break;
> +	case FMODE_WRITE:
> +		status =3D nfs_do_local_write(hdr, filp, call_ops);
> +		break;
> +	default:
> +		dprintk("%s: invalid mode: %d\n", __func__,
> +			hdr->rw_mode);
> +		status =3D -EINVAL;
> +	}
> +out_fput:
> +	if (status !=3D 0) {
> +		fput(filp);
> +		hdr->task.tk_status =3D status;
> +		nfs_local_hdr_release(hdr, call_ops);
> +	}
> +	return status;
> +}
> +
> +static void
> +nfs_local_init_commit(struct nfs_commit_data *data,
> +		const struct rpc_call_ops *call_ops)
> +{
> +	data->task.tk_ops =3D call_ops;
> +}
> +
> +static int
> +nfs_local_run_commit(struct file *filp, struct nfs_commit_data *data)
> +{
> +	loff_t start =3D data->args.offset;
> +	loff_t end =3D LLONG_MAX;
> +
> +	if (data->args.count > 0) {
> +		end =3D start + data->args.count - 1;
> +		if (end < start)
> +			end =3D LLONG_MAX;
> +	}
> +
> +	dprintk("%s: commit %llu - %llu\n", __func__, start, end);
> +	return vfs_fsync_range(filp, start, end, 0);
> +}
> +
> +static void
> +nfs_local_commit_done(struct nfs_commit_data *data, int status)
> +{
> +	if (status >=3D 0) {
> +		nfs_set_local_verifier(data->inode,
> +				data->res.verf,
> +				NFS_FILE_SYNC);
> +		data->res.op_status =3D NFS4_OK;
> +		data->task.tk_status =3D 0;
> +	} else {
> +		nfs_reset_boot_verifier(data->inode);
> +		data->res.op_status =3D nfs4errno(status);
> +		data->task.tk_status =3D status;
> +	}
> +}
> +
> +static void
> +nfs_local_release_commit_data(struct file *filp,
> +		struct nfs_commit_data *data,
> +		const struct rpc_call_ops *call_ops)
> +{
> +	fput(filp);
> +	call_ops->rpc_call_done(&data->task, data);
> +	call_ops->rpc_release(data);
> +}
> +
> +static struct nfs_local_fsync_ctx *
> +nfs_local_fsync_ctx_alloc(struct nfs_commit_data *data, struct file *fil=
p,
> +		gfp_t flags)
> +{
> +	struct nfs_local_fsync_ctx *ctx =3D kmalloc(sizeof(*ctx), flags);
> +
> +	if (ctx !=3D NULL) {
> +		ctx->filp =3D filp;
> +		ctx->data =3D data;
> +		INIT_WORK(&ctx->work, nfs_local_fsync_work);
> +		kref_init(&ctx->kref);
> +		ctx->done =3D NULL;
> +	}
> +	return ctx;
> +}
> +
> +static void
> +nfs_local_fsync_ctx_kref_free(struct kref *kref)
> +{
> +	kfree(container_of(kref, struct nfs_local_fsync_ctx, kref));
> +}
> +
> +static void
> +nfs_local_fsync_ctx_put(struct nfs_local_fsync_ctx *ctx)
> +{
> +	kref_put(&ctx->kref, nfs_local_fsync_ctx_kref_free);
> +}
> +
> +static void
> +nfs_local_fsync_ctx_free(struct nfs_local_fsync_ctx *ctx)
> +{
> +	nfs_local_release_commit_data(ctx->filp, ctx->data,
> +			ctx->data->task.tk_ops);
> +	nfs_local_fsync_ctx_put(ctx);
> +}
> +
> +static void
> +nfs_local_fsync_work(struct work_struct *work)
> +{
> +	struct nfs_local_fsync_ctx *ctx;
> +	int status;
> +
> +	ctx =3D container_of(work, struct nfs_local_fsync_ctx, work);
> +
> +	status =3D nfs_local_run_commit(ctx->filp, ctx->data);
> +	nfs_local_commit_done(ctx->data, status);
> +	if (ctx->done !=3D NULL)
> +		complete(ctx->done);
> +	nfs_local_fsync_ctx_free(ctx);
> +}
> +
> +int
> +nfs_local_commit(struct file *filp, struct nfs_commit_data *data,
> +		 const struct rpc_call_ops *call_ops, int how)
> +{
> +	struct nfs_local_fsync_ctx *ctx;
> +
> +	ctx =3D nfs_local_fsync_ctx_alloc(data, filp, GFP_KERNEL);
> +	if (!ctx) {
> +		nfs_local_commit_done(data, -ENOMEM);
> +		nfs_local_release_commit_data(filp, data, call_ops);
> +		return -ENOMEM;
> +	}
> +
> +	nfs_local_init_commit(data, call_ops);
> +	kref_get(&ctx->kref);
> +	if (how & FLUSH_SYNC) {
> +		DECLARE_COMPLETION_ONSTACK(done);
> +		ctx->done =3D &done;
> +		queue_work(nfsiod_workqueue, &ctx->work);
> +		wait_for_completion(&done);
> +	} else
> +		queue_work(nfsiod_workqueue, &ctx->work);
> +	nfs_local_fsync_ctx_put(ctx);
> +	return 0;
> +}
> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> index 1e710654af11..95a2c19a9172 100644
> --- a/fs/nfs/nfstrace.h
> +++ b/fs/nfs/nfstrace.h
> @@ -1681,6 +1681,67 @@ TRACE_EVENT(nfs_mount_path,
> =C2=A0	TP_printk("path=3D'%s'", __get_str(path))
> =C2=A0);
> =C2=A0
> +TRACE_EVENT(nfs_local_open_fh,
> +		TP_PROTO(
> +			const struct nfs_fh *fh,
> +			fmode_t fmode,
> +			int error
> +		),
> +
> +		TP_ARGS(fh, fmode, error),
> +
> +		TP_STRUCT__entry(
> +			__field(int, error)
> +			__field(u32, fhandle)
> +			__field(unsigned int, fmode)
> +		),
> +
> +		TP_fast_assign(
> +			__entry->error =3D error;
> +			__entry->fhandle =3D nfs_fhandle_hash(fh);
> +			__entry->fmode =3D (__force unsigned int)fmode;
> +		),
> +
> +		TP_printk(
> +			"error=3D%d fhandle=3D0x%08x mode=3D%s",
> +			__entry->error,
> +			__entry->fhandle,
> +			show_fs_fmode_flags(__entry->fmode)
> +		)
> +);
> +
> +DECLARE_EVENT_CLASS(nfs_local_client_event,
> +		TP_PROTO(
> +			const struct nfs_client *clp
> +		),
> +
> +		TP_ARGS(clp),
> +
> +		TP_STRUCT__entry(
> +			__field(unsigned int, protocol)
> +			__string(server, clp->cl_hostname)
> +		),
> +
> +		TP_fast_assign(
> +			__entry->protocol =3D clp->rpc_ops->version;
> +			__assign_str(server);
> +		),
> +
> +		TP_printk(
> +			"server=3D%s NFSv%u", __get_str(server), __entry->protocol
> +		)
> +);
> +
> +#define DEFINE_NFS_LOCAL_CLIENT_EVENT(name) \
> +	DEFINE_EVENT(nfs_local_client_event, name, \
> +			TP_PROTO( \
> +				const struct nfs_client *clp \
> +			), \
> +			TP_ARGS(clp))
> +
> +DEFINE_NFS_LOCAL_CLIENT_EVENT(nfs_local_enable);
> +DEFINE_NFS_LOCAL_CLIENT_EVENT(nfs_local_disable);
> +
> =C2=A0DECLARE_EVENT_CLASS(nfs_xdr_event,
> =C2=A0		TP_PROTO(
> =C2=A0			const struct xdr_stream *xdr,
> diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> index 57d62db3be5b..b08420b8e664 100644
> --- a/fs/nfs/pagelist.c
> +++ b/fs/nfs/pagelist.c
> @@ -879,6 +879,9 @@ int nfs_initiate_pgio(struct nfs_pageio_descriptor *d=
esc,
> =C2=A0		hdr->args.count,
> =C2=A0		(unsigned long long)hdr->args.offset);
> =C2=A0
> +	if (localio)
> +		return nfs_local_doio(clp, localio, hdr, call_ops);
> +
> =C2=A0	task =3D rpc_run_task(&task_setup_data);
> =C2=A0	if (IS_ERR(task))
> =C2=A0		return PTR_ERR(task);
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 267bed2a4ceb..b29b0fd5431f 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -1700,6 +1700,9 @@ int nfs_initiate_commit(struct rpc_clnt *clnt, stru=
ct nfs_commit_data *data,
> =C2=A0
> =C2=A0	dprintk("NFS: initiated commit call\n");
> =C2=A0
> +	if (localio)
> +		return nfs_local_commit(localio, data, call_ops, how);
> +
> =C2=A0	task =3D rpc_run_task(&task_setup_data);
> =C2=A0	if (IS_ERR(task))
> =C2=A0		return PTR_ERR(task);
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index b8736a82e57c..78b421778a79 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) +=3D nfs4layouts.o
> =C2=A0nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) +=3D blocklayout.o blocklayoutxdr.o
> =C2=A0nfsd-$(CONFIG_NFSD_SCSILAYOUT) +=3D blocklayout.o blocklayoutxdr.o
> =C2=A0nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) +=3D flexfilelayout.o flexfilela=
youtxdr.o
> +nfsd-$(CONFIG_NFSD_LOCALIO) +=3D localio.o
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index ad9083ca144b..99631fa56662 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -52,7 +52,7 @@
> =C2=A0#define NFSD_FILE_CACHE_UP		=C2=A0=C2=A0=C2=A0=C2=A0 (0)
> =C2=A0
> =C2=A0/* We only care about NFSD_MAY_READ/WRITE for this cache */
> -#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
> +#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALI=
O)
> =C2=A0
> =C2=A0static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
> =C2=A0static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> new file mode 100644
> index 000000000000..6e2918e76f49
> --- /dev/null
> +++ b/fs/nfsd/localio.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NFS server support for local clients to bypass network stack
> + *
> + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
> + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> + */
> +
> +#include <linux/exportfs.h>
> +#include <linux/sunrpc/svcauth_gss.h>
> +#include <linux/sunrpc/clnt.h>
> +#include <linux/nfs.h>
> +#include <linux/string.h>
> +
> +#include "nfsd.h"
> +#include "vfs.h"
> +#include "netns.h"
> +#include "filecache.h"
> +
> +#define NFSDDBG_FACILITY		NFSDDBG_FH
> +
> +/*
> + * We need to translate between nfs status return values and
> + * the local errno values which may not be the same.
> + * - duplicated from fs/nfs/nfs2xdr.c to avoid needless bloat of
> + *=C2=A0=C2=A0 all compiled nfs objects if it were in include/linux/nfs.=
h
> + */
> +static const struct {
> +	int stat;
> +	int errno;
> +} nfs_common_errtbl[] =3D {
> +	{ NFS_OK,		0		},
> +	{ NFSERR_PERM,		-EPERM		},
> +	{ NFSERR_NOENT,		-ENOENT		},
> +	{ NFSERR_IO,		-EIO		},
> +	{ NFSERR_NXIO,		-ENXIO		},
> +/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
> +	{ NFSERR_ACCES,		-EACCES		},
> +	{ NFSERR_EXIST,		-EEXIST		},
> +	{ NFSERR_XDEV,		-EXDEV		},
> +	{ NFSERR_NODEV,		-ENODEV		},
> +	{ NFSERR_NOTDIR,	-ENOTDIR	},
> +	{ NFSERR_ISDIR,		-EISDIR		},
> +	{ NFSERR_INVAL,		-EINVAL		},
> +	{ NFSERR_FBIG,		-EFBIG		},
> +	{ NFSERR_NOSPC,		-ENOSPC		},
> +	{ NFSERR_ROFS,		-EROFS		},
> +	{ NFSERR_MLINK,		-EMLINK		},
> +	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
> +	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
> +	{ NFSERR_DQUOT,		-EDQUOT		},
> +	{ NFSERR_STALE,		-ESTALE		},
> +	{ NFSERR_REMOTE,	-EREMOTE	},
> +#ifdef EWFLUSH
> +	{ NFSERR_WFLUSH,	-EWFLUSH	},
> +#endif
> +	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
> +	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
> +	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
> +	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
> +	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
> +	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
> +	{ NFSERR_BADTYPE,	-EBADTYPE	},
> +	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
> +	{ -1,			-EIO		}
> +};
> +
> +/**
> + * nfs_stat_to_errno - convert an NFS status code to a local errno
> + * @status: NFS status code to convert
> + *
> + * Returns a local errno value, or -EIO if the NFS status code is
> + * not recognized.=C2=A0 This function is used jointly by NFSv2 and NFSv=
3.
> + */
> +static inline int nfs_stat_to_errno(enum nfs_stat status)
> +{
> +	int i;
> +
> +	for (i =3D 0; nfs_common_errtbl[i].stat !=3D -1; i++) {
> +		if (nfs_common_errtbl[i].stat =3D=3D (int)status)
> +			return nfs_common_errtbl[i].errno;
> +	}
> +	return nfs_common_errtbl[i].errno;
> +}
> +

Honestly, this is a little large for an inline. It wouldn't hurt to
just make this non-static and only have the table in one place.
Consider that a nit though, I don't feel strongly about it.

> +static void
> +nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
> +{
> +	if (rqstp->rq_client)
> +		auth_domain_put(rqstp->rq_client);
> +	if (rqstp->rq_cred.cr_group_info)
> +		put_group_info(rqstp->rq_cred.cr_group_info);
> +	/* rpcauth_map_to_svc_cred_local() clears cr_principal */
> +	WARN_ON_ONCE(rqstp->rq_cred.cr_principal !=3D NULL);
> +	kfree(rqstp->rq_xprt);
> +	kfree(rqstp);
> +}
> +
> +static struct svc_rqst *
> +nfsd_local_fakerqst_create(struct rpc_clnt *rpc_clnt, const struct cred =
*cred)
> +{
> +	struct svc_rqst *rqstp;
> +	struct net *net =3D rpc_net_ns(rpc_clnt);
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	int status;
> +
> +	/* FIXME: not running in nfsd context, must get reference on nfsd_serv =
*/
> +	if (unlikely(!READ_ONCE(nn->nfsd_serv))) {
> +		dprintk("%s: localio denied. Server not running\n", __func__);
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	rqstp =3D kzalloc(sizeof(*rqstp), GFP_KERNEL);
> +	if (!rqstp)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rqstp->rq_xprt =3D kzalloc(sizeof(*rqstp->rq_xprt), GFP_KERNEL);
> +	if (!rqstp->rq_xprt) {
> +		status =3D -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	rqstp->rq_xprt->xpt_net =3D net;
> +	__set_bit(RQ_SECURE, &rqstp->rq_flags);
> +	rqstp->rq_proc =3D 1;
> +	rqstp->rq_vers =3D 3;
> +	rqstp->rq_prot =3D IPPROTO_TCP;
> +	rqstp->rq_server =3D nn->nfsd_serv;
> +
> +	/* Note: we're connecting to ourself, so source addr =3D=3D peer addr *=
/
> +	rqstp->rq_addrlen =3D rpc_peeraddr(rpc_clnt,
> +			(struct sockaddr *)&rqstp->rq_addr,
> +			sizeof(rqstp->rq_addr));
> +
> +	rpcauth_map_to_svc_cred_local(rpc_clnt->cl_auth, cred, &rqstp->rq_cred)=
;
> +
> +	/*
> +	 * set up enough for svcauth_unix_set_client to be able to wait
> +	 * for the cache downcall. Note that we do _not_ want to allow the
> +	 * request to be deferred for later revisit since this rqst and xprt
> +	 * are not set up to run inside of the normal svc_rqst engine.
> +	 */
> +	INIT_LIST_HEAD(&rqstp->rq_xprt->xpt_deferred);
> +	kref_init(&rqstp->rq_xprt->xpt_ref);
> +	spin_lock_init(&rqstp->rq_xprt->xpt_lock);
> +	rqstp->rq_chandle.thread_wait =3D 5 * HZ;
> +
> +	status =3D svcauth_unix_set_client(rqstp);
> +	switch (status) {
> +	case SVC_OK:
> +		break;
> +	case SVC_DENIED:
> +		status =3D -ENXIO;
> +		dprintk("%s: client %pISpc denied localio access\n",
> +				__func__, (struct sockaddr *)&rqstp->rq_addr);
> +		goto out_err;
> +	default:
> +		status =3D -ETIMEDOUT;
> +		dprintk("%s: client %pISpc temporarily denied localio access\n",
> +				__func__, (struct sockaddr *)&rqstp->rq_addr);
> +		goto out_err;
> +	}
> +
> +	return rqstp;
> +
> +out_err:
> +	nfsd_local_fakerqst_destroy(rqstp);
> +	return ERR_PTR(status);
> +}
> +
> +/*
> + * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to @fi=
le
> + *
> + * This function maps a local fh to a path on a local filesystem.
> + * This is useful when the nfs client has the local server mounted - it =
can
> + * avoid all the NFS overhead with reads, writes and commits.
> + *
> + * on successful return, caller is responsible for calling path_put. Als=
o
> + * note that this is called from nfs.ko via find_symbol() to avoid an ex=
plicit
> + * dependency on knfsd. So, there is no forward declaration in a header =
file
> + * for it.
> + */
> +int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
> +			 const struct cred *cred,
> +			 const struct nfs_fh *nfs_fh,
> +			 const fmode_t fmode,
> +			 struct file **pfilp)
> +{
> +	const struct cred *save_cred;
> +	struct svc_rqst *rqstp;
> +	struct svc_fh fh;
> +	struct nfsd_file *nf;
> +	int status =3D 0;
> +	int mayflags =3D NFSD_MAY_LOCALIO;
> +	__be32 beres;
> +
> +	/* Save creds before calling into nfsd */
> +	save_cred =3D get_current_cred();
> +
> +	rqstp =3D nfsd_local_fakerqst_create(rpc_clnt, cred);
> +	if (IS_ERR(rqstp)) {
> +		status =3D PTR_ERR(rqstp);
> +		goto out_revertcred;
> +	}
> +
> +	/* nfs_fh -> svc_fh */
> +	if (nfs_fh->size > NFS4_FHSIZE) {
> +		status =3D -EINVAL;
> +		goto out;
> +	}
> +	fh_init(&fh, NFS4_FHSIZE);
> +	fh.fh_handle.fh_size =3D nfs_fh->size;
> +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> +
> +	if (fmode & FMODE_READ)
> +		mayflags |=3D NFSD_MAY_READ;
> +	if (fmode & FMODE_WRITE)
> +		mayflags |=3D NFSD_MAY_WRITE;
> +
> +	beres =3D nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
> +	if (beres) {
> +		status =3D nfs_stat_to_errno(be32_to_cpu(beres));
> +		dprintk("%s: fh_verify failed %d\n", __func__, status);
> +		goto out_fh_put;
> +	}
> +
> +	*pfilp =3D get_file(nf->nf_file);
> +
> +	nfsd_file_put(nf);
> +out_fh_put:
> +	fh_put(&fh);
> +
> +out:
> +	nfsd_local_fakerqst_destroy(rqstp);
> +out_revertcred:
> +	revert_creds(save_cred);
> +	return status;
> +}
> +EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
> +
> +/* Compile time type checking, not used by anything */
> +static nfs_to_nfsd_open_t __maybe_unused nfsd_open_local_fh_typecheck =
=3D nfsd_open_local_fh;
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 77bbd23aa150..9c0610fdd11c 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -86,7 +86,8 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
> =C2=A0		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" },	\
> =C2=A0		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
> =C2=A0		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
> -		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
> +		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" },	\
> +		{ NFSD_MAY_LOCALIO,		"LOCALIO" })
> =C2=A0
> =C2=A0TRACE_EVENT(nfsd_compound,
> =C2=A0	TP_PROTO(
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 57cd70062048..91c50649a8c7 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -36,6 +36,8 @@
> =C2=A0#define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
> =C2=A0#define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRU=
NC)
> =C2=A0
> +#define NFSD_MAY_LOCALIO		0x800000
> +
> =C2=A0struct nfsd_file;
> =C2=A0
> =C2=A0/*
> @@ -158,6 +160,12 @@ __be32		nfsd_permission(struct svc_rqst *, struct sv=
c_export *,
> =C2=A0
> =C2=A0void		nfsd_filp_close(struct file *fp);
> =C2=A0
> +int		nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
> +				=C2=A0=C2=A0 const struct cred *cred,
> +				=C2=A0=C2=A0 const struct nfs_fh *nfs_fh,
> +				=C2=A0=C2=A0 const fmode_t fmode,
> +				=C2=A0=C2=A0 struct file **pfilp);
> +
> =C2=A0static inline int fh_want_write(struct svc_fh *fh)
> =C2=A0{
> =C2=A0	int ret;
> diff --git a/include/linux/nfs.h b/include/linux/nfs.h
> index ceb70a926b95..2dacfe9742c6 100644
> --- a/include/linux/nfs.h
> +++ b/include/linux/nfs.h
> @@ -8,6 +8,8 @@
> =C2=A0#ifndef _LINUX_NFS_H
> =C2=A0#define _LINUX_NFS_H
> =C2=A0
> +#include <linux/cred.h>
> +#include <linux/sunrpc/auth.h>
> =C2=A0#include <linux/sunrpc/msg_prot.h>
> =C2=A0#include <linux/string.h>
> =C2=A0#include <linux/crc32.h>
> @@ -46,6 +48,10 @@ enum nfs3_stable_how {
> =C2=A0	NFS_INVALID_STABLE_HOW =3D -1
> =C2=A0};
> =C2=A0
> +typedef int (*nfs_to_nfsd_open_t)(struct rpc_clnt *, const struct cred *=
,
> +				=C2=A0 const struct nfs_fh *, const fmode_t,
> +				=C2=A0 struct file **);
> +
> =C2=A0#ifdef CONFIG_CRC32
> =C2=A0/**
> =C2=A0 * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index 039898d70954..a0bb947fdd1d 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -96,6 +96,8 @@ struct nfs_open_context {
> =C2=A0	struct list_head list;
> =C2=A0	struct nfs4_threshold	*mdsthreshold;
> =C2=A0	struct rcu_head	rcu_head;
> +
> +	struct file *local_filp;
> =C2=A0};
> =C2=A0
> =C2=A0struct nfs_open_dir_context {
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 92de074e63b9..00fe469bc72e 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -49,6 +49,7 @@ struct nfs_client {
> =C2=A0#define NFS_CS_DS		7		/* - Server is a DS */
> =C2=A0#define NFS_CS_REUSEPORT	8		/* - reuse src port on reconnect */
> =C2=A0#define NFS_CS_PNFS		9		/* - Server used for pnfs */
> +#define NFS_CS_LOCAL_IO		10		/* - client is local */
> =C2=A0	struct sockaddr_storage	cl_addr;	/* server identifier */
> =C2=A0	size_t			cl_addrlen;
> =C2=A0	char *			cl_hostname;	/* hostname of server */
> @@ -125,6 +126,10 @@ struct nfs_client {
> =C2=A0	struct net		*cl_net;
> =C2=A0	struct list_head	pending_cb_stateids;
> =C2=A0	struct rcu_head		rcu;
> +
> +	/* localio */
> +	struct timespec64	cl_nfssvc_boot;
> +	seqlock_t		cl_boot_lock;
> =C2=A0};
> =C2=A0
> =C2=A0/*
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index d09b9773b20c..764513a61601 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1605,6 +1605,7 @@ enum {
> =C2=A0	NFS_IOHDR_RESEND_PNFS,
> =C2=A0	NFS_IOHDR_RESEND_MDS,
> =C2=A0	NFS_IOHDR_UNSTABLE_WRITES,
> +	NFS_IOHDR_ODIRECT,
> =C2=A0};
> =C2=A0
> =C2=A0struct nfs_io_completion;

--=20
Jeff Layton <jlayton@kernel.org>

