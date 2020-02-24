Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F242916AB2C
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2020 17:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgBXQS2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Feb 2020 11:18:28 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47144 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgBXQS1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Feb 2020 11:18:27 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OG7bP7114412;
        Mon, 24 Feb 2020 16:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ow4LHRwEWfC/sG5paeRjJYOrPqvPo3lvBTny14veKZg=;
 b=KHoEqrFINbcM8hi3uvQ5AAOLPllLUeMNPhd3rqFvQRdc/5w0N/cm+GqyTQhE+TGVKMpb
 WxE9kCCoinLMc2BfuBd2PUXU83bhT1dAeVwCi2cAEO857ojckftEh8EgbVprQXXNhi3a
 3sgscPsaaEQQ0LRE1/V//r/SNT9rq3IuLKaIv6rNA8K+7rWbFdvV1VMIc2kUCSXGVKy3
 pSldj6lHA/LEgwbP62W+jDYwBSGm5fcZiyRXXX8vvD2xpF4KmEGo/cMVEUXu1huVJ7zr
 b+8VjaYirjZCZhxo6/xt8Db5lXUC3WxYatpVsPksYI4zPvJPz0ppFR3imMbqA6BgxouZ XA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ybvr4mnvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 16:18:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OG7wxZ120575;
        Mon, 24 Feb 2020 16:18:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ybe11k2p1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 16:18:23 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OGINqr028348;
        Mon, 24 Feb 2020 16:18:23 GMT
Received: from [172.16.5.101] (/4.28.11.152)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Feb 2020 08:18:22 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 10/11] xprtrdma: Extract sockaddr from struct
 rdma_cm_id
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <57e16538f7a711d7671056d19abc38a09afc451d.camel@gmail.com>
Date:   Mon, 24 Feb 2020 08:18:20 -0800
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3099D78C-CBA7-43ED-86A1-4C757C7B9F93@oracle.com>
References: <20200221214906.2072.32572.stgit@manet.1015granger.net>
 <20200221220100.2072.45609.stgit@manet.1015granger.net>
 <57e16538f7a711d7671056d19abc38a09afc451d.camel@gmail.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240128
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 24, 2020, at 8:15 AM, Anna Schumaker <schumaker.anna@gmail.com> =
wrote:
>=20
> Hi Chuck,
>=20
> On Fri, 2020-02-21 at 17:01 -0500, Chuck Lever wrote:
>> rpcrdma_cm_event_handler() is always passed an @id pointer that is
>> valid. However, in a subsequent patch, we won't be able to extract
>> an r_xprt in every case. So instead of using the r_xprt's
>> presentation address strings, extract them from struct rdma_cm_id.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> include/trace/events/rpcrdma.h |   78 =
+++++++++++++++++++++++++++----------
>> ---
>> net/sunrpc/xprtrdma/verbs.c    |   33 +++++++----------
>> 2 files changed, 67 insertions(+), 44 deletions(-)
>>=20
>> diff --git a/include/trace/events/rpcrdma.h =
b/include/trace/events/rpcrdma.h
>> index bebc45f7c570..a6d3a2122e9b 100644
>> --- a/include/trace/events/rpcrdma.h
>> +++ b/include/trace/events/rpcrdma.h
>> @@ -373,47 +373,74 @@
>>=20
>> TRACE_EVENT(xprtrdma_inline_thresh,
>> 	TP_PROTO(
>> -		const struct rpcrdma_xprt *r_xprt
>> +		const struct rpcrdma_ep *ep
>> 	),
>>=20
>> -	TP_ARGS(r_xprt),
>> +	TP_ARGS(ep),
>>=20
>> 	TP_STRUCT__entry(
>> -		__field(const void *, r_xprt)
>> 		__field(unsigned int, inline_send)
>> 		__field(unsigned int, inline_recv)
>> 		__field(unsigned int, max_send)
>> 		__field(unsigned int, max_recv)
>> -		__string(addr, rpcrdma_addrstr(r_xprt))
>> -		__string(port, rpcrdma_portstr(r_xprt))
>> +		__array(unsigned char, srcaddr, sizeof(struct =
sockaddr_in6))
>> +		__array(unsigned char, dstaddr, sizeof(struct =
sockaddr_in6))
>> 	),
>>=20
>> 	TP_fast_assign(
>> -		const struct rpcrdma_ep *ep =3D &r_xprt->rx_ep;
>> +		const struct rdma_cm_id *id =3D ep->re_id;
>>=20
>> -		__entry->r_xprt =3D r_xprt;
>> 		__entry->inline_send =3D ep->re_inline_send;
>> 		__entry->inline_recv =3D ep->re_inline_recv;
>> 		__entry->max_send =3D ep->re_max_inline_send;
>> 		__entry->max_recv =3D ep->re_max_inline_recv;
>> -		__assign_str(addr, rpcrdma_addrstr(r_xprt));
>> -		__assign_str(port, rpcrdma_portstr(r_xprt));
>> +		memcpy(__entry->srcaddr, &id->route.addr.src_addr,
>> +		       sizeof(struct sockaddr_in6));
>> +		memcpy(__entry->dstaddr, &id->route.addr.dst_addr,
>> +		       sizeof(struct sockaddr_in6));
>> 	),
>>=20
>> -	TP_printk("peer=3D[%s]:%s r_xprt=3D%p neg send/recv=3D%u/%u, =
calc
>> send/recv=3D%u/%u",
>> -		__get_str(addr), __get_str(port), __entry->r_xprt,
>> +	TP_printk("%pISpc -> %pISpc neg send/recv=3D%u/%u, calc =
send/recv=3D%u/%u",
>> +		__entry->srcaddr, __entry->dstaddr,
>> 		__entry->inline_send, __entry->inline_recv,
>> 		__entry->max_send, __entry->max_recv
>> 	)
>> );
>>=20
>> +TRACE_EVENT(xprtrdma_remove,
>> +	TP_PROTO(
>> +		const struct rpcrdma_ep *ep
>> +	),
>> +
>> +	TP_ARGS(ep),
>> +
>> +	TP_STRUCT__entry(
>> +		__array(unsigned char, srcaddr, sizeof(struct =
sockaddr_in6))
>> +		__array(unsigned char, dstaddr, sizeof(struct =
sockaddr_in6))
>> +		__string(name, ep->re_id->device->name)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		const struct rdma_cm_id *id =3D ep->re_id;
>> +
>> +		memcpy(__entry->srcaddr, &id->route.addr.src_addr,
>> +		       sizeof(struct sockaddr_in6));
>> +		memcpy(__entry->dstaddr, &id->route.addr.dst_addr,
>> +		       sizeof(struct sockaddr_in6));
>> +		__assign_str(name, id->device->name);
>> +	),
>> +
>> +	TP_printk("%pISpc -> %pISpc device=3D%s",
>> +		__entry->srcaddr, __entry->dstaddr, __get_str(name)
>> +	)
>> +);
>> +
>> DEFINE_CONN_EVENT(connect);
>> DEFINE_CONN_EVENT(disconnect);
>> DEFINE_CONN_EVENT(flush_dct);
>>=20
>> DEFINE_RXPRT_EVENT(xprtrdma_create);
>> DEFINE_RXPRT_EVENT(xprtrdma_op_destroy);
>> -DEFINE_RXPRT_EVENT(xprtrdma_remove);
>> DEFINE_RXPRT_EVENT(xprtrdma_op_inject_dsc);
>> DEFINE_RXPRT_EVENT(xprtrdma_op_close);
>> DEFINE_RXPRT_EVENT(xprtrdma_op_setport);
>> @@ -480,32 +507,33 @@
>>=20
>> TRACE_EVENT(xprtrdma_qp_event,
>> 	TP_PROTO(
>> -		const struct rpcrdma_xprt *r_xprt,
>> +		const struct rpcrdma_ep *ep,
>> 		const struct ib_event *event
>> 	),
>>=20
>> -	TP_ARGS(r_xprt, event),
>> +	TP_ARGS(ep, event),
>>=20
>> 	TP_STRUCT__entry(
>> -		__field(const void *, r_xprt)
>> -		__field(unsigned int, event)
>> +		__field(unsigned long, event)
>> 		__string(name, event->device->name)
>> -		__string(addr, rpcrdma_addrstr(r_xprt))
>> -		__string(port, rpcrdma_portstr(r_xprt))
>> +		__array(unsigned char, srcaddr, sizeof(struct =
sockaddr_in6))
>> +		__array(unsigned char, dstaddr, sizeof(struct =
sockaddr_in6))
>> 	),
>>=20
>> 	TP_fast_assign(
>> -		__entry->r_xprt =3D r_xprt;
>> +		const struct rdma_cm_id *id =3D ep->re_id;
>> +
>> 		__entry->event =3D event->event;
>> 		__assign_str(name, event->device->name);
>> -		__assign_str(addr, rpcrdma_addrstr(r_xprt));
>> -		__assign_str(port, rpcrdma_portstr(r_xprt));
>> +		memcpy(__entry->srcaddr, &id->route.addr.src_addr,
>> +		       sizeof(struct sockaddr_in6));
>> +		memcpy(__entry->dstaddr, &id->route.addr.dst_addr,
>> +		       sizeof(struct sockaddr_in6));
>> 	),
>>=20
>> -	TP_printk("peer=3D[%s]:%s r_xprt=3D%p: dev %s: %s (%u)",
>> -		__get_str(addr), __get_str(port), __entry->r_xprt,
>> -		__get_str(name), rdma_show_ib_event(__entry->event),
>> -		__entry->event
>> +	TP_printk("%pISpc -> %pISpc device=3D%s %s (%lu)",
>> +		__entry->srcaddr, __entry->dstaddr, __get_str(name),
>> +		rdma_show_ib_event(__entry->event), __entry->event
>> 	)
>> );
>>=20
>> diff --git a/net/sunrpc/xprtrdma/verbs.c =
b/net/sunrpc/xprtrdma/verbs.c
>> index 10826982ddf8..5cb308fb4f0f 100644
>> --- a/net/sunrpc/xprtrdma/verbs.c
>> +++ b/net/sunrpc/xprtrdma/verbs.c
>> @@ -116,16 +116,14 @@ static void rpcrdma_xprt_drain(struct =
rpcrdma_xprt
>> *r_xprt)
>>  * @context: ep that owns QP where event occurred
>>  *
>>  * Called from the RDMA provider (device driver) possibly in an =
interrupt
>> - * context.
>> + * context. The QP is always destroyed before the ID, so the ID will =
be
>> + * reliably available when this handler is invoked.
>>  */
>> -static void
>> -rpcrdma_qp_event_handler(struct ib_event *event, void *context)
>> +static void rpcrdma_qp_event_handler(struct ib_event *event, void =
*context)
>> {
>> 	struct rpcrdma_ep *ep =3D context;
>> -	struct rpcrdma_xprt *r_xprt =3D container_of(ep, struct =
rpcrdma_xprt,
>> -						rx_ep);
>>=20
>> -	trace_xprtrdma_qp_event(r_xprt, event);
>> +	trace_xprtrdma_qp_event(ep, event);
>> }
>>=20
>> /**
>> @@ -202,11 +200,10 @@ static void rpcrdma_wc_receive(struct ib_cq =
*cq, struct
>> ib_wc *wc)
>> 	rpcrdma_rep_destroy(rep);
>> }
>>=20
>> -static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
>> +static void rpcrdma_update_cm_private(struct rpcrdma_ep *ep,
>> 				      struct rdma_conn_param *param)
>> {
>> 	const struct rpcrdma_connect_private *pmsg =3D =
param->private_data;
>> -	struct rpcrdma_ep *ep =3D &r_xprt->rx_ep;
>> 	unsigned int rsize, wsize;
>>=20
>> 	/* Default settings for RPC-over-RDMA Version One */
>> @@ -241,6 +238,7 @@ static void rpcrdma_update_cm_private(struct =
rpcrdma_xprt
>> *r_xprt,
>> static int
>> rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event =
*event)
>> {
>> +	struct sockaddr *sap =3D (struct sockaddr =
*)&id->route.addr.dst_addr;
>=20
> Is there an clean way to put this inside the CONFIG_SUNRPC_DEBUG lines =
below?
> I'm getting an "unused variable 'sap'" warning when =
CONFIG_SUNRPC_DEBUG=3Dn.

Looking at the RDMA_CM_EVENT_DEVICE_REMOVAL arm, seems like
those are not really debugging messages. What if I deleted
the "#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)" wrapper?


> Thanks,
> Anna
>=20
>> 	struct rpcrdma_xprt *r_xprt =3D id->context;
>> 	struct rpcrdma_ep *ep =3D &r_xprt->rx_ep;
>> 	struct rpc_xprt *xprt =3D &r_xprt->rx_xprt;
>> @@ -264,23 +262,22 @@ static void rpcrdma_update_cm_private(struct
>> rpcrdma_xprt *r_xprt,
>> 		return 0;
>> 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
>> #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>> -		pr_info("rpcrdma: removing device %s for %s:%s\n",
>> -			ep->re_id->device->name,
>> -			rpcrdma_addrstr(r_xprt), =
rpcrdma_portstr(r_xprt));
>> +		pr_info("rpcrdma: removing device %s for %pISpc\n",
>> +			ep->re_id->device->name, sap);
>> #endif
>> 		init_completion(&ep->re_remove_done);
>> 		ep->re_connect_status =3D -ENODEV;
>> 		xprt_force_disconnect(xprt);
>> 		wait_for_completion(&ep->re_remove_done);
>> -		trace_xprtrdma_remove(r_xprt);
>> +		trace_xprtrdma_remove(ep);
>>=20
>> 		/* Return 1 to ensure the core destroys the id. */
>> 		return 1;
>> 	case RDMA_CM_EVENT_ESTABLISHED:
>> 		++xprt->connect_cookie;
>> 		ep->re_connect_status =3D 1;
>> -		rpcrdma_update_cm_private(r_xprt, &event->param.conn);
>> -		trace_xprtrdma_inline_thresh(r_xprt);
>> +		rpcrdma_update_cm_private(ep, &event->param.conn);
>> +		trace_xprtrdma_inline_thresh(ep);
>> 		wake_up_all(&ep->re_connect_wait);
>> 		break;
>> 	case RDMA_CM_EVENT_CONNECT_ERROR:
>> @@ -290,9 +287,8 @@ static void rpcrdma_update_cm_private(struct =
rpcrdma_xprt
>> *r_xprt,
>> 		ep->re_connect_status =3D -ENETUNREACH;
>> 		goto disconnected;
>> 	case RDMA_CM_EVENT_REJECTED:
>> -		dprintk("rpcrdma: connection to %s:%s rejected: %s\n",
>> -			rpcrdma_addrstr(r_xprt), =
rpcrdma_portstr(r_xprt),
>> -			rdma_reject_msg(id, event->status));
>> +		dprintk("rpcrdma: connection to %pISpc rejected: %s\n",
>> +			sap, rdma_reject_msg(id, event->status));
>> 		ep->re_connect_status =3D -ECONNREFUSED;
>> 		if (event->status =3D=3D IB_CM_REJ_STALE_CONN)
>> 			ep->re_connect_status =3D -EAGAIN;
>> @@ -307,8 +303,7 @@ static void rpcrdma_update_cm_private(struct =
rpcrdma_xprt
>> *r_xprt,
>> 		break;
>> 	}
>>=20
>> -	dprintk("RPC:       %s: %s:%s on %s/frwr: %s\n", __func__,
>> -		rpcrdma_addrstr(r_xprt), rpcrdma_portstr(r_xprt),
>> +	dprintk("RPC:       %s: %pISpc on %s/frwr: %s\n", __func__, sap,
>> 		ep->re_id->device->name, rdma_event_msg(event->event));
>> 	return 0;
>> }

--
Chuck Lever



