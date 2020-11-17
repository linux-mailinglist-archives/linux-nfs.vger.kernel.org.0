Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637FC2B672E
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Nov 2020 15:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgKQOOG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Nov 2020 09:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgKQOOG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Nov 2020 09:14:06 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9BFC0613CF
        for <linux-nfs@vger.kernel.org>; Tue, 17 Nov 2020 06:14:06 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 29B131CE6; Tue, 17 Nov 2020 09:14:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 29B131CE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1605622445;
        bh=mv9E/otnrADzIvuQoj37YLUWkP9ALGzv5ewIs91gTWc=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=F9ZvMA/nhE8Os6dU0Wb8gOcIHOfogaGuKp+xpCMLG20weX+7hPH/ohANtiD3sYB/c
         HSi11f4Cq1oWNmilb8j/hIQdHvuIarj3obWuTjkyjorHOOfYJkZ1Qy0IbHRXxvirgD
         9jadrufOpQqmPI0V/T2eg6XhHTwPdDD/DSUJywZg=
Date:   Tue, 17 Nov 2020 09:14:05 -0500
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] nfs: don't mangle i_version on NFS
Message-ID: <20201117141405.GA4556@fieldses.org>
References: <20201117031601.GB10526@fieldses.org>
 <1605583086-19869-1-git-send-email-bfields@redhat.com>
 <1605583086-19869-3-git-send-email-bfields@redhat.com>
 <4be708fffc15a27560c378af20314212e8594f85.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4be708fffc15a27560c378af20314212e8594f85.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 17, 2020 at 07:27:03AM -0500, Jeff Layton wrote:
> On Mon, 2020-11-16 at 22:18 -0500, J. Bruce Fields wrote:
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > The i_version on NFS has pretty much opaque to the client, so we don't
> > want to give the low bit any special interpretation.
> > 
> > Define a new FS_PRIVATE_I_VERSION flag for filesystems that manage the
> > i_version on their own.
> > 
> 
> Description here doesn't quite match the patch...

Oops, thanks.--b.

> 
> > Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> > ---
> >  fs/nfs/export.c          | 1 +
> >  include/linux/exportfs.h | 1 +
> >  include/linux/iversion.h | 4 ++++
> >  3 files changed, 6 insertions(+)
> > 
> > diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> > index 3430d6891e89..c2eb915a54ca 100644
> > --- a/fs/nfs/export.c
> > +++ b/fs/nfs/export.c
> > @@ -171,4 +171,5 @@ const struct export_operations nfs_export_ops = {
> >  	.encode_fh = nfs_encode_fh,
> >  	.fh_to_dentry = nfs_fh_to_dentry,
> >  	.get_parent = nfs_get_parent,
> > +	.fetch_iversion = inode_peek_iversion_raw,
> >  };
> > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > index 3ceb72b67a7a..6000121a201f 100644
> > --- a/include/linux/exportfs.h
> > +++ b/include/linux/exportfs.h
> > @@ -213,6 +213,7 @@ struct export_operations {
> >  			  bool write, u32 *device_generation);
> >  	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
> >  			     int nr_iomaps, struct iattr *iattr);
> > +	u64 (*fetch_iversion)(const struct inode *);
> >  };
> >  
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> >  extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
> > diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> > index 2917ef990d43..481b3debf6bb 100644
> > --- a/include/linux/iversion.h
> > +++ b/include/linux/iversion.h
> > @@ -3,6 +3,7 @@
> >  #define _LINUX_IVERSION_H
> >  
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> >  #include <linux/fs.h>
> > +#include <linux/exportfs.h>
> >  
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> >  /*
> >   * The inode->i_version field:
> > @@ -306,6 +307,9 @@ inode_query_iversion(struct inode *inode)
> >  {
> >  	u64 cur, old, new;
> >  
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > +	if (inode->i_sb->s_export_op->fetch_iversion)
> > +		return inode->i_sb->s_export_op->fetch_iversion(inode);
> > +
> 
> This looks dangerous -- s_export_op could be a NULL pointer.
> 
> >  	cur = inode_peek_iversion_raw(inode);
> >  	for (;;) {
> >  		/* If flag is already set, then no need to swap */
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
