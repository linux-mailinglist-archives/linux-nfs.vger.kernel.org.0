Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F4448B7BF
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jan 2022 21:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbiAKUBi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jan 2022 15:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241662AbiAKUBi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jan 2022 15:01:38 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823F0C06173F
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jan 2022 12:01:38 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 721C570C2; Tue, 11 Jan 2022 15:01:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 721C570C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641931297;
        bh=2JDqY4M0JgqVm2iMvz8tdGgCR5N46oW7j5f1pyo5J+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J06UI9iug2VVj+NV01RVznm8OjfQ/YguJ39PUWI7+PyfLolyFZ0EKBbrk0AYzjJHa
         zrNWKGeQddZWUo9RzlqleOFJVSEbjVWZ18iozl7/i+k/nw3O1Fd8jFHvesW1sNlT97
         Dqk32PQv/EH2Aw1Z6dt99u73NYC4YHHuF6MqhE9M=
Date:   Tue, 11 Jan 2022 15:01:37 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs@vger.kernel.org, luis.turcitu@appsbroker.com,
        chris.chilvers@appsbroker.com, david.young@appsbroker.com,
        daire@dneg.com, david.oberhollenzer@sigma-star.at,
        david@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com
Subject: Re: [RFC PATCH 0/3] Dealing with NFS re-export and cross mounts
Message-ID: <20220111200137.GD4035@fieldses.org>
References: <20220110184419.27665-1-richard@nod.at>
 <20220111194337.GC4035@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111194337.GC4035@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 11, 2022 at 02:43:37PM -0500, J. Bruce Fields wrote:
> On Mon, Jan 10, 2022 at 07:44:16PM +0100, Richard Weinberger wrote:
> > rpc.mountd could:
> > a) re-use the fsid from the original NFS server.
> >    Beside of requesting this information, the problem with that approach is
> >    that the original fsid might conflict with an existing export.
> > b) derive the fsid from stat->st_dev.
> > c) allocate a free fsid.
> >  
> > One use case to consider is load balancing. When multiple NFS servers re-export
> > a NFS mount, they need to use the same fsid for crossed mounts.

I guess if rpc.mountd kept an on-disk database of fsid's, it wouldn't be
too big a deal to later enhance that with the option of a distributed
database.

So I'm leaning towards picking a random fsid and sticking it in a
database.  When you encouter a new filesystem you'd need to make sure
the addition of a new entry is atomic and persistent before returning to
knfsd.

It'd be nice if mountd had an easy way to query the on-the-wire fsid
from userspace, and then you could index entries on the fsid.  Absent
that, maybe just indexing on server and path would be good enough.

I'm not sure how NFS's st_dev's are generated.  I think they might
depend on stuff that isn't necessarily the same on each boot (like the
order the NFS filesystems were mounted in), so they wouldn't work.

--b.

> > So I'm a little puzzled which approach is best. What do you think?
> > 
> > Known issues:
> > - Only tested with NFSv3 (both server and client) so far.
> > 
> > [0] https://marc.info/?l=linux-nfs&m=161653016627277&w=2
> > 
> > Richard Weinberger (3):
> >   NFSD: Teach nfsd_mountpoint() auto mounts
> >   fs: namei: Allow follow_down() to uncover auto mounts
> >   NFS: nfs_encode_fh: Remove S_AUTOMOUNT check
> > 
> >  fs/namei.c      | 2 +-
> >  fs/nfs/export.c | 5 -----
> >  fs/nfsd/vfs.c   | 2 +-
> >  3 files changed, 2 insertions(+), 7 deletions(-)
> > 
> > -- 
> > 2.26.2
