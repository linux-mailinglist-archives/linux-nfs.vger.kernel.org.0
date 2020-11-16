Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D462B4B6D
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Nov 2020 17:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbgKPQir (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Nov 2020 11:38:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731019AbgKPQir (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 16 Nov 2020 11:38:47 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0409E20776;
        Mon, 16 Nov 2020 16:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605544726;
        bh=Z5AWtiu4/1nWs4Lqdj/yny4W/uP1nc6RV9GniVjMa8A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RiFO9kiC4/Ad19BXeIebz5+/+HfW0GmciIXryGNFcNo+6oLX3kJ3Z8pb6ZvlfzxZo
         guD4s45QxUVpGm/R3ID049i9rgSmCccd5jGwCdYRPrxSdT9EkW76UmVISSi6D2R9fZ
         bNa4D1Hfyxd5LW4AgPkUjrrBWm9v9Lgp60BIo3kY=
Message-ID: <db55bab87b6fc9dd1594f8c2e853f07b1165ff5d.camel@kernel.org>
Subject: Re: Adventures in NFS re-exporting
From:   Jeff Layton <jlayton@kernel.org>
To:     bfields <bfields@fieldses.org>
Cc:     Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Date:   Mon, 16 Nov 2020 11:38:44 -0500
In-Reply-To: <20201116161407.GG898@fieldses.org>
References: <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
         <20201112135733.GA9243@fieldses.org>
         <444227972.86442677.1605206025305.JavaMail.zimbra@dneg.com>
         <20201112205524.GI9243@fieldses.org>
         <883314904.86570901.1605222357023.JavaMail.zimbra@dneg.com>
         <20201113145050.GB1299@fieldses.org> <20201113222600.GC1299@fieldses.org>
         <b0d61b4053442ba46fd2c707ee7e0608704c2598.camel@kernel.org>
         <20201116155619.GF898@fieldses.org>
         <83ebb6dc68216ce3f3dfd2a2736b7a301550efc5.camel@kernel.org>
         <20201116161407.GG898@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2020-11-16 at 11:14 -0500, bfields wrote:
> On Mon, Nov 16, 2020 at 11:03:00AM -0500, Jeff Layton wrote:
> > On Mon, 2020-11-16 at 10:56 -0500, bfields wrote:
> > > On Mon, Nov 16, 2020 at 10:29:29AM -0500, Jeff Layton wrote:
> > > > On Fri, 2020-11-13 at 17:26 -0500, bfields wrote:
> > > > > On Fri, Nov 13, 2020 at 09:50:50AM -0500, bfields wrote:
> > > > > > On Thu, Nov 12, 2020 at 11:05:57PM +0000, Daire Byrne wrote:
> > > > > > > So, I can't lay claim to identifying the exact optimisation/hack that
> > > > > > > improves the retention of the re-export server's client cache when
> > > > > > > re-exporting an NFSv3 server (which is then read by many clients). We
> > > > > > > were working with an engineer at the time who showed an interest in
> > > > > > > our use case and after we supplied a reproducer he suggested modifying
> > > > > > > the nfs/inode.c
> > > > > > > 
> > > > > > > -		if (!inode_eq_iversion_raw(inode, fattr->change_attr)) {
> > > > > > > +		if (inode_peek_iversion_raw(inode) < fattr->change_attr)
> > > > > > > {
> > > > > > > 
> > > > > > > His reasoning at the time was:
> > > > > > > 
> > > > > > > "Fixes inode invalidation caused by read access. The least important
> > > > > > > bit is ORed with 1 and causes the inode version to differ from the one
> > > > > > > seen on the NFS share. This in turn causes unnecessary re-download
> > > > > > > impacting the performance significantly. This fix makes it only
> > > > > > > re-fetch file content if inode version seen on the server is newer
> > > > > > > than the one on the client."
> > > > > > > 
> > > > > > > But I've always been puzzled by why this only seems to be the case
> > > > > > > when using knfsd to re-export the (NFSv3) client mount. Using multiple
> > > > > > > processes on a standard client mount never causes any similar
> > > > > > > re-validations. And this happens with a completely read-only share
> > > > > > > which is why I started to think it has something to do with atimes as
> > > > > > > that could perhaps still cause a "write" modification even when
> > > > > > > read-only?
> > > > > > 
> > > > > > Ah-hah!  So, it's inode_query_iversion() that's modifying a nfs inode's
> > > > > > i_version.  That's a special thing that only nfsd would do.
> > > > > > 
> > > > > > I think that's totally fixable, we'll just have to think a little about
> > > > > > how....
> > > > > 
> > > > > I wonder if something like this helps?--b.
> > > > > 
> > > > > commit 0add88a9ccc5
> > > > > Author: J. Bruce Fields <bfields@redhat.com>
> > > > > Date:   Fri Nov 13 17:03:04 2020 -0500
> > > > > 
> > > > >     nfs: don't mangle i_version on NFS
> > > > >     
> > > > > 
> > > > >     The i_version on NFS has pretty much opaque to the client, so we don't
> > > > >     want to give the low bit any special interpretation.
> > > > >     
> > > > > 
> > > > >     Define a new FS_PRIVATE_I_VERSION flag for filesystems that manage the
> > > > >     i_version on their own.
> > > > >     
> > > > > 
> > > > >     Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > > > > 
> > > > > diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> > > > > index 29ec8b09a52d..9b8dd5b713a7 100644
> > > > > --- a/fs/nfs/fs_context.c
> > > > > +++ b/fs/nfs/fs_context.c
> > > > > @@ -1488,7 +1488,8 @@ struct file_system_type nfs_fs_type = {
> > > > >  	.init_fs_context	= nfs_init_fs_context,
> > > > >  	.parameters		= nfs_fs_parameters,
> > > > >  	.kill_sb		= nfs_kill_super,
> > > > > -	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
> > > > > +	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA|
> > > > > +				  FS_PRIVATE_I_VERSION,
> > > > >  };
> > > > >  MODULE_ALIAS_FS("nfs");
> > > > >  EXPORT_SYMBOL_GPL(nfs_fs_type);
> > > > > @@ -1500,7 +1501,8 @@ struct file_system_type nfs4_fs_type = {
> > > > >  	.init_fs_context	= nfs_init_fs_context,
> > > > >  	.parameters		= nfs_fs_parameters,
> > > > >  	.kill_sb		= nfs_kill_super,
> > > > > -	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
> > > > > +	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA|
> > > > > +				  FS_PRIVATE_I_VERSION,
> > > > >  };
> > > > >  MODULE_ALIAS_FS("nfs4");
> > > > >  MODULE_ALIAS("nfs4");
> > > > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > > > index 21cc971fd960..c5bb4268228b 100644
> > > > > --- a/include/linux/fs.h
> > > > > +++ b/include/linux/fs.h
> > > > > @@ -2217,6 +2217,7 @@ struct file_system_type {
> > > > >  #define FS_HAS_SUBTYPE		4
> > > > >  #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
> > > > >  #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
> > > > > +#define FS_PRIVATE_I_VERSION	32	/* i_version managed by filesystem */
> > > > >  #define FS_THP_SUPPORT		8192	/* Remove once all fs converted */
> > > > >  #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
> > > > >  	int (*init_fs_context)(struct fs_context *);
> > > > > diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> > > > > index 2917ef990d43..52c790a847de 100644
> > > > > --- a/include/linux/iversion.h
> > > > > +++ b/include/linux/iversion.h
> > > > > @@ -307,6 +307,8 @@ inode_query_iversion(struct inode *inode)
> > > > >  	u64 cur, old, new;
> > > > >  
> > > > > 
> > > > >  	cur = inode_peek_iversion_raw(inode);
> > > > > +	if (inode->i_sb->s_type->fs_flags & FS_PRIVATE_I_VERSION)
> > > > > +		return cur;
> > > > >  	for (;;) {
> > > > >  		/* If flag is already set, then no need to swap */
> > > > >  		if (cur & I_VERSION_QUERIED) {
> > > > 
> > > > 
> > > > It's probably more correct to just check the already-existing
> > > > SB_I_VERSION flag here
> > > 
> > > So the check would be
> > > 
> > > 	if (!IS_I_VERSION(inode))
> > > 		return cur;
> > > 
> > > ?
> > > 
> > 
> > Yes, that looks about right.
> 
> That doesn't sound right to me.  NFS, for example, has a perfectly good
> i_version that works as a change attribute, so it should set
> SB_I_VERSION.  But it doesn't want the vfs playing games with the low
> bit.
> 
> (In fact, I'm confused now: the improvement Daire was seeing should only
> be possible if the re-export server was seeing SB_I_VERSION set on the
> NFS filesystem it was exporting, but a quick grep doesn't actually show
> me where NFS is setting SB_I_VERSION.  I'm missing something
> obvious....)


Hmm, ok... nfsd4_change_attribute() is called from nfs4 code but also
nfs3 code as well. The v4 caller (encode_change) only calls it when
IS_I_VERSION is set, but the v3 callers don't seem to pay attention to
that.

I think the basic issue here is that we're trying to use SB_I_VERSION
for two different things. Its main purpose is to tell the kernel that
when it's updating the file times that it should also (possibly)
increment the i_version counter too. (Some of this is documented in
include/linux/iversion.h too, fwiw)

nfsd needs a way to tell whether the field should be consulted at all.
For that we probably do need a different flag of some sort. Doing it at
the fstype level seems a bit wrong though -- v2/3 don't have a real
change attribute and it probably shouldn't be trusted when exporting
them.

-- 
Jeff Layton <jlayton@kernel.org>

