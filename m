Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2FA1FD109
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2020 17:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgFQPbR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jun 2020 11:31:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28834 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726857AbgFQPbQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Jun 2020 11:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592407874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L3O+vvb9MR52fdpp6oH5YQQ+6n4HbCpp7/3PBoWRbnw=;
        b=CEaSdGgkzeK+MXgFMdhQlI49YtZe7qhcjgGRC/PxAGzavywSjOyELYE3vPdl5bAGXXAJFT
        l4CylG9iTWzO0z95UsNAh1xsYdwW8AN+QzmIGuRUeDU9+2QdqvjgQPx9pSqWsPXfXyeA4j
        XZTgeKMX6uEE+AMMzx0SUYYzWUcbewg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-15bTrx6eOTq1lkh9BRrX2Q-1; Wed, 17 Jun 2020 11:31:10 -0400
X-MC-Unique: 15bTrx6eOTq1lkh9BRrX2Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4F64100CCC8;
        Wed, 17 Jun 2020 15:31:09 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-115-232.rdu2.redhat.com [10.10.115.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F4175C241;
        Wed, 17 Jun 2020 15:31:09 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id D5873120476; Wed, 17 Jun 2020 11:31:07 -0400 (EDT)
Date:   Wed, 17 Jun 2020 11:31:07 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     ecryptfs@vger.kernel.org, Salvatore Bonaccorso <carnil@debian.org>,
        Elliott Mitchell <ehem+debian@m5p.com>, 962254@bugs.debian.org,
        linux-nfs@vger.kernel.org
Subject: Re: Umask ignored when mounting NFSv4.2 share of an exported
 Filesystem with noacl (was: Re: Bug#962254: NFS(v4) broken at 4.19.118-2)
Message-ID: <20200617153107.GL266716@pick.fieldses.org>
References: <20200605183631.GA1720057@eldamar.local>
 <20200611223711.GA37917@mattapan.m5p.com>
 <20200613125431.GA349352@eldamar.local>
 <20200613184527.GA54221@mattapan.m5p.com>
 <20200615145035.GA214986@pick.fieldses.org>
 <20200615185311.GA702681@eldamar.local>
 <20200616023820.GB214986@pick.fieldses.org>
 <20200616024212.GC214986@pick.fieldses.org>
 <20200616161658.GA17251@lorien.valinor.li>
 <20200617144256.1028414-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617144256.1028414-1-agruenba@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 17, 2020 at 04:42:56PM +0200, Andreas Gruenbacher wrote:
> Hi Bruce,
> 
> On Wed, Jun 17, 2020 at 2:58 AM J. Bruce Fields <bfields@redhat.com> wrote:
> > I think I'll send the following upstream.
> 
> looking good, but how about using a little helper for this?

I like it.  And the new comment's helpful too.

> 
> Also I'm not sure if ecryptfs gets this right, so taking the ecryptfs
> list into the CC.

Yes, questions I had while doing this:

	- cachefiles, ecrypfs, devtmpfs, and unix_mknod skip the check,
	  is that OK for all of them?  (Overlayfs too, I think?--that
	  code's harder to follow.

	- why don't vfs_{create,mknod,mkdir} do the IS_POSIXACL check
	  themselves?  Even if it's unnecessary for some callers, surely
	  it wouldn't be wrong?

I also wondered why both vfs_{create,mknod,mkdir} and the callers were
calling security hooks, but now I see that the callers are calling
security_path_* hooks and the vfs_ functions are calling
security_inode_* hooks, so I guess they're not redundant.

Though now I wonder why some of the callers (nfsd, overlayfs) are
skipping the security_path_* hooks.

--b.

> 
> Thanks,
> Andreas
> 
> --
> 
> Add a posix_acl_apply_umask helper for filesystems like nfsd to apply
> the umask before calling into vfs_create, vfs_mkdir, and vfs_mknod when
> necessary.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/namei.c                |  9 +++------
>  fs/nfsd/vfs.c             |  6 ++----
>  fs/overlayfs/dir.c        |  4 ++--
>  fs/posix_acl.c            | 15 +++++++++++++++
>  include/linux/posix_acl.h |  6 ++++++
>  5 files changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 72d4219c93ac..a68887d3a446 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3054,8 +3054,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	if (open_flag & O_CREAT) {
>  		if (open_flag & O_EXCL)
>  			open_flag &= ~O_TRUNC;
> -		if (!IS_POSIXACL(dir->d_inode))
> -			mode &= ~current_umask();
> +		posix_acl_apply_umask(dir->d_inode, &mode);
>  		if (likely(got_write))
>  			create_error = may_o_create(&nd->path, dentry, mode);
>  		else
> @@ -3580,8 +3579,7 @@ long do_mknodat(int dfd, const char __user *filename, umode_t mode,
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
>  
> -	if (!IS_POSIXACL(path.dentry->d_inode))
> -		mode &= ~current_umask();
> +	posix_acl_apply_umask(path.dentry->d_inode, &mode);
>  	error = security_path_mknod(&path, dentry, mode, dev);
>  	if (error)
>  		goto out;
> @@ -3657,8 +3655,7 @@ long do_mkdirat(int dfd, const char __user *pathname, umode_t mode)
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
>  
> -	if (!IS_POSIXACL(path.dentry->d_inode))
> -		mode &= ~current_umask();
> +	posix_acl_apply_umask(path.dentry->d_inode, &mode);
>  	error = security_path_mkdir(&path, dentry, mode);
>  	if (!error)
>  		error = vfs_mkdir(path.dentry->d_inode, dentry, mode);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index d22a056da477..0c625b004b0c 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1226,8 +1226,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		iap->ia_mode = 0;
>  	iap->ia_mode = (iap->ia_mode & S_IALLUGO) | type;
>  
> -	if (!IS_POSIXACL(dirp))
> -		iap->ia_mode &= ~current_umask();
> +	posix_acl_apply_umask(dirp, &iap->ia_mode);
>  
>  	err = 0;
>  	host_err = 0;
> @@ -1461,8 +1460,7 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		goto out;
>  	}
>  
> -	if (!IS_POSIXACL(dirp))
> -		iap->ia_mode &= ~current_umask();
> +	posix_acl_apply_umask(dirp, &iap->ia_mode);
>  
>  	host_err = vfs_create(dirp, dchild, iap->ia_mode, true);
>  	if (host_err < 0) {
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 1bba4813f9cb..4d98db2a0208 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -325,8 +325,8 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
>  	struct dentry *newdentry;
>  	int err;
>  
> -	if (!attr->hardlink && !IS_POSIXACL(udir))
> -		attr->mode &= ~current_umask();
> +	if (!attr->hardlink)
> +	       posix_acl_apply_umask(udir, &attr->mode);
>  
>  	inode_lock_nested(udir, I_MUTEX_PARENT);
>  	newdentry = ovl_create_real(udir,
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 95882b3f5f62..7ee647b74bc2 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -578,6 +578,21 @@ posix_acl_chmod(struct inode *inode, umode_t mode)
>  }
>  EXPORT_SYMBOL(posix_acl_chmod);
>  
> +/*
> + * On inode creation, filesystems with ACL support are expected to apply the
> + * umask when no ACL is inherited from the parent directory; this is usually
> + * done by posix_acl_create.  Filesystems like nfsd that call vfs_create,
> + * vfs_mknod, or vfs_mkdir directly are expected to call posix_acl_apply_umask
> + * to apply the umask first when necessary.
> + */
> +void
> +posix_acl_apply_umask(struct inode *inode, umode_t *mode)
> +{
> +	if (!IS_POSIXACL(inode))
> +		*mode &= ~current_umask();
> +}
> +EXPORT_SYMBOL(posix_acl_apply_umask);
> +
>  int
>  posix_acl_create(struct inode *dir, umode_t *mode,
>  		struct posix_acl **default_acl, struct posix_acl **acl)
> diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
> index 90797f1b421d..76e402ff4f92 100644
> --- a/include/linux/posix_acl.h
> +++ b/include/linux/posix_acl.h
> @@ -73,6 +73,7 @@ extern int set_posix_acl(struct inode *, int, struct posix_acl *);
>  
>  #ifdef CONFIG_FS_POSIX_ACL
>  extern int posix_acl_chmod(struct inode *, umode_t);
> +extern void posix_acl_apply_umask(struct inode *, umode_t *);
>  extern int posix_acl_create(struct inode *, umode_t *, struct posix_acl **,
>  		struct posix_acl **);
>  extern int posix_acl_update_mode(struct inode *, umode_t *, struct posix_acl **);
> @@ -99,6 +100,11 @@ static inline int posix_acl_chmod(struct inode *inode, umode_t mode)
>  
>  #define simple_set_acl		NULL
>  
> +static inline void posix_acl_apply_umask(struct inode *inode, umode_t *mode)
> +{
> +	*mode &= ~current_umask();
> +}
> +
>  static inline int simple_acl_create(struct inode *dir, struct inode *inode)
>  {
>  	return 0;
> 
> base-commit: 69119673bd50b176ded34032fadd41530fb5af21
> prerequisite-patch-id: a8319d40da9f70f478892d0bd8e63f540364b089
> -- 
> 2.26.2
> 

