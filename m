Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 537B317A8A1
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2020 16:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgCEPPw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Mar 2020 10:15:52 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56798 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgCEPPw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Mar 2020 10:15:52 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 025FE8iK069453;
        Thu, 5 Mar 2020 15:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=HWXS7sWP7MtSqYLHZPHK5VpfhN5mWLnNDXOltxT0TPw=;
 b=H/SVGCetLOOTQc14m/AFsu+Z9iaNKcFaoQduy5g30yQE14GXnQWNq3bh4p2RA2BIJYpg
 FrOw1UNLcbfDisZHWRmQIkDA/TKzevuM7QiyvJ6N1orNI6NaEiMbY0utdWYqGCNHEvAq
 bcW+5qXCpVc/ff9dT+F5Rg+7qZkxxdrCdRmj4CLW5lftvNBr2ja99oF24KnDpS2nupXy
 SfD9ECbfYkX+jDXz4TZUoGprhw9Q0CfKHYmyfdgXIP4EfOeH9yl/xMuHE5PM+hIDKhO6
 B4xrcTlLAShbud8eUfc6337A3nl7g6iPfRa8GFqliwzDIC3lH4VysHxw4E/CWSGww2+K dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2yffwr5sk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Mar 2020 15:15:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 025FCxnP110690;
        Thu, 5 Mar 2020 15:15:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2yg1rvt4av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Mar 2020 15:15:35 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 025FFV6b000307;
        Thu, 5 Mar 2020 15:15:32 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Mar 2020 07:15:31 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] nfsd: Fix build error
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <ff3a1cae-c628-9324-f32f-c7e694585686@huawei.com>
Date:   Thu, 5 Mar 2020 10:15:30 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B4220557-CDE0-4B74-ADB2-4B4CD6477A2B@oracle.com>
References: <20200304131803.46560-1-yuehaibing@huawei.com>
 <BC0E3531-B282-4C04-9540-C39C6F4A1A5D@oracle.com>
 <20200304200609.GA26924@fieldses.org>
 <ff3a1cae-c628-9324-f32f-c7e694585686@huawei.com>
To:     Yuehaibing <yuehaibing@huawei.com>,
        Bruce Fields <bfields@fieldses.org>,
        Olga Kornievskaia <kolga@netapp.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003050099
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 4, 2020, at 10:46 PM, Yuehaibing <yuehaibing@huawei.com> wrote:
>=20
> On 2020/3/5 4:06, Bruce Fields wrote:
>> On Wed, Mar 04, 2020 at 01:00:12PM -0500, Chuck Lever wrote:
>>> Hi-
>>>=20
>>>> On Mar 4, 2020, at 8:18 AM, YueHaibing <yuehaibing@huawei.com> =
wrote:
>>>>=20
>>>> fs/nfsd/nfs4proc.o: In function `nfsd4_do_copy':
>>>> nfs4proc.c:(.text+0x23b7): undefined reference to `nfs42_ssc_close'
>>>> fs/nfsd/nfs4proc.o: In function `nfsd4_copy':
>>>> nfs4proc.c:(.text+0x5d2a): undefined reference to `nfs_sb_deactive'
>>>> fs/nfsd/nfs4proc.o: In function `nfsd4_do_async_copy':
>>>> nfs4proc.c:(.text+0x61d5): undefined reference to `nfs42_ssc_open'
>>>> nfs4proc.c:(.text+0x6389): undefined reference to `nfs_sb_deactive'
>>>>=20
>>>> Add dependency to NFSD_V4_2_INTER_SSC to fix this.
>>>>=20
>>>> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>> ---
>>>> fs/nfsd/Kconfig | 1 +
>>>> 1 file changed, 1 insertion(+)
>>>>=20
>>>> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
>>>> index f368f32..fc587a5 100644
>>>> --- a/fs/nfsd/Kconfig
>>>> +++ b/fs/nfsd/Kconfig
>>>> @@ -136,6 +136,7 @@ config NFSD_FLEXFILELAYOUT
>>>>=20
>>>> config NFSD_V4_2_INTER_SSC
>>>> 	bool "NFSv4.2 inter server to server COPY"
>>>> +	depends on !(NFSD=3Dy && NFS_FS=3Dm)
>>>=20
>>> The new dependency is not especially clear to me; more explanation
>>> in the patch description about the cause of the build failure
>>> would definitely be helpful.
>>>=20
>>> NFSD_V4 can't be set unless NFSD is also set.
>>>=20
>>> NFS_V4_2 can't be set unless NFS_V4_1 is also set, and that cannot
>>> be set unless NFS_FS is also set.
>>>=20
>>> So what's really going on here?
>>=20
>> I don't understand that "depends" either.
>>=20
>> The fundamental problem, though, is that nfsd is calling nfs code
>> directly.
>=20
> Yes
>=20
>>=20
>> Which I noticed in earlier review and then forgot to follow up on,
>> sorry.
>>=20
>> So either we:
>>=20
>> 	- let nfsd depend on nfs, fix up Kconfig to reflect the fact, or
>=20
> It only fails while NFSD=3Dy && NFS_FS=3Dm, other cases works fine as =
Chuck Lever pointed.

TL;DR - we probably need both of Bruce's options, IMO.

IIUC current distributions have the NFS client and server built as
separate modules. On an NFS server, most of the time there would be
no NFS mounts, thus the NFS client module is unlikely to be in memory
when an inter-SSC type request arrives.

Stated differently, enabling SSC cannot break the kernel build when
the client is built as a module. So we need NFS_FS=3Dm to work because
it is the most common configuration.

If creating that fix will take longer than the next merge window, it
would be good practice IMO if some kind of Kconfig dependency were
introduced now to prevent SSC from being enabled when NFS_FS=3Dm. =
Someone
with better Kconfig fu than me should have a look at Yue's proposed
patch. Once the long term solution is ready, this temporary fix can
be reverted.


>> 	- write some code so nfsd can load nfs and find those symbols at
>> 	  runtime if it needs to do a copy.
>>=20
>> The latter's certainly doable, but it'd be simplest to do the former.
>> Are there actually a lot of people who want nfsd but not nfs?  Does =
that
>> cause a real problem for anyone?
>>=20
>> --b.

--
Chuck Lever



