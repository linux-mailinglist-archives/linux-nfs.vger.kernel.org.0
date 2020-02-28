Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2A6B1741C4
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 23:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgB1WED (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Feb 2020 17:04:03 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40400 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgB1WEC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Feb 2020 17:04:02 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SM2n9x016979;
        Fri, 28 Feb 2020 22:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : date : references :
 cc : to : message-id; s=corp-2020-01-29;
 bh=u2IyteTo6Ztk21l7Z2Uv14WN7q81IIxV0zT1xupZjNc=;
 b=J3bhNSLOSrHV/Wweo+J3JWAtN3OMYNqw07b3pumcxwzNQVz48wUIrqfNkwRf2R7l4H1n
 1rIeFnUJl9gnKXN0Yfp73ByRt4Fcta/sPsaPwgG6DHfeoXzzEFZhf8xLItC9mApe1RJW
 n9W2z+gXD4klF8IoeQdlKhIUJft10ZPVpB6BDJAiA6qZGpTpm83u9n8jJO80pek0wgMK
 S6u0NttTPqLZeOlnPh6Xgcno0kaH9wAkb1eAK5poCrb10LBeWFkM0YjLRF0SWnI0gnLs
 lU24k5zqrVJby+rZou2gUPpBwnGHQep5xPrlme5Xj81PEzMZX7jrGOBB691LRJySPQPB sg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2ydct3nh4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 22:03:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SM2Ddh149653;
        Fri, 28 Feb 2020 22:03:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ydj4rw41n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 22:03:57 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01SM3sTd013201;
        Fri, 28 Feb 2020 22:03:56 GMT
Received: from [10.11.24.223] (/10.11.24.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 14:03:53 -0800
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Fwd: [PATCH v1 05/16] svcrdma: Create a generic tracing class for
 displaying xdr_buf layout
Date:   Fri, 28 Feb 2020 14:02:14 -0800
References: <158284985994.38468.11081309957716392757.stgit@seurat29.1015granger.net>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <schumaker.anna@gmail.com>
Message-Id: <B7BA77F4-A68D-4649-8290-A99D2CB59329@oracle.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280157
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Just to note this patch hits client paths too.


> Begin forwarded message:
>=20
> From: Chuck Lever <chuck.lever@oracle.com>
> Subject: [PATCH v1 05/16] svcrdma: Create a generic tracing class for =
displaying xdr_buf layout
> Date: February 27, 2020 at 4:30:59 PM PST
> To: bfields@fieldses.org
> Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
>=20
> This class can be used to create trace points in either the RPC
> client or RPC server paths. It simply displays the length of each
> part of an xdr_buf, which is useful to determine that the transport
> and XDR codecs are operating correctly.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> include/trace/events/sunrpc.h |   43 =
+++++++++++++++++++++++++++++++++++++++++
> net/sunrpc/svc_xprt.c         |    6 +++++-
> net/sunrpc/xprt.c             |    4 ++--
> 3 files changed, 50 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/trace/events/sunrpc.h =
b/include/trace/events/sunrpc.h
> index ee993575d2fa..1577223add43 100644
> --- a/include/trace/events/sunrpc.h
> +++ b/include/trace/events/sunrpc.h
> @@ -14,6 +14,49 @@
> #include <linux/net.h>
> #include <linux/tracepoint.h>
>=20
> +DECLARE_EVENT_CLASS(xdr_buf_class,
> +	TP_PROTO(
> +		const struct xdr_buf *xdr
> +	),
> +
> +	TP_ARGS(xdr),
> +
> +	TP_STRUCT__entry(
> +		__field(const void *, head_base)
> +		__field(size_t, head_len)
> +		__field(const void *, tail_base)
> +		__field(size_t, tail_len)
> +		__field(unsigned int, page_len)
> +		__field(unsigned int, msg_len)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->head_base =3D xdr->head[0].iov_base;
> +		__entry->head_len =3D xdr->head[0].iov_len;
> +		__entry->tail_base =3D xdr->tail[0].iov_base;
> +		__entry->tail_len =3D xdr->tail[0].iov_len;
> +		__entry->page_len =3D xdr->page_len;
> +		__entry->msg_len =3D xdr->len;
> +	),
> +
> +	TP_printk("head=3D[%p,%zu] page=3D%u tail=3D[%p,%zu] len=3D%u",
> +		__entry->head_base, __entry->head_len, =
__entry->page_len,
> +		__entry->tail_base, __entry->tail_len, __entry->msg_len
> +	)
> +);
> +
> +#define DEFINE_XDRBUF_EVENT(name)					=
\
> +		DEFINE_EVENT(xdr_buf_class, name,			=
\
> +				TP_PROTO(				=
\
> +					const struct xdr_buf *xdr	=
\
> +				),					=
\
> +				TP_ARGS(xdr))
> +
> +DEFINE_XDRBUF_EVENT(xprt_sendto);
> +DEFINE_XDRBUF_EVENT(xprt_recvfrom);
> +DEFINE_XDRBUF_EVENT(svc_recvfrom);
> +DEFINE_XDRBUF_EVENT(svc_sendto);
> +
> TRACE_DEFINE_ENUM(RPC_AUTH_OK);
> TRACE_DEFINE_ENUM(RPC_AUTH_BADCRED);
> TRACE_DEFINE_ENUM(RPC_AUTH_REJECTEDCRED);
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index de3c077733a7..081564449e98 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -802,6 +802,8 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, =
struct svc_xprt *xprt)
> 			len =3D svc_deferred_recv(rqstp);
> 		else
> 			len =3D xprt->xpt_ops->xpo_recvfrom(rqstp);
> +		if (len > 0)
> +			trace_svc_recvfrom(&rqstp->rq_arg);
> 		rqstp->rq_stime =3D ktime_get();
> 		rqstp->rq_reserved =3D serv->sv_max_mesg;
> 		atomic_add(rqstp->rq_reserved, &xprt->xpt_reserved);
> @@ -912,8 +914,10 @@ int svc_send(struct svc_rqst *rqstp)
> 	if (test_bit(XPT_DEAD, &xprt->xpt_flags)
> 			|| test_bit(XPT_CLOSE, &xprt->xpt_flags))
> 		len =3D -ENOTCONN;
> -	else
> +	else {
> +		trace_svc_sendto(xb);
> 		len =3D xprt->xpt_ops->xpo_sendto(rqstp);
> +	}
> 	mutex_unlock(&xprt->xpt_mutex);
> 	trace_svc_send(rqstp, len);
> 	svc_xprt_release(rqstp);
> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> index 1aafe8d3f3f4..30989d9b61a0 100644
> --- a/net/sunrpc/xprt.c
> +++ b/net/sunrpc/xprt.c
> @@ -1117,9 +1117,8 @@ void xprt_complete_rqst(struct rpc_task *task, =
int copied)
> 	struct rpc_rqst *req =3D task->tk_rqstp;
> 	struct rpc_xprt *xprt =3D req->rq_xprt;
>=20
> -	dprintk("RPC: %5u xid %08x complete (%d bytes received)\n",
> -			task->tk_pid, ntohl(req->rq_xid), copied);
> 	trace_xprt_complete_rqst(xprt, req->rq_xid, copied);
> +	trace_xprt_recvfrom(&req->rq_rcv_buf);
>=20
> 	xprt->stat.recvs++;
>=20
> @@ -1462,6 +1461,7 @@ xprt_request_transmit(struct rpc_rqst *req, =
struct rpc_task *snd_task)
> 	 */
> 	req->rq_ntrans++;
>=20
> +	trace_xprt_sendto(&req->rq_snd_buf);
> 	connect_cookie =3D xprt->connect_cookie;
> 	status =3D xprt->ops->send_request(req);
> 	if (status !=3D 0) {
>=20

--
Chuck Lever



