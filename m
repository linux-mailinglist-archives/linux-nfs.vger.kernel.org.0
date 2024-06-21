Return-Path: <linux-nfs+bounces-4211-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B5A911AE6
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 08:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06604B21DA1
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 06:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B8712F365;
	Fri, 21 Jun 2024 06:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KEUXXwv8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u+LNL2S9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KEUXXwv8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u+LNL2S9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B2D12EBCA
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950113; cv=none; b=r8GUysuRgJgB9bWthtpv1w5XWeexos+0v75miyrOr/2zP2p7tzbxwYSWXMDEyRrGJpxHEfD4XihCj9N0jK9FfAofEntR8wkyF4pujp0WNoMWgNy7jQqf1qHnKNjnTMKR8BRtV84JisjcicyY43rgmMUQAifnCD2KR5SFhsPmJc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950113; c=relaxed/simple;
	bh=Q5VWUj2i1CsHcqFuKtzRUtkIz6cZEnwINWyKCPUVi58=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=EPtfzaxknaqWOGKo6Fw3Ir52Sc+Px8Go3PJnI7T7BcyxqCqz9LjbEak5/r1f00SeRgbDA8xGiR31CX7hALKy/bG/Xr33P2B4jb59WU74Q+pdAdIggkhhZtWpcnaX+1QPLAHYqWdq66LPv2kKkIwvPBSvbv7uqXgOtIAbxEZKrQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KEUXXwv8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u+LNL2S9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KEUXXwv8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u+LNL2S9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3862121A30;
	Fri, 21 Jun 2024 06:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718950108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjZQMnugLKU1mBo+FyPyWQKmgExwQIPcT3i5P4XF8UQ=;
	b=KEUXXwv8GZ+75MtlWn3ZwjSKKdYxvA4nnvxYOB9fNfe4Esc4ck/CqICqxBjdFr0N8RwqcF
	ENTzmuulrKSqcQyroLnt/EI4Jt6/3DRRJnn8aJhU6gU8IqRzlbHolDeE6toU6O+yZXu8JD
	eFYs+cdLhoCEaIPyptTQXAV9eTpn+uY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718950108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjZQMnugLKU1mBo+FyPyWQKmgExwQIPcT3i5P4XF8UQ=;
	b=u+LNL2S99r1FS8kP/DTCNNndhN0SV3SurcbhWbD8xRGq1jYZgQVUYFp1fmodIkQ19Uh7T9
	twHplkpmwZYQSwAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718950108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjZQMnugLKU1mBo+FyPyWQKmgExwQIPcT3i5P4XF8UQ=;
	b=KEUXXwv8GZ+75MtlWn3ZwjSKKdYxvA4nnvxYOB9fNfe4Esc4ck/CqICqxBjdFr0N8RwqcF
	ENTzmuulrKSqcQyroLnt/EI4Jt6/3DRRJnn8aJhU6gU8IqRzlbHolDeE6toU6O+yZXu8JD
	eFYs+cdLhoCEaIPyptTQXAV9eTpn+uY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718950108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjZQMnugLKU1mBo+FyPyWQKmgExwQIPcT3i5P4XF8UQ=;
	b=u+LNL2S99r1FS8kP/DTCNNndhN0SV3SurcbhWbD8xRGq1jYZgQVUYFp1fmodIkQ19Uh7T9
	twHplkpmwZYQSwAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4AF813ABD;
	Fri, 21 Jun 2024 06:08:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hOLtHdgYdWZiewAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 21 Jun 2024 06:08:24 +0000
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
Subject: Re: [PATCH v6 06/18] nfs/nfsd: add "localio" support
In-reply-to: <20240619204032.93740-7-snitzer@kernel.org>
References: <20240619204032.93740-1-snitzer@kernel.org>,
 <20240619204032.93740-7-snitzer@kernel.org>
Date: Fri, 21 Jun 2024 16:08:20 +1000
Message-id: <171895010008.14261.5871139607400580149@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]

On Thu, 20 Jun 2024, Mike Snitzer wrote:
> From: Weston Andros Adamson <dros@primarydata.com>
>=20
> Add client support for bypassing NFS for localhost reads, writes, and
> commits. This is only useful when the client and the server are
> running on the same host.
>=20
> nfs_local_probe() is stubbed out, later commits will enable client and
> server handshake via a Linux-only LOCALIO auxiliary RPC protocol.
>=20
> This has dynamic binding with the nfsd module (via nfs_localio module
> which is part of nfs_common). Localio will only work if nfsd is
> already loaded.
>=20
> The "localio_enabled" nfs kernel module parameter can be used to
> disable and enable the ability to use localio support.
>=20
> Tracepoints were added for nfs_local_open_fh, nfs_local_enable and
> nfs_local_disable.
>=20
> Also, pass the stored cl_nfssvc_net from the client to the server as
> first argument to nfsd_open_local_fh() to ensure the proper network
> namespace is used for localio.
>=20
> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Peng Tao <tao.peng@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/Makefile           |   1 +
>  fs/nfs/client.c           |   3 +
>  fs/nfs/inode.c            |   4 +
>  fs/nfs/internal.h         |  51 +++
>  fs/nfs/localio.c          | 722 ++++++++++++++++++++++++++++++++++++++
>  fs/nfs/nfstrace.h         |  61 ++++
>  fs/nfs/pagelist.c         |   3 +
>  fs/nfs/write.c            |   3 +
>  fs/nfsd/Makefile          |   1 +
>  fs/nfsd/filecache.c       |   2 +-
>  fs/nfsd/localio.c         | 244 +++++++++++++
>  fs/nfsd/nfssvc.c          |   1 +
>  fs/nfsd/trace.h           |   3 +-
>  fs/nfsd/vfs.h             |   9 +
>  include/linux/nfs.h       |   2 +
>  include/linux/nfs_fs.h    |   2 +
>  include/linux/nfs_fs_sb.h |   1 +
>  include/linux/nfs_xdr.h   |   1 +
>  18 files changed, 1112 insertions(+), 2 deletions(-)
>  create mode 100644 fs/nfs/localio.c
>  create mode 100644 fs/nfsd/localio.c
>=20
> diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
> index 5f6db37f461e..9fb2f2cac87e 100644
> --- a/fs/nfs/Makefile
> +++ b/fs/nfs/Makefile
> @@ -13,6 +13,7 @@ nfs-y 			:=3D client.o dir.o file.o getroot.o inode.o sup=
er.o \
>  nfs-$(CONFIG_ROOT_NFS)	+=3D nfsroot.o
>  nfs-$(CONFIG_SYSCTL)	+=3D sysctl.o
>  nfs-$(CONFIG_NFS_FSCACHE) +=3D fscache.o
> +nfs-$(CONFIG_NFS_LOCALIO) +=3D localio.o
> =20
>  obj-$(CONFIG_NFS_V2) +=3D nfsv2.o
>  nfsv2-y :=3D nfs2super.o proc.o nfs2xdr.o
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index bcdf8d42cbc7..1300c388f971 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -241,6 +241,8 @@ static void pnfs_init_server(struct nfs_server *server)
>   */
>  void nfs_free_client(struct nfs_client *clp)
>  {
> +	nfs_local_disable(clp);
> +
>  	/* -EIO all pending I/O */
>  	if (!IS_ERR(clp->cl_rpcclient))
>  		rpc_shutdown_client(clp->cl_rpcclient);
> @@ -432,6 +434,7 @@ struct nfs_client *nfs_get_client(const struct nfs_clie=
nt_initdata *cl_init)
>  			list_add_tail(&new->cl_share_link,
>  					&nn->nfs_client_list);
>  			spin_unlock(&nn->nfs_client_lock);
> +			nfs_local_probe(new);
>  			return rpc_ops->init_client(new, cl_init);
>  		}
> =20
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index acef52ecb1bb..f9923cbf6058 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -39,6 +39,7 @@
>  #include <linux/slab.h>
>  #include <linux/compat.h>
>  #include <linux/freezer.h>
> +#include <linux/file.h>
>  #include <linux/uaccess.h>
>  #include <linux/iversion.h>
> =20
> @@ -1053,6 +1054,7 @@ struct nfs_open_context *alloc_nfs_open_context(struc=
t dentry *dentry,
>  	ctx->lock_context.open_context =3D ctx;
>  	INIT_LIST_HEAD(&ctx->list);
>  	ctx->mdsthreshold =3D NULL;
> +	ctx->local_filp =3D NULL;
>  	return ctx;
>  }
>  EXPORT_SYMBOL_GPL(alloc_nfs_open_context);
> @@ -1084,6 +1086,8 @@ static void __put_nfs_open_context(struct nfs_open_co=
ntext *ctx, int is_sync)
>  	nfs_sb_deactive(sb);
>  	put_rpccred(rcu_dereference_protected(ctx->ll_cred, 1));
>  	kfree(ctx->mdsthreshold);
> +	if (!IS_ERR_OR_NULL(ctx->local_filp))
> +		fput(ctx->local_filp);
>  	kfree_rcu(ctx, rcu_head);
>  }
> =20
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 958c8de072e2..d352040e3232 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -451,6 +451,57 @@ extern void nfs_set_cache_invalid(struct inode *inode,=
 unsigned long flags);
>  extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
>  extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
> =20
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +/* localio.c */
> +extern void nfs_local_disable(struct nfs_client *);
> +extern void nfs_local_probe(struct nfs_client *);
> +extern struct file *nfs_local_open_fh(struct nfs_client *, const struct cr=
ed *,
> +				      struct nfs_fh *, const fmode_t);
> +extern struct file *nfs_local_file_open(struct nfs_client *clp,
> +					const struct cred *cred,
> +					struct nfs_fh *fh,
> +					struct nfs_open_context *ctx);
> +extern int nfs_local_doio(struct nfs_client *, struct file *,
> +			  struct nfs_pgio_header *,
> +			  const struct rpc_call_ops *);
> +extern int nfs_local_commit(struct file *, struct nfs_commit_data *,
> +			    const struct rpc_call_ops *, int);
> +extern bool nfs_server_is_local(const struct nfs_client *clp);
> +
> +#else
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
> +static inline int nfs_local_doio(struct nfs_client *clp, struct file *file=
p,
> +				struct nfs_pgio_header *hdr,
> +				const struct rpc_call_ops *call_ops)
> +{
> +	return -EINVAL;
> +}
> +static inline int nfs_local_commit(struct file *filep, struct nfs_commit_d=
ata *data,
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
>  /* super.c */
>  extern const struct super_operations nfs_sops;
>  bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflavor_t);
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> new file mode 100644
> index 000000000000..38d0832442b2
> --- /dev/null
> +++ b/fs/nfs/localio.c
> @@ -0,0 +1,722 @@
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
> +/*
> + * nfs_local_enable - attempt to enable local i/o for an nfs_client
> + */
> +static void nfs_local_enable(struct nfs_client *clp, struct net *net)
> +{
> +	if (READ_ONCE(clp->nfsd_open_local_fh)) {
> +		set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
> +		clp->cl_nfssvc_net =3D net;
> +		trace_nfs_local_enable(clp);
> +	}
> +}
> +
> +/*
> + * nfs_local_disable - disable local i/o for an nfs_client
> + */
> +void nfs_local_disable(struct nfs_client *clp)
> +{
> +	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
> +		trace_nfs_local_disable(clp);
> +		clp->cl_nfssvc_net =3D NULL;
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
> +		  struct nfs_fh *fh, const fmode_t mode)
> +{
> +	struct file *filp;
> +	int status;
> +
> +	if (mode & ~(FMODE_READ | FMODE_WRITE))
> +		return ERR_PTR(-EINVAL);
> +
> +	status =3D clp->nfsd_open_local_fh(clp->cl_nfssvc_net, clp->cl_rpcclient,
> +					cred, fh, mode, &filp);
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
> +	iocb->bvec =3D nfs_bvec_alloc_and_import_pagevec(hdr->page_array.pagevec,
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
> +nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int =
dir)
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

Both branches of this if() do exactly the same thing.  iov_iter_advance
is a no-op if the size arg is zero.

Is it really worth increasing the code size to sometimes avoid a
function call?

At least we should for the iov_iter_bvec() inconditionally, then maybe
call _advance().

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

fput() is not a good excuse for a workqueue - the work is always
deferred either to a workqueue or to a process return-from-syscall
context.
However the ->rpc_call_done() and vfs_fsync_range() calls are excellent
justification for a workqueue.
So I think the comment should be improved, but the code looks sensible.

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
> +	    hdr->args.offset + hdr->res.count >=3D i_size_read(file_inode(filp)))
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
> +nfs_copy_boot_verifier(struct nfs_write_verifier *verifier, struct inode *=
inode)
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

This looks wrong for NFSv4.  I think we should use
nfsd4_change_attribute().
Maybe it isn't important, but if it isn't I'd like to see an explanation
why.

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
> +		(hdr->args.stable =3D=3D NFS_UNSTABLE) ?  "unstable" : "stable");
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
> +nfs_local_file_open_cached(struct nfs_client *clp, const struct cred *cred,
> +			   struct nfs_fh *fh, struct nfs_open_context *ctx)
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
> +		    struct nfs_fh *fh, struct nfs_open_context *ctx)
> +{
> +	if (!nfs_server_is_local(clp))
> +		return NULL;
> +	return nfs_local_file_open_cached(clp, cred, fh, ctx);
> +}
> +
> +int
> +nfs_local_doio(struct nfs_client *clp, struct file *filp,
> +	       struct nfs_pgio_header *hdr,
> +	       const struct rpc_call_ops *call_ops)
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
> +nfs_local_fsync_ctx_alloc(struct nfs_commit_data *data, struct file *filp,
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
>  	TP_printk("path=3D'%s'", __get_str(path))
>  );
> =20
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
>  DECLARE_EVENT_CLASS(nfs_xdr_event,
>  		TP_PROTO(
>  			const struct xdr_stream *xdr,
> diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> index 57d62db3be5b..b08420b8e664 100644
> --- a/fs/nfs/pagelist.c
> +++ b/fs/nfs/pagelist.c
> @@ -879,6 +879,9 @@ int nfs_initiate_pgio(struct nfs_pageio_descriptor *des=
c,
>  		hdr->args.count,
>  		(unsigned long long)hdr->args.offset);
> =20
> +	if (localio)
> +		return nfs_local_doio(clp, localio, hdr, call_ops);
> +
>  	task =3D rpc_run_task(&task_setup_data);
>  	if (IS_ERR(task))
>  		return PTR_ERR(task);
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 267bed2a4ceb..b29b0fd5431f 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -1700,6 +1700,9 @@ int nfs_initiate_commit(struct rpc_clnt *clnt, struct=
 nfs_commit_data *data,
> =20
>  	dprintk("NFS: initiated commit call\n");
> =20
> +	if (localio)
> +		return nfs_local_commit(localio, data, call_ops, how);
> +
>  	task =3D rpc_run_task(&task_setup_data);
>  	if (IS_ERR(task))
>  		return PTR_ERR(task);
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index b8736a82e57c..78b421778a79 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) +=3D nfs4layouts.o
>  nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) +=3D blocklayout.o blocklayoutxdr.o
>  nfsd-$(CONFIG_NFSD_SCSILAYOUT) +=3D blocklayout.o blocklayoutxdr.o
>  nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) +=3D flexfilelayout.o flexfilelayoutxdr=
.o
> +nfsd-$(CONFIG_NFSD_LOCALIO) +=3D localio.o
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index ad9083ca144b..99631fa56662 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -52,7 +52,7 @@
>  #define NFSD_FILE_CACHE_UP		     (0)
> =20
>  /* We only care about NFSD_MAY_READ/WRITE for this cache */
> -#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
> +#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
> =20
>  static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
>  static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> new file mode 100644
> index 000000000000..e9aa0997f898
> --- /dev/null
> +++ b/fs/nfsd/localio.c
> @@ -0,0 +1,244 @@
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
> + *   all compiled nfs objects if it were in include/linux/nfs.h
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
> + * not recognized.  This function is used jointly by NFSv2 and NFSv3.
> + */
> +static int nfs_stat_to_errno(enum nfs_stat status)
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
> +nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
> +			const struct cred *cred)
> +{
> +	struct svc_rqst *rqstp;
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	int status;
> +
> +	/* FIXME: not running in nfsd context, must get reference on nfsd_serv */
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
> +	/* Note: we're connecting to ourself, so source addr =3D=3D peer addr */
> +	rqstp->rq_addrlen =3D rpc_peeraddr(rpc_clnt,
> +			(struct sockaddr *)&rqstp->rq_addr,
> +			sizeof(rqstp->rq_addr));
> +
> +	rpcauth_map_to_svc_cred_local(rpc_clnt->cl_auth, cred, &rqstp->rq_cred);
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
> + * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to @file
> + *
> + * This function maps a local fh to a path on a local filesystem.
> + * This is useful when the nfs client has the local server mounted - it can
> + * avoid all the NFS overhead with reads, writes and commits.
> + *
> + * on successful return, caller is responsible for calling path_put. Also
> + * note that this is called from nfs.ko via find_symbol() to avoid an expl=
icit
> + * dependency on knfsd. So, there is no forward declaration in a header fi=
le
> + * for it.
> + */
> +int nfsd_open_local_fh(struct net *net,
> +			 struct rpc_clnt *rpc_clnt,
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
> +	rqstp =3D nfsd_local_fakerqst_create(net, rpc_clnt, cred);
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
> +static nfs_to_nfsd_open_t __maybe_unused nfsd_open_local_fh_typecheck =3D =
nfsd_open_local_fh;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 1222a0a33fe1..a477d2c5088a 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -431,6 +431,7 @@ static int nfsd_startup_net(struct net *net, const stru=
ct cred *cred)
>  #endif
>  #if IS_ENABLED(CONFIG_NFSD_LOCALIO)
>  	INIT_LIST_HEAD(&nn->nfsd_uuid.list);
> +	nn->nfsd_uuid.net =3D net;
>  	list_add_tail_rcu(&nn->nfsd_uuid.list, &nfsd_uuids);
>  #endif
>  	nn->nfsd_net_up =3D true;
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 77bbd23aa150..9c0610fdd11c 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -86,7 +86,8 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
>  		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" },	\
>  		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
>  		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
> -		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
> +		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" },	\
> +		{ NFSD_MAY_LOCALIO,		"LOCALIO" })
> =20
>  TRACE_EVENT(nfsd_compound,
>  	TP_PROTO(
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 57cd70062048..af07bb146e81 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -36,6 +36,8 @@
>  #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
>  #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
> =20
> +#define NFSD_MAY_LOCALIO		0x800000
> +
>  struct nfsd_file;
> =20
>  /*
> @@ -158,6 +160,13 @@ __be32		nfsd_permission(struct svc_rqst *, struct svc_=
export *,
> =20
>  void		nfsd_filp_close(struct file *fp);
> =20
> +int		nfsd_open_local_fh(struct net *net,
> +				   struct rpc_clnt *rpc_clnt,
> +				   const struct cred *cred,
> +				   const struct nfs_fh *nfs_fh,
> +				   const fmode_t fmode,
> +				   struct file **pfilp);
> +
>  static inline int fh_want_write(struct svc_fh *fh)
>  {
>  	int ret;
> diff --git a/include/linux/nfs.h b/include/linux/nfs.h
> index ceb70a926b95..64ed672a0b34 100644
> --- a/include/linux/nfs.h
> +++ b/include/linux/nfs.h
> @@ -8,6 +8,8 @@
>  #ifndef _LINUX_NFS_H
>  #define _LINUX_NFS_H
> =20
> +#include <linux/cred.h>
> +#include <linux/sunrpc/auth.h>
>  #include <linux/sunrpc/msg_prot.h>
>  #include <linux/string.h>
>  #include <linux/crc32.h>
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index 039898d70954..a0bb947fdd1d 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -96,6 +96,8 @@ struct nfs_open_context {
>  	struct list_head list;
>  	struct nfs4_threshold	*mdsthreshold;
>  	struct rcu_head	rcu_head;
> +
> +	struct file *local_filp;
>  };
> =20
>  struct nfs_open_dir_context {
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index e58e706a6503..4290c550a049 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -50,6 +50,7 @@ struct nfs_client {
>  #define NFS_CS_DS		7		/* - Server is a DS */
>  #define NFS_CS_REUSEPORT	8		/* - reuse src port on reconnect */
>  #define NFS_CS_PNFS		9		/* - Server used for pnfs */
> +#define NFS_CS_LOCAL_IO		10		/* - client is local */
>  	struct sockaddr_storage	cl_addr;	/* server identifier */
>  	size_t			cl_addrlen;
>  	char *			cl_hostname;	/* hostname of server */
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index d09b9773b20c..764513a61601 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1605,6 +1605,7 @@ enum {
>  	NFS_IOHDR_RESEND_PNFS,
>  	NFS_IOHDR_RESEND_MDS,
>  	NFS_IOHDR_UNSTABLE_WRITES,
> +	NFS_IOHDR_ODIRECT,
>  };
> =20
>  struct nfs_io_completion;
> --=20
> 2.44.0
>=20
>=20
>=20

Thanks,
NeilBrown

