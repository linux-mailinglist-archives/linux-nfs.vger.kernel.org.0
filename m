Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8E32B9474
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Nov 2020 15:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgKSORu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Nov 2020 09:17:50 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42264 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgKSORu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Nov 2020 09:17:50 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJEAFtb091248;
        Thu, 19 Nov 2020 14:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=zzau/U+7ZI2kWUqv5KdzSUJrF+qDxuNLOxGBt7D14hA=;
 b=RVCli65VZUpzyn1+Wdz9Q/BmCJCvQoQg76HK0woNYa8DRZsKeDLjj6EDMaIRTwerJ1Ps
 NSp2HqBaYq7QLBnn1VAmqwTmEBu8wD37ztTiLTK7Cy0HGMOhdmujHKKSrWRqVFrGHIyq
 2JRqQqJX7MihVXuvKCyeDaPsYI+ribbJMFYYdhkIu3YHYsqqyilUPvWn+VTj5oCK3DmU
 tpOPxA3tBvJTrieuNi6mo8wWzUmnEn6SHs99EMbl4tUxSaBKtDpwTKmv5VPYtfJ0B98T
 QAoDxdLo+lkL9dMcIRmfQRUozCWJCgwRnS58zRchKhWy84WGxB7HwUlNwP7jR56GuxjB mg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34t76m5k9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 14:17:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJEEfil115660;
        Thu, 19 Nov 2020 14:17:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34ts6014rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 14:17:46 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AJEHjqM025444;
        Thu, 19 Nov 2020 14:17:45 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Nov 2020 06:17:45 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 3/3] NFS: Avoid copy of xdr padding in read()
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201118221939.20715-3-trondmy@kernel.org>
Date:   Thu, 19 Nov 2020 09:17:44 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <42FFB4EC-5E31-4002-92FC-7CA329479D78@oracle.com>
References: <20201118221939.20715-1-trondmy@kernel.org>
 <20201118221939.20715-2-trondmy@kernel.org>
 <20201118221939.20715-3-trondmy@kernel.org>
To:     trondmy@kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=1 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011190108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011190107
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 18, 2020, at 5:19 PM, trondmy@kernel.org wrote:
>=20
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> When doing a read() into a page, we also don't care if the nul padding
> stays in that last page when the data length is not 32-bit aligned.

What if the READ payload lands in the middle of a file? The
pad on the end will overwrite file content just past where
the READ payload lands.


> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
> fs/nfs/nfs2xdr.c | 2 +-
> fs/nfs/nfs3xdr.c | 2 +-
> fs/nfs/nfs4xdr.c | 2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
> index db9c265ad9e1..468bfbfe44d7 100644
> --- a/fs/nfs/nfs2xdr.c
> +++ b/fs/nfs/nfs2xdr.c
> @@ -102,7 +102,7 @@ static int decode_nfsdata(struct xdr_stream *xdr, =
struct nfs_pgio_res *result)
> 	if (unlikely(!p))
> 		return -EIO;
> 	count =3D be32_to_cpup(p);
> -	recvd =3D xdr_read_pages(xdr, count);
> +	recvd =3D xdr_read_pages(xdr, xdr_align_size(count));
> 	if (unlikely(count > recvd))
> 		goto out_cheating;
> out:
> diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
> index d3e1726d538b..8ef7c961d3e2 100644
> --- a/fs/nfs/nfs3xdr.c
> +++ b/fs/nfs/nfs3xdr.c
> @@ -1611,7 +1611,7 @@ static int decode_read3resok(struct xdr_stream =
*xdr,
> 	ocount =3D be32_to_cpup(p++);
> 	if (unlikely(ocount !=3D count))
> 		goto out_mismatch;
> -	recvd =3D xdr_read_pages(xdr, count);
> +	recvd =3D xdr_read_pages(xdr, xdr_align_size(count));
> 	if (unlikely(count > recvd))
> 		goto out_cheating;
> out:
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index 755b556e85c3..5baa767106dc 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -5202,7 +5202,7 @@ static int decode_read(struct xdr_stream *xdr, =
struct rpc_rqst *req,
> 		return -EIO;
> 	eof =3D be32_to_cpup(p++);
> 	count =3D be32_to_cpup(p);
> -	recvd =3D xdr_read_pages(xdr, count);
> +	recvd =3D xdr_read_pages(xdr, xdr_align_size(count));
> 	if (count > recvd) {
> 		dprintk("NFS: server cheating in read reply: "
> 				"count %u > recvd %u\n", count, recvd);
> --=20
> 2.28.0
>=20

--
Chuck Lever



