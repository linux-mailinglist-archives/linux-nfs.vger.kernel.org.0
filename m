Return-Path: <linux-nfs+bounces-4437-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A5991D38E
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 21:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A601C20643
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 19:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AA0153814;
	Sun, 30 Jun 2024 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Crc+Z+aW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8866D38DFC
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719777122; cv=none; b=QhMKqypDG9UjAh3Dq30zxsbVoNfCfpE/NSHdN62iJ5F5fc7mGVftlAEpb4Ubc9qPnRttV5lh+Q+0YoXVurHua1L8CT3KZUwupiABesH7guJ9W7xjTTKYQwhMFUPON8QQwd26OZ+mpYbUaWy3XjxBuldhs1NeIOeSzBTHKC0rV/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719777122; c=relaxed/simple;
	bh=pjrrK2+OC22DpKAi/tcsmjJZrsB1BYGay6FmULcB5Ls=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OvC9pVHoCcJANpYIEOkBaIyDzWwYd1klECJnLZ67exi1Rgqw+t/e1L7f9NJnTUbNo9M13TUsslWJ/bMCgdANZYwgVQkhorH99wMj5jUUc6caR7ZuPCxF07VRQdP6U2URj9FsyZ6dN9NcUHbHdn48dDFb1LpPvh8CI28SHNmZv7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Crc+Z+aW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B034C2BD10;
	Sun, 30 Jun 2024 19:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719777122;
	bh=pjrrK2+OC22DpKAi/tcsmjJZrsB1BYGay6FmULcB5Ls=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Crc+Z+aWq+roPxOvxKAfRCzOxZjZ/NvhmcyGwaYLNZK8KmpwdS21huflW1+yRGjgf
	 c4kyCXR+3FMeD1QdM7m4Hff/JLhnkMsJS/AIEabkFWGh8jSbkgKZ1ALVjFW2zb2nMo
	 RC26vtPaZuiOJUqIF//vL3OAnmn+01noeorF6TuIYn86xcuK937Rt7CAKO12Ggd6Ug
	 RblqSe5AAf9DjTeRjAxnB7CtaeFhtMy/cHIrbUebMm/R+FwX3ohIJSA6kzQFRJgy0h
	 vMZchmgxAdGp+pSxaaN09MFmplpG9MaNeCpOeLJR2v9I3BRdtO5nbMzBXBZIaKELK5
	 hd1n/uEw4zBeg==
Message-ID: <12c6bc98d9e04779d22cb893670c93d67fe808f9.camel@kernel.org>
Subject: Re: [PATCH v9 13/19] nfsd: add "localio" support
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>, Trond
 Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
 snitzer@hammerspace.com
Date: Sun, 30 Jun 2024 15:51:55 -0400
In-Reply-To: <ZoCIQjxougYwplsp@tissot.1015granger.net>
References: <20240628211105.54736-1-snitzer@kernel.org>
	 <20240628211105.54736-14-snitzer@kernel.org>
	 <ZoCIQjxougYwplsp@tissot.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-29 at 18:18 -0400, Chuck Lever wrote:
> Sorry, I guess I expected to have more time to learn about these
> patches before writing review comments. But if you want them to go
> in soon, I had better look more closely at them now.
>=20
>=20
> On Fri, Jun 28, 2024 at 05:10:59PM -0400, Mike Snitzer wrote:
> > Pass the stored cl_nfssvc_net from the client to the server as
>=20
> This is the only mention of cl_nfssvc_net I can find in this
> patch. I'm not sure what it is. Patch description should maybe
> provide some context.
>=20
>=20
> > first argument to nfsd_open_local_fh() to ensure the proper network
> > namespace is used for localio.
>=20
> Can the patch description say something about the distinct mount=20
> namespaces -- if the local application is running in a different
> container than the NFS server, are we using only the network
> namespaces for authorizing the file access? And is that OK to do?
> If yes, patch description should explain that NFS local I/O ignores
> the boundaries of mount namespaces and why that is OK to do.
>=20
>=20
> > Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> > Signed-off-by: Peng Tao <tao.peng@primarydata.com>
> > Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfsd/Makefile    |   1 +
> >  fs/nfsd/filecache.c |   2 +-
> >  fs/nfsd/localio.c   | 239 ++++++++++++++++++++++++++++++++++++++++++++
> >  fs/nfsd/nfssvc.c    |   1 +
> >  fs/nfsd/trace.h     |   3 +-
> >  fs/nfsd/vfs.h       |   9 ++
> >  6 files changed, 253 insertions(+), 2 deletions(-)
> >  create mode 100644 fs/nfsd/localio.c
> >=20
> > diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> > index b8736a82e57c..78b421778a79 100644
> > --- a/fs/nfsd/Makefile
> > +++ b/fs/nfsd/Makefile
> > @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) +=3D nfs4layouts.o
> >  nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) +=3D blocklayout.o blocklayoutxdr.o
> >  nfsd-$(CONFIG_NFSD_SCSILAYOUT) +=3D blocklayout.o blocklayoutxdr.o
> >  nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) +=3D flexfilelayout.o flexfilelayou=
txdr.o
> > +nfsd-$(CONFIG_NFSD_LOCALIO) +=3D localio.o
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index ad9083ca144b..99631fa56662 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -52,7 +52,7 @@
> >  #define NFSD_FILE_CACHE_UP		     (0)
> > =20
> >  /* We only care about NFSD_MAY_READ/WRITE for this cache */
> > -#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
> > +#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCA=
LIO)
> > =20
> >  static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
> >  static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > new file mode 100644
> > index 000000000000..759a5cb79652
> > --- /dev/null
> > +++ b/fs/nfsd/localio.c
> > @@ -0,0 +1,239 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * NFS server support for local clients to bypass network stack
> > + *
> > + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> > + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com=
>
> > + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> > + */
> > +
> > +#include <linux/exportfs.h>
> > +#include <linux/sunrpc/svcauth_gss.h>
> > +#include <linux/sunrpc/clnt.h>
> > +#include <linux/nfs.h>
> > +#include <linux/string.h>
> > +
> > +#include "nfsd.h"
> > +#include "vfs.h"
> > +#include "netns.h"
> > +#include "filecache.h"
> > +
> > +#define NFSDDBG_FACILITY		NFSDDBG_FH
>=20
> With no more dprintk() call sites in this patch, you no longer need
> this macro definition.
>=20
>=20
> > +/*
> > + * We need to translate between nfs status return values and
> > + * the local errno values which may not be the same.
> > + * - duplicated from fs/nfs/nfs2xdr.c to avoid needless bloat of
> > + *   all compiled nfs objects if it were in include/linux/nfs.h
> > + */
> > +static const struct {
> > +	int stat;
> > +	int errno;
> > +} nfs_common_errtbl[] =3D {
> > +	{ NFS_OK,		0		},
> > +	{ NFSERR_PERM,		-EPERM		},
> > +	{ NFSERR_NOENT,		-ENOENT		},
> > +	{ NFSERR_IO,		-EIO		},
> > +	{ NFSERR_NXIO,		-ENXIO		},
> > +/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
> > +	{ NFSERR_ACCES,		-EACCES		},
> > +	{ NFSERR_EXIST,		-EEXIST		},
> > +	{ NFSERR_XDEV,		-EXDEV		},
> > +	{ NFSERR_NODEV,		-ENODEV		},
> > +	{ NFSERR_NOTDIR,	-ENOTDIR	},
> > +	{ NFSERR_ISDIR,		-EISDIR		},
> > +	{ NFSERR_INVAL,		-EINVAL		},
> > +	{ NFSERR_FBIG,		-EFBIG		},
> > +	{ NFSERR_NOSPC,		-ENOSPC		},
> > +	{ NFSERR_ROFS,		-EROFS		},
> > +	{ NFSERR_MLINK,		-EMLINK		},
> > +	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
> > +	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
> > +	{ NFSERR_DQUOT,		-EDQUOT		},
> > +	{ NFSERR_STALE,		-ESTALE		},
> > +	{ NFSERR_REMOTE,	-EREMOTE	},
> > +#ifdef EWFLUSH
> > +	{ NFSERR_WFLUSH,	-EWFLUSH	},
> > +#endif
> > +	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
> > +	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
> > +	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
> > +	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
> > +	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
> > +	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
> > +	{ NFSERR_BADTYPE,	-EBADTYPE	},
> > +	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
> > +	{ -1,			-EIO		}
> > +};
> > +
> > +/**
> > + * nfs_stat_to_errno - convert an NFS status code to a local errno
> > + * @status: NFS status code to convert
> > + *
> > + * Returns a local errno value, or -EIO if the NFS status code is
> > + * not recognized.  nfsd_file_acquire() returns an nfsstat that
> > + * needs to be translated to an errno before being returned to a
> > + * local client application.
> > + */
> > +static int nfs_stat_to_errno(enum nfs_stat status)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; nfs_common_errtbl[i].stat !=3D -1; i++) {
> > +		if (nfs_common_errtbl[i].stat =3D=3D (int)status)
> > +			return nfs_common_errtbl[i].errno;
> > +	}
> > +	return nfs_common_errtbl[i].errno;
> > +}
> > +
> > +static void
> > +nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
> > +{
> > +	if (rqstp->rq_client)
> > +		auth_domain_put(rqstp->rq_client);
> > +	if (rqstp->rq_cred.cr_group_info)
> > +		put_group_info(rqstp->rq_cred.cr_group_info);
> > +	/* rpcauth_map_to_svc_cred_local() clears cr_principal */
> > +	WARN_ON_ONCE(rqstp->rq_cred.cr_principal !=3D NULL);
> > +	kfree(rqstp->rq_xprt);
> > +	kfree(rqstp);
> > +}
> > +
> > +static struct svc_rqst *
> > +nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
> > +			const struct cred *cred)
> > +{
> > +	struct svc_rqst *rqstp;
> > +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > +	int status;
> > +
> > +	/* FIXME: not running in nfsd context, must get reference on nfsd_ser=
v */
> > +	if (unlikely(!READ_ONCE(nn->nfsd_serv)))
> > +		return ERR_PTR(-ENXIO);
> > +
> > +	rqstp =3D kzalloc(sizeof(*rqstp), GFP_KERNEL);
> > +	if (!rqstp)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	rqstp->rq_xprt =3D kzalloc(sizeof(*rqstp->rq_xprt), GFP_KERNEL);
> > +	if (!rqstp->rq_xprt) {
> > +		status =3D -ENOMEM;
> > +		goto out_err;
> > +	}
>=20
> struct svc_rqst is pretty big (like, bigger than a couple of pages).
> What happens if this allocation fails?
>=20
> And how often does it occur -- does that add significant overhead?
>=20
>=20
> > +
> > +	rqstp->rq_xprt->xpt_net =3D net;
> > +	__set_bit(RQ_SECURE, &rqstp->rq_flags);
> > +	rqstp->rq_proc =3D 1;
> > +	rqstp->rq_vers =3D 3;
>=20
> IMO these need to be symbolic constants, not integers. Or, at least
> there needs to be some documenting comments that explain these are
> fake and why that's OK to do. Or, are there better choices?
>=20
>=20
> > +	rqstp->rq_prot =3D IPPROTO_TCP;
> > +	rqstp->rq_server =3D nn->nfsd_serv;
> > +
> > +	/* Note: we're connecting to ourself, so source addr =3D=3D peer addr=
 */
> > +	rqstp->rq_addrlen =3D rpc_peeraddr(rpc_clnt,
> > +			(struct sockaddr *)&rqstp->rq_addr,
> > +			sizeof(rqstp->rq_addr));
> > +
> > +	rpcauth_map_to_svc_cred_local(rpc_clnt->cl_auth, cred, &rqstp->rq_cre=
d);
> > +
> > +	/*
> > +	 * set up enough for svcauth_unix_set_client to be able to wait
> > +	 * for the cache downcall. Note that we do _not_ want to allow the
> > +	 * request to be deferred for later revisit since this rqst and xprt
> > +	 * are not set up to run inside of the normal svc_rqst engine.
> > +	 */
> > +	INIT_LIST_HEAD(&rqstp->rq_xprt->xpt_deferred);
> > +	kref_init(&rqstp->rq_xprt->xpt_ref);
> > +	spin_lock_init(&rqstp->rq_xprt->xpt_lock);
> > +	rqstp->rq_chandle.thread_wait =3D 5 * HZ;
> > +
> > +	status =3D svcauth_unix_set_client(rqstp);
> > +	switch (status) {
> > +	case SVC_OK:
> > +		break;
> > +	case SVC_DENIED:
> > +		status =3D -ENXIO;
> > +		goto out_err;
> > +	default:
> > +		status =3D -ETIMEDOUT;
> > +		goto out_err;
> > +	}
>=20
> Interesting. Why would svcauth_unix_set_client fail for a local I/O
> request? Wouldn't it only be because the local application is trying
> to open a file it doesn't have permission to?
>=20

I'd think so, yes. This case is not exactly like doing I/O on a local
fs since we don't have a persistent open file. nfsd has to do the
permission check on every READ/WRITE op, and I think we have to follow
suit here, particularly in the case of flexfiles DS traffic, since
fencing requires it.

>=20
> > +	return rqstp;
> > +
> > +out_err:
> > +	nfsd_local_fakerqst_destroy(rqstp);
> > +	return ERR_PTR(status);
> > +}
> > +
> > +/*
> > + * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to @=
file
> > + *
> > + * This function maps a local fh to a path on a local filesystem.
> > + * This is useful when the nfs client has the local server mounted - i=
t can
> > + * avoid all the NFS overhead with reads, writes and commits.
>=20
> Hm. It just occurred to me that there won't be a two-phase commit
> here, and possibly no flush-on-close, either? Can someone help
> explain whether/how the writeback semantics are different for NFS
> local I/O?
>=20

A localio request is just a replacement for a READ or WRITE RPC. We
don't have flush on close or a COMMIT in the WRITE RPC case either. The
client has to follow up with a COMMIT RPC (or the localio equivalent).

>=20
> > + *
> > + * on successful return, caller is responsible for calling path_put. A=
lso
> > + * note that this is called from nfs.ko via find_symbol() to avoid an =
explicit
> > + * dependency on knfsd. So, there is no forward declaration in a heade=
r file
> > + * for it.
>=20
> Yet I see a declaration added below in fs/nfsd/vfs.h. Is this
> comment out of date? Or perhaps you mean there's no declaration
> that is shared with the client code?
>=20
>=20
> > + */
> > +int nfsd_open_local_fh(struct net *net,
>=20
> I've been asking that new NFSD code use genuine full-blooded kdoc
> comments for new functions. Since this is a global (EXPORTED)
> function, please make this a genuine kdoc comment.
>=20
>=20
> > +			 struct rpc_clnt *rpc_clnt,
> > +			 const struct cred *cred,
> > +			 const struct nfs_fh *nfs_fh,
> > +			 const fmode_t fmode,
> > +			 struct file **pfilp)
> > +{
> > +	const struct cred *save_cred;
> > +	struct svc_rqst *rqstp;
> > +	struct svc_fh fh;
> > +	struct nfsd_file *nf;
> > +	int status =3D 0;
> > +	int mayflags =3D NFSD_MAY_LOCALIO;
> > +	__be32 beres;
>=20
> Nit: I've been asking that new NFSD code use reverse-christmas tree
> format for variable declarations.
>=20
>=20
> > +
> > +	/* Save creds before calling into nfsd */
> > +	save_cred =3D get_current_cred();
> > +
> > +	rqstp =3D nfsd_local_fakerqst_create(net, rpc_clnt, cred);
> > +	if (IS_ERR(rqstp)) {
> > +		status =3D PTR_ERR(rqstp);
> > +		goto out_revertcred;
> > +	}
>=20
> It might be nicer if you had a small pool of svc threads pre-created
> for this purpose instead of manufacturing one of these and then
> tearing it down for every local open call.
>=20
> Maybe even better if you had an internal transport on which to queue
> these open requests... because this is all pretty bespoke.
>=20
>=20
> > +
> > +	/* nfs_fh -> svc_fh */
> > +	if (nfs_fh->size > NFS4_FHSIZE) {
> > +		status =3D -EINVAL;
> > +		goto out;
> > +	}
> > +	fh_init(&fh, NFS4_FHSIZE);
> > +	fh.fh_handle.fh_size =3D nfs_fh->size;
> > +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> > +
> > +	if (fmode & FMODE_READ)
> > +		mayflags |=3D NFSD_MAY_READ;
> > +	if (fmode & FMODE_WRITE)
> > +		mayflags |=3D NFSD_MAY_WRITE;
> > +
> > +	beres =3D nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
> > +	if (beres) {
> > +		status =3D nfs_stat_to_errno(be32_to_cpu(beres));
> > +		goto out_fh_put;
> > +	}
>=20
> So I'm wondering whether just calling fh_verify() and then
> nfsd_open_verified() would be simpler and/or good enough here. Is
> there a strong reason to use the file cache for locally opened
> files? Jeff, any thoughts? Will there be writeback ramifications for
> doing this? Maybe we need a comment here explaining how these files
> are garbage collected (just an fput by the local I/O client, I would
> guess).
>=20

Yes, I think you do want to use the filecache here. The whole point of
the filecache is to optimize away the open and close in v3 calls.
Optimizing those away in the context of a localio op seems even more
valuable, since you're not dealing with network latency.

>=20
> > +
> > +	*pfilp =3D get_file(nf->nf_file);
> > +
> > +	nfsd_file_put(nf);
> > +out_fh_put:
> > +	fh_put(&fh);
> > +
> > +out:
> > +	nfsd_local_fakerqst_destroy(rqstp);
> > +out_revertcred:
> > +	revert_creds(save_cred);
> > +	return status;
> > +}
> > +EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
> > +
> > +/* Compile time type checking, not used by anything */
> > +static nfs_to_nfsd_open_t __maybe_unused nfsd_open_local_fh_typecheck =
=3D nfsd_open_local_fh;
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 1222a0a33fe1..a477d2c5088a 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -431,6 +431,7 @@ static int nfsd_startup_net(struct net *net, const =
struct cred *cred)
> >  #endif
> >  #if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> >  	INIT_LIST_HEAD(&nn->nfsd_uuid.list);
> > +	nn->nfsd_uuid.net =3D net;
> >  	list_add_tail_rcu(&nn->nfsd_uuid.list, &nfsd_uuids);
> >  #endif
> >  	nn->nfsd_net_up =3D true;
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index 77bbd23aa150..9c0610fdd11c 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -86,7 +86,8 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
> >  		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" },	\
> >  		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
> >  		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
> > -		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
> > +		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" },	\
> > +		{ NFSD_MAY_LOCALIO,		"LOCALIO" })
> > =20
> >  TRACE_EVENT(nfsd_compound,
> >  	TP_PROTO(
> > diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> > index 57cd70062048..5146f0c81752 100644
> > --- a/fs/nfsd/vfs.h
> > +++ b/fs/nfsd/vfs.h
> > @@ -33,6 +33,8 @@
> > =20
> >  #define NFSD_MAY_64BIT_COOKIE		0x1000 /* 64 bit readdir cookies for >=
=3D NFSv3 */
> > =20
> > +#define NFSD_MAY_LOCALIO		0x2000
> > +
> >  #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
> >  #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
> > =20
> > @@ -158,6 +160,13 @@ __be32		nfsd_permission(struct svc_rqst *, struct =
svc_export *,
> > =20
> >  void		nfsd_filp_close(struct file *fp);
> > =20
> > +int		nfsd_open_local_fh(struct net *net,
> > +				   struct rpc_clnt *rpc_clnt,
> > +				   const struct cred *cred,
> > +				   const struct nfs_fh *nfs_fh,
> > +				   const fmode_t fmode,
> > +				   struct file **pfilp);
> > +
> >  static inline int fh_want_write(struct svc_fh *fh)
> >  {
> >  	int ret;
> > --=20
> > 2.44.0
> >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

