Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1A1D9D94
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2019 23:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbfJPViO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Oct 2019 17:38:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727447AbfJPViO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 16 Oct 2019 17:38:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7AF2F30832C0;
        Wed, 16 Oct 2019 21:38:14 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-120-208.rdu2.redhat.com [10.10.120.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DC2060852;
        Wed, 16 Oct 2019 21:38:14 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 6583F120272; Wed, 16 Oct 2019 17:38:13 -0400 (EDT)
Date:   Wed, 16 Oct 2019 17:38:13 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>,
        Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Subject: Re: [PATCH 1/3] SUNRPC: The TCP back channel mustn't disappear while
 requests are outstanding
Message-ID: <20191016213813.GB1987@pick.fieldses.org>
References: <20191016141546.32277-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016141546.32277-1-trond.myklebust@hammerspace.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 16 Oct 2019 21:38:14 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These make sense to me.  (But I'll confess I haven't been following the
back and forth with Neil.)

On Wed, Oct 16, 2019 at 10:15:44AM -0400, Trond Myklebust wrote:
> If there are TCP back channel requests either being processed by the

In this patch and the next, is the "either" unnecessary, or was there
some other condition you meant to mention?

--b.

> server threads, then we should hold a reference to the transport
> to ensure it doesn't get freed from underneath us.
> 
> Reported-by: Neil Brown <neilb@suse.de>
> Fixes: 2ea24497a1b3 ("SUNRPC: RPC callbacks may be split across several..")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  net/sunrpc/backchannel_rqst.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
> index 339e8c077c2d..7eb251372f94 100644
> --- a/net/sunrpc/backchannel_rqst.c
> +++ b/net/sunrpc/backchannel_rqst.c
> @@ -307,8 +307,8 @@ void xprt_free_bc_rqst(struct rpc_rqst *req)
>  		 */
>  		dprintk("RPC:       Last session removed req=%p\n", req);
>  		xprt_free_allocation(req);
> -		return;
>  	}
> +	xprt_put(xprt);
>  }
>  
>  /*
> @@ -339,7 +339,7 @@ struct rpc_rqst *xprt_lookup_bc_request(struct rpc_xprt *xprt, __be32 xid)
>  		spin_unlock(&xprt->bc_pa_lock);
>  		if (new) {
>  			if (req != new)
> -				xprt_free_bc_rqst(new);
> +				xprt_free_allocation(new);
>  			break;
>  		} else if (req)
>  			break;
> @@ -368,6 +368,7 @@ void xprt_complete_bc_request(struct rpc_rqst *req, uint32_t copied)
>  	set_bit(RPC_BC_PA_IN_USE, &req->rq_bc_pa_state);
>  
>  	dprintk("RPC:       add callback request to list\n");
> +	xprt_get(xprt);
>  	spin_lock(&bc_serv->sv_cb_lock);
>  	list_add(&req->rq_bc_list, &bc_serv->sv_cb_list);
>  	wake_up(&bc_serv->sv_cb_waitq);
> -- 
> 2.21.0
> 
