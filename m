Return-Path: <linux-nfs+bounces-4319-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343DA918753
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655A01C2224C
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 16:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB6618E748;
	Wed, 26 Jun 2024 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d70/a++P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C346E611
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719419252; cv=none; b=rbZPA6zZa4NLY4vNstZfb9H9YblD03YCY5O91LzKGd8DY7gdCf6xj0Tb4YzLDMI3cEIYILFqn+0ow2YJ68MW4sQf0ynTA7gvPy6boEwymcj9OY23EOFj6Iap0Yd1bZDpevAWv8p9oLf2R+9bjLK62oB5sprwknhvLfXeBr1Pbcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719419252; c=relaxed/simple;
	bh=Xr9a+xPIoHfBnpmejr9yFDy7opwjNxp+OAdbUayiSfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcglzC3G1FHLFNdApCV2/IwipTn9ekx4nKCQqU+JRtIuYl7bBbxmYZd6naHffhKEBqz57kJb17WxYKOELw3wzJoHuKo17zT7Eqsps0PrRxukdouIUfr0nqfiGfSztm1+sX0t1BnqtJHKoGC0haOgoepraMLtqCNwV6PCiCrf8Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d70/a++P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD02C116B1;
	Wed, 26 Jun 2024 16:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719419252;
	bh=Xr9a+xPIoHfBnpmejr9yFDy7opwjNxp+OAdbUayiSfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d70/a++Pejzxjg8mzemegnqUY4VGpXy84NCjFV24sXPTxpfCpmUBLnGHElHoqwc2t
	 f5l53VGsk6pgkwLGzlerJoAPQDSovu0hx71Wm20AEfgl699xBayKjobnRq2qN+683I
	 7bfYPtr3RNYCkCMrjFZSaLTwuTU3CxSrg5GCLfRp5rFSiBxHepD4MOY9y1MN0bvpSD
	 3N0w4g1bWNE6w2J86zCJhR/5Y9HolFkaf0lQE/MFdymUZC7FQBzgkYNES4HPIgeEna
	 mLRjJQ0mJxhUhqBRvk6u3eJE1BLuezww79wDmihe2z8TOMkbgugWztJIr5IS61iPUp
	 adFTddpXsQu0A==
Date: Wed, 26 Jun 2024 12:27:31 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v7 14/20] nfsd: implement server support for
 NFS_LOCALIO_PROGRAM
Message-ID: <ZnxBc0dwprOZkox9@kernel.org>
References: <20240624162741.68216-1-snitzer@kernel.org>
 <20240624162741.68216-15-snitzer@kernel.org>
 <171935781035.14261.11537219125500827548@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171935781035.14261.11537219125500827548@noble.neil.brown.name>

On Wed, Jun 26, 2024 at 09:23:30AM +1000, NeilBrown wrote:
> On Tue, 25 Jun 2024, Mike Snitzer wrote:
> > LOCALIOPROC_GETUUID encodes the server's uuid_t in terms of the fixed
> > UUID_SIZE (16). The fixed size opaque encode and decode XDR methods
> > are used instead of the less efficient variable sized methods.
> > 
> > Aside from a bit of code in nfssvc.c, all the knowledge of the LOCALIO
> > RPC protocol is in fs/nfsd/localio.c which implements just a single
> > version (1) that is used independently of what NFS version is used.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > [neilb: factored out and simplified single localio protocol]
> > Co-developed-by: NeilBrown <neilb@suse.de>
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/localio.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/nfsd/nfssvc.c  | 29 ++++++++++++++++++-
> >  2 files changed, 102 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > index f6df66b1d523..aaa5293eb352 100644
> > --- a/fs/nfsd/localio.c
> > +++ b/fs/nfsd/localio.c
> > @@ -11,12 +11,15 @@
> >  #include <linux/sunrpc/svcauth_gss.h>
> >  #include <linux/sunrpc/clnt.h>
> >  #include <linux/nfs.h>
> > +#include <linux/nfs_fs.h>
> > +#include <linux/nfs_xdr.h>
> >  #include <linux/string.h>
> >  
> >  #include "nfsd.h"
> >  #include "vfs.h"
> >  #include "netns.h"
> >  #include "filecache.h"
> > +#include "cache.h"
> >  
> >  #define NFSDDBG_FACILITY		NFSDDBG_FH
> >  
> > @@ -249,3 +252,74 @@ EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
> >  
> >  /* Compile time type checking, not used by anything */
> >  static nfs_to_nfsd_open_t __maybe_unused nfsd_open_local_fh_typecheck = nfsd_open_local_fh;
> > +
> > +/*
> > + * GETUUID XDR encode functions
> > + */
> > +
> > +static __be32 nfsd_proc_null(struct svc_rqst *rqstp)
> > +{
> > +	return rpc_success;
> > +}
> > +
> > +struct nfsd_getuuidres {
> > +	uuid_t			uuid;
> > +};
> > +
> > +static __be32 nfsd_proc_getuuid(struct svc_rqst *rqstp)
> > +{
> > +	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> > +	struct nfsd_getuuidres *resp = rqstp->rq_resp;
> > +
> > +	uuid_copy(&resp->uuid, &nn->nfsd_uuid.uuid);
> > +
> > +	return rpc_success;
> > +}
> > +
> > +static bool nfslocalio_encode_getuuidres(struct svc_rqst *rqstp,
> > +					 struct xdr_stream *xdr)
> > +{
> > +	struct nfsd_getuuidres *resp = rqstp->rq_resp;
> > +	u8 uuid[UUID_SIZE];
> > +
> > +	export_uuid(uuid, &resp->uuid);
> > +	encode_opaque_fixed(xdr, uuid, UUID_SIZE);
> > +	dprintk("%s: uuid=%pU\n", __func__, uuid);
> > +
> > +	return true;
> > +}
> > +
> > +static const struct svc_procedure nfsd_localio_procedures[2] = {
> 
> Including a '2' here is unnecessary.
> 
> > +	[LOCALIOPROC_NULL] = {
> > +		.pc_func = nfsd_proc_null,
> > +		.pc_decode = nfssvc_decode_voidarg,
> > +		.pc_encode = nfssvc_encode_voidres,
> > +		.pc_argsize = sizeof(struct nfsd_voidargs),
> > +		.pc_ressize = sizeof(struct nfsd_voidres),
> > +		.pc_cachetype = RC_NOCACHE,
> > +		.pc_xdrressize = 0,
> > +		.pc_name = "NULL",
> > +	},
> > +	[LOCALIOPROC_GETUUID] = {
> > +		.pc_func = nfsd_proc_getuuid,
> > +		.pc_decode = nfssvc_decode_voidarg,
> > +		.pc_encode = nfslocalio_encode_getuuidres,
> > +		.pc_argsize = sizeof(struct nfsd_voidargs),
> > +		.pc_ressize = sizeof(struct nfsd_getuuidres),
> > +		.pc_cachetype = RC_NOCACHE,
> > +		.pc_xdrressize = XDR_QUADLEN(UUID_SIZE),
> > +		.pc_name = "GETUUID",
> > +	},
> > +};
> > +
> > +static DEFINE_PER_CPU_ALIGNED(unsigned long,
> > +			      nfsd_localio_count[ARRAY_SIZE(nfsd_localio_procedures)]);
> 
> We have ARRAY_SIZE above and "= 2" below, both referring to the same
> value.
> 
> Maybe #define LOCALIO_NR_PROCEEDURES ARRAY_SIZE(nfsd_localio_procedures)
> ??

Yeap, sounds good, fixed for v8.

