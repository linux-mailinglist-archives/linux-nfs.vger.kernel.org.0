Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05C82ADD3D
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 18:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgKJRo2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 12:44:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40616 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgKJRo2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Nov 2020 12:44:28 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAHZRxY162921;
        Tue, 10 Nov 2020 17:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=+tmLGcrKoO3aBPxU3dhKsnBlTgSJKnhMTr5+1XOsOy0=;
 b=LQAHD/Tcb+ARjPdUy0GEDniu/pEEgwY4cv80xjmcpKWbGngJbLDwwyznFSduhsEi2M8v
 /SZnPf39328plq9PdOV7isJhXwXsYG91iTL5nIP1tS4wsCe+HPJDU8dF6Lde8CEFLCUl
 zsQMRbUrELJouxv7g4RyxfskbAFGs1mkqZ9LBWq8USB/5Lk1ZglGwsuD5faoLVSnDu8o
 pqvM0bBXFtFFVzYvD6EfSc9GyARLnyeFhO77s1EbLgta6GmnyuEZr95pz4zAS0sYIEvM
 ZpD1BmMPhiCQJre+41XUsZnYiNNl3KFxnG8c5zuoGvm20vTS0rBDFVHEyCB6QDVl8eXX Vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34p72ek5et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 17:44:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAHZ6ua000861;
        Tue, 10 Nov 2020 17:44:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34qgp75wac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 17:44:22 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AAHiKAt026157;
        Tue, 10 Nov 2020 17:44:20 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Nov 2020 09:44:20 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: kernel oops in generic/013 on an rdma mount (over either soft
 roce or iwarp)
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyF1mUQ3bgx_5i2SJH=BQ1MH0omHkQq6SmaZw7sS5U_1GA@mail.gmail.com>
Date:   Tue, 10 Nov 2020 12:44:19 -0500
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C452338F-A32A-4F35-BB9C-08104DB91960@oracle.com>
References: <CAN-5tyENFaKb=CUZCxkeAqhS7jsFswwaGkPyC0W9h_OJyVrEmw@mail.gmail.com>
 <98BAC3EC-35C5-449F-8476-4B740632DC7C@oracle.com>
 <CAN-5tyGKXJCWxzDnPfT0v70Ry7QNvSCKRnwyU360aW6nJvN-aA@mail.gmail.com>
 <CAN-5tyFsGBJ3aJC0XVfTOAR219d6jukYZPLvmUGgRFYkraB88A@mail.gmail.com>
 <576A90AD-278A-4738-B437-162C8B931FE0@oracle.com>
 <CAN-5tyF1mUQ3bgx_5i2SJH=BQ1MH0omHkQq6SmaZw7sS5U_1GA@mail.gmail.com>
To:     Olga Kornievskaia <aglo@umich.edu>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100124
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Nov 10, 2020, at 11:51 AM, Olga Kornievskaia <aglo@umich.edu> =
wrote:
>=20
> On Tue, Nov 10, 2020 at 9:42 AM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>>> Which those changes applied, I get the following oops:
>>=20
>> What's your workload? Do you have a reproducer?
>=20
> I ran generic/013 linux-to-linux.

I'm not able to reproduce the problem.

xfstest: mount options: =
vers=3D4.2,proto=3Drdma,sec=3Dsys,rsize=3D262144,wsize=3D131072
=20
FSTYP         -- nfs
PLATFORM      -- Linux/x86_64 manet 5.10.0-rc1-00015-g6d4bab79ed4f #1297 =
SMP Sat Oct 31 12:56:30 EDT 2020

generic/001 22s ...  22s
generic/002 1s ...  2s
generic/003	[not run] this test requires a valid $SCRATCH_DEV
generic/004	[not run] O_TMPFILE is not supported
generic/005 1s ...  2s
generic/006 10s ...  9s
generic/007 40s ...  39s
generic/008	[not run] xfs_io fzero  failed (old kernel/wrong fs?)
generic/009	[not run] xfs_io fzero  failed (old kernel/wrong fs?)
generic/010	[not run] /home/cel/src/xfstests/src/dbtest not built
generic/011 6s ...  6s
generic/012	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
generic/013 9s ...  9s
generic/014 10s ...  8s
generic/015	[not run] this test requires a valid $SCRATCH_DEV
generic/016	[not run] xfs_io fiemap  failed (old kernel/wrong fs?)
generic/017	[not run] this test requires a valid $SCRATCH_DEV
generic/018	[not run] this test requires a valid $SCRATCH_DEV

I must be missing something that you have in your environment.


--
Chuck Lever



