Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF57F3881D3
	for <lists+linux-nfs@lfdr.de>; Tue, 18 May 2021 23:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352349AbhERVHb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 May 2021 17:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352350AbhERVHa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 May 2021 17:07:30 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32484C06175F
        for <linux-nfs@vger.kernel.org>; Tue, 18 May 2021 14:06:12 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C368D581C; Tue, 18 May 2021 17:06:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C368D581C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1621371970;
        bh=A4UVSWaDbckWtqGK+z28WZxC3x6H5Ycv9rm4gOCF7bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AMw3DNn3gUU2+pgLyZGXa4hi6NYgxGTYgqZjbbz1B3UEEoOrSDxcaNttUC8xmN5oI
         2a6lkLTM5B+VE5ZdTuq/aM8zBOCK2oOIRe+y+syFysd2eSq5FJlhdFV2mvLcUAxOpb
         kIPMNMRtBR8riS/hKrOPzo3hUWwTWw2Ab1+idQm8=
Date:   Tue, 18 May 2021 17:06:10 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "nickhuang@synology.com" <nickhuang@synology.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "robbieko@synology.com" <robbieko@synology.com>,
        "bingjingc@synology.com" <bingjingc@synology.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Prevent truncation of an unlinked inode from
 blocking access to its directory
Message-ID: <20210518210610.GD26957@fieldses.org>
References: <20210514035829.5230-1-nickhuang@synology.com>
 <00195ec8bf1752306f549540eed74c3938c5e312.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00195ec8bf1752306f549540eed74c3938c5e312.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 14, 2021 at 03:46:57PM +0000, Trond Myklebust wrote:
> On Fri, 2021-05-14 at 11:58 +0800, Nick Huang wrote:
> > From: Yu Hsiang Huang <nickhuang@synology.com>
> > 
> > Truncation of an unlinked inode may take a long time for I/O waiting,
> > and
> > it doesn't have to prevent access to the directory. Thus, let
> > truncation
> > occur outside the directory's mutex, just like do_unlinkat() does.
> > 
> > Signed-off-by: Yu Hsiang Huang <nickhuang@synology.com>
> > Signed-off-by: Bing Jing Chang <bingjingc@synology.com>
> > Signed-off-by: Robbie Ko <robbieko@synology.com>
> > ---
> >  fs/nfsd/vfs.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 15adf1f6ab21..39948f130712 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1859,6 +1859,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct
> > svc_fh *fhp, int type,
> >  {
> >         struct dentry   *dentry, *rdentry;
> >         struct inode    *dirp;
> > +       struct inode    *rinode;
> >         __be32          err;
> >         int             host_err;
> >  
> > @@ -1887,6 +1888,8 @@ nfsd_unlink(struct svc_rqst *rqstp, struct
> > svc_fh *fhp, int type,
> >                 host_err = -ENOENT;
> >                 goto out_drop_write;
> >         }
> > +       rinode = d_inode(rdentry);
> > +       ihold(rinode);
> >  
> >         if (!type)
> >                 type = d_inode(rdentry)->i_mode & S_IFMT;
> > @@ -1902,6 +1905,8 @@ nfsd_unlink(struct svc_rqst *rqstp, struct
> > svc_fh *fhp, int type,
> >         if (!host_err)
> >                 host_err = commit_metadata(fhp);
> 
> Why leave the commit_metadata() call under the lock? If you're
> concerned about latency, then it makes more sense to call fh_unlock()
> before flushing those metadata updates to disk.
> 
> This is, BTW, an optimisation that appears to be possible in several
> other cases in fs/nfsd/vfs.c.

I'm tentatively applying the original patch plus the following.

Create and rename code are two other places where we have
commit_metadata() calls that could probably be moved out from under
locks but they looked slightly more complicated.

--b.

commit ec79990df716
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Fri May 14 18:21:37 2021 -0400

    nfsd: move some commit_metadata()s outside the inode lock
    
    The commit may be time-consuming and there's no need to hold the lock
    for it.
    
    More of these are possible, these were just some easy ones.
    
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 39948f130712..d73d3c9126fc 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1613,9 +1613,9 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	host_err = vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
 	err = nfserrno(host_err);
+	fh_unlock(fhp);
 	if (!err)
 		err = nfserrno(commit_metadata(fhp));
-	fh_unlock(fhp);
 
 	fh_drop_write(fhp);
 
@@ -1680,6 +1680,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	if (d_really_is_negative(dold))
 		goto out_dput;
 	host_err = vfs_link(dold, &init_user_ns, dirp, dnew, NULL);
+	fh_unlock(ffhp);
 	if (!host_err) {
 		err = nfserrno(commit_metadata(ffhp));
 		if (!err)
@@ -1902,10 +1903,10 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 		host_err = vfs_rmdir(&init_user_ns, dirp, rdentry);
 	}
 
+	fh_unlock(fhp);
 	if (!host_err)
 		host_err = commit_metadata(fhp);
 	dput(rdentry);
-	fh_unlock(fhp);
 	iput(rinode);    /* truncate the inode here */
 
 out_drop_write:
