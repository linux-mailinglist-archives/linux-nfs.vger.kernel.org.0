Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5348E348390
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Mar 2021 22:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbhCXVXt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Mar 2021 17:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21755 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238292AbhCXVXs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Mar 2021 17:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616621028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7XUIbWuoAOjbMJGwp7K2r0/RMkw4ElcGdb9YG/13DPM=;
        b=E82fp94GAIqEt7BzgMXrjASkx4+p9YbFOaVIX4zg236z/pxVeXYs9NWVH13ZHKO207IaCN
        E1/Q6qnVIOVrgHhPvdLOhf9njqv2yTAyOuO4LK29iWZ9f96kjYNj7Ws2BTD31o3zA8Ak6+
        /whFVYBRjTYyQiJiG0ijSEFqAfJuklU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-stFEObQKOhaosDurdUdx-A-1; Wed, 24 Mar 2021 17:23:44 -0400
X-MC-Unique: stFEObQKOhaosDurdUdx-A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84E32801817;
        Wed, 24 Mar 2021 21:23:43 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-116-27.rdu2.redhat.com [10.10.116.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B6791992D;
        Wed, 24 Mar 2021 21:23:43 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id C76BF120207; Wed, 24 Mar 2021 17:23:39 -0400 (EDT)
Date:   Wed, 24 Mar 2021 17:23:39 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] NFS: fix nfs_fetch_iversion()
Message-ID: <YFut25Sq1wvv8Zii@pick.fieldses.org>
References: <20210324195353.577432-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324195353.577432-1-trondmy@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 24, 2021 at 03:53:53PM -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> The change attribute is always set by all NFS client versions so get rid
> of the open-coded version.

Thanks!

I'm unclear whether there's a user-visible bug here or whether it's
mainly cleanup?

--b.

> Fixes: 3cc55f4434b4 ("nfs: use change attribute for NFS re-exports")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/export.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> index f2b34cfe286c..b347e3ce0cc8 100644
> --- a/fs/nfs/export.c
> +++ b/fs/nfs/export.c
> @@ -171,17 +171,10 @@ static u64 nfs_fetch_iversion(struct inode *inode)
>  {
>  	struct nfs_server *server = NFS_SERVER(inode);
>  
> -	/* Is this the right call?: */
> -	nfs_revalidate_inode(server, inode);
> -	/*
> -	 * Also, note we're ignoring any returned error.  That seems to be
> -	 * the practice for cache consistency information elsewhere in
> -	 * the server, but I'm not sure why.
> -	 */
> -	if (server->nfs_client->rpc_ops->version >= 4)
> -		return inode_peek_iversion_raw(inode);
> -	else
> -		return time_to_chattr(&inode->i_ctime);
> +	if (nfs_check_cache_invalid(inode, NFS_INO_INVALID_CHANGE |
> +						   NFS_INO_REVAL_PAGECACHE))
> +		__nfs_revalidate_inode(server, inode);
> +	return inode_peek_iversion_raw(inode);
>  }
>  
>  const struct export_operations nfs_export_ops = {
> -- 
> 2.30.2
> 

