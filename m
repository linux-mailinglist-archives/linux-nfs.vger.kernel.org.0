Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 087651235B8
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2019 20:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfLQTaI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Dec 2019 14:30:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50229 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726612AbfLQTaI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Dec 2019 14:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576611007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BQ6+u6GwPugOx7YA6CsXWHaZl0iwp4hG5Sj13uvlR2A=;
        b=LFUXXMsCgwlH6li8SgaxltUinLfKdz/J5oa1D5l+ESuXHDiDHZjbi9UEvJWJJQMQydZOYA
        lwE1ihLv34is5sc7pB71o3kmKFi1G5bfk40Fj1t44/o/zZm02x8uA1k3BWBOjmuWe7GaPM
        ZBbawrs1rovshuKFWGyyQZ7+jqN5FRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-dVbf3I9tMyWh48Rpd96AeA-1; Tue, 17 Dec 2019 14:30:06 -0500
X-MC-Unique: dVbf3I9tMyWh48Rpd96AeA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AC5B18B9F82;
        Tue, 17 Dec 2019 19:30:05 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-117-255.phx2.redhat.com [10.3.117.255])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA0C8620CF;
        Tue, 17 Dec 2019 19:30:04 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 5F33A120197; Tue, 17 Dec 2019 14:30:03 -0500 (EST)
Date:   Tue, 17 Dec 2019 14:30:03 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: Return the correct number of bytes written to the
 file
Message-ID: <20191217193003.GA13504@pick.fieldses.org>
References: <20191217173333.105547-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217173333.105547-1-trond.myklebust@hammerspace.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Dec 17, 2019 at 12:33:33PM -0500, Trond Myklebust wrote:
> We must allow for the fact that iov_iter_write() could have returned
> a short write (e.g. if there was an ENOSPC issue).

Thanks!  Just a nit:

> 
> Fixes: 73da852e3831 ("nfsd: use vfs_iter_read/write")

I think that should be d890be159a71 "nfsd: Add I/O trace points in the
NFSv4 write path".

--b.

> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfsd/vfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index c0dc491537a6..f0bca0e87d0c 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -975,6 +975,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file *file,
>  	host_err = vfs_iter_write(file, &iter, &pos, flags);
>  	if (host_err < 0)
>  		goto out_nfserr;
> +	*cnt = host_err;
>  	nfsdstats.io_write += *cnt;
>  	fsnotify_modify(file);
>  
> -- 
> 2.23.0
> 

