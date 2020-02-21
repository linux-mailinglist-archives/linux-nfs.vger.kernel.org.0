Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9669F16883A
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2020 21:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgBUUVM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Fri, 21 Feb 2020 15:21:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47798 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726483AbgBUUVM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Feb 2020 15:21:12 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-MTjdiAeLMqaUO7dM2OcG-g-1; Fri, 21 Feb 2020 15:21:08 -0500
X-MC-Unique: MTjdiAeLMqaUO7dM2OcG-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14F70477;
        Fri, 21 Feb 2020 20:21:07 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-123-59.rdu2.redhat.com [10.10.123.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC7805D9E2;
        Fri, 21 Feb 2020 20:21:06 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 0821A1A00A4; Fri, 21 Feb 2020 15:21:06 -0500 (EST)
Date:   Fri, 21 Feb 2020 15:21:05 -0500
From:   Scott Mayhew <smayhew@redhat.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        dhowells@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFS: Don't hard-code the fs_type when submounting
Message-ID: <20200221202105.GA3175@aion.usersys.redhat.com>
References: <20200220130620.3547817-1-smayhew@redhat.com>
 <20200220134618.GA4641@ncase>
MIME-Version: 1.0
In-Reply-To: <20200220134618.GA4641@ncase>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aion.usersys.redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 20 Feb 2020, Patrick Steinhardt wrote:

> On Thu, Feb 20, 2020 at 08:06:20AM -0500, Scott Mayhew wrote:
> > Hard-coding the fstype causes "nfs4" mounts to appear as "nfs",
> > which breaks scripts that do "umount -at nfs4".
> > 
> > Reported-by: Patrick Steinhardt <ps@pks.im>
> > Fixes: f2aedb713c28 ("NFS: Add fs_context support.")
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  fs/nfs/namespace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
> > index ad6077404947..f3ece8ed3203 100644
> > --- a/fs/nfs/namespace.c
> > +++ b/fs/nfs/namespace.c
> > @@ -153,7 +153,7 @@ struct vfsmount *nfs_d_automount(struct path *path)
> >  	/* Open a new filesystem context, transferring parameters from the
> >  	 * parent superblock, including the network namespace.
> >  	 */
> > -	fc = fs_context_for_submount(&nfs_fs_type, path->dentry);
> > +	fc = fs_context_for_submount(path->mnt->mnt_sb->s_type, path->dentry);
> >  	if (IS_ERR(fc))
> >  		return ERR_CAST(fc);
> 
> Thanks for your fix! While this fixes the fstype with mount.nfs4(8),
> it still doesn't work when using mount(8):
> 
>      $ sudo mount server:/mnt /mnt && findmnt -n -ofstype /mnt
>      nfs
>      $ sudo umount /mnt
>      $ sudo mount.nfs4 server:/mnt /mnt && findmnt -n -ofstype /mnt
>      nfs4
> 
> I guess the issue is that the kernel doesn't yet know which NFS version
> the server provides at the point where `fs_context_for_submount()` is
> called.

Thanks for testing.  Actually the problem is that the super_block's
s_type is now based on the fs_context->fs_type field, which is set when
the fs_context is created (way before the mount options are parsed).
When you use mount(8) without specifying '-t nfs4', it defaults to
using the mount.nfs helper, which calls mount(2) with 'nfs' as the
fstype.  I'm sending a second patch that double-checks the
fs_context->fs_type after the mount options have been parsed.  We still
shouldn't be hard-coding the fstype in fs_context_for_submount() though
(i.e. both patches are needed).

-Scott
> 
> Patrick


