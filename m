Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F35232CB2D
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 04:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhCDD4z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 22:56:55 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:63784 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbhCDD4s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 22:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1614830209; x=1646366209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hDq43FgTjMQqVeHa2y9bAHKINabF4wyv9pW3HHBaFu0=;
  b=qdlEEufMTiyjsWHFjZStk7o/Txok7GfvBOqpwtSFSsFqV2nvCGbMCcRk
   o3recBfvoZV7RMOkIvjSWcNni+jmR0QoBzTAmp+9mtXRueqpuBpleCZtn
   Lu/JoPzMAaIwCAHBuS3iOVzepRdmWHNEaRr7QAB6EvtkX+Wc72Sgd6e6w
   I=;
X-IronPort-AV: E=Sophos;i="5.81,221,1610409600"; 
   d="scan'208";a="89715014"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 04 Mar 2021 03:56:07 +0000
Received: from EX13MTAUEE002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id C4311A253C;
        Thu,  4 Mar 2021 03:56:06 +0000 (UTC)
Received: from EX13D30UEE001.ant.amazon.com (10.43.62.85) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 4 Mar 2021 03:56:06 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D30UEE001.ant.amazon.com (10.43.62.85) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 4 Mar 2021 03:56:06 +0000
Received: from dev-dsk-gerardu-1d-3da90cb4.us-east-1.amazon.com
 (10.200.231.78) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 4 Mar 2021 03:56:06 +0000
Received: by dev-dsk-gerardu-1d-3da90cb4.us-east-1.amazon.com (Postfix, from userid 5408343)
        id 55B924A3; Thu,  4 Mar 2021 03:56:06 +0000 (UTC)
Date:   Thu, 4 Mar 2021 03:56:06 +0000
From:   Geert Jansen <gerardu@amazon.com>
To:     <trondmy@kernel.org>
CC:     <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] NFS: Don't revalidate the directory permissions on a
 lookup failure
Message-ID: <20210304035605.GA13323@dev-dsk-gerardu-1d-3da90cb4.us-east-1.amazon.com>
References: <20210303042836.200413-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210303042836.200413-1-trondmy@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 02, 2021 at 11:28:35PM -0500, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> There should be no reason to expect the directory permissions to change
> just because the directory contents changed or a negative lookup timed
> out. So let's avoid doing a full call to nfs_mark_for_revalidate() in
> that case.
> Furthermore, if this is a negative dentry, and we haven't actually done
> a new lookup, then we have no reason yet to believe the directory has
> changed at all. So let's remove the gratuitous directory inode
> invalidation altogether when called from
> nfs_lookup_revalidate_negative().

Thanks! I tested this patch and 2/2 from this series, and I can confirm
that it addresses the issue that we were seeing.

Tested-by: Geert Jansen <gerardu@amazon.com>

> Reported-by: Geert Jansen <gerardu@amazon.com>
> Fixes: 5ceb9d7fdaaf ("NFS: Refactor nfs_lookup_revalidate()")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/dir.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 19a9f434442f..6350873cb8bd 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1401,6 +1401,15 @@ int nfs_lookup_verify_inode(struct inode *inode, unsigned int flags)
>         goto out;
>  }
> 
> +static void nfs_mark_dir_for_revalidate(struct inode *inode)
> +{
> +       struct nfs_inode *nfsi = NFS_I(inode);
> +
> +       spin_lock(&inode->i_lock);
> +       nfsi->cache_validity |= NFS_INO_REVAL_PAGECACHE;
> +       spin_unlock(&inode->i_lock);
> +}
> +
>  /*
>   * We judge how long we want to trust negative
>   * dentries by looking at the parent inode mtime.
> @@ -1435,7 +1444,6 @@ nfs_lookup_revalidate_done(struct inode *dir, struct dentry *dentry,
>                         __func__, dentry);
>                 return 1;
>         case 0:
> -               nfs_mark_for_revalidate(dir);
>                 if (inode && S_ISDIR(inode->i_mode)) {
>                         /* Purge readdir caches. */
>                         nfs_zap_caches(inode);
> @@ -1525,6 +1533,8 @@ nfs_lookup_revalidate_dentry(struct inode *dir, struct dentry *dentry,
>         nfs_free_fattr(fattr);
>         nfs_free_fhandle(fhandle);
>         nfs4_label_free(label);
> +       if (!ret)
> +               nfs_mark_dir_for_revalidate(dir);
>         return nfs_lookup_revalidate_done(dir, dentry, inode, ret);
>  }
> 
> @@ -1567,7 +1577,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
>                 error = nfs_lookup_verify_inode(inode, flags);
>                 if (error) {
>                         if (error == -ESTALE)
> -                               nfs_zap_caches(dir);
> +                               nfs_mark_dir_for_revalidate(dir);
>                         goto out_bad;
>                 }
>                 nfs_advise_use_readdirplus(dir);
> @@ -2064,7 +2074,7 @@ nfs_add_or_obtain(struct dentry *dentry, struct nfs_fh *fhandle,
>         dput(parent);
>         return d;
>  out_error:
> -       nfs_mark_for_revalidate(dir);
> +       nfs_mark_dir_for_revalidate(dir);
>         d = ERR_PTR(error);
>         goto out;
>  }
> --
> 2.29.2
> 
