Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C886DDD588
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Oct 2019 01:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbfJRXe0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Oct 2019 19:34:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56026 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfJRXe0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Oct 2019 19:34:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9INXX8k169678;
        Fri, 18 Oct 2019 23:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=SCy5bruQDIsiogR7bKZATZXSQMgqMDvb3s244zmrNM8=;
 b=Or8XrcFCm4dYnM1K0f4GUFnKkLo9NHyCjuuBAGn6cZj+4EPD2b2Cwk9RsJhPCuDkQNB9
 r3zckpOdJYrHC/JicyURj8PMIiyNOHZCNilh5MJ09SkeM6ztrXSU679HCYMPszlVvilI
 dw/EF9Ma5WtWnKm7rF+WsSl2lkcK3qoOtFR8RI7yGpi5a/fQkKpX0ay1VymsMk4FmzHo
 EdgZwNMNnG2HYvAAjQLF6XaNpgTPQmaSlwjcQx/5JSdVRKSgsHg0HYR0fZqdsZdCjj+t
 rd19yLWp4Qxt5Z8+54LIu6dZptSd83SSoWXzGJ0KFqxphR6HKk5fGgvLW4PJoTtBbpkQ iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vq0q4ej5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 23:34:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9INTHaF095983;
        Fri, 18 Oct 2019 23:34:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vq0dysbcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 23:34:22 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9INYLTZ029256;
        Fri, 18 Oct 2019 23:34:21 GMT
Received: from [172.20.3.63] (/107.1.192.66)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Oct 2019 23:34:21 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 6/6] xprtrdma: Pull up sometimes
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <f5075a20-7c9a-773f-e76b-11cba1ab0f16@talpey.com>
Date:   Fri, 18 Oct 2019 19:34:20 -0400
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1BB2B60-6DE2-47FD-92BA-ED9011C51661@oracle.com>
References: <20191017182811.2517.25676.stgit@oracle-102.nfsv4bat.org>
 <20191017183152.2517.67599.stgit@oracle-102.nfsv4bat.org>
 <f5075a20-7c9a-773f-e76b-11cba1ab0f16@talpey.com>
To:     Tom Talpey <tom@talpey.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910180210
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910180211
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Tom-

> On Oct 18, 2019, at 4:17 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 10/17/2019 2:31 PM, Chuck Lever wrote:
>> On some platforms, DMA mapping part of a page is more costly than
>> copying bytes. Restore the pull-up code and use that when we
>> think it's going to be faster. The heuristic for now is to pull-up
>> when the size of the RPC message body fits in the buffer underlying
>> the head iovec.
>> Indeed, not involving the I/O MMU can help the RPC/RDMA transport
>> scale better for tiny I/Os across more RDMA devices. This is because
>> interaction with the I/O MMU is eliminated, as is handling a Send
>> completion, for each of these small I/Os. Without the explicit
>> unmapping, the NIC no longer needs to do a costly internal TLB shoot
>> down for buffers that are just a handful of bytes.
>=20
> This is good stuff. Do you have any performance data for the new
> strategy, especially latencies and local CPU cycles per byte?

Saves almost a microsecond of RT latency on my NFS client that uses
a real Intel IOMMU. On my other NFS client, the DMA map operations
are always a no-op. This savings applies only to NFS WRITE, of course.

I don't have a good benchmark for cycles per byte. Do you have any
suggestions? Not sure how I would account for cycles spent handling
Send completions, for example.


> Tom.
>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  net/sunrpc/xprtrdma/backchannel.c |    2 -
>>  net/sunrpc/xprtrdma/rpc_rdma.c    |   82 =
+++++++++++++++++++++++++++++++++++--
>>  net/sunrpc/xprtrdma/verbs.c       |    2 -
>>  net/sunrpc/xprtrdma/xprt_rdma.h   |    2 +
>>  4 files changed, 81 insertions(+), 7 deletions(-)
>> diff --git a/include/trace/events/rpcrdma.h =
b/include/trace/events/rpcrdma.h
>> index 16572ae7..336a65d 100644
>> --- a/include/trace/events/rpcrdma.h
>> +++ b/include/trace/events/rpcrdma.h
>> @@ -532,6 +532,8 @@
>>  DEFINE_WRCH_EVENT(reply);
>>    TRACE_DEFINE_ENUM(rpcrdma_noch);
>> +TRACE_DEFINE_ENUM(rpcrdma_noch_pullup);
>> +TRACE_DEFINE_ENUM(rpcrdma_noch_mapped);
>>  TRACE_DEFINE_ENUM(rpcrdma_readch);
>>  TRACE_DEFINE_ENUM(rpcrdma_areadch);
>>  TRACE_DEFINE_ENUM(rpcrdma_writech);
>> @@ -540,6 +542,8 @@
>>  #define xprtrdma_show_chunktype(x)					=
\
>>  		__print_symbolic(x,					=
\
>>  				{ rpcrdma_noch, "inline" },		=
\
>> +				{ rpcrdma_noch_pullup, "pullup" },	=
\
>> +				{ rpcrdma_noch_mapped, "mapped" },	=
\
>>  				{ rpcrdma_readch, "read list" },	=
\
>>  				{ rpcrdma_areadch, "*read list" },	=
\
>>  				{ rpcrdma_writech, "write list" },	=
\
>> diff --git a/net/sunrpc/xprtrdma/backchannel.c =
b/net/sunrpc/xprtrdma/backchannel.c
>> index 50e075f..1168524 100644
>> --- a/net/sunrpc/xprtrdma/backchannel.c
>> +++ b/net/sunrpc/xprtrdma/backchannel.c
>> @@ -79,7 +79,7 @@ static int rpcrdma_bc_marshal_reply(struct rpc_rqst =
*rqst)
>>  	*p =3D xdr_zero;
>>    	if (rpcrdma_prepare_send_sges(r_xprt, req, RPCRDMA_HDRLEN_MIN,
>> -				      &rqst->rq_snd_buf, rpcrdma_noch))
>> +				      &rqst->rq_snd_buf, =
rpcrdma_noch_pullup))
>>  		return -EIO;
>>    	trace_xprtrdma_cb_reply(rqst);
>> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c =
b/net/sunrpc/xprtrdma/rpc_rdma.c
>> index a441dbf..4ad8889 100644
>> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
>> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
>> @@ -392,7 +392,7 @@ static int rpcrdma_encode_read_list(struct =
rpcrdma_xprt *r_xprt,
>>  	unsigned int pos;
>>  	int nsegs;
>>  -	if (rtype =3D=3D rpcrdma_noch)
>> +	if (rtype =3D=3D rpcrdma_noch_pullup || rtype =3D=3D =
rpcrdma_noch_mapped)
>>  		goto done;
>>    	pos =3D rqst->rq_snd_buf.head[0].iov_len;
>> @@ -691,6 +691,72 @@ static bool rpcrdma_prepare_tail_iov(struct =
rpcrdma_req *req,
>>  	return false;
>>  }
>>  +/* Copy the tail to the end of the head buffer.
>> + */
>> +static void rpcrdma_pullup_tail_iov(struct rpcrdma_xprt *r_xprt,
>> +				    struct rpcrdma_req *req,
>> +				    struct xdr_buf *xdr)
>> +{
>> +	unsigned char *dst;
>> +
>> +	dst =3D (unsigned char *)xdr->head[0].iov_base;
>> +	dst +=3D xdr->head[0].iov_len + xdr->page_len;
>> +	memmove(dst, xdr->tail[0].iov_base, xdr->tail[0].iov_len);
>> +	r_xprt->rx_stats.pullup_copy_count +=3D xdr->tail[0].iov_len;
>> +}
>> +
>> +/* Copy pagelist content into the head buffer.
>> + */
>> +static void rpcrdma_pullup_pagelist(struct rpcrdma_xprt *r_xprt,
>> +				    struct rpcrdma_req *req,
>> +				    struct xdr_buf *xdr)
>> +{
>> +	unsigned int len, page_base, remaining;
>> +	struct page **ppages;
>> +	unsigned char *src, *dst;
>> +
>> +	dst =3D (unsigned char *)xdr->head[0].iov_base;
>> +	dst +=3D xdr->head[0].iov_len;
>> +	ppages =3D xdr->pages + (xdr->page_base >> PAGE_SHIFT);
>> +	page_base =3D offset_in_page(xdr->page_base);
>> +	remaining =3D xdr->page_len;
>> +	while (remaining) {
>> +		src =3D page_address(*ppages);
>> +		src +=3D page_base;
>> +		len =3D min_t(unsigned int, PAGE_SIZE - page_base, =
remaining);
>> +		memcpy(dst, src, len);
>> +		r_xprt->rx_stats.pullup_copy_count +=3D len;
>> +
>> +		ppages++;
>> +		dst +=3D len;
>> +		remaining -=3D len;
>> +		page_base =3D 0;
>> +	}
>> +}
>> +
>> +/* Copy the contents of @xdr into @rl_sendbuf and DMA sync it.
>> + * When the head, pagelist, and tail are small, a pull-up copy
>> + * is considerably less costly than DMA mapping the components
>> + * of @xdr.
>> + *
>> + * Assumptions:
>> + *  - the caller has already verified that the total length
>> + *    of the RPC Call body will fit into @rl_sendbuf.
>> + */
>> +static bool rpcrdma_prepare_noch_pullup(struct rpcrdma_xprt *r_xprt,
>> +					struct rpcrdma_req *req,
>> +					struct xdr_buf *xdr)
>> +{
>> +	if (unlikely(xdr->tail[0].iov_len))
>> +		rpcrdma_pullup_tail_iov(r_xprt, req, xdr);
>> +
>> +	if (unlikely(xdr->page_len))
>> +		rpcrdma_pullup_pagelist(r_xprt, req, xdr);
>> +
>> +	/* The whole RPC message resides in the head iovec now */
>> +	return rpcrdma_prepare_head_iov(r_xprt, req, xdr->len);
>> +}
>> +
>>  static bool rpcrdma_prepare_noch_mapped(struct rpcrdma_xprt *r_xprt,
>>  					struct rpcrdma_req *req,
>>  					struct xdr_buf *xdr)
>> @@ -779,7 +845,11 @@ inline int rpcrdma_prepare_send_sges(struct =
rpcrdma_xprt *r_xprt,
>>  		goto out_unmap;
>>    	switch (rtype) {
>> -	case rpcrdma_noch:
>> +	case rpcrdma_noch_pullup:
>> +		if (!rpcrdma_prepare_noch_pullup(r_xprt, req, xdr))
>> +			goto out_unmap;
>> +		break;
>> +	case rpcrdma_noch_mapped:
>>  		if (!rpcrdma_prepare_noch_mapped(r_xprt, req, xdr))
>>  			goto out_unmap;
>>  		break;
>> @@ -827,6 +897,7 @@ inline int rpcrdma_prepare_send_sges(struct =
rpcrdma_xprt *r_xprt,
>>  	struct rpcrdma_req *req =3D rpcr_to_rdmar(rqst);
>>  	struct xdr_stream *xdr =3D &req->rl_stream;
>>  	enum rpcrdma_chunktype rtype, wtype;
>> +	struct xdr_buf *buf =3D &rqst->rq_snd_buf;
>>  	bool ddp_allowed;
>>  	__be32 *p;
>>  	int ret;
>> @@ -884,8 +955,9 @@ inline int rpcrdma_prepare_send_sges(struct =
rpcrdma_xprt *r_xprt,
>>  	 */
>>  	if (rpcrdma_args_inline(r_xprt, rqst)) {
>>  		*p++ =3D rdma_msg;
>> -		rtype =3D rpcrdma_noch;
>> -	} else if (ddp_allowed && rqst->rq_snd_buf.flags & XDRBUF_WRITE) =
{
>> +		rtype =3D buf->len < rdmab_length(req->rl_sendbuf) ?
>> +			rpcrdma_noch_pullup : rpcrdma_noch_mapped;
>> +	} else if (ddp_allowed && buf->flags & XDRBUF_WRITE) {
>>  		*p++ =3D rdma_msg;
>>  		rtype =3D rpcrdma_readch;
>>  	} else {
>> @@ -927,7 +999,7 @@ inline int rpcrdma_prepare_send_sges(struct =
rpcrdma_xprt *r_xprt,
>>  		goto out_err;
>>    	ret =3D rpcrdma_prepare_send_sges(r_xprt, req, =
req->rl_hdrbuf.len,
>> -					&rqst->rq_snd_buf, rtype);
>> +					buf, rtype);
>>  	if (ret)
>>  		goto out_err;
>>  diff --git a/net/sunrpc/xprtrdma/verbs.c =
b/net/sunrpc/xprtrdma/verbs.c
>> index 2f46582..a514e2c 100644
>> --- a/net/sunrpc/xprtrdma/verbs.c
>> +++ b/net/sunrpc/xprtrdma/verbs.c
>> @@ -1165,7 +1165,7 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt =
*r_xprt)
>>  	for (i =3D 0; i < buf->rb_max_requests; i++) {
>>  		struct rpcrdma_req *req;
>>  -		req =3D rpcrdma_req_create(r_xprt, =
RPCRDMA_V1_DEF_INLINE_SIZE,
>> +		req =3D rpcrdma_req_create(r_xprt, =
RPCRDMA_V1_DEF_INLINE_SIZE * 2,
>>  					 GFP_KERNEL);
>>  		if (!req)
>>  			goto out;
>> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h =
b/net/sunrpc/xprtrdma/xprt_rdma.h
>> index cdd6a3d..5d15140 100644
>> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
>> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
>> @@ -554,6 +554,8 @@ struct rpcrdma_mr_seg *frwr_map(struct =
rpcrdma_xprt *r_xprt,
>>    enum rpcrdma_chunktype {
>>  	rpcrdma_noch =3D 0,
>> +	rpcrdma_noch_pullup,
>> +	rpcrdma_noch_mapped,
>>  	rpcrdma_readch,
>>  	rpcrdma_areadch,
>>  	rpcrdma_writech,

--
Chuck Lever



