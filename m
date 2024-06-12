Return-Path: <linux-nfs+bounces-3653-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F9E9048FC
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 04:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7908828AA39
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 02:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C788EB651;
	Wed, 12 Jun 2024 02:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVuTmSYN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1757AD5D
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 02:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718159160; cv=none; b=Oy6RjrrcqqtzuZt6/f8sb1H5Ux/QOnZGXokmOs3ps1YJm/LEASxSwMPe2RDIYdOd+Irk5+3xCDzUeD9GyFac5auT89OChT8cRDmISIR225cM7RvOO6cGlCCrk9+FZ++2KuhJ7zA4UtBv+DHM7OtbNuNwwVov7ggkW60MB734vGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718159160; c=relaxed/simple;
	bh=LjKcpXQtEBH4D2rApRBFTp5bImOSvksZt39M7iRa6dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5Pn7FCqXdj+TFIwT42FauCOwZApWeayGO1JQXQHa4CB+/TzJWhnJu9FAj9eHinQb4hAL3PNGmpXRl0H9R4ojQ0HjYy+Pl7fT8nTUdS7Smpr3snzhtMh8eaFynP1jJWdK/DKrppU7kCkEONJgZw9G3HwEObEIFvM8/9i25YUVU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVuTmSYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F20C2BD10;
	Wed, 12 Jun 2024 02:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718159160;
	bh=LjKcpXQtEBH4D2rApRBFTp5bImOSvksZt39M7iRa6dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVuTmSYNVLWy7BkIL3Xe1bfQexLi6X/D9cziYuT/aDkIqqAE7hV39Pg79nBBJIp0d
	 3xtI+FiHi7Q9vznOTFNmlAYvloeBq3u+G5+c+aFrr0xM90Ldp27umFS6JBXl+dOK+k
	 g3f6wmvl5LQ53BJ6QckigmMcI7Z+OvVKFK09e1sky9Zv5FQca+CevnOujkkd4aT6qT
	 inACE7k5RD6LRsQI89L5Q3QKKjnrKNLQHp28A3qPPY93gH59rbnlgn88+BWdkXehQO
	 pfGTiZpvOvsqxY+muUGBdbjO2d8b/dj7wKyyBofPKkb1VLdSyis5elr0wVX2aKFPL8
	 5KvW/2GzfVpjQ==
Date: Tue, 11 Jun 2024 22:25:58 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [for-6.11 PATCH 10/29] nfs/nfsd: add "local io" support
Message-ID: <ZmkHNr5jtGHDpko_@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
 <20240607142646.20924-11-snitzer@kernel.org>
 <3ed173a9370c6d386f4c48cc133eb61511e291d0.camel@kernel.org>
 <ZmctDkCCg331JS4M@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmctDkCCg331JS4M@kernel.org>

On Mon, Jun 10, 2024 at 12:42:54PM -0400, Mike Snitzer wrote:
> On Mon, Jun 10, 2024 at 08:43:34AM -0400, Jeff Layton wrote:
> > On Fri, 2024-06-07 at 10:26 -0400, Mike Snitzer wrote:
> > > From: Weston Andros Adamson <dros@primarydata.com>
> > > 
> > > Add client support for bypassing NFS for localhost reads, writes, and commits.
> > > 
> > > This is only useful when the client and the server are running on the same
> > > host and in the same container.
> > > 
> > > This has dynamic binding with the nfsd module. Local i/o will only work if
> > > nfsd is already loaded.
> > > 
> > > [snitm: rebase accounted for commit d8b26071e65e8 ("NFSD: simplify struct nfsfh")
> > >  and commit 7c98f7cb8fda ("remove call_{read,write}_iter() functions")]
> > > 
> > > Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> > > Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
> > > Signed-off-by: Peng Tao <tao.peng@primarydata.com>
> > > Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
...
> > > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > > new file mode 100644
> > > index 000000000000..ff68454a4017
> > > --- /dev/null
> > > +++ b/fs/nfsd/localio.c
> > > @@ -0,0 +1,179 @@
> > > +/*
> > > + * NFS server support for local clients to bypass network stack
> > > + *
> > > + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
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
> > > +static void
> > > +nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
> > > +{
> > > +	if (rqstp->rq_client)
> > > +		auth_domain_put(rqstp->rq_client);
> > > +	if (rqstp->rq_cred.cr_group_info)
> > > +		put_group_info(rqstp->rq_cred.cr_group_info);
> > > +	kfree(rqstp->rq_cred.cr_principal);
> > > +	kfree(rqstp->rq_xprt);
> > > +	kfree(rqstp);
> > > +}
> > > +
> > > +static struct svc_rqst *
> > > +nfsd_local_fakerqst_create(struct rpc_clnt *rpc_clnt, const struct cred *cred)
> > > +{
> > > +	struct svc_rqst *rqstp;
> > > +	struct net *net = rpc_net_ns(rpc_clnt);
> > > +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > > +	int status;
> > > +
> > > +	if (!nn->nfsd_serv) {
> > > +		dprintk("%s: localio denied. Server not running\n", __func__);
> > > +		return ERR_PTR(-ENXIO);
> > > +	}
> > > +
> > 
> > Note that the above check is racy. The nfsd_serv can go away at any
> > time since you're not holding the (global) nfsd_mutex (I assume?).
> 
> Yes, worst case we should fallback to going over the network.

Actual worst case is we could crash... ;)

> > > +	rqstp = kzalloc(sizeof(*rqstp), GFP_KERNEL);
> > > +	if (!rqstp)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	rqstp->rq_xprt = kzalloc(sizeof(*rqstp->rq_xprt), GFP_KERNEL);
> > > +	if (!rqstp->rq_xprt) {
> > > +		status = -ENOMEM;
> > > +		goto out_err;
> > > +	}
> > > +
> > > +	rqstp->rq_xprt->xpt_net = net;
> > > +	__set_bit(RQ_SECURE, &rqstp->rq_flags);
> > > +	rqstp->rq_proc = 1;
> > > +	rqstp->rq_vers = 3;
> > > +	rqstp->rq_prot = IPPROTO_TCP;
> > > +	rqstp->rq_server = nn->nfsd_serv;
> > > +
> > 
> > I suspect you need to carry a reference of some sort so that the
> > nfsd_serv doesn't go away out from under you while this is running,
> > since this is not operating in nfsd thread context.
> > 
> > Typically, every nfsd thread holds a reference to the serv (in serv-
> > >sv_nrthreads), so that when you shut down all of the threads, it goes
> > away. The catch is that that refcount is currently under the protection
> > of the global nfsd_mutex and I doubt you want to take that in this
> > codepath.
> 
> OK, I can look closer at the implications.

SO I looked, and I'm saddened to see Neil's 6.8 commit 1e3577a4521e
("SUNRPC: discard sv_refcnt, and svc_get/svc_put").

[the lack of useful refcounting with the current code kind of blew me
away.. but nice to see it existed not too long ago.]

Rather than immediately invest the effort to revert commit
1e3577a4521e for my apparent needs... I'll send out v2 to allow for
further review and discussion.

But it really does feel like I _need_ svc_{get,put} and nfsd_{get,put}

Mike

