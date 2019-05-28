Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 094C52CF27
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 21:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfE1TEB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 15:04:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52496 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfE1TEB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 15:04:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SIx0QB100194;
        Tue, 28 May 2019 19:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=7/hDi0qTYa4JisZUQMogkkmi0jv/asin5TlKOQ7VUOQ=;
 b=U+FX2h3pBX66Xe6xa9/cyiavfubGVQqpWMQdLIdM8LakV3hZ1os0EfPT8bZcvmnnnwBe
 gy9ZIAw5+x2k/limrJdg+di6NyRiRDV3Rxhi+NIUzRSELlZchVUASIdjVKWCcQtjrx8h
 rO57DJxklg41oWMcDkWEBtKD7ivVmkp9zpYqXnxCiThxQZbECq4gxc1QGlVtTXhkIrEd
 8qkAwjkCzXhb1kU0AMcFym9irA4yC/YsDxiz7I94osEoW7RYFHl9TpntTgyUYED8u09g
 LAjsbkh88LXyEsGJ+5pVVuV9nnlQ3edfE+fRFksjAnAfSCW8oXAcEVlgjVwpms2phG1r sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2spw4tda97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 19:03:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SJ3NO3091186;
        Tue, 28 May 2019 19:03:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ss1fn1umt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 19:03:58 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4SJ3vNQ010312;
        Tue, 28 May 2019 19:03:57 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 12:03:57 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH 5/5] SUNRPC: Reduce the priority of the xprtiod queue
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <65D12050-BF24-4922-A287-3A4D981BD635@oracle.com>
Date:   Tue, 28 May 2019 15:03:56 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <12C94CD2-5E07-4C12-B7F6-78B433327361@oracle.com>
References: <20190503111841.4391-1-trond.myklebust@hammerspace.com>
 <20190503111841.4391-2-trond.myklebust@hammerspace.com>
 <20190503111841.4391-3-trond.myklebust@hammerspace.com>
 <20190503111841.4391-4-trond.myklebust@hammerspace.com>
 <20190503111841.4391-5-trond.myklebust@hammerspace.com>
 <20190503111841.4391-6-trond.myklebust@hammerspace.com>
 <65D12050-BF24-4922-A287-3A4D981BD635@oracle.com>
To:     Trond Myklebust <trondmy@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280119
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Following up on this. Now with even more data!

> On May 6, 2019, at 4:41 PM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
>=20
>> On May 3, 2019, at 7:18 AM, Trond Myklebust <trondmy@gmail.com> =
wrote:
>>=20
>> Allow more time for softirqd
>=20
> Have you thought about performance tests for this one?

I tested this series on my 12-core two-socket client using a variety
of tests including iozone, fio, and fstests. The network under test
is 56Gb InfiniBand (TCP uses IPoIB). I tested both TCP and RDMA.

With lock debugging and memory leak testing enabled, I did not see
any functional regressions or new leaks or crashes. Thus IMO this
series is "safe to apply."

With TCP, I saw no change in performance between a "stock" kernel
and one with all five patches in this series applied, as, IIRC,
you predicted.

The following discussion is based on testing with NFS/RDMA.

With RDMA, I saw an improvement of 5-10% in IOPS rate between the
"stock" kernel and a kernel with the first four patches applied. When
the fifth patch is applied, I saw IOPS throughput significantly worse
than "stock" -- like 20% worse.

I also studied average RPC execution time (the "execute" metric) with
the "stock" kernel, the one with four patches applied, and with the
one where all five are applied. The workload is 100% 4KB READs with
an iodepth of 1024 in order to saturate the transmit queue.

With four patches, the execute time is about 2.5 msec faster (average
execution time is around 75 msec due to the large backlog this test
generates). With five patches, it's slower than "stock" by 12 msec.

I also saw a 30 usec improvement in the average latency of
xprt_complete_rqst with the four patch series.

As far as I can tell, the benefit of this series comes mostly from
the third patch, which changes spin_lock_bh(&xprt->transport_lock) to
spin_lock(&xprt->transport_lock). When the xprtiod work queue is
lowered in priority in 5/5, that benefit vanishes.

I am still confused about why 5/5 is needed. I did not see any soft
lockups without this patch applied when using RDMA. Is the issue
with xprtsock's use of xprtiod for handling incoming TCP receives?

I still have some things I'd like to look at. One thing I haven't
yet tried is looking at lock_stat, which would confirm or refute
my theory that this is all about the transport_lock, for instance.


>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> ---
>> net/sunrpc/sched.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
>> index c7e81336620c..6b37c9a4b48f 100644
>> --- a/net/sunrpc/sched.c
>> +++ b/net/sunrpc/sched.c
>> @@ -1253,7 +1253,7 @@ static int rpciod_start(void)
>> 		goto out_failed;
>> 	rpciod_workqueue =3D wq;
>> 	/* Note: highpri because network receive is latency sensitive */
>=20
> The above comment should be deleted as well.
>=20
>=20
>> -	wq =3D alloc_workqueue("xprtiod", =
WQ_UNBOUND|WQ_MEM_RECLAIM|WQ_HIGHPRI, 0);
>> +	wq =3D alloc_workqueue("xprtiod", WQ_MEM_RECLAIM | WQ_UNBOUND, =
0);
>> 	if (!wq)
>> 		goto free_rpciod;
>> 	xprtiod_workqueue =3D wq;
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--
Chuck Lever



