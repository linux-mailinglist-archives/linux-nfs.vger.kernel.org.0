Return-Path: <linux-nfs+bounces-4287-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EFC915DD7
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 06:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E9A1B210E4
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 04:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1081D12FF89;
	Tue, 25 Jun 2024 04:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yh6q57uj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE404596E
	for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2024 04:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719291476; cv=none; b=RXQaHh4vErAVV+nQo10HtSsYnZ58X9Q3oh7lZuH4fjp708C3DJgHQL7lzvIHkdhmbhkJaeIgU429lOmzSXZBC5uwD7DT8V1BEc5CDqgKsoojdR2OzlXeaR1F2Nm2VkBePFaXRFGmV7mOLDI3l6idRSDSMDrYyzdlHBhQxsC6u6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719291476; c=relaxed/simple;
	bh=njbsYB1xoEua+SUVYyBOpwwNTAVO4DBOYOwGprUsSfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZ/Q3c4aY+Cr7n7IIsbF/at5wCOKTb84Oj+9COlLBZLH2NlTiw9CpDQpc4wic7lXRPGDi46IqKG1xVxO1TeETUQKOuSr+aQ8ox0H2RVCdpu0saMDyK7bCVJOa2l33dp4bq9Rl+vBOP6XQLJshGYb0pELmGub2mGt8Xy1cS+hiAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yh6q57uj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76909C32782;
	Tue, 25 Jun 2024 04:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719291475;
	bh=njbsYB1xoEua+SUVYyBOpwwNTAVO4DBOYOwGprUsSfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yh6q57ujtLvkBilIFxCki2ntj5I5OegP46MJnrgb+HseSk6TRzaBmTGcWtPBa+GCJ
	 T/Q8yKwV1ubmS0VvZyiF63Nf5jHA0UBWB+MVORL6TYjmmsBXVsnBJE7azNs/P1FPh2
	 OAkB1ndzpxS5oPL2KL8f3YIjAq7o8LWW3JRO4scz+0SnI3ot0BU+SS8eqeclPQ0Qkj
	 CRBwJRL5l84nbHfQ/bos3b6wz5oBuTTrk18pMrRpw1CBZFdZXk8bNbdg0yihisSTgQ
	 FCh+ro2zk8BtIey/O3XjRB+g3HNnFSJTb5ZUeXqG0PJZgAsf4V07+HnmYoga/+AdvW
	 y6Nn508HLdUbg==
Date: Tue, 25 Jun 2024 00:57:54 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, snitzer@hammerspace.com
Subject: Re: [PATCH v7 06/20] nfs/nfsd: add "localio" support
Message-ID: <ZnpOUiAhapJaRMXm@kernel.org>
References: <20240624162741.68216-1-snitzer@kernel.org>
 <20240624162741.68216-7-snitzer@kernel.org>
 <Znm6YjFetA6pG/5W@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Znm6YjFetA6pG/5W@tissot.1015granger.net>

On Mon, Jun 24, 2024 at 02:26:42PM -0400, Chuck Lever wrote:
> On Mon, Jun 24, 2024 at 12:27:27PM -0400, Mike Snitzer wrote:
> > From: Weston Andros Adamson <dros@primarydata.com>
> > 
> > Add client support for bypassing NFS for localhost reads, writes, and
> > commits. This is only useful when the client and the server are
> > running on the same host.
> > 
> > nfs_local_probe() is stubbed out, later commits will enable client and
> > server handshake via a Linux-only LOCALIO auxiliary RPC protocol.
> > 
> > This has dynamic binding with the nfsd module (via nfs_localio module
> > which is part of nfs_common). Localio will only work if nfsd is
> > already loaded.
> > 
> > The "localio_enabled" nfs kernel module parameter can be used to
> > disable and enable the ability to use localio support.
> > 
> > Tracepoints were added for nfs_local_open_fh, nfs_local_enable and
> > nfs_local_disable.
> > 
> > Also, pass the stored cl_nfssvc_net from the client to the server as
> > first argument to nfsd_open_local_fh() to ensure the proper network
> > namespace is used for localio.
> > 
> > Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> > Signed-off-by: Peng Tao <tao.peng@primarydata.com>
> > Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfs/Makefile           |   1 +
> >  fs/nfs/client.c           |   3 +
> >  fs/nfs/inode.c            |   4 +
> >  fs/nfs/internal.h         |  51 +++
> >  fs/nfs/localio.c          | 654 ++++++++++++++++++++++++++++++++++++++
> >  fs/nfs/nfstrace.h         |  61 ++++
> >  fs/nfs/pagelist.c         |   3 +
> >  fs/nfs/write.c            |   3 +
> 
> Hi Mike -
> 
> I'd prefer to see this patch split into two patches, one for the
> NFS client, and one for the NFS server. The other patches in this
> series seem to have a clear line between server and client
> changes.

Will do.

> > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > new file mode 100644
> > index 000000000000..e9aa0997f898
> > --- /dev/null
> > +++ b/fs/nfsd/localio.c
> > @@ -0,0 +1,244 @@
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
> 
> I think I'd rather prefer to see trace points in here rather than
> new dprintk call sites. In any event, perhaps NFSDDBG_FH is not
> especially appropriate?

I think NFSDDBG_FH is most appropriate given this localio is most
focused on opening a file handle.  (The getuuid not so much)

I'm not loving how overdone the trace points interface is. in my
experience, trace points are also a serious source of conflicts when
backporting changes to older kernels.

But if you were inclined to switch this code over to trace points once
it is merged, who am I to stop you! ;)

> > +
> > +/**
> > + * nfs_stat_to_errno - convert an NFS status code to a local errno
> > + * @status: NFS status code to convert
> > + *
> > + * Returns a local errno value, or -EIO if the NFS status code is
> > + * not recognized.  This function is used jointly by NFSv2 and NFSv3.
> > + */
> > +static int nfs_stat_to_errno(enum nfs_stat status)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; nfs_common_errtbl[i].stat != -1; i++) {
> > +		if (nfs_common_errtbl[i].stat == (int)status)
> > +			return nfs_common_errtbl[i].errno;
> > +	}
> > +	return nfs_common_errtbl[i].errno;
> > +}
> 
> I get it: The existing nfserrno() function on the server is the
> reverse mapping from this one, and you need to undo the nfsstat
> returned from nfsd_file_acquire().
> 
> The documenting comments here confusing in the context of why this
> function is necessary on the server. For example, "This function is
> used jointly by NFSv2 and NFSv3"... Maybe instead, explain that
> nfsd_file_acquire() returns an nfsstat that needs to be translated
> to an errno before being returned to a local client application.

Thanks, fixed.

> > +static void
> > +nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
> > +{
> > +	if (rqstp->rq_client)
> > +		auth_domain_put(rqstp->rq_client);
> > +	if (rqstp->rq_cred.cr_group_info)
> > +		put_group_info(rqstp->rq_cred.cr_group_info);
> > +	/* rpcauth_map_to_svc_cred_local() clears cr_principal */
> > +	WARN_ON_ONCE(rqstp->rq_cred.cr_principal != NULL);
> > +	kfree(rqstp->rq_xprt);
> > +	kfree(rqstp);
> > +}
> > +
> > +static struct svc_rqst *
> > +nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
> > +			const struct cred *cred)
> > +{
> > +	struct svc_rqst *rqstp;
> > +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > +	int status;
> > +
> > +	/* FIXME: not running in nfsd context, must get reference on nfsd_serv */
> 
> What's your plan for addressing this FIXME?

The SRCU (and nfsd_serv_get, nfsd_serv_put and nfsd_serv_sync) in
later patches addresses it.

FYI: And now that I looked closer at Neil's earlier suggestion (to
have a single SRCU for all of nfsd_net -- rather than having one
embedded in each): I'll try to include that change for v8.

> > diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> > index 57cd70062048..af07bb146e81 100644
> > --- a/fs/nfsd/vfs.h
> > +++ b/fs/nfsd/vfs.h
> > @@ -36,6 +36,8 @@
> >  #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
> >  #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
> >  
> > +#define NFSD_MAY_LOCALIO		0x800000
> > +
> 
> Nit: I'd prefer to see NFSD_MAY_LOCALIO inserted just after
> NFSD_MAY_64BIT_COOKIE. Is there a reason the value of the new flag
> should not be 0x2000 ?

Fixed.

