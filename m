Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 816306BDB4
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2019 15:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfGQNzO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jul 2019 09:55:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55764 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfGQNzO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Jul 2019 09:55:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HDn6Jw045451;
        Wed, 17 Jul 2019 13:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=cThDjhYGvn4YhsqOqg/3p7wMMxqv+7C11vSdtn3eScQ=;
 b=PFpyviXY3yUD8WSrP5JX9MMdrdgQt60TOwYJKNAR+DFUJ9/jq6rW834FnhIf8YXqnIAT
 nrmlZ7NDB0PS1RK8JyUlMwc1alDZhC2aowk79A96ZwdubwrEPX7Y0N6Q+LXuyOKSRJ9D
 o61+el5FxV0WBaDRUuQzNAg0HCBfVTondCrH2dnYZZFSfQDqvrXTDsQnRgrf0xysLmtk
 vlirhZDTxIVBToAME4CGaHlO3dRFOteJPclBGAUVtxiRs5pORnQbS2Czz322ZgIcWteb
 /e0Qqn+RP/0A2JLhjpQsyXq7hbcnD92hjKQehgt04IiFuZrblVKnThiGh7Tbw2axeuq9 cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2tq7xr2u90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 13:55:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HDlxI3057530;
        Wed, 17 Jul 2019 13:55:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2tq4duhgbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 13:55:10 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6HDt9ri008173;
        Wed, 17 Jul 2019 13:55:09 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 13:55:09 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] SUNRPC: Fix up backchannel slot table accounting
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190716200157.38583-1-trond.myklebust@hammerspace.com>
Date:   Wed, 17 Jul 2019 09:55:04 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <99A569FB-DD7F-4547-AB06-FEB5DABA8488@oracle.com>
References: <20190716200157.38583-1-trond.myklebust@hammerspace.com>
To:     Trond Myklebust <trondmy@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170166
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170166
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond-

> On Jul 16, 2019, at 4:01 PM, Trond Myklebust <trondmy@gmail.com> =
wrote:
>=20
> Add a per-transport maximum limit in the socket case, and add
> helpers to allow the NFSv4 code to discover that limit.

For RDMA, the number of credits is permitted to change during the life
of the connection, so this is not a fixed limit for such transports.

And, AFAICT, it's not necessary to know the transport's limit. The
lesser of the NFS backchannel and RPC/RDMA reverse credit limit will
be used.

The patch description doesn't explain why this change is now necessary,
so I don't get what's going on here.


> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> fs/nfs/nfs4proc.c                 |  3 +++
> include/linux/sunrpc/bc_xprt.h    |  1 +
> include/linux/sunrpc/clnt.h       |  1 +
> include/linux/sunrpc/xprt.h       |  6 +++--
> net/sunrpc/backchannel_rqst.c     | 40 +++++++++++++++++--------------
> net/sunrpc/clnt.c                 | 13 ++++++++++
> net/sunrpc/svc.c                  |  2 +-
> net/sunrpc/xprtrdma/backchannel.c |  7 ++++++
> net/sunrpc/xprtrdma/transport.c   |  1 +
> net/sunrpc/xprtrdma/xprt_rdma.h   |  1 +
> net/sunrpc/xprtsock.c             |  1 +
> 11 files changed, 55 insertions(+), 21 deletions(-)
>=20
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 52de7245a2ee..39896afc6edf 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -8380,6 +8380,7 @@ static void nfs4_init_channel_attrs(struct =
nfs41_create_session_args *args,
> {
> 	unsigned int max_rqst_sz, max_resp_sz;
> 	unsigned int max_bc_payload =3D rpc_max_bc_payload(clnt);
> +	unsigned int max_bc_slots =3D rpc_num_bc_slots(clnt);
>=20
> 	max_rqst_sz =3D NFS_MAX_FILE_IO_SIZE + nfs41_maxwrite_overhead;
> 	max_resp_sz =3D NFS_MAX_FILE_IO_SIZE + nfs41_maxread_overhead;
> @@ -8402,6 +8403,8 @@ static void nfs4_init_channel_attrs(struct =
nfs41_create_session_args *args,
> 	args->bc_attrs.max_resp_sz_cached =3D 0;
> 	args->bc_attrs.max_ops =3D NFS4_MAX_BACK_CHANNEL_OPS;
> 	args->bc_attrs.max_reqs =3D max_t(unsigned short, =
max_session_cb_slots, 1);
> +	if (args->bc_attrs.max_reqs > max_bc_slots)
> +		args->bc_attrs.max_reqs =3D max_bc_slots;
>=20
> 	dprintk("%s: Back Channel : max_rqst_sz=3D%u max_resp_sz=3D%u "
> 		"max_resp_sz_cached=3D%u max_ops=3D%u max_reqs=3D%u\n",
> diff --git a/include/linux/sunrpc/bc_xprt.h =
b/include/linux/sunrpc/bc_xprt.h
> index d4229a78524a..87d27e13d885 100644
> --- a/include/linux/sunrpc/bc_xprt.h
> +++ b/include/linux/sunrpc/bc_xprt.h
> @@ -43,6 +43,7 @@ void xprt_destroy_backchannel(struct rpc_xprt *, =
unsigned int max_reqs);
> int xprt_setup_bc(struct rpc_xprt *xprt, unsigned int min_reqs);
> void xprt_destroy_bc(struct rpc_xprt *xprt, unsigned int max_reqs);
> void xprt_free_bc_rqst(struct rpc_rqst *req);
> +unsigned int xprt_bc_max_slots(struct rpc_xprt *xprt);
>=20
> /*
>  * Determine if a shared backchannel is in use
> diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
> index 4e070e00c143..abc63bd1be2b 100644
> --- a/include/linux/sunrpc/clnt.h
> +++ b/include/linux/sunrpc/clnt.h
> @@ -194,6 +194,7 @@ void		rpc_setbufsize(struct rpc_clnt =
*, unsigned int, unsigned int);
> struct net *	rpc_net_ns(struct rpc_clnt *);
> size_t		rpc_max_payload(struct rpc_clnt *);
> size_t		rpc_max_bc_payload(struct rpc_clnt *);
> +unsigned int	rpc_num_bc_slots(struct rpc_clnt *);
> void		rpc_force_rebind(struct rpc_clnt *);
> size_t		rpc_peeraddr(struct rpc_clnt *, struct sockaddr =
*, size_t);
> const char	*rpc_peeraddr2str(struct rpc_clnt *, enum =
rpc_display_format_t);
> diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
> index ed76e5fb36c1..13e108bcc9eb 100644
> --- a/include/linux/sunrpc/xprt.h
> +++ b/include/linux/sunrpc/xprt.h
> @@ -158,6 +158,7 @@ struct rpc_xprt_ops {
> 	int		(*bc_setup)(struct rpc_xprt *xprt,
> 				    unsigned int min_reqs);
> 	size_t		(*bc_maxpayload)(struct rpc_xprt *xprt);
> +	unsigned int	(*bc_num_slots)(struct rpc_xprt *xprt);
> 	void		(*bc_free_rqst)(struct rpc_rqst *rqst);
> 	void		(*bc_destroy)(struct rpc_xprt *xprt,
> 				      unsigned int max_reqs);
> @@ -251,8 +252,9 @@ struct rpc_xprt {
> #if defined(CONFIG_SUNRPC_BACKCHANNEL)
> 	struct svc_serv		*bc_serv;       /* The RPC service which =
will */
> 						/* process the callback =
*/
> -	int			bc_alloc_count;	/* Total number of =
preallocs */
> -	atomic_t		bc_free_slots;
> +	unsigned int		bc_alloc_max;
> +	unsigned int		bc_alloc_count;	/* Total number of =
preallocs */
> +	atomic_t		bc_slot_count;	/* Number of allocated =
slots */
> 	spinlock_t		bc_pa_lock;	/* Protects the =
preallocated
> 						 * items */
> 	struct list_head	bc_pa_list;	/* List of preallocated
> diff --git a/net/sunrpc/backchannel_rqst.c =
b/net/sunrpc/backchannel_rqst.c
> index c47d82622fd1..339e8c077c2d 100644
> --- a/net/sunrpc/backchannel_rqst.c
> +++ b/net/sunrpc/backchannel_rqst.c
> @@ -31,25 +31,20 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF =
SUCH DAMAGE.
> #define RPCDBG_FACILITY	RPCDBG_TRANS
> #endif
>=20
> +#define BC_MAX_SLOTS	64U
> +
> +unsigned int xprt_bc_max_slots(struct rpc_xprt *xprt)
> +{
> +	return BC_MAX_SLOTS;
> +}
> +
> /*
>  * Helper routines that track the number of preallocation elements
>  * on the transport.
>  */
> static inline int xprt_need_to_requeue(struct rpc_xprt *xprt)
> {
> -	return xprt->bc_alloc_count < atomic_read(&xprt->bc_free_slots);
> -}
> -
> -static inline void xprt_inc_alloc_count(struct rpc_xprt *xprt, =
unsigned int n)
> -{
> -	atomic_add(n, &xprt->bc_free_slots);
> -	xprt->bc_alloc_count +=3D n;
> -}
> -
> -static inline int xprt_dec_alloc_count(struct rpc_xprt *xprt, =
unsigned int n)
> -{
> -	atomic_sub(n, &xprt->bc_free_slots);
> -	return xprt->bc_alloc_count -=3D n;
> +	return xprt->bc_alloc_count < xprt->bc_alloc_max;
> }
>=20
> /*
> @@ -145,6 +140,9 @@ int xprt_setup_bc(struct rpc_xprt *xprt, unsigned =
int min_reqs)
>=20
> 	dprintk("RPC:       setup backchannel transport\n");
>=20
> +	if (min_reqs > BC_MAX_SLOTS)
> +		min_reqs =3D BC_MAX_SLOTS;
> +
> 	/*
> 	 * We use a temporary list to keep track of the preallocated
> 	 * buffers.  Once we're done building the list we splice it
> @@ -172,7 +170,9 @@ int xprt_setup_bc(struct rpc_xprt *xprt, unsigned =
int min_reqs)
> 	 */
> 	spin_lock(&xprt->bc_pa_lock);
> 	list_splice(&tmp_list, &xprt->bc_pa_list);
> -	xprt_inc_alloc_count(xprt, min_reqs);
> +	xprt->bc_alloc_count +=3D min_reqs;
> +	xprt->bc_alloc_max +=3D min_reqs;
> +	atomic_add(min_reqs, &xprt->bc_slot_count);
> 	spin_unlock(&xprt->bc_pa_lock);
>=20
> 	dprintk("RPC:       setup backchannel transport done\n");
> @@ -220,11 +220,13 @@ void xprt_destroy_bc(struct rpc_xprt *xprt, =
unsigned int max_reqs)
> 		goto out;
>=20
> 	spin_lock_bh(&xprt->bc_pa_lock);
> -	xprt_dec_alloc_count(xprt, max_reqs);
> +	xprt->bc_alloc_max -=3D max_reqs;
> 	list_for_each_entry_safe(req, tmp, &xprt->bc_pa_list, =
rq_bc_pa_list) {
> 		dprintk("RPC:        req=3D%p\n", req);
> 		list_del(&req->rq_bc_pa_list);
> 		xprt_free_allocation(req);
> +		xprt->bc_alloc_count--;
> +		atomic_dec(&xprt->bc_slot_count);
> 		if (--max_reqs =3D=3D 0)
> 			break;
> 	}
> @@ -241,13 +243,14 @@ static struct rpc_rqst =
*xprt_get_bc_request(struct rpc_xprt *xprt, __be32 xid,
> 	struct rpc_rqst *req =3D NULL;
>=20
> 	dprintk("RPC:       allocate a backchannel request\n");
> -	if (atomic_read(&xprt->bc_free_slots) <=3D 0)
> -		goto not_found;
> 	if (list_empty(&xprt->bc_pa_list)) {
> 		if (!new)
> 			goto not_found;
> +		if (atomic_read(&xprt->bc_slot_count) >=3D BC_MAX_SLOTS)
> +			goto not_found;
> 		list_add_tail(&new->rq_bc_pa_list, &xprt->bc_pa_list);
> 		xprt->bc_alloc_count++;
> +		atomic_inc(&xprt->bc_slot_count);
> 	}
> 	req =3D list_first_entry(&xprt->bc_pa_list, struct rpc_rqst,
> 				rq_bc_pa_list);
> @@ -291,6 +294,7 @@ void xprt_free_bc_rqst(struct rpc_rqst *req)
> 	if (xprt_need_to_requeue(xprt)) {
> 		list_add_tail(&req->rq_bc_pa_list, &xprt->bc_pa_list);
> 		xprt->bc_alloc_count++;
> +		atomic_inc(&xprt->bc_slot_count);
> 		req =3D NULL;
> 	}
> 	spin_unlock_bh(&xprt->bc_pa_lock);
> @@ -357,7 +361,7 @@ void xprt_complete_bc_request(struct rpc_rqst =
*req, uint32_t copied)
>=20
> 	spin_lock(&xprt->bc_pa_lock);
> 	list_del(&req->rq_bc_pa_list);
> -	xprt_dec_alloc_count(xprt, 1);
> +	xprt->bc_alloc_count--;
> 	spin_unlock(&xprt->bc_pa_lock);
>=20
> 	req->rq_private_buf.len =3D copied;
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 383555d2b522..79c849391cb9 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -1526,6 +1526,19 @@ size_t rpc_max_bc_payload(struct rpc_clnt =
*clnt)
> }
> EXPORT_SYMBOL_GPL(rpc_max_bc_payload);
>=20
> +unsigned int rpc_num_bc_slots(struct rpc_clnt *clnt)
> +{
> +	struct rpc_xprt *xprt;
> +	unsigned int ret;
> +
> +	rcu_read_lock();
> +	xprt =3D rcu_dereference(clnt->cl_xprt);
> +	ret =3D xprt->ops->bc_num_slots(xprt);
> +	rcu_read_unlock();
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(rpc_num_bc_slots);
> +
> /**
>  * rpc_force_rebind - force transport to check that remote port is =
unchanged
>  * @clnt: client to rebind
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index e15cb704453e..220b79988000 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1595,7 +1595,7 @@ bc_svc_process(struct svc_serv *serv, struct =
rpc_rqst *req,
> 	/* Parse and execute the bc call */
> 	proc_error =3D svc_process_common(rqstp, argv, resv);
>=20
> -	atomic_inc(&req->rq_xprt->bc_free_slots);
> +	atomic_dec(&req->rq_xprt->bc_slot_count);
> 	if (!proc_error) {
> 		/* Processing error: drop the request */
> 		xprt_free_bc_request(req);
> diff --git a/net/sunrpc/xprtrdma/backchannel.c =
b/net/sunrpc/xprtrdma/backchannel.c
> index ce986591f213..59e624b1d7a0 100644
> --- a/net/sunrpc/xprtrdma/backchannel.c
> +++ b/net/sunrpc/xprtrdma/backchannel.c
> @@ -52,6 +52,13 @@ size_t xprt_rdma_bc_maxpayload(struct rpc_xprt =
*xprt)
> 	return maxmsg - RPCRDMA_HDRLEN_MIN;
> }
>=20
> +unsigned int xprt_rdma_bc_max_slots(struct rpc_xprt *xprt)
> +{
> +	struct rpcrdma_xprt *r_xprt =3D rpcx_to_rdmax(xprt);
> +
> +	return r_xprt->rx_buf.rb_bc_srv_max_requests;
> +}
> +
> static int rpcrdma_bc_marshal_reply(struct rpc_rqst *rqst)
> {
> 	struct rpcrdma_xprt *r_xprt =3D rpcx_to_rdmax(rqst->rq_xprt);
> diff --git a/net/sunrpc/xprtrdma/transport.c =
b/net/sunrpc/xprtrdma/transport.c
> index 4993aa49ecbe..52abddac19e5 100644
> --- a/net/sunrpc/xprtrdma/transport.c
> +++ b/net/sunrpc/xprtrdma/transport.c
> @@ -812,6 +812,7 @@ static const struct rpc_xprt_ops xprt_rdma_procs =3D=
 {
> #if defined(CONFIG_SUNRPC_BACKCHANNEL)
> 	.bc_setup		=3D xprt_rdma_bc_setup,
> 	.bc_maxpayload		=3D xprt_rdma_bc_maxpayload,
> +	.bc_num_slots		=3D xprt_rdma_bc_max_slots,
> 	.bc_free_rqst		=3D xprt_rdma_bc_free_rqst,
> 	.bc_destroy		=3D xprt_rdma_bc_destroy,
> #endif
> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h =
b/net/sunrpc/xprtrdma/xprt_rdma.h
> index 8378f45d2da7..92ce09fcea74 100644
> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> @@ -605,6 +605,7 @@ void xprt_rdma_cleanup(void);
> #if defined(CONFIG_SUNRPC_BACKCHANNEL)
> int xprt_rdma_bc_setup(struct rpc_xprt *, unsigned int);
> size_t xprt_rdma_bc_maxpayload(struct rpc_xprt *);
> +unsigned int xprt_rdma_bc_max_slots(struct rpc_xprt *);
> int rpcrdma_bc_post_recv(struct rpcrdma_xprt *, unsigned int);
> void rpcrdma_bc_receive_call(struct rpcrdma_xprt *, struct rpcrdma_rep =
*);
> int xprt_rdma_bc_send_reply(struct rpc_rqst *rqst);
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 3c2cc96afcaa..6b1fca51028a 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -2788,6 +2788,7 @@ static const struct rpc_xprt_ops xs_tcp_ops =3D =
{
> #ifdef CONFIG_SUNRPC_BACKCHANNEL
> 	.bc_setup		=3D xprt_setup_bc,
> 	.bc_maxpayload		=3D xs_tcp_bc_maxpayload,
> +	.bc_num_slots		=3D xprt_bc_max_slots,
> 	.bc_free_rqst		=3D xprt_free_bc_rqst,
> 	.bc_destroy		=3D xprt_destroy_bc,
> #endif
> --=20
> 2.21.0
>=20

--
Chuck Lever



