Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F374917C
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2019 22:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfFQUhG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jun 2019 16:37:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45460 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfFQUhG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jun 2019 16:37:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HKStXq174690;
        Mon, 17 Jun 2019 20:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=dZUvNlu7AsHbzKsj3DdWY258BEMF72wGHjGybE09EuY=;
 b=XlLGyMe0zNhmSMJMqSPNZeBkJfJUlM5SW7CnIW2i2MkSImDhqui52VU01OPREhLT9bPB
 eByjnuQN4NnJv42SsQOmkdolvdapgq8Kdm9m93lxviBIwIZ7NR+cqyW8VPrqTBOlTVvl
 5Zg5DYiKljcWkw0d9Q0R/INHBOPfiR7RlAO9tDVD9WF/MHfF9g9pDbhxUwM2uVfp/KIS
 A6cUJlIchsbRqT1EKxhDDMRIjHJlqYmzgqREKfGoPaSXoUxCBaSXQ9yaZwV8PKPHDFre
 YZxcbRU5gUwLhT5PDmYM/z0v8QANoJ0IdMBS/vbKbAUs/5/YQTwikC06VyYzLrHT8oNh ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2t4rmp0ktn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 20:37:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HKZ5DH020471;
        Mon, 17 Jun 2019 20:37:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2t5h5tbnm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 20:36:59 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HKawXA010320;
        Mon, 17 Jun 2019 20:36:58 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Jun 2019 13:36:58 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3 06/19] xprtrdma: Remove fr_state
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190617153201.12090.18184.stgit@manet.1015granger.net>
Date:   Mon, 17 Jun 2019 16:36:56 -0400
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <89D793C7-8CA7-4F1A-9772-F87F9548CB1E@oracle.com>
References: <20190617152657.12090.11389.stgit@manet.1015granger.net>
 <20190617153201.12090.18184.stgit@manet.1015granger.net>
To:     Anna Schumaker <anna.schumaker@netapp.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170179
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170179
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 17, 2019, at 11:32 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> Now that both the Send and Receive completions are handled in
> process context, it is safe to DMA unmap and return MRs to the
> free or recycle lists directly in the completion handlers.
>=20
> Doing this means rpcrdma_frwr no longer needs to track the state of
> each MR, meaning that a VALID or FLUSHED MR can no longer appear on
> an xprt's MR free list. Thus there is no longer a need to track the
> MR's registration state in rpcrdma_frwr.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> include/trace/events/rpcrdma.h  |   19 ----
> net/sunrpc/xprtrdma/frwr_ops.c  |  204 =
++++++++++++++++++---------------------
> net/sunrpc/xprtrdma/rpc_rdma.c  |    2=20
> net/sunrpc/xprtrdma/xprt_rdma.h |   11 --
> 4 files changed, 96 insertions(+), 140 deletions(-)
>=20
> diff --git a/include/trace/events/rpcrdma.h =
b/include/trace/events/rpcrdma.h
> index 2fb4151..1d25470 100644
> --- a/include/trace/events/rpcrdma.h
> +++ b/include/trace/events/rpcrdma.h
> @@ -181,18 +181,6 @@
> 				),					=
\
> 				TP_ARGS(task, mr, nsegs))
>=20
> -TRACE_DEFINE_ENUM(FRWR_IS_INVALID);
> -TRACE_DEFINE_ENUM(FRWR_IS_VALID);
> -TRACE_DEFINE_ENUM(FRWR_FLUSHED_FR);
> -TRACE_DEFINE_ENUM(FRWR_FLUSHED_LI);
> -
> -#define xprtrdma_show_frwr_state(x)					=
\
> -		__print_symbolic(x,					=
\
> -				{ FRWR_IS_INVALID, "INVALID" },		=
\
> -				{ FRWR_IS_VALID, "VALID" },		=
\
> -				{ FRWR_FLUSHED_FR, "FLUSHED_FR" },	=
\
> -				{ FRWR_FLUSHED_LI, "FLUSHED_LI" })
> -
> DECLARE_EVENT_CLASS(xprtrdma_frwr_done,
> 	TP_PROTO(
> 		const struct ib_wc *wc,
> @@ -203,22 +191,19 @@
>=20
> 	TP_STRUCT__entry(
> 		__field(const void *, mr)
> -		__field(unsigned int, state)
> 		__field(unsigned int, status)
> 		__field(unsigned int, vendor_err)
> 	),
>=20
> 	TP_fast_assign(
> 		__entry->mr =3D container_of(frwr, struct rpcrdma_mr, =
frwr);
> -		__entry->state =3D frwr->fr_state;
> 		__entry->status =3D wc->status;
> 		__entry->vendor_err =3D __entry->status ? wc->vendor_err =
: 0;
> 	),
>=20
> 	TP_printk(
> -		"mr=3D%p state=3D%s: %s (%u/0x%x)",
> -		__entry->mr, xprtrdma_show_frwr_state(__entry->state),
> -		rdma_show_wc_status(__entry->status),
> +		"mr=3D%p: %s (%u/0x%x)",
> +		__entry->mr, rdma_show_wc_status(__entry->status),
> 		__entry->status, __entry->vendor_err
> 	)
> );
> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c =
b/net/sunrpc/xprtrdma/frwr_ops.c
> index ac47314..dae2caa 100644
> --- a/net/sunrpc/xprtrdma/frwr_ops.c
> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
> @@ -168,7 +168,6 @@ int frwr_init_mr(struct rpcrdma_ia *ia, struct =
rpcrdma_mr *mr)
> 		goto out_list_err;
>=20
> 	mr->frwr.fr_mr =3D frmr;
> -	mr->frwr.fr_state =3D FRWR_IS_INVALID;
> 	mr->mr_dir =3D DMA_NONE;
> 	INIT_LIST_HEAD(&mr->mr_list);
> 	INIT_WORK(&mr->mr_recycle, frwr_mr_recycle_worker);
> @@ -298,65 +297,6 @@ size_t frwr_maxpages(struct rpcrdma_xprt *r_xprt)
> }
>=20
> /**
> - * frwr_wc_fastreg - Invoked by RDMA provider for a flushed FastReg =
WC
> - * @cq:	completion queue (ignored)
> - * @wc:	completed WR
> - *
> - */
> -static void
> -frwr_wc_fastreg(struct ib_cq *cq, struct ib_wc *wc)
> -{
> -	struct ib_cqe *cqe =3D wc->wr_cqe;
> -	struct rpcrdma_frwr *frwr =3D
> -			container_of(cqe, struct rpcrdma_frwr, fr_cqe);
> -
> -	/* WARNING: Only wr_cqe and status are reliable at this point */
> -	if (wc->status !=3D IB_WC_SUCCESS)
> -		frwr->fr_state =3D FRWR_FLUSHED_FR;
> -	trace_xprtrdma_wc_fastreg(wc, frwr);
> -}
> -
> -/**
> - * frwr_wc_localinv - Invoked by RDMA provider for a flushed LocalInv =
WC
> - * @cq:	completion queue (ignored)
> - * @wc:	completed WR
> - *
> - */
> -static void
> -frwr_wc_localinv(struct ib_cq *cq, struct ib_wc *wc)
> -{
> -	struct ib_cqe *cqe =3D wc->wr_cqe;
> -	struct rpcrdma_frwr *frwr =3D container_of(cqe, struct =
rpcrdma_frwr,
> -						 fr_cqe);
> -
> -	/* WARNING: Only wr_cqe and status are reliable at this point */
> -	if (wc->status !=3D IB_WC_SUCCESS)
> -		frwr->fr_state =3D FRWR_FLUSHED_LI;
> -	trace_xprtrdma_wc_li(wc, frwr);
> -}
> -
> -/**
> - * frwr_wc_localinv_wake - Invoked by RDMA provider for a signaled =
LocalInv WC
> - * @cq:	completion queue (ignored)
> - * @wc:	completed WR
> - *
> - * Awaken anyone waiting for an MR to finish being fenced.
> - */
> -static void
> -frwr_wc_localinv_wake(struct ib_cq *cq, struct ib_wc *wc)
> -{
> -	struct ib_cqe *cqe =3D wc->wr_cqe;
> -	struct rpcrdma_frwr *frwr =3D container_of(cqe, struct =
rpcrdma_frwr,
> -						 fr_cqe);
> -
> -	/* WARNING: Only wr_cqe and status are reliable at this point */
> -	if (wc->status !=3D IB_WC_SUCCESS)
> -		frwr->fr_state =3D FRWR_FLUSHED_LI;
> -	trace_xprtrdma_wc_li_wake(wc, frwr);
> -	complete(&frwr->fr_linv_done);
> -}
> -
> -/**
>  * frwr_map - Register a memory region
>  * @r_xprt: controlling transport
>  * @seg: memory region co-ordinates
> @@ -378,23 +318,15 @@ struct rpcrdma_mr_seg *frwr_map(struct =
rpcrdma_xprt *r_xprt,
> {
> 	struct rpcrdma_ia *ia =3D &r_xprt->rx_ia;
> 	bool holes_ok =3D ia->ri_mrtype =3D=3D IB_MR_TYPE_SG_GAPS;
> -	struct rpcrdma_frwr *frwr;
> 	struct rpcrdma_mr *mr;
> 	struct ib_mr *ibmr;
> 	struct ib_reg_wr *reg_wr;
> 	int i, n;
> 	u8 key;
>=20
> -	mr =3D NULL;
> -	do {
> -		if (mr)
> -			rpcrdma_mr_recycle(mr);
> -		mr =3D rpcrdma_mr_get(r_xprt);
> -		if (!mr)
> -			goto out_getmr_err;
> -	} while (mr->frwr.fr_state !=3D FRWR_IS_INVALID);
> -	frwr =3D &mr->frwr;
> -	frwr->fr_state =3D FRWR_IS_VALID;
> +	mr =3D rpcrdma_mr_get(r_xprt);
> +	if (!mr)
> +		goto out_getmr_err;
>=20
> 	if (nsegs > ia->ri_max_frwr_depth)
> 		nsegs =3D ia->ri_max_frwr_depth;
> @@ -423,7 +355,7 @@ struct rpcrdma_mr_seg *frwr_map(struct =
rpcrdma_xprt *r_xprt,
> 	if (!mr->mr_nents)
> 		goto out_dmamap_err;
>=20
> -	ibmr =3D frwr->fr_mr;
> +	ibmr =3D mr->frwr.fr_mr;
> 	n =3D ib_map_mr_sg(ibmr, mr->mr_sg, mr->mr_nents, NULL, =
PAGE_SIZE);
> 	if (unlikely(n !=3D mr->mr_nents))
> 		goto out_mapmr_err;
> @@ -433,7 +365,7 @@ struct rpcrdma_mr_seg *frwr_map(struct =
rpcrdma_xprt *r_xprt,
> 	key =3D (u8)(ibmr->rkey & 0x000000FF);
> 	ib_update_fast_reg_key(ibmr, ++key);
>=20
> -	reg_wr =3D &frwr->fr_regwr;
> +	reg_wr =3D &mr->frwr.fr_regwr;
> 	reg_wr->mr =3D ibmr;
> 	reg_wr->key =3D ibmr->rkey;
> 	reg_wr->access =3D writing ?
> @@ -465,6 +397,23 @@ struct rpcrdma_mr_seg *frwr_map(struct =
rpcrdma_xprt *r_xprt,
> }
>=20
> /**
> + * frwr_wc_fastreg - Invoked by RDMA provider for a flushed FastReg =
WC
> + * @cq:	completion queue (ignored)
> + * @wc:	completed WR
> + *
> + */
> +static void frwr_wc_fastreg(struct ib_cq *cq, struct ib_wc *wc)
> +{
> +	struct ib_cqe *cqe =3D wc->wr_cqe;
> +	struct rpcrdma_frwr *frwr =3D
> +		container_of(cqe, struct rpcrdma_frwr, fr_cqe);
> +
> +	/* WARNING: Only wr_cqe and status are reliable at this point */
> +	trace_xprtrdma_wc_fastreg(wc, frwr);
> +	/* The MR will get recycled when the associated req is =
retransmitted */
> +}
> +
> +/**
>  * frwr_send - post Send WR containing the RPC Call message
>  * @ia: interface adapter
>  * @req: Prepared RPC Call
> @@ -516,31 +465,72 @@ void frwr_reminv(struct rpcrdma_rep *rep, struct =
list_head *mrs)
> 		if (mr->mr_handle =3D=3D rep->rr_inv_rkey) {
> 			list_del_init(&mr->mr_list);
> 			trace_xprtrdma_mr_remoteinv(mr);
> -			mr->frwr.fr_state =3D FRWR_IS_INVALID;
> 			rpcrdma_mr_unmap_and_put(mr);
> 			break;	/* only one invalidated MR per RPC */
> 		}
> }
>=20
> +static void __frwr_release_mr(struct ib_wc *wc, struct rpcrdma_mr =
*mr)
> +{
> +	if (wc->status !=3D IB_WC_SUCCESS)
> +		rpcrdma_mr_recycle(mr);
> +	else
> +		rpcrdma_mr_unmap_and_put(mr);
> +}
> +
> /**
> - * frwr_unmap_sync - invalidate memory regions that were registered =
for @req
> - * @r_xprt: controlling transport
> - * @mrs: list of MRs to process
> + * frwr_wc_localinv - Invoked by RDMA provider for a LOCAL_INV WC
> + * @cq:	completion queue (ignored)
> + * @wc:	completed WR
>  *
> - * Sleeps until it is safe for the host CPU to access the
> - * previously mapped memory regions.
> + */
> +static void frwr_wc_localinv(struct ib_cq *cq, struct ib_wc *wc)
> +{
> +	struct ib_cqe *cqe =3D wc->wr_cqe;
> +	struct rpcrdma_frwr *frwr =3D
> +		container_of(cqe, struct rpcrdma_frwr, fr_cqe);
> +	struct rpcrdma_mr *mr =3D container_of(frwr, struct rpcrdma_mr, =
frwr);
> +
> +	/* WARNING: Only wr_cqe and status are reliable at this point */
> +	__frwr_release_mr(wc, mr);
> +	trace_xprtrdma_wc_li(wc, frwr);

I think this is a use-after-free.


> +}
> +
> +/**
> + * frwr_wc_localinv_wake - Invoked by RDMA provider for a LOCAL_INV =
WC
> + * @cq:	completion queue (ignored)
> + * @wc:	completed WR
>  *
> - * Caller ensures that @mrs is not empty before the call. This
> - * function empties the list.
> + * Awaken anyone waiting for an MR to finish being fenced.
>  */
> -void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct list_head =
*mrs)
> +static void frwr_wc_localinv_wake(struct ib_cq *cq, struct ib_wc *wc)
> +{
> +	struct ib_cqe *cqe =3D wc->wr_cqe;
> +	struct rpcrdma_frwr *frwr =3D
> +		container_of(cqe, struct rpcrdma_frwr, fr_cqe);
> +	struct rpcrdma_mr *mr =3D container_of(frwr, struct rpcrdma_mr, =
frwr);
> +
> +	/* WARNING: Only wr_cqe and status are reliable at this point */
> +	__frwr_release_mr(wc, mr);
> +	trace_xprtrdma_wc_li_wake(wc, frwr);
> +	complete(&frwr->fr_linv_done);

Likewise. Anna, I can send a patch that fixes the UAF, or I can send
you a new version of this patch.


> +}
> +
> +/**
> + * frwr_unmap_sync - invalidate memory regions that were registered =
for @req
> + * @r_xprt: controlling transport instance
> + * @req: rpcrdma_req with a non-empty list of MRs to process
> + *
> + * Sleeps until it is safe for the host CPU to access the previously =
mapped
> + * memory regions.
> + */
> +void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req =
*req)
> {
> 	struct ib_send_wr *first, **prev, *last;
> 	const struct ib_send_wr *bad_wr;
> -	struct rpcrdma_ia *ia =3D &r_xprt->rx_ia;
> 	struct rpcrdma_frwr *frwr;
> 	struct rpcrdma_mr *mr;
> -	int count, rc;
> +	int rc;
>=20
> 	/* ORDER: Invalidate all of the MRs first
> 	 *
> @@ -548,33 +538,32 @@ void frwr_unmap_sync(struct rpcrdma_xprt =
*r_xprt, struct list_head *mrs)
> 	 * a single ib_post_send() call.
> 	 */
> 	frwr =3D NULL;
> -	count =3D 0;
> 	prev =3D &first;
> -	list_for_each_entry(mr, mrs, mr_list) {
> -		mr->frwr.fr_state =3D FRWR_IS_INVALID;
> +	while (!list_empty(&req->rl_registered)) {
> +		mr =3D rpcrdma_mr_pop(&req->rl_registered);
>=20
> -		frwr =3D &mr->frwr;
> 		trace_xprtrdma_mr_localinv(mr);
> +		r_xprt->rx_stats.local_inv_needed++;
>=20
> +		frwr =3D &mr->frwr;
> 		frwr->fr_cqe.done =3D frwr_wc_localinv;
> 		last =3D &frwr->fr_invwr;
> -		memset(last, 0, sizeof(*last));
> +		last->next =3D NULL;
> 		last->wr_cqe =3D &frwr->fr_cqe;
> +		last->sg_list =3D NULL;
> +		last->num_sge =3D 0;
> 		last->opcode =3D IB_WR_LOCAL_INV;
> +		last->send_flags =3D IB_SEND_SIGNALED;
> 		last->ex.invalidate_rkey =3D mr->mr_handle;
> -		count++;
>=20
> 		*prev =3D last;
> 		prev =3D &last->next;
> 	}
> -	if (!frwr)
> -		goto unmap;
>=20
> 	/* Strong send queue ordering guarantees that when the
> 	 * last WR in the chain completes, all WRs in the chain
> 	 * are complete.
> 	 */
> -	last->send_flags =3D IB_SEND_SIGNALED;
> 	frwr->fr_cqe.done =3D frwr_wc_localinv_wake;
> 	reinit_completion(&frwr->fr_linv_done);
>=20
> @@ -582,29 +571,20 @@ void frwr_unmap_sync(struct rpcrdma_xprt =
*r_xprt, struct list_head *mrs)
> 	 * replaces the QP. The RPC reply handler won't call us
> 	 * unless ri_id->qp is a valid pointer.
> 	 */
> -	r_xprt->rx_stats.local_inv_needed++;
> 	bad_wr =3D NULL;
> -	rc =3D ib_post_send(ia->ri_id->qp, first, &bad_wr);
> -	if (bad_wr !=3D first)
> -		wait_for_completion(&frwr->fr_linv_done);
> -	if (rc)
> -		goto out_release;
> +	rc =3D ib_post_send(r_xprt->rx_ia.ri_id->qp, first, &bad_wr);
> +	trace_xprtrdma_post_send(req, rc);
>=20
> -	/* ORDER: Now DMA unmap all of the MRs, and return
> -	 * them to the free MR list.
> +	/* The final LOCAL_INV WR in the chain is supposed to
> +	 * do the wake. If it was never posted, the wake will
> +	 * not happen, so don't wait in that case.
> 	 */
> -unmap:
> -	while (!list_empty(mrs)) {
> -		mr =3D rpcrdma_mr_pop(mrs);
> -		rpcrdma_mr_unmap_and_put(mr);
> -	}
> -	return;
> -
> -out_release:
> -	pr_err("rpcrdma: FRWR invalidate ib_post_send returned %i\n", =
rc);
> +	if (bad_wr !=3D first)
> +		wait_for_completion(&frwr->fr_linv_done);
> +	if (!rc)
> +		return;
>=20
> -	/* Unmap and release the MRs in the LOCAL_INV WRs that did not
> -	 * get posted.
> +	/* Recycle MRs in the LOCAL_INV chain that did not get posted.
> 	 */
> 	while (bad_wr) {
> 		frwr =3D container_of(bad_wr, struct rpcrdma_frwr,
> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c =
b/net/sunrpc/xprtrdma/rpc_rdma.c
> index fbc0a9f..f23450b 100644
> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
> @@ -1277,7 +1277,7 @@ void rpcrdma_release_rqst(struct rpcrdma_xprt =
*r_xprt, struct rpcrdma_req *req)
> 	 * RPC has relinquished all its Send Queue entries.
> 	 */
> 	if (!list_empty(&req->rl_registered))
> -		frwr_unmap_sync(r_xprt, &req->rl_registered);
> +		frwr_unmap_sync(r_xprt, req);
>=20
> 	/* Ensure that any DMA mapped pages associated with
> 	 * the Send of the RPC Call have been unmapped before
> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h =
b/net/sunrpc/xprtrdma/xprt_rdma.h
> index 3c39aa3..a9de116 100644
> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> @@ -240,17 +240,9 @@ struct rpcrdma_sendctx {
>  * An external memory region is any buffer or page that is registered
>  * on the fly (ie, not pre-registered).
>  */
> -enum rpcrdma_frwr_state {
> -	FRWR_IS_INVALID,	/* ready to be used */
> -	FRWR_IS_VALID,		/* in use */
> -	FRWR_FLUSHED_FR,	/* flushed FASTREG WR */
> -	FRWR_FLUSHED_LI,	/* flushed LOCALINV WR */
> -};
> -
> struct rpcrdma_frwr {
> 	struct ib_mr			*fr_mr;
> 	struct ib_cqe			fr_cqe;
> -	enum rpcrdma_frwr_state		fr_state;
> 	struct completion		fr_linv_done;
> 	union {
> 		struct ib_reg_wr	fr_regwr;
> @@ -567,8 +559,7 @@ struct rpcrdma_mr_seg *frwr_map(struct =
rpcrdma_xprt *r_xprt,
> 				struct rpcrdma_mr **mr);
> int frwr_send(struct rpcrdma_ia *ia, struct rpcrdma_req *req);
> void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs);
> -void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt,
> -		     struct list_head *mrs);
> +void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req =
*req);
>=20
> /*
>  * RPC/RDMA protocol calls - xprtrdma/rpc_rdma.c
>=20

--
Chuck Lever



