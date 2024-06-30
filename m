Return-Path: <linux-nfs+bounces-4447-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8999A91D467
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 00:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09D91C2080D
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 22:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BE76EB73;
	Sun, 30 Jun 2024 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zefnVeQf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+a2qVN2Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zefnVeQf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+a2qVN2Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E2D6EB4A
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 22:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786191; cv=none; b=BpMIPtyP+E6Brt7EEceoWKqyV7Vrda2K/2oyUsOQ2kTduzs/i8XHhDn8WB0v/pavRPafHXwBbs36DgLtSvBkOlrbxOKOn0FaLYT68GhRtes6pMYqw+j16iMmvgfPxL7T4dC7ndQHPQvBiLauVgsb5C2tr9dGmknaBIXEbsfA0zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786191; c=relaxed/simple;
	bh=rwC9QUXv6SY13AkZhO9IqUn9egQkbwbadm6au4DvT74=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=VmHIduxD/I/N4cHZSebw/gXk8VHaTDIwUkW2A7fxtwlk3KUI6fELctvF9xFSJBm2jZAZ2Sry16ys1Tq+Ln6XxI3lu3hcROOZBBmdAjdYkVR8z8zMWibCtKGh6DhyLKWiegMH+KZQ5tOEVUID5IpYzBE8QwAAefMcWzrdgBG1oD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zefnVeQf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+a2qVN2Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zefnVeQf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+a2qVN2Q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 169A7219ED;
	Sun, 30 Jun 2024 22:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719786187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qO0RQj5rQMy407hwNtrms3etu5ybHwpoeLx+HFcqbU8=;
	b=zefnVeQf0UnkupJEiaNFlZdkk9jiXwO1BQ40+SjpfPdAzIEaNWxvFlL6/0YnDNnXK2bIxC
	SZXVP/apjUjv0U1vckZ+PMSc28mxl/t+o4ro1qUiMP+VVUC9swCzaEI22b+T+WZjwkjpy+
	rXWpB17dlK0qfIQIk+oggB7h0sDHsvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719786187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qO0RQj5rQMy407hwNtrms3etu5ybHwpoeLx+HFcqbU8=;
	b=+a2qVN2QCmszMUj589rbVN1oW37zObHRHlBnuAaksxas/BM0aoq5Q7H3W5lRW7AKHXE/r4
	C+S3O7j4sa1mNpBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zefnVeQf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+a2qVN2Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719786187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qO0RQj5rQMy407hwNtrms3etu5ybHwpoeLx+HFcqbU8=;
	b=zefnVeQf0UnkupJEiaNFlZdkk9jiXwO1BQ40+SjpfPdAzIEaNWxvFlL6/0YnDNnXK2bIxC
	SZXVP/apjUjv0U1vckZ+PMSc28mxl/t+o4ro1qUiMP+VVUC9swCzaEI22b+T+WZjwkjpy+
	rXWpB17dlK0qfIQIk+oggB7h0sDHsvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719786187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qO0RQj5rQMy407hwNtrms3etu5ybHwpoeLx+HFcqbU8=;
	b=+a2qVN2QCmszMUj589rbVN1oW37zObHRHlBnuAaksxas/BM0aoq5Q7H3W5lRW7AKHXE/r4
	C+S3O7j4sa1mNpBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 186E113A7F;
	Sun, 30 Jun 2024 22:23:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rRqBK8fagWagbQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 30 Jun 2024 22:23:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v9 13/19] nfsd: add "localio" support
In-reply-to: <ZoCIQjxougYwplsp@tissot.1015granger.net>
References: <>, <ZoCIQjxougYwplsp@tissot.1015granger.net>
Date: Mon, 01 Jul 2024 08:22:56 +1000
Message-id: <171978617639.16071.17212237728640634496@noble.neil.brown.name>
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 169A7219ED
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Spam-Level: 

On Sun, 30 Jun 2024, Chuck Lever wrote:
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
> >  nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) +=3D flexfilelayout.o flexfilelayoutx=
dr.o
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
> > +#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALI=
O)
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
> > + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
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
> > +	/* FIXME: not running in nfsd context, must get reference on nfsd_serv =
*/
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
> > +	/* Note: we're connecting to ourself, so source addr =3D=3D peer addr */
> > +	rqstp->rq_addrlen =3D rpc_peeraddr(rpc_clnt,
> > +			(struct sockaddr *)&rqstp->rq_addr,
> > +			sizeof(rqstp->rq_addr));
> > +
> > +	rpcauth_map_to_svc_cred_local(rpc_clnt->cl_auth, cred, &rqstp->rq_cred);
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

I'm beginning to think this section of code is the of the sort where you
need to be twice as clever when debugging as you where when writing.  It
is trying to get the client to use interfaces written for server-side
actions, and it isn't a good fit.

I think that instead we should modify fh_verify() so that it takes
explicit net, rq_vers, rq_cred, rq_client as well as the rqstp, and
the localio client passes in a NULL rqstp.

Getting the rq_client is an interesting challenge.
The above code (if I'm reading it correctly) gets the server-side
address of the IP connection, and passes that through to the sunrpc code
as though it is the client address.  So as long as the server is
exporting to itself, and as long as no address translation is happening
on the path, this works.  It feels messy though - and fragile.

I would rather we had some rq_client (struct auth_domain) that was
dedicated to localio.  The client should be able to access it based on
the fact that it could rather the server UUID using the LOCALIO RPC
protocol.

I'm not sure what exactly this would look like, but the=20
'struct auth_domain *' should be something that can be accessed
directly, not looked up in a cache.

I can try to knock up a patch to allow fh_verify (and nfsd_file_acquire)
without an rqstp.  I won't try the auth_domain change until I hear what
others think.

NeilBrown

