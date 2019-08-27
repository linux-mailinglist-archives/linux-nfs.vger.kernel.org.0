Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 830279EC2B
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2019 17:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfH0PRg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Aug 2019 11:17:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbfH0PRg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 27 Aug 2019 11:17:36 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91F782070B;
        Tue, 27 Aug 2019 15:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566919055;
        bh=1J5swPyXCKuTbz88FUBhhA0l7vB27nP7ZPr8ExIt1wc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mGnaGu6z1FRe6FyupDKbAA+vdf5f1256Vu8tupwgCxiNmgkL83BdORQvB85V6AvCl
         gpww3t1aXNiXXFB2G49na6tMX1ZEgnTO/dhBm/kjyBRpImWGtLCIkUfX/3bsQ9n6i+
         BEcJmhhE8ClsPbwcM1WPR2ealg6HCEGCzghvuDOc=
Message-ID: <7864c3d642f771f8a99f5d511ccd0a77e12ef4cb.camel@kernel.org>
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Date:   Tue, 27 Aug 2019 11:17:33 -0400
In-Reply-To: <61F77AD6-BD02-4322-B944-0DC263EB9BD8@oracle.com>
References: <20190826165021.81075-1-trond.myklebust@hammerspace.com>
         <20190826205156.GA27834@fieldses.org>
         <ef9f2791ef395d7c968a386ce0a32ea503d6478f.camel@hammerspace.com>
         <61F77AD6-BD02-4322-B944-0DC263EB9BD8@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2019-08-27 at 09:59 -0400, Chuck Lever wrote:
> > On Aug 26, 2019, at 5:02 PM, Trond Myklebust <trondmy@hammerspace.com> wrote:
> > 
> > On Mon, 2019-08-26 at 16:51 -0400, J. Bruce Fields wrote:
> > > On Mon, Aug 26, 2019 at 12:50:18PM -0400, Trond Myklebust wrote:
> > > > Recently, a number of changes went into the kernel to try to ensure
> > > > that I/O errors (specifically write errors) are reported to the
> > > > application once and only once. The vehicle for ensuring the errors
> > > > are reported is the struct file, which uses the 'f_wb_err' field to
> > > > track which errors have been reported.
> > > > 
> > > > The problem is that errors are mainly intended to be reported
> > > > through
> > > > fsync(). If the client is doing synchronous writes, then all is
> > > > well,
> > > > but if it is doing unstable writes, then the errors may not be
> > > > reported until the client calls COMMIT. If the file cache has
> > > > thrown out the struct file, due to memory pressure, or just because
> > > > the client took a long while between the last WRITE and the COMMIT,
> > > > then the error report may be lost, and the client may just think
> > > > its data is safely stored.
> > > 
> > > These were lost before the file caching patches as well, right?  Or
> > > is
> > > there some regression? 
> > 
> > Correct. This is not a regression, but an attempt to fix a problem that
> > has existed for some time now.
> > 
> > > > Note that the problem is compounded by the fact that NFSv3 is
> > > > stateless,
> > > > so the server never knows that the client may have rebooted, so
> > > > there
> > > > can be no guarantee that a COMMIT will ever be sent.
> > > > 
> > > > The following patch set attempts to remedy the situation using 2
> > > > strategies:
> > > > 
> > > > 1) If the inode is dirty, then avoid garbage collecting the file
> > > >   from the file cache.
> > > > 2) If the file is closed, and we see that it would have reported
> > > >   an error to COMMIT, then we bump the boot verifier in order to
> > > >   ensure the client retransmits all its writes.
> > > 
> > > Sounds sensible to me.
> > > 
> > > > Note that if multiple clients were writing to the same file, then
> > > > we probably want to bump the boot verifier anyway, since only one
> > > > COMMIT will see the error report (because the cached file is also
> > > > shared).
> > > 
> > > I'm confused by the "probably should".  So that's future work?  I
> > > guess
> > > it'd mean some additional work to identify that case.  You can't
> > > really
> > > even distinguish clients in the NFSv3 case, but I suppose you could
> > > use
> > > IP address or TCP connection as an approximation.
> > 
> > I'm suggesting we should do this too, but I haven't done so yet in
> > these patches. I'd like to hear other opinions (particularly from you,
> > Chuck and Jeff).
> 
> The strategy of handling these errors more carefully seems good.
> Bumping the write/commit verifier so the client writes again to
> retrieve the latent error is clever!
> 

Yes, this would seem to neatly solve a whole class of related problems
in these sorts of scenarios. I also think we ought to bump the verifier
whenever nfsd sees a writeback error, as you have a great point that
we'll only report writeback errors on the first COMMIT after an error
today. Fixing that would be a nice goal.

We should note though that the verifier is a per net-namespace value, so
if you get a transient writeback error on one inode, any inode that is
currently dirty will probably end up having its writes retransmitted
once you bump the verifier.

That seems like an acceptable thing to do in these scenarios, but we may
need to consider making the verifier more granular if that turns out to
cause a lot of re-write activity that isn't necessary.

> It's not clear to me though that the NFSv3 protocol can deal with
> the multi-client write scenario, since it is stateless. We are now
> making it stateful in some sense by preserving error state on the
> server across NFS requests, without having any sense of an open
> file in the protocol itself.
> 

I think it's worthwhile to do the best we can here. WRITE/COMMIT are
inherently stateful to some degree in that they involve a verifier.
Trond's proposal is just utilizing that fact to ensure that we deliver
writeback errors more widely. I like it!

> Would an "approximation" without open state be good enough? I
> assume you are doing this to more fully support the FlexFiles
> layout type. Do you have any analysis or thought about this next
> step?
> 
> I also echo Bruce's concern about whether the client implementations
> are up to snuff. There could be long-standing bugs or their protocol
> implementation could be missing parts. This is more curiosity than
> an objection, but maybe noting which client implementations you've
> tested with would be good.
> 
> 
> > > --b.
> > > 
> > > > So in order to implement the above strategy, we first have to do
> > > > the following: split up the file cache to act per net namespace,
> > > > since the boot verifier is per net namespace. Then add a helper
> > > > to update the boot verifier.
> > > > 
> > > > Trond Myklebust (3):
> > > >  nfsd: nfsd_file cache entries should be per net namespace
> > > >  nfsd: Support the server resetting the boot verifier
> > > >  nfsd: Don't garbage collect files that might contain write errors
> > > > 
> > > > fs/nfsd/export.c    |  2 +-
> > > > fs/nfsd/filecache.c | 76 +++++++++++++++++++++++++++++++++++++--
> > > > ------
> > > > fs/nfsd/filecache.h |  3 +-
> > > > fs/nfsd/netns.h     |  4 +++
> > > > fs/nfsd/nfs3xdr.c   | 13 +++++---
> > > > fs/nfsd/nfs4proc.c  | 14 +++------
> > > > fs/nfsd/nfsctl.c    |  1 +
> > > > fs/nfsd/nfssvc.c    | 32 ++++++++++++++++++-
> > > > 8 files changed, 115 insertions(+), 30 deletions(-)
> > > > 
> > > > -- 
> > > > 2.21.0
> > -- 
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> 
> --
> Chuck Lever
> 
> 
> 

-- 
Jeff Layton <jlayton@kernel.org>

