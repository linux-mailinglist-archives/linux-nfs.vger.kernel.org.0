Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00FC1B2267
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2019 16:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbfIMOmZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Sep 2019 10:42:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35826 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729729AbfIMOmZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Sep 2019 10:42:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DEcnM9026004;
        Fri, 13 Sep 2019 14:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=mh4dqjUFLQmplHhMZ0HIZoanSXA+XGG1R7zJICqYDhs=;
 b=Vx7SC8fpxj0M6AG8wlV2om91yPE3iu5J+dp2X7j8wYMWEJneMXUHQcGSiIx5brqUulVR
 9nNWXgOhGqalWAS3pJgYe6h7HHwx6ZJPCIULjjepZKSYAcsvJh+StklDuxTScV6y2suW
 uu5ecbnfxEdiwqEj1M6vpgj5pP/jnp6fMKMv2FvrYGRynwwi1vh6vVpEB3kDttvJ6Uev
 hrxQggWFbozfJxw8syY8HHC9Mg3+14M1ytoxDTBPbTjpjVfmCw/i1DXJKr6sW0SQ9XqE
 NrMsdEA2/Gd8nelldj0LjE3qiaN94CqJYjh2vrxjjD9H2XpPfaNvzIfjDASQkykMHK69 ZA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2uytd3n4rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Sep 2019 14:42:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DEXrOO030764;
        Fri, 13 Sep 2019 14:42:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2uytdjcr29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Sep 2019 14:42:06 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8DEfqQo023557;
        Fri, 13 Sep 2019 14:41:55 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Sep 2019 07:41:52 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] SUNRPC: Fix buffer handling of GSS MIC with less
 slack
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <043d2ca649c3d81cdf0b43b149cd43069ad1c1e2.1568307763.git.bcodding@redhat.com>
Date:   Fri, 13 Sep 2019 10:41:51 -0400
Cc:     trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>, tibbs@math.uh.edu,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>, km@cm4all.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <181DFFE9-F11A-421A-97FA-E3478B7A8C51@oracle.com>
References: <043d2ca649c3d81cdf0b43b149cd43069ad1c1e2.1568307763.git.bcodding@redhat.com>
To:     Benjamin Coddington <bcodding@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909130146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909130147
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 12, 2019, at 1:07 PM, Benjamin Coddington <bcodding@redhat.com> =
wrote:
>=20
> The GSS Message Integrity Check data for krb5i may lie partially in =
the XDR
> reply buffer's pages and tail.  If so, we try to copy the entire MIC =
into
> free space in the tail.  But as the estimations of the slack space =
required
> for authentication and verification have improved there may be less =
free
> space in the tail to complete this copy -- see commit 2c94b8eca1a2
> ("SUNRPC: Use au_rslack when computing reply buffer size").  In fact, =
there
> may only be room in the tail for a single copy of the MIC, and not =
part of
> the MIC and then another complete copy.
>=20
> The real world failure reported is that `ls` of a directory on NFS may
> sometimes return -EIO, which can be traced back to =
xdr_buf_read_netobj()
> failing to find available free space in the tail to copy the MIC.
>=20
> Fix this by checking for the case of the MIC crossing the boundaries =
of
> head, pages, and tail. If so, shift the buffer until the MIC is =
contained
> completely within the pages or tail.  This allows the remainder of the
> function to create a sub buffer that directly address the complete =
MIC.
>=20
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> Cc: stable@vger.kernel.org

# v5.1 ?


> ---
> net/sunrpc/xdr.c | 45 +++++++++++++++++++++++++++------------------
> 1 file changed, 27 insertions(+), 18 deletions(-)
>=20
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 48c93b9e525e..6e05a9693568 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -1237,39 +1237,48 @@ xdr_encode_word(struct xdr_buf *buf, unsigned =
int base, u32 obj)
> EXPORT_SYMBOL_GPL(xdr_encode_word);
>=20
> /* If the netobj starting offset bytes from the start of xdr_buf is =
contained
> - * entirely in the head or the tail, set object to point to it; =
otherwise
> - * try to find space for it at the end of the tail, copy it there, =
and
> - * set obj to point to it. */
> + * entirely in the head, pages, or tail, set object to point to it; =
otherwise
> + * shift the buffer until it is contained entirely within the pages =
or tail.
> + */
> int xdr_buf_read_netobj(struct xdr_buf *buf, struct xdr_netobj *obj, =
unsigned int offset)
> {
> 	struct xdr_buf subbuf;
> +	unsigned int len_to_boundary;
>=20
> 	if (xdr_decode_word(buf, offset, &obj->len))
> 		return -EFAULT;
> -	if (xdr_buf_subsegment(buf, &subbuf, offset + 4, obj->len))
> +
> +	offset +=3D 4;
> +
> +	/* Is the obj partially in the head? */
> +	len_to_boundary =3D buf->head->iov_len - offset;
> +	if (len_to_boundary > 0 && len_to_boundary < obj->len)
> +		xdr_shift_buf(buf, len_to_boundary);
> +
> +	/* Is the obj partially in the pages? */
> +	len_to_boundary =3D buf->head->iov_len + buf->page_len - offset;
> +	if (len_to_boundary > 0 && len_to_boundary < obj->len)
> +		xdr_shrink_pagelen(buf, len_to_boundary);

Do you need to check if the obj is entirely in ->pages but crosses a =
page boundary?


> +
> +	if (xdr_buf_subsegment(buf, &subbuf, offset, obj->len))
> 		return -EFAULT;
>=20
> -	/* Is the obj contained entirely in the head? */
> -	obj->data =3D subbuf.head[0].iov_base;
> -	if (subbuf.head[0].iov_len =3D=3D obj->len)
> -		return 0;
> -	/* ..or is the obj contained entirely in the tail? */
> +	/* Most likely: is the obj contained entirely in the tail? */
> 	obj->data =3D subbuf.tail[0].iov_base;
> 	if (subbuf.tail[0].iov_len =3D=3D obj->len)
> 		return 0;
>=20
> -	/* use end of tail as storage for obj:
> -	 * (We don't copy to the beginning because then we'd have
> -	 * to worry about doing a potentially overlapping copy.
> -	 * This assumes the object is at most half the length of the
> -	 * tail.) */
> +	/* ..or is the obj contained entirely in the head? */
> +	obj->data =3D subbuf.head[0].iov_base;
> +	if (subbuf.head[0].iov_len =3D=3D obj->len)
> +		return 0;
> +
> +	/* obj is in the pages: move to tail */
> 	if (obj->len > buf->buflen - buf->len)
> 		return -ENOMEM;
> -	if (buf->tail[0].iov_len !=3D 0)
> -		obj->data =3D buf->tail[0].iov_base + =
buf->tail[0].iov_len;
> -	else
> -		obj->data =3D buf->head[0].iov_base + =
buf->head[0].iov_len;
> +	obj->data =3D buf->head[0].iov_base + buf->head[0].iov_len;
> 	__read_bytes_from_xdr_buf(&subbuf, obj->data, obj->len);
> +
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(xdr_buf_read_netobj);
> --=20
> 2.20.1
>=20

--
Chuck Lever



