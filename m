Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31532ADE3C
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 19:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbgKJSZd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 13:25:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34285 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJSZd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Nov 2020 13:25:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAINlpp157869;
        Tue, 10 Nov 2020 18:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=uUdEa9koh2rOxUexo6aqHVwrw1/KYEN1GGFgvlGuHDc=;
 b=rFNMGIdiX8Z8ZuVhTBcm8VjEGpJCE8m6bq+YCwBpoir9Q2i7SvYmwvLgS7WcHzRQ17g5
 Siylnzvfmn+LvoB8PsDpRPLiLJ7orZQjXvUyj0PK9GN+a+bniVPVdOozrWAq/CbKJlzd
 jQVy+AbqhL9dERzpb+gpm7lrG8bZ6iZX3X8uG/+jXFyR8GgxCWDA69Knmukc6VM/Kobh
 oyTt0nmpob4ytHhLQKsiMvhQMC2gb3HOfuDQEVskqgTzpZUXIrc5fPcuATTFvPfDre5i
 z1M8xluitBpb/pELBLQU3u5zSpjet/2DpLqrIj42NG08gBXX2pI9c+r/dIACDHbvZUm7 KQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34nkhkw547-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 18:25:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAI69oQ009745;
        Tue, 10 Nov 2020 18:25:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34p5gxb358-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 18:25:26 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AAIPPvG000859;
        Tue, 10 Nov 2020 18:25:25 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Nov 2020 10:25:25 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: kernel oops in generic/013 on an rdma mount (over either soft
 roce or iwarp)
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyH0ujGDgowBZi6ykZ52ZFqW7GZJekhb6-oZEuq0XrpaUw@mail.gmail.com>
Date:   Tue, 10 Nov 2020 13:25:24 -0500
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <71766FD5-E726-474A-95D8-A86CB6E6AF55@oracle.com>
References: <CAN-5tyENFaKb=CUZCxkeAqhS7jsFswwaGkPyC0W9h_OJyVrEmw@mail.gmail.com>
 <98BAC3EC-35C5-449F-8476-4B740632DC7C@oracle.com>
 <CAN-5tyGKXJCWxzDnPfT0v70Ry7QNvSCKRnwyU360aW6nJvN-aA@mail.gmail.com>
 <CAN-5tyFsGBJ3aJC0XVfTOAR219d6jukYZPLvmUGgRFYkraB88A@mail.gmail.com>
 <576A90AD-278A-4738-B437-162C8B931FE0@oracle.com>
 <CAN-5tyF1mUQ3bgx_5i2SJH=BQ1MH0omHkQq6SmaZw7sS5U_1GA@mail.gmail.com>
 <C452338F-A32A-4F35-BB9C-08104DB91960@oracle.com>
 <CAN-5tyH0ujGDgowBZi6ykZ52ZFqW7GZJekhb6-oZEuq0XrpaUw@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100128
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 10, 2020, at 1:18 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>=20
> On Tue, Nov 10, 2020 at 12:44 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>> On Nov 10, 2020, at 11:51 AM, Olga Kornievskaia <aglo@umich.edu> =
wrote:
>>>=20
>>> On Tue, Nov 10, 2020 at 9:42 AM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>>>=20
>>>>> Which those changes applied, I get the following oops:
>>>>=20
>>>> What's your workload? Do you have a reproducer?
>>>=20
>>> I ran generic/013 linux-to-linux.
>>=20
>> I'm not able to reproduce the problem.
>=20
> Are you on hardware? This is over soft roce/iwarp. I will try hardware
> but it'll take me time.

Since it appears to work correctly when a hardware RDMA device is in
use, that approach would be a waste of your time, methinks. Can you try
debugging with your soft RDMA device?

Start by identifying what NFS operation is failing, and what =
configuration
of chunks it is using.


>> xfstest: mount options: =
vers=3D4.2,proto=3Drdma,sec=3Dsys,rsize=3D262144,wsize=3D131072
>>=20
>> FSTYP         -- nfs
>> PLATFORM      -- Linux/x86_64 manet 5.10.0-rc1-00015-g6d4bab79ed4f =
#1297 SMP Sat Oct 31 12:56:30 EDT 2020
>>=20
>> generic/001 22s ...  22s
>> generic/002 1s ...  2s
>> generic/003     [not run] this test requires a valid $SCRATCH_DEV
>> generic/004     [not run] O_TMPFILE is not supported
>> generic/005 1s ...  2s
>> generic/006 10s ...  9s
>> generic/007 40s ...  39s
>> generic/008     [not run] xfs_io fzero  failed (old kernel/wrong fs?)
>> generic/009     [not run] xfs_io fzero  failed (old kernel/wrong fs?)
>> generic/010     [not run] /home/cel/src/xfstests/src/dbtest not built
>> generic/011 6s ...  6s
>> generic/012     [not run] xfs_io fiemap  failed (old kernel/wrong =
fs?)
>> generic/013 9s ...  9s
>> generic/014 10s ...  8s
>> generic/015     [not run] this test requires a valid $SCRATCH_DEV
>> generic/016     [not run] xfs_io fiemap  failed (old kernel/wrong =
fs?)
>> generic/017     [not run] this test requires a valid $SCRATCH_DEV
>> generic/018     [not run] this test requires a valid $SCRATCH_DEV
>>=20
>> I must be missing something that you have in your environment.
>>=20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



