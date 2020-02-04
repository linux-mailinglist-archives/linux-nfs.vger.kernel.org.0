Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 590CE15208E
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Feb 2020 19:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgBDSoX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Feb 2020 13:44:23 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38752 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgBDSoX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Feb 2020 13:44:23 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014IhJGC039644;
        Tue, 4 Feb 2020 18:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=nPXK0clzyM1sVZ2bGsaRaYaylegz2mt4Yaw1JoKO2xE=;
 b=gqTRGo4s57wJhpYO7WbYhINsC1Z9EJB1pLv5wDEGED4sPDqk6/mVLBxyQf4vKoDE3gh+
 nQkUxApje/w2rwzdHK+Pg1wINuqeUOVxKaoS8xQnp0zv8xoQvR6x9xA3J40smZa5XnAa
 DJ5nF04wxPz728SuAczkONs+TvD/2llBzNGMnloMdtbiFqVgsaIHPZ0yFMwJhBB6v4L+
 wIG1ezYs0EwOv/8XzKk8GwVcYu1imf2qrZyhLy/1b48Mb6ONmlSiZ7tdDrUV7bw6f38C
 Iz5wfN2sVINCX1mS+l5RTJDsddTrThp45E9GNcUkiju80Hupcb3rDOp0TW96joSXviYa EA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xw0ru8pej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 18:44:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014IiFqe095095;
        Tue, 4 Feb 2020 18:44:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2xxvy3mny3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 18:44:17 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 014IhwVL014230;
        Tue, 4 Feb 2020 18:44:00 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Feb 2020 10:43:58 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3] nfsd: Fix NFSv4 READ on RDMA when using readv
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200204172154.GB8763@fieldses.org>
Date:   Tue, 4 Feb 2020 13:43:56 -0500
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B95D88FC-C76D-42A2-9366-CA226757BA42@oracle.com>
References: <20200201195914.12238.15729.stgit@bazille.1015granger.net>
 <20200204172154.GB8763@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002040124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002040124
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 4, 2020, at 12:21 PM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Sat, Feb 01, 2020 at 03:05:19PM -0500, Chuck Lever wrote:
>> svcrdma expects that the payload falls precisely into the xdr_buf
>> page vector. This does not seem to be the case for
>> nfsd4_encode_readv().
>>=20
>> This code is called only when fops->splice_read is missing or when
>> RQ_SPLICE_OK is clear, so it's not a noticeable problem in many
>> common cases.
>>=20
>> Add new transport method: ->xpo_read_payload so that when a READ
>> payload does not fit exactly in rq_res's page vector, the XDR
>> encoder can inform the RPC transport exactly where that payload is,
>> without the payload's XDR pad.
>>=20
>> That way, when a Write chunk is present, the transport knows what
>> byte range in the Reply message is supposed to be matched with the
>> chunk.
>>=20
>> Note that the Linux NFS server implementation of NFS/RDMA can
>> currently handle only one Write chunk per RPC-over-RDMA message.
>> This simplifies the implementation of this fix.
>>=20
>> Fixes: b04209806384 ("nfsd4: allow exotic read compounds")
>> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=3D198053
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>=20
>> Hi Bruce-
>>=20
>> This fix seems closer to being merge-able. I've tested it by wiring
>> the NFSv4 READ Reply encoder to always use readv. I've run the git
>> regression suite with NFSv3, NFSv4.0, and NFSv4.1 using all three
>> flavors of Kerberos and sec=3Dsys, all on NFS/RDMA.
>>=20
>> Aside from a new no-op function call, the TCP path is not perturbed.
>>=20
>>=20
>> Changes since RFC2:
>> - Take Trond's suggestion to use xdr->buf->len
>> - Squash fix down to a single patch
>=20
> I liked them better split out.
>=20
> This seems fine to me, though.
>=20
> Could you ping me again in another week, after the merge window?
>=20
>> @@ -3521,17 +3521,14 @@ static __be32 nfsd4_encode_readv(struct =
nfsd4_compoundres *resp,
>> 	u32 zzz =3D 0;
>> 	int pad;
>>=20
>> +	/* Ensure xdr_reserve_space skips past xdr->buf->head */
>=20
> Could the comment explain why we're doing this?  (Maybe take some
> language from the changelog.)

The new comment will also explain why the patches are combined.
I'll send a v4 after the merge window closes.


> --b.
>=20
>> +	if (xdr->iov =3D=3D xdr->buf->head) {
>> +		xdr->iov =3D NULL;
>> +		xdr->end =3D xdr->p;
>> +	}
>> +
>> 	len =3D maxcount;
>> 	v =3D 0;
>> -
>> -	thislen =3D min_t(long, len, ((void *)xdr->end - (void =
*)xdr->p));
>> -	p =3D xdr_reserve_space(xdr, (thislen+3)&~3);
>> -	WARN_ON_ONCE(!p);
>> -	resp->rqstp->rq_vec[v].iov_base =3D p;
>> -	resp->rqstp->rq_vec[v].iov_len =3D thislen;
>> -	v++;
>> -	len -=3D thislen;
>> -
>> 	while (len) {
>> 		thislen =3D min_t(long, len, PAGE_SIZE);
>> 		p =3D xdr_reserve_space(xdr, (thislen+3)&~3);
>> @@ -3550,6 +3547,7 @@ static __be32 nfsd4_encode_readv(struct =
nfsd4_compoundres *resp,
>> 	read->rd_length =3D maxcount;
>> 	if (nfserr)
>> 		return nfserr;
>> +	svc_mark_read_payload(resp->rqstp, starting_len + 8, =
read->rd_length);
>> 	xdr_truncate_encode(xdr, starting_len + 8 + ((maxcount+3)&~3));
>>=20
>> 	tmp =3D htonl(eof);
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index 1afe38eb33f7..e0610e0e34f7 100644
>> --- a/include/linux/sunrpc/svc.h
>> +++ b/include/linux/sunrpc/svc.h
>> @@ -517,6 +517,9 @@ int		   svc_register(const struct =
svc_serv *, struct net *, const int,
>> void		   svc_reserve(struct svc_rqst *rqstp, int space);
>> struct svc_pool *  svc_pool_for_cpu(struct svc_serv *serv, int cpu);
>> char *		   svc_print_addr(struct svc_rqst *, char *, =
size_t);
>> +void		   svc_mark_read_payload(struct svc_rqst *rqstp,
>> +					 unsigned int pos,
>> +					 unsigned long length);
>> unsigned int	   svc_fill_write_vector(struct svc_rqst *rqstp,
>> 					 struct page **pages,
>> 					 struct kvec *first, size_t =
total);
>> diff --git a/include/linux/sunrpc/svc_rdma.h =
b/include/linux/sunrpc/svc_rdma.h
>> index 40f65888dd38..4fd3b8a16dfd 100644
>> --- a/include/linux/sunrpc/svc_rdma.h
>> +++ b/include/linux/sunrpc/svc_rdma.h
>> @@ -137,6 +137,7 @@ struct svc_rdma_recv_ctxt {
>> 	unsigned int		rc_page_count;
>> 	unsigned int		rc_hdr_count;
>> 	u32			rc_inv_rkey;
>> +	unsigned long		rc_read_payload_length;
>> 	struct page		*rc_pages[RPCSVC_MAXPAGES];
>> };
>>=20
>> @@ -170,7 +171,8 @@ extern int svc_rdma_recv_read_chunk(struct =
svcxprt_rdma *rdma,
>> 				    struct svc_rqst *rqstp,
>> 				    struct svc_rdma_recv_ctxt *head, =
__be32 *p);
>> extern int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
>> -				     __be32 *wr_ch, struct xdr_buf =
*xdr);
>> +				     __be32 *wr_ch, struct xdr_buf *xdr,
>> +				     struct svc_rdma_recv_ctxt *rctxt);
>> extern int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
>> 				     __be32 *rp_ch, bool writelist,
>> 				     struct xdr_buf *xdr);
>> @@ -189,6 +191,8 @@ extern int svc_rdma_map_reply_msg(struct =
svcxprt_rdma *rdma,
>> 				  struct svc_rdma_send_ctxt *ctxt,
>> 				  struct xdr_buf *xdr, __be32 *wr_lst);
>> extern int svc_rdma_sendto(struct svc_rqst *);
>> +extern void svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned =
int pos,
>> +				  unsigned long length);
>>=20
>> /* svc_rdma_transport.c */
>> extern int svc_rdma_create_listen(struct svc_serv *, int, struct =
sockaddr *);
>> diff --git a/include/linux/sunrpc/svc_xprt.h =
b/include/linux/sunrpc/svc_xprt.h
>> index ea6f46be9cb7..d272acf7531f 100644
>> --- a/include/linux/sunrpc/svc_xprt.h
>> +++ b/include/linux/sunrpc/svc_xprt.h
>> @@ -21,6 +21,8 @@ struct svc_xprt_ops {
>> 	int		(*xpo_has_wspace)(struct svc_xprt *);
>> 	int		(*xpo_recvfrom)(struct svc_rqst *);
>> 	int		(*xpo_sendto)(struct svc_rqst *);
>> +	void		(*xpo_read_payload)(struct svc_rqst *, unsigned =
int,
>> +					    unsigned long);
>> 	void		(*xpo_release_rqst)(struct svc_rqst *);
>> 	void		(*xpo_detach)(struct svc_xprt *);
>> 	void		(*xpo_free)(struct svc_xprt *);
>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>> index 187dd4e73d64..d4a0134f1ca1 100644
>> --- a/net/sunrpc/svc.c
>> +++ b/net/sunrpc/svc.c
>> @@ -1637,6 +1637,20 @@ u32 svc_max_payload(const struct svc_rqst =
*rqstp)
>> EXPORT_SYMBOL_GPL(svc_max_payload);
>>=20
>> /**
>> + * svc_mark_read_payload - mark a range of bytes as a READ payload
>> + * @rqstp: svc_rqst to operate on
>> + * @pos: payload's byte offset in the RPC Reply message
>> + * @length: size of payload, in bytes
>> + *
>> + */
>> +void svc_mark_read_payload(struct svc_rqst *rqstp, unsigned int pos,
>> +			   unsigned long length)
>> +{
>> +	rqstp->rq_xprt->xpt_ops->xpo_read_payload(rqstp, pos, length);
>> +}
>> +EXPORT_SYMBOL_GPL(svc_mark_read_payload);
>> +
>> +/**
>>  * svc_fill_write_vector - Construct data argument for VFS write call
>>  * @rqstp: svc_rqst to operate on
>>  * @pages: list of pages containing data payload
>> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
>> index 2934dd711715..fe045b3e7e08 100644
>> --- a/net/sunrpc/svcsock.c
>> +++ b/net/sunrpc/svcsock.c
>> @@ -279,6 +279,11 @@ static int svc_sendto(struct svc_rqst *rqstp, =
struct xdr_buf *xdr)
>> 	return len;
>> }
>>=20
>> +static void svc_sock_read_payload(struct svc_rqst *rqstp, unsigned =
int pos,
>> +				  unsigned long length)
>> +{
>> +}
>> +
>> /*
>>  * Report socket names for nfsdfs
>>  */
>> @@ -653,6 +658,7 @@ static struct svc_xprt *svc_udp_create(struct =
svc_serv *serv,
>> 	.xpo_create =3D svc_udp_create,
>> 	.xpo_recvfrom =3D svc_udp_recvfrom,
>> 	.xpo_sendto =3D svc_udp_sendto,
>> +	.xpo_read_payload =3D svc_sock_read_payload,
>> 	.xpo_release_rqst =3D svc_release_udp_skb,
>> 	.xpo_detach =3D svc_sock_detach,
>> 	.xpo_free =3D svc_sock_free,
>> @@ -1171,6 +1177,7 @@ static struct svc_xprt *svc_tcp_create(struct =
svc_serv *serv,
>> 	.xpo_create =3D svc_tcp_create,
>> 	.xpo_recvfrom =3D svc_tcp_recvfrom,
>> 	.xpo_sendto =3D svc_tcp_sendto,
>> +	.xpo_read_payload =3D svc_sock_read_payload,
>> 	.xpo_release_rqst =3D svc_release_skb,
>> 	.xpo_detach =3D svc_tcp_sock_detach,
>> 	.xpo_free =3D svc_sock_free,
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c =
b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>> index 393af8624f53..90f0a9ce7521 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>> @@ -191,6 +191,7 @@ void svc_rdma_recv_ctxts_destroy(struct =
svcxprt_rdma *rdma)
>>=20
>> out:
>> 	ctxt->rc_page_count =3D 0;
>> +	ctxt->rc_read_payload_length =3D 0;
>> 	return ctxt;
>>=20
>> out_empty:
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c =
b/net/sunrpc/xprtrdma/svc_rdma_rw.c
>> index 467d40a1dffa..2cef19592565 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
>> @@ -484,18 +484,18 @@ static int svc_rdma_send_xdr_kvec(struct =
svc_rdma_write_info *info,
>> 				     vec->iov_len);
>> }
>>=20
>> -/* Send an xdr_buf's page list by itself. A Write chunk is
>> - * just the page list. a Reply chunk is the head, page list,
>> - * and tail. This function is shared between the two types
>> - * of chunk.
>> +/* Send an xdr_buf's page list by itself. A Write chunk is just
>> + * the page list. A Reply chunk is @xdr's head, page list, and
>> + * tail. This function is shared between the two types of chunk.
>>  */
>> static int svc_rdma_send_xdr_pagelist(struct svc_rdma_write_info =
*info,
>> -				      struct xdr_buf *xdr)
>> +				      struct xdr_buf *xdr,
>> +				      unsigned int length)
>> {
>> 	info->wi_xdr =3D xdr;
>> 	info->wi_next_off =3D 0;
>> 	return svc_rdma_build_writes(info, svc_rdma_pagelist_to_sg,
>> -				     xdr->page_len);
>> +				     length);
>> }
>>=20
>> /**
>> @@ -503,6 +503,7 @@ static int svc_rdma_send_xdr_pagelist(struct =
svc_rdma_write_info *info,
>>  * @rdma: controlling RDMA transport
>>  * @wr_ch: Write chunk provided by client
>>  * @xdr: xdr_buf containing the data payload
>> + * @rctxt: location in @xdr of the data payload
>>  *
>>  * Returns a non-negative number of bytes the chunk consumed, or
>>  *	%-E2BIG if the payload was larger than the Write chunk,
>> @@ -512,9 +513,11 @@ static int svc_rdma_send_xdr_pagelist(struct =
svc_rdma_write_info *info,
>>  *	%-EIO if rdma_rw initialization failed (DMA mapping, etc).
>>  */
>> int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 =
*wr_ch,
>> -			      struct xdr_buf *xdr)
>> +			      struct xdr_buf *xdr,
>> +			      struct svc_rdma_recv_ctxt *rctxt)
>> {
>> 	struct svc_rdma_write_info *info;
>> +	unsigned int length;
>> 	int ret;
>>=20
>> 	if (!xdr->page_len)
>> @@ -524,7 +527,12 @@ int svc_rdma_send_write_chunk(struct =
svcxprt_rdma *rdma, __be32 *wr_ch,
>> 	if (!info)
>> 		return -ENOMEM;
>>=20
>> -	ret =3D svc_rdma_send_xdr_pagelist(info, xdr);
>> +	/* xdr->page_len is the chunk length, unless the upper layer
>> +	 * has explicitly provided a payload length.
>> +	 */
>> +	length =3D rctxt->rc_read_payload_length ?
>> +			rctxt->rc_read_payload_length : xdr->page_len;
>> +	ret =3D svc_rdma_send_xdr_pagelist(info, xdr, length);
>> 	if (ret < 0)
>> 		goto out_err;
>>=20
>> @@ -533,7 +541,7 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma =
*rdma, __be32 *wr_ch,
>> 		goto out_err;
>>=20
>> 	trace_svcrdma_encode_write(xdr->page_len);
>> -	return xdr->page_len;
>> +	return length;
>>=20
>> out_err:
>> 	svc_rdma_write_info_free(info);
>> @@ -573,7 +581,8 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma =
*rdma, __be32 *rp_ch,
>> 	 * client did not provide Write chunks.
>> 	 */
>> 	if (!writelist && xdr->page_len) {
>> -		ret =3D svc_rdma_send_xdr_pagelist(info, xdr);
>> +		ret =3D svc_rdma_send_xdr_pagelist(info, xdr,
>> +						 xdr->page_len);
>> 		if (ret < 0)
>> 			goto out_err;
>> 		consumed +=3D xdr->page_len;
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c =
b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
>> index a9ba040c70da..6f9b49b6768f 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
>> @@ -871,7 +871,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
>>=20
>> 	if (wr_lst) {
>> 		/* XXX: Presume the client sent only one Write chunk */
>> -		ret =3D svc_rdma_send_write_chunk(rdma, wr_lst, xdr);
>> +		ret =3D svc_rdma_send_write_chunk(rdma, wr_lst, xdr, =
rctxt);
>> 		if (ret < 0)
>> 			goto err2;
>> 		svc_rdma_xdr_encode_write_list(rdma_resp, wr_lst, ret);
>> @@ -913,3 +913,27 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
>> 	ret =3D -ENOTCONN;
>> 	goto out;
>> }
>> +
>> +/**
>> + * svc_rdma_read_payload - mark where a READ payload sites
>> + * @rqstp: svc_rqst to operate on
>> + * @pos: payload's byte offset in the RPC Reply message
>> + * @length: size of payload, in bytes
>> + *
>> + * For the moment, just record the xdr_buf location of the READ
>> + * payload. svc_rdma_sendto will use that location later when
>> + * we actually send the payload.
>> + */
>> +void svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int pos,
>> +			   unsigned long length)
>> +{
>> +	struct svc_rdma_recv_ctxt *ctxt =3D rqstp->rq_xprt_ctxt;
>> +
>> +	/* XXX: Just one READ payload slot for now, since our
>> +	 * transport implementation currently supports only one
>> +	 * Write chunk. We assume the one READ payload always
>> +	 * starts at the head<->pages boundary.
>> +	 */
>> +	WARN_ON(rqstp->rq_res.head[0].iov_len !=3D pos);
>> +	ctxt->rc_read_payload_length =3D length;
>> +}
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c =
b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> index 145a3615c319..f6aad2798063 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> @@ -82,6 +82,7 @@ static struct svc_xprt *svc_rdma_create(struct =
svc_serv *serv,
>> 	.xpo_create =3D svc_rdma_create,
>> 	.xpo_recvfrom =3D svc_rdma_recvfrom,
>> 	.xpo_sendto =3D svc_rdma_sendto,
>> +	.xpo_read_payload =3D svc_rdma_read_payload,
>> 	.xpo_release_rqst =3D svc_rdma_release_rqst,
>> 	.xpo_detach =3D svc_rdma_detach,
>> 	.xpo_free =3D svc_rdma_free,

--
Chuck Lever



