Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A708C1C3F4F
	for <lists+linux-nfs@lfdr.de>; Mon,  4 May 2020 18:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgEDQEP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 May 2020 12:04:15 -0400
Received: from fieldses.org ([173.255.197.46]:45026 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbgEDQEP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 4 May 2020 12:04:15 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 9F954150A; Mon,  4 May 2020 12:04:14 -0400 (EDT)
Date:   Mon, 4 May 2020 12:04:14 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 4/4] SUNRPC: Clean up request deferral tracepoints
Message-ID: <20200504160414.GA2757@fieldses.org>
References: <20200501171750.3764.7676.stgit@klimt.1015granger.net>
 <20200501172227.3764.74938.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501172227.3764.74938.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 01, 2020 at 01:22:27PM -0400, Chuck Lever wrote:
> - Rename these so they are easy to enable and search for as a set
> - Move the tracepoints to get a more accurate sense of control flow
> - Tracepoints should not fire on xprt shutdown
> - Display memory address in case data structure had been corrupted
> - Abandon dprintk in these paths
> 
> I haven't ever gotten one of these tracepoints to trigger. I wonder
> if we should simply remove them.

It's definitely not dead code.  But I forget the conditions required to
hit those cases.  Looking.... So, we in cache_check we have a cache miss
that requires an upcall, and call cache_defer_req, which will wait for a
response 1 or 5 seconds (depending on how busy server threads are) and
then calls svc_defer().

--b.

> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/trace/events/sunrpc.h |   11 ++++++++---
>  net/sunrpc/svc_xprt.c         |   12 ++++++------
>  2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
> index ffd2215950dc..3158b3f7e01e 100644
> --- a/include/trace/events/sunrpc.h
> +++ b/include/trace/events/sunrpc.h
> @@ -1313,27 +1313,32 @@ DECLARE_EVENT_CLASS(svc_deferred_event,
>  	TP_ARGS(dr),
>  
>  	TP_STRUCT__entry(
> +		__field(const void *, dr)
>  		__field(u32, xid)
>  		__string(addr, dr->xprt->xpt_remotebuf)
>  	),
>  
>  	TP_fast_assign(
> +		__entry->dr = dr;
>  		__entry->xid = be32_to_cpu(*(__be32 *)(dr->args +
>  						       (dr->xprt_hlen>>2)));
>  		__assign_str(addr, dr->xprt->xpt_remotebuf);
>  	),
>  
> -	TP_printk("addr=%s xid=0x%08x", __get_str(addr), __entry->xid)
> +	TP_printk("addr=%s dr=%p xid=0x%08x", __get_str(addr), __entry->dr,
> +		__entry->xid)
>  );
> +
>  #define DEFINE_SVC_DEFERRED_EVENT(name) \
> -	DEFINE_EVENT(svc_deferred_event, svc_##name##_deferred, \
> +	DEFINE_EVENT(svc_deferred_event, svc_defer_##name, \
>  			TP_PROTO( \
>  				const struct svc_deferred_req *dr \
>  			), \
>  			TP_ARGS(dr))
>  
>  DEFINE_SVC_DEFERRED_EVENT(drop);
> -DEFINE_SVC_DEFERRED_EVENT(revisit);
> +DEFINE_SVC_DEFERRED_EVENT(queue);
> +DEFINE_SVC_DEFERRED_EVENT(recv);
>  
>  DECLARE_EVENT_CLASS(cache_event,
>  	TP_PROTO(
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 2284ff038dad..e12ec68cd0ff 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -1158,16 +1158,15 @@ static void svc_revisit(struct cache_deferred_req *dreq, int too_many)
>  	set_bit(XPT_DEFERRED, &xprt->xpt_flags);
>  	if (too_many || test_bit(XPT_DEAD, &xprt->xpt_flags)) {
>  		spin_unlock(&xprt->xpt_lock);
> -		dprintk("revisit canceled\n");
> +		trace_svc_defer_drop(dr);
>  		svc_xprt_put(xprt);
> -		trace_svc_drop_deferred(dr);
>  		kfree(dr);
>  		return;
>  	}
> -	dprintk("revisit queued\n");
>  	dr->xprt = NULL;
>  	list_add(&dr->handle.recent, &xprt->xpt_deferred);
>  	spin_unlock(&xprt->xpt_lock);
> +	trace_svc_defer_queue(dr);
>  	svc_xprt_enqueue(xprt);
>  	svc_xprt_put(xprt);
>  }
> @@ -1213,22 +1212,24 @@ static struct cache_deferred_req *svc_defer(struct cache_req *req)
>  		memcpy(dr->args, rqstp->rq_arg.head[0].iov_base - skip,
>  		       dr->argslen << 2);
>  	}
> +	trace_svc_defer(rqstp);
>  	svc_xprt_get(rqstp->rq_xprt);
>  	dr->xprt = rqstp->rq_xprt;
>  	set_bit(RQ_DROPME, &rqstp->rq_flags);
>  
>  	dr->handle.revisit = svc_revisit;
> -	trace_svc_defer(rqstp);
>  	return &dr->handle;
>  }
>  
>  /*
>   * recv data from a deferred request into an active one
>   */
> -static int svc_deferred_recv(struct svc_rqst *rqstp)
> +static noinline int svc_deferred_recv(struct svc_rqst *rqstp)
>  {
>  	struct svc_deferred_req *dr = rqstp->rq_deferred;
>  
> +	trace_svc_defer_recv(dr);
> +
>  	/* setup iov_base past transport header */
>  	rqstp->rq_arg.head[0].iov_base = dr->args + (dr->xprt_hlen>>2);
>  	/* The iov_len does not include the transport header bytes */
> @@ -1259,7 +1260,6 @@ static struct svc_deferred_req *svc_deferred_dequeue(struct svc_xprt *xprt)
>  				struct svc_deferred_req,
>  				handle.recent);
>  		list_del_init(&dr->handle.recent);
> -		trace_svc_revisit_deferred(dr);
>  	} else
>  		clear_bit(XPT_DEFERRED, &xprt->xpt_flags);
>  	spin_unlock(&xprt->xpt_lock);
