Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872E32CAF99
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 23:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389544AbgLAWCR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 17:02:17 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53964 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391977AbgLAWCL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 17:02:11 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1LtcXi139905;
        Tue, 1 Dec 2020 22:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=HTNa8+fBZQn8nIM+NU8f9Kr2bHjdFk28VtAzC2VWaqs=;
 b=aqvC4g1hXrP1AUZMuoJqWnXvZnHsHxj7cRCCxLOfQMqTSquUgcqQ6AkjnS2l18JzyPIv
 uGbU21QhDj5YFVY0WuE5Wz7asc96WoHDQVBnKs7Tg2LyhY4XbbCtjcicrRoSbKFt9vKd
 Tw2p4ftfRt6W1c9TwcwhOCp1DJOW3cFXk+y4Wfstpm1E6qcu1OiBdirrMf2mnk3/h48H
 b3VZdW+ts6TBYTuhquhM2YDCmcnCPmIk0eNB++CeVHQ1a9HEbr7ahvTf8Nahc8zSRn3Z
 pwdcI4AoTQYeyCC7hBRHVoVhnOsdFSp16w30Nxoi06ye692Fna54xB5BIKL/6NOvROtN Og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 353egkn134-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Dec 2020 22:01:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1LoWRX182265;
        Tue, 1 Dec 2020 22:01:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3540at30gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Dec 2020 22:01:21 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B1M1HTd005786;
        Tue, 1 Dec 2020 22:01:17 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Dec 2020 14:01:16 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] NFSv4.2: improve page handling for GETXATTR
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201201213128.13624-1-fllinden@amazon.com>
Date:   Tue, 1 Dec 2020 17:01:15 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        trond.myklebust@hammerspace.com, Olga Kornievskaia <aglo@umich.edu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <93373383-EA91-434A-97F7-ACC5E97711BD@oracle.com>
References: <20201201213128.13624-1-fllinden@amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=2
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=2
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010131
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 1, 2020, at 4:31 PM, Frank van der Linden <fllinden@amazon.com> =
wrote:
>=20
> XDRBUF_SPARSE_PAGES can cause problems for the RDMA transport,
> and it's easy enough to allocate enough pages for the request
> up front, so do that.
>=20
> Also, since we've allocated the pages anyway, use the full
> page aligned length for the receive buffer. This will allow
> caching of valid replies that are too large for the caller,
> but that still fit in the allocated pages.
>=20
> Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> ---
> fs/nfs/nfs42proc.c | 39 ++++++++++++++++++++++++++++++---------
> fs/nfs/nfs42xdr.c  | 22 +++++++++++++++++-----
> 2 files changed, 47 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 2b2211d1234e..bfe15ac77bd9 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -1176,11 +1176,9 @@ static ssize_t _nfs42_proc_getxattr(struct =
inode *inode, const char *name,
> 				void *buf, size_t buflen)
> {
> 	struct nfs_server *server =3D NFS_SERVER(inode);
> -	struct page *pages[NFS4XATTR_MAXPAGES] =3D {};
> +	struct page **pages;

Taking this array of pointers off the stack is Goodness(tm).

Thanks for doing this update!

> 	struct nfs42_getxattrargs arg =3D {
> 		.fh		=3D NFS_FH(inode),
> -		.xattr_pages	=3D pages,
> -		.xattr_len	=3D buflen,
> 		.xattr_name	=3D name,
> 	};
> 	struct nfs42_getxattrres res;
> @@ -1189,12 +1187,31 @@ static ssize_t _nfs42_proc_getxattr(struct =
inode *inode, const char *name,
> 		.rpc_argp	=3D &arg,
> 		.rpc_resp	=3D &res,
> 	};
> -	int ret, np;
> +	ssize_t ret, np, i;
> +
> +	arg.xattr_len =3D buflen ?: XATTR_SIZE_MAX;
> +
> +	ret =3D -ENOMEM;
> +	np =3D DIV_ROUND_UP(arg.xattr_len, PAGE_SIZE);
> +
> +	pages =3D kcalloc(np, sizeof(struct page *), GFP_KERNEL);
> +	if (pages =3D=3D NULL)
> +		return ret;
> +
> +	for (i =3D 0; i < np; i++) {
> +		pages[i] =3D alloc_page(GFP_KERNEL);
> +		if (!pages[i])
> +			goto out_free;
> +	}
> +
> +	arg.xattr_pages =3D pages;
>=20
> 	ret =3D nfs4_call_sync(server->client, server, &msg, =
&arg.seq_args,
> 	    &res.seq_res, 0);
> 	if (ret < 0)
> -		return ret;
> +		goto out_free;
> +
> +	ret =3D res.xattr_len;
>=20
> 	/*
> 	 * Normally, the caching is done one layer up, but for =
successful
> @@ -1209,16 +1226,20 @@ static ssize_t _nfs42_proc_getxattr(struct =
inode *inode, const char *name,
> 	nfs4_xattr_cache_add(inode, name, NULL, pages, res.xattr_len);
>=20
> 	if (buflen) {
> -		if (res.xattr_len > buflen)
> -			return -ERANGE;
> +		if (res.xattr_len > buflen) {
> +			ret =3D -ERANGE;
> +			goto out_free;
> +		}
> 		_copy_from_pages(buf, pages, 0, res.xattr_len);
> 	}
>=20
> -	np =3D DIV_ROUND_UP(res.xattr_len, PAGE_SIZE);
> +out_free:
> 	while (--np >=3D 0)
> 		__free_page(pages[np]);
>=20
> -	return res.xattr_len;
> +	kfree(pages);
> +
> +	return ret;
> }
>=20
> static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
> diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> index 6e060a88f98c..8dfe674d1301 100644
> --- a/fs/nfs/nfs42xdr.c
> +++ b/fs/nfs/nfs42xdr.c
> @@ -489,6 +489,12 @@ static int decode_getxattr(struct xdr_stream =
*xdr,
> 		return -EIO;
>=20
> 	len =3D be32_to_cpup(p);
> +
> +	/*
> +	 * Only check against the page length here. The actual
> +	 * requested length may be smaller, but that is only
> +	 * checked against after possibly caching a valid reply.
> +	 */
> 	if (len > req->rq_rcv_buf.page_len)
> 		return -ERANGE;
>=20
> @@ -1483,11 +1489,17 @@ static void nfs4_xdr_enc_getxattr(struct =
rpc_rqst *req, struct xdr_stream *xdr,
> 	encode_putfh(xdr, args->fh, &hdr);
> 	encode_getxattr(xdr, args->xattr_name, &hdr);
>=20
> -	plen =3D args->xattr_len ? args->xattr_len : XATTR_SIZE_MAX;
> -
> -	rpc_prepare_reply_pages(req, args->xattr_pages, 0, plen,
> -	    hdr.replen);
> -	req->rq_rcv_buf.flags |=3D XDRBUF_SPARSE_PAGES;
> +	/*
> +	 * The GETXATTR op has no length field in the call, and the
> +	 * xattr data is at the end of the reply.
> +	 *
> +	 * Since the pages have already been allocated, there is no
> +	 * downside in using the page-aligned length. It will allow
> +	 * receiving and caching xattrs that are too large for the
> +	 * caller but still fit in the page-rounded value.
> +	 */
> +	plen =3D round_up(args->xattr_len, PAGE_SIZE);
> +	rpc_prepare_reply_pages(req, args->xattr_pages, 0, plen, =
hdr.replen);
>=20
> 	encode_nops(&hdr);
> }
> --=20
> 2.23.3
>=20

--
Chuck Lever



