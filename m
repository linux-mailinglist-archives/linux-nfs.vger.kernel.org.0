Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF50332AAC
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Mar 2021 16:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhCIPhp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Mar 2021 10:37:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58218 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231872AbhCIPhW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Mar 2021 10:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615304241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RhaAQPjjOlWsbQTulUcvF5Mroout05w+T1cN5gfW1HA=;
        b=VlPd9V38Is6Uy9QxdNvDDflrHz51W99KC94xavIkivd5u35ygIXUQYv+j4SvfRw8BO/tK1
        NUK5AjiyuO6hrkDoC/PzIKse/2IrSm6dh/va2leevL7y0wV4AiLlKkg7JgqegOGx/Sy42B
        tCpsRR0JRMAhujuNylu+bXbQRKkepmY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-onALo6C5OWiRDGuSX0I0kw-1; Tue, 09 Mar 2021 10:37:17 -0500
X-MC-Unique: onALo6C5OWiRDGuSX0I0kw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A3B9108BD08;
        Tue,  9 Mar 2021 15:37:16 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-114-27.phx2.redhat.com [10.3.114.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 190D95D9CD;
        Tue,  9 Mar 2021 15:37:16 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 237C3120198; Tue,  9 Mar 2021 10:37:15 -0500 (EST)
Date:   Tue, 9 Mar 2021 10:37:15 -0500
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: fix error handling in callbacks
Message-ID: <YEeWK+gs4c8O7k0u@pick.fieldses.org>
References: <20210309144127.57833-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309144127.57833-1-olga.kornievskaia@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 09, 2021 at 09:41:27AM -0500, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> When the server tries to do a callback and a client fails it due to
> authentication problems, we need the server to set callback down
> flag in RENEW so that client can recover.

I was looking at this.  It looks to me like this should really be just:

	case 1:
		if (task->tk_status)
			nfsd4_mark_cb_down(clp, task->tk_status);

If tk_status showed an error, and the ->done method doesn't return 0 to
tell us it something worth retrying, then the callback failed
permanently, so we should mark the callback path down, regardless of the
exact error.

--b.

> 
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfsd/nfs4callback.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 052be5bf9ef5..7325592b456e 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1189,6 +1189,7 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
>  		switch (task->tk_status) {
>  		case -EIO:
>  		case -ETIMEDOUT:
> +		case -EACCES:
>  			nfsd4_mark_cb_down(clp, task->tk_status);
>  		}
>  		break;
> -- 
> 2.27.0
> 

