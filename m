Return-Path: <linux-nfs+bounces-4372-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFBE91AE09
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 19:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816641F2924E
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 17:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD98199E9B;
	Thu, 27 Jun 2024 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc7tD+I8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FB6199225
	for <linux-nfs@vger.kernel.org>; Thu, 27 Jun 2024 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509259; cv=none; b=KmhHQts52opajCnp7M7DEaTQlL1IeCTZwXdmkJ3vX+TcjyZgkZ7DWFqPlAt28dO/4a5jPblvL5fsqALyPUNoX2hPD8ybwS1JUwBPfeAfyQSWagvxKzIAEXRqTHDytGt3cH5QmBmHmALuOjTU12Wk0PD6WvvVi5pWsfaa+ziOBUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509259; c=relaxed/simple;
	bh=NI7UXU7BWuD19MPUpfSYowX4Gd94QFAzH68qjRRHx3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vy29qVG8eS3aSOSPrIWHQb1nn6x1Bm8axVuszWgI5tRLHrvRmRsFK26i4JriVjPnFhFDrnGW8cXjWcWWL2qV/3DAl80n0rsQ0GWJ5zHUY9i4OH5SMWatA7+X9+TCTR9a+ZUceVhQvTTZKJmAi6EPxK8Zw9XvGi0WMylzZ/JGaZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc7tD+I8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA128C2BBFC;
	Thu, 27 Jun 2024 17:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719509258;
	bh=NI7UXU7BWuD19MPUpfSYowX4Gd94QFAzH68qjRRHx3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nc7tD+I83xnLBJXJsR2b9jXbS8b+odiWM5tix8+4Lzi9RHyc6sgX371D+HW0Qbj6g
	 7Wsskzk603c5TeBnDEl3NKjl6hBKhCv1mfKsyDMcCfpWlZRpyn7DdnLjiTBHSVUxja
	 qRSj6Ouio7ycQ6VS2UDNHqJTZVsOoiHQxptwyumWDjsKDUIqw9d+VZz4QTohKXr9Vi
	 f8on5VY5P//86zNXKGY2dKeaSkn2ZKIRtGC2Z80Rlhp42CAdmq1mFoYsdWKQnfQWJu
	 GwkzdaC7NvJHUx7yHdPKTgUgrZoZ0NvJnTt54vcD1ljBrpY9FJ8BgpU74rb8OSyrzC
	 h4yEA86WSLRwg==
Date: Thu, 27 Jun 2024 13:27:37 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, snitzer@hammerspace.com
Subject: Re: [PATCH v8 07/18] nfsd: add "localio" support
Message-ID: <Zn2hCU59Zxze79yW@kernel.org>
References: <20240626182438.69539-1-snitzer@kernel.org>
 <20240626182438.69539-8-snitzer@kernel.org>
 <618117cfff2c4581cdcda15586f3f771e37faebc.camel@kernel.org>
 <Zn2OJ5UynQmwMGEA@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zn2OJ5UynQmwMGEA@tissot.1015granger.net>

On Thu, Jun 27, 2024 at 12:07:03PM -0400, Chuck Lever wrote:
> On Thu, Jun 27, 2024 at 11:48:09AM -0400, Jeff Layton wrote:
> > On Wed, 2024-06-26 at 14:24 -0400, Mike Snitzer wrote:
> > > Pass the stored cl_nfssvc_net from the client to the server as
> > > first argument to nfsd_open_local_fh() to ensure the proper network
> > > namespace is used for localio.
> > > 
> > > Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> > > Signed-off-by: Peng Tao <tao.peng@primarydata.com>
> > > Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  fs/nfsd/Makefile    |   1 +
> > >  fs/nfsd/filecache.c |   2 +-
> > >  fs/nfsd/localio.c   | 246 ++++++++++++++++++++++++++++++++++++++++++++
> > >  fs/nfsd/nfssvc.c    |   1 +
> > >  fs/nfsd/trace.h     |   3 +-
> > >  fs/nfsd/vfs.h       |   9 ++
> > >  6 files changed, 260 insertions(+), 2 deletions(-)
> > >  create mode 100644 fs/nfsd/localio.c
> > > 
> > > diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> > > index b8736a82e57c..78b421778a79 100644
> > > --- a/fs/nfsd/Makefile
> > > +++ b/fs/nfsd/Makefile
> > > @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
> > >  nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
> > >  nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
> > >  nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
> > > +nfsd-$(CONFIG_NFSD_LOCALIO) += localio.o
> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index ad9083ca144b..99631fa56662 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -52,7 +52,7 @@
> > >  #define NFSD_FILE_CACHE_UP		     (0)
> > >  
> > >  /* We only care about NFSD_MAY_READ/WRITE for this cache */
> > > -#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
> > > +#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
> > >  
> > >  static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
> > >  static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> > > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > > new file mode 100644
> > > index 000000000000..ba9187735947
> > > --- /dev/null
> > > +++ b/fs/nfsd/localio.c
> > > @@ -0,0 +1,246 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * NFS server support for local clients to bypass network stack
> > > + *
> > > + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> > > + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
> > > + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> > > + */
> > > +
> > > +#include <linux/exportfs.h>
> > > +#include <linux/sunrpc/svcauth_gss.h>
> > > +#include <linux/sunrpc/clnt.h>
> > > +#include <linux/nfs.h>
> > > +#include <linux/string.h>
> > > +
> > > +#include "nfsd.h"
> > > +#include "vfs.h"
> > > +#include "netns.h"
> > > +#include "filecache.h"
> > > +
> > > +#define NFSDDBG_FACILITY		NFSDDBG_FH
> > > +
> > > +/*
> > > + * We need to translate between nfs status return values and
> > > + * the local errno values which may not be the same.
> > > + * - duplicated from fs/nfs/nfs2xdr.c to avoid needless bloat of
> > > + *   all compiled nfs objects if it were in include/linux/nfs.h
> > > + */
> > > +static const struct {
> > > +	int stat;
> > > +	int errno;
> > > +} nfs_common_errtbl[] = {
> > > +	{ NFS_OK,		0		},
> > > +	{ NFSERR_PERM,		-EPERM		},
> > > +	{ NFSERR_NOENT,		-ENOENT		},
> > > +	{ NFSERR_IO,		-EIO		},
> > > +	{ NFSERR_NXIO,		-ENXIO		},
> > > +/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
> > > +	{ NFSERR_ACCES,		-EACCES		},
> > > +	{ NFSERR_EXIST,		-EEXIST		},
> > > +	{ NFSERR_XDEV,		-EXDEV		},
> > > +	{ NFSERR_NODEV,		-ENODEV		},
> > > +	{ NFSERR_NOTDIR,	-ENOTDIR	},
> > > +	{ NFSERR_ISDIR,		-EISDIR		},
> > > +	{ NFSERR_INVAL,		-EINVAL		},
> > > +	{ NFSERR_FBIG,		-EFBIG		},
> > > +	{ NFSERR_NOSPC,		-ENOSPC		},
> > > +	{ NFSERR_ROFS,		-EROFS		},
> > > +	{ NFSERR_MLINK,		-EMLINK		},
> > > +	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
> > > +	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
> > > +	{ NFSERR_DQUOT,		-EDQUOT		},
> > > +	{ NFSERR_STALE,		-ESTALE		},
> > > +	{ NFSERR_REMOTE,	-EREMOTE	},
> > > +#ifdef EWFLUSH
> > > +	{ NFSERR_WFLUSH,	-EWFLUSH	},
> > > +#endif
> > > +	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
> > > +	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
> > > +	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
> > > +	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
> > > +	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
> > > +	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
> > > +	{ NFSERR_BADTYPE,	-EBADTYPE	},
> > > +	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
> > > +	{ -1,			-EIO		}
> > > +};
> > > +
> > > +/**
> > > + * nfs_stat_to_errno - convert an NFS status code to a local errno
> > > + * @status: NFS status code to convert
> > > + *
> > > + * Returns a local errno value, or -EIO if the NFS status code is
> > > + * not recognized.  nfsd_file_acquire() returns an nfsstat that
> > > + * needs to be translated to an errno before being returned to a
> > > + * local client application.
> > > + */
> > > +static int nfs_stat_to_errno(enum nfs_stat status)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; nfs_common_errtbl[i].stat != -1; i++) {
> > > +		if (nfs_common_errtbl[i].stat == (int)status)
> > > +			return nfs_common_errtbl[i].errno;
> > > +	}
> > > +	return nfs_common_errtbl[i].errno;
> > > +}
> > > +
> > > +static void
> > > +nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
> > > +{
> > > +	if (rqstp->rq_client)
> > > +		auth_domain_put(rqstp->rq_client);
> > > +	if (rqstp->rq_cred.cr_group_info)
> > > +		put_group_info(rqstp->rq_cred.cr_group_info);
> > > +	/* rpcauth_map_to_svc_cred_local() clears cr_principal */
> > > +	WARN_ON_ONCE(rqstp->rq_cred.cr_principal != NULL);
> > > +	kfree(rqstp->rq_xprt);
> > > +	kfree(rqstp);
> > > +}
> > > +
> > > +static struct svc_rqst *
> > > +nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
> > > +			const struct cred *cred)
> > > +{
> > > +	struct svc_rqst *rqstp;
> > > +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > > +	int status;
> > > +
> > > +	/* FIXME: not running in nfsd context, must get reference on nfsd_serv */
> > > +	if (unlikely(!READ_ONCE(nn->nfsd_serv))) {
> > > +		dprintk("%s: localio denied. Server not running\n", __func__);
> > 
> > Chuck mentioned this earlier, but I don't think we ought to merge the
> > dprintks. If they're useful for debugging then they should be turned
> > into tracepoints. This one, I'd probably just drop.
> 
> Right; the problem with dprintk() is they can create so much chatter
> that the systemd journal will automatically toss those messages and
> they are lost. No diagnostic value in that.
> 
> Also you probably won't find it useful if lots of debugging info
> goes into the trace log but a handful of the stuff you are
> looking for is dumped into the system journal; the two use different
> timestamps and so are really hard to line up after the fact.
> 
> We're trying to transition away from dprintk() in NFSD for these
> reasons.

OK, I understand wanting to not allow new dprintk() to be added.

Meanwhile:
$ grep -ri dprintk fs/nfsd/*.[ch]  | wc -l
     181

So I'm struggling to get motivated to convert to tracepoints.  Feels
like a needless make-work hurdle, these could be converted by others
more proficient with tracepoints if/when needed.

Making everyone have to be proficient at developing debugging via
tracepoints seems misplaced (but I also understand that forcing others
to fish enables "others" to not be doing the conversion work).

This is the end of my mild protest.. I'll shutup and either convert
the dprintk()s or kill them all. ;)

Thanks,
Mike

