Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8887F48B78F
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jan 2022 20:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbiAKTnk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jan 2022 14:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbiAKTnj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jan 2022 14:43:39 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2027C06173F
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jan 2022 11:43:39 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id B78364C7F; Tue, 11 Jan 2022 14:43:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B78364C7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641930217;
        bh=CsNcwSrsvAHZFzeTQGz3QK+kODx+UOssswuZydny5ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k6HmMmUuAuF4CUDqW+ignRhVRE0zg3AVhG4vke6dbBtYrQRigTOew06PgmbM1VYvk
         jt6BPhZUaNQubMECL5fN4kSCiXq86nBKi1ajwJii8gSKQEz2U1OgdODGVI3ogzPxCQ
         gwyArQhVAun4w3c1NcZa1HQ6HOQHvjRAzYcoRPNI=
Date:   Tue, 11 Jan 2022 14:43:37 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-nfs@vger.kernel.org, luis.turcitu@appsbroker.com,
        chris.chilvers@appsbroker.com, david.young@appsbroker.com,
        daire@dneg.com, david.oberhollenzer@sigma-star.at,
        david@sigma-star.at, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com
Subject: Re: [RFC PATCH 0/3] Dealing with NFS re-export and cross mounts
Message-ID: <20220111194337.GC4035@fieldses.org>
References: <20220110184419.27665-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220110184419.27665-1-richard@nod.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 10, 2022 at 07:44:16PM +0100, Richard Weinberger wrote:
> Currently when re-exporting a NFS share the NFS cross mount feature does
> not work [0].
> This RFC patch series outlines an approach to address the problem.
> 
> Crossing mounts does not work for two reasons:
> 
> 1. As soon the NFS client (on the re-exporting server) sees a different
> filesystem id, it installs an automount. That way the other filesystem
> will be mounted automatically when someone enters the directory.
> But the cross mount logic of KNFS does not know about automount.
> The three patches in this series address the problem and teach both KNFSD
> and the exportfs logic of NFS to deal with automount.
> 
> 2. When KNFSD detects crossing of a mount point, it asks rpc.mountd to install
> a new export for the target mount point. Beside of authentication rpc.mountd
> also has to find a filesystem id for the new export. Is the to be exported
> filesystem a NFS share, rpc.mountd cannot derive a filesystem id from it and
> refuses to export. In the logs you’ll see error such as:
> mountd: Cannot export /srv/nfs/vol0, possibly unsupported filesystem or fsid= required
> To deal with that I changed rpc.mountd to use an arbitrary fsid.
> Since this is a gross hack we need to agree on an approach to derive filesystem
> ids for NFS mounts.

The toughest problem to deal with is reboot of the re-export server.  If
you want this to work across reboots, then you need to pick an fsid that
will be the same across reboots.

Also, you need to deal with getting an fsid for a filesystem that isn't
mounted yet.  That's because, if you reboot while a client is using
/srv/nfs/vol0, when you come back up, the client *isn't* going to look
up the path /srv/nfs/vol0 again--it's just going to give you a
filehandle for some object under there, and you're going to have to
figure out what to do with that.

Simplest might be recording the fsid's you use in an on-disk database.
knfsd makes an upcall to rpc.mountd each time it encounters a new fsid,
so maybe that'd mean you could do all the management of that database in
rpc.mountd and minimize required kernel patches.

Maybe a last-resort option would be just to not support reboot of the
re-export server.  That's already what we do for locking.  I'm not happy
about that, and have some vague ideas how it might be fixed, but not
anything that's likely to be done soon.

Then I think a random fsid might be OK.  I believe fsids can be up to 32
bits so there's effectively no chance of collisions.

But, I can't remember, can those nfs automounts expire?  An export that
looks idle from the server's point of view might still be in use by a
client, so we can't drop that mount and then get stuck returning ESTALE
when the client does eventually try to use it.

--b.

> 
> rpc.mountd could:
> a) re-use the fsid from the original NFS server.
>    Beside of requesting this information, the problem with that approach is
>    that the original fsid might conflict with an existing export.
> b) derive the fsid from stat->st_dev.
> c) allocate a free fsid.
>  
> One use case to consider is load balancing. When multiple NFS servers re-export
> a NFS mount, they need to use the same fsid for crossed mounts.
> So I'm a little puzzled which approach is best. What do you think?
> 
> Known issues:
> - Only tested with NFSv3 (both server and client) so far.
> 
> [0] https://marc.info/?l=linux-nfs&m=161653016627277&w=2
> 
> Richard Weinberger (3):
>   NFSD: Teach nfsd_mountpoint() auto mounts
>   fs: namei: Allow follow_down() to uncover auto mounts
>   NFS: nfs_encode_fh: Remove S_AUTOMOUNT check
> 
>  fs/namei.c      | 2 +-
>  fs/nfs/export.c | 5 -----
>  fs/nfsd/vfs.c   | 2 +-
>  3 files changed, 2 insertions(+), 7 deletions(-)
> 
> -- 
> 2.26.2
