Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D816715ACC7
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2020 17:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgBLQFi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Feb 2020 11:05:38 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48414 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgBLQFi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Feb 2020 11:05:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CG37ZL109887;
        Wed, 12 Feb 2020 16:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=f34pvIGvMHLVeIMX6ougLpLSf2lM8o1tQKkq/eUVHf4=;
 b=eH0W7rgmbQWmIcMIOVkuQW+knXhnqq7HldHsuYx6N5Q1dw6DqJHTtGFHWeIwJHdui5dD
 YFu313zNQ+7u/YOsD0K2QU+dNzwlDFKJeCt22UawT5eCoAEKf0Mpjlxh2LvkiwoOEMmr
 STRL+59xcLgiWFEJWwRJi+DewRm4KTu5b2TFFo0u+y1i0Camyh4aXO8qt7dGKJPpexdA
 6b7WCEZnfDBmVsOLE0qAsg3H/dqK3yU3jsYK4rx/+daRCJfAViN145pxnEbs/jKItUTi
 2/T2yD3gWFQDyUPL2LeCSNPj3DtRd8r3A8sYLp25S585IJ6gDxIqKogeKfv9Gv9JErf+ Gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2y2p3skpkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 16:05:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CG2xLa035969;
        Wed, 12 Feb 2020 16:05:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2y4k30y0jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 16:05:33 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01CG5W2G025605;
        Wed, 12 Feb 2020 16:05:32 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 08:05:32 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] xprtrdma: Fix DMA scatter-gather list mapping
 imbalance
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1d2693b1-b37f-c611-91c3-55b567be5274@tomt.net>
Date:   Wed, 12 Feb 2020 11:05:31 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E4C9BADB-72EA-4F39-9837-675C7E7E2CCF@oracle.com>
References: <158151473332.515306.1111360128438553868.stgit@morisot.1015granger.net>
 <869DC73D-190E-46AB-B8F8-1A394F92AF41@oracle.com>
 <1d2693b1-b37f-c611-91c3-55b567be5274@tomt.net>
To:     Andre Tomt <andre@tomt.net>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120123
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 12, 2020, at 11:03 AM, Andre Tomt <andre@tomt.net> wrote:
>=20
> On 12.02.2020 14:48, Chuck Lever wrote:
>>> On Feb 12, 2020, at 8:43 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>>=20
>>> The @nents value that was passed to ib_dma_map_sg() has to be passed
>>> to the matching ib_dma_unmap_sg() call. If ib_dma_map_sg() choses to
>>> concatenate sg entries, it will return a different nents value than
>>> it was passed.
>>>=20
>>> The bug was exposed by recent changes to the AMD IOMMU driver, which
>>> enabled sg entry concatenation.
>>>=20
>>> Looking all the way back to 4143f34e01e9 ("xprtrdma: Port to new
>>> memory registration API") and reviewing other kernel ULPs, it's not
>>> clear that the frwr_map() logic was ever correct for this case.
>>>=20
>>> Reported-by: Andre Tomt <andre@tomt.net>
>>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>> include/trace/events/rpcrdma.h |    6 ++++--
>>> net/sunrpc/xprtrdma/frwr_ops.c |   13 +++++++------
>>> 2 files changed, 11 insertions(+), 8 deletions(-)
>>>=20
>>> Hi Andre, here's take 2, based on the trace data you sent me.
>>> Please let me know if this one fares any better.
>>>=20
>>> Changes since v1:
>>> - Ensure the correct nents value is passed to ib_map_mr_sg
>>> - Record the mr_nents value in the MR trace points
> Verified working (with the patch correction) in my environment, with =
some quick testing (mount + some random and bulk I/O)
>=20
> client, 5.5.3 + patch + amd iommu on =3D OK
> client, 5.5.3 + patch + amd iommu off =3D OK
> client, 5.6-rc1 + patch + amd iommu on =3D OK
>=20
> server, 5.5.3 + patch + intel iommu on =3D OK

Very good! I'll submit the fix through the NFS tree ASAP, and request =
backport to v5.5 stable.

--
Chuck Lever



