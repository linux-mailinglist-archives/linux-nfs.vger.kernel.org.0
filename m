Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D658075086
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jul 2019 16:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfGYOFZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Jul 2019 10:05:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35460 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfGYOFZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Jul 2019 10:05:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6PE4IwV048953;
        Thu, 25 Jul 2019 14:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=7FQi80gvJ0Tra/F/Rx8SxIih9lm3KJ2f5RsjJd+Jt10=;
 b=D8vFLMczoumOtpwISLvoYpWxiIg51R1FPKJ+4iKsMjzipAmW6WoxiP3iSlURSflbbENp
 WWbeJSjb5tJcOWClUGxwdJvaXT8nQR9dCtXwSZlAJOjHeJh4vwdvZ3e5DAQcEvdXPqmJ
 VaGBIRbi3A+lM9AzfsxJoq65vBr0K8rXoUQgutzOYkKWWFIezwF73QoNYUWNb73jOgwd
 KSyM/aqZ0k0l/KlJmez0pP/cidrsPztNTIRHR+jG1rYB7BCghB7F+xC5WON0+IkMRDbD
 8CPlPHRN7yLGs9rtp6HfVBvW7vODraijPeFPhTA57C3njOeT7apfeZ/1oCwvJDMLPqNl TQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2tx61c491m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 14:05:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6PE3BYZ162060;
        Thu, 25 Jul 2019 14:03:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2tx60yb8ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 14:03:23 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6PE3LtQ031186;
        Thu, 25 Jul 2019 14:03:21 GMT
Received: from dhcp-82c9.meeting.ietf.org (/31.133.130.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Jul 2019 07:03:14 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1] rdma: Enable ib_alloc_cq to spread work over a
 device's comp_vectors
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190725131715.GF4674@mtr-leonro.mtl.com>
Date:   Thu, 25 Jul 2019 10:03:13 -0400
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A698820-DE08-44F2-BA30-F62FDD035D22@oracle.com>
References: <156390915496.6759.4305845732131573253.stgit@seurat29.1015granger.net>
 <20190724054736.GW5125@mtr-leonro.mtl.com>
 <8AC10EC7-5203-4D82-A455-2589DA6ADB9D@oracle.com>
 <20190725131715.GF4674@mtr-leonro.mtl.com>
To:     Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=989
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907250164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907250165
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 25, 2019, at 9:17 AM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Wed, Jul 24, 2019 at 10:01:36AM -0400, Chuck Lever wrote:
>> Hi Leon, thanks for taking a look. Responses below.
>>=20
>>=20
>>> On Jul 24, 2019, at 1:47 AM, Leon Romanovsky <leon@kernel.org> =
wrote:
>>>=20
>>> On Tue, Jul 23, 2019 at 03:13:37PM -0400, Chuck Lever wrote:
>>>> Send and Receive completion is handled on a single CPU selected at
>>>> the time each Completion Queue is allocated. Typically this is when
>>>> an initiator instantiates an RDMA transport, or when a target
>>>> accepts an RDMA connection.
>>>>=20
>>>> Some ULPs cannot open a connection per CPU to spread completion
>>>> workload across available CPUs. For these ULPs, allow the RDMA core
>>>> to select a completion vector based on the device's complement of
>>>> available comp_vecs.
>>>>=20
>>>> When a ULP elects to use RDMA_CORE_ANY_COMPVEC, if multiple CPUs =
are
>>>> available, a different CPU will be selected for each Completion
>>>> Queue. For the moment, a simple round-robin mechanism is used.
>>>>=20
>>>> Suggested-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>=20
>>> It make me wonder why do we need comp_vector as an argument to =
ib_alloc_cq?
>>> =46rom what I see, or callers are internally implementing similar =
logic
>>> to proposed here, or they don't care (set 0).
>>=20
>> The goal of this patch is to deduplicate that "similar logic".
>> Callers that implement this logic already can use
>> RDMA_CORE_ANY_COMPVEC and get rid of their own copy.
>=20
> Can you please send removal patches together with this API proposal?
> It will ensure that ULPs authors will notice such changes and we won't
> end with special function for one ULP.

I prefer that the maintainers of those ULPs make those changes.
It would require testing that I am not in a position to do myself.

I can add a couple of other ULPs, like cifs and 9p, which look
like straightforward modifications; but my understanding was that
only one user of a new API was required for adoption.


>>> Can we enable this comp_vector for everyone and simplify our API?
>>=20
>> We could create a new CQ allocation API that does not take a
>> comp vector. That might be cleaner than passing in a -1.
>=20
> +1

I'll send a v2 with this suggestion.


>> But I think some ULPs still want to use the existing API to
>> allocate one CQ for each of a device's comp vectors.
>=20
> It can be "legacy implementation", which is not really needed,
> but I don't really know about it.

Have a look at the iSER initiator. There are legitimate use cases
in the kernel for the current ib_alloc_cq() API.

And don't forget the many users of ib_create_cq that remain in
the kernel.


>>>> ---
>>>> drivers/infiniband/core/cq.c             |   20 =
+++++++++++++++++++-
>>>> include/rdma/ib_verbs.h                  |    3 +++
>>>> net/sunrpc/xprtrdma/svc_rdma_transport.c |    6 ++++--
>>>> net/sunrpc/xprtrdma/verbs.c              |    5 ++---
>>>> 4 files changed, 28 insertions(+), 6 deletions(-)
>>>>=20
>>>> Jason-
>>>>=20
>>>> If this patch is acceptable to all, then I would expect you to take
>>>> it through the RDMA tree.
>>>>=20
>>>>=20
>>>> diff --git a/drivers/infiniband/core/cq.c =
b/drivers/infiniband/core/cq.c
>>>> index 7c599878ccf7..a89d549490c4 100644
>>>> --- a/drivers/infiniband/core/cq.c
>>>> +++ b/drivers/infiniband/core/cq.c
>>>> @@ -165,12 +165,27 @@ static void ib_cq_completion_workqueue(struct =
ib_cq *cq, void *private)
>>>> 	queue_work(cq->comp_wq, &cq->work);
>>>> }
>>>>=20
>>>> +/*
>>>> + * Attempt to spread ULP completion queues over a device's =
completion
>>>> + * vectors so that all available CPU cores can help service the =
device's
>>>> + * interrupt workload. This mechanism may be improved at a later =
point
>>>> + * to dynamically take into account the system's actual workload.
>>>> + */
>>>> +static int ib_get_comp_vector(struct ib_device *dev)
>>>> +{
>>>> +	static atomic_t cv;
>>>> +
>>>> +	if (dev->num_comp_vectors > 1)
>>>> +		return atomic_inc_return(&cv) % dev->num_comp_vectors;
>>>=20
>>> It is worth to take into account num_online_cpus(),
>>=20
>> I don't believe it is.
>>=20
>> H=C3=A5kon has convinced me that assigning interrupt vectors to
>> CPUs is in the domain of user space (ie, driven by policy).
>> In addition, one assumes that taking a CPU offline properly
>> will also involve re-assigning interrupt vectors that point
>> to that core.
>>=20
>> In any event, this code can be modified after it is merged
>> if it is necessary to accommodate such requirements.
>=20
> It is a simple change, which is worth to do now as long as
> we have interested parties involved here.

Can you propose some code, or point out an example of how you
would prefer it to work?


--
Chuck Lever



