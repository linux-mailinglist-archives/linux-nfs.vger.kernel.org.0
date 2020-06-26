Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD720B1CB
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2020 14:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgFZM4t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jun 2020 08:56:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58616 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFZM4t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Jun 2020 08:56:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05QCqNLa060632;
        Fri, 26 Jun 2020 12:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=DIznYym8E7Ehl/1d0NTtnal4dVfQP2/AA3ex9x//Tbo=;
 b=OuS1Xy8ZYSxHbcyXYbJ8A4I6ioHRebT1VAnVQ2Tye4zIFdH4U93ktab11jRSGqb7ygom
 c9t9PG/oRDqA8mGFRX3u2KH0/sPu6QJtJAuY2TUx42xzCh5W9OlFa3XRRIzwuGRbFSyK
 nYVMZTF5uEiMNX+3+Sz4YBbwiDdBeLCuJT1Z9WYcsaDEJ2x1Jl1v+E+eEBAk5J9VxK/9
 m8oMYy1rTBYsciVMq8xkSSA5ayUblmKZUX7Jwgzeip7XBVUMzR9P4sqA8Lawh0I8R6fD
 Xk5geqPH/D6SLnjXutPD7cn36P3Ex3oZ7YvzdJd4VeFQqaqW7h2oOcgZW2M6mTU/Qhsn hQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31uusu5wf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Jun 2020 12:56:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05QCsKbX096925;
        Fri, 26 Jun 2020 12:56:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31uuramqrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jun 2020 12:56:44 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05QCuhj1021277;
        Fri, 26 Jun 2020 12:56:43 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Jun 2020 12:56:43 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH] xprtrdma: fix EP destruction logic
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200626071034.34805-1-dan@kernelim.com>
Date:   Fri, 26 Jun 2020 08:56:41 -0400
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FEB41A86-87EB-44BD-BEC4-6EAB3723B426@oracle.com>
References: <0E2AA9D9-2503-462C-952D-FC0DD5111BD1@oracle.com>
 <20200626071034.34805-1-dan@kernelim.com>
To:     Dan Aloni <dan@kernelim.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=1 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006260090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 bulkscore=0
 cotscore=-2147483648 malwarescore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006260090
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 26, 2020, at 3:10 AM, Dan Aloni <dan@kernelim.com> wrote:
>=20
> This fixes various issues found when testing disconnections and other
> various fault injections under a KASAN-enabled kernel.
>=20
> - Swap the names of `rpcrdma_ep_destroy` and `rpcrdma_ep_put` to
>  reflect what the functions are doing.
> - In the cleanup of `rpcrdma_ep_create` do `kfree` on the EP only for
>  the case where no one knows about it, and avoid a double free (what
>  `rpcrdma_ep_destroy` did, followed by `kfree`). No need to set
>  `r_xprt->rx_ep` to NULL because we are doing that only in the success
>  path.
> - Don't up the EP ref in `RDMA_CM_EVENT_ESTABLISHED` but do it sooner
>  before `rdma_connect`. This is needed so that an early wake up of
>  `wait_event_interruptible` in `rpcrdma_xprt_connect` in case of
>  a failure does not see a freed EP.
> - Still try to follow the rule that the last decref of EP performs
>  `rdma_destroy_id(id)`.
> - Only path to disengage an EP is `rpcrdma_xprt_disconnect`, whether =
it
>  is actually connected or not. This makes the error paths of
>  `rpcrdma_xprt_connect` clearer.
> - Add a mutex in `rpcrdma_ep_destroy` to guard against concurrent =
calls
>  to `rpcrdma_xprt_disconnect` coming from either =
`rpcrdma_xprt_connect`
>  or `xprt_rdma_close`.

NAK. The RPC client provides appropriate exclusion, please let's not
add more serialization that can introduce further deadlocks.

There are already patches pending in this area that make some of these
changes, starting with

https://marc.info/?l=3Dlinux-nfs&m=3D159222724808832&w=3D2

Yesterday, I found the other problems you mentioned above after I was
finally able to get my server to REJECT connection attempts. I'll submit
patches to clean all this up once I have tested them.


> Signed-off-by: Dan Aloni <dan@kernelim.com>
> ---
> net/sunrpc/xprtrdma/transport.c |  2 ++
> net/sunrpc/xprtrdma/verbs.c     | 50 ++++++++++++++++++++++-----------
> net/sunrpc/xprtrdma/xprt_rdma.h |  1 +
> 3 files changed, 37 insertions(+), 16 deletions(-)
>=20
> diff --git a/net/sunrpc/xprtrdma/transport.c =
b/net/sunrpc/xprtrdma/transport.c
> index 0c4af7f5e241..50c28be6b694 100644
> --- a/net/sunrpc/xprtrdma/transport.c
> +++ b/net/sunrpc/xprtrdma/transport.c
> @@ -350,6 +350,8 @@ xprt_setup_rdma(struct xprt_create *args)
> 	xprt_rdma_format_addresses(xprt, sap);
>=20
> 	new_xprt =3D rpcx_to_rdmax(xprt);
> +	mutex_init(&new_xprt->rx_flush);
> +
> 	rc =3D rpcrdma_buffer_create(new_xprt);
> 	if (rc) {
> 		xprt_rdma_free_addresses(xprt);
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 2ae348377806..c66871bbb894 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -84,7 +84,7 @@ static void rpcrdma_rep_destroy(struct rpcrdma_rep =
*rep);
> static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt);
> static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
> static void rpcrdma_mrs_destroy(struct rpcrdma_xprt *r_xprt);
> -static int rpcrdma_ep_destroy(struct rpcrdma_ep *ep);
> +static int rpcrdma_ep_put(struct rpcrdma_ep *ep);
> static struct rpcrdma_regbuf *
> rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction,
> 		     gfp_t flags);
> @@ -99,6 +99,9 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt =
*r_xprt)
> {
> 	struct rdma_cm_id *id =3D r_xprt->rx_ep->re_id;
>=20
> +	if (!id->qp)
> +		return;
> +
> 	/* Flush Receives, then wait for deferred Reply work
> 	 * to complete.
> 	 */
> @@ -266,7 +269,6 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, =
struct rdma_cm_event *event)
> 		xprt_force_disconnect(xprt);
> 		goto disconnected;
> 	case RDMA_CM_EVENT_ESTABLISHED:
> -		kref_get(&ep->re_kref);
> 		ep->re_connect_status =3D 1;
> 		rpcrdma_update_cm_private(ep, &event->param.conn);
> 		trace_xprtrdma_inline_thresh(ep);
> @@ -289,7 +291,8 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, =
struct rdma_cm_event *event)
> 		ep->re_connect_status =3D -ECONNABORTED;
> disconnected:
> 		xprt_force_disconnect(xprt);
> -		return rpcrdma_ep_destroy(ep);
> +		wake_up_all(&ep->re_connect_wait);
> +		return rpcrdma_ep_put(ep);
> 	default:
> 		break;
> 	}
> @@ -345,11 +348,11 @@ static struct rdma_cm_id =
*rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
> 	return ERR_PTR(rc);
> }
>=20
> -static void rpcrdma_ep_put(struct kref *kref)
> +static void rpcrdma_ep_destroy(struct kref *kref)
> {
> 	struct rpcrdma_ep *ep =3D container_of(kref, struct rpcrdma_ep, =
re_kref);
>=20
> -	if (ep->re_id->qp) {
> +	if (ep->re_id && ep->re_id->qp) {
> 		rdma_destroy_qp(ep->re_id);
> 		ep->re_id->qp =3D NULL;
> 	}
> @@ -373,9 +376,9 @@ static void rpcrdma_ep_put(struct kref *kref)
>  *     %0 if @ep still has a positive kref count, or
>  *     %1 if @ep was destroyed successfully.
>  */
> -static int rpcrdma_ep_destroy(struct rpcrdma_ep *ep)
> +static int rpcrdma_ep_put(struct rpcrdma_ep *ep)
> {
> -	return kref_put(&ep->re_kref, rpcrdma_ep_put);
> +	return kref_put(&ep->re_kref, rpcrdma_ep_destroy);
> }
>=20
> static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
> @@ -492,11 +495,12 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt =
*r_xprt)
> 	return 0;
>=20
> out_destroy:
> -	rpcrdma_ep_destroy(ep);
> +	rpcrdma_ep_put(ep);
> 	rdma_destroy_id(id);
> +	return rc;
> +
> out_free:
> 	kfree(ep);
> -	r_xprt->rx_ep =3D NULL;
> 	return rc;
> }
>=20
> @@ -510,6 +514,7 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt =
*r_xprt)
> {
> 	struct rpc_xprt *xprt =3D &r_xprt->rx_xprt;
> 	struct rpcrdma_ep *ep;
> +	struct rdma_cm_id *id;
> 	int rc;
>=20
> retry:
> @@ -518,6 +523,7 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt =
*r_xprt)
> 	if (rc)
> 		return rc;
> 	ep =3D r_xprt->rx_ep;
> +	id =3D ep->re_id;
>=20
> 	ep->re_connect_status =3D 0;
> 	xprt_clear_connected(xprt);
> @@ -529,7 +535,10 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt =
*r_xprt)
> 	if (rc)
> 		goto out;
>=20
> -	rc =3D rdma_connect(ep->re_id, &ep->re_remote_cma);
> +	/* =46rom this point on, CM events can discard our EP */
> +	kref_get(&ep->re_kref);
> +
> +	rc =3D rdma_connect(id, &ep->re_remote_cma);
> 	if (rc)
> 		goto out;
>=20
> @@ -546,14 +555,17 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt =
*r_xprt)
>=20
> 	rc =3D rpcrdma_reqs_setup(r_xprt);
> 	if (rc) {
> -		rpcrdma_xprt_disconnect(r_xprt);
> +		ep->re_connect_status =3D rc;
> 		goto out;
> 	}
> +
> 	rpcrdma_mrs_create(r_xprt);
> +	trace_xprtrdma_connect(r_xprt, 0);
> +	return rc;
>=20
> out:
> -	if (rc)
> -		ep->re_connect_status =3D rc;
> +	ep->re_connect_status =3D rc;
> +	rpcrdma_xprt_disconnect(r_xprt);
> 	trace_xprtrdma_connect(r_xprt, rc);
> 	return rc;
> }
> @@ -570,12 +582,15 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt =
*r_xprt)
>  */
> void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt)
> {
> -	struct rpcrdma_ep *ep =3D r_xprt->rx_ep;
> +	struct rpcrdma_ep *ep;
> 	struct rdma_cm_id *id;
> 	int rc;
>=20
> +	mutex_lock(&r_xprt->rx_flush);
> +
> +	ep =3D r_xprt->rx_ep;
> 	if (!ep)
> -		return;
> +		goto out;
>=20
> 	id =3D ep->re_id;
> 	rc =3D rdma_disconnect(id);
> @@ -587,10 +602,13 @@ void rpcrdma_xprt_disconnect(struct rpcrdma_xprt =
*r_xprt)
> 	rpcrdma_mrs_destroy(r_xprt);
> 	rpcrdma_sendctxs_destroy(r_xprt);
>=20
> -	if (rpcrdma_ep_destroy(ep))
> +	if (rpcrdma_ep_put(ep))
> 		rdma_destroy_id(id);
>=20
> 	r_xprt->rx_ep =3D NULL;
> +
> +out:
> +	mutex_unlock(&r_xprt->rx_flush);
> }
>=20
> /* Fixed-size circular FIFO queue. This implementation is wait-free =
and
> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h =
b/net/sunrpc/xprtrdma/xprt_rdma.h
> index 0a16fdb09b2c..288645a9437f 100644
> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> @@ -417,6 +417,7 @@ struct rpcrdma_xprt {
> 	struct delayed_work	rx_connect_worker;
> 	struct rpc_timeout	rx_timeout;
> 	struct rpcrdma_stats	rx_stats;
> +	struct mutex            rx_flush;
> };
>=20
> #define rpcx_to_rdmax(x) container_of(x, struct rpcrdma_xprt, rx_xprt)
> --=20
> 2.25.4
>=20

--
Chuck Lever



