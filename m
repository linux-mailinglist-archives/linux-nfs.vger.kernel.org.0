Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9211E7DD9
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2020 15:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgE2NEr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 May 2020 09:04:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55614 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgE2NEq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 May 2020 09:04:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TD1rkc183550
        for <linux-nfs@vger.kernel.org>; Fri, 29 May 2020 13:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 to; s=corp-2020-01-29; bh=7PClN/JGbWAX1eHzbdG5WoOGkoM3vrjgTxXT6M6WtrU=;
 b=cMyM2V+GrWdu0GtT/FcWjrq1Py39AkQ6bkMik5gERmwDBY9CYFIJK1mskYNL6YHzP4Yj
 26XV4p6RSzJkcZrdT+f0wgYJi7YpzUrmtTOxDnazIz3bOJtcxCOTksVVo9ovzcFwDp2E
 EqWRMHNFFlACS6QeGrYnFoFVVyP365I+GF6/Poj8ilBNrfYMb93zSsap3r5gKOxx7GIu
 CbZI365/wGhDCAfgaOUILv0RhWotn+r+vYU8rEFcs0PZclicdApX2q3kmNSHCgcXy+BV
 arj1zJOghFevdmGYG7gXG+GteSg9tNH9xCu4tp09IY6Z53Ty+3nuw8omo3pLn62gzrXQ SA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 318xbka9ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-nfs@vger.kernel.org>; Fri, 29 May 2020 13:04:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TCr1CE182000
        for <linux-nfs@vger.kernel.org>; Fri, 29 May 2020 13:02:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 317ds48spu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Fri, 29 May 2020 13:02:45 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04TD2iVA012019
        for <linux-nfs@vger.kernel.org>; Fri, 29 May 2020 13:02:44 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 May 2020 06:02:44 -0700
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: 50% regression in NFS direct WRITE throughput
Message-Id: <B3EFAB24-4786-4D83-B17A-4EF5168266A8@oracle.com>
Date:   Fri, 29 May 2020 09:02:43 -0400
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005290104
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

While testing other things, I noticed that several iozone tests showed
a significant regression in large direct WRITE performance with little
to no drop in small WRITE IOPS.

One example (NFS/RDMA on FDR InfiniBand):

	Machine =3D Linux manet.1015granger.net =
5.7.0-rc7-00033-g8de6ca0614d4 #1071 SMP
 	CPU utilization Resolution =3D 0.000 seconds.
 	CPU utilization Excel chart enabled
 	File size set to 1048576 kB
 	Record Size 256 kB
 	O_DIRECT feature enabled
 	Command line used: /home/cel/bin/iozone -M -+u -i0 -i1 -s1g =
-r256k -t12 -I
 	Output is in kBytes/sec
 	Time Resolution =3D 0.000001 seconds.
 	Processor cache size set to 1024 kBytes.
 	Processor cache line size set to 32 bytes.
 	File stride size set to 17 * record size.
 	Throughput test with 12 processes
 	Each process writes a 1048576 kByte file in 256 kByte records

 	Children see throughput for 12 initial writers 	=3D 2430898.66 =
kB/sec
 	Parent sees throughput for 12 initial writers 	=3D 2425731.85 =
kB/sec
 	Min throughput per process 			=3D  202025.03 =
kB/sec
 	Max throughput per process 			=3D  202899.33 =
kB/sec
 	Avg throughput per process 			=3D  202574.89 =
kB/sec
 	Min xfer 					=3D 1044224.00 =
kB
 	CPU Utilization: Wall time    5.179    CPU time    2.020    CPU =
utilization  39.00 %

 	Children see throughput for 12 rewriters 	=3D 2431774.06 =
kB/sec
 	Parent sees throughput for 12 rewriters 	=3D 2431230.83 =
kB/sec
 	Min throughput per process 			=3D  202230.42 =
kB/sec
 	Max throughput per process 			=3D  202926.08 =
kB/sec
 	Avg throughput per process 			=3D  202647.84 =
kB/sec
 	Min xfer 					=3D 1045248.00 =
kB
	CPU utilization: Wall time    5.169    CPU time    2.015    CPU =
utilization  38.99 %

These numbers are half what they usually are.

I bisected between v5.6 and v5.7-rc7, and it terminated on 1f28476dcb98
("NFS: Fix O_DIRECT commit verifier handling").

This commit doesn't revert cleanly -- the kernel won't build after it is
reverted, so I can't easily do the obvious test to confirm the bisect
result.

I intend to look into the exact pathology, but wanted to get this =
regression
reported first, in case someone has a thought about what is slowing =
things
down.

--
Chuck Lever



