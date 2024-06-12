Return-Path: <linux-nfs+bounces-3684-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD010904A49
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 06:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF211C23A88
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 04:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FAA36AF5;
	Wed, 12 Jun 2024 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TelMNdoo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D2A36AF2
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 04:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718167891; cv=none; b=ePe9WZ3zf6IkhYQoU5uDZ8f68Ef0ZndrsP+NC5Nhke8DAv4F2D7FnINVZ7g5JZz3e82OOEuhPppyDTBK+BjDNz5UQC3qjWnsesAFNc/1IMaqU815ya5NcZvLZ7vwJ+4HCdsGEoc05miGVvF2inn6MtjBgCk4RjfRnKGvVy0/zZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718167891; c=relaxed/simple;
	bh=qERewtss8aW4faLB/3L1NvX2o6hiFROD4BXdAM61LiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiuwArQIsn57bFZs65Ts7fL2y1s1y07o30elZd0M9JxI9ed5Pxr2HgGpBSQIsuK5wBfhRg5ZYnwsGU3eXtnv9gO5rGd8qMt2ZXBKeW1OrBng3SbwOa6CLNF4JO/LkFFitYRevuhWq9EtiK6S0cEAd7LB02yp1Dwqkxxl96KMrbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TelMNdoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECB8C32786;
	Wed, 12 Jun 2024 04:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718167890;
	bh=qERewtss8aW4faLB/3L1NvX2o6hiFROD4BXdAM61LiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TelMNdooEgNH8eo339ghYglzWWxgRY/JdesyTaTvzGnSKmciGGR1VnYOF3U/tRs+u
	 S4E4vuCFRFvdiy+6BdxZ19R2/1pkClH3q+PzpAqYAsF5gD+5sgzqtkAneLUAGEX5Ws
	 WIs9aNCF8zNPcnAfEfNRekTfDi4PS8dx0KkB2apWnAtXMDTwPIjvBUsr4w8XXMHQBE
	 frhhUNcI5cDYGPaRA0c6VF/1JKt0kNdFy1iohfP7pQMS9SxioIc2/vZ5ZwpSI8uv5I
	 zDzzW9wjSkTvQ0Ep71FVDRUUxToP+rvnyNktkqmOseqQaH+YKbMcaGAxGTT36A6Gpl
	 bL3nPJ4Se22Mw==
Date: Wed, 12 Jun 2024 00:51:29 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [RFC PATCH v2 07/15] nfs/nfsd: add "localio" support
Message-ID: <ZmkpUWUUFnftOtdl@kernel.org>
References: <20240612030752.31754-1-snitzer@kernel.org>
 <20240612030752.31754-8-snitzer@kernel.org>
 <171816697836.14261.17806813255162604456@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171816697836.14261.17806813255162604456@noble.neil.brown.name>

On Wed, Jun 12, 2024 at 02:36:18PM +1000, NeilBrown wrote:
> On Wed, 12 Jun 2024, Mike Snitzer wrote:
> > From: Weston Andros Adamson <dros@primarydata.com>
> > 
> > Add client support for bypassing NFS for localhost reads, writes, and
> > commits. This is only useful when the client and the server are
> > running on the same host.
> > 
> > nfs_local_probe() is stubbed out, later commits will enable client and
> > server handshake via a LOCALIO protocol extension.
> > 
> > This has dynamic binding with the nfsd module. Localio will only work
> > if nfsd is already loaded.
> > 
> > The "localio_enabled" nfs kernel module parameter can be used to
> > disable and enable the ability to use localio support.
> > 
> > Also, tracepoints were added for nfs_local_open_fh, nfs_local_enable
> > and nfs_local_disable.
> > 
> > Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> > Signed-off-by: Peng Tao <tao.peng@primarydata.com>
> > Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfs/Makefile           |   2 +
> >  fs/nfs/client.c           |   7 +
> >  fs/nfs/inode.c            |   5 +
> >  fs/nfs/internal.h         |  55 +++
> >  fs/nfs/localio.c          | 798 ++++++++++++++++++++++++++++++++++++++
> >  fs/nfs/nfstrace.h         |  61 +++
> >  fs/nfs/pagelist.c         |   3 +
> >  fs/nfs/write.c            |   3 +
> >  fs/nfsd/Makefile          |   2 +
> >  fs/nfsd/filecache.c       |   2 +-
> >  fs/nfsd/localio.c         | 184 +++++++++
> >  fs/nfsd/trace.h           |   3 +-
> >  fs/nfsd/vfs.h             |   8 +
> >  include/linux/nfs.h       |   6 +
> >  include/linux/nfs_fs.h    |   2 +
> >  include/linux/nfs_fs_sb.h |   5 +
> >  include/linux/nfs_xdr.h   |   1 +
> >  17 files changed, 1145 insertions(+), 2 deletions(-)
> >  create mode 100644 fs/nfs/localio.c
> >  create mode 100644 fs/nfsd/localio.c
> > 
> > diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
> > index 5f6db37f461e..ad9923fb0f03 100644
> > --- a/fs/nfs/Makefile
> > +++ b/fs/nfs/Makefile
> > @@ -13,6 +13,8 @@ nfs-y 			:= client.o dir.o file.o getroot.o inode.o super.o \
> >  nfs-$(CONFIG_ROOT_NFS)	+= nfsroot.o
> >  nfs-$(CONFIG_SYSCTL)	+= sysctl.o
> >  nfs-$(CONFIG_NFS_FSCACHE) += fscache.o
> > +nfs-$(CONFIG_NFS_V3_LOCALIO) += localio.o
> > +nfs-$(CONFIG_NFS_V4_LOCALIO) += localio.o
> 
> Should be just
> 
>    nfs-$(CONFIG_NFS_LOCALIO_SUPPORT) += localio.o
> 
> >  
> >  obj-$(CONFIG_NFS_V2) += nfsv2.o
> >  nfsv2-y := nfs2super.o proc.o nfs2xdr.o
> > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > index de77848ae654..c123ad22ac79 100644
> > --- a/fs/nfs/client.c
> > +++ b/fs/nfs/client.c
> > @@ -178,6 +178,10 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
> >  	clp->cl_max_connect = cl_init->max_connect ? cl_init->max_connect : 1;
> >  	clp->cl_net = get_net(cl_init->net);
> >  
> > +#if defined(CONFIG_NFS_V3_LOCALIO) || defined(CONFIG_NFS_V4_LOCALIO)
> 
> Maybe CONFIG_NFS_LOCALIO_SUPPORT here too?  And one more place below.

Yeah, I had issues with accessing CONFIG_NFS_LOCALIO_SUPPORT.. I did
try it though. Can revisit and try harder ;)

