Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2E5E0849
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2019 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbfJVQIN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Oct 2019 12:08:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38940 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbfJVQIN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Oct 2019 12:08:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9MG7ZBd145830;
        Tue, 22 Oct 2019 16:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=kaaT+wFBs/EY2gUbkOpPNJSkxo45bu97p1bzsZSK2hQ=;
 b=EpSdhT4SBeJ21lFqlyAb1qxZmePTZRaahgu8e042pC54Qs98KBCY3lz4TeC+wZfV09tM
 FLXJZP8eWDeHQh32nrqWuajCuxBZv8vSCvE/foQYLsoJd97G5iQKphc2GIGFp4Ixb2I6
 9hj8VYenDMg7sPt57b/BKDZpjTpxbmBmbTgjOBZvGXYzoIzLIqmWnhW+mPTIexwbrZdo
 GrP8qOo49Hkaz0te7yS7oClTWxK7DOVDa7UxrXuI2437ei50Ors+On1zVpznoaeIHhVH
 wngFeSHUUp284ZUuyUavMPMJvUhLbtEP11JDhiIUZJIUgbSXbREVXAInOPjUibv9LjZ/ Ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vqu4qqnhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 16:08:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9MG2rQh051004;
        Tue, 22 Oct 2019 16:08:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vsx231829-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 16:08:08 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9MG88Yp020411;
        Tue, 22 Oct 2019 16:08:08 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Oct 2019 09:08:07 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 6/6] xprtrdma: Pull up sometimes
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <3ef2c12c-cc88-6ac6-25cd-99ef162f70a1@talpey.com>
Date:   Tue, 22 Oct 2019 12:08:06 -0400
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC70F961-3062-4079-A1F0-54B53C6B861B@oracle.com>
References: <20191017182811.2517.25676.stgit@oracle-102.nfsv4bat.org>
 <20191017183152.2517.67599.stgit@oracle-102.nfsv4bat.org>
 <f5075a20-7c9a-773f-e76b-11cba1ab0f16@talpey.com>
 <E1BB2B60-6DE2-47FD-92BA-ED9011C51661@oracle.com>
 <3ef2c12c-cc88-6ac6-25cd-99ef162f70a1@talpey.com>
To:     Tom Talpey <tom@talpey.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910220137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910220137
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 19, 2019, at 12:36 PM, Tom Talpey <tom@talpey.com> wrote:
>=20
> On 10/18/2019 7:34 PM, Chuck Lever wrote:
>> Hi Tom-
>>> On Oct 18, 2019, at 4:17 PM, Tom Talpey <tom@talpey.com> wrote:
>>>=20
>>> On 10/17/2019 2:31 PM, Chuck Lever wrote:
>>>> On some platforms, DMA mapping part of a page is more costly than
>>>> copying bytes. Restore the pull-up code and use that when we
>>>> think it's going to be faster. The heuristic for now is to pull-up
>>>> when the size of the RPC message body fits in the buffer underlying
>>>> the head iovec.
>>>> Indeed, not involving the I/O MMU can help the RPC/RDMA transport
>>>> scale better for tiny I/Os across more RDMA devices. This is =
because
>>>> interaction with the I/O MMU is eliminated, as is handling a Send
>>>> completion, for each of these small I/Os. Without the explicit
>>>> unmapping, the NIC no longer needs to do a costly internal TLB =
shoot
>>>> down for buffers that are just a handful of bytes.
>>>=20
>>> This is good stuff. Do you have any performance data for the new
>>> strategy, especially latencies and local CPU cycles per byte?
>> Saves almost a microsecond of RT latency on my NFS client that uses
>> a real Intel IOMMU. On my other NFS client, the DMA map operations
>> are always a no-op. This savings applies only to NFS WRITE, of =
course.
>> I don't have a good benchmark for cycles per byte. Do you have any
>> suggestions? Not sure how I would account for cycles spent handling
>> Send completions, for example.
>=20
> Cycles per byte is fairly simple but like all performance measurement
> the trick is in the setup. Because of platform variations, it's best
> to compare results on the same hardware. The absolute value isn't as
> meaningful. Here's a rough sketch of one approach.
>=20
> - Configure BIOS and OS to hold CPU frequency constant:
>  - ACPI C-states off
>  - Turbo mode off
>  - Power management off (OS needs this too)
>  - Anything else relevant to clock variation
> - Hyperthreading off
>  - (hyperthreads don't add work linearly)
> - Calculate core count X clock frequency
>  - (e.g. 8 X 3GHz =3D 24G cycles/sec)
>=20
> Now, use a benchmark which runs the desired workload and reports %CPU.
> For a given interval, record the total bytes transferred, time spent,
> and CPU load. (e.g. 100GB, 100 sec, 20%).
>=20
> Finally, compute CpB (the 1/sec terms cancel out):
> 20% x 24Gcps =3D 4.8G cps
> 100GB / 100s =3D 1G bps
> 4.8Gcps / 1 GBps =3D 4.8cpb
>=20
> Like I said, it's rough, but surprisingly telling. A similar metric
> is cycles per IOP, and since you're focusing on small i/o with this
> change, it might also be an interesting calculation. Simply replace
> total bytes/sec with IOPS.

Systems under test:

	=E2=80=A2 12 Haswell cores x 1.6GHz =3D 19.2 billion cps
	=E2=80=A2 Server is exporting a tmpfs filesystem
	=E2=80=A2 Client and server using CX-3 Pro on 56Gbps InfiniBand
	=E2=80=A2 Kernel is v5.4-rc4
	=E2=80=A2 iozone -M -+u -i0 -i1 -s1g -r1k -t12 -I

The purpose of this test is to compare the two kernels, not to publish =
an absolute performance value. Both kernels below have a number of =
CPU-intensive debugging options enabled, which might tend to increase =
CPU cycles per byte or per I/O, and might also amplify the differences =
between the two kernels.



*** With DMA-mapping kernel (confirmed after test - total pull-up was =
zero bytes):

WRITE tests:

	=E2=80=A2 Write test: CPU Utilization: Wall time  496.136    CPU =
time  812.879    CPU utilization 163.84 %
	=E2=80=A2 Re-write test: CPU utilization: Wall time  500.266    =
CPU time  822.810    CPU utilization 164.47 %

Final mountstats results:

WRITE:
    25161863 ops (50%)
    avg bytes sent per op: 1172    avg bytes received per op: 136
    backlog wait: 0.094913     RTT: 0.048245     total execute time: =
0.213270 (milliseconds)

Based solely on the iozone Write test:
12 threads x 1GB file =3D 12 GB transferred
12 GB / 496 s =3D 25973227 Bps
19.2 billion cps / 25973227 Bps =3D 740 cpB @ 1KB I/O

Based on both the iozone Write and Re-write tests:
25161863 ops / 996 s =3D 25263 IOps
19.2 billion cps / 25263 IOps =3D 760004 cpIO


READ tests:

	=E2=80=A2 Read test: CPU utilization: Wall time  451.762    CPU =
time  826.888    CPU utilization 183.04 %
	=E2=80=A2 Re-read test: CPU utilization: Wall time  452.543    =
CPU time  827.575    CPU utilization 182.87 %

Final mountstats results:

READ:
    25146066 ops (49%)
    avg bytes sent per op: 140    avg bytes received per op: 1152
    backlog wait: 0.092140     RTT: 0.045202     total execute time: =
0.205996 (milliseconds)

Based solely on the iozone Read test:
12 threads x 1GB file =3D 12 GB transferred
12 GB / 451 s =3D 28569627 Bps
19.2 billion cps / 28569627 Bps =3D 672 cpB @ 1KB I/O

Based on both the iozone Read and Re-read tests:
25146066 ops / 903 s =3D 27847 IOps
19.2 billion cps / 27847 IOps =3D 689481 cpIO



*** With pull-up kernel (confirmed after test - total pull-up was =
25763734528 bytes):

WRITE tests:
	=E2=80=A2 Write test: CPU Utilization: Wall time  453.318    CPU =
time  839.581    CPU utilization 185.21 %
	=E2=80=A2 Re-write test: CPU utilization: Wall time  458.717    =
CPU time  850.335    CPU utilization 185.37 %

Final mountstats results:

WRITE:
          25159897 ops (50%)
        avg bytes sent per op: 1172     avg bytes received per op: 136
        backlog wait: 0.080036  RTT: 0.049674   total execute time: =
0.183426 (milliseconds)

Based solely on the iozone Write test:
12 threads x 1GB file =3D 12 GB transferred
12 GB / 453 s =3D 28443492 Bps
19.2 billion cps / 28443492 Bps =3D 675 cpB @ 1KB I/O

Based on both the iozone Write and Re-write tests:
25159897 ops / 911 s =3D 27617 IOps
19.2 billion cps / 27617 IOps =3D 695223 cpIO


READ tests:

	=E2=80=A2 Read test: CPU utilization: Wall time  451.248    CPU =
time  834.203    CPU utilization 184.87 %
	=E2=80=A2 Re-read test: CPU utilization: Wall time  451.113    =
CPU time  834.302    CPU utilization 184.94 %

Final mountstats results:

READ:
    25149527 ops (49%)
    avg bytes sent per op: 140    avg bytes received per op: 1152
    backlog wait: 0.091011     RTT: 0.045790     total execute time: =
0.203793 (milliseconds)

Based solely on the iozone Read test:
12 threads x 1GB file =3D 12 GB transferred
12 GB / 451 s =3D 28569627 Bps
19.2 billion cps / 28569627 Bps =3D 672 cpB @ 1KB I/O

Based on both the iozone Read and Re-read tests:
25149527 ops / 902 s =3D 27881 IOps
19.2 billion cps / 27881 IOps =3D 688641 cpIO



*** Analysis:

For both kernels, the READ tests are close. This demonstrates that the =
patch does not have any gross effects on the READ path, as expected.

The WRITE tests are more remarkable.
	=E2=80=A2 Mean total execute time per WRITE RPC decreases by =
about 30 microseconds. Almost half of that is decreased backlog wait.
	=E2=80=A2 Mean round-trip time increases by a microsecond and a =
half. My earlier report that RT decreased by a microsecond was based on =
a QD=3D1 direct latency measure.
	=E2=80=A2 For 1KB WRITE: IOPS, Cycles per byte written and =
Cycles per I/O are now within spitting distance of the same metrics for =
1KB READ.


--
Chuck Lever



