Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC2FE13003
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2019 16:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfECOXa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 May 2019 10:23:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47760 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfECOX3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 May 2019 10:23:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x43EItp2189353;
        Fri, 3 May 2019 14:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=mR9lNnh9ej40HnDc26HROfs50GOfX48Sj9+u+NADH90=;
 b=NOxhtfdKWOOTFXGRrJz9AzvJldOlrJu+Aj9vgMJKWH8iL/4+abOYuJuMKUa9CySXNuTt
 4CH9efjaT30HpKX4TV4PfAASUEDrfdLC+bFnlrEQTXzwjdsj5yustG6D81uVcizQG6en
 UaSI2OpbMP7cG5fMOxEdpHrfsg1Rvn/31vyh/HX+Q+lDN1/2XPGGRHrfjUCqMCfxsZHM
 i3NHIPb9BKPQy8Uic8NcXai+UFSf4L4xZS9Bo8rb89+dj4HCdHvO39m8A+i1uKGAsQSC
 4W/SDy+8nZhc5AkosFG7ZzEWyQ/h/CuNbF4HROKKMWRQGk/UislIi9CayszpIHAowUwK Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2s6xhyq3g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 May 2019 14:23:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x43EKnOa144678;
        Fri, 3 May 2019 14:21:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2s7rtcafvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 May 2019 14:21:24 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x43ELMMl012894;
        Fri, 3 May 2019 14:21:22 GMT
Received: from [172.20.15.129] (/173.228.226.134)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 May 2019 07:21:22 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [RFC PATCH 3/5] SUNRPC: Remove the bh-safe lock requirement on
 xprt->transport_lock
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190503111841.4391-4-trond.myklebust@hammerspace.com>
Date:   Fri, 3 May 2019 10:21:25 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EBFAF849-B5F1-4CFD-8DB4-7D66815353C8@oracle.com>
References: <20190503111841.4391-1-trond.myklebust@hammerspace.com>
 <20190503111841.4391-2-trond.myklebust@hammerspace.com>
 <20190503111841.4391-3-trond.myklebust@hammerspace.com>
 <20190503111841.4391-4-trond.myklebust@hammerspace.com>
To:     Trond Myklebust <trondmy@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905030091
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905030091
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 3, 2019, at 7:18 AM, Trond Myklebust <trondmy@gmail.com> wrote:
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> net/sunrpc/xprt.c                          | 61 ++++++++++------------
> net/sunrpc/xprtrdma/rpc_rdma.c             |  4 +-
> net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  4 +-
> net/sunrpc/xprtrdma/svc_rdma_transport.c   |  8 +--
> net/sunrpc/xprtsock.c                      | 23 ++++----
> 5 files changed, 47 insertions(+), 53 deletions(-)

For rpc_rdma.c and svc_rdma_backchannel.c:

   Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

For svc_rdma_transport.c:

These locks are server-side only. AFAICS it's not safe
to leave BH's enabled here. Can you drop these hunks?


> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> index bc1c8247750d..b87d185cf010 100644
> --- a/net/sunrpc/xprt.c
> +++ b/net/sunrpc/xprt.c
> @@ -301,9 +301,9 @@ static inline int xprt_lock_write(struct rpc_xprt =
*xprt, struct rpc_task *task)
>=20
> 	if (test_bit(XPRT_LOCKED, &xprt->state) && xprt->snd_task =3D=3D =
task)
> 		return 1;
> -	spin_lock_bh(&xprt->transport_lock);
> +	spin_lock(&xprt->transport_lock);
> 	retval =3D xprt->ops->reserve_xprt(xprt, task);
> -	spin_unlock_bh(&xprt->transport_lock);
> +	spin_unlock(&xprt->transport_lock);
> 	return retval;
> }
>=20
> @@ -380,9 +380,9 @@ static inline void xprt_release_write(struct =
rpc_xprt *xprt, struct rpc_task *ta
> {
> 	if (xprt->snd_task !=3D task)
> 		return;
> -	spin_lock_bh(&xprt->transport_lock);
> +	spin_lock(&xprt->transport_lock);
> 	xprt->ops->release_xprt(xprt, task);
> -	spin_unlock_bh(&xprt->transport_lock);
> +	spin_unlock(&xprt->transport_lock);
> }
>=20
> /*
> @@ -434,9 +434,9 @@ xprt_request_get_cong(struct rpc_xprt *xprt, =
struct rpc_rqst *req)
>=20
> 	if (req->rq_cong)
> 		return true;
> -	spin_lock_bh(&xprt->transport_lock);
> +	spin_lock(&xprt->transport_lock);
> 	ret =3D __xprt_get_cong(xprt, req) !=3D 0;
> -	spin_unlock_bh(&xprt->transport_lock);
> +	spin_unlock(&xprt->transport_lock);
> 	return ret;
> }
> EXPORT_SYMBOL_GPL(xprt_request_get_cong);
> @@ -463,9 +463,9 @@ static void
> xprt_clear_congestion_window_wait(struct rpc_xprt *xprt)
> {
> 	if (test_and_clear_bit(XPRT_CWND_WAIT, &xprt->state)) {
> -		spin_lock_bh(&xprt->transport_lock);
> +		spin_lock(&xprt->transport_lock);
> 		__xprt_lock_write_next_cong(xprt);
> -		spin_unlock_bh(&xprt->transport_lock);
> +		spin_unlock(&xprt->transport_lock);
> 	}
> }
>=20
> @@ -562,9 +562,9 @@ bool xprt_write_space(struct rpc_xprt *xprt)
>=20
> 	if (!test_bit(XPRT_WRITE_SPACE, &xprt->state))
> 		return false;
> -	spin_lock_bh(&xprt->transport_lock);
> +	spin_lock(&xprt->transport_lock);
> 	ret =3D xprt_clear_write_space_locked(xprt);
> -	spin_unlock_bh(&xprt->transport_lock);
> +	spin_unlock(&xprt->transport_lock);
> 	return ret;
> }
> EXPORT_SYMBOL_GPL(xprt_write_space);
> @@ -633,9 +633,9 @@ int xprt_adjust_timeout(struct rpc_rqst *req)
> 		req->rq_retries =3D 0;
> 		xprt_reset_majortimeo(req);
> 		/* Reset the RTT counters =3D=3D "slow start" */
> -		spin_lock_bh(&xprt->transport_lock);
> +		spin_lock(&xprt->transport_lock);
> 		rpc_init_rtt(req->rq_task->tk_client->cl_rtt, =
to->to_initval);
> -		spin_unlock_bh(&xprt->transport_lock);
> +		spin_unlock(&xprt->transport_lock);
> 		status =3D -ETIMEDOUT;
> 	}
>=20
> @@ -667,11 +667,11 @@ static void xprt_autoclose(struct work_struct =
*work)
> void xprt_disconnect_done(struct rpc_xprt *xprt)
> {
> 	dprintk("RPC:       disconnected transport %p\n", xprt);
> -	spin_lock_bh(&xprt->transport_lock);
> +	spin_lock(&xprt->transport_lock);
> 	xprt_clear_connected(xprt);
> 	xprt_clear_write_space_locked(xprt);
> 	xprt_wake_pending_tasks(xprt, -ENOTCONN);
> -	spin_unlock_bh(&xprt->transport_lock);
> +	spin_unlock(&xprt->transport_lock);
> }
> EXPORT_SYMBOL_GPL(xprt_disconnect_done);
>=20
> @@ -683,7 +683,7 @@ EXPORT_SYMBOL_GPL(xprt_disconnect_done);
> void xprt_force_disconnect(struct rpc_xprt *xprt)
> {
> 	/* Don't race with the test_bit() in xprt_clear_locked() */
> -	spin_lock_bh(&xprt->transport_lock);
> +	spin_lock(&xprt->transport_lock);
> 	set_bit(XPRT_CLOSE_WAIT, &xprt->state);
> 	/* Try to schedule an autoclose RPC call */
> 	if (test_and_set_bit(XPRT_LOCKED, &xprt->state) =3D=3D 0)
> @@ -691,7 +691,7 @@ void xprt_force_disconnect(struct rpc_xprt *xprt)
> 	else if (xprt->snd_task)
> 		rpc_wake_up_queued_task_set_status(&xprt->pending,
> 				xprt->snd_task, -ENOTCONN);
> -	spin_unlock_bh(&xprt->transport_lock);
> +	spin_unlock(&xprt->transport_lock);
> }
> EXPORT_SYMBOL_GPL(xprt_force_disconnect);
>=20
> @@ -725,7 +725,7 @@ xprt_request_retransmit_after_disconnect(struct =
rpc_task *task)
> void xprt_conditional_disconnect(struct rpc_xprt *xprt, unsigned int =
cookie)
> {
> 	/* Don't race with the test_bit() in xprt_clear_locked() */
> -	spin_lock_bh(&xprt->transport_lock);
> +	spin_lock(&xprt->transport_lock);
> 	if (cookie !=3D xprt->connect_cookie)
> 		goto out;
> 	if (test_bit(XPRT_CLOSING, &xprt->state))
> @@ -736,7 +736,7 @@ void xprt_conditional_disconnect(struct rpc_xprt =
*xprt, unsigned int cookie)
> 		queue_work(xprtiod_workqueue, &xprt->task_cleanup);
> 	xprt_wake_pending_tasks(xprt, -EAGAIN);
> out:
> -	spin_unlock_bh(&xprt->transport_lock);
> +	spin_unlock(&xprt->transport_lock);
> }
>=20
> static bool
> @@ -758,18 +758,13 @@ xprt_init_autodisconnect(struct timer_list *t)
> {
> 	struct rpc_xprt *xprt =3D from_timer(xprt, t, timer);
>=20
> -	spin_lock(&xprt->transport_lock);
> 	if (!RB_EMPTY_ROOT(&xprt->recv_queue))
> -		goto out_abort;
> +		return;
> 	/* Reset xprt->last_used to avoid connect/autodisconnect cycling =
*/
> 	xprt->last_used =3D jiffies;
> 	if (test_and_set_bit(XPRT_LOCKED, &xprt->state))
> -		goto out_abort;
> -	spin_unlock(&xprt->transport_lock);
> +		return;
> 	queue_work(xprtiod_workqueue, &xprt->task_cleanup);
> -	return;
> -out_abort:
> -	spin_unlock(&xprt->transport_lock);
> }
>=20
> bool xprt_lock_connect(struct rpc_xprt *xprt,
> @@ -778,7 +773,7 @@ bool xprt_lock_connect(struct rpc_xprt *xprt,
> {
> 	bool ret =3D false;
>=20
> -	spin_lock_bh(&xprt->transport_lock);
> +	spin_lock(&xprt->transport_lock);
> 	if (!test_bit(XPRT_LOCKED, &xprt->state))
> 		goto out;
> 	if (xprt->snd_task !=3D task)
> @@ -786,13 +781,13 @@ bool xprt_lock_connect(struct rpc_xprt *xprt,
> 	xprt->snd_task =3D cookie;
> 	ret =3D true;
> out:
> -	spin_unlock_bh(&xprt->transport_lock);
> +	spin_unlock(&xprt->transport_lock);
> 	return ret;
> }
>=20
> void xprt_unlock_connect(struct rpc_xprt *xprt, void *cookie)
> {
> -	spin_lock_bh(&xprt->transport_lock);
> +	spin_lock(&xprt->transport_lock);
> 	if (xprt->snd_task !=3D cookie)
> 		goto out;
> 	if (!test_bit(XPRT_LOCKED, &xprt->state))
> @@ -801,7 +796,7 @@ void xprt_unlock_connect(struct rpc_xprt *xprt, =
void *cookie)
> 	xprt->ops->release_xprt(xprt, NULL);
> 	xprt_schedule_autodisconnect(xprt);
> out:
> -	spin_unlock_bh(&xprt->transport_lock);
> +	spin_unlock(&xprt->transport_lock);
> 	wake_up_bit(&xprt->state, XPRT_LOCKED);
> }
>=20
> @@ -1411,14 +1406,14 @@ xprt_request_transmit(struct rpc_rqst *req, =
struct rpc_task *snd_task)
> 	xprt_inject_disconnect(xprt);
>=20
> 	task->tk_flags |=3D RPC_TASK_SENT;
> -	spin_lock_bh(&xprt->transport_lock);
> +	spin_lock(&xprt->transport_lock);
>=20
> 	xprt->stat.sends++;
> 	xprt->stat.req_u +=3D xprt->stat.sends - xprt->stat.recvs;
> 	xprt->stat.bklog_u +=3D xprt->backlog.qlen;
> 	xprt->stat.sending_u +=3D xprt->sending.qlen;
> 	xprt->stat.pending_u +=3D xprt->pending.qlen;
> -	spin_unlock_bh(&xprt->transport_lock);
> +	spin_unlock(&xprt->transport_lock);
>=20
> 	req->rq_connect_cookie =3D connect_cookie;
> out_dequeue:
> @@ -1769,13 +1764,13 @@ void xprt_release(struct rpc_task *task)
> 	else if (task->tk_client)
> 		rpc_count_iostats(task, task->tk_client->cl_metrics);
> 	xprt_request_dequeue_all(task, req);
> -	spin_lock_bh(&xprt->transport_lock);
> +	spin_lock(&xprt->transport_lock);
> 	xprt->ops->release_xprt(xprt, task);
> 	if (xprt->ops->release_request)
> 		xprt->ops->release_request(task);
> 	xprt->last_used =3D jiffies;
> 	xprt_schedule_autodisconnect(xprt);
> -	spin_unlock_bh(&xprt->transport_lock);
> +	spin_unlock(&xprt->transport_lock);
> 	if (req->rq_buffer)
> 		xprt->ops->buf_free(task);
> 	xprt_inject_disconnect(xprt);
> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c =
b/net/sunrpc/xprtrdma/rpc_rdma.c
> index 6c1fb270f127..26419be782d0 100644
> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
> @@ -1359,10 +1359,10 @@ void rpcrdma_reply_handler(struct rpcrdma_rep =
*rep)
> 	else if (credits > buf->rb_max_requests)
> 		credits =3D buf->rb_max_requests;
> 	if (buf->rb_credits !=3D credits) {
> -		spin_lock_bh(&xprt->transport_lock);
> +		spin_lock(&xprt->transport_lock);
> 		buf->rb_credits =3D credits;
> 		xprt->cwnd =3D credits << RPC_CWNDSHIFT;
> -		spin_unlock_bh(&xprt->transport_lock);
> +		spin_unlock(&xprt->transport_lock);
> 	}
>=20
> 	req =3D rpcr_to_rdmar(rqst);
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c =
b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> index bed57d8b5c19..d1fcc41d5eb5 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> @@ -72,9 +72,9 @@ int svc_rdma_handle_bc_reply(struct rpc_xprt *xprt, =
__be32 *rdma_resp,
> 	else if (credits > r_xprt->rx_buf.rb_bc_max_requests)
> 		credits =3D r_xprt->rx_buf.rb_bc_max_requests;
>=20
> -	spin_lock_bh(&xprt->transport_lock);
> +	spin_lock(&xprt->transport_lock);
> 	xprt->cwnd =3D credits << RPC_CWNDSHIFT;
> -	spin_unlock_bh(&xprt->transport_lock);
> +	spin_unlock(&xprt->transport_lock);
>=20
> 	spin_lock(&xprt->queue_lock);
> 	ret =3D 0;
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c =
b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index 027a3b07d329..18ffc6190ea9 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -221,9 +221,9 @@ static void handle_connect_req(struct rdma_cm_id =
*new_cma_id,
> 	 * Enqueue the new transport on the accept queue of the =
listening
> 	 * transport
> 	 */
> -	spin_lock_bh(&listen_xprt->sc_lock);
> +	spin_lock(&listen_xprt->sc_lock);
> 	list_add_tail(&newxprt->sc_accept_q, &listen_xprt->sc_accept_q);
> -	spin_unlock_bh(&listen_xprt->sc_lock);
> +	spin_unlock(&listen_xprt->sc_lock);
>=20
> 	set_bit(XPT_CONN, &listen_xprt->sc_xprt.xpt_flags);
> 	svc_xprt_enqueue(&listen_xprt->sc_xprt);
> @@ -396,7 +396,7 @@ static struct svc_xprt *svc_rdma_accept(struct =
svc_xprt *xprt)
> 	listen_rdma =3D container_of(xprt, struct svcxprt_rdma, =
sc_xprt);
> 	clear_bit(XPT_CONN, &xprt->xpt_flags);
> 	/* Get the next entry off the accept list */
> -	spin_lock_bh(&listen_rdma->sc_lock);
> +	spin_lock(&listen_rdma->sc_lock);
> 	if (!list_empty(&listen_rdma->sc_accept_q)) {
> 		newxprt =3D list_entry(listen_rdma->sc_accept_q.next,
> 				     struct svcxprt_rdma, sc_accept_q);
> @@ -404,7 +404,7 @@ static struct svc_xprt *svc_rdma_accept(struct =
svc_xprt *xprt)
> 	}
> 	if (!list_empty(&listen_rdma->sc_accept_q))
> 		set_bit(XPT_CONN, &listen_rdma->sc_xprt.xpt_flags);
> -	spin_unlock_bh(&listen_rdma->sc_lock);
> +	spin_unlock(&listen_rdma->sc_lock);
> 	if (!newxprt)
> 		return NULL;
>=20
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index e0195b1a0c18..d7b8e95a61c8 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -880,7 +880,7 @@ static int xs_nospace(struct rpc_rqst *req)
> 			req->rq_slen);
>=20
> 	/* Protect against races with write_space */
> -	spin_lock_bh(&xprt->transport_lock);
> +	spin_lock(&xprt->transport_lock);
>=20
> 	/* Don't race with disconnect */
> 	if (xprt_connected(xprt)) {
> @@ -890,7 +890,7 @@ static int xs_nospace(struct rpc_rqst *req)
> 	} else
> 		ret =3D -ENOTCONN;
>=20
> -	spin_unlock_bh(&xprt->transport_lock);
> +	spin_unlock(&xprt->transport_lock);
>=20
> 	/* Race breaker in case memory is freed before above code is =
called */
> 	if (ret =3D=3D -EAGAIN) {
> @@ -1344,6 +1344,7 @@ static void xs_destroy(struct rpc_xprt *xprt)
> 	cancel_delayed_work_sync(&transport->connect_worker);
> 	xs_close(xprt);
> 	cancel_work_sync(&transport->recv_worker);
> +	cancel_work_sync(&transport->error_worker);
> 	xs_xprt_free(xprt);
> 	module_put(THIS_MODULE);
> }
> @@ -1397,9 +1398,9 @@ static void xs_udp_data_read_skb(struct rpc_xprt =
*xprt,
> 	}
>=20
>=20
> -	spin_lock_bh(&xprt->transport_lock);
> +	spin_lock(&xprt->transport_lock);
> 	xprt_adjust_cwnd(xprt, task, copied);
> -	spin_unlock_bh(&xprt->transport_lock);
> +	spin_unlock(&xprt->transport_lock);
> 	spin_lock(&xprt->queue_lock);
> 	xprt_complete_rqst(task, copied);
> 	__UDPX_INC_STATS(sk, UDP_MIB_INDATAGRAMS);
> @@ -1509,7 +1510,6 @@ static void xs_tcp_state_change(struct sock *sk)
> 	trace_rpc_socket_state_change(xprt, sk->sk_socket);
> 	switch (sk->sk_state) {
> 	case TCP_ESTABLISHED:
> -		spin_lock(&xprt->transport_lock);
> 		if (!xprt_test_and_set_connected(xprt)) {
> 			xprt->connect_cookie++;
> 			clear_bit(XPRT_SOCK_CONNECTING, =
&transport->sock_state);
> @@ -1520,7 +1520,6 @@ static void xs_tcp_state_change(struct sock *sk)
> 						   =
xprt->stat.connect_start;
> 			xs_run_error_worker(transport, =
XPRT_SOCK_WAKE_PENDING);
> 		}
> -		spin_unlock(&xprt->transport_lock);
> 		break;
> 	case TCP_FIN_WAIT1:
> 		/* The client initiated a shutdown of the socket */
> @@ -1677,9 +1676,9 @@ static void xs_udp_set_buffer_size(struct =
rpc_xprt *xprt, size_t sndsize, size_t
>  */
> static void xs_udp_timer(struct rpc_xprt *xprt, struct rpc_task *task)
> {
> -	spin_lock_bh(&xprt->transport_lock);
> +	spin_lock(&xprt->transport_lock);
> 	xprt_adjust_cwnd(xprt, task, -ETIMEDOUT);
> -	spin_unlock_bh(&xprt->transport_lock);
> +	spin_unlock(&xprt->transport_lock);
> }
>=20
> static int xs_get_random_port(void)
> @@ -2214,13 +2213,13 @@ static void xs_tcp_set_socket_timeouts(struct =
rpc_xprt *xprt,
> 	unsigned int opt_on =3D 1;
> 	unsigned int timeo;
>=20
> -	spin_lock_bh(&xprt->transport_lock);
> +	spin_lock(&xprt->transport_lock);
> 	keepidle =3D DIV_ROUND_UP(xprt->timeout->to_initval, HZ);
> 	keepcnt =3D xprt->timeout->to_retries + 1;
> 	timeo =3D jiffies_to_msecs(xprt->timeout->to_initval) *
> 		(xprt->timeout->to_retries + 1);
> 	clear_bit(XPRT_SOCK_UPD_TIMEOUT, &transport->sock_state);
> -	spin_unlock_bh(&xprt->transport_lock);
> +	spin_unlock(&xprt->transport_lock);
>=20
> 	/* TCP Keepalive options */
> 	kernel_setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
> @@ -2245,7 +2244,7 @@ static void xs_tcp_set_connect_timeout(struct =
rpc_xprt *xprt,
> 	struct rpc_timeout to;
> 	unsigned long initval;
>=20
> -	spin_lock_bh(&xprt->transport_lock);
> +	spin_lock(&xprt->transport_lock);
> 	if (reconnect_timeout < xprt->max_reconnect_timeout)
> 		xprt->max_reconnect_timeout =3D reconnect_timeout;
> 	if (connect_timeout < xprt->connect_timeout) {
> @@ -2262,7 +2261,7 @@ static void xs_tcp_set_connect_timeout(struct =
rpc_xprt *xprt,
> 		xprt->connect_timeout =3D connect_timeout;
> 	}
> 	set_bit(XPRT_SOCK_UPD_TIMEOUT, &transport->sock_state);
> -	spin_unlock_bh(&xprt->transport_lock);
> +	spin_unlock(&xprt->transport_lock);
> }
>=20
> static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct =
socket *sock)
> --=20
> 2.21.0
>=20

--
Chuck Lever



