Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D62C2D899D
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Dec 2020 20:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439795AbgLLTRf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 12 Dec 2020 14:17:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52166 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgLLTR0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 12 Dec 2020 14:17:26 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BCJATSu176780
        for <linux-nfs@vger.kernel.org>; Sat, 12 Dec 2020 19:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : date : references :
 to : in-reply-to : message-id; s=corp-2020-01-29;
 bh=dYWNGgmeAl6SspuE2kG/Wq0XgAw7ZBa+C5TDYp2sYic=;
 b=tAnrpBkIfvT+vtVQdAVgGCXr6xAwgbdZta4JYzDHzSuuoYljz19+KghUHh3J1tIGd6/u
 wu03llWpJpkj3sqmW493+w4IgpDp1e1r+Wyr6zgCFCQIUDSruYgM4Y+ZGNiIRNHmCm25
 KDRhKJ1JXyFo07UzKwOAnQM2q5+PY8OGULIHjZ6n04UvMlac1yeV+yXCWFxK27axpric
 LF9iaYSiQ4SFKD5a9PBDeQDX4JMOmNxsChIEwny5cAG6LbsPYJQHYu6BhDC5r4j0wPA8
 oVUr+d8QyVzqFDjOo84gUP0ahDjPmDoXbzNdF2iJp5irLt0vQDIaMnjGG9AC1n33Rp/f Tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 35cn9r17ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-nfs@vger.kernel.org>; Sat, 12 Dec 2020 19:16:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BCJA3S8158245
        for <linux-nfs@vger.kernel.org>; Sat, 12 Dec 2020 19:16:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 35cvpvrptk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Sat, 12 Dec 2020 19:16:40 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BCJGd3f005794
        for <linux-nfs@vger.kernel.org>; Sat, 12 Dec 2020 19:16:39 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 12 Dec 2020 11:16:39 -0800
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH RFC] SUNRPC: Handle TCP socket sends with
 kernel_sendpage() again
Date:   Sat, 12 Dec 2020 14:16:38 -0500
References: <160772591937.2046.18355802579143636131.stgit@klimt.1015granger.net>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <160772591937.2046.18355802579143636131.stgit@klimt.1015granger.net>
Message-Id: <729DE950-2D8D-4F14-B4D2-AB34A227F0CB@oracle.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9833 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012120150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9833 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012120150
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 11, 2020, at 5:33 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> Daire Byrne reports a ~50% aggregrate throughput regression on his
> Linux NFS server after commit da1661b93bf4 ("SUNRPC: Teach server to
> use xprt_sock_sendmsg for socket sends"), which replaced
> kernel_send_page() calls in NFSD's socket send path with calls to
> sock_sendmsg() using iov_iter.
>=20
> Investigation showed that tcp_sendmsg() was not using zero-copy to
> send the xdr_buf's bvec pages, but instead was relying on memcpy.
> This means copying every byte of a large NFS READ payload.
>=20
> It looks like TLS sockets do indeed support a ->sendpage method,
> so it's really not necessary to use xprt_sock_sendmsg() to support
> TLS fully on the server. A mechanical reversion of da1661b93bf4 is
> not possible at this point, but we can re-implement the server's
> TCP socket sendmsg path using kernel_sendpage().
>=20
> No Fixes: tag. If needed, please backport this fix by hand.
>=20
> Reported-by: Daire Byrne <daire@dneg.com>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D209439
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> net/sunrpc/svcsock.c |   92 =
++++++++++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 88 insertions(+), 4 deletions(-)
>=20
>=20
> This replaces the SVC zero-copy send patch I posted a couple of
> weeks ago.
>=20
>=20
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index b248f2349437..30332111bd37 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -1062,6 +1062,92 @@ static int svc_tcp_recvfrom(struct svc_rqst =
*rqstp)
> 	return 0;	/* record not complete */
> }
>=20
> +/**
> + * svc_tcp_sendmsg - Send an RPC message on a TCP socket
> + * @sock: socket to write the RPC message onto
> + * @xdr: XDR buffer containing the RPC message
> + * @marker: TCP record marker
> + * @sentp: OUT: number of bytes actually written
> + *
> + * Caller serializes calls on this @sock, and ensures the pages
> + * backing @xdr are unchanging. In addition, it is assumed that
> + * no .bv_len is larger than PAGE_SIZE.
> + *
> + * Returns zero on success or a negative errno value.
> + */
> +static int svc_tcp_sendmsg(struct socket *sock, const struct xdr_buf =
*xdr,
> +			   rpc_fraghdr marker, unsigned int *sentp)
> +{
> +	struct kvec vec[2] =3D {
> +		[0] =3D {
> +			.iov_base	=3D &marker,
> +			.iov_len	=3D sizeof(marker),
> +		},
> +		[1] =3D *xdr->head,
> +	};
> +	size_t len =3D vec[0].iov_len + vec[1].iov_len;
> +	const struct kvec *tail =3D xdr->tail;
> +	struct msghdr msg =3D {
> +		.msg_flags	=3D 0,
> +	};
> +	int ret;
> +
> +	*sentp =3D 0;
> +
> +	/*
> +	 * Optimized for the common case where we have just the record
> +	 * marker and xdr->head.
> +	 */
> +	if (xdr->head[0].iov_len < xdr->len)
> +		msg.msg_flags =3D MSG_MORE;
> +	iov_iter_kvec(&msg.msg_iter, WRITE, vec, ARRAY_SIZE(vec), len);
> +	ret =3D sock_sendmsg(sock, &msg);
> +	if (ret < 0)
> +		return ret;
> +	*sentp +=3D ret;
> +	if (*sentp !=3D len)
> +		goto out;
> +
> +	if (xdr->page_len) {
> +		unsigned int offset, len, remaining;
> +		struct bio_vec *bvec;
> +		int flags, ret;
> +
> +		bvec =3D xdr->bvec;
> +		offset =3D xdr->page_base;
> +		remaining =3D xdr->page_len;
> +		flags =3D MSG_MORE | MSG_SENDPAGE_NOTLAST;
> +		while (remaining > 0) {
> +			if (remaining <=3D PAGE_SIZE && tail->iov_len =3D=3D=
 0)
> +				flags =3D 0;
> +			len =3D min(remaining, bvec->bv_len);
> +			ret =3D kernel_sendpage(sock, bvec->bv_page,
> +						bvec->bv_offset + =
offset,
> +						len, flags);
> +			if (ret < 0)
> +				return ret;
> +			*sentp +=3D ret;
> +			if (ret !=3D len)
> +				goto out;
> +			remaining -=3D len;
> +			offset =3D 0;
> +			bvec++;
> +		}
> +	}
> +
> +	if (tail->iov_len) {
> +		ret =3D kernel_sendpage(sock, =
virt_to_page(tail->iov_base),
> +				      offset_in_page(tail->iov_base),
> +				      tail->iov_len, 0);
> +		if (ret < 0)
> +			return ret;
> +		*sentp +=3D ret;
> +	}
> +
> +out:
> +	return 0;
> +}
> +
> /**
>  * svc_tcp_sendto - Send out a reply on a TCP socket
>  * @rqstp: completed svc_rqst
> @@ -1078,18 +1164,16 @@ static int svc_tcp_sendto(struct svc_rqst =
*rqstp)
> 	struct xdr_buf *xdr =3D &rqstp->rq_res;
> 	rpc_fraghdr marker =3D cpu_to_be32(RPC_LAST_STREAM_FRAGMENT |
> 					 (u32)xdr->len);
> -	struct msghdr msg =3D {
> -		.msg_flags	=3D 0,
> -	};
> 	unsigned int sent;
> 	int err;
>=20
> 	svc_tcp_release_rqst(rqstp);
> +	xdr_alloc_bvec(xdr);

This should be

+	xdr_alloc_bvec(xdr, GFP_KERNEL);


> 	mutex_lock(&xprt->xpt_mutex);
> 	if (svc_xprt_is_dead(xprt))
> 		goto out_notconn;
> -	err =3D xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, marker, =
&sent);
> +	err =3D svc_tcp_sendmsg(svsk->sk_sock, xdr, marker, &sent);
> 	xdr_free_bvec(xdr);
> 	trace_svcsock_tcp_send(xprt, err < 0 ? err : sent);
> 	if (err < 0 || sent !=3D (xdr->len + sizeof(marker)))
>=20
>=20

--
Chuck Lever



