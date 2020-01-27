Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A66E14A5B3
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2020 15:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgA0OIM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jan 2020 09:08:12 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57240 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgA0OIM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jan 2020 09:08:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RDw1xr094745;
        Mon, 27 Jan 2020 14:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=PP/C3kna8wYte8vQP0ifQEEsu1PO+MuiqORYpeszGRM=;
 b=FRtpP3JGMk+uLa3oVnA3ORkkDGN9xoYldiVcGD9t560sw0qOvjz6In2LKSJGmjOa3lV2
 7zWUKHpjwZU/bOVAR82+lvr+2GIsNBAn0KJFjAc/e42VgcuUxVKaQeWcz/ZGdgYFwIB3
 wZ1g7G7gwl7b7TIJT6DMaLtuu96IoO3NnqV0Cm+P4NHzQpbVVr3B0SVMaGaBPVCuz2WF
 k3NAWZT9SeFrKHs17D7qPQ3bufRdMfjpG9sXOtm6oDjMFwHF8qadiINnRS9DuymaOIvI
 2gz4GEh+vON1xbx9FGvP98leroljqwDXhxjhE5k0b3Cnuz4LPRSn4XzDa3e7CNZqNlrZ DA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xrdmq7gxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 14:08:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00RE57Mv113707;
        Mon, 27 Jan 2020 14:06:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2xry6t5498-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 14:06:09 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00RE67FS017554;
        Mon, 27 Jan 2020 14:06:08 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jan 2020 06:06:07 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Remove single NFS client performance bottleneck: Only 4 nfsd
 active
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <a8a528c7-80bd-befc-59f8-00135d85a2bf@excelero.com>
Date:   Mon, 27 Jan 2020 09:06:06 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F82F3FA8-4E2A-4014-A052-A0367562A956@oracle.com>
References: <a8a528c7-80bd-befc-59f8-00135d85a2bf@excelero.com>
To:     Sven Breuner <sven@excelero.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270119
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Sven-

> On Jan 26, 2020, at 6:41 PM, Sven Breuner <sven@excelero.com> wrote:
>=20
> Hi,
>=20
> I'm using the kernel NFS client/server and am trying to read as many =
small files per second as possible from a single NFS client, but seem to =
run into a bottleneck.
>=20
> Maybe this is just a tunable that I am missing, because the CPUs on =
client and server side are mostly idle, the 100Gbit (RoCE) network links =
between client and server are also mostly idle and the NVMe drives in =
the server are also mostly idle (and the server has enough RAM to easily =
fit my test data set in the ext4/xfs page cache, but also a 2nd read of =
the data set from the RAM cache doesn't change the result much).
>=20
> This is my test case:
> # Create 1.6M 10KB files through 128 mdtest processes in different =
directories...
> $ mpirun -hosts localhost -np 128 /path/to/mdtest -F -d =
/mnt/nfs/mdtest -i 1 -I 100 -z 1 -b 128 -L -u -w 10240 -e 10240 -C
>=20
> # Read all the files through 128 mdtest processes (the case that =
matters primarily for my test)...
> $ mpirun -hosts localhost -np 128 /path/to/mdtest -F -d =
/mnt/nfs/mdtest -i 1 -I 100 -z 1 -b 128 -L -u -w 10240 -e 10240 -E
>=20
> The result is about 20,000 file reads per sec, so only ~200MB/s =
network throughput.

What is the typical size of the NFS READ I/Os on the wire?

Are you sure your mpirun workload is generating enough parallelism?


> I noticed in "top" that only 4 nfsd processes are active, so I'm =
wondering why the load is not spread across more of my 64 =
/proc/fs/nfsd/threads, but even the few nfsd processes that are active =
use less than 50% of their core each. The CPUs are shown as >90% idle in =
"top" on client and server during the read phase.
>=20
> I've tried:
> * CentOS 7.5 and 7.6 kernels (3.10.0-...) on client and server; and =
Ubuntu 18 with 4.18 kernel on server side
> * TCP & RDMA
> * Mounted as NFSv3/v4.1/v4.2
> * Increased tcp_slot_table_entries to 1024
>=20
> ...but all that didn't change the fact that only 4 nfsd processes are =
active on the server and thus I'm getting the same result already if =
/proc/fs/nfsd/threads is set to only 4 instead of 64.
>=20
> Any pointer to how I can overcome this limit will be greatly =
appreciated.
>=20
> Thanks in advance
>=20
> Sven
>=20

--
Chuck Lever



