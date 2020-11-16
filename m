Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E812B48F8
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Nov 2020 16:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbgKPPSv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Nov 2020 10:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729499AbgKPPSv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Nov 2020 10:18:51 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5CDC0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 16 Nov 2020 07:18:51 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0E2DA7EC; Mon, 16 Nov 2020 10:18:50 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 0E2DA7EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1605539930;
        bh=91Nws8qMidzl5kXGu4HxNqZmzO1izbP/zoCeZYFFoYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ePjzdX8mz8i063F5FJTnYDe286uVCVfIL4a5UDiLQwsQEb0rrRSWwt+zB4r62pwQ4
         OZ/HHnwIKVZDTxVNpWEljSdxa0MsSqavCFARwOaF5oa7PSkSKduCdlhLvWYLlS/Pzw
         Znguv29OWa/F/wiMpgz1ypt4oYsJC98K9IlFlfuI=
Date:   Mon, 16 Nov 2020 10:18:50 -0500
From:   bfields <bfields@fieldses.org>
To:     Daire Byrne <daire@dneg.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>, jlayton@kernel.org
Subject: Re: Adventures in NFS re-exporting
Message-ID: <20201116151850.GD898@fieldses.org>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
 <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
 <20201112135733.GA9243@fieldses.org>
 <444227972.86442677.1605206025305.JavaMail.zimbra@dneg.com>
 <20201112205524.GI9243@fieldses.org>
 <883314904.86570901.1605222357023.JavaMail.zimbra@dneg.com>
 <20201113145050.GB1299@fieldses.org>
 <20201113222600.GC1299@fieldses.org>
 <217712894.87456370.1605358643862.JavaMail.zimbra@dneg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <217712894.87456370.1605358643862.JavaMail.zimbra@dneg.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Jeff, does something like this look reasonable?

--b.

On Sat, Nov 14, 2020 at 12:57:24PM +0000, Daire Byrne wrote:
> ----- On 13 Nov, 2020, at 22:26, bfields bfields@fieldses.org wrote:
> > On Fri, Nov 13, 2020 at 09:50:50AM -0500, bfields wrote:
> >> Ah-hah!  So, it's inode_query_iversion() that's modifying a nfs inode's
> >> i_version.  That's a special thing that only nfsd would do.
> >> 
> >> I think that's totally fixable, we'll just have to think a little about
> >> how....
> > 
> > I wonder if something like this helps?--b.
> > 
> > commit 0add88a9ccc5
> > Author: J. Bruce Fields <bfields@redhat.com>
> > Date:   Fri Nov 13 17:03:04 2020 -0500
> > 
> >    nfs: don't mangle i_version on NFS
> >    
> >    The i_version on NFS has pretty much opaque to the client, so we don't
> >    want to give the low bit any special interpretation.
> >    
> >    Define a new FS_PRIVATE_I_VERSION flag for filesystems that manage the
> >    i_version on their own.
> >    
> >    Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > 
> > diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> > index 29ec8b09a52d..9b8dd5b713a7 100644
> > --- a/fs/nfs/fs_context.c
> > +++ b/fs/nfs/fs_context.c
> > @@ -1488,7 +1488,8 @@ struct file_system_type nfs_fs_type = {
> > 	.init_fs_context	= nfs_init_fs_context,
> > 	.parameters		= nfs_fs_parameters,
> > 	.kill_sb		= nfs_kill_super,
> > -	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
> > +	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA|
> > +				  FS_PRIVATE_I_VERSION,
> > };
> > MODULE_ALIAS_FS("nfs");
> > EXPORT_SYMBOL_GPL(nfs_fs_type);
> > @@ -1500,7 +1501,8 @@ struct file_system_type nfs4_fs_type = {
> > 	.init_fs_context	= nfs_init_fs_context,
> > 	.parameters		= nfs_fs_parameters,
> > 	.kill_sb		= nfs_kill_super,
> > -	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
> > +	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA|
> > +				  FS_PRIVATE_I_VERSION,
> > };
> > MODULE_ALIAS_FS("nfs4");
> > MODULE_ALIAS("nfs4");
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 21cc971fd960..c5bb4268228b 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2217,6 +2217,7 @@ struct file_system_type {
> > #define FS_HAS_SUBTYPE		4
> > #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
> > #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
> > +#define FS_PRIVATE_I_VERSION	32	/* i_version managed by filesystem */
> > #define FS_THP_SUPPORT		8192	/* Remove once all fs converted */
> > #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename()
> > internally. */
> > 	int (*init_fs_context)(struct fs_context *);
> > diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> > index 2917ef990d43..52c790a847de 100644
> > --- a/include/linux/iversion.h
> > +++ b/include/linux/iversion.h
> > @@ -307,6 +307,8 @@ inode_query_iversion(struct inode *inode)
> > 	u64 cur, old, new;
> > 
> > 	cur = inode_peek_iversion_raw(inode);
> > +	if (inode->i_sb->s_type->fs_flags & FS_PRIVATE_I_VERSION)
> > +		return cur;
> > 	for (;;) {
> > 		/* If flag is already set, then no need to swap */
> >  		if (cur & I_VERSION_QUERIED) {
> 
> Yes, I can confirm that this absolutely helps! I replaced our (brute force) iversion patch with this (much nicer) patch and we got the same improvement; nfsd and it's clients no longer cause the re-export server's client cache to constantly be re-validated. The re-export server can now serve the same results to many clients from cache. Thanks so much for spending the time to track this down. If merged, future (crazy) NFS re-exporters will benefit from the metadata performance improvement/acceleration!
> 
> Now if anyone has any ideas why all the read calls to the originating server are limited to a maximum of 128k (with rsize=1M) when coming via the re-export server's nfsd threads, I see that as the next biggest performance issue. Reading directly on the re-export server with a userspace process issues 1MB reads as expected. It doesn't happen for writes (wsize=1MB all the way through) but I'm not sure if that has more to do with async and write back caching helping to build up the size before commit?
> 
> I figure the other remaining items on my (wish) list are probably more in the "won't fix" or "can't fix" category (except maybe the NFSv4.0 input/output errors?).
> 
> Daire
