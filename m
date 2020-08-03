Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E908A23ACE6
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 21:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHCTVV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 15:21:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47294 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHCTVV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 15:21:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073J7v2T131164;
        Mon, 3 Aug 2020 19:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=dCo0Z+4LVp8knWvtc/NzEC0AbW1ZkshkrHV50i5XXbs=;
 b=QzT/uwC9/kHSGUXlnSu+vqVDwmGItCEw/IhkUg0msze3H7HNbYASJ7tZ/38rGOPRLS3r
 B7gOKqrjWWzBR0++yOHqvU6V1Lv+NRualzd18l9eqoehaXTa2LNeX9lVDdpY2Qdve+rJ
 HEWYBXuYZRTYvlFEAyg64HPGzDpChYnnUE8puc5nv9jTiia5Xn9TzyWd6rvRzESSBsrk
 3IvaBGMqaNwsCpKsFPyhTPFvRgssaZvARXkThr2cF7WnMcCdbHEyLn2GCQ76tFsnr/TZ
 gfA2rW9nzB4rsd3vqMsKztLgN9ocHOILQmsP/ZJGHarUPlOSB5fiz9J258eV23XgJVH1 Mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 32nc9yewr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 19:21:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073J8n8C150152;
        Mon, 3 Aug 2020 19:19:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 32pdnnt52w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 19:19:16 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 073JJFip004561;
        Mon, 3 Aug 2020 19:19:15 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Aug 2020 12:19:15 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 1/6] SUNRPC: Implement xdr_reserve_space_vec()
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200803165954.1348263-2-Anna.Schumaker@Netapp.com>
Date:   Mon, 3 Aug 2020 15:19:14 -0400
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DEB91DA9-0DCE-4C95-8B87-D8167AB57F65@oracle.com>
References: <20200803165954.1348263-1-Anna.Schumaker@Netapp.com>
 <20200803165954.1348263-2-Anna.Schumaker@Netapp.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030133
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna-

> On Aug 3, 2020, at 12:59 PM, schumaker.anna@gmail.com wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> Reserving space for a large READ payload requires special handling =
when
> reserving space in the xdr buffer pages. One problem we can have is =
use
> of the scratch buffer, which is used to get a pointer to a contiguous
> region of data up to PAGE_SIZE. When using the scratch buffer, calls =
to
> xdr_commit_encode() shift the data to it's proper alignment in the xdr
> buffer. If we've reserved several pages in a vector, then this could
> potentially invalidate earlier pointers and result in incorrect READ
> data being sent to the client.
>=20
> I get around this by looking at the amount of space left in the =
current
> page, and never reserve more than that for each entry in the read
> vector. This lets us place data directly where it needs to go in the
> buffer pages.

Nit: This appears to be a refactoring change that should be squashed
together with 2/6.


> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
> include/linux/sunrpc/xdr.h |  2 ++
> net/sunrpc/xdr.c           | 45 ++++++++++++++++++++++++++++++++++++++
> 2 files changed, 47 insertions(+)
>=20
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index 22c207b2425f..bac459584dd0 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -234,6 +234,8 @@ typedef int	(*kxdrdproc_t)(struct rpc_rqst =
*rqstp, struct xdr_stream *xdr,
> extern void xdr_init_encode(struct xdr_stream *xdr, struct xdr_buf =
*buf,
> 			    __be32 *p, struct rpc_rqst *rqst);
> extern __be32 *xdr_reserve_space(struct xdr_stream *xdr, size_t =
nbytes);
> +extern int xdr_reserve_space_vec(struct xdr_stream *xdr, struct kvec =
*vec,
> +		size_t nbytes);
> extern void xdr_commit_encode(struct xdr_stream *xdr);
> extern void xdr_truncate_encode(struct xdr_stream *xdr, size_t len);
> extern int xdr_restrict_buflen(struct xdr_stream *xdr, int newbuflen);
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index be11d672b5b9..6dfe5dc8b35f 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -648,6 +648,51 @@ __be32 * xdr_reserve_space(struct xdr_stream =
*xdr, size_t nbytes)
> }
> EXPORT_SYMBOL_GPL(xdr_reserve_space);
>=20
> +
> +/**
> + * xdr_reserve_space_vec - Reserves a large amount of buffer space =
for sending
> + * @xdr: pointer to xdr_stream
> + * @vec: pointer to a kvec array
> + * @nbytes: number of bytes to reserve
> + *
> + * Reserves enough buffer space to encode 'nbytes' of data and stores =
the
> + * pointers in 'vec'. The size argument passed to xdr_reserve_space() =
is
> + * determined based on the number of bytes remaining in the current =
page to
> + * avoid invalidating iov_base pointers when xdr_commit_encode() is =
called.
> + */
> +int xdr_reserve_space_vec(struct xdr_stream *xdr, struct kvec *vec, =
size_t nbytes)
> +{
> +	int thislen;
> +	int v =3D 0;
> +	__be32 *p;
> +
> +	/*
> +	 * svcrdma requires every READ payload to start somewhere
> +	 * in xdr->pages.
> +	 */
> +	if (xdr->iov =3D=3D xdr->buf->head) {
> +		xdr->iov =3D NULL;
> +		xdr->end =3D xdr->p;
> +	}
> +
> +	while (nbytes) {
> +		thislen =3D xdr->buf->page_len % PAGE_SIZE;
> +		thislen =3D min_t(size_t, nbytes, PAGE_SIZE - thislen);
> +
> +		p =3D xdr_reserve_space(xdr, thislen);
> +		if (!p)
> +			return -EIO;
> +
> +		vec[v].iov_base =3D p;
> +		vec[v].iov_len =3D thislen;
> +		v++;
> +		nbytes -=3D thislen;
> +	}
> +
> +	return v;
> +}
> +EXPORT_SYMBOL_GPL(xdr_reserve_space_vec);
> +
> /**
>  * xdr_truncate_encode - truncate an encode buffer
>  * @xdr: pointer to xdr_stream
> --=20
> 2.27.0
>=20

--
Chuck Lever



