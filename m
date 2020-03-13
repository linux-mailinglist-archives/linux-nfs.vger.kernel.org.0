Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9393C184AD7
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2020 16:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCMPfv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Mar 2020 11:35:51 -0400
Received: from fieldses.org ([173.255.197.46]:51172 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgCMPfu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 13 Mar 2020 11:35:50 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 9FC1D83B; Fri, 13 Mar 2020 11:35:49 -0400 (EDT)
Date:   Fri, 13 Mar 2020 11:35:49 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 02/14] xattr: modify vfs_{set,remove}xattr for NFS server
 use
Message-ID: <20200313153549.GD12537@fieldses.org>
References: <20200311195954.27117-1-fllinden@amazon.com>
 <20200311195954.27117-3-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311195954.27117-3-fllinden@amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 11, 2020 at 07:59:42PM +0000, Frank van der Linden wrote:
> To be called from the upcoming NFS server xattr code, the vfs_removexattr
> and vfs_setxattr need some modifications.
> 
> First, they need to grow a _locked variant, since the NFS server code
> will call this with i_rwsem held. It needs to do that in fh_lock to be
> able to atomically provide the before and after change attributes.

Unlike NFSv3, NFSv4+ doesn't support atomic before- and after- change
attributes for setattr.  Trying to take advantage of that assumption
might result in worse code, though.

> Second, RFC 8276 (NFSv4 extended attribute support) specifies that
> delegations should be recalled (8.4.2.4, 8.4.4.4) when a SETXATTR
> or REMOVEXATTR operation is performed. So, like with other fs
> operations, try to break the delegation. The _locked version of
> these operations will not wait for the delegation to be successfully
> broken, instead returning an error if it wasn't, so that the NFS
> server code can return NFS4ERR_DELAY to the client (similar to
> what e.g. vfs_link does).

Is there a preexisting bug here?  Even without NFS support for xattrs, a
local setxattr on the filesystem should still revoke any delegations
held by remote NFS clients.  I couldn't tell whether we're getting that
right from a quick look at the current code.

--b.

> 
> Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> ---
>  fs/xattr.c            | 63 +++++++++++++++++++++++++++++++++++++++++++++------
>  include/linux/xattr.h |  2 ++
>  2 files changed, 58 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 90dd78f0eb27..58013bcbc333 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -204,10 +204,10 @@ int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
>  	return error;
>  }
>  
> -
>  int
> -vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
> -		size_t size, int flags)
> +__vfs_setxattr_locked(struct dentry *dentry, const char *name,
> +		const void *value, size_t size, int flags,
> +		struct inode **delegated_inode)
>  {
>  	struct inode *inode = dentry->d_inode;
>  	int error;
> @@ -216,15 +216,40 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
>  	if (error)
>  		return error;
>  
> -	inode_lock(inode);
>  	error = security_inode_setxattr(dentry, name, value, size, flags);
>  	if (error)
>  		goto out;
>  
> +	error = try_break_deleg(inode, delegated_inode);
> +	if (error)
> +		goto out;
> +
>  	error = __vfs_setxattr_noperm(dentry, name, value, size, flags);
>  
>  out:
> +	return error;
> +}
> +EXPORT_SYMBOL_GPL(__vfs_setxattr_locked);
> +
> +int
> +vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
> +		size_t size, int flags)
> +{
> +	struct inode *inode = dentry->d_inode;
> +	struct inode *delegated_inode = NULL;
> +	int error;
> +
> +retry_deleg:
> +	inode_lock(inode);
> +	error = __vfs_setxattr_locked(dentry, name, value, size, flags,
> +	    &delegated_inode);
>  	inode_unlock(inode);
> +
> +	if (delegated_inode) {
> +		error = break_deleg_wait(&delegated_inode);
> +		if (!error)
> +			goto retry_deleg;
> +	}
>  	return error;
>  }
>  EXPORT_SYMBOL_GPL(vfs_setxattr);
> @@ -379,7 +404,8 @@ __vfs_removexattr(struct dentry *dentry, const char *name)
>  EXPORT_SYMBOL(__vfs_removexattr);
>  
>  int
> -vfs_removexattr(struct dentry *dentry, const char *name)
> +__vfs_removexattr_locked(struct dentry *dentry, const char *name,
> +		struct inode **delegated_inode)
>  {
>  	struct inode *inode = dentry->d_inode;
>  	int error;
> @@ -388,11 +414,14 @@ vfs_removexattr(struct dentry *dentry, const char *name)
>  	if (error)
>  		return error;
>  
> -	inode_lock(inode);
>  	error = security_inode_removexattr(dentry, name);
>  	if (error)
>  		goto out;
>  
> +	error = try_break_deleg(inode, delegated_inode);
> +	if (error)
> +		goto out;
> +
>  	error = __vfs_removexattr(dentry, name);
>  
>  	if (!error) {
> @@ -401,12 +430,32 @@ vfs_removexattr(struct dentry *dentry, const char *name)
>  	}
>  
>  out:
> +	return error;
> +}
> +EXPORT_SYMBOL_GPL(__vfs_removexattr_locked);
> +
> +int
> +vfs_removexattr(struct dentry *dentry, const char *name)
> +{
> +	struct inode *inode = dentry->d_inode;
> +	struct inode *delegated_inode = NULL;
> +	int error;
> +
> +retry_deleg:
> +	inode_lock(inode);
> +	error = __vfs_removexattr_locked(dentry, name, &delegated_inode);
>  	inode_unlock(inode);
> +
> +	if (delegated_inode) {
> +		error = break_deleg_wait(&delegated_inode);
> +		if (!error)
> +			goto retry_deleg;
> +	}
> +
>  	return error;
>  }
>  EXPORT_SYMBOL_GPL(vfs_removexattr);
>  
> -
>  /*
>   * Extended attribute SET operations
>   */
> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index 6dad031be3c2..3a71ad716da5 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -51,8 +51,10 @@ ssize_t vfs_getxattr(struct dentry *, const char *, void *, size_t);
>  ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size);
>  int __vfs_setxattr(struct dentry *, struct inode *, const char *, const void *, size_t, int);
>  int __vfs_setxattr_noperm(struct dentry *, const char *, const void *, size_t, int);
> +int __vfs_setxattr_locked(struct dentry *, const char *, const void *, size_t, int, struct inode **);
>  int vfs_setxattr(struct dentry *, const char *, const void *, size_t, int);
>  int __vfs_removexattr(struct dentry *, const char *);
> +int __vfs_removexattr_locked(struct dentry *, const char *, struct inode **);
>  int vfs_removexattr(struct dentry *, const char *);
>  
>  ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size);
> -- 
> 2.16.6
