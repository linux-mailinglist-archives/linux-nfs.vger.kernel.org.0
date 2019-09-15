Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6078B30E7
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Sep 2019 18:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbfIOQnt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 15 Sep 2019 12:43:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58690 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIOQnt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 15 Sep 2019 12:43:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8FGdQMj085430;
        Sun, 15 Sep 2019 16:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=IF9M7howY//f3gTh8pNza4bDL73ndVmSxf9vdMqytJ8=;
 b=EPxh35fpHIvRDNVKYCYDVMfx6kS+D9q5+QbOfJ9v2GI6isANQxTSQtP+vqlVgJysNrJ+
 B5l4iE4rUIJCqaiCprWHKi4S/VAMYFKuHb7yC/PODWSAzm9sO5/Siw3HbfC9tuwvNd0A
 h3nXB49jq/ugaCtg8XUdbWz7AcwNRKNAnZq9dHgIHKtTgTiOBVxQFgFram4gypunKwTJ
 /kuBGKfjG7O0cThgsIRqgAzXHxbpl73Y+G+qjTRR77qS/tAfN92zfT83/a+LLH9ZYW98
 8fl19QbXwhNoRqhuH5Fsz2gBvQYHZ6gee/N7mtxiGMq6qrjSLuiCWqrQnikG2aKOuPtN Kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2v0qmt3ycb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 Sep 2019 16:43:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8FGhBdE056378;
        Sun, 15 Sep 2019 16:43:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2v0p8tm5b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 Sep 2019 16:43:18 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8FGhBur021916;
        Sun, 15 Sep 2019 16:43:14 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 15 Sep 2019 09:43:06 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 1/2] SUNRPC: Fix buffer handling of GSS MIC without
 slack
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <9f9848f4cbb03b09c7f28f8a43fb27120703ae49.1568557832.git.bcodding@redhat.com>
Date:   Sun, 15 Sep 2019 12:43:05 -0400
Cc:     trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>, tibbs@math.uh.edu,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>, km@cm4all.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8350AC46-9CFA-410D-AC0C-EF2ACE24FD74@oracle.com>
References: <9f9848f4cbb03b09c7f28f8a43fb27120703ae49.1568557832.git.bcodding@redhat.com>
To:     Benjamin Coddington <bcodding@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9381 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909150182
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9381 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909150181
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Ben-


> On Sep 15, 2019, at 11:41 AM, Benjamin Coddington =
<bcodding@redhat.com> wrote:
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
> ---
> net/sunrpc/xdr.c | 32 +++++++++++++++++++-------------
> 1 file changed, 19 insertions(+), 13 deletions(-)
>=20
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 48c93b9e525e..a29ce73c3029 100644
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
> @@ -1258,17 +1271,10 @@ int xdr_buf_read_netobj(struct xdr_buf *buf, =
struct xdr_netobj *obj, unsigned in
> 	if (subbuf.tail[0].iov_len =3D=3D obj->len)
> 		return 0;
>=20
> -	/* use end of tail as storage for obj:
> -	 * (We don't copy to the beginning because then we'd have
> -	 * to worry about doing a potentially overlapping copy.
> -	 * This assumes the object is at most half the length of the
> -	 * tail.) */
> +	/* obj is in the pages: move to end of the tail */

How about "/* Find a contiguous area in @buf to hold all of @obj */" ?


> 	if (obj->len > buf->buflen - buf->len)
> 		return -ENOMEM;
> -	if (buf->tail[0].iov_len !=3D 0)
> -		obj->data =3D buf->tail[0].iov_base + =
buf->tail[0].iov_len;
> -	else
> -		obj->data =3D buf->head[0].iov_base + =
buf->head[0].iov_len;
> +	obj->data =3D buf->tail[0].iov_base + buf->tail[0].iov_len;

Your new code assumes that when krb5i is in use, the upper layer will =
always
provide a non-NULL tail->iov_len. I wouldn't swear that will always be =
true:
The reason for the "if (buf->tail[0].iov_len)" check is to see whether =
the
upper layer indeed has set up a tail. iov_len will be non-zero only when =
the
upper layer has provided a tail buffer.


> we can definitely keep the check, but
> the second half of the statement also assumes a contiguous head/tail =
range.

Well, it assumes that there is space in the head buffer after its end. =
That's
not necessarily the tail. Are we sure that in the post-35e77d21baa0 =
world
there will always be enough space after head->iov_len?

A reasonable test here would be to enable SLUB poisoning and and try =
some
complex workloads on an NFSv4 krb5i mount.


> I think it's safe to just remove the test altogether and place the =
netobj at
> the end of the tail.


I'm not convinced :-) I'd like to see more justification for this claim.

This is why in the long run we are better off using a scratch buffer =
instead
of finding a spot in @buf. The rules about how the rq_rcv_buf is set up =
are
gray; this function makes a lot of "clever" assumptions about that, and =
that
makes this logic quite brittle.

Now that we have an xdr_stream in gss_unwrap_resp_integ(), I wonder if =
you
could use the stream's scratch xdr_buf. If not, a kmalloc should do the =
trick.


> 	__read_bytes_from_xdr_buf(&subbuf, obj->data, obj->len);
> 	return 0;
> }
> --=20
> 2.20.1
>=20

--
Chuck Lever



