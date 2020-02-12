Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2BC15B078
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2020 20:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgBLTJJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Feb 2020 14:09:09 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42956 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgBLTJJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Feb 2020 14:09:09 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CJ2dwP130361;
        Wed, 12 Feb 2020 19:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=JTp6Z3pIK5uALAQA8OrrrVHzTPkb3n3q8YFiUfciiNA=;
 b=ONLJA7L5WNDzMh9nAECMuH/b0g6TC6M68zguvhsX4CuV7CgNDdjmp9uiPzhCzBI5ZaOC
 K2oeKKDrfKVOJb7x7xemiZTmFU/BATIg8dAjOp92d1uckUnjELXg4q2L9Hzh2GINbP7k
 jj551g1ArX51/xboJL84je988RRlMAasrdc3uXhRVpcFvU1h8j2yaIJRVAjxo4+0rOdg
 Z3Egt1oEcgL67O5mBA9EkPNIQGqNiQleo4CiUX3TzLgR77E24hZWZTFdnGmIolZln2Xi
 fVp0444GCasQM79YsNnxt3WNDB6D02ZUinITWo8G/kLgQ2HxMZTPyoMtMKmzEI3aRDxY Sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2y2k88d3at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 19:09:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CIvxXr062849;
        Wed, 12 Feb 2020 19:09:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2y4k7x7s2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 19:09:06 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01CJ95kT025599;
        Wed, 12 Feb 2020 19:09:05 GMT
Received: from [10.39.214.195] (/10.39.214.195)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 11:09:04 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3 1/2] xprtrdma: Fix DMA scatter-gather list mapping
 imbalance
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200212190545.GB31668@ziepe.ca>
Date:   Wed, 12 Feb 2020 14:09:03 -0500
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B9D0EE52-469B-4CC4-A944-C3421DBB68B6@oracle.com>
References: <158152363458.433502.7428050218198466755.stgit@morisot.1015granger.net>
 <158152394998.433502.5623790463334839091.stgit@morisot.1015granger.net>
 <20200212182638.GA31668@ziepe.ca>
 <F7B6A553-0355-41BF-A209-E8D73D15A6A9@oracle.com>
 <20200212190545.GB31668@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120135
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 12, 2020, at 2:05 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Wed, Feb 12, 2020 at 01:38:59PM -0500, Chuck Lever wrote:
>>=20
>>> On Feb 12, 2020, at 1:26 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>=20
>>> On Wed, Feb 12, 2020 at 11:12:30AM -0500, Chuck Lever wrote:
>>>> The @nents value that was passed to ib_dma_map_sg() has to be =
passed
>>>> to the matching ib_dma_unmap_sg() call. If ib_dma_map_sg() choses =
to
>>>> concatenate sg entries, it will return a different nents value than
>>>> it was passed.
>>>>=20
>>>> The bug was exposed by recent changes to the AMD IOMMU driver, =
which
>>>> enabled sg entry concatenation.
>>>>=20
>>>> Looking all the way back to commit 4143f34e01e9 ("xprtrdma: Port to
>>>> new memory registration API") and reviewing other kernel ULPs, it's
>>>> not clear that the frwr_map() logic was ever correct for this case.
>>>>=20
>>>> Reported-by: Andre Tomt <andre@tomt.net>
>>>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> Cc: stable@vger.kernel.org # v5.5
>>>> net/sunrpc/xprtrdma/frwr_ops.c |   13 +++++++------
>>>> 1 file changed, 7 insertions(+), 6 deletions(-)
>>>=20
>>> Yep
>>>=20
>>> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
>>=20
>> Thanks.
>>=20
>> Wondering if it makes sense to add a Fixes tag for the AMD IOMMU =
commit
>> where NFS/RDMA stopped working, rather than the "Cc: stable # v5.5".
>>=20
>> Fixes: be62dbf554c5 ("iommu/amd: Convert AMD iommu driver to the =
dma-iommu api")
>=20
> Not really, this was broken for other configurations besides AMD

Agreed, but the bug seems to have been inconsequential until now?

Otherwise we should explore backporting farther into the past.


--
Chuck Lever



