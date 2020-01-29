Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB6E14C41A
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2020 01:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgA2Ana (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Jan 2020 19:43:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33522 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgA2An3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Jan 2020 19:43:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00T0cBGD035913;
        Wed, 29 Jan 2020 00:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=PlqrHvj8eNPzkV5gJSDGvEFeKDS3olG8yLZz4dthv6o=;
 b=jnEZ9jKAcLTo/dF8fPzNHMDut4TWt7o0TNokndQ8ySMTdIMhmmBLvtlGp4/xEIrZp/lO
 cGEd1MK1Z3R4ntUwpFxgBkoDJaedp5PKMkIeWN5SNZiWOhct+IGzuXz8UwgqBYq6ZUhx
 RXio6S6C2AmqZC4sOOfTHjSZiDT8isFeRDjZtlK931BdhI+8TgfZltazVL/fKMWKjowq
 io6Hi4IO7CdLUNYOkT8Fqws3XmMwhiNSrxRqNmzWN4Br3WXMuDXruCxrIV0cu475QQ0r
 lUchlhG5Q4r9WkFFBOp6TrjzqHqYrVlmQAbg6LsF5HYGSnZaX7GvqiEGg8rCug6A2qKz pQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xrear9t44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 00:43:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00T0dav4165920;
        Wed, 29 Jan 2020 00:43:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2xtmr5d3am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 00:43:25 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00T0hPVd008679;
        Wed, 29 Jan 2020 00:43:25 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Jan 2020 16:43:25 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Remove single NFS client performance bottleneck: Only 4 nfsd
 active
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <3b63a0ea-cf3a-fcea-72e6-8d604b16455f@excelero.com>
Date:   Tue, 28 Jan 2020 19:43:24 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B13230B7-D83B-4194-8A3F-E1C49166E94F@oracle.com>
References: <a8a528c7-80bd-befc-59f8-00135d85a2bf@excelero.com>
 <F82F3FA8-4E2A-4014-A052-A0367562A956@oracle.com>
 <2D125E5E-F97D-4F52-89A9-C499CC7E7A5D@oracle.com>
 <0474b0f7-ec6d-9a02-2cd0-a69339e7cae5@excelero.com>
 <DE46C289-9655-4E45-B89F-110E62F9F82D@oracle.com>
 <3b63a0ea-cf3a-fcea-72e6-8d604b16455f@excelero.com>
To:     Sven Breuner <sven@excelero.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001290002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001290002
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 28, 2020, at 6:22 PM, Sven Breuner <sven@excelero.com> wrote:
>=20
>=20
> Chuck Lever wrote on 27.01.2020 18:45:
>>=20
>>> On Jan 27, 2020, at 12:27 PM, Sven Breuner <sven@excelero.com> =
wrote:
>>>=20
>>> Hi Chuck,
>>>=20
>>> thanks for looking into this. (Answers inline...)
>>>=20
>>> Chuck Lever wrote on 27.01.2020 15:12:
>>>>> On Jan 27, 2020, at 9:06 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>>>>=20
>>>>> Hi Sven-
>>>>>=20
>>>>>> On Jan 26, 2020, at 6:41 PM, Sven Breuner <sven@excelero.com> =
wrote:
>>>>>>=20
>>>>>> Hi,
>>>>>>=20
>>>>>> I'm using the kernel NFS client/server and am trying to read as =
many small files per second as possible from a single NFS client, but =
seem to run into a bottleneck.
>>>>>>=20
>>>>>> Maybe this is just a tunable that I am missing, because the CPUs =
on client and server side are mostly idle, the 100Gbit (RoCE) network =
links between client and server are also mostly idle and the NVMe drives =
in the server are also mostly idle (and the server has enough RAM to =
easily fit my test data set in the ext4/xfs page cache, but also a 2nd =
read of the data set from the RAM cache doesn't change the result much).
>>>>>>=20
>>>>>> This is my test case:
>>>>>> # Create 1.6M 10KB files through 128 mdtest processes in =
different directories...
>>>>>> $ mpirun -hosts localhost -np 128 /path/to/mdtest -F -d =
/mnt/nfs/mdtest -i 1 -I 100 -z 1 -b 128 -L -u -w 10240 -e 10240 -C
>>>>>>=20
>>>>>> # Read all the files through 128 mdtest processes (the case that =
matters primarily for my test)...
>>>>>> $ mpirun -hosts localhost -np 128 /path/to/mdtest -F -d =
/mnt/nfs/mdtest -i 1 -I 100 -z 1 -b 128 -L -u -w 10240 -e 10240 -E
>>>>>>=20
>>>>>> The result is about 20,000 file reads per sec, so only ~200MB/s =
network throughput.
>>>>> What is the typical size of the NFS READ I/Os on the wire?
>>> The application is fetching each full 10KB file in a single read op =
(so "read(fd, buf, 10240)" ) and NFS wsize/rsize is 512KB.
>> 512KB is not going to matter if every file contains only 10KB.
>> This means 10KB READs. The I/O size is going to limit data
>> throughput. 20KIOPS seems low for RDMA, but is about right for
>> TCP.
> RDMA is about 30% faster (26K file reads per sec), but I'm more hoping =
for an order of magnitude increase.

Not an unreasonable hope. Here's a simple fio test I ran on my 100GbE =
systems with NFSv3:

fio-test: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, =
(T) 4096B-4096B, ioengine=3Dlibaio, iodepth=3D1024
...
fio-3.14
Starting 4 processes
fio-test: Laying out IO file (1 file / 1024MiB)
fio-test: Laying out IO file (1 file / 1024MiB)
fio-test: Laying out IO file (1 file / 1024MiB)
fio-test: Laying out IO file (1 file / 1024MiB)
Jobs: 4 (f=3D4): [r(4)][100.0%][r=3D1092MiB/s][r=3D280k IOPS][eta =
00m:00s]
fio-test: (groupid=3D0, jobs=3D4): err=3D 0: pid=3D3075643: Tue Jan 28 =
19:27:10 2020
  read: IOPS=3D280k, BW=3D1094MiB/s (1147MB/s)(32.0GiB/30005msec)
    slat (nsec): min=3D1516, max=3D83293k, avg=3D7696.22, =
stdev=3D218022.20
    clat (usec): min=3D46, max=3D143098, avg=3D14618.22, stdev=3D11253.38
     lat (usec): min=3D50, max=3D143105, avg=3D14626.26, stdev=3D11256.38
    clat percentiles (msec):
     |  1.00th=3D[    3],  5.00th=3D[    4], 10.00th=3D[    5], =
20.00th=3D[    7],
     | 30.00th=3D[    8], 40.00th=3D[   10], 50.00th=3D[   12], =
60.00th=3D[   14],
     | 70.00th=3D[   17], 80.00th=3D[   21], 90.00th=3D[   28], =
95.00th=3D[   36],
     | 99.00th=3D[   60], 99.50th=3D[   71], 99.90th=3D[   90], =
99.95th=3D[   94],
     | 99.99th=3D[  108]
   bw (  MiB/s): min=3D  728, max=3D 1795, per=3D99.96%, avg=3D1093.10, =
stdev=3D55.40, samples=3D240
   iops        : min=3D186436, max=3D459578, avg=3D279833.92, =
stdev=3D14183.03, samples=3D240
  lat (usec)   : 50=3D0.01%, 100=3D0.01%, 250=3D0.03%, 500=3D0.08%, =
750=3D0.08%
  lat (usec)   : 1000=3D0.08%
  lat (msec)   : 2=3D0.47%, 4=3D4.93%, 10=3D35.53%, 20=3D38.41%, =
50=3D18.62%
  lat (msec)   : 100=3D1.75%, 250=3D0.03%
  cpu          : usr=3D10.66%, sys=3D17.51%, ctx=3D1627222, majf=3D0, =
minf=3D4136
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, =
32=3D0.1%, >=3D64=3D100.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.1%
     issued rwts: total=3D8400192,0,0,0 short=3D0,0,0,0 dropped=3D0,0,0,0
     latency   : target=3D0, window=3D0, percentile=3D100.00%, =
depth=3D1024

Run status group 0 (all jobs):
   READ: bw=3D1094MiB/s (1147MB/s), 1094MiB/s-1094MiB/s =
(1147MB/s-1147MB/s), io=3D32.0GiB (34.4GB), run=3D30005-30005msec


It achieves better than a quarter-million 4KB read IOPS.

However I do not believe there is an open/close with each I/O in this
test; each thread opens one of the test files, and then simply streams
reads to it.


> By the way: Is there an NFSoRDMA equivalent for tcp_slot_table_entries =
to increase or is there no such limit in case of RDMA transport?

[cel@morisot ~]$ cat /proc/sys/sunrpc/tcp_slot_table_entries
2
[cel@morisot ~]$ cat /proc/sys/sunrpc/tcp_max_slot_table_entries
65536
[cel@morisot ~]$ cat /proc/sys/sunrpc/rdma_slot_table_entries
128
[cel@morisot ~]$

The tcp_slot_table_entries file controls the number of pre-allocated
rpc_rqst's per transport. After 2 are in use, the transport uses
kmalloc and kfree for the others.

The tcp_max_slot_table_entries file caps the total number of rpc_rqst's
allowed per transport. The default setting is already quite large.

The rdma_slot_table_entries file caps the number of RPC-over-RDMA
credits the client supports. The Linux server grants at most 32 credits.
That number has increased to 64 credits in recent kernels.

The kernel also has a control on the server to set the number of
credits it will grant:

[cel@bazille linux]$ cat /proc/sys/sunrpc/svc_rdma/max_requests=20
64
[cel@bazille linux]$

These two systems will use no more than 64 credits per connection.


>> If you see wire operations, then the client's page cache is not
>> being used at all?
> I'm usually benchmarking after fresh client mount or "echo 3 > =
/proc/sys/vm/drop_caches", because the actual production data set will =
have many more files (multiple Terabytes) and thus won't fit in RAM.

In the server's RAM? If that's the case, then your durable storage
will be the main bottleneck.


>>>>> Are you sure your mpirun workload is generating enough =
parallelism?
>>> Yes, MPI is only used to start the 128 processes and aggregate the =
performance results in the end. For the actual file read phase, all 128 =
processes run completely independent without any =
communication/synchronization. Each process is working in its own subdir =
with its own set of 10KB files.
>>> (Running the same test directly on the local xfs of the NFS server =
box results in ~350,000 10KB file reads per sec after cache drop and >1 =
mio 10KB file reads per sec from page cache. Just mentioning this for =
the sake of completeness to show that this is not hitting a limit on the =
server side.)
>>>> A couple of other thoughts:
>>>>=20
>>>> What's the client hardware like? NUMA? Fast memory? CPU count?
>>> Client and server are dual socket Intel Xeon E5-2690 v4 @ 2.60GHz =
(14 cores per socket plus hyper threading), all 4 memory channels per =
socket populated with fastest possible DIMMs (DDR4 2400).
>> One recommendation: Disable HT in the BIOS.
> Thanks for the recommendation. Tried, but no significant difference.
>>> Also tried pool_mode auto/global/pernode on server side.
>> NUMA seems to matter more on the client than on the server.
> mpirun can also bind the mdtest processes to NUMA zones, but also no =
significant difference for that.

Keep the processes on the same node as the NIC and its interrupt =
vectors.
Again, not likely to give a 10x boost in IOPS, but it will help once you
figure out the main issue.


>>>> Have you configured device interrupt affinity and used tuned
>>>> to disable CPU sleep states, etc?
>>> Yes, CPU power saving (frequency scaling) disabled. Tried tuned =
profiles latency-performance and and throughput-performance. Also tried =
irqbalance and mlnx_affinity.
>>>=20
>>> All without any significant effect unfortunately.
>> And lspci -vvv confirms you are getting the right PCIe link
>> settings on both systems?
>=20
> Yes. I can also see >11GB/s network throughput between client and =
server through e.g. ib_send_bw.
>=20
> Actually, the client and server each have two 100Gbit RoCE NICs, but =
it seems like there isn't a way currently to get the NFS client to =
spread the communication across two RDMA interfaces for a single =
mountpoint.

That's correct. You might try bonding the two NICs.

However, in general a single RDMA NIC should enable much better =
throughput
than a non-offloaded NIC.


> Assuming the hardware is not the limit, is there any software limit =
for parallelism in the NFS client?

No architected limit that I'm aware of. Lock contention can certainly be
a problem, though.

Also, if your kernel builds have Kernel Hacking options enabled, that =
can
have a considerable impact on throughput. Memory, lock, or data =
structure
debugging options will have an effect.

NFSv4.0 open owners maybe? Though you said your test results do not seem =
to
depend on the NFS version.

NFSv3 does not have on-the-wire OPEN and CLOSE, but IIUC it does force a
GETATTR operation to check the file's mtime at each open(2) and =
close(2).
I wonder if the "nocto" mount option would help the NFSv3 results?


> So if an application on an NFS client can generates 128 concurrent =
open/read/close (from 128 threads) to 128 different files in the NFS =
mountpoint, will the NFS client then actually send 128 concurrent =
open/read/close over the wire or will it e.g. limit for some reason to =
only 4 or 8 concurrent requests and the rest will be queued until one of =
the first 4/8/... requests has received a reply - e.g. because there is =
only 1 pending reply allowed per connection and a client does not =
establish more than 4/8/... connections to the same server?

A connection can have as many concurrent pending replies as there are
outstanding calls.

With TCP, you can use tcpdump to look at wire behavior to see if there
are obvious problems.


> And same question on the NFS server side: If a client sends 128 =
concurrent reads over the wire and the knfsd has 128 threads, will it =
actually work on all those 128 reads in parallel or is there a limit in =
the server that e.g. maps requests from the same client to a maximum of =
4/8/... threads, no matter how many more threads the knfsd has =
available?

Each nfsd thread handles one RPC. If there are 128 ingress NFS READS
and 128 threads, the kernel will try to use all available threads.


> Thanks a lot for your help
>=20
> Sven
>=20
>>=20
>>=20
>>>> Have you properly configured your 100GbE switch and cards?
>>>>=20
>>>> I have a Mellanox SN2100 here and two hosts with CX-5 Ethernet.
>>>> The configuration of the cards and switch is critical to good
>>>> performance.
>>> Yes, I can absolutely confirm that having this part of the config =
correct is critical for great performance :-) All configured with PFC =
and ECN and double-checked for packets to be tagged correctly and =
lossless in the RoCE case. The topology is simple: Client and server =
connected to same Mellanox switch, nothing else happening on the switch.
>>>>=20
>>>>>> I noticed in "top" that only 4 nfsd processes are active, so I'm =
wondering why the load is not spread across more of my 64 =
/proc/fs/nfsd/threads, but even the few nfsd processes that are active =
use less than 50% of their core each. The CPUs are shown as >90% idle in =
"top" on client and server during the read phase.
>>>>>>=20
>>>>>> I've tried:
>>>>>> * CentOS 7.5 and 7.6 kernels (3.10.0-...) on client and server; =
and Ubuntu 18 with 4.18 kernel on server side
>>>>>> * TCP & RDMA
>>>>>> * Mounted as NFSv3/v4.1/v4.2
>>>>>> * Increased tcp_slot_table_entries to 1024
>>>>>>=20
>>>>>> ...but all that didn't change the fact that only 4 nfsd processes =
are active on the server and thus I'm getting the same result already if =
/proc/fs/nfsd/threads is set to only 4 instead of 64.
>>>>>>=20
>>>>>> Any pointer to how I can overcome this limit will be greatly =
appreciated.
>>>>>>=20
>>>>>> Thanks in advance
>>>>>>=20
>>>>>> Sven
>>>>>>=20
>>>>> --
>>>>> Chuck Lever
>>>> --
>>>> Chuck Lever
>> --
>> Chuck Lever

--
Chuck Lever



