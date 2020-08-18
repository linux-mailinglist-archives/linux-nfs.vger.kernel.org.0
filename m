Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0852486BF
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Aug 2020 16:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgHROK3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Aug 2020 10:10:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46672 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgHROK2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Aug 2020 10:10:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IE1aRd117919;
        Tue, 18 Aug 2020 14:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=4rZo0rC6+j8nAEC7rdPQaPtpp4HgCJVC0uSUYUYR8AA=;
 b=rkB1D35yX5vXccbbKAoZ3J+oUmRC2sciuKJ5+Iu5tZqayC1MGcLH9C2p9NFqUh1kiYhp
 sIna6yEhbqhm2Http+RiVzCWB3TIkJTb9XKH1Nj3dI7M8Rm8Wb94Fo3f7piSTZFRkz24
 oKNPYAfeGWRbuFIaPQpDSAhLF8ODbRAbYrtFY51BUHYQB6MbWDEGYPkGaakLZgYcjeJk
 +tmCAnZQY/KIoY/YmC3XJaHlIIf3QLqzJmg9nZo+WCypbQP1HM4uVnSpGu7k9wNW+bYG
 pIsTbgNoL7p7R+5YOD6KuuEW0RAJ+P7UshbyBB2KREafkoAEAtcTpw24I8tva0E/Fcrk qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 32x7nmcvx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Aug 2020 14:10:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IE4D9t149069;
        Tue, 18 Aug 2020 14:08:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32xsfrwnnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 14:08:21 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07IE8KVr016775;
        Tue, 18 Aug 2020 14:08:20 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Aug 2020 07:08:16 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: Kernel panic in laundromat_main on 5.3.0-46-generic (Ubuntu HWE)
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAL9i7GHMbU9_5i6r-c=kmv+q0LPTKAX8WX0bNxpwzeXT=UjN-g@mail.gmail.com>
Date:   Tue, 18 Aug 2020 10:08:12 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9AB0122A-E656-416E-86A7-B2A623E57152@oracle.com>
References: <CAL9i7GFmOOCWoOnGuDORCCHonFE7siUxSvAvP4TpWX5+CR601g@mail.gmail.com>
 <CAL9i7GHMbU9_5i6r-c=kmv+q0LPTKAX8WX0bNxpwzeXT=UjN-g@mail.gmail.com>
To:     sea you <seayou@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180102
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

> On Aug 12, 2020, at 5:24 AM, sea you <seayou@gmail.com> wrote:
>=20
> After upgrading the kernel to 5.4.0-39-generic, the very same happened =
again.
> You could find more information here on LaunchPad
> =
https://bugs.launchpad.net/ubuntu/+source/linux-signed-hwe/+bug/1885265
>=20
> Anyone else experienced this? This definitely looks like a bug to me
> at this point.

Thanks for the bug report.

This appears to be a distributor's kernel and ZFS (which is an out-
of-tree filesystem) is the backend.

The distributor will have to drill down on this issue with a recent
upstream kernel and a native filesystem to demonstrate we have an
upstream bug.


> On Thu, May 14, 2020 at 12:26 PM sea you <seayou@gmail.com> wrote:
>>=20
>> Hi all,
>>=20
>> Today we've seen a kernel panic that looks like related to =
delegations
>> and laundromat
>>=20
>> ...
>> [1388051.959652] Call Trace:
>> [1388051.959984]  unhash_delegation_locked+0x39/0xa0 [nfsd]
>> [1388051.960631]  laundromat_main+0x235/0x5a0 [nfsd]
>> [1388051.961234]  process_one_work+0x1fd/0x3f0
>> [1388051.961803]  worker_thread+0x34/0x410
>> [1388051.962281]  kthread+0x121/0x140
>> [1388051.962698]  ? process_one_work+0x3f0/0x3f0
>> [1388051.963210]  ? kthread_park+0xb0/0xb0
>> [1388051.963690]  ret_from_fork+0x22/0x40
>> ....
>>=20
>> In the link below you'll find what has been captured from the =
console.
>>=20
>> https://pastebin.com/raw/CdpMfUAK
>>=20
>> I couldn't really find any reference to this in the mailing list
>> history so I assume we might have hit a bug that is unknown so far.
>>=20
>> Best regards,
>> Doma

--
Chuck Lever



