Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3845A15AA59
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2020 14:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgBLNsa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Feb 2020 08:48:30 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44492 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgBLNsa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Feb 2020 08:48:30 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CDWffm128144;
        Wed, 12 Feb 2020 13:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=XOBpNC2vaxv98JUwiiK/tuD55VV4tZ9KF2/KTnm016Q=;
 b=G8mQlTFUl3p1533mJpIYFiQcKIbuS7u/2VU193gjgxKUNqvqETvB1EuyrJIGJyaGUJp5
 kuQ+Ro6tGIbzcefVub3rjN1QdRp7YN561IcYs2zZnKL3GpmWrm/wBHQ+D+orJ5b1qpzU
 SDdHWe6H7r3HbbB4aAzTBIaPdwVBwJk96tM2GdkU7jQ90Egn6vdbntPjyxtlabIcYF62
 BnkpPV4yk0EZR9D2PuKhDM2mfoMCW8uUCZ67zUxnVHiC8cjT9PLzu1DnlMXNqVspzp1a
 2DuxQtbyjqSBg0sTIRm3yXOiS34/9MPcp4AmL/61AW4GQUsGcGZnFCeB9RSr/ZP78g4K Hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2y2jx6aquk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 13:48:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CDWF87060435;
        Wed, 12 Feb 2020 13:48:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2y26hx022n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 13:48:23 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01CDmLNF029403;
        Wed, 12 Feb 2020 13:48:21 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 05:48:21 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] xprtrdma: Fix DMA scatter-gather list mapping
 imbalance
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <158151473332.515306.1111360128438553868.stgit@morisot.1015granger.net>
Date:   Wed, 12 Feb 2020 08:48:20 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <869DC73D-190E-46AB-B8F8-1A394F92AF41@oracle.com>
References: <158151473332.515306.1111360128438553868.stgit@morisot.1015granger.net>
To:     Andre Tomt <andre@tomt.net>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120108
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 12, 2020, at 8:43 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> The @nents value that was passed to ib_dma_map_sg() has to be passed
> to the matching ib_dma_unmap_sg() call. If ib_dma_map_sg() choses to
> concatenate sg entries, it will return a different nents value than
> it was passed.
>=20
> The bug was exposed by recent changes to the AMD IOMMU driver, which
> enabled sg entry concatenation.
>=20
> Looking all the way back to 4143f34e01e9 ("xprtrdma: Port to new
> memory registration API") and reviewing other kernel ULPs, it's not
> clear that the frwr_map() logic was ever correct for this case.
>=20
> Reported-by: Andre Tomt <andre@tomt.net>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> include/trace/events/rpcrdma.h |    6 ++++--
> net/sunrpc/xprtrdma/frwr_ops.c |   13 +++++++------
> 2 files changed, 11 insertions(+), 8 deletions(-)
>=20
> Hi Andre, here's take 2, based on the trace data you sent me.
> Please let me know if this one fares any better.
>=20
> Changes since v1:
> - Ensure the correct nents value is passed to ib_map_mr_sg
> - Record the mr_nents value in the MR trace points
>=20
> diff --git a/include/trace/events/rpcrdma.h =
b/include/trace/events/rpcrdma.h
> index c0e4c93324f5..023c5da45999 100644
> --- a/include/trace/events/rpcrdma.h
> +++ b/include/trace/events/rpcrdma.h
> @@ -275,6 +275,7 @@ DECLARE_EVENT_CLASS(xprtrdma_mr,
>=20
> 	TP_STRUCT__entry(
> 		__field(const void *, mr)
> +		__field(unsigned int, nents)
> 		__field(u32, handle)
> 		__field(u32, length)
> 		__field(u64, offset)
> @@ -283,14 +284,15 @@ DECLARE_EVENT_CLASS(xprtrdma_mr,
>=20
> 	TP_fast_assign(
> 		__entry->mr =3D mr;
> +		__entry->nents =3D mr->mr_nents;
> 		__entry->handle =3D mr->mr_handle;
> 		__entry->length =3D mr->mr_length;
> 		__entry->offset =3D mr->mr_offset;
> 		__entry->dir    =3D mr->mr_dir;
> 	),
>=20
> -	TP_printk("mr=3D%p %u@0x%016llx:0x%08x (%s)",
> -		__entry->mr, __entry->length,
> +	TP_printk("mr=3D%p %d %u@0x%016llx:0x%08x (%s)",
> +		__entry->mr, __entry->mr_nents, __entry->length,

This should be:
		__entry->mr, __entry->nents, __entry->length,

Sorry about that.


> 		(unsigned long long)__entry->offset, __entry->handle,
> 		xprtrdma_show_direction(__entry->dir)
> 	)
> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c =
b/net/sunrpc/xprtrdma/frwr_ops.c
> index 095be887753e..75617646702b 100644
> --- a/net/sunrpc/xprtrdma/frwr_ops.c
> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
> @@ -288,8 +288,8 @@ struct rpcrdma_mr_seg *frwr_map(struct =
rpcrdma_xprt *r_xprt,
> {
> 	struct rpcrdma_ia *ia =3D &r_xprt->rx_ia;
> 	struct ib_reg_wr *reg_wr;
> +	int i, n, dma_nents;
> 	struct ib_mr *ibmr;
> -	int i, n;
> 	u8 key;
>=20
> 	if (nsegs > ia->ri_max_frwr_depth)
> @@ -313,15 +313,16 @@ struct rpcrdma_mr_seg *frwr_map(struct =
rpcrdma_xprt *r_xprt,
> 			break;
> 	}
> 	mr->mr_dir =3D rpcrdma_data_dir(writing);
> +	mr->mr_nents =3D i;
>=20
> -	mr->mr_nents =3D
> -		ib_dma_map_sg(ia->ri_id->device, mr->mr_sg, i, =
mr->mr_dir);
> -	if (!mr->mr_nents)
> +	dma_nents =3D ib_dma_map_sg(ia->ri_id->device, mr->mr_sg,
> +				  mr->mr_nents, mr->mr_dir);
> +	if (!dma_nents)
> 		goto out_dmamap_err;
>=20
> 	ibmr =3D mr->frwr.fr_mr;
> -	n =3D ib_map_mr_sg(ibmr, mr->mr_sg, mr->mr_nents, NULL, =
PAGE_SIZE);
> -	if (unlikely(n !=3D mr->mr_nents))
> +	n =3D ib_map_mr_sg(ibmr, mr->mr_sg, dma_nents, NULL, PAGE_SIZE);
> +	if (n !=3D dma_nents)
> 		goto out_mapmr_err;
>=20
> 	ibmr->iova &=3D 0x00000000ffffffff;
>=20
>=20

--
Chuck Lever



