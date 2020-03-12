Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C35C6183949
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2020 20:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgCLTQr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Mar 2020 15:16:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50464 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgCLTQr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Mar 2020 15:16:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CJAbVo109887;
        Thu, 12 Mar 2020 19:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=y1C4u9zps73iIvoAV3Ub4xxRUBh5orzZRykmHhL8rsI=;
 b=s/GGOiVph76xfEmxIALKuf6bhbc5neXNJN98aPUmOxDab3DbH4KMj40/XKJ8xEOvKD9s
 vCDOkIDqDWowemiPUjWebAureDh6/BHkAIH5Q4EAPB0AwB0o1YRTLTFre0PX8fKimqab
 fUanxI4rOnDxXg7hRrlTuqMdZR7mN8A91Q4hjIORo7nd5bYyNG0MXllxNusbGCQ4aQUv
 4/vAxRfqF7sLyVxhZnohrlzFxfiiulm/QQRyPwPzxmA2ECNqLQgNioVhQ/G+JaJNB753
 lf0VnTxG6TSWWcw8uxx4fvMFUPOw1K16w/Od619nsEmcM7c0XhoXd5/zTxZ8JvQ3PWl8 ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2yqtag88x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 19:16:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CJ8555150255;
        Thu, 12 Mar 2020 19:16:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2yqta9b2fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 19:16:41 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02CJGcIa004174;
        Thu, 12 Mar 2020 19:16:39 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Mar 2020 12:16:38 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 11/14] nfsd: add user xattr RPC XDR encoding/decoding
 logic
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200311195954.27117-12-fllinden@amazon.com>
Date:   Thu, 12 Mar 2020 15:16:37 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6955728A-CFCC-40FC-9E02-671255EDD45F@oracle.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
 <20200311195954.27117-12-fllinden@amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003120095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003120095
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 11, 2020, at 3:59 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> Add functions to calculate the reply size for the user extended =
attribute
> operations, and implement the XDR encode / decode logic for these
> operations.
>=20
> Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> ---
> fs/nfsd/nfs4proc.c |  36 +++++
> fs/nfsd/nfs4xdr.c  | 448 =
+++++++++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 484 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index a76b9025a357..44d488bdebd9 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2778,6 +2778,42 @@ static inline u32 nfsd4_seek_rsize(struct =
svc_rqst *rqstp, struct nfsd4_op *op)
> 	return (op_encode_hdr_size + 3) * sizeof(__be32);
> }
>=20
> +static inline u32 nfsd4_getxattr_rsize(struct svc_rqst *rqstp,
> +				       struct nfsd4_op *op)
> +{
> +	u32 maxcount, rlen;
> +
> +	maxcount =3D svc_max_payload(rqstp);
> +	rlen =3D min_t(u32, XATTR_SIZE_MAX, maxcount);
> +
> +	return (op_encode_hdr_size + 1 + XDR_QUADLEN(rlen)) * =
sizeof(__be32);
> +}
> +
> +static inline u32 nfsd4_setxattr_rsize(struct svc_rqst *rqstp,
> +				       struct nfsd4_op *op)
> +{
> +	return (op_encode_hdr_size + op_encode_change_info_maxsz)
> +		* sizeof(__be32);
> +}
> +static inline u32 nfsd4_listxattrs_rsize(struct svc_rqst *rqstp,
> +					 struct nfsd4_op *op)
> +{
> +	u32 maxcount, rlen;
> +
> +	maxcount =3D svc_max_payload(rqstp);
> +	rlen =3D min(op->u.listxattrs.lsxa_maxcount, maxcount);
> +
> +	return (op_encode_hdr_size + 4 + XDR_QUADLEN(rlen)) * =
sizeof(__be32);
> +}
> +
> +static inline u32 nfsd4_removexattr_rsize(struct svc_rqst *rqstp,
> +					  struct nfsd4_op *op)
> +{
> +	return (op_encode_hdr_size + op_encode_change_info_maxsz)
> +		* sizeof(__be32);
> +}
> +
> +
> static const struct nfsd4_operation nfsd4_ops[LAST_NFS4_OP + 1] =3D {
> 	[OP_ACCESS] =3D {
> 		.op_func =3D nfsd4_access,
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index b12d7ac6f52c..41c8b95ca1c5 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -1879,6 +1879,224 @@ nfsd4_decode_seek(struct nfsd4_compoundargs =
*argp, struct nfsd4_seek *seek)
> 	DECODE_TAIL;
> }
>=20
> +/*
> + * XDR data that is more than PAGE_SIZE in size is normally part of a
> + * read or write. However, the size of extended attributes is limited
> + * by the maximum request size, and then further limited by the =
underlying
> + * filesystem limits. This can exceed PAGE_SIZE (currently, =
XATTR_SIZE_MAX
> + * is 64k). Since there is no kvec- or page-based interface to =
xattrs,
> + * and we're not dealing with contiguous pages, we need to do some =
copying.
> + */
> +
> +/*
> + * Decode int to buffer.

"int" is of course a C keyword, so this typo had me confused!
I think you mean "Decode into buffer."


> Uses head and pages constructed by
> + * svcxdr_construct_vector.
> + */
> +static int
> +nfsd4_vbuf_from_stream(struct nfsd4_compoundargs *argp, struct kvec =
*head,
> +		       struct page **pages, char **bufp, u32 buflen)
> +{
> +	char *tmp, *dp;
> +	u32 len;
> +
> +	if (buflen <=3D head->iov_len) {
> +		/*
> +		 * We're in luck, the head has enough space. Just return
> +		 * the head, no need for copying.
> +		 */
> +		*bufp =3D head->iov_base;
> +		return 0;
> +	}
> +
> +	tmp =3D svcxdr_tmpalloc(argp, buflen);
> +	if (tmp =3D=3D NULL)
> +		return nfserr_jukebox;
> +
> +	dp =3D tmp;
> +	memcpy(dp, head->iov_base, head->iov_len);
> +	buflen -=3D head->iov_len;
> +	dp +=3D head->iov_len;
> +
> +	while (buflen > 0) {
> +		len =3D min_t(u32, buflen, PAGE_SIZE);
> +		memcpy(dp, page_address(*pages), len);
> +
> +		buflen -=3D len;
> +		dp +=3D len;
> +		pages++;
> +	}
> +
> +	*bufp =3D tmp;
> +	return 0;
> +}
> +
> +/*
> + * Get a user extended attribute name from the XDR buffer.
> + * It will not have the "user." prefix, so prepend it.
> + * Lastly, check for nul characters in the name.
> + */
> +static int
> +nfsd4_decode_xattr_name(struct nfsd4_compoundargs *argp, char =
**namep)
> +{
> +	DECODE_HEAD;
> +	char *name, *sp, *dp;
> +	u32 namelen, cnt;
> +
> +	READ_BUF(4);
> +	namelen =3D be32_to_cpup(p++);
> +
> +	if (namelen > (XATTR_NAME_MAX - XATTR_USER_PREFIX_LEN))
> +		return nfserr_nametoolong;
> +
> +	if (namelen =3D=3D 0)
> +		goto xdr_error;
> +
> +	READ_BUF(namelen);
> +
> +	name =3D svcxdr_tmpalloc(argp, namelen + XATTR_USER_PREFIX_LEN + =
1);
> +	if (!name)
> +		return nfserr_jukebox;
> +
> +	memcpy(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN);
> +
> +	/*
> +	 * Copy the extended attribute name over while checking for 0
> +	 * characters.
> +	 */
> +	sp =3D (char *)p;
> +	dp =3D name + XATTR_USER_PREFIX_LEN;
> +	cnt =3D namelen;
> +
> +	while (cnt-- > 0) {
> +		if (*sp =3D=3D '\0')
> +			goto xdr_error;
> +		*dp++ =3D *sp++;
> +	}
> +	*dp =3D '\0';
> +
> +	*namep =3D name;
> +
> +	DECODE_TAIL;
> +}
> +
> +/*
> + * A GETXATTR op request comes without a length specifier. We just =
set the
> + * maximum length for the reply based on XATTR_SIZE_MAX and the =
maximum
> + * channel reply size, allocate a buffer of that length and pass it =
to
> + * vfs_getxattr.
> + */
> +static __be32
> +nfsd4_decode_getxattr(struct nfsd4_compoundargs *argp,
> +		      struct nfsd4_getxattr *getxattr)
> +{
> +	int status;
> +	u32 maxcount;
> +
> +	status =3D nfsd4_decode_xattr_name(argp, &getxattr->getxa_name);
> +	if (status)
> +		return status;
> +
> +	maxcount =3D svc_max_payload(argp->rqstp);
> +	maxcount =3D min_t(u32, XATTR_SIZE_MAX, maxcount);
> +
> +	getxattr->getxa_buf =3D svcxdr_tmpalloc(argp, maxcount);
> +	if (!getxattr->getxa_buf)
> +		status =3D nfserr_jukebox;
> +	getxattr->getxa_len =3D maxcount;
> +
> +	return status;
> +}
> +
> +static __be32
> +nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
> +		      struct nfsd4_setxattr *setxattr)
> +{
> +	DECODE_HEAD;
> +	u32 flags, maxcount, size;
> +	struct kvec head;
> +	struct page **pagelist;
> +
> +	READ_BUF(4);
> +	flags =3D be32_to_cpup(p++);
> +
> +	if (flags > SETXATTR4_REPLACE)
> +		return nfserr_inval;
> +	setxattr->setxa_flags =3D flags;
> +
> +	status =3D nfsd4_decode_xattr_name(argp, &setxattr->setxa_name);
> +	if (status)
> +		return status;
> +
> +	maxcount =3D svc_max_payload(argp->rqstp);
> +	maxcount =3D min_t(u32, XATTR_SIZE_MAX, maxcount);
> +
> +	READ_BUF(4);
> +	size =3D be32_to_cpup(p++);
> +	if (size > maxcount)
> +		return nfserr_xattr2big;
> +
> +	setxattr->setxa_len =3D size;
> +	if (size > 0) {
> +		status =3D svcxdr_construct_vector(argp, &head, =
&pagelist, size);
> +		if (status)
> +			return status;
> +
> +		status =3D nfsd4_vbuf_from_stream(argp, &head, pagelist,
> +		    &setxattr->setxa_buf, size);
> +	}

Now I'm wondering if read_bytes_from_xdr_buf() might be adequate
for this purpose, so you can avoid open-coding all of this logic.


> +
> +	DECODE_TAIL;
> +}
> +
> +static __be32
> +nfsd4_decode_listxattrs(struct nfsd4_compoundargs *argp,
> +			struct nfsd4_listxattrs *listxattrs)
> +{
> +	DECODE_HEAD;
> +	u32 maxcount;
> +
> +	READ_BUF(12);
> +	p =3D xdr_decode_hyper(p, &listxattrs->lsxa_cookie);
> +
> +	/*
> +	 * If the cookie  is too large to have even one user.x attribute
> +	 * plus trailing '\0' left in a maximum size buffer, it's =
invalid.
> +	 */
> +	if (listxattrs->lsxa_cookie >=3D
> +	    (XATTR_LIST_MAX / (XATTR_USER_PREFIX_LEN + 2)))
> +		return nfserr_badcookie;
> +
> +	maxcount =3D be32_to_cpup(p++);
> +	if (maxcount < 8)
> +		/* Always need at least 2 words (length and one =
character) */
> +		return nfserr_inval;
> +
> +	maxcount =3D min(maxcount, svc_max_payload(argp->rqstp));
> +	listxattrs->lsxa_maxcount =3D maxcount;
> +
> +	/*
> +	 * Unfortunately, there is no interface to only list xattrs for
> +	 * one prefix. So there is no good way to convert maxcount to
> +	 * a maximum value to pass to vfs_listxattr, as we don't know
> +	 * how many of the returned attributes will be user attributes.
> +	 *
> +	 * So, always ask vfs_listxattr for the maximum size, and encode
> +	 * as many as possible.
> +	 */
> +	listxattrs->lsxa_buf =3D svcxdr_tmpalloc(argp, XATTR_LIST_MAX);
> +	if (!listxattrs->lsxa_buf)
> +		status =3D nfserr_jukebox;
> +
> +	DECODE_TAIL;
> +}
> +
> +static __be32
> +nfsd4_decode_removexattr(struct nfsd4_compoundargs *argp,
> +			 struct nfsd4_removexattr *removexattr)
> +{
> +	return nfsd4_decode_xattr_name(argp, &removexattr->rmxa_name);
> +}
> +
> static __be32
> nfsd4_decode_noop(struct nfsd4_compoundargs *argp, void *p)
> {
> @@ -1975,6 +2193,11 @@ static const nfsd4_dec nfsd4_dec_ops[] =3D {
> 	[OP_SEEK]		=3D (nfsd4_dec)nfsd4_decode_seek,
> 	[OP_WRITE_SAME]		=3D (nfsd4_dec)nfsd4_decode_notsupp,
> 	[OP_CLONE]		=3D (nfsd4_dec)nfsd4_decode_clone,
> +	/* RFC 8276 extended atributes operations */
> +	[OP_GETXATTR]		=3D (nfsd4_dec)nfsd4_decode_getxattr,
> +	[OP_SETXATTR]		=3D (nfsd4_dec)nfsd4_decode_setxattr,
> +	[OP_LISTXATTRS]		=3D (nfsd4_dec)nfsd4_decode_listxattrs,
> +	[OP_REMOVEXATTR]	=3D (nfsd4_dec)nfsd4_decode_removexattr,
> };
>=20
> static inline bool
> @@ -4458,6 +4681,225 @@ nfsd4_encode_noop(struct nfsd4_compoundres =
*resp, __be32 nfserr, void *p)
> 	return nfserr;
> }
>=20
> +/*
> + * Encode kmalloc-ed buffer in to XDR stream.
> + */
> +static int
> +nfsd4_vbuf_to_stream(struct xdr_stream *xdr, char *buf, u32 buflen)
> +{
> +	u32 cplen;
> +	__be32 *p;
> +
> +	cplen =3D min_t(unsigned long, buflen,
> +		      ((void *)xdr->end - (void *)xdr->p));
> +	p =3D xdr_reserve_space(xdr, cplen);
> +	if (!p)
> +		return nfserr_resource;
> +
> +	memcpy(p, buf, cplen);
> +	buf +=3D cplen;
> +	buflen -=3D cplen;
> +
> +	while (buflen) {
> +		cplen =3D min_t(u32, buflen, PAGE_SIZE);
> +		p =3D xdr_reserve_space(xdr, cplen);
> +		if (!p)
> +			return nfserr_resource;
> +
> +		memcpy(p, buf, cplen);
> +
> +		if (cplen < PAGE_SIZE) {
> +			/*
> +			 * We're done, with a length that wasn't page
> +			 * aligned, so possibly not word aligned. Pad
> +			 * any trailing bytes with 0.
> +			 */
> +			xdr_encode_opaque_fixed(p, NULL, cplen);
> +			break;
> +		}
> +
> +		buflen -=3D PAGE_SIZE;
> +		buf +=3D PAGE_SIZE;
> +	}
> +
> +	return 0;
> +}
> +
> +static __be32
> +nfsd4_encode_getxattr(struct nfsd4_compoundres *resp, __be32 nfserr,
> +		      struct nfsd4_getxattr *getxattr)
> +{
> +	struct xdr_stream *xdr =3D &resp->xdr;
> +	__be32 *p;
> +
> +	p =3D xdr_reserve_space(xdr, 4);
> +	if (!p)
> +		return nfserr_resource;
> +
> +	*p =3D cpu_to_be32(getxattr->getxa_len);
> +
> +	if (getxattr->getxa_len =3D=3D 0)
> +		return 0;
> +
> +	return nfsd4_vbuf_to_stream(xdr, getxattr->getxa_buf,
> +				    getxattr->getxa_len);
> +}
> +
> +static __be32
> +nfsd4_encode_setxattr(struct nfsd4_compoundres *resp, __be32 nfserr,
> +		      struct nfsd4_setxattr *setxattr)
> +{
> +	struct xdr_stream *xdr =3D &resp->xdr;
> +	__be32 *p;
> +
> +	p =3D xdr_reserve_space(xdr, 20);
> +	if (!p)
> +		return nfserr_resource;
> +
> +	encode_cinfo(p, &setxattr->setxa_cinfo);
> +
> +	return 0;
> +}
> +
> +/*
> + * See if there are cookie values that can be rejected outright.
> + */
> +static int
> +nfsd4_listxattr_validate_cookie(struct nfsd4_listxattrs *listxattrs,
> +				u32 *offsetp)
> +{
> +	u64 cookie =3D listxattrs->lsxa_cookie;
> +
> +	/*
> +	 * If the cookie is larger than the maximum number we can fit
> +	 * in either the buffer we just got back from vfs_listxattr, or,
> +	 * XDR-encoded, in the return buffer, it's invalid.
> +	 */
> +	if (cookie > (listxattrs->lsxa_len) / (XATTR_USER_PREFIX_LEN + =
2))
> +		return nfserr_badcookie;
> +
> +	if (cookie > (listxattrs->lsxa_maxcount /
> +		      (XDR_QUADLEN(XATTR_USER_PREFIX_LEN + 2) + 4)))
> +		return nfserr_badcookie;
> +
> +	*offsetp =3D (u32)cookie;
> +	return 0;
> +}
> +
> +static __be32
> +nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 =
nfserr,
> +			struct nfsd4_listxattrs *listxattrs)
> +{
> +	struct xdr_stream *xdr =3D &resp->xdr;
> +	u32 cookie_offset, count_offset, eof;
> +	u32 left, xdrleft, slen, count;
> +	u32 xdrlen, offset;
> +	u64 cookie;
> +	char *sp;
> +	int status;
> +	__be32 *p;
> +	u32 nuser;
> +
> +	eof =3D 1;
> +
> +	status =3D nfsd4_listxattr_validate_cookie(listxattrs, &offset);
> +	if (status)
> +		return status;
> +
> +	/*
> +	 * Reserve space for the cookie and the name array count. Record
> +	 * the offsets to save them later.
> +	 */
> +	cookie_offset =3D xdr->buf->len;
> +	count_offset =3D cookie_offset + 8;
> +	p =3D xdr_reserve_space(xdr, 12);
> +	if (!p)
> +		return nfserr_resource;
> +
> +	count =3D 0;
> +	left =3D listxattrs->lsxa_len;
> +	sp =3D listxattrs->lsxa_buf;
> +	nuser =3D 0;
> +
> +	xdrleft =3D listxattrs->lsxa_maxcount;
> +
> +	while (left > 0 && xdrleft > 0) {
> +		slen =3D strlen(sp);
> +
> +		/*
> +		 * Check if this a user. attribute, skip it if not.
> +		 */
> +		if (strncmp(sp, XATTR_USER_PREFIX, =
XATTR_USER_PREFIX_LEN))
> +			goto contloop;
> +
> +		slen -=3D XATTR_USER_PREFIX_LEN;
> +		xdrlen =3D 4 + ((slen + 3) & ~3);
> +		if (xdrlen > xdrleft) {
> +			if (count =3D=3D 0) {
> +				/*
> +				 * Can't even fit the first attribute =
name.
> +				 */
> +				return nfserr_toosmall;
> +			}
> +			eof =3D 0;
> +			goto wreof;
> +		}
> +
> +		left -=3D XATTR_USER_PREFIX_LEN;
> +		sp +=3D XATTR_USER_PREFIX_LEN;
> +		if (nuser++ < offset)
> +			goto contloop;
> +
> +
> +		p =3D xdr_reserve_space(xdr, xdrlen);
> +		if (!p)
> +			return nfserr_resource;
> +
> +		p =3D xdr_encode_opaque(p, sp, slen);
> +
> +		xdrleft -=3D xdrlen;
> +		count++;
> +contloop:
> +		sp +=3D slen + 1;
> +		left -=3D slen + 1;
> +	}
> +
> +	/*
> +	 * If there were user attributes to copy, but we didn't copy
> +	 * any, the offset was too large (e.g. the cookie was invalid).
> +	 */
> +	if (nuser > 0 && count =3D=3D 0)
> +		return nfserr_badcookie;
> +
> +wreof:
> +	p =3D xdr_reserve_space(xdr, 4);
> +	if (!p)
> +		return nfserr_resource;
> +	*p =3D cpu_to_be32(eof);
> +
> +	cookie =3D offset + count;
> +
> +	write_bytes_to_xdr_buf(xdr->buf, cookie_offset, &cookie, 8);
> +	count =3D htonl(count);
> +	write_bytes_to_xdr_buf(xdr->buf, count_offset, &count, 4);
> +	return 0;
> +}
> +
> +static __be32
> +nfsd4_encode_removexattr(struct nfsd4_compoundres *resp, __be32 =
nfserr,
> +			 struct nfsd4_removexattr *removexattr)
> +{
> +	struct xdr_stream *xdr =3D &resp->xdr;
> +	__be32 *p;
> +
> +	p =3D xdr_reserve_space(xdr, 20);
> +	if (!p)
> +		return nfserr_resource;
> +
> +	p =3D encode_cinfo(p, &removexattr->rmxa_cinfo);
> +	return 0;
> +}
> +
> typedef __be32(* nfsd4_enc)(struct nfsd4_compoundres *, __be32, void =
*);
>=20
> /*
> @@ -4547,6 +4989,12 @@ static const nfsd4_enc nfsd4_enc_ops[] =3D {
> 	[OP_SEEK]		=3D (nfsd4_enc)nfsd4_encode_seek,
> 	[OP_WRITE_SAME]		=3D (nfsd4_enc)nfsd4_encode_noop,
> 	[OP_CLONE]		=3D (nfsd4_enc)nfsd4_encode_noop,
> +
> +	/* RFC 8276 extended atributes operations */
> +	[OP_GETXATTR]		=3D (nfsd4_enc)nfsd4_encode_getxattr,
> +	[OP_SETXATTR]		=3D (nfsd4_enc)nfsd4_encode_setxattr,
> +	[OP_LISTXATTRS]		=3D (nfsd4_enc)nfsd4_encode_listxattrs,
> +	[OP_REMOVEXATTR]	=3D (nfsd4_enc)nfsd4_encode_removexattr,
> };
>=20
> /*
> --=20
> 2.16.6
>=20

--
Chuck Lever



