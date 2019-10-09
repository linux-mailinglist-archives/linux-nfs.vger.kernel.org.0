Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A74A4D1504
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2019 19:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbfJIRMS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Oct 2019 13:12:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56526 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731433AbfJIRMS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Oct 2019 13:12:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99H4Ret055750;
        Wed, 9 Oct 2019 17:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : date : references :
 to : in-reply-to : message-id; s=corp-2019-08-05;
 bh=fBLz7Xz4r1TRVmLAn/eSqFuYDWqaQAXwau9rlhmIzto=;
 b=f4Cju9s89A7YEaNhX92j8ZM0swXhJAaHX8cDI2jchT64nzv6CzHLBtSX8KTu/HPOVdY5
 cJeQm1hq2i2hczFuHs97k6CNI/pJ/I7U4kq4x6X2I43JX9MLnuOcKW1uZmV1xPsVhMfE
 R8PuQhsdyq5QqS4p8AJ5BOZD9kwCu0zMRYEK/9FucHXsqFIBtl3eQnt66Ir2hpITNn98
 J6xA+x9U9oHlD+IeTTWDDh8RF6gwhvh1xOiRcvIUo+zg/B7NLeMJzS01jrm+V9SAOM5w
 pb3uYtWqV5Nw+9uIWxRCgZWpoWA16i0lazxFUM/heCTLpu+jJmpvil1kRku/BtSuO242 cA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vejkup514-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 17:12:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99H38VL164019;
        Wed, 9 Oct 2019 17:10:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vgev1vaqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 17:10:16 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x99HAFdj004736;
        Wed, 9 Oct 2019 17:10:15 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 17:10:14 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 1/6] xprtrdma: Add unique trace points for posting
 Local Invalidate WRs
Date:   Wed, 9 Oct 2019 13:10:13 -0400
References: <20191009170721.2978.128.stgit@manet.1015granger.net>
To:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <20191009170721.2978.128.stgit@manet.1015granger.net>
Message-Id: <68B39F44-0AB3-489F-A9A2-EDF7976339A6@oracle.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910090148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910090148
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

> On Oct 9, 2019, at 1:07 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> When adding frwr_unmap_async way back when, I re-used the existing
> trace_xprtrdma_post_send() trace point to record the return code
> of ib_post_send.
>=20
> Unfortunately there are some cases where re-using that trace point
> causes a crash. Instead, construct a trace point specific to posting
> Local Invalidate WRs that will always be safe to use in that context,
> and will act as a trace log eye-catcher for Local Invalidation.

I forgot to add a cover letter to this series.

The first patch fixes a crasher that shows up when the rpcrdma trace
class is enabled.

The remaining patches address issues with how the RPC/RDMA client
handles MRs. See individual patch descriptions for details.


> Fixes: 847568942f93 ("xprtrdma: Remove fr_state")
> Fixes: d8099feda483 ("xprtrdma: Reduce context switching due ... ")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Tested-by: Bill Baker <bill.baker@oracle.com>
> ---
> include/trace/events/rpcrdma.h |   25 +++++++++++++++++++++++++
> net/sunrpc/xprtrdma/frwr_ops.c |    4 ++--
> 2 files changed, 27 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/trace/events/rpcrdma.h =
b/include/trace/events/rpcrdma.h
> index 9dd7680..31681cb 100644
> --- a/include/trace/events/rpcrdma.h
> +++ b/include/trace/events/rpcrdma.h
> @@ -735,6 +735,31 @@
> 	)
> );
>=20
> +TRACE_EVENT(xprtrdma_post_linv,
> +	TP_PROTO(
> +		const struct rpcrdma_req *req,
> +		int status
> +	),
> +
> +	TP_ARGS(req, status),
> +
> +	TP_STRUCT__entry(
> +		__field(const void *, req)
> +		__field(int, status)
> +		__field(u32, xid)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->req =3D req;
> +		__entry->status =3D status;
> +		__entry->xid =3D be32_to_cpu(req->rl_slot.rq_xid);
> +	),
> +
> +	TP_printk("req=3D%p xid=3D0x%08x status=3D%d",
> +		__entry->req, __entry->xid, __entry->status
> +	)
> +);
> +
> /**
>  ** Completion events
>  **/
> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c =
b/net/sunrpc/xprtrdma/frwr_ops.c
> index 30065a2..9901a81 100644
> --- a/net/sunrpc/xprtrdma/frwr_ops.c
> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
> @@ -570,7 +570,6 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, =
struct rpcrdma_req *req)
> 	 */
> 	bad_wr =3D NULL;
> 	rc =3D ib_post_send(r_xprt->rx_ia.ri_id->qp, first, &bad_wr);
> -	trace_xprtrdma_post_send(req, rc);
>=20
> 	/* The final LOCAL_INV WR in the chain is supposed to
> 	 * do the wake. If it was never posted, the wake will
> @@ -583,6 +582,7 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, =
struct rpcrdma_req *req)
>=20
> 	/* Recycle MRs in the LOCAL_INV chain that did not get posted.
> 	 */
> +	trace_xprtrdma_post_linv(req, rc);
> 	while (bad_wr) {
> 		frwr =3D container_of(bad_wr, struct rpcrdma_frwr,
> 				    fr_invwr);
> @@ -673,12 +673,12 @@ void frwr_unmap_async(struct rpcrdma_xprt =
*r_xprt, struct rpcrdma_req *req)
> 	 */
> 	bad_wr =3D NULL;
> 	rc =3D ib_post_send(r_xprt->rx_ia.ri_id->qp, first, &bad_wr);
> -	trace_xprtrdma_post_send(req, rc);
> 	if (!rc)
> 		return;
>=20
> 	/* Recycle MRs in the LOCAL_INV chain that did not get posted.
> 	 */
> +	trace_xprtrdma_post_linv(req, rc);
> 	while (bad_wr) {
> 		frwr =3D container_of(bad_wr, struct rpcrdma_frwr, =
fr_invwr);
> 		mr =3D container_of(frwr, struct rpcrdma_mr, frwr);
>=20

--
Chuck Lever



