Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7331E8412
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2020 18:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgE2QwF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 May 2020 12:52:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46938 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgE2QwD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 May 2020 12:52:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TGpwTZ109615;
        Fri, 29 May 2020 16:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=iIYtEqvKfdQA08ErZcuqUmtkcM0+LyKts5KRCwK+cYY=;
 b=lENU7fiuUg/u69NoIQ3peB5At1U7BH8WUD3IUj369wnZDoaQCqQbL+bLxJQAl+jMAd3Z
 syzPUA2pXkbZ6W0v5Nd988k7OcHQV3SSD5qB0quvEqKAGHHgvXTSNq0hKXrgOxVQdERl
 4juRi4Rj/w4YJtWEZe8ArPTN5oYkAUWBpN0AptV7tOaPb9pM9JSQRbfm9uV+TUEVywBY
 dwbBXqPK57Qc47s8Myrg84VR40tT/SRLZLGvG2FuHa7O1ZQHN+Y7507bH+89OjZS09Fl
 TKlWTYZfK5YcK/AVB/Q+JeLCeqnePtGDKzi423+G8wL6Zt+JzFdfL3iQGhjEpEHl5/4x 9g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 316u8rbeah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 May 2020 16:51:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TGlg26031760;
        Fri, 29 May 2020 16:51:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 317j5ywuw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 May 2020 16:51:57 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04TGprgE021046;
        Fri, 29 May 2020 16:51:56 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 May 2020 09:51:53 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: 50% regression in NFS direct WRITE throughput
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <B3EFAB24-4786-4D83-B17A-4EF5168266A8@oracle.com>
Date:   Fri, 29 May 2020 12:51:52 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D883562-6E57-40D2-8107-24091AEEC859@oracle.com>
References: <B3EFAB24-4786-4D83-B17A-4EF5168266A8@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9636 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9636 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 suspectscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290128
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 29, 2020, at 9:02 AM, Chuck Lever <chuck.lever@oracle.com> =
wrote:
>=20
> While testing other things, I noticed that several iozone tests showed
> a significant regression in large direct WRITE performance with little
> to no drop in small WRITE IOPS.
>=20
> One example (NFS/RDMA on FDR InfiniBand):
>=20
> 	Machine =3D Linux manet.1015granger.net =
5.7.0-rc7-00033-g8de6ca0614d4 #1071 SMP
> 	CPU utilization Resolution =3D 0.000 seconds.
> 	CPU utilization Excel chart enabled
> 	File size set to 1048576 kB
> 	Record Size 256 kB
> 	O_DIRECT feature enabled
> 	Command line used: /home/cel/bin/iozone -M -+u -i0 -i1 -s1g =
-r256k -t12 -I
> 	Output is in kBytes/sec
> 	Time Resolution =3D 0.000001 seconds.
> 	Processor cache size set to 1024 kBytes.
> 	Processor cache line size set to 32 bytes.
> 	File stride size set to 17 * record size.
> 	Throughput test with 12 processes
> 	Each process writes a 1048576 kByte file in 256 kByte records
>=20
> 	Children see throughput for 12 initial writers 	=3D 2430898.66 =
kB/sec
> 	Parent sees throughput for 12 initial writers 	=3D 2425731.85 =
kB/sec
> 	Min throughput per process 			=3D  202025.03 =
kB/sec
> 	Max throughput per process 			=3D  202899.33 =
kB/sec
> 	Avg throughput per process 			=3D  202574.89 =
kB/sec
> 	Min xfer 					=3D 1044224.00 =
kB
> 	CPU Utilization: Wall time    5.179    CPU time    2.020    CPU =
utilization  39.00 %
>=20
> 	Children see throughput for 12 rewriters 	=3D 2431774.06 =
kB/sec
> 	Parent sees throughput for 12 rewriters 	=3D 2431230.83 =
kB/sec
> 	Min throughput per process 			=3D  202230.42 =
kB/sec
> 	Max throughput per process 			=3D  202926.08 =
kB/sec
> 	Avg throughput per process 			=3D  202647.84 =
kB/sec
> 	Min xfer 					=3D 1045248.00 =
kB
> 	CPU utilization: Wall time    5.169    CPU time    2.015    CPU =
utilization  38.99 %
>=20
> These numbers are half what they usually are.
>=20
> I bisected between v5.6 and v5.7-rc7, and it terminated on =
1f28476dcb98
> ("NFS: Fix O_DIRECT commit verifier handling").
>=20
> This commit doesn't revert cleanly -- the kernel won't build after it =
is
> reverted, so I can't easily do the obvious test to confirm the bisect
> result.
>=20
> I intend to look into the exact pathology, but wanted to get this =
regression
> reported first, in case someone has a thought about what is slowing =
things
> down.

The observed behavior is that the client sends every WRITE twice: once =
as
an UNSTABLE WRITE plus a COMMIT, and once as a FILE_SYNC WRITE.

This is because the nfs_write_match_verf() check in =
nfs_direct_commit_complete()
fails for every on-the-wire WRITE.

Buffered writes use nfs_write_completion(), which sets req->wb_verf =
correctly.

Direct writes use nfs_direct_write_completion(), which does not set =
req->wb_verf
at all. This leaves req->wb_verf set to all zeroes for every direct =
WRITE,
and thus nfs_direct_commit_completion always requests a resend.

I confirmed all this by adding temporary tracepoints in the write =
completion
paths. Seems like the fix is to duplicate the guts of =
nfs_write_completion() in
nfs_direct_write_completion() (or refactor the guts into helpers that =
both
functions invoke).


--
Chuck Lever



