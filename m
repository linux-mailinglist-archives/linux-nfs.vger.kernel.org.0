Return-Path: <linux-nfs+bounces-4369-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 927C291ABC8
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 17:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EDF81F21EDC
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 15:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA3319922C;
	Thu, 27 Jun 2024 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLhDsLDP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665C8199224
	for <linux-nfs@vger.kernel.org>; Thu, 27 Jun 2024 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503291; cv=none; b=cnX3NtMsyvwLCc3NLzE8jGRTEEbHuVbWYBwOFxDpHseGbhuQvId2Z2xmtvGXcD37occNe5+6lribfyBkp930Z/0k3LuHFBYCNCNiJ4vfzaDoK1jfU6KMfKTdePhcQTuEdnJhWid45WIS1HuSOAGEWw9lJ1JmYtAhZMJSqwW8sho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503291; c=relaxed/simple;
	bh=p8599W2HG6F9Wqge5BwoWu5IeHnKU8geQEW8Pqepk1I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AvDjr153511QFRXb3V2yNafdSW+elwwNHdUQ9Y4ED7vaku/d+HMQFzN+fNSBV8sDLUqHDOhPLJDwB6TbtPnbs6m7uBnF+zT34SFb27XExD318xzY0e2uEjKxppQpe0teX65gYAN2R0h28rMDQJtfmYPJqUV+SvwEhYc4YlkS63c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLhDsLDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648E4C2BBFC;
	Thu, 27 Jun 2024 15:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719503291;
	bh=p8599W2HG6F9Wqge5BwoWu5IeHnKU8geQEW8Pqepk1I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OLhDsLDPJ7HZmQtRTHy2x4j1ERcvLwNhC8zXWIHzhm7Pn0p/ZiH3zbhQb9HpZ+uap
	 yMgfG+BgWFBGJc7cVj+acpOquxX9udItzuJ1g52MTExLZdmZXLKUC6+liKuxLEzifI
	 5quD8MmGr3Ut44RRZW6G6cDWa4nQMTbQErR3GfVFYznd0DMNaydVUz6oNLjdJnheSh
	 vQE/Ypszvk/KvVaYguDMPvJwde8qz2MZYoZeq25cfOmlVUF8ubC5w30Zk5Vbo/zS+S
	 O9AJEkdGjAgTbrAGBLQUM0wUWgS+3S3AyG34koCsNCbl7AAk8UPNMH0vr2EZCgbFkn
	 WCLRgy/E7g3Xw==
Message-ID: <618117cfff2c4581cdcda15586f3f771e37faebc.camel@kernel.org>
Subject: Re: [PATCH v8 07/18] nfsd: add "localio" support
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Trond Myklebust
 <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 snitzer@hammerspace.com
Date: Thu, 27 Jun 2024 11:48:09 -0400
In-Reply-To: <20240626182438.69539-8-snitzer@kernel.org>
References: <20240626182438.69539-1-snitzer@kernel.org>
	 <20240626182438.69539-8-snitzer@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-26 at 14:24 -0400, Mike Snitzer wrote:
> Pass the stored cl_nfssvc_net from the client to the server as
> first argument to nfsd_open_local_fh() to ensure the proper network
> namespace is used for localio.
>=20
> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Peng Tao <tao.peng@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
> =C2=A0fs/nfsd/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0fs/nfsd/filecache.c |=C2=A0=C2=A0 2 +-
> =C2=A0fs/nfsd/localio.c=C2=A0=C2=A0 | 246 +++++++++++++++++++++++++++++++=
+++++++++++++
> =C2=A0fs/nfsd/nfssvc.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0fs/nfsd/trace.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
> =C2=A0fs/nfsd/vfs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +=
+
> =C2=A06 files changed, 260 insertions(+), 2 deletions(-)
> =C2=A0create mode 100644 fs/nfsd/localio.c
>=20
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
> index 000000000000..ba9187735947
> --- /dev/null
> +++ b/fs/nfsd/localio.c
> @@ -0,0 +1,246 @@
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
> + * not recognized.=C2=A0 nfsd_file_acquire() returns an nfsstat that
> + * needs to be translated to an errno before being returned to a
> + * local client application.
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
> +	/* FIXME: not running in nfsd context, must get reference on nfsd_serv =
*/
> +	if (unlikely(!READ_ONCE(nn->nfsd_serv))) {
> +		dprintk("%s: localio denied. Server not running\n", __func__);

Chuck mentioned this earlier, but I don't think we ought to merge the
dprintks. If they're useful for debugging then they should be turned
into tracepoints. This one, I'd probably just drop.

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

The two above can probably be turned into a single tracepoint here,
though it might just be best to have a single tracepoint that always
fires when this function exits.

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

This should also be a tracepoint.

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
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 1222a0a33fe1..a477d2c5088a 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -431,6 +431,7 @@ static int nfsd_startup_net(struct net *net, const st=
ruct cred *cred)
> =C2=A0#endif
> =C2=A0#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> =C2=A0	INIT_LIST_HEAD(&nn->nfsd_uuid.list);
> +	nn->nfsd_uuid.net =3D net;
> =C2=A0	list_add_tail_rcu(&nn->nfsd_uuid.list, &nfsd_uuids);
> =C2=A0#endif
> =C2=A0	nn->nfsd_net_up =3D true;
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
> index 57cd70062048..5146f0c81752 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -33,6 +33,8 @@
> =C2=A0
> =C2=A0#define NFSD_MAY_64BIT_COOKIE		0x1000 /* 64 bit readdir cookies for=
 >=3D NFSv3 */
> =C2=A0
> +#define NFSD_MAY_LOCALIO		0x2000
> +
> =C2=A0#define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
> =C2=A0#define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRU=
NC)
> =C2=A0
> @@ -158,6 +160,13 @@ __be32		nfsd_permission(struct svc_rqst *, struct sv=
c_export *,
> =C2=A0
> =C2=A0void		nfsd_filp_close(struct file *fp);
> =C2=A0
> +int		nfsd_open_local_fh(struct net *net,
> +				=C2=A0=C2=A0 struct rpc_clnt *rpc_clnt,
> +				=C2=A0=C2=A0 const struct cred *cred,
> +				=C2=A0=C2=A0 const struct nfs_fh *nfs_fh,
> +				=C2=A0=C2=A0 const fmode_t fmode,
> +				=C2=A0=C2=A0 struct file **pfilp);
> +
> =C2=A0static inline int fh_want_write(struct svc_fh *fh)
> =C2=A0{
> =C2=A0	int ret;

--=20
Jeff Layton <jlayton@kernel.org>

