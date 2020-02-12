Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1467315B001
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2020 19:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgBLSjF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Feb 2020 13:39:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50094 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLSjE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Feb 2020 13:39:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CIcwPD151146;
        Wed, 12 Feb 2020 18:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=BweQOyuw4lAI6QOL+dq2bZ9WmNPlU41QUHb0XGgqOUs=;
 b=cFmPttuwsX7KyyGJ0mYbNzuS3gLlNRZOwJShj52gBiLW0sSWgq+33rARMsXUKFgKZ/fK
 dYaD56uQjnOnmpPAdOF5zq2F2/oN9gRAzVnPImYzo/Hs1OPmQf2nfAPSEpOoF906O40P
 ZwgvlLItWRtJy8qWI0Et3azCdI/dmhNcwLvYv3B4dxlF8VkJDGJQCZp2qcGF5iBNSFCY
 Pl8QgpmJjQ24s8kKdDajSUSMuNZ32pBOYcGaAO9aE4nl6/pNlliY6JRekEUJUyEBYajs
 6BRvplNnsXmamST2waA4cKi3+Wm4YoLh8JG5VAwkCDXP+AReWP9kBKd5Mb518ZqGV4wp Gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2y2jx6d3bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 18:39:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CIb2gH005747;
        Wed, 12 Feb 2020 18:39:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2y4kagph5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 18:39:01 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01CId0SB019931;
        Wed, 12 Feb 2020 18:39:00 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 10:39:00 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3 1/2] xprtrdma: Fix DMA scatter-gather list mapping
 imbalance
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200212182638.GA31668@ziepe.ca>
Date:   Wed, 12 Feb 2020 13:38:59 -0500
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F7B6A553-0355-41BF-A209-E8D73D15A6A9@oracle.com>
References: <158152363458.433502.7428050218198466755.stgit@morisot.1015granger.net>
 <158152394998.433502.5623790463334839091.stgit@morisot.1015granger.net>
 <20200212182638.GA31668@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120133
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Feb 12, 2020, at 1:26 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Wed, Feb 12, 2020 at 11:12:30AM -0500, Chuck Lever wrote:
>> The @nents value that was passed to ib_dma_map_sg() has to be passed
>> to the matching ib_dma_unmap_sg() call. If ib_dma_map_sg() choses to
>> concatenate sg entries, it will return a different nents value than
>> it was passed.
>>=20
>> The bug was exposed by recent changes to the AMD IOMMU driver, which
>> enabled sg entry concatenation.
>>=20
>> Looking all the way back to commit 4143f34e01e9 ("xprtrdma: Port to
>> new memory registration API") and reviewing other kernel ULPs, it's
>> not clear that the frwr_map() logic was ever correct for this case.
>>=20
>> Reported-by: Andre Tomt <andre@tomt.net>
>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> Cc: stable@vger.kernel.org # v5.5
>> ---
>> net/sunrpc/xprtrdma/frwr_ops.c |   13 +++++++------
>> 1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> Yep
>=20
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Thanks.

Wondering if it makes sense to add a Fixes tag for the AMD IOMMU commit
where NFS/RDMA stopped working, rather than the "Cc: stable # v5.5".

Fixes: be62dbf554c5 ("iommu/amd: Convert AMD iommu driver to the =
dma-iommu api")

--
Chuck Lever



