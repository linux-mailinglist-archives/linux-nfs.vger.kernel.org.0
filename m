Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDB978DC0
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2019 16:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfG2OY3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jul 2019 10:24:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44552 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfG2OY3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jul 2019 10:24:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6TEJBih052691;
        Mon, 29 Jul 2019 14:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=1qdqjCkA/mfxasEl5KR5f7Kd6vzrOzS/W9lw2+2mkzs=;
 b=RAAkxuTyG6ifTCRLKtFDJUpIqGzZ79dmmxg3/jzvPON2motynf2Sr3GDJXAnrHkGhcDh
 wq6JWj6VX9+8JutdIjS1mahVR9gUvru9RP5p5ZWknSgDb9g+a/DPaKT6jcSOBYp38LRg
 SbnuNuH55bCNlPDH25NvVcrVTyRNLkv2kmxAD+KyP5y3/TtDM+GUKZqy5s8YDZmVgJNY
 zZ2dL45o6gF5PGNcrjHR+lvtOaiZXTRoCABXLtomgLFiWid40eARTNbU1jjaHsLndmt8
 6RzabVfSNb+lghU6SZYKRDv366Zh0AvqbvlCFU3FxZeH4Udu6caQq0pdJ1Cv59WnRNxT sQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u0f8qqp4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jul 2019 14:24:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6TEMraC059576;
        Mon, 29 Jul 2019 14:24:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2u0xv7hqsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jul 2019 14:24:16 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6TEOEbt012597;
        Mon, 29 Jul 2019 14:24:14 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jul 2019 07:24:14 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] rdma: Enable ib_alloc_cq to spread work over a
 device's comp_vectors
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190729054933.GK4674@mtr-leonro.mtl.com>
Date:   Mon, 29 Jul 2019 10:24:12 -0400
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-cifs@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <9AF784D9-E0B4-473F-9D5F-7858F6FE1FDD@oracle.com>
References: <20190728163027.3637.70740.stgit@manet.1015granger.net>
 <20190729054933.GK4674@mtr-leonro.mtl.com>
To:     Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907290165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907290165
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 29, 2019, at 1:49 AM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Sun, Jul 28, 2019 at 12:30:27PM -0400, Chuck Lever wrote:
>> Send and Receive completion is handled on a single CPU selected at
>> the time each Completion Queue is allocated. Typically this is when
>> an initiator instantiates an RDMA transport, or when a target
>> accepts an RDMA connection.
>>=20
>> Some ULPs cannot open a connection per CPU to spread completion
>> workload across available CPUs and MSI vectors. For such ULPs,
>> provide an API that allows the RDMA core to select a completion
>> vector based on the device's complement of available comp_vecs.
>>=20
>> ULPs that invoke ib_alloc_cq() with only comp_vector 0 are converted
>> to use the new API so that their completion workloads interfere less
>> with each other.
>>=20
>> Suggested-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> Cc: <linux-cifs@vger.kernel.org>
>> Cc: <v9fs-developer@lists.sourceforge.net>
>> ---
>> drivers/infiniband/core/cq.c             |   29 =
+++++++++++++++++++++++++++++
>> drivers/infiniband/ulp/srpt/ib_srpt.c    |    4 ++--
>> fs/cifs/smbdirect.c                      |   10 ++++++----
>> include/rdma/ib_verbs.h                  |   19 +++++++++++++++++++
>> net/9p/trans_rdma.c                      |    6 +++---
>> net/sunrpc/xprtrdma/svc_rdma_transport.c |    8 ++++----
>> net/sunrpc/xprtrdma/verbs.c              |   13 ++++++-------
>> 7 files changed, 69 insertions(+), 20 deletions(-)
>>=20
>> diff --git a/drivers/infiniband/core/cq.c =
b/drivers/infiniband/core/cq.c
>> index 7c59987..ea3bb0d 100644
>> --- a/drivers/infiniband/core/cq.c
>> +++ b/drivers/infiniband/core/cq.c
>> @@ -253,6 +253,35 @@ struct ib_cq *__ib_alloc_cq_user(struct =
ib_device *dev, void *private,
>> EXPORT_SYMBOL(__ib_alloc_cq_user);
>>=20
>> /**
>> + * __ib_alloc_cq_any - allocate a completion queue
>> + * @dev:		device to allocate the CQ for
>> + * @private:		driver private data, accessible from =
cq->cq_context
>> + * @nr_cqe:		number of CQEs to allocate
>> + * @poll_ctx:		context to poll the CQ from.
>> + * @caller:		module owner name.
>> + *
>> + * Attempt to spread ULP Completion Queues over each device's =
interrupt
>> + * vectors.
>> + */
>> +struct ib_cq *__ib_alloc_cq_any(struct ib_device *dev, void =
*private,
>> +				int nr_cqe, enum ib_poll_context =
poll_ctx,
>> +				const char *caller)
>> +{
>> +	static atomic_t counter;
>> +	int comp_vector;
>=20
> int comp_vector =3D 0;
>=20
>> +
>> +	comp_vector =3D 0;
>=20
> This assignment is better to be part of initialization.
>=20
>> +	if (dev->num_comp_vectors > 1)
>> +		comp_vector =3D
>> +			atomic_inc_return(&counter) %
>=20
> Don't we need manage "free list" of comp_vectors? Otherwise we can =
find
> ourselves providing already "taken" comp_vector.

Many ULPs use only comp_vector 0 today. It is obviously harmless
to have more than one ULP using the same comp_vector.

The point of this patch is best effort spreading. This algorithm
has been proposed repeatedly for several years on this list, and
each time the consensus has been this is simple and good enough.


> Just as an example:
> dev->num_comp_vectors =3D 2
> num_online_cpus =3D 4
>=20
> The following combination will give us same comp_vector:
> 1. ib_alloc_cq_any()
> 2. ib_alloc_cq_any()
> 3. ib_free_cq()
> 4. goto 2
>=20
>> +			min_t(int, dev->num_comp_vectors, =
num_online_cpus());
>> +
>> +	return __ib_alloc_cq_user(dev, private, nr_cqe, comp_vector, =
poll_ctx,
>> +				  caller, NULL);
>> +}
>> +EXPORT_SYMBOL(__ib_alloc_cq_any);
>> +
>> +/**
>>  * ib_free_cq_user - free a completion queue
>>  * @cq:		completion queue to free.
>>  * @udata:	User data or NULL for kernel object
>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c =
b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> index 1a039f1..e25c70a 100644
>> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> @@ -1767,8 +1767,8 @@ static int srpt_create_ch_ib(struct =
srpt_rdma_ch *ch)
>> 		goto out;
>>=20
>> retry:
>> -	ch->cq =3D ib_alloc_cq(sdev->device, ch, ch->rq_size + sq_size,
>> -			0 /* XXX: spread CQs */, IB_POLL_WORKQUEUE);
>> +	ch->cq =3D ib_alloc_cq_any(sdev->device, ch, ch->rq_size + =
sq_size,
>> +				 IB_POLL_WORKQUEUE);
>> 	if (IS_ERR(ch->cq)) {
>> 		ret =3D PTR_ERR(ch->cq);
>> 		pr_err("failed to create CQ cqe=3D %d ret=3D %d\n",
>> diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
>> index cd07e53..3c91fa9 100644
>> --- a/fs/cifs/smbdirect.c
>> +++ b/fs/cifs/smbdirect.c
>> @@ -1654,15 +1654,17 @@ static struct smbd_connection =
*_smbd_get_connection(
>>=20
>> 	info->send_cq =3D NULL;
>> 	info->recv_cq =3D NULL;
>> -	info->send_cq =3D ib_alloc_cq(info->id->device, info,
>> -			info->send_credit_target, 0, IB_POLL_SOFTIRQ);
>> +	info->send_cq =3D
>> +		ib_alloc_cq_any(info->id->device, info,
>> +				info->send_credit_target, =
IB_POLL_SOFTIRQ);
>> 	if (IS_ERR(info->send_cq)) {
>> 		info->send_cq =3D NULL;
>> 		goto alloc_cq_failed;
>> 	}
>>=20
>> -	info->recv_cq =3D ib_alloc_cq(info->id->device, info,
>> -			info->receive_credit_max, 0, IB_POLL_SOFTIRQ);
>> +	info->recv_cq =3D
>> +		ib_alloc_cq_any(info->id->device, info,
>> +				info->receive_credit_max, =
IB_POLL_SOFTIRQ);
>> 	if (IS_ERR(info->recv_cq)) {
>> 		info->recv_cq =3D NULL;
>> 		goto alloc_cq_failed;
>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>> index c5f8a9f..2a1523cc 100644
>> --- a/include/rdma/ib_verbs.h
>> +++ b/include/rdma/ib_verbs.h
>> @@ -3711,6 +3711,25 @@ static inline struct ib_cq *ib_alloc_cq(struct =
ib_device *dev, void *private,
>> 				NULL);
>> }
>>=20
>> +struct ib_cq *__ib_alloc_cq_any(struct ib_device *dev, void =
*private,
>> +				int nr_cqe, enum ib_poll_context =
poll_ctx,
>> +				const char *caller);
>> +
>> +/**
>> + * ib_alloc_cq_any: Allocate kernel CQ
>> + * @dev: The IB device
>> + * @private: Private data attached to the CQE
>> + * @nr_cqe: Number of CQEs in the CQ
>> + * @poll_ctx: Context used for polling the CQ
>> + */
>> +static inline struct ib_cq *ib_alloc_cq_any(struct ib_device *dev,
>> +					    void *private, int nr_cqe,
>> +					    enum ib_poll_context =
poll_ctx)
>> +{
>> +	return __ib_alloc_cq_any(dev, private, nr_cqe, poll_ctx,
>> +				 KBUILD_MODNAME);
>> +}
>=20
> This should be macro and not inline function, because compiler can be
> instructed do not inline functions (there is kconfig option for that)
> and it will cause that wrong KBUILD_MODNAME will be inserted (ib_core
> instead of ulp).
>=20
> And yes, commit c4367a26357b ("IB: Pass uverbs_attr_bundle down ib_x
> destroy path") did it completely wrong.

My understanding is the same as Jason's.


>> +
>> /**
>>  * ib_free_cq_user - Free kernel/user CQ
>>  * @cq: The CQ to free
>> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
>> index bac8dad..b21c3c2 100644
>> --- a/net/9p/trans_rdma.c
>> +++ b/net/9p/trans_rdma.c
>> @@ -685,9 +685,9 @@ static int p9_rdma_bind_privport(struct =
p9_trans_rdma *rdma)
>> 		goto error;
>>=20
>> 	/* Create the Completion Queue */
>> -	rdma->cq =3D ib_alloc_cq(rdma->cm_id->device, client,
>> -			opts.sq_depth + opts.rq_depth + 1,
>> -			0, IB_POLL_SOFTIRQ);
>> +	rdma->cq =3D ib_alloc_cq_any(rdma->cm_id->device, client,
>> +				   opts.sq_depth + opts.rq_depth + 1,
>> +				   IB_POLL_SOFTIRQ);
>> 	if (IS_ERR(rdma->cq))
>> 		goto error;
>>=20
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c =
b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> index 3fe6651..4d3db6e 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
>> @@ -454,14 +454,14 @@ static struct svc_xprt *svc_rdma_accept(struct =
svc_xprt *xprt)
>> 		dprintk("svcrdma: error creating PD for connect =
request\n");
>> 		goto errout;
>> 	}
>> -	newxprt->sc_sq_cq =3D ib_alloc_cq(dev, newxprt, =
newxprt->sc_sq_depth,
>> -					0, IB_POLL_WORKQUEUE);
>> +	newxprt->sc_sq_cq =3D ib_alloc_cq_any(dev, newxprt, =
newxprt->sc_sq_depth,
>> +					    IB_POLL_WORKQUEUE);
>> 	if (IS_ERR(newxprt->sc_sq_cq)) {
>> 		dprintk("svcrdma: error creating SQ CQ for connect =
request\n");
>> 		goto errout;
>> 	}
>> -	newxprt->sc_rq_cq =3D ib_alloc_cq(dev, newxprt, rq_depth,
>> -					0, IB_POLL_WORKQUEUE);
>> +	newxprt->sc_rq_cq =3D
>> +		ib_alloc_cq_any(dev, newxprt, rq_depth, =
IB_POLL_WORKQUEUE);
>> 	if (IS_ERR(newxprt->sc_rq_cq)) {
>> 		dprintk("svcrdma: error creating RQ CQ for connect =
request\n");
>> 		goto errout;
>> diff --git a/net/sunrpc/xprtrdma/verbs.c =
b/net/sunrpc/xprtrdma/verbs.c
>> index 805b1f35..b10aa16 100644
>> --- a/net/sunrpc/xprtrdma/verbs.c
>> +++ b/net/sunrpc/xprtrdma/verbs.c
>> @@ -521,18 +521,17 @@ int rpcrdma_ep_create(struct rpcrdma_xprt =
*r_xprt)
>> 	init_waitqueue_head(&ep->rep_connect_wait);
>> 	ep->rep_receive_count =3D 0;
>>=20
>> -	sendcq =3D ib_alloc_cq(ia->ri_id->device, NULL,
>> -			     ep->rep_attr.cap.max_send_wr + 1,
>> -			     ia->ri_id->device->num_comp_vectors > 1 ? 1 =
: 0,
>> -			     IB_POLL_WORKQUEUE);
>> +	sendcq =3D ib_alloc_cq_any(ia->ri_id->device, NULL,
>> +				 ep->rep_attr.cap.max_send_wr + 1,
>> +				 IB_POLL_WORKQUEUE);
>> 	if (IS_ERR(sendcq)) {
>> 		rc =3D PTR_ERR(sendcq);
>> 		goto out1;
>> 	}
>>=20
>> -	recvcq =3D ib_alloc_cq(ia->ri_id->device, NULL,
>> -			     ep->rep_attr.cap.max_recv_wr + 1,
>> -			     0, IB_POLL_WORKQUEUE);
>> +	recvcq =3D ib_alloc_cq_any(ia->ri_id->device, NULL,
>> +				 ep->rep_attr.cap.max_recv_wr + 1,
>> +				 IB_POLL_WORKQUEUE);
>> 	if (IS_ERR(recvcq)) {
>> 		rc =3D PTR_ERR(recvcq);
>> 		goto out2;

--
Chuck Lever



