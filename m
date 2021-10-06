Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE58423FF8
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Oct 2021 16:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbhJFOYR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Oct 2021 10:24:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51125 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231738AbhJFOYR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Oct 2021 10:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633530144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NgFcKLlF1ys/aPEIE2b0YuKoHEOl36L7zo6FWZfCn94=;
        b=ICgqo8t6R6p4lYnH5mwG01yu2qNtFkh1ZfZbgDW6d00z5SDsMo0rJP/XtsoiGNNiOr6DeI
        YzLClDby7ZVfoASO+UVhSpR8lSIDxp6rPsN+PWQBtVU/pctQQzX7WlwAkgj7lNjs8llWxj
        aq+3PyILtX+0arLhgSPzqVlDd68rawo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-ToLzYFeTOva6uWOOhNVSpg-1; Wed, 06 Oct 2021 10:22:23 -0400
X-MC-Unique: ToLzYFeTOva6uWOOhNVSpg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 892EC1006AA3;
        Wed,  6 Oct 2021 14:22:22 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FF9510013D7;
        Wed,  6 Oct 2021 14:22:21 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: Keep existing listners on portlist error
Date:   Wed, 06 Oct 2021 10:22:20 -0400
Message-ID: <7A49A6B0-8E89-4123-9A2D-71FCC4B6EEED@redhat.com>
In-Reply-To: <45b916f1aa3fb7c059a574f61188a8f2f615410e.1633529847.git.bcodding@redhat.com>
References: <45b916f1aa3fb7c059a574f61188a8f2f615410e.1633529847.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6 Oct 2021, at 10:18, Benjamin Coddington wrote:

> If nfsd has existing listening sockets without any processes, then an 
> error
> returned from svc_create_xprt() for an additional transport will 
> remove
> those existing listeners.  We're seeing this in practice when 
> userspace
> attempts to create rpcrdma transports without having the rpcrdma 
> modules
> present before creating nfsd kernel processes.  Fix this by checking 
> for
> existing sockets before callingn nfsd_destroy().
>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfsd/nfsctl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index c2c3d9077dc5..df4613a4924c 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -793,7 +793,10 @@ static ssize_t __write_ports_addxprt(char *buf, 
> struct net *net, const struct cr
>  		svc_xprt_put(xprt);
>  	}
>  out_err:
> -	nfsd_destroy(net);
> +	if (list_empty(&nn->nfsd_serv->sv_permsocks))
> +		nfsd_destroy(net);
> +	else
> +		nn->nfsd_serv->sv_nrthreads--;

Eh -- ignore this one, needs a v2 since we might decrement sv_nrthreads 
twice for the INET6 case..

Ben

