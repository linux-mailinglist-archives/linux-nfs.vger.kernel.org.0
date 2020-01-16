Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3045313DE7A
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 16:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgAPPTO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 10:19:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45307 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726189AbgAPPTO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jan 2020 10:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579187952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yU7BANNTMeLju2Qk6T4L+gavhdUV2NZ3oWLRX1eKk8o=;
        b=VhwoOCe4KwdHA+7Bc3Fc9Rcci7s6WImMQcEL32K9tuT2E4YXGf91IiN6DCjUyjAK1LfNEk
        wEUcEKhGEOhx4UzQ/dgGopcf6kAsrk4PlLMTS8VDeWtAqBYeQCFcNxys35msdCiP73I0cO
        HfJh/CQHyMvp1ewJ2qmrkrwN/egxq7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-t9Fkhp3sOWOsIiwIWp0yIg-1; Thu, 16 Jan 2020 10:19:09 -0500
X-MC-Unique: t9Fkhp3sOWOsIiwIWp0yIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48F37800D41;
        Thu, 16 Jan 2020 15:19:08 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF0951001902;
        Thu, 16 Jan 2020 15:19:07 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] NFS: Don't skip lookup when holding a delegation
Date:   Thu, 16 Jan 2020 10:19:06 -0500
Message-ID: <6399DBA2-DA9D-40C3-80BC-6DCE94BB9C49@redhat.com>
In-Reply-To: <77be993185fa7f114f6856f74f2f7affb5bd411d.1568904510.git.bcodding@redhat.com>
References: <77be993185fa7f114f6856f74f2f7affb5bd411d.1568904510.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'd like to bump this one again while we're talking about 
lookup/revalidation.

We have folks that hit this problem in the field:
     - client caches a dentry
     - file gets moved
     - server gives out a delegation
     - client never notices the change because we always skip 
revalidation

Is this the wrong place to fix this?  Any other feedback?

Ben

On 19 Sep 2019, at 10:49, Benjamin Coddington wrote:

> If we skip lookup revalidation while holding a delegation, we might 
> miss
> that the file has changed directories on the server.  The directory's
> change attribute should still be checked against the dentry's d_time 
> to
> perform a complete revalidation.
>
> V2 - Add some commentary as suggested-by J. Bruce Fields.
>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/dir.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 0adfd8840110..8723e82f5c9d 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1197,12 +1197,20 @@ nfs_do_lookup_revalidate(struct inode *dir, 
> struct dentry *dentry,
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
> +		/*
> +		 * Note that the file can't move while we hold a
> +		 * delegation.  But this dentry could have been cached
> +		 * before we got a delegation.  So it's only safe to
> +		 * skip revalidation when the parent directory is
> +		 * unchanged:
> +		 */
> +		if (NFS_PROTO(dir)->have_delegation(inode, FMODE_READ))
> +			return nfs_lookup_revalidate_delegated(dir, dentry, inode);
> +
>  		error = nfs_lookup_verify_inode(inode, flags);
>  		if (error) {
>  			if (error == -ESTALE)
> @@ -1635,9 +1643,6 @@ nfs4_do_lookup_revalidate(struct inode *dir, 
> struct dentry *dentry,
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

