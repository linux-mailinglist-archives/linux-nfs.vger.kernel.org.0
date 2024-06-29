Return-Path: <linux-nfs+bounces-4410-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6F891CECD
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 21:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EA81C20DD2
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 19:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAFA139CEC;
	Sat, 29 Jun 2024 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8eDda2a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B48208C4
	for <linux-nfs@vger.kernel.org>; Sat, 29 Jun 2024 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719688222; cv=none; b=SoLH1MU1gdQNL7JQA7/Mz3E7ZOEGV1g0z4H++kYmFfrYEAFsSr2//+sP2mhyxtqXLAJg32wJ9n+K/Fqwu0NhSa+/ViuXeiJLxs18txaQ3JKisTgF25F0bbOzedIkjmPQVffgp2Rp20FMdy+FNYVDKUu9lB42FZlBZwDWRNqr3P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719688222; c=relaxed/simple;
	bh=yN/xhVg4dp4xYl7+doybeB1EWS4xzu+icohlanxJvRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkBIQLD7EL1J/MkjwNo29QW65cbugOMXU654eBCwbcyaFNLD+YYkQ1Pc+QkBllSjkfM1RQis/Yf01vC5REDwhxfMBwT6MGybe1gnEpUl00sNRDq5KcEHZs9YVGP5PucYaKxZGBXGNjzHOnCUxtfQeLvrkTZw3niUEE2vY4ma7O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8eDda2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF41C2BBFC;
	Sat, 29 Jun 2024 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719688221;
	bh=yN/xhVg4dp4xYl7+doybeB1EWS4xzu+icohlanxJvRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8eDda2aPjOPzJFYzDL6whB4n4Ig+frsk5Brc+E0lL/whCgTxgYGEQiAjmg/L/5Om
	 bZrfR8z2YnU44+L6aQJJlwi65NYv10NkyVOzeruiUo6nO22qkjSsa3/j7Wh8MTn/yL
	 yFslis2pu/nXtWibg2Zr96G+kkqgeTbtCuKBILxCjVhkk7MaJTqUkS3RNkcgvP7jjg
	 XVeIcFcbVM3xWla9h80kE80l5US+oQ1Ll1de6Va/XBvaRY9Q/A/cIoz5RtmTycVMOV
	 531KN3uRspCWF7u02vHrd8qPwVV3xnml9GrjXJsfF+gaFECns3HCbFzxoE9tzU0GiJ
	 FisMTH8oRwxOA==
Date: Sat, 29 Jun 2024 15:10:19 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>,
	"snitzer@hammerspace.com" <snitzer@hammerspace.com>
Subject: Re: [PATCH v9 00/19] nfs/nfsd: add support for localio
Message-ID: <ZoBcGxAsPuguaR7q@kernel.org>
References: <20240628211105.54736-1-snitzer@kernel.org>
 <577D0632-FABE-4D16-93B9-4701C051B418@oracle.com>
 <ZoAwZnuaPLSSIfon@kernel.org>
 <ZoA+Bas+GV8lmRU7@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZoA+Bas+GV8lmRU7@tissot.1015granger.net>

On Sat, Jun 29, 2024 at 01:01:57PM -0400, Chuck Lever wrote:
> On Sat, Jun 29, 2024 at 12:03:50PM -0400, Mike Snitzer wrote:
> > On Sat, Jun 29, 2024 at 03:36:10PM +0000, Chuck Lever III wrote:
> > > 
> > > 
> > > > On Jun 28, 2024, at 5:10 PM, Mike Snitzer <snitzer@kernel.org> wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > I'd prefer to see these changes land upstream for 6.11 if possible.
> > > > They are adequately Kconfig'd to certainly pose no risk if disabled.
> > > > And even if localio enabled it has proven to work well with increased
> > > > testing.
> > > 
> > > Can v10 split this series into an NFS client part and an NFS
> > > server part? I will need to get the NFSD changes into nfsd-next
> > > in the next week or so to land in v6.11.
> > 
> > I forgot to mention this as a v9 improvement: I did split the series,
> > but left it as one patchset.
> > 
> > Patches 1-12 are NFS client, Patches 13-19 are NFSD.
> 
> I didn't notice that because my MUA displayed the patches completely
> out of order. Apologies!
>
> > Here is the diffstat for NFS (patches 1 - 12):
> > 
> >  fs/Kconfig                                |    3
> >  fs/nfs/Kconfig                            |   14
> >  fs/nfs/Makefile                           |    1
> >  fs/nfs/blocklayout/blocklayout.c          |    6
> >  fs/nfs/client.c                           |   15
> >  fs/nfs/filelayout/filelayout.c            |   16
> >  fs/nfs/flexfilelayout/flexfilelayout.c    |  131 ++++
> >  fs/nfs/flexfilelayout/flexfilelayout.h    |    2
> >  fs/nfs/flexfilelayout/flexfilelayoutdev.c |    6
> >  fs/nfs/inode.c                            |    4
> >  fs/nfs/internal.h                         |   60 ++
> >  fs/nfs/localio.c                          |  827 ++++++++++++++++++++++++++++++
> >  fs/nfs/nfs4xdr.c                          |   13
> >  fs/nfs/nfstrace.h                         |   61 ++
> >  fs/nfs/pagelist.c                         |   32 -
> >  fs/nfs/pnfs.c                             |   24
> >  fs/nfs/pnfs.h                             |    6
> >  fs/nfs/pnfs_nfs.c                         |    2
> >  fs/nfs/write.c                            |   13
> >  fs/nfs_common/Makefile                    |    3
> >  fs/nfs_common/nfslocalio.c                |   74 ++
> >  fs/nfsd/netns.h                           |    4
> >  fs/nfsd/nfssvc.c                          |   12
> >  include/linux/nfs.h                       |    9
> >  include/linux/nfs_fs.h                    |    2
> >  include/linux/nfs_fs_sb.h                 |   10
> >  include/linux/nfs_xdr.h                   |   20
> >  include/linux/nfslocalio.h                |   39 +
> >  include/linux/sunrpc/auth.h               |    4
> >  net/sunrpc/auth.c                         |   15
> >  net/sunrpc/clnt.c                         |    1
> >  31 files changed, 1354 insertions(+), 75 deletions(-)
> > 
> > Unfortunately there are the fs/nfsd/netns.h and fs/nfsd/nfssvc.c
> > changes that anchor everything (patch 5).
> 
> I /did/ notice that.
> 
> 
> > I suppose we could invert the order, such that NFSD comes before NFS
> > changes.  But then the NFS tree will need to be rebased on NFSD tree.
> 
> Alternately, I can take the NFSD-related patches in 6.11, and the
> client changes can go in 6.12. My impression (could be wrong) was
> that the NFSD patches were nearly ready but the client side was
> still churning a little.

I'm "done" with both afaik.  Only thing that needs settling is that
XFS RFC patch I posted.

> Or we might decide that it's not worth the trouble. Anna offered to
> take the whole series, or I can. If Anna takes it, I'll send
> Acked-by for the NFSD patches.

Probably best to have it all go through the same tree.  Just get proper
Acked-by:s where needed.

I would say it is more client heavy (in terms of code foot-print) so
maybe it does make more sense to go through NFS.  Anna is handling the
6.11 merge for NFS so let's just work on getting proper Acked-by.

If you, Jeff and Neil could do a final review and provide Acked-by (or
conditional Acked-by if I fold your suggestions in for v10) I'll add
all your final feedback and Acked-by:s or Reviewed-by:s so Anna will
be able to simply pick it up once the NFS client side is also
reviewed.

> > Diffstat for NFSD (patches 13 - 19):
> > 
> >  Documentation/filesystems/nfs/localio.rst |  135 ++++++++++++
> >  fs/nfsd/Kconfig                           |   14 +
> >  fs/nfsd/Makefile                          |    1 
> >  fs/nfsd/filecache.c                       |    2 
> >  fs/nfsd/localio.c                         |  319 ++++++++++++++++++++++++++++++
> >  fs/nfsd/netns.h                           |    8 
> >  fs/nfsd/nfsctl.c                          |    2 
> >  fs/nfsd/nfsd.h                            |    2 
> >  fs/nfsd/nfssvc.c                          |  104 +++++++--
> >  fs/nfsd/trace.h                           |    3 
> >  fs/nfsd/vfs.h                             |    9 
> >  include/linux/nfslocalio.h                |    2 
> >  include/linux/sunrpc/svc.h                |    7 
> >  net/sunrpc/svc.c                          |   68 +++---
> >  net/sunrpc/svc_xprt.c                     |    2 
> >  net/sunrpc/svcauth_unix.c                 |    3 
> >  16 files changed, 621 insertions(+), 60 deletions(-)
> > 
> > Happy to work it however you think is best.
> > 
> > > > Worked with Kent Overstreet to enable testing integration with ktest
> > > > running xfstests, the dashboard is here:
> > > > https://evilpiepirate.org/~testdashboard/ci?branch=snitm-nfs
> > > > (it is running way more xfstests tests than is usual for nfs, would be
> > > > good to reconcile that with the listing provided here:
> > > > https://wiki.linux-nfs.org/wiki/index.php/Xfstests )
> > > 
> > > Actually, we're using kdevops for NFSD CI testing. Any possibility
> > > that we can get some help setting that up? (It runs xfstests and
> > > several other workflows).
> > 
> > Sure, I can get with you off-list if that's best?  I just need some
> > pointers/access to help get it going.
> 
> Yes, off-list wfm.
> 
> Come to think of it, it might just work to point my test systems to
> your git branch and let it rip, if there are no new tests. I will
> try that.

Right, no new tests added to xfstests, it was purely configuration to
get xfstests running on single host in loopback mode (NFS client
mounting export from knfsd on same host).

Would be great if you could point your kdevops at my localio-for-6.11
branch.  You just need to make sure to enable these in your Kconfig:

CONFIG_NFSD_LOCALIO=y
CONFIG_NFS_LOCALIO=y
CONFIG_NFS_COMMON_LOCALIO_SUPPORT=y

(either of the NFS or NFSD options will select
CONFIG_NFS_COMMON_LOCALIO_SUPPORT)

