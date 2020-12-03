Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741402CDFB0
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 21:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgLCU14 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 15:27:56 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34596 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgLCU14 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 15:27:56 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B3KPCSL015307;
        Thu, 3 Dec 2020 20:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=lpE5CJ8s8t+V/PwiDfGpjRMVP56Y5pnzkBBdObetaO0=;
 b=wqtfu5B5hcX8EqzwV8d1M7fHX+yg1J9EduGWlUZEuIcLVPlTJLldA4mZE6D2l4N0VrLL
 wIGnYlgyyG5GwF1qHlq03rTDmB7zVds9udKWT7KEA3nQNHIli5oftzhWRUbcW3AhpZ3J
 ZHvELpTlimyC0AynntcWpq3hVjD600OznFuKI48C+9pZZmFIv8dtL5Mp5vG0jUvNBddz
 6hH+F6sUy3xBRPftCSMpI6VYOsROT5ir6CnPtJ/p7piNMv1vxyRFC8sDYvQbzmTkJDur
 g1lf6WdlMhYldu/E8QIEgiokQhqxkGp8akvrwDKCbjIbsAJBrwDBtnrUZ4EqxIiX2MCu RA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 353egm01g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Dec 2020 20:27:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B3KQNXK128919;
        Thu, 3 Dec 2020 20:27:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3540awsqrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Dec 2020 20:27:11 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B3KRAQV022233;
        Thu, 3 Dec 2020 20:27:10 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Dec 2020 12:27:09 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 2/3] NFS: Allocate a scratch page for READ_PLUS
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201203201841.103294-3-Anna.Schumaker@Netapp.com>
Date:   Thu, 3 Dec 2020 15:27:08 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8CE5CE8C-9301-4250-B077-ACE23969C19A@oracle.com>
References: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
 <20201203201841.103294-3-Anna.Schumaker@Netapp.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9824 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9824 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012030119
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 3, 2020, at 3:18 PM, schumaker.anna@gmail.com wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> We might need this to better handle shifting around data in the reply
> buffer.
>=20
> Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
> fs/nfs/nfs42xdr.c       |  2 ++
> fs/nfs/read.c           | 13 +++++++++++--
> include/linux/nfs_xdr.h |  1 +
> 3 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> index 8432bd6b95f0..ef095a5f86f7 100644
> --- a/fs/nfs/nfs42xdr.c
> +++ b/fs/nfs/nfs42xdr.c
> @@ -1297,6 +1297,8 @@ static int nfs4_xdr_dec_read_plus(struct =
rpc_rqst *rqstp,
> 	struct compound_hdr hdr;
> 	int status;
>=20
> +	xdr_set_scratch_buffer(xdr, page_address(res->scratch), =
PAGE_SIZE);

I intend to submit this for v5.11:

=
https://git.linux-nfs.org/?p=3Dcel/cel-2.6.git;a=3Dcommit;h=3D0ae4c3e8a64a=
ce1b8d7de033b0751afe43024416

But seems like enough callers need a scratch buffer that the XDR
layer should set up it transparently for all requests.


> +
> 	status =3D decode_compound_hdr(xdr, &hdr);
> 	if (status)
> 		goto out;
> diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> index eb854f1f86e2..012deb5a136f 100644
> --- a/fs/nfs/read.c
> +++ b/fs/nfs/read.c
> @@ -37,15 +37,24 @@ static struct kmem_cache *nfs_rdata_cachep;
>=20
> static struct nfs_pgio_header *nfs_readhdr_alloc(void)
> {
> -	struct nfs_pgio_header *p =3D =
kmem_cache_zalloc(nfs_rdata_cachep, GFP_KERNEL);
> +	struct nfs_pgio_header *p;
> +	struct page *page;
>=20
> -	if (p)
> +	page =3D alloc_page(GFP_KERNEL);
> +	if (!page)
> +		return ERR_PTR(-ENOMEM);
> +
> +	p =3D kmem_cache_zalloc(nfs_rdata_cachep, GFP_KERNEL);
> +	if (p) {
> 		p->rw_mode =3D FMODE_READ;
> +		p->res.scratch =3D page;
> +	}
> 	return p;
> }
>=20
> static void nfs_readhdr_free(struct nfs_pgio_header *rhdr)
> {
> +	__free_page(rhdr->res.scratch);
> 	kmem_cache_free(nfs_rdata_cachep, rhdr);
> }
>=20
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index d63cb862d58e..e0a1c97f11a9 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -659,6 +659,7 @@ struct nfs_pgio_res {
> 	struct nfs_fattr *	fattr;
> 	__u64			count;
> 	__u32			op_status;
> +	struct page *		scratch;
> 	union {
> 		struct {
> 			unsigned int		replen;		/* used =
by read */
> --=20
> 2.29.2
>=20

--
Chuck Lever



