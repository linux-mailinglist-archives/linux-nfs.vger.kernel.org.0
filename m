Return-Path: <linux-nfs+bounces-8207-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B42419D672D
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Nov 2024 03:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371E6161661
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Nov 2024 02:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003834A29;
	Sat, 23 Nov 2024 02:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otOaiNlc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8F64A0A
	for <linux-nfs@vger.kernel.org>; Sat, 23 Nov 2024 02:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732329085; cv=none; b=gxQ86XWfDURiFR1G0XgotldKJwkM8IfLV0w4OTA98ZBFsp+7XSjhF65pO62faQSsVJnhlt7meEn2hyfFdJQtoy8xEpci0v9lZbJsmXYxlqE5mrzyIF1VwaTGYwcti6rw4ukJ68zfSy/C48QGR3QlinIvIxiiyOOdACY4101x+Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732329085; c=relaxed/simple;
	bh=w8O24brTWsFoek4IyqNzkGa8wSHvH1NhOFclU6mT7wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFRx5yqCJmfTzD4JKEgJe8rZmYY9/W6ze8ZIOMUAd1KSEa+KoPejwHt+rzaUkVERtXwc0Rx2fmn4KnQ7HwSHn8aggadVHkgfKZVbL1/Nr079uK7grDBqmkPrM4Ll8QMxFKKgFnpBIcBrOOi6o2A+U6AUSt/9dnfO/W00Xe5I2t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otOaiNlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06057C4CECE;
	Sat, 23 Nov 2024 02:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732329085;
	bh=w8O24brTWsFoek4IyqNzkGa8wSHvH1NhOFclU6mT7wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=otOaiNlc5l9x9n9gjhjDitJ6VLN291w8Pnxjcu7uoNmAkLFP0BIecg+cLtfzjBT9D
	 ofnOAT54xjXenSh4WDhs6HBM7BcdWTU45irGtlWcKBp8T0WcVsOYHx7DuEQQyPijIO
	 hJ9GFHgp6L+fKpVxzR0Lc0QsK6zGjPAGvt9Uk1nEshScmOtLvr3fJa88PrihoWgB4i
	 zJhBxMwf+pooFZfJPSSUagEQK56PrsnrDhq2xqnuYGhdQpHwPR9JJBEfEzKBrSK9CB
	 ldiC5RBWUE45Bsla5MCwmYyFl3ikI69TzS8ctdHLen/YbbEb79Ixm32eBkKObfPk+F
	 QInHA9330O+AQ==
Date: Fri, 22 Nov 2024 21:31:23 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>
Subject: Re: [for-6.13 PATCH v3 00/14] nfs/nfsd: improvements for LOCALIO
Message-ID: <Z0E-e7p5FtWWVKeV@kernel.org>
References: <20241116014106.25456-1-snitzer@kernel.org>
 <754757a44ac96f894c82338ec3212cf7202d540a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <754757a44ac96f894c82338ec3212cf7202d540a.camel@kernel.org>

On Fri, Nov 22, 2024 at 12:26:39PM -0500, Jeff Layton wrote:
> On Fri, 2024-11-15 at 20:40 -0500, Mike Snitzer wrote:
> > Hi,
> > 
> > All available here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next
> > 
> > Changes since v2:
> > - switched from rcu_assign_pointer to RCU_INIT_POINTER when setting to
> >   NULL.
> > - removed some unnecessary #if IS_ENABLED(CONFIG_NFS_LOCALIO)
> > - revised the NFS v3 probe patch to use a new nfsv3.ko modparam
> >   'nfs3_localio_probe_throttle' to control if NFSv3 will probe for
> >   LOCALIO. Avoids use of NFS_CS_LOCAL_IO and will probe every
> >   'nfs3_localio_probe_throttle' IO requests (defaults to 0, disabled).
> > - added "Module Parameters" section to localio.rst
> > 
> > All review appreciated, thanks.
> > Mike
> > 
> > Mike Snitzer (14):
> >   nfs/localio: add direct IO enablement with sync and async IO support
> >   nfsd: add nfsd_file_{get,put} to 'nfs_to' nfsd_localio_operations
> >   nfs_common: rename functions that invalidate LOCALIO nfs_clients
> >   nfs_common: move localio_lock to new lock member of nfs_uuid_t
> >   nfs: cache all open LOCALIO nfsd_file(s) in client
> >   nfsd: update percpu_ref to manage references on nfsd_net
> >   nfsd: rename nfsd_serv_ prefixed methods and variables with nfsd_net_
> >   nfsd: nfsd_file_acquire_local no longer returns GC'd nfsd_file
> >   nfs_common: rename nfslocalio nfs_uuid_lock to nfs_uuids_lock
> >   nfs_common: track all open nfsd_files per LOCALIO nfs_client
> >   nfs_common: add nfs_localio trace events
> >   nfs/localio: remove redundant code and simplify LOCALIO enablement
> >   nfs: probe for LOCALIO when v4 client reconnects to server
> >   nfs: probe for LOCALIO when v3 client reconnects to server
> > 
> >  Documentation/filesystems/nfs/localio.rst |  98 +++++----
> >  fs/nfs/client.c                           |   6 +-
> >  fs/nfs/direct.c                           |   1 +
> >  fs/nfs/flexfilelayout/flexfilelayout.c    |  25 +--
> >  fs/nfs/flexfilelayout/flexfilelayout.h    |   1 +
> >  fs/nfs/inode.c                            |   3 +
> >  fs/nfs/internal.h                         |   9 +-
> >  fs/nfs/localio.c                          | 232 +++++++++++++++-----
> >  fs/nfs/nfs3proc.c                         |  46 +++-
> >  fs/nfs/nfs4state.c                        |   1 +
> >  fs/nfs/nfstrace.h                         |  32 ---
> >  fs/nfs/pagelist.c                         |   5 +-
> >  fs/nfs/write.c                            |   3 +-
> >  fs/nfs_common/Makefile                    |   3 +-
> >  fs/nfs_common/localio_trace.c             |  10 +
> >  fs/nfs_common/localio_trace.h             |  56 +++++
> >  fs/nfs_common/nfslocalio.c                | 250 +++++++++++++++++-----
> >  fs/nfsd/filecache.c                       |  20 +-
> >  fs/nfsd/localio.c                         |   9 +-
> >  fs/nfsd/netns.h                           |  12 +-
> >  fs/nfsd/nfsctl.c                          |   6 +-
> >  fs/nfsd/nfssvc.c                          |  40 ++--
> >  include/linux/nfs_fs.h                    |  22 +-
> >  include/linux/nfs_fs_sb.h                 |   3 +-
> >  include/linux/nfs_xdr.h                   |   1 +
> >  include/linux/nfslocalio.h                |  48 +++--
> >  26 files changed, 674 insertions(+), 268 deletions(-)
> >  create mode 100644 fs/nfs_common/localio_trace.c
> >  create mode 100644 fs/nfs_common/localio_trace.h
> > 
> 
> I went through the set and it looks mostly sane to me. The one concern
> I have is that you have the client set up to start caching nfsd files
> before there is a mechanism to call it and ask them to return them. You
> might see some weird behavior there on a bisect, but it looks like it
> all gets resolved in the end.

Yeah, couldn't see a better way to atomically pivot to the new disable
functionality without it needing to be a large muddled patch.

Shouldn't be bad even if someone did bisect, its only the server being
restarted during LOCALIO that could see issues (unlikely thing for
someone to be testing for specifically with a bisect).

> How do you intend for this to go in? Since most of this is client side,
> will this be going in via Trond/Anna's tree?

Yes, likely easiest to have it go through Trond/Anna's tree.  Trond
did have it in his testing tree, maybe your Reviewed-by helps it all
land.

> You can add:
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks,
Mike

