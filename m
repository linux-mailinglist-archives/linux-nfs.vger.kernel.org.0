Return-Path: <linux-nfs+bounces-8659-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A37C79F6F3E
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 22:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 762BE7A224D
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 21:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DE41FCF74;
	Wed, 18 Dec 2024 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVrioAwk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD4C14D283
	for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2024 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734556026; cv=none; b=dPMpDFWwRKFpA2LYZi8YZiIFgqLPf1yMIxW/GRD2sjRLC1eaQqUY6QwRY1LNw4AfTJOtUerOFjYGC2httI9OtXSriu6pqpFHQg1F+6bbiU5Dn3L1uB0fwCk+a83hDL+Eq2mX70e8X6QWn6H3WZBeaOFjcCsQ8uDCWFKfCquvgmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734556026; c=relaxed/simple;
	bh=uPuFJCdmViqxBRvo8YY6rqSEFHXl9F3n2AbJ+8fmYxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow5StFyrTGwdeNWvTtqpY8l/ZXCmviLXC/s7l9FM/qHsg8Y9hv73ThBs/fuxhg5AqpvvqjIhekUykogzqievUEdV6u7gpOQebwgrmE+9G2RCwBloVXEA+i1SwUwm5LgeUDvCkMy0rpPdoPwLDJq7grdcjzMi/38jFNrDVK3MtJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVrioAwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72168C4CECD;
	Wed, 18 Dec 2024 21:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734556025;
	bh=uPuFJCdmViqxBRvo8YY6rqSEFHXl9F3n2AbJ+8fmYxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NVrioAwkMhuBn6pabUqqsxn0BPlWowTb1WuhgJ3Kiky4mu9JRmChAz/PAOBbINgI3
	 ZnlBahRsvTKfHD3G8bdtvt5zadX4EnwXdpED3R40DsNRVC+IbudM9KRBfh0fiGLpgB
	 q0tVupXzOSUL6aiRu6rqH/hD5OPw4erTsrl649QKfMa7JySMgUvtfaZe1oN1jxr/8U
	 nczbj/Z6rAi2yvEBEo0Jo5XndMvNPislhqCXiIFODu0yhkg0x7gywT0yt+pSBDQGVq
	 OqtGdcCz+H2fnRzvvzG6PoXfYokM+cgKvEhcSVfVMmt0m+PBbM+nLIFXvzQlozuo7D
	 6LY8px2DWPgHA==
Date: Wed, 18 Dec 2024 16:07:04 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>,
	linux-nfs@vger.kernel.org
Subject: Re: [for-6.13 PATCH v3 00/14] nfs/nfsd: improvements for LOCALIO
Message-ID: <Z2M5eJDpX6PUejTs@kernel.org>
References: <20241116014106.25456-1-snitzer@kernel.org>
 <754757a44ac96f894c82338ec3212cf7202d540a.camel@kernel.org>
 <Z0E-e7p5FtWWVKeV@kernel.org>
 <Z2MG3X_PpbJRNzCw@kernel.org>
 <f0d7f601-a6ac-40d6-9665-e9a40e2dc00c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0d7f601-a6ac-40d6-9665-e9a40e2dc00c@oracle.com>

On Wed, Dec 18, 2024 at 03:55:16PM -0500, Anna Schumaker wrote:
> 
> 
> On 12/18/24 12:31 PM, Mike Snitzer wrote:
> > On Fri, Nov 22, 2024 at 09:31:23PM -0500, Mike Snitzer wrote:
> >> On Fri, Nov 22, 2024 at 12:26:39PM -0500, Jeff Layton wrote:
> >>> On Fri, 2024-11-15 at 20:40 -0500, Mike Snitzer wrote:
> >>>> Hi,
> >>>>
> >>>> All available here:
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next
> >>>>
> >>>> Changes since v2:
> >>>> - switched from rcu_assign_pointer to RCU_INIT_POINTER when setting to
> >>>>   NULL.
> >>>> - removed some unnecessary #if IS_ENABLED(CONFIG_NFS_LOCALIO)
> >>>> - revised the NFS v3 probe patch to use a new nfsv3.ko modparam
> >>>>   'nfs3_localio_probe_throttle' to control if NFSv3 will probe for
> >>>>   LOCALIO. Avoids use of NFS_CS_LOCAL_IO and will probe every
> >>>>   'nfs3_localio_probe_throttle' IO requests (defaults to 0, disabled).
> >>>> - added "Module Parameters" section to localio.rst
> >>>>
> >>>> All review appreciated, thanks.
> >>>> Mike
> >>>>
> >>>> Mike Snitzer (14):
> >>>>   nfs/localio: add direct IO enablement with sync and async IO support
> >>>>   nfsd: add nfsd_file_{get,put} to 'nfs_to' nfsd_localio_operations
> >>>>   nfs_common: rename functions that invalidate LOCALIO nfs_clients
> >>>>   nfs_common: move localio_lock to new lock member of nfs_uuid_t
> >>>>   nfs: cache all open LOCALIO nfsd_file(s) in client
> >>>>   nfsd: update percpu_ref to manage references on nfsd_net
> >>>>   nfsd: rename nfsd_serv_ prefixed methods and variables with nfsd_net_
> >>>>   nfsd: nfsd_file_acquire_local no longer returns GC'd nfsd_file
> >>>>   nfs_common: rename nfslocalio nfs_uuid_lock to nfs_uuids_lock
> >>>>   nfs_common: track all open nfsd_files per LOCALIO nfs_client
> >>>>   nfs_common: add nfs_localio trace events
> >>>>   nfs/localio: remove redundant code and simplify LOCALIO enablement
> >>>>   nfs: probe for LOCALIO when v4 client reconnects to server
> >>>>   nfs: probe for LOCALIO when v3 client reconnects to server
> >>>>
> >>>>  Documentation/filesystems/nfs/localio.rst |  98 +++++----
> >>>>  fs/nfs/client.c                           |   6 +-
> >>>>  fs/nfs/direct.c                           |   1 +
> >>>>  fs/nfs/flexfilelayout/flexfilelayout.c    |  25 +--
> >>>>  fs/nfs/flexfilelayout/flexfilelayout.h    |   1 +
> >>>>  fs/nfs/inode.c                            |   3 +
> >>>>  fs/nfs/internal.h                         |   9 +-
> >>>>  fs/nfs/localio.c                          | 232 +++++++++++++++-----
> >>>>  fs/nfs/nfs3proc.c                         |  46 +++-
> >>>>  fs/nfs/nfs4state.c                        |   1 +
> >>>>  fs/nfs/nfstrace.h                         |  32 ---
> >>>>  fs/nfs/pagelist.c                         |   5 +-
> >>>>  fs/nfs/write.c                            |   3 +-
> >>>>  fs/nfs_common/Makefile                    |   3 +-
> >>>>  fs/nfs_common/localio_trace.c             |  10 +
> >>>>  fs/nfs_common/localio_trace.h             |  56 +++++
> >>>>  fs/nfs_common/nfslocalio.c                | 250 +++++++++++++++++-----
> >>>>  fs/nfsd/filecache.c                       |  20 +-
> >>>>  fs/nfsd/localio.c                         |   9 +-
> >>>>  fs/nfsd/netns.h                           |  12 +-
> >>>>  fs/nfsd/nfsctl.c                          |   6 +-
> >>>>  fs/nfsd/nfssvc.c                          |  40 ++--
> >>>>  include/linux/nfs_fs.h                    |  22 +-
> >>>>  include/linux/nfs_fs_sb.h                 |   3 +-
> >>>>  include/linux/nfs_xdr.h                   |   1 +
> >>>>  include/linux/nfslocalio.h                |  48 +++--
> >>>>  26 files changed, 674 insertions(+), 268 deletions(-)
> >>>>  create mode 100644 fs/nfs_common/localio_trace.c
> >>>>  create mode 100644 fs/nfs_common/localio_trace.h
> >>>>
> >>>
> >>> I went through the set and it looks mostly sane to me. The one concern
> >>> I have is that you have the client set up to start caching nfsd files
> >>> before there is a mechanism to call it and ask them to return them. You
> >>> might see some weird behavior there on a bisect, but it looks like it
> >>> all gets resolved in the end.
> >>
> >> Yeah, couldn't see a better way to atomically pivot to the new disable
> >> functionality without it needing to be a large muddled patch.
> >>
> >> Shouldn't be bad even if someone did bisect, its only the server being
> >> restarted during LOCALIO that could see issues (unlikely thing for
> >> someone to be testing for specifically with a bisect).
> >>
> >>> How do you intend for this to go in? Since most of this is client side,
> >>> will this be going in via Trond/Anna's tree?
> >>
> >> Yes, likely easiest to have it go through Trond/Anna's tree.  Trond
> >> did have it in his testing tree, maybe your Reviewed-by helps it all
> >> land.
> >>
> >>> You can add:
> >>>
> >>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >>
> >> Thanks,
> >> Mike
> >>
> > 
> > Hi all,
> > 
> > These LOCALIO changes didn't land for 6.13 merge, please advise on if
> > we might get these changes staged for 6.14 now-ish.
> 
> Works for me.
> 
> > 
> > Trond and/or Anna, do you feel comfortable picking this series up
> > (nfsd cachnges too) or would you like to see any changes before that
> > is possible?
> 
> I'll go through the patches once more, but they should be fine. I will need Acked-by's for the NFSD bits from Chuck or Jeff.

OK, Jeff did already provide his Reviewed-by for the entire set (still
visible in the exchange I quoted above).

Thanks,
Mike

