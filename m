Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0D614A935
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2020 18:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgA0RqF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jan 2020 12:46:05 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37506 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgA0RqF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jan 2020 12:46:05 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RHilem146617;
        Mon, 27 Jan 2020 17:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=A5fzn1EhXA1dOHrIrxCMqV9yX8BBlYktBgUqM0CWTVE=;
 b=l8NRKzksQeXj3oxqMJLqI1Mmnds+Y743Wqcr97Z37aHmwPwFI0AzzLyGP5ss0aY7Sj6v
 4fTxiixpvAjPjqb7NUQ/R4OcnmS58UbQFyZeu9al+Sr8r2BXs03cTDPzLQKRwrcy8hIJ
 K3/nCl9+6HEieCRH4eLL5Mt9m79kFQVM4yikiBW6DX0MnWBizQN24vtpYce8l1eY354S
 ayO5exrDTK4dD37hVkNsJHb+JcRAroFbtWjO0KVr/MZDG1fjNHJse/DLr1AjZ8EE3Zfy
 VKEXPBZ8JUFamasdQBonk9AA//RWWJXukOuTFOYYSAo32dBrfQKiYKjBM56h76NlMaV5 VQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xrd3u10cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 17:46:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RHikZY188844;
        Mon, 27 Jan 2020 17:46:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2xryu9v68q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 17:46:01 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00RHk0F2011785;
        Mon, 27 Jan 2020 17:46:00 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jan 2020 09:46:00 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Remove single NFS client performance bottleneck: Only 4 nfsd
 active
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <0474b0f7-ec6d-9a02-2cd0-a69339e7cae5@excelero.com>
Date:   Mon, 27 Jan 2020 12:45:59 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DE46C289-9655-4E45-B89F-110E62F9F82D@oracle.com>
References: <a8a528c7-80bd-befc-59f8-00135d85a2bf@excelero.com>
 <F82F3FA8-4E2A-4014-A052-A0367562A956@oracle.com>
 <2D125E5E-F97D-4F52-89A9-C499CC7E7A5D@oracle.com>
 <0474b0f7-ec6d-9a02-2cd0-a69339e7cae5@excelero.com>
To:     Sven Breuner <sven@excelero.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270144
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 27, 2020, at 12:27 PM, Sven Breuner <sven@excelero.com> wrote:
>=20
> Hi Chuck,
>=20
> thanks for looking into this. (Answers inline...)
>=20
> Chuck Lever wrote on 27.01.2020 15:12:
>>=20
>>> On Jan 27, 2020, at 9:06 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>>=20
>>> Hi Sven-
>>>=20
>>>> On Jan 26, 2020, at 6:41 PM, Sven Breuner <sven@excelero.com> =
wrote:
>>>>=20
>>>> Hi,
>>>>=20
>>>> I'm using the kernel NFS client/server and am trying to read as =
many small files per second as possible from a single NFS client, but =
seem to run into a bottleneck.
>>>>=20
>>>> Maybe this is just a tunable that I am missing, because the CPUs on =
client and server side are mostly idle, the 100Gbit (RoCE) network links =
between client and server are also mostly idle and the NVMe drives in =
the server are also mostly idle (and the server has enough RAM to easily =
fit my test data set in the ext4/xfs page cache, but also a 2nd read of =
the data set from the RAM cache doesn't change the result much).
>>>>=20
>>>> This is my test case:
>>>> # Create 1.6M 10KB files through 128 mdtest processes in different =
directories...
>>>> $ mpirun -hosts localhost -np 128 /path/to/mdtest -F -d =
/mnt/nfs/mdtest -i 1 -I 100 -z 1 -b 128 -L -u -w 10240 -e 10240 -C
>>>>=20
>>>> # Read all the files through 128 mdtest processes (the case that =
matters primarily for my test)...
>>>> $ mpirun -hosts localhost -np 128 /path/to/mdtest -F -d =
/mnt/nfs/mdtest -i 1 -I 100 -z 1 -b 128 -L -u -w 10240 -e 10240 -E
>>>>=20
>>>> The result is about 20,000 file reads per sec, so only ~200MB/s =
network throughput.
>>> What is the typical size of the NFS READ I/Os on the wire?
> The application is fetching each full 10KB file in a single read op =
(so "read(fd, buf, 10240)" ) and NFS wsize/rsize is 512KB.

512KB is not going to matter if every file contains only 10KB.
This means 10KB READs. The I/O size is going to limit data
throughput. 20KIOPS seems low for RDMA, but is about right for
TCP.

If you see wire operations, then the client's page cache is not
being used at all?


>>> Are you sure your mpirun workload is generating enough parallelism?
> Yes, MPI is only used to start the 128 processes and aggregate the =
performance results in the end. For the actual file read phase, all 128 =
processes run completely independent without any =
communication/synchronization. Each process is working in its own subdir =
with its own set of 10KB files.
> (Running the same test directly on the local xfs of the NFS server box =
results in ~350,000 10KB file reads per sec after cache drop and >1 mio =
10KB file reads per sec from page cache. Just mentioning this for the =
sake of completeness to show that this is not hitting a limit on the =
server side.)
>> A couple of other thoughts:
>>=20
>> What's the client hardware like? NUMA? Fast memory? CPU count?
>=20
> Client and server are dual socket Intel Xeon E5-2690 v4 @ 2.60GHz (14 =
cores per socket plus hyper threading), all 4 memory channels per socket =
populated with fastest possible DIMMs (DDR4 2400).

One recommendation: Disable HT in the BIOS.


> Also tried pool_mode auto/global/pernode on server side.

NUMA seems to matter more on the client than on the server.


>> Have you configured device interrupt affinity and used tuned
>> to disable CPU sleep states, etc?
>=20
> Yes, CPU power saving (frequency scaling) disabled. Tried tuned =
profiles latency-performance and and throughput-performance. Also tried =
irqbalance and mlnx_affinity.
>=20
> All without any significant effect unfortunately.

And lspci -vvv confirms you are getting the right PCIe link
settings on both systems?


>> Have you properly configured your 100GbE switch and cards?
>>=20
>> I have a Mellanox SN2100 here and two hosts with CX-5 Ethernet.
>> The configuration of the cards and switch is critical to good
>> performance.
> Yes, I can absolutely confirm that having this part of the config =
correct is critical for great performance :-) All configured with PFC =
and ECN and double-checked for packets to be tagged correctly and =
lossless in the RoCE case. The topology is simple: Client and server =
connected to same Mellanox switch, nothing else happening on the switch.
>>=20
>>=20
>>>> I noticed in "top" that only 4 nfsd processes are active, so I'm =
wondering why the load is not spread across more of my 64 =
/proc/fs/nfsd/threads, but even the few nfsd processes that are active =
use less than 50% of their core each. The CPUs are shown as >90% idle in =
"top" on client and server during the read phase.
>>>>=20
>>>> I've tried:
>>>> * CentOS 7.5 and 7.6 kernels (3.10.0-...) on client and server; and =
Ubuntu 18 with 4.18 kernel on server side
>>>> * TCP & RDMA
>>>> * Mounted as NFSv3/v4.1/v4.2
>>>> * Increased tcp_slot_table_entries to 1024
>>>>=20
>>>> ...but all that didn't change the fact that only 4 nfsd processes =
are active on the server and thus I'm getting the same result already if =
/proc/fs/nfsd/threads is set to only 4 instead of 64.
>>>>=20
>>>> Any pointer to how I can overcome this limit will be greatly =
appreciated.
>>>>=20
>>>> Thanks in advance
>>>>=20
>>>> Sven
>>>>=20
>>> --
>>> Chuck Lever
>> --
>> Chuck Lever

--
Chuck Lever



