Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD95DD45E1
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2019 18:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfJKQ4E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Oct 2019 12:56:04 -0400
Received: from fieldses.org ([173.255.197.46]:59056 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbfJKQ4E (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Oct 2019 12:56:04 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id A543D1C97; Fri, 11 Oct 2019 12:56:03 -0400 (EDT)
Date:   Fri, 11 Oct 2019 12:56:03 -0400
To:     NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.1 backchannel xprt problems.
Message-ID: <20191011165603.GD19318@fieldses.org>
References: <87tv8iqz3b.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv8iqz3b.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 09, 2019 at 04:15:04PM +1100, NeilBrown wrote:
>  I have a customer with a 4.12-based kernel who is experiencing memory
>  exhaustion.
> 
>  There are over 100,000 rpc_rqst structures queue on sv_cb_list for
>  handing by the NFSv4 callback, which is idle.
> 
>  The rpc_rqst.rq_xprt pointer points to freed memory.
> 
>  I notice that that server code calls svc_xprt_get() on the xprt
>  before storing it in rq_xprt, but the client/backchannel code doesn't.
> 
>  I'm wondering if the following might be useful.
> 
>  I plan to explore the code a bit more tomorrow and if this  still seems
>  likely I get the customer to test this change, but I thought I would
>  ask here as well incase someone more knowledgeable can give me any
>  pointers.

Looks sensible.  But if I ever understood how this works, I've got no
memory of it now....  Good luck.

> 
> Thanks,
> NeilBrown
> 
> diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
> index 339e8c077c2d..c95ca39688b6 100644
> --- a/net/sunrpc/backchannel_rqst.c
> +++ b/net/sunrpc/backchannel_rqst.c
> @@ -61,6 +61,7 @@ static void xprt_free_allocation(struct rpc_rqst *req)
>  	free_page((unsigned long)xbufp->head[0].iov_base);
>  	xbufp = &req->rq_snd_buf;
>  	free_page((unsigned long)xbufp->head[0].iov_base);
> +	xprt_put(req->rq_xprt);
>  	kfree(req);
>  }
>  
> @@ -85,7 +86,7 @@ struct rpc_rqst *xprt_alloc_bc_req(struct rpc_xprt *xprt, gfp_t gfp_flags)
>  	if (req == NULL)
>  		return NULL;
>  
> -	req->rq_xprt = xprt;
> +	req->rq_xprt = xprt_get(xprt);
>  	INIT_LIST_HEAD(&req->rq_bc_list);
>  
>  	/* Preallocate one XDR receive buffer */


