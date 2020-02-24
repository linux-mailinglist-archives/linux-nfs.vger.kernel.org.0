Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4166016AB1D
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2020 17:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgBXQPM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Feb 2020 11:15:12 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45756 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgBXQPM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Feb 2020 11:15:12 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so10773840ioi.12;
        Mon, 24 Feb 2020 08:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:message-id:subject:from:to:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=49KkQtE+PMPYrBnD5B3WEr2NU+9hgZB7snC3utxnBpI=;
        b=rfhMSl/N7yIwOiUgHMz4acYE/jVIg5rYEZ5EsiH3hRNuKZRC5C6M1XCekFuVg8xyRW
         7Xk8U2BmhACxPfQAkYK2C/KUCiNx8sMBo25SIUBGWZymb7NDgo3S6EoEhWr5bFUvkjlb
         QcypLG/JQlWPdOLQYU24mhUh/eDQLccGTQ6gaWpKq+hjs5aYBYu7jWnN2x60U7y6bB7a
         ZSdo8mbwz6wmh5yjvi73a6W55naLywfgFJbHnqdyaRoVoBdL7MLloF0Urcasqqhj4C8S
         iQ1Go506qXEr7+F3AIv/ZT87Q2Uuo0MC5ZpWkSf0mvnjz59yvRBj8I+oh9q/su9iKSC+
         nIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:message-id:subject:from:to:date
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=49KkQtE+PMPYrBnD5B3WEr2NU+9hgZB7snC3utxnBpI=;
        b=C2i5T1twVm4sm+aaAOsKjku8eukK9tjNV9ko/hsvJgfPb5Stk1RX7biHBJxfMD3K/o
         05DKeG6tf36Od61q3G/gA4jxRsPg2CB8L2zM13ZqPqQNUCGRDYGB+7esRJjoe3mVK5yG
         WMokbnPXQt+btQlmXhuNUXw+/PUKF4tDpMK8jeDQaKPCMziNuSK4aVkVyHcyQbRqDJNH
         UghsKauhw+MMnRmktA8AlAiMqPwmjISgJQTYEilnQj8eK1px3lBERj38lB/TZkbkhtth
         CBJkig4W8bL252GN3TSAYIaCTrVTzyw5/UiSxSogd/6UP6AjHh9x5tAmv5/zF1ngeNol
         IRDw==
X-Gm-Message-State: APjAAAV5etrfCY+tjg8DWNqIk4acqY3Cf9vleaARkRGDDXkgLOtzvfnZ
        3thO5VOiR+5i+NO0VZQFE5o=
X-Google-Smtp-Source: APXvYqyqri5YdQMSF5pppjqyW9Q3r4+DKMwV7cXI8o0AxO6aL9d4gNRkNitZTiKWJdge7EPtlfp8Ig==
X-Received: by 2002:a02:cf0e:: with SMTP id q14mr52577746jar.82.1582560911211;
        Mon, 24 Feb 2020 08:15:11 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.googlemail.com with ESMTPSA id w79sm4437799ill.70.2020.02.24.08.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 08:15:10 -0800 (PST)
Message-ID: <57e16538f7a711d7671056d19abc38a09afc451d.camel@gmail.com>
Subject: Re: [PATCH v1 10/11] xprtrdma: Extract sockaddr from struct
 rdma_cm_id
From:   Anna Schumaker <schumaker.anna@gmail.com>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org
Date:   Mon, 24 Feb 2020 11:15:09 -0500
In-Reply-To: <20200221220100.2072.45609.stgit@manet.1015granger.net>
References: <20200221214906.2072.32572.stgit@manet.1015granger.net>
         <20200221220100.2072.45609.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On Fri, 2020-02-21 at 17:01 -0500, Chuck Lever wrote:
> rpcrdma_cm_event_handler() is always passed an @id pointer that is
> valid. However, in a subsequent patch, we won't be able to extract
> an r_xprt in every case. So instead of using the r_xprt's
> presentation address strings, extract them from struct rdma_cm_id.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/trace/events/rpcrdma.h |   78 +++++++++++++++++++++++++++----------
> ---
>  net/sunrpc/xprtrdma/verbs.c    |   33 +++++++----------
>  2 files changed, 67 insertions(+), 44 deletions(-)
> 
> diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
> index bebc45f7c570..a6d3a2122e9b 100644
> --- a/include/trace/events/rpcrdma.h
> +++ b/include/trace/events/rpcrdma.h
> @@ -373,47 +373,74 @@
>  
>  TRACE_EVENT(xprtrdma_inline_thresh,
>  	TP_PROTO(
> -		const struct rpcrdma_xprt *r_xprt
> +		const struct rpcrdma_ep *ep
>  	),
>  
> -	TP_ARGS(r_xprt),
> +	TP_ARGS(ep),
>  
>  	TP_STRUCT__entry(
> -		__field(const void *, r_xprt)
>  		__field(unsigned int, inline_send)
>  		__field(unsigned int, inline_recv)
>  		__field(unsigned int, max_send)
>  		__field(unsigned int, max_recv)
> -		__string(addr, rpcrdma_addrstr(r_xprt))
> -		__string(port, rpcrdma_portstr(r_xprt))
> +		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
> +		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
>  	),
>  
>  	TP_fast_assign(
> -		const struct rpcrdma_ep *ep = &r_xprt->rx_ep;
> +		const struct rdma_cm_id *id = ep->re_id;
>  
> -		__entry->r_xprt = r_xprt;
>  		__entry->inline_send = ep->re_inline_send;
>  		__entry->inline_recv = ep->re_inline_recv;
>  		__entry->max_send = ep->re_max_inline_send;
>  		__entry->max_recv = ep->re_max_inline_recv;
> -		__assign_str(addr, rpcrdma_addrstr(r_xprt));
> -		__assign_str(port, rpcrdma_portstr(r_xprt));
> +		memcpy(__entry->srcaddr, &id->route.addr.src_addr,
> +		       sizeof(struct sockaddr_in6));
> +		memcpy(__entry->dstaddr, &id->route.addr.dst_addr,
> +		       sizeof(struct sockaddr_in6));
>  	),
>  
> -	TP_printk("peer=[%s]:%s r_xprt=%p neg send/recv=%u/%u, calc
> send/recv=%u/%u",
> -		__get_str(addr), __get_str(port), __entry->r_xprt,
> +	TP_printk("%pISpc -> %pISpc neg send/recv=%u/%u, calc send/recv=%u/%u",
> +		__entry->srcaddr, __entry->dstaddr,
>  		__entry->inline_send, __entry->inline_recv,
>  		__entry->max_send, __entry->max_recv
>  	)
>  );
>  
> +TRACE_EVENT(xprtrdma_remove,
> +	TP_PROTO(
> +		const struct rpcrdma_ep *ep
> +	),
> +
> +	TP_ARGS(ep),
> +
> +	TP_STRUCT__entry(
> +		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
> +		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
> +		__string(name, ep->re_id->device->name)
> +	),
> +
> +	TP_fast_assign(
> +		const struct rdma_cm_id *id = ep->re_id;
> +
> +		memcpy(__entry->srcaddr, &id->route.addr.src_addr,
> +		       sizeof(struct sockaddr_in6));
> +		memcpy(__entry->dstaddr, &id->route.addr.dst_addr,
> +		       sizeof(struct sockaddr_in6));
> +		__assign_str(name, id->device->name);
> +	),
> +
> +	TP_printk("%pISpc -> %pISpc device=%s",
> +		__entry->srcaddr, __entry->dstaddr, __get_str(name)
> +	)
> +);
> +
>  DEFINE_CONN_EVENT(connect);
>  DEFINE_CONN_EVENT(disconnect);
>  DEFINE_CONN_EVENT(flush_dct);
>  
>  DEFINE_RXPRT_EVENT(xprtrdma_create);
>  DEFINE_RXPRT_EVENT(xprtrdma_op_destroy);
> -DEFINE_RXPRT_EVENT(xprtrdma_remove);
>  DEFINE_RXPRT_EVENT(xprtrdma_op_inject_dsc);
>  DEFINE_RXPRT_EVENT(xprtrdma_op_close);
>  DEFINE_RXPRT_EVENT(xprtrdma_op_setport);
> @@ -480,32 +507,33 @@
>  
>  TRACE_EVENT(xprtrdma_qp_event,
>  	TP_PROTO(
> -		const struct rpcrdma_xprt *r_xprt,
> +		const struct rpcrdma_ep *ep,
>  		const struct ib_event *event
>  	),
>  
> -	TP_ARGS(r_xprt, event),
> +	TP_ARGS(ep, event),
>  
>  	TP_STRUCT__entry(
> -		__field(const void *, r_xprt)
> -		__field(unsigned int, event)
> +		__field(unsigned long, event)
>  		__string(name, event->device->name)
> -		__string(addr, rpcrdma_addrstr(r_xprt))
> -		__string(port, rpcrdma_portstr(r_xprt))
> +		__array(unsigned char, srcaddr, sizeof(struct sockaddr_in6))
> +		__array(unsigned char, dstaddr, sizeof(struct sockaddr_in6))
>  	),
>  
>  	TP_fast_assign(
> -		__entry->r_xprt = r_xprt;
> +		const struct rdma_cm_id *id = ep->re_id;
> +
>  		__entry->event = event->event;
>  		__assign_str(name, event->device->name);
> -		__assign_str(addr, rpcrdma_addrstr(r_xprt));
> -		__assign_str(port, rpcrdma_portstr(r_xprt));
> +		memcpy(__entry->srcaddr, &id->route.addr.src_addr,
> +		       sizeof(struct sockaddr_in6));
> +		memcpy(__entry->dstaddr, &id->route.addr.dst_addr,
> +		       sizeof(struct sockaddr_in6));
>  	),
>  
> -	TP_printk("peer=[%s]:%s r_xprt=%p: dev %s: %s (%u)",
> -		__get_str(addr), __get_str(port), __entry->r_xprt,
> -		__get_str(name), rdma_show_ib_event(__entry->event),
> -		__entry->event
> +	TP_printk("%pISpc -> %pISpc device=%s %s (%lu)",
> +		__entry->srcaddr, __entry->dstaddr, __get_str(name),
> +		rdma_show_ib_event(__entry->event), __entry->event
>  	)
>  );
>  
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 10826982ddf8..5cb308fb4f0f 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -116,16 +116,14 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt
> *r_xprt)
>   * @context: ep that owns QP where event occurred
>   *
>   * Called from the RDMA provider (device driver) possibly in an interrupt
> - * context.
> + * context. The QP is always destroyed before the ID, so the ID will be
> + * reliably available when this handler is invoked.
>   */
> -static void
> -rpcrdma_qp_event_handler(struct ib_event *event, void *context)
> +static void rpcrdma_qp_event_handler(struct ib_event *event, void *context)
>  {
>  	struct rpcrdma_ep *ep = context;
> -	struct rpcrdma_xprt *r_xprt = container_of(ep, struct rpcrdma_xprt,
> -						   rx_ep);
>  
> -	trace_xprtrdma_qp_event(r_xprt, event);
> +	trace_xprtrdma_qp_event(ep, event);
>  }
>  
>  /**
> @@ -202,11 +200,10 @@ static void rpcrdma_wc_receive(struct ib_cq *cq, struct
> ib_wc *wc)
>  	rpcrdma_rep_destroy(rep);
>  }
>  
> -static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
> +static void rpcrdma_update_cm_private(struct rpcrdma_ep *ep,
>  				      struct rdma_conn_param *param)
>  {
>  	const struct rpcrdma_connect_private *pmsg = param->private_data;
> -	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
>  	unsigned int rsize, wsize;
>  
>  	/* Default settings for RPC-over-RDMA Version One */
> @@ -241,6 +238,7 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt
> *r_xprt,
>  static int
>  rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
>  {
> +	struct sockaddr *sap = (struct sockaddr *)&id->route.addr.dst_addr;

Is there an clean way to put this inside the CONFIG_SUNRPC_DEBUG lines below?
I'm getting an "unused variable 'sap'" warning when CONFIG_SUNRPC_DEBUG=n.

Thanks,
Anna

>  	struct rpcrdma_xprt *r_xprt = id->context;
>  	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
>  	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
> @@ -264,23 +262,22 @@ static void rpcrdma_update_cm_private(struct
> rpcrdma_xprt *r_xprt,
>  		return 0;
>  	case RDMA_CM_EVENT_DEVICE_REMOVAL:
>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
> -		pr_info("rpcrdma: removing device %s for %s:%s\n",
> -			ep->re_id->device->name,
> -			rpcrdma_addrstr(r_xprt), rpcrdma_portstr(r_xprt));
> +		pr_info("rpcrdma: removing device %s for %pISpc\n",
> +			ep->re_id->device->name, sap);
>  #endif
>  		init_completion(&ep->re_remove_done);
>  		ep->re_connect_status = -ENODEV;
>  		xprt_force_disconnect(xprt);
>  		wait_for_completion(&ep->re_remove_done);
> -		trace_xprtrdma_remove(r_xprt);
> +		trace_xprtrdma_remove(ep);
>  
>  		/* Return 1 to ensure the core destroys the id. */
>  		return 1;
>  	case RDMA_CM_EVENT_ESTABLISHED:
>  		++xprt->connect_cookie;
>  		ep->re_connect_status = 1;
> -		rpcrdma_update_cm_private(r_xprt, &event->param.conn);
> -		trace_xprtrdma_inline_thresh(r_xprt);
> +		rpcrdma_update_cm_private(ep, &event->param.conn);
> +		trace_xprtrdma_inline_thresh(ep);
>  		wake_up_all(&ep->re_connect_wait);
>  		break;
>  	case RDMA_CM_EVENT_CONNECT_ERROR:
> @@ -290,9 +287,8 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt
> *r_xprt,
>  		ep->re_connect_status = -ENETUNREACH;
>  		goto disconnected;
>  	case RDMA_CM_EVENT_REJECTED:
> -		dprintk("rpcrdma: connection to %s:%s rejected: %s\n",
> -			rpcrdma_addrstr(r_xprt), rpcrdma_portstr(r_xprt),
> -			rdma_reject_msg(id, event->status));
> +		dprintk("rpcrdma: connection to %pISpc rejected: %s\n",
> +			sap, rdma_reject_msg(id, event->status));
>  		ep->re_connect_status = -ECONNREFUSED;
>  		if (event->status == IB_CM_REJ_STALE_CONN)
>  			ep->re_connect_status = -EAGAIN;
> @@ -307,8 +303,7 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt
> *r_xprt,
>  		break;
>  	}
>  
> -	dprintk("RPC:       %s: %s:%s on %s/frwr: %s\n", __func__,
> -		rpcrdma_addrstr(r_xprt), rpcrdma_portstr(r_xprt),
> +	dprintk("RPC:       %s: %pISpc on %s/frwr: %s\n", __func__, sap,
>  		ep->re_id->device->name, rdma_event_msg(event->event));
>  	return 0;
>  }
> 

