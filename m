Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAC143784
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2019 17:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbfFMO7n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jun 2019 10:59:43 -0400
Received: from fieldses.org ([173.255.197.46]:52438 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732605AbfFMOvu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 13 Jun 2019 10:51:50 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 04208BC5; Thu, 13 Jun 2019 10:51:50 -0400 (EDT)
Date:   Thu, 13 Jun 2019 10:51:49 -0400
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFS: Don't skip lookup when holding a delegation
Message-ID: <20190613145149.GD2145@fieldses.org>
References: <bcb2d38fe9c9bb15aeb9baa811aeb9a8697ea141.1560348835.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcb2d38fe9c9bb15aeb9baa811aeb9a8697ea141.1560348835.git.bcodding@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 12, 2019 at 10:45:13AM -0400, Benjamin Coddington wrote:
> If we skip lookup revalidation while holding a delegation, we might miss
> that the file has changed directories on the server.

The delegation should prevent the file disappearing from this directory,
so if I've been following the discussion, the bug was due to overlooking
the case where the change happened before we got the delegation.  Given
that history it seems worth calling out that case specifically?

Maybe a comment along the lines of:

		/*
		 * Note that the file can't move while we hold a
		 * delegation.  But this dentry could have been cached
		 * before we got a delegation.  So it's only safe to
		 * skip revalidation when the parent directory is
		 * unchanged:
		 */

But maybe there's a pithier way to say that.

--b.

> The directory's
> change attribute should still be checked against the dentry's d_time to
> perform a complete revalidation.
> 
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/dir.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index a71d0b42d160..10cc684dc082 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1269,12 +1269,13 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
>  		goto out_bad;
>  	}
>  
> -	if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
> -		return nfs_lookup_revalidate_delegated(dir, dentry, inode);
> -
>  	/* Force a full look up iff the parent directory has changed */
>  	if (!(flags & (LOOKUP_EXCL | LOOKUP_REVAL)) &&
>  	    nfs_check_verifier(dir, dentry, flags & LOOKUP_RCU)) {
> +
> +		if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
> +			return nfs_lookup_revalidate_delegated(dir, dentry, inode);
> +
>  		error = nfs_lookup_verify_inode(inode, flags);
>  		if (error) {
>  			if (error == -ESTALE)
> @@ -1707,9 +1708,6 @@ nfs4_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
>  	if (inode == NULL)
>  		goto full_reval;
>  
> -	if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
> -		return nfs_lookup_revalidate_delegated(dir, dentry, inode);
> -
>  	/* NFS only supports OPEN on regular files */
>  	if (!S_ISREG(inode->i_mode))
>  		goto full_reval;
> -- 
> 2.20.1
