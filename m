Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E179179AA2
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2020 22:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgCDVFW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Mar 2020 16:05:22 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48154 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCDVFV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Mar 2020 16:05:21 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024KwBVI031961;
        Wed, 4 Mar 2020 21:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=durUIH9nl11hlJYfROfWjX3IyST0g9f4WzIcjysdPBw=;
 b=V4FgB3DId1elpFDmnrLyVa9jxp0vFh1BnmIKfLnt3zh0Qc9CQ+1qDf/N5xhzJMgx3e2K
 EthmboMw5VvqSYyiHQl0ljHYBsiPggTMLg674A3z1rOCF8k2+yRQxyK+w9tOX1qLL4Jg
 iNF6jhkkkU/qvkPV99rlPtcSOQx3XE/A0+6SHzTbP6U9oU6GgVWGNDnVCYqTTNiSMfRG
 94Q4KabFV08+UpwZhiWhazEhTbmC99Li73mtR3Zf+XFCsYxjDKx1BVxZld27fPgIzvwc
 WjyUuAAyBbOVOum+yxVZMj4bU597koQLykFjzeAuKx9BZdkyv3D1Z3bdi1AYW2sC5oVf Og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2yffwr0yd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 21:05:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024Kv7BJ172542;
        Wed, 4 Mar 2020 21:05:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2yg1h1prht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 21:05:11 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 024L55hS019510;
        Wed, 4 Mar 2020 21:05:08 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Mar 2020 13:05:05 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] nfsd: Fix build error
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200304200609.GA26924@fieldses.org>
Date:   Wed, 4 Mar 2020 16:05:03 -0500
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9592D8FB-C758-4B52-962B-B04A00627A43@oracle.com>
References: <20200304131803.46560-1-yuehaibing@huawei.com>
 <BC0E3531-B282-4C04-9540-C39C6F4A1A5D@oracle.com>
 <20200304200609.GA26924@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040136
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 4, 2020, at 3:06 PM, Bruce Fields <bfields@fieldses.org> wrote:
> 
> On Wed, Mar 04, 2020 at 01:00:12PM -0500, Chuck Lever wrote:
>> Hi-
>> 
>>> On Mar 4, 2020, at 8:18 AM, YueHaibing <yuehaibing@huawei.com> wrote:
>>> 
>>> fs/nfsd/nfs4proc.o: In function `nfsd4_do_copy':
>>> nfs4proc.c:(.text+0x23b7): undefined reference to `nfs42_ssc_close'
>>> fs/nfsd/nfs4proc.o: In function `nfsd4_copy':
>>> nfs4proc.c:(.text+0x5d2a): undefined reference to `nfs_sb_deactive'
>>> fs/nfsd/nfs4proc.o: In function `nfsd4_do_async_copy':
>>> nfs4proc.c:(.text+0x61d5): undefined reference to `nfs42_ssc_open'
>>> nfs4proc.c:(.text+0x6389): undefined reference to `nfs_sb_deactive'
>>> 
>>> Add dependency to NFSD_V4_2_INTER_SSC to fix this.
>>> 
>>> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>> ---
>>> fs/nfsd/Kconfig | 1 +
>>> 1 file changed, 1 insertion(+)
>>> 
>>> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
>>> index f368f32..fc587a5 100644
>>> --- a/fs/nfsd/Kconfig
>>> +++ b/fs/nfsd/Kconfig
>>> @@ -136,6 +136,7 @@ config NFSD_FLEXFILELAYOUT
>>> 
>>> config NFSD_V4_2_INTER_SSC
>>> 	bool "NFSv4.2 inter server to server COPY"
>>> +	depends on !(NFSD=y && NFS_FS=m)
>> 
>> The new dependency is not especially clear to me; more explanation
>> in the patch description about the cause of the build failure
>> would definitely be helpful.
>> 
>> NFSD_V4 can't be set unless NFSD is also set.
>> 
>> NFS_V4_2 can't be set unless NFS_V4_1 is also set, and that cannot
>> be set unless NFS_FS is also set.
>> 
>> So what's really going on here?
> 
> I don't understand that "depends" either.
> 
> The fundamental problem, though, is that nfsd is calling nfs code
> directly.
> 
> Which I noticed in earlier review and then forgot to follow up on,
> sorry.
> 
> So either we:
> 
> 	- let nfsd depend on nfs, fix up Kconfig to reflect the fact, or
> 	- write some code so nfsd can load nfs and find those symbols at
> 	  runtime if it needs to do a copy.

Another practical option would be to create a copy of these functions in
the server's SSC code. At least nfs_sb_deactive() is not large.

Not clear if nfs42_ssc_open/close are even used on the client. Maybe they
could be moved to the server?

> The latter's certainly doable, but it'd be simplest to do the former.
> Are there actually a lot of people who want nfsd but not nfs?  Does that
> cause a real problem for anyone?
> 
> --b.

--
Chuck Lever



