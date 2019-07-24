Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0643073090
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2019 16:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfGXOBn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Jul 2019 10:01:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54808 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfGXOBm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Jul 2019 10:01:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6ODwaJ8127973;
        Wed, 24 Jul 2019 14:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=p5+J4+T1cKwr1UY7FwBFlqqWsMQRrVqKRMVYskH/Vao=;
 b=ibWcY6ORyYhSsRk4lJX5k05NRkjGonmO4dGR5lMgzej+o5Y9n5N8kuyjaYYJ+RBYqwfw
 O9P2UjdBwik/0dRUTZ+0+i5N5O6pvdZI35qC9NZv66G0kiknFnnOrulAj/sj4d1QTqdO
 Jg5BnXopnvZNumNRiav80Wy4UELOcD6npeZu0uWBjz2Ca4RrqIPaR/FgevuMLHRd1Ah+
 YwI33jPIIzB8ljNBTAEA/Ir9rluvJKUP+Pj+fbqEsc0oS0tcI6659zdz1/ckwPmOTu77
 +E7BIKMKAuFMivNQFf/775pRTgiLDqkfLj20TteOS5ftNBp2xz6Jts0J14CmHffqvdPn Lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tx61bwnke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 14:01:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6ODvdxq044402;
        Wed, 24 Jul 2019 14:01:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tx60xy5s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 14:01:38 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6OE1c3p030123;
        Wed, 24 Jul 2019 14:01:38 GMT
Received: from [172.16.134.18] (/207.115.96.130)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jul 2019 07:01:37 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1] rdma: Enable ib_alloc_cq to spread work over a
 device's comp_vectors
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190724054736.GW5125@mtr-leonro.mtl.com>
Date:   Wed, 24 Jul 2019 10:01:36 -0400
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8AC10EC7-5203-4D82-A455-2589DA6ADB9D@oracle.com>
References: <156390915496.6759.4305845732131573253.stgit@seurat29.1015granger.net>
 <20190724054736.GW5125@mtr-leonro.mtl.com>
To:     Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907240156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907240156
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Leon, thanks for taking a look. Responses below.


> On Jul 24, 2019, at 1:47 AM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Tue, Jul 23, 2019 at 03:13:37PM -0400, Chuck Lever wrote:
>> Send and Receive completion is handled on a single CPU selected at
>> the time each Completion Queue is allocated. Typically this is when
>> an initiator instantiates an RDMA transport, or when a target
>> accepts an RDMA connection.
>>=20
>> Some ULPs cannot open a connection per CPU to spread completion
>> workload across available CPUs. For these ULPs, allow the RDMA core
>> to select a completion vector based on the device's complement of
>> available comp_vecs.
>>=20
>> When a ULP elects to use RDMA_CORE_ANY_COMPVEC, if multiple CPUs are
>> available, a different CPU will be selected for each Completion
>> Queue. For the moment, a simple round-robin mechanism is used.
>>=20
>> Suggested-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>=20
> It make me wonder why do we need comp_vector as an argument to =
ib_alloc_cq?
> =46rom what I see, or callers are internally implementing similar =
logic
> to proposed here, or they don't care (set 0).

The goal of this patch is to deduplicate that "similar logic".
Callers that implement this logic already can use
RDMA_CORE_ANY_COMPVEC and get rid of their own copy.


> Can we enable this comp_vector for everyone and simplify our API?

We could create a new CQ allocation API that does not take a
comp vector. That might be cleaner than passing in a -1.

But I think some ULPs still want to use the existing API to
allocate one CQ for each of a device's comp vectors.


>> ---
>> drivers/infiniband/core/cq.c             |   20 +++++++++++++++++++-
>> include/rdma/ib_verbs.h                  |    3 +++
>> net/sunrpc/xprtrdma/svc_rdma_transport.c |    6 ++++--
>> net/sunrpc/xprtrdma/verbs.c              |    5 ++---
>> 4 files changed, 28 insertions(+), 6 deletions(-)
>>=20
>> Jason-
>>=20
>> If this patch is acceptable to all, then I would expect you to take
>> it through the RDMA tree.
>>=20
>>=20
>> diff --git a/drivers/infiniband/core/cq.c =
b/drivers/infiniband/core/cq.c
>> index 7c599878ccf7..a89d549490c4 100644
>> --- a/drivers/infiniband/core/cq.c
>> +++ b/drivers/infiniband/core/cq.c
>> @@ -165,12 +165,27 @@ static void ib_cq_completion_workqueue(struct =
ib_cq *cq, void *private)
>> 	queue_work(cq->comp_wq, &cq->work);
>> }
>>=20
>> +/*
>> + * Attempt to spread ULP completion queues over a device's =
completion
>> + * vectors so that all available CPU cores can help service the =
device's
>> + * interrupt workload. This mechanism may be improved at a later =
point
>> + * to dynamically take into account the system's actual workload.
>> + */
>> +static int ib_get_comp_vector(struct ib_device *dev)
>> +{
>> +	static atomic_t cv;
>> +
>> +	if (dev->num_comp_vectors > 1)
>> +		return atomic_inc_return(&cv) % dev->num_comp_vectors;
>=20
> It is worth to take into account num_online_cpus(),

I don't believe it is.

H=C3=A5kon has convinced me that assigning interrupt vectors to
CPUs is in the domain of user space (ie, driven by policy).
In addition, one assumes that taking a CPU offline properly
will also involve re-assigning interrupt vectors that point
to that core.

In any event, this code can be modified after it is merged
if it is necessary to accommodate such requirements.

--
Chuck Lever



