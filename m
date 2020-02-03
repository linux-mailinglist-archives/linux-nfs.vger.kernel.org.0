Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 565AF150893
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2020 15:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgBCOmF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Feb 2020 09:42:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48544 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727454AbgBCOmF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Feb 2020 09:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580740923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lixzxSvFrpo8ACZ+mFoc4XSH+6CaaC5C1z4xAKw9EnU=;
        b=Gb0Ay+VFlkZzk7ImFrUfHQCjMBgieMOW5nWXP/5A9cRhaT99FsCJJSsUlPxYUdtFTLcFZg
        PStQJhJmykgSGcQv+KM7YsLsyDSFPN3XTkEN/eXYUTy44BaDTYfeU0apfIakCZqFhGsqfD
        6yZ02gNU7ndsrxvJTVi69kIGY9InwdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-1ooyBL54NQCR23wMMtqZiw-1; Mon, 03 Feb 2020 09:42:00 -0500
X-MC-Unique: 1ooyBL54NQCR23wMMtqZiw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C0281005502;
        Mon,  3 Feb 2020 14:41:59 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 723565DA83;
        Mon,  3 Feb 2020 14:41:58 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@gmail.com>
Cc:     "Anna Schumaker" <Anna.Schumaker@netapp.com>,
        "Dai Ngo" <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 4/4] NFS: Switch readdir to using iterate_shared()
Date:   Mon, 03 Feb 2020 09:41:57 -0500
Message-ID: <03CF6022-FEF6-48D4-9F55-7A7ED9DE6542@redhat.com>
In-Reply-To: <20200202225356.995080-5-trond.myklebust@hammerspace.com>
References: <20200202225356.995080-1-trond.myklebust@hammerspace.com>
 <20200202225356.995080-2-trond.myklebust@hammerspace.com>
 <20200202225356.995080-3-trond.myklebust@hammerspace.com>
 <20200202225356.995080-4-trond.myklebust@hammerspace.com>
 <20200202225356.995080-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2 Feb 2020, at 17:53, Trond Myklebust wrote:

> Now that the page cache locking is repaired, we should be able to
> switch to using iterate_shared() for improved concurrency when
> doing readdir().
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 60387dec9032..803e6fec0266 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -58,7 +58,7 @@ static void nfs_readdir_clear_array(struct page*);
>  const struct file_operations nfs_dir_operations = {
>  	.llseek		= nfs_llseek_dir,
>  	.read		= generic_read_dir,
> -	.iterate	= nfs_readdir,
> +	.iterate_shared	= nfs_readdir,
>  	.open		= nfs_opendir,
>  	.release	= nfs_closedir,
>  	.fsync		= nfs_fsync_dir,

Jeez, it makes a lot of sense just to use the page lock.  Wish I could have
thought of that a long time ago.  Thanks for this, we'll send it through
some testing, but it looks good to me.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

