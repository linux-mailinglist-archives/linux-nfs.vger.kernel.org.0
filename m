Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42AABB3CC8
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 16:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfIPOnf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 10:43:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56808 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730509AbfIPOnf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 10:43:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GEdCJn076860;
        Mon, 16 Sep 2019 14:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=Gn0P4yVxofkhsaZeT46suKXlHRyWOI2K1HFcegXJskg=;
 b=KviWZggd2JVJUglMz4ZibEQj5Q/hBDCxctXXI7Y7RPo3CDvzd1ikDo/Ztc2LJQjpjohk
 oB08AjKwjCofYxnSJ/AjaEi5iEIAk22T69WkVyHQfRu9yRdyncDEqyRh8ffgfEn89jvY
 Af1C5eGyvYl27QT9L4+Z7qQl8SDXzB91gYIz8fGpz00oQEzRZzC6CW69zN46RVNJTFcv
 dxRjn8PbZsJjaiu9JAFd4iDfCowDHeCavo7INOkrxuGsyJxlGrb4pqlrUQZKTnNntiFj
 C5SMd85PlmJbKd1x1rIhx69WnAobgMMfgLaO3wJXxpFqfahs3tC+jtxethJS3yzdSeHu Mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2v2bx2r6hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 14:43:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GEc5rb174488;
        Mon, 16 Sep 2019 14:43:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2v0qhpkrpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 14:43:15 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8GEh9wE030116;
        Mon, 16 Sep 2019 14:43:12 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Sep 2019 07:43:08 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V3 1/2] SUNRPC: Fix buffer handling of GSS MIC without
 slack
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <dad661c66dcbfb67714253d55d826ff126e53f50.1568635163.git.bcodding@redhat.com>
Date:   Mon, 16 Sep 2019 10:43:07 -0400
Cc:     trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>, tibbs@math.uh.edu,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>, km@cm4all.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8C53DD2-DB69-4660-943B-1AE059F69CFF@oracle.com>
References: <dad661c66dcbfb67714253d55d826ff126e53f50.1568635163.git.bcodding@redhat.com>
To:     Benjamin Coddington <bcodding@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9381 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909160151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9381 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909160151
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 16, 2019, at 7:59 AM, Benjamin Coddington <bcodding@redhat.com> =
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
> Cc: stable@vger.kernel.org # v5.1

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> net/sunrpc/xdr.c | 27 ++++++++++++++++++---------
> 1 file changed, 18 insertions(+), 9 deletions(-)
>=20
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 48c93b9e525e..b256806d69cd 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -1237,16 +1237,29 @@ xdr_encode_word(struct xdr_buf *buf, unsigned =
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
> +	unsigned int boundary;
>=20
> 	if (xdr_decode_word(buf, offset, &obj->len))
> 		return -EFAULT;
> -	if (xdr_buf_subsegment(buf, &subbuf, offset + 4, obj->len))
> +	offset +=3D 4;
> +
> +	/* Is the obj partially in the head? */
> +	boundary =3D buf->head[0].iov_len;
> +	if (offset < boundary && (offset + obj->len) > boundary)
> +		xdr_shift_buf(buf, boundary - offset);
> +
> +	/* Is the obj partially in the pages? */
> +	boundary +=3D buf->page_len;
> +	if (offset < boundary && (offset + obj->len) > boundary)
> +		xdr_shrink_pagelen(buf, boundary - offset);
> +
> +	if (xdr_buf_subsegment(buf, &subbuf, offset, obj->len))
> 		return -EFAULT;
>=20
> 	/* Is the obj contained entirely in the head? */
> @@ -1258,11 +1271,7 @@ int xdr_buf_read_netobj(struct xdr_buf *buf, =
struct xdr_netobj *obj, unsigned in
> 	if (subbuf.tail[0].iov_len =3D=3D obj->len)
> 		return 0;
>=20
> -	/* use end of tail as storage for obj:
> -	 * (We don't copy to the beginning because then we'd have
> -	 * to worry about doing a potentially overlapping copy.
> -	 * This assumes the object is at most half the length of the
> -	 * tail.) */
> +	/* Find a contiguous area in @buf to hold all of @obj */
> 	if (obj->len > buf->buflen - buf->len)
> 		return -ENOMEM;
> 	if (buf->tail[0].iov_len !=3D 0)
> --=20
> 2.20.1
>=20

--
Chuck Lever



