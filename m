Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA4C18B964
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 15:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCSOaS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 10:30:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:55130 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726795AbgCSOaS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Mar 2020 10:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584628217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lPZseBpYEOdWvh2ClBRW7TuYgcnIAPkQGs3zbJW3LBg=;
        b=ZAYucIBsCSvBgVCM4zfyyeiz0rJ35aTg4Fxfr5QN6Z6xin5WGFIMP7Ppkv3xWX322QwP0Y
        L8ZgM7D4ifgTTMlQuQjXVyhb91lbxHKJTk6sS6ITTYDpHmDy+Ay0RQaLk96A989UzyNVUP
        t7QgsJaFDWDW6Zl2p6llw7KB88nOkKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-cD3Qs_vMODiq8I3OVBH9gg-1; Thu, 19 Mar 2020 10:30:16 -0400
X-MC-Unique: cD3Qs_vMODiq8I3OVBH9gg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B387DA1360;
        Thu, 19 Mar 2020 14:30:14 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 12DD519C58;
        Thu, 19 Mar 2020 14:30:13 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd4: kill warnings on testing stateids with mismatched
 clientids
Date:   Thu, 19 Mar 2020 10:30:53 -0400
Message-ID: <A2752AC8-E6FF-4ED7-86BE-4D64ACE1F7D7@redhat.com>
In-Reply-To: <20200319141849.GB1546@fieldses.org>
References: <20200319141849.GB1546@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 19 Mar 2020, at 10:18, J. Bruce Fields wrote:

> From: "J. Bruce Fields" <bfields@redhat.com>
>
> It's normal for a client to test a stateid from a previous instance,
> e.g. after a network partition.
>
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

Thanks!

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

> ---
>  fs/nfsd/nfs4state.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> I'm not a fan of printk's even on buggy client behavior.  I guess it
> could be a dprintk.  I'm not sure it adds much over information you
> could get at some other layer, e.g. from a network trace.
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c1f347bbf8f4..927cfb9d2204 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5522,15 +5522,8 @@ static __be32 nfsd4_validate_stateid(struct 
> nfs4_client *cl, stateid_t *stateid)
>  	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
>  		CLOSE_STATEID(stateid))
>  		return status;
> -	/* Client debugging aid. */
> -	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid)) {
> -		char addr_str[INET6_ADDRSTRLEN];
> -		rpc_ntop((struct sockaddr *)&cl->cl_addr, addr_str,
> -				 sizeof(addr_str));
> -		pr_warn_ratelimited("NFSD: client %s testing state ID "
> -					"with incorrect client ID\n", addr_str);
> +	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid))
>  		return status;
> -	}
>  	spin_lock(&cl->cl_lock);
>  	s = find_stateid_locked(cl, stateid);
>  	if (!s)
> -- 
> 2.25.1

