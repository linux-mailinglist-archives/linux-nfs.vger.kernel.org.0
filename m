Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 822CF15C067
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2020 15:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgBMOdb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Feb 2020 09:33:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38316 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbgBMOdb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Feb 2020 09:33:31 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01DEUlRR186046;
        Thu, 13 Feb 2020 14:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=nuyPBpjAVYT7HQZeVv//RC7Ou3xrZdtOJkagIPP9KQA=;
 b=b8Qw0L1tO5gHd1dkyDnrk5JDzT9YDjAvK1zbffQbeNqbofcWmZ9GOjYpGvTXWYSDsuS9
 FVvfMBprSsds/0/cYOW50wVtboulaHPIhIX19e9v6mRBdj7i5SbXxy0LrijtPb1GnY+n
 UR8ex1Tw3x7WnyffGfI0bN0CCMXXt/YJ4FPR5gjc9S0iHbTJbiwNna8kOGWCXKX1j0j6
 eVH0smzL02+c/+/hJRdX5Q0seApmDs3voHnhLTedSzB3H45R5TbIDCq/sG8ShSLeRV3+
 r77oLR1fTabxnwxA6oj2T7RpnYDZqX6qJRLxQKCIxLZo1BooDH0Lrz47U9t0138SpS/V yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2y2jx6jgt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Feb 2020 14:33:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01DERWA8116377;
        Thu, 13 Feb 2020 14:33:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2y4k36k72a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 14:33:26 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01DEXOlR021115;
        Thu, 13 Feb 2020 14:33:24 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Feb 2020 06:33:24 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3 1/2] xprtrdma: Fix DMA scatter-gather list mapping
 imbalance
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200212193036.GD31668@ziepe.ca>
Date:   Thu, 13 Feb 2020 09:33:23 -0500
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <595DB50E-F65A-4F52-BFDB-79161151ECDD@oracle.com>
References: <158152363458.433502.7428050218198466755.stgit@morisot.1015granger.net>
 <158152394998.433502.5623790463334839091.stgit@morisot.1015granger.net>
 <20200212182638.GA31668@ziepe.ca>
 <F7B6A553-0355-41BF-A209-E8D73D15A6A9@oracle.com>
 <20200212190545.GB31668@ziepe.ca>
 <B9D0EE52-469B-4CC4-A944-C3421DBB68B6@oracle.com>
 <20200212193036.GD31668@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130115
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 12, 2020, at 2:30 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Wed, Feb 12, 2020 at 02:09:03PM -0500, Chuck Lever wrote:
>>=20
>>=20
>>> On Feb 12, 2020, at 2:05 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>=20
>>> On Wed, Feb 12, 2020 at 01:38:59PM -0500, Chuck Lever wrote:
>>>>=20
>>>>> On Feb 12, 2020, at 1:26 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>>>=20
>>>>> On Wed, Feb 12, 2020 at 11:12:30AM -0500, Chuck Lever wrote:
>>>>>> The @nents value that was passed to ib_dma_map_sg() has to be =
passed
>>>>>> to the matching ib_dma_unmap_sg() call. If ib_dma_map_sg() choses =
to
>>>>>> concatenate sg entries, it will return a different nents value =
than
>>>>>> it was passed.
>>>>>>=20
>>>>>> The bug was exposed by recent changes to the AMD IOMMU driver, =
which
>>>>>> enabled sg entry concatenation.
>>>>>>=20
>>>>>> Looking all the way back to commit 4143f34e01e9 ("xprtrdma: Port =
to
>>>>>> new memory registration API") and reviewing other kernel ULPs, =
it's
>>>>>> not clear that the frwr_map() logic was ever correct for this =
case.
>>>>>>=20
>>>>>> Reported-by: Andre Tomt <andre@tomt.net>
>>>>>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>>>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>>> Cc: stable@vger.kernel.org # v5.5
>>>>>> net/sunrpc/xprtrdma/frwr_ops.c |   13 +++++++------
>>>>>> 1 file changed, 7 insertions(+), 6 deletions(-)
>>>>>=20
>>>>> Yep
>>>>>=20
>>>>> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
>>>>=20
>>>> Thanks.
>>>>=20
>>>> Wondering if it makes sense to add a Fixes tag for the AMD IOMMU =
commit
>>>> where NFS/RDMA stopped working, rather than the "Cc: stable # =
v5.5".
>>>>=20
>>>> Fixes: be62dbf554c5 ("iommu/amd: Convert AMD iommu driver to the =
dma-iommu api")
>>>=20
>>> Not really, this was broken for other configurations besides AMD
>>=20
>> Agreed, but the bug seems to have been inconsequential until now?
>=20
> I imagine it would get you on ARM or other archs, IIRC.

That's certainly plausible, but I haven't received explicit bug reports
in this area. (I'm not at all saying that such bugs categorically do
not exist).

In any event, practical matters: the posted patch applies back to v5.4,
but fails to apply starting with v5.3.

I think we can leave the "Cc: stable # v5.5"; and I'm open to requests
to backport this simple fix onto earlier stable kernels (back to v4.4),
which can be handled case-by-case. 'Salright?

--
Chuck Lever



