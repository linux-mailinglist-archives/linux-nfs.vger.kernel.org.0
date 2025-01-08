Return-Path: <linux-nfs+bounces-8973-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4FBA06117
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 17:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D752E1884843
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 16:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155E21FE47F;
	Wed,  8 Jan 2025 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ0uKDYT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E532017E900
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352357; cv=none; b=cKpHeyhrC0/+lXEleOPFZ4yCmiG3fm++Ym3uiBorrQT3a87e6vf20RaX9aQj/DdD0xsLJQnLpasLXUfMJjojDHNoVajngm5qu7YSo9gOed5ZwD2XIO6s2p0LR3Q1GD2RrZV7TFdG3ra6HrZ8adim9SUgvutzp1PQ4lJD+8u1oGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352357; c=relaxed/simple;
	bh=67yFeBTkZu7U/XzpUdl8mByVJuKacm/x5j+PZkG72oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8qv+g7OyMN1rWpWZam3KMl3+bN01SzVn86CDLfK8vChw3BITv/N9kuUGMG2LGCUx0YEx6NsMww9cCQQV8Vp7nl8+dt+mXthvjUb99iYDK4cMnyomnZhtLIIIRipLLFcHeHlreyXH7KyUb5Q91mXOU9bhCfW8BBuTbGFjchUM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ0uKDYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300C4C4CED3;
	Wed,  8 Jan 2025 16:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736352356;
	bh=67yFeBTkZu7U/XzpUdl8mByVJuKacm/x5j+PZkG72oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQ0uKDYTViSx7JPkkpITJe231E7p1t5Z9R2IVL0FQmdWCW8l9HkwXaF1wkauCR+Wi
	 at/651rdl3af7Wu1OXipfnCDt8Clzzp8AL+JA+xR9Dr35Nig28jkQUN0MHfOdew5NT
	 Ry2xMJ+W6N2CkjIffSCThXI9oEPqlb183aQgqgVxuLMtefe2AbeO0/91gm7dfjtgdZ
	 DUJxbfPQo9yzbeddX0tH8giV0f/VF1sz4f+AyL0vvjWxU6ySub34FSwUixKjUBPiWK
	 VMyP53HJKCm+qgMzqDKgebB4Em1aP08WV91LCwhOT3t2sdl7xYxnRGweHhSiy+Pu9H
	 SwjcGJvgCf92g==
Date: Wed, 8 Jan 2025 11:05:55 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org
Subject: Re: [for-6.13 PATCH v3 00/14] nfs/nfsd: improvements for LOCALIO
Message-ID: <Z36iY7nJT5ngLddS@kernel.org>
References: <20241116014106.25456-1-snitzer@kernel.org>
 <754757a44ac96f894c82338ec3212cf7202d540a.camel@kernel.org>
 <Z0E-e7p5FtWWVKeV@kernel.org>
 <Z2MG3X_PpbJRNzCw@kernel.org>
 <f0d7f601-a6ac-40d6-9665-e9a40e2dc00c@oracle.com>
 <23bc5e70-9d7a-4185-9645-0ba89cd43de0@oracle.com>
 <Z2M8blaSYonRmDYT@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2M8blaSYonRmDYT@kernel.org>

[top-posting because of my general inquiry]

Hi Anna,

I know Trond has been quite busy, I suspect you have been too
(holidays and all too).  I just wanted to check with you on this
patchset.

Given the 6.14 merge window is fast approaching, is there anything you
need from me?

Jeff did provide his Reviewed-by, and Chuck his Acked-by.  But would
it help for me to prepare a v4 that explicitly adds their tags
accordingly?

There is also this LOCALIO error path fix that should go upstream and
be marked for stable@:
https://lore.kernel.org/linux-nfs/20241227201356.3074-1-snitzer@kernel.org/

I could put that fix in the front of a v4 resubmission.  I'm also
perfectly fine to stand-down and let you review and apply if/when you
have time.. the patches haven't changed at all, but happy to sweep
through and do the v4 if it helps.

Thanks,
Mike


On Wed, Dec 18, 2024 at 04:19:42PM -0500, Mike Snitzer wrote:
> On Wed, Dec 18, 2024 at 04:05:23PM -0500, Chuck Lever wrote:
> > On 12/18/24 3:55 PM, Anna Schumaker wrote:
> > > 
> > > 
> > > On 12/18/24 12:31 PM, Mike Snitzer wrote:
> > > > On Fri, Nov 22, 2024 at 09:31:23PM -0500, Mike Snitzer wrote:
> > > > > On Fri, Nov 22, 2024 at 12:26:39PM -0500, Jeff Layton wrote:
> > > > > > On Fri, 2024-11-15 at 20:40 -0500, Mike Snitzer wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > All available here:
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next
> > > > > > > 
> > > > > > > Changes since v2:
> > > > > > > - switched from rcu_assign_pointer to RCU_INIT_POINTER when setting to
> > > > > > >    NULL.
> > > > > > > - removed some unnecessary #if IS_ENABLED(CONFIG_NFS_LOCALIO)
> > > > > > > - revised the NFS v3 probe patch to use a new nfsv3.ko modparam
> > > > > > >    'nfs3_localio_probe_throttle' to control if NFSv3 will probe for
> > > > > > >    LOCALIO. Avoids use of NFS_CS_LOCAL_IO and will probe every
> > > > > > >    'nfs3_localio_probe_throttle' IO requests (defaults to 0, disabled).
> > > > > > > - added "Module Parameters" section to localio.rst
> > > > > > > 
> > > > > > > All review appreciated, thanks.
> > > > > > > Mike
> > > > > > > 
> > > > > > > Mike Snitzer (14):
> > > > > > >    nfs/localio: add direct IO enablement with sync and async IO support
> > > > > > >    nfsd: add nfsd_file_{get,put} to 'nfs_to' nfsd_localio_operations
> > > > > > >    nfs_common: rename functions that invalidate LOCALIO nfs_clients
> > > > > > >    nfs_common: move localio_lock to new lock member of nfs_uuid_t
> > > > > > >    nfs: cache all open LOCALIO nfsd_file(s) in client
> > > > > > >    nfsd: update percpu_ref to manage references on nfsd_net
> > > > > > >    nfsd: rename nfsd_serv_ prefixed methods and variables with nfsd_net_
> > > > > > >    nfsd: nfsd_file_acquire_local no longer returns GC'd nfsd_file
> > > > > > >    nfs_common: rename nfslocalio nfs_uuid_lock to nfs_uuids_lock
> > > > > > >    nfs_common: track all open nfsd_files per LOCALIO nfs_client
> > > > > > >    nfs_common: add nfs_localio trace events
> > > > > > >    nfs/localio: remove redundant code and simplify LOCALIO enablement
> > > > > > >    nfs: probe for LOCALIO when v4 client reconnects to server
> > > > > > >    nfs: probe for LOCALIO when v3 client reconnects to server
> > > > > > > 
> > > > > > >   Documentation/filesystems/nfs/localio.rst |  98 +++++----
> > > > > > >   fs/nfs/client.c                           |   6 +-
> > > > > > >   fs/nfs/direct.c                           |   1 +
> > > > > > >   fs/nfs/flexfilelayout/flexfilelayout.c    |  25 +--
> > > > > > >   fs/nfs/flexfilelayout/flexfilelayout.h    |   1 +
> > > > > > >   fs/nfs/inode.c                            |   3 +
> > > > > > >   fs/nfs/internal.h                         |   9 +-
> > > > > > >   fs/nfs/localio.c                          | 232 +++++++++++++++-----
> > > > > > >   fs/nfs/nfs3proc.c                         |  46 +++-
> > > > > > >   fs/nfs/nfs4state.c                        |   1 +
> > > > > > >   fs/nfs/nfstrace.h                         |  32 ---
> > > > > > >   fs/nfs/pagelist.c                         |   5 +-
> > > > > > >   fs/nfs/write.c                            |   3 +-
> > > > > > >   fs/nfs_common/Makefile                    |   3 +-
> > > > > > >   fs/nfs_common/localio_trace.c             |  10 +
> > > > > > >   fs/nfs_common/localio_trace.h             |  56 +++++
> > > > > > >   fs/nfs_common/nfslocalio.c                | 250 +++++++++++++++++-----
> > > > > > >   fs/nfsd/filecache.c                       |  20 +-
> > > > > > >   fs/nfsd/localio.c                         |   9 +-
> > > > > > >   fs/nfsd/netns.h                           |  12 +-
> > > > > > >   fs/nfsd/nfsctl.c                          |   6 +-
> > > > > > >   fs/nfsd/nfssvc.c                          |  40 ++--
> > > > > > >   include/linux/nfs_fs.h                    |  22 +-
> > > > > > >   include/linux/nfs_fs_sb.h                 |   3 +-
> > > > > > >   include/linux/nfs_xdr.h                   |   1 +
> > > > > > >   include/linux/nfslocalio.h                |  48 +++--
> > > > > > >   26 files changed, 674 insertions(+), 268 deletions(-)
> > > > > > >   create mode 100644 fs/nfs_common/localio_trace.c
> > > > > > >   create mode 100644 fs/nfs_common/localio_trace.h
> > > > > > > 
> > > > > > 
> > > > > > I went through the set and it looks mostly sane to me. The one concern
> > > > > > I have is that you have the client set up to start caching nfsd files
> > > > > > before there is a mechanism to call it and ask them to return them. You
> > > > > > might see some weird behavior there on a bisect, but it looks like it
> > > > > > all gets resolved in the end.
> > > > > 
> > > > > Yeah, couldn't see a better way to atomically pivot to the new disable
> > > > > functionality without it needing to be a large muddled patch.
> > > > > 
> > > > > Shouldn't be bad even if someone did bisect, its only the server being
> > > > > restarted during LOCALIO that could see issues (unlikely thing for
> > > > > someone to be testing for specifically with a bisect).
> > > > > 
> > > > > > How do you intend for this to go in? Since most of this is client side,
> > > > > > will this be going in via Trond/Anna's tree?
> > > > > 
> > > > > Yes, likely easiest to have it go through Trond/Anna's tree.  Trond
> > > > > did have it in his testing tree, maybe your Reviewed-by helps it all
> > > > > land.
> > > > > 
> > > > > > You can add:
> > > > > > 
> > > > > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > > > 
> > > > > Thanks,
> > > > > Mike
> > > > > 
> > > > 
> > > > Hi all,
> > > > 
> > > > These LOCALIO changes didn't land for 6.13 merge, please advise on if
> > > > we might get these changes staged for 6.14 now-ish.
> > > 
> > > Works for me.
> > > 
> > > > 
> > > > Trond and/or Anna, do you feel comfortable picking this series up
> > > > (nfsd cachnges too) or would you like to see any changes before that
> > > > is possible?
> > > 
> > > I'll go through the patches once more, but they should be fine. I will need Acked-by's for the NFSD bits from Chuck or Jeff.
> > 
> > Looks like Jeff gave his Reviewed-by for the series already.
> > 
> > I had asked for some minor changes, haven't seen them go by,
> 
> Only thing I was aware of, and addressed in v2, was this:
> https://lore.kernel.org/all/ZzNm0hekxOyAUhib@tissot.1015granger.net/
> 
> I added a module parameters section to the localio.rst and mentioned
> that in v2's 0th header:
> https://lore.kernel.org/r/all/20241114035952.13889-1-snitzer@kernel.org/
> 
> with:
> 
> "- updated Documentation/filesystems/nfs/localio.rst to reflect the
>   percpu_ref change from nfsd_serv to nfsd_net. Also discuss O_DIRECT
>   relative to LOCALIO and document the nfs module param (Chuck, I do
>   think we need it, otherwise O_DIRECT regressions are possible)."
> 
> > but, for the NFSD-related hunks:
> > 
> > Acked-by: Chuck Lever <chuck.lever@oracle.com>
> 
> Thanks!
> 

