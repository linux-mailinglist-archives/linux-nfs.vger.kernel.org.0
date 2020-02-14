Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBE8D15F953
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 23:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgBNWUp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 17:20:45 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44176 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbgBNWUp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 17:20:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01EMDJne146658;
        Fri, 14 Feb 2020 22:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=yYFo76qFz3KMj5aDdTrP1abf6VEjSGdEcr5JzwGt02k=;
 b=dLDm9aTUwG2ZBgdh4VXkuWQWyNucxICc7IONs8QoEFegRWDXu5M/Y64H/hiSy1ck/Rs+
 osanqAmLoy+3Q8SDMh3/NxbS52KS5YA0dlOeigzUhfiT9pgJVTCgkhp76BcGdFuanmqT
 98mInUsZF2tJUla1PAsPFDNpWQ7oKwpTLIm99o/v9jjLWsOn9Hukjv3WrWQOasGiYdCW
 TpZ9vUpWh39hBRe5ma52EoFGNdfRF7Xv42YJkCGs7lSol7FvJKNMi4bso82AquWPtVBT
 kf/FqWX4N0ams/9Lgq7rAicWwG14Uv+6KOiOiRqx1MF8W7C6S1H4My30NZrQ6Q5PTLrJ mA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2y2jx6v6px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Feb 2020 22:20:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01EMBwBk165754;
        Fri, 14 Feb 2020 22:20:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2y4k82x7qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Feb 2020 22:20:41 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01EMKdnH030381;
        Fri, 14 Feb 2020 22:20:39 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Feb 2020 14:20:39 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 1/4] NFSD: Return eof and maxcount to
 nfsd4_encode_read()
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200214211206.407725-2-Anna.Schumaker@Netapp.com>
Date:   Fri, 14 Feb 2020 17:20:37 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8293E6BD-F063-4872-848F-93196C87DA02@oracle.com>
References: <20200214211206.407725-1-Anna.Schumaker@Netapp.com>
 <20200214211206.407725-2-Anna.Schumaker@Netapp.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>,
        Bruce Fields <bfields@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9531 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9531 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002140163
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 14, 2020, at 4:12 PM, schumaker.anna@gmail.com wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> I want to reuse nfsd4_encode_readv() and nfsd4_encode_splice_read() in
> READ_PLUS rather than reimplementing them. READ_PLUS returns a single
> eof flag for the entire call and a separate maxcount for each data
> segment, so we need to have the READ call encode these values in a
> different place.

This probably collides pretty nastily with the fix I posted today for
https://bugzilla.kernel.org/show_bug.cgi?id=3D198053 .

Can my fix go in first so that there is still opportunity to backport =
it?


> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
> fs/nfsd/nfs4xdr.c | 60 ++++++++++++++++++++---------------------------
> 1 file changed, 26 insertions(+), 34 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 9761512674a0..45f0623f6488 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3521,23 +3521,22 @@ nfsd4_encode_open_downgrade(struct =
nfsd4_compoundres *resp, __be32 nfserr, struc
>=20
> static __be32 nfsd4_encode_splice_read(
> 				struct nfsd4_compoundres *resp,
> -				struct nfsd4_read *read,
> -				struct file *file, unsigned long =
maxcount)
> +				struct nfsd4_read *read, struct file =
*file,
> +				unsigned long *maxcount, u32 *eof)
> {
> 	struct xdr_stream *xdr =3D &resp->xdr;
> 	struct xdr_buf *buf =3D xdr->buf;
> -	u32 eof;
> +	long len;
> 	int space_left;
> 	__be32 nfserr;
> -	__be32 *p =3D xdr->p - 2;
>=20
> 	/* Make sure there will be room for padding if needed */
> 	if (xdr->end - xdr->p < 1)
> 		return nfserr_resource;
>=20
> +	len =3D *maxcount;
> 	nfserr =3D nfsd_splice_read(read->rd_rqstp, read->rd_fhp,
> -				  file, read->rd_offset, &maxcount, =
&eof);
> -	read->rd_length =3D maxcount;
> +				  file, read->rd_offset, maxcount, eof);
> 	if (nfserr) {
> 		/*
> 		 * nfsd_splice_actor may have already messed with the
> @@ -3548,24 +3547,21 @@ static __be32 nfsd4_encode_splice_read(
> 		return nfserr;
> 	}
>=20
> -	*(p++) =3D htonl(eof);
> -	*(p++) =3D htonl(maxcount);
> -
> -	buf->page_len =3D maxcount;
> -	buf->len +=3D maxcount;
> -	xdr->page_ptr +=3D (buf->page_base + maxcount + PAGE_SIZE - 1)
> +	buf->page_len =3D *maxcount;
> +	buf->len +=3D *maxcount;
> +	xdr->page_ptr +=3D (buf->page_base + *maxcount + PAGE_SIZE - 1)
> 							/ PAGE_SIZE;
>=20
> 	/* Use rest of head for padding and remaining ops: */
> 	buf->tail[0].iov_base =3D xdr->p;
> 	buf->tail[0].iov_len =3D 0;
> 	xdr->iov =3D buf->tail;
> -	if (maxcount&3) {
> -		int pad =3D 4 - (maxcount&3);
> +	if (*maxcount&3) {
> +		int pad =3D 4 - (*maxcount&3);
>=20
> 		*(xdr->p++) =3D 0;
>=20
> -		buf->tail[0].iov_base +=3D maxcount&3;
> +		buf->tail[0].iov_base +=3D *maxcount&3;
> 		buf->tail[0].iov_len =3D pad;
> 		buf->len +=3D pad;
> 	}
> @@ -3579,22 +3575,20 @@ static __be32 nfsd4_encode_splice_read(
> }
>=20
> static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
> -				 struct nfsd4_read *read,
> -				 struct file *file, unsigned long =
maxcount)
> +				 struct nfsd4_read *read, struct file =
*file,
> +				 unsigned long *maxcount, u32 *eof)
> {
> 	struct xdr_stream *xdr =3D &resp->xdr;
> -	u32 eof;
> 	int v;
> 	int starting_len =3D xdr->buf->len - 8;
> 	long len;
> 	int thislen;
> 	__be32 nfserr;
> -	__be32 tmp;
> 	__be32 *p;
> 	u32 zzz =3D 0;
> 	int pad;
>=20
> -	len =3D maxcount;
> +	len =3D *maxcount;
> 	v =3D 0;
>=20
> 	thislen =3D min_t(long, len, ((void *)xdr->end - (void =
*)xdr->p));
> @@ -3616,22 +3610,15 @@ static __be32 nfsd4_encode_readv(struct =
nfsd4_compoundres *resp,
> 	}
> 	read->rd_vlen =3D v;
>=20
> -	len =3D maxcount;
> +	len =3D *maxcount;
> 	nfserr =3D nfsd_readv(resp->rqstp, read->rd_fhp, file, =
read->rd_offset,
> -			    resp->rqstp->rq_vec, read->rd_vlen, =
&maxcount,
> -			    &eof);
> -	read->rd_length =3D maxcount;
> +			    resp->rqstp->rq_vec, read->rd_vlen, =
maxcount, eof);
> 	if (nfserr)
> 		return nfserr;
> -	xdr_truncate_encode(xdr, starting_len + 8 + ((maxcount+3)&~3));
> +	xdr_truncate_encode(xdr, starting_len + 8 + ((*maxcount+3)&~3));
>=20
> -	tmp =3D htonl(eof);
> -	write_bytes_to_xdr_buf(xdr->buf, starting_len    , &tmp, 4);
> -	tmp =3D htonl(maxcount);
> -	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
> -
> -	pad =3D (maxcount&3) ? 4 - (maxcount&3) : 0;
> -	write_bytes_to_xdr_buf(xdr->buf, starting_len + 8 + maxcount,
> +	pad =3D (*maxcount&3) ? 4 - (*maxcount&3) : 0;
> +	write_bytes_to_xdr_buf(xdr->buf, starting_len + 8 + *maxcount,
> 								&zzz, =
pad);
> 	return 0;
>=20
> @@ -3642,6 +3629,7 @@ nfsd4_encode_read(struct nfsd4_compoundres =
*resp, __be32 nfserr,
> 		  struct nfsd4_read *read)
> {
> 	unsigned long maxcount;
> +	u32 eof;
> 	struct xdr_stream *xdr =3D &resp->xdr;
> 	struct file *file;
> 	int starting_len =3D xdr->buf->len;
> @@ -3670,13 +3658,17 @@ nfsd4_encode_read(struct nfsd4_compoundres =
*resp, __be32 nfserr,
>=20
> 	if (file->f_op->splice_read &&
> 	    test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags))
> -		nfserr =3D nfsd4_encode_splice_read(resp, read, file, =
maxcount);
> +		nfserr =3D nfsd4_encode_splice_read(resp, read, file, =
&maxcount, &eof);
> 	else
> -		nfserr =3D nfsd4_encode_readv(resp, read, file, =
maxcount);
> +		nfserr =3D nfsd4_encode_readv(resp, read, file, =
&maxcount, &eof);
>=20
> 	if (nfserr)
> 		xdr_truncate_encode(xdr, starting_len);
>=20
> +	read->rd_length =3D maxcount;
> +	*p++ =3D htonl(eof);
> +	*p++ =3D htonl(maxcount);
> +
> 	return nfserr;
> }
>=20
> --=20
> 2.25.0
>=20

--
Chuck Lever



