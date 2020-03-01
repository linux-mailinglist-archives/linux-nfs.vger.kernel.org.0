Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCCAE174EDE
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2020 19:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCASLq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Mar 2020 13:11:46 -0500
Received: from p3plsmtpa12-10.prod.phx3.secureserver.net ([68.178.252.239]:46891
        "EHLO p3plsmtpa12-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726592AbgCASLp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Mar 2020 13:11:45 -0500
Received: from [172.20.1.219] ([50.235.29.75])
        by :SMTPAUTH: with ESMTPSA
        id 8T44jUfL6ZiSw8T44jWN7f; Sun, 01 Mar 2020 11:11:45 -0700
X-CMAE-Analysis: v=2.3 cv=JbHCUnCV c=1 sm=1 tr=0
 a=VA9wWQeJdn4CMHigaZiKkA==:117 a=VA9wWQeJdn4CMHigaZiKkA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=yPCof4ZbAAAA:8
 a=uTTicwxXqJULkALxAcoA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v1 05/11] xprtrdma: Allocate Protection Domain in
 rpcrdma_ep_create()
To:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <20200221214906.2072.32572.stgit@manet.1015granger.net>
 <20200221220033.2072.22880.stgit@manet.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <8a1b8d87-48a7-6cc2-66de-121a46d1b6a4@talpey.com>
Date:   Sun, 1 Mar 2020 10:11:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221220033.2072.22880.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLHaajMo5ZmAOZEyDK2g9OZaTq10C0qXP10/M9vSp7dgXSQcNH8Q2jXgszXaSmaWSK7cZT61NdkUWgL8ybxQTg1uQ8RWQ+y+UV7dR6UkEFW8GZ0Djt01
 Ini7sWHSzn+GXlmkOoD81gURAdFOvQ/Ry2zJkWwlGroFuOHcGuZ22Q9ZKcepSNhve87A/3LwgQvN81eta/6U2HNuYtae7Ub0Bp3nop15R2GMfk5mSvocGyiE
 KXMphSsWs6LKCuJt19jLVA==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2/21/2020 2:00 PM, Chuck Lever wrote:
> Make a Protection Domain (PD) a per-connection resource rather than
> a per-transport resource. In other words, when the connection
> terminates, the PD is destroyed.
> 
> Thus there is one less HW resource that remains allocated to a
> transport after a connection is closed.

That's a good goal, but there are cases where the upper layer may
want the PD to be shared. For example, in a multichannel configuration,
where RDMA may not be constrained to use a single connection.

How would this approach support such a requirement? Can a PD be
provided to a new connection?

Tom.

> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   net/sunrpc/xprtrdma/verbs.c |   26 ++++++++++----------------
>   1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index f361213a8157..36fe7baea014 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -363,14 +363,6 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
>   		rc = PTR_ERR(ia->ri_id);
>   		goto out_err;
>   	}
> -
> -	ia->ri_pd = ib_alloc_pd(ia->ri_id->device, 0);
> -	if (IS_ERR(ia->ri_pd)) {
> -		rc = PTR_ERR(ia->ri_pd);
> -		pr_err("rpcrdma: ib_alloc_pd() returned %d\n", rc);
> -		goto out_err;
> -	}
> -
>   	return 0;
>   
>   out_err:
> @@ -403,9 +395,6 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
>   
>   	rpcrdma_ep_destroy(r_xprt);
>   
> -	ib_dealloc_pd(ia->ri_pd);
> -	ia->ri_pd = NULL;
> -
>   	/* Allow waiters to continue */
>   	complete(&ia->ri_remove_done);
>   
> @@ -423,11 +412,6 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
>   	if (ia->ri_id && !IS_ERR(ia->ri_id))
>   		rdma_destroy_id(ia->ri_id);
>   	ia->ri_id = NULL;
> -
> -	/* If the pd is still busy, xprtrdma missed freeing a resource */
> -	if (ia->ri_pd && !IS_ERR(ia->ri_pd))
> -		ib_dealloc_pd(ia->ri_pd);
> -	ia->ri_pd = NULL;
>   }
>   
>   static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt,
> @@ -514,6 +498,12 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt,
>   	ep->rep_remote_cma.flow_control = 0;
>   	ep->rep_remote_cma.rnr_retry_count = 0;
>   
> +	ia->ri_pd = ib_alloc_pd(id->device, 0);
> +	if (IS_ERR(ia->ri_pd)) {
> +		rc = PTR_ERR(ia->ri_pd);
> +		goto out_destroy;
> +	}
> +
>   	rc = rdma_create_qp(id, ia->ri_pd, &ep->rep_attr);
>   	if (rc)
>   		goto out_destroy;
> @@ -540,6 +530,10 @@ static void rpcrdma_ep_destroy(struct rpcrdma_xprt *r_xprt)
>   	if (ep->rep_attr.send_cq)
>   		ib_free_cq(ep->rep_attr.send_cq);
>   	ep->rep_attr.send_cq = NULL;
> +
> +	if (ia->ri_pd)
> +		ib_dealloc_pd(ia->ri_pd);
> +	ia->ri_pd = NULL;
>   }
>   
>   /* Re-establish a connection after a device removal event.
> 
> 
> 
