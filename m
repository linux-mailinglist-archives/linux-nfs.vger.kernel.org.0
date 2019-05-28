Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 705842CFCC
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 21:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfE1TxG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 15:53:06 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57310 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfE1TxG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 15:53:06 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SJiQjU155814;
        Tue, 28 May 2019 19:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=xLTixY+TIXs+n+RACM48MRPmMnJPEf9Jov1BT+bmY8M=;
 b=CJ0ou2jfE8xdP6aqnQQPJ2JpcOEREkw5+ChTAk11Cu8poIyBf8vLHoSMzd3K6cQaSTP7
 rlL1tbEhSfSmGAf41iY4wGOuqqoebjlBzd8rwquB2qSvku6H/8Q+Yq1zDQ/mgXMzq0H6
 5Yr/cdM1PJA1HZ4eXnnn1HaqztRMcrIJCnbkrT18lkW4onWRqO8ByhHybv7QGssqJOFA
 Bfv8HIQZQwRoNXy08mXPnkdO2/1OsX6QaAJ4FCjeyVyT1ri9lki8a7Fh3h2Oqs/Y95xJ
 UEajnXG5X+BnPgnGEEr8rSfZ6LjcFi4Naa/2cKedoF32WaX2ZGdDyLBng4pAVVW5BpAO gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2spu7ddrgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 19:53:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SJqwcL017525;
        Tue, 28 May 2019 19:53:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ss1fn2k6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 19:53:00 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4SJqxFF023616;
        Tue, 28 May 2019 19:53:00 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 12:52:59 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH 5/5] SUNRPC: Reduce the priority of the xprtiod queue
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2fd3177890a8c8fba9b40468df213bafa30b5481.camel@hammerspace.com>
Date:   Tue, 28 May 2019 15:52:58 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B9863294-2962-42CC-9D58-DC24F9A55938@oracle.com>
References: <20190503111841.4391-1-trond.myklebust@hammerspace.com>
 <20190503111841.4391-2-trond.myklebust@hammerspace.com>
 <20190503111841.4391-3-trond.myklebust@hammerspace.com>
 <20190503111841.4391-4-trond.myklebust@hammerspace.com>
 <20190503111841.4391-5-trond.myklebust@hammerspace.com>
 <20190503111841.4391-6-trond.myklebust@hammerspace.com>
 <65D12050-BF24-4922-A287-3A4D981BD635@oracle.com>
 <12C94CD2-5E07-4C12-B7F6-78B433327361@oracle.com>
 <2fd3177890a8c8fba9b40468df213bafa30b5481.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280123
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 28, 2019, at 3:33 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Tue, 2019-05-28 at 15:03 -0400, Chuck Lever wrote:
>> Following up on this. Now with even more data!
>>=20
>>> On May 6, 2019, at 4:41 PM, Chuck Lever <chuck.lever@oracle.com>
>>> wrote:
>>>=20
>>>=20
>>>> On May 3, 2019, at 7:18 AM, Trond Myklebust <trondmy@gmail.com>
>>>> wrote:
>>>>=20
>>>> Allow more time for softirqd
>>>=20
>>> Have you thought about performance tests for this one?
>>=20
>> I tested this series on my 12-core two-socket client using a variety
>> of tests including iozone, fio, and fstests. The network under test
>> is 56Gb InfiniBand (TCP uses IPoIB). I tested both TCP and RDMA.
>>=20
>> With lock debugging and memory leak testing enabled, I did not see
>> any functional regressions or new leaks or crashes. Thus IMO this
>> series is "safe to apply."
>>=20
>> With TCP, I saw no change in performance between a "stock" kernel
>> and one with all five patches in this series applied, as, IIRC,
>> you predicted.
>>=20
>> The following discussion is based on testing with NFS/RDMA.
>>=20
>> With RDMA, I saw an improvement of 5-10% in IOPS rate between the
>> "stock" kernel and a kernel with the first four patches applied. When
>> the fifth patch is applied, I saw IOPS throughput significantly worse
>> than "stock" -- like 20% worse.
>>=20
>> I also studied average RPC execution time (the "execute" metric) with
>> the "stock" kernel, the one with four patches applied, and with the
>> one where all five are applied. The workload is 100% 4KB READs with
>> an iodepth of 1024 in order to saturate the transmit queue.
>>=20
>> With four patches, the execute time is about 2.5 msec faster (average
>> execution time is around 75 msec due to the large backlog this test
>> generates). With five patches, it's slower than "stock" by 12 msec.
>>=20
>> I also saw a 30 usec improvement in the average latency of
>> xprt_complete_rqst with the four patch series.
>>=20
>> As far as I can tell, the benefit of this series comes mostly from
>> the third patch, which changes spin_lock_bh(&xprt->transport_lock) to
>> spin_lock(&xprt->transport_lock). When the xprtiod work queue is
>> lowered in priority in 5/5, that benefit vanishes.
>>=20
>> I am still confused about why 5/5 is needed. I did not see any soft
>> lockups without this patch applied when using RDMA. Is the issue
>> with xprtsock's use of xprtiod for handling incoming TCP receives?
>>=20
>> I still have some things I'd like to look at. One thing I haven't
>> yet tried is looking at lock_stat, which would confirm or refute
>> my theory that this is all about the transport_lock, for instance.
>>=20
>=20
> OK. I can drop 5/5.
>=20
> The issue there was not about soft lockups. However since we were
> previously running most soft irqs as part of spin_unlock_bh(), the
> question was whether or not we would see more of them needing to move
> to softirqd. As far as I can see, your answer to that question is 'no'
> (at least for your system).

The top contended lock now is the work queue lock. I believe that's a
full irqsave lock. Someone should try testing on a single core system.

I also plan to try this series on my mlx5_en system. The mlx5 Ethernet
driver does a lot more work in soft IRQ than mlx4/IB does.


--
Chuck Lever



