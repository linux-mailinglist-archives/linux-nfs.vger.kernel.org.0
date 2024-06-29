Return-Path: <linux-nfs+bounces-4407-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9735691CE0E
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 18:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7209B21277
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 16:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4541DDEA;
	Sat, 29 Jun 2024 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TM1LcZFi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B05660
	for <linux-nfs@vger.kernel.org>; Sat, 29 Jun 2024 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719677032; cv=none; b=cjn3OW5I+8Id6IBbSLAO+V/M87EuN76P3p/WtFYOgF8vn/x8l+TWnLfjUr9zUsNQevgMcDqDqvas7tjoz3gxj0tJ7T5PGrDMLt9kl/dG25vo5s80cdBpFt+RbojIwTo63Fg0Yi0TQhrutkWF+B9FIK7WH2Jnmd17XxrAW4JBiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719677032; c=relaxed/simple;
	bh=VjIMacEf5KhM/mtVqwjhg2qTOeXXN0+2OlaMBLxVuA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzFZ/LwKKMu8j2PkRrY/jn6AmeKA9LjAcJ7ksj4mzASHgIvK2mioRaYdZ6GMpEqPZ6bHsyeZi2U2uuHhuvbYpNM246p7LPS8vTydMLQcTDY77scppJY37RxVMz5vJZsP3vhZ+iEKHpsfxlk8Y+HodlXAXOAFB3mPen6DCglviiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TM1LcZFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D03C2BBFC;
	Sat, 29 Jun 2024 16:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719677032;
	bh=VjIMacEf5KhM/mtVqwjhg2qTOeXXN0+2OlaMBLxVuA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TM1LcZFin9g3/Am62d55u8zxAVcG7rvUhGQ5vduZCrDubsBjbcyaBv6KqDNUYpcvG
	 ZnHyyqtRAq1TOL5f3Kxibgbx9OdJRsqFrIag9pSTDsDrTn9BIiqRNcVPYzIZWPPW0l
	 cUVy1SM51LKCWDC4sAnYF9ndA+CYaNHbeRFM4wdkNqEi6mh6WlkVr6a9/mVd4sdca+
	 OcP873IViOyRpFRzeW4QOiTxrEhkFHQmVuoLRRSjV+DKchHuCZOtXnl/7xrhKYE15o
	 DajAEOtYPFRg3GbDBHu4rR4aKgUdgmGlsbCGS4Jo70w+1pB4ZbiIP+ziQ4QOUpNfTG
	 HF9KKcBKksEXw==
Date: Sat, 29 Jun 2024 12:03:50 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>,
	"snitzer@hammerspace.com" <snitzer@hammerspace.com>
Subject: Re: [PATCH v9 00/19] nfs/nfsd: add support for localio
Message-ID: <ZoAwZnuaPLSSIfon@kernel.org>
References: <20240628211105.54736-1-snitzer@kernel.org>
 <577D0632-FABE-4D16-93B9-4701C051B418@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <577D0632-FABE-4D16-93B9-4701C051B418@oracle.com>

On Sat, Jun 29, 2024 at 03:36:10PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jun 28, 2024, at 5:10 PM, Mike Snitzer <snitzer@kernel.org> wrote:
> > 
> > Hi,
> > 
> > I'd prefer to see these changes land upstream for 6.11 if possible.
> > They are adequately Kconfig'd to certainly pose no risk if disabled.
> > And even if localio enabled it has proven to work well with increased
> > testing.
> 
> Can v10 split this series into an NFS client part and an NFS
> server part? I will need to get the NFSD changes into nfsd-next
> in the next week or so to land in v6.11.

I forgot to mention this as a v9 improvement: I did split the series,
but left it as one patchset.

Patches 1-12 are NFS client, Patches 13-19 are NFSD.

Here is the diffstat for NFS (patches 1 - 12):

 fs/Kconfig                                |    3
 fs/nfs/Kconfig                            |   14
 fs/nfs/Makefile                           |    1
 fs/nfs/blocklayout/blocklayout.c          |    6
 fs/nfs/client.c                           |   15
 fs/nfs/filelayout/filelayout.c            |   16
 fs/nfs/flexfilelayout/flexfilelayout.c    |  131 ++++
 fs/nfs/flexfilelayout/flexfilelayout.h    |    2
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |    6
 fs/nfs/inode.c                            |    4
 fs/nfs/internal.h                         |   60 ++
 fs/nfs/localio.c                          |  827 ++++++++++++++++++++++++++++++
 fs/nfs/nfs4xdr.c                          |   13
 fs/nfs/nfstrace.h                         |   61 ++
 fs/nfs/pagelist.c                         |   32 -
 fs/nfs/pnfs.c                             |   24
 fs/nfs/pnfs.h                             |    6
 fs/nfs/pnfs_nfs.c                         |    2
 fs/nfs/write.c                            |   13
 fs/nfs_common/Makefile                    |    3
 fs/nfs_common/nfslocalio.c                |   74 ++
 fs/nfsd/netns.h                           |    4
 fs/nfsd/nfssvc.c                          |   12
 include/linux/nfs.h                       |    9
 include/linux/nfs_fs.h                    |    2
 include/linux/nfs_fs_sb.h                 |   10
 include/linux/nfs_xdr.h                   |   20
 include/linux/nfslocalio.h                |   39 +
 include/linux/sunrpc/auth.h               |    4
 net/sunrpc/auth.c                         |   15
 net/sunrpc/clnt.c                         |    1
 31 files changed, 1354 insertions(+), 75 deletions(-)

Unfortunately there are the fs/nfsd/netns.h and fs/nfsd/nfssvc.c
changes that anchor everything (patch 5).

I suppose we could invert the order, such that NFSD comes before NFS
changes.  But then the NFS tree will need to be rebased on NFSD tree.

Diffstat for NFSD (patches 13 - 19):

 Documentation/filesystems/nfs/localio.rst |  135 ++++++++++++
 fs/nfsd/Kconfig                           |   14 +
 fs/nfsd/Makefile                          |    1 
 fs/nfsd/filecache.c                       |    2 
 fs/nfsd/localio.c                         |  319 ++++++++++++++++++++++++++++++
 fs/nfsd/netns.h                           |    8 
 fs/nfsd/nfsctl.c                          |    2 
 fs/nfsd/nfsd.h                            |    2 
 fs/nfsd/nfssvc.c                          |  104 +++++++--
 fs/nfsd/trace.h                           |    3 
 fs/nfsd/vfs.h                             |    9 
 include/linux/nfslocalio.h                |    2 
 include/linux/sunrpc/svc.h                |    7 
 net/sunrpc/svc.c                          |   68 +++---
 net/sunrpc/svc_xprt.c                     |    2 
 net/sunrpc/svcauth_unix.c                 |    3 
 16 files changed, 621 insertions(+), 60 deletions(-)

Happy to work it however you think is best.

> > Worked with Kent Overstreet to enable testing integration with ktest
> > running xfstests, the dashboard is here:
> > https://evilpiepirate.org/~testdashboard/ci?branch=snitm-nfs
> > (it is running way more xfstests tests than is usual for nfs, would be
> > good to reconcile that with the listing provided here:
> > https://wiki.linux-nfs.org/wiki/index.php/Xfstests )
> 
> Actually, we're using kdevops for NFSD CI testing. Any possibility
> that we can get some help setting that up? (It runs xfstests and
> several other workflows).

Sure, I can get with you off-list if that's best?  I just need some
pointers/access to help get it going.

Thanks,
Mike

