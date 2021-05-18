Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63295387FBF
	for <lists+linux-nfs@lfdr.de>; Tue, 18 May 2021 20:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351611AbhERSlU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 May 2021 14:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343747AbhERSlT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 May 2021 14:41:19 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7166C061573
        for <linux-nfs@vger.kernel.org>; Tue, 18 May 2021 11:40:00 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C35054F7D; Tue, 18 May 2021 14:39:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C35054F7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1621363199;
        bh=pcz8UXo9//gxbL3GlspfgdEbVFVh6hDUCWykYhuttcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s9bpohjW/0j5QYiJyrhWDVirY3lPd+OyNbO/17tu1nBnqQOrW34/2u26gwxbOwr6/
         a8THasDie4ieMaBlY970ADPHuYEcKxk18mgMh/vlWQIStAlv6UYKkrpCi6r3OzHp8e
         o4crlVE4WesxNsfGrt+p2FgrYrW0q42QfbBauC10=
Date:   Tue, 18 May 2021 14:39:59 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "robbieko@synology.com" <robbieko@synology.com>,
        "bingjingc@synology.com" <bingjingc@synology.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "nickhuang@synology.com" <nickhuang@synology.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH] nfsd: Prevent truncation of an unlinked inode from
 blocking access to its directory
Message-ID: <20210518183959.GC26957@fieldses.org>
References: <20210514035829.5230-1-nickhuang@synology.com>
 <00195ec8bf1752306f549540eed74c3938c5e312.camel@hammerspace.com>
 <YJ9yD1S6Yl2m0gOO@infradead.org>
 <4387867bd64c5d3d8c67830a633b90e4a7e1ba38.camel@hammerspace.com>
 <20210518182115.GB26957@fieldses.org>
 <924d92d52116cff9c0203b84a02d45352bfad361.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <924d92d52116cff9c0203b84a02d45352bfad361.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 18, 2021 at 06:36:23PM +0000, Trond Myklebust wrote:
> On Tue, 2021-05-18 at 14:21 -0400, bfields@fieldses.org wrote:
> > On Tue, May 18, 2021 at 05:53:47PM +0000, Trond Myklebust wrote:
> > > On Sat, 2021-05-15 at 08:02 +0100, Christoph Hellwig wrote:
> > > > On Fri, May 14, 2021 at 03:46:57PM +0000, Trond Myklebust wrote:
> > > > > Why leave the commit_metadata() call under the lock? If you're
> > > > > concerned about latency, then it makes more sense to call
> > > > > fh_unlock()
> > > > > before flushing those metadata updates to disk.
> > > > 
> > > > Also I'm not sure why the extra inode reference is needed.  What
> > > > speaks
> > > > against just moving the dput out of the locked section?
> > > 
> > > Isn't the inode reference taken just in order to ensure that the
> > > call
> > > to iput_final() (and in particular the call to
> > > truncate_inode_pages_final()) is performed outside the lock?
> > > 
> > > The dput() is presumably usually not particularly expensive, since
> > > the
> > > dentry is just a completely ordinary negative dentry at this point.
> > 
> > Right, but why bother with the extra ihold/iput instead of just
> > postponing the dput?
> 
> As I said above, the dentry is negative at this point. It doesn't carry
> a reference to the inode any more, so that wouldn't defer the inode
> truncation.

Oh, of course, thanks!

--b.

> 
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 79b0ff9b151e..aeed93c9874c 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4084,7 +4084,6 @@ long do_unlinkat(int dfd, struct filename
> > *name)
> >                 inode = dentry->d_inode;
> >                 if (d_is_negative(dentry))
> >                         goto slashes;
> > -               ihold(inode);
> >                 error = security_path_unlink(&path, dentry);
> >                 if (error)
> >                         goto exit2;
> > @@ -4092,11 +4091,10 @@ long do_unlinkat(int dfd, struct filename
> > *name)
> >                 error = vfs_unlink(mnt_userns, path.dentry->d_inode,
> > dentry,
> >                                    &delegated_inode);
> >  exit2:
> > -               dput(dentry);
> >         }
> >         inode_unlock(path.dentry->d_inode);
> > -       if (inode)
> > -               iput(inode);    /* truncate the inode here */
> > +       if (!IS_ERR(dentry))
> > +               dput(dentry);   /* truncate the inode here */
> >         inode = NULL;
> >         if (delegated_inode) {
> >                 error = break_deleg_wait(&delegated_inode);
> > 
> > ?
> > 
> > --b.
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
