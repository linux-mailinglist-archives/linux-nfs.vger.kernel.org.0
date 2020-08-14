Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66335244E65
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Aug 2020 20:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHNSOy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Aug 2020 14:14:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47054 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgHNSOy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Aug 2020 14:14:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07EIC22F188743;
        Fri, 14 Aug 2020 18:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=OkrJo0k8Huar3lX/G/1ooBJIfUbojguhPgaUo7Rw6gI=;
 b=O+wQXgD/DdNMG6uFL9PIsu3Y5wU3R2AR8+O3soAZFqX3lP4JHlgr8KHVxtCu19e7yx41
 0NNQA10iw3MfDPIUFTBWVKFb7Ri9YyOGe6SXQ7DfOWJ6vFAVkL7NrvssCgNayo+OfqLC
 B++6jX8CZgsHw4FI6A3mns9s6CWA907tM2zr8znweKjSxFYWwk19duhMu34ptwI6cXaV
 ao2/eXUIGIffROsYg5aFhouTRoWlqHhcQD8GiEALqjt/4IriOhpxM67RkQtY1irUn504
 sxAMELWEMfWoMQv20XcDZVEKqsh9ndmQ3WoP8JeaCcd/7b4rTlTrL8NyPXUD9Dj4P1jL KA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32t2ye6449-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Aug 2020 18:14:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07EICj4b024001;
        Fri, 14 Aug 2020 18:12:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 32t6083qpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Aug 2020 18:12:51 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07EICnN1017667;
        Fri, 14 Aug 2020 18:12:50 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Aug 2020 18:12:49 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] xprtrdma: make sure MRs are unmapped before freeing them
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200814173734.3271600-1-dan@kernelim.com>
Date:   Fri, 14 Aug 2020 14:12:48 -0400
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5B87C3B5-B73D-40FD-A813-B3929CDF7583@oracle.com>
References: <20200814173734.3271600-1-dan@kernelim.com>
To:     Dan Aloni <dan@kernelim.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9713 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008140136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9713 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008140136
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dan-

> On Aug 14, 2020, at 1:37 PM, Dan Aloni <dan@kernelim.com> wrote:
>=20
> It was observed that on disconnections, these unmaps don't occur. The
> relevant path is rpcrdma_mrs_destroy(), being called from
> rpcrdma_xprt_disconnect().

MRs are supposed to be unmapped right after they are used, so
during disconnect they should all be unmapped already. How often
do you see a DMA mapped MR in this code path? Do you have a
reproducer I can try?


> Signed-off-by: Dan Aloni <dan@kernelim.com>
> ---
> net/sunrpc/xprtrdma/frwr_ops.c | 22 ++++++++++++++++------
> 1 file changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c =
b/net/sunrpc/xprtrdma/frwr_ops.c
> index 7f94c9a19fd3..3899a5310214 100644
> --- a/net/sunrpc/xprtrdma/frwr_ops.c
> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
> @@ -49,6 +49,19 @@
> # define RPCDBG_FACILITY	RPCDBG_TRANS
> #endif
>=20
> +static void frwr_mr_unmap(struct rpcrdma_mr *mr)
> +{
> +	struct rpcrdma_xprt *r_xprt =3D mr->mr_xprt;
> +
> +	if (mr->mr_dir =3D=3D DMA_NONE)
> +		return;
> +
> +	trace_xprtrdma_mr_unmap(mr);
> +	ib_dma_unmap_sg(r_xprt->rx_ep->re_id->device,
> +			mr->mr_sg, mr->mr_nents, mr->mr_dir);
> +	mr->mr_dir =3D DMA_NONE;
> +}
> +
> /**
>  * frwr_release_mr - Destroy one MR
>  * @mr: MR allocated by frwr_mr_init
> @@ -58,6 +71,8 @@ void frwr_release_mr(struct rpcrdma_mr *mr)
> {
> 	int rc;
>=20
> +	frwr_mr_unmap(mr);
> +
> 	rc =3D ib_dereg_mr(mr->frwr.fr_mr);
> 	if (rc)
> 		trace_xprtrdma_frwr_dereg(mr, rc);
> @@ -71,12 +86,7 @@ static void frwr_mr_recycle(struct rpcrdma_mr *mr)
>=20
> 	trace_xprtrdma_mr_recycle(mr);
>=20
> -	if (mr->mr_dir !=3D DMA_NONE) {
> -		trace_xprtrdma_mr_unmap(mr);
> -		ib_dma_unmap_sg(r_xprt->rx_ep->re_id->device,
> -				mr->mr_sg, mr->mr_nents, mr->mr_dir);
> -		mr->mr_dir =3D DMA_NONE;
> -	}
> +	frwr_mr_unmap(mr);
>=20
> 	spin_lock(&r_xprt->rx_buf.rb_lock);
> 	list_del(&mr->mr_all);
> --=20
> 2.25.4
>=20

--
Chuck Lever



