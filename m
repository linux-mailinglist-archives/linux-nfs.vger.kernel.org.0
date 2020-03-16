Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFD6187004
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2020 17:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbgCPQ24 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Mar 2020 12:28:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53766 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731713AbgCPQ24 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Mar 2020 12:28:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02GG8x5D073070;
        Mon, 16 Mar 2020 16:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=yk3DMMLZoQ0T4iLsZb2rp4cpSfXlCrG5f5ND50ud4ig=;
 b=ccMm+mDKv32WCHqxrnAp67yszC093V6L1CNJyj7JB5Lvl//2BQGIhrUm/Agcabb0m+6z
 HsAinjQvxRLNVuFUuk68jn3qFCw/YbP8RSocChQaw2+cz5OCSF3tey5jmK6M35MzB03n
 ZVbGLsw26FYrFHSDKOFQlK4iRKVrd5oQEtY2MilvNwQ67U6rW2kN+tJZFBaJXFfyQij3
 4qeihN55oGmpuliuJ3YgvCFRf3yS7rmd9PKlfV5ObNpiPa1q2JHULCJMTtv0b7Q+fKPQ
 xmGI+S5MsBBQ4fQ/UFjz1rkLrFzv0Qi2kpBHfu7yyoQ2NQ1BbdqVCnSw6PuEz/CelORC Zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2yrppr0065-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Mar 2020 16:23:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02GGJYqo141936;
        Mon, 16 Mar 2020 16:23:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2ys92a2grs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Mar 2020 16:23:51 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02GGNnVo008206;
        Mon, 16 Mar 2020 16:23:50 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Mar 2020 09:23:49 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] NFSD: Fix NFS server build errors
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <384e6acb2cd88596a2d02e18123e9f452ff5ab4b.camel@hammerspace.com>
Date:   Mon, 16 Mar 2020 12:23:47 -0400
Cc:     "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        Bruce Fields <bfields@fieldses.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <90DA0D07-723B-424A-A255-96C44475BC20@oracle.com>
References: <20200305233433.14530.61315.stgit@klimt.1015granger.net>
 <631f52a1-b557-9137-0a7c-f493ac3339af@huawei.com>
 <734C2816-BB0C-4E6B-9894-67C9754DC071@oracle.com>
 <384e6acb2cd88596a2d02e18123e9f452ff5ab4b.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9562 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003160075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9562 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003160075
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 16, 2020, at 12:04 PM, Trond Myklebust =
<trondmy@hammerspace.com> wrote:
>=20
> On Fri, 2020-03-06 at 10:56 -0500, Chuck Lever wrote:
>>> On Mar 5, 2020, at 9:14 PM, Yuehaibing <yuehaibing@huawei.com>
>>> wrote:
>>>=20
>>> On 2020/3/6 7:38, Chuck Lever wrote:
>>>> yuehaibing@huawei.com reports the following build errors arise
>>>> when
>>>> CONFIG_NFSD_V4_2_INTER_SSC is set and the NFS client is not built
>>>> into the kernel:
>>>>=20
>>>> fs/nfsd/nfs4proc.o: In function `nfsd4_do_copy':
>>>> nfs4proc.c:(.text+0x23b7): undefined reference to
>>>> `nfs42_ssc_close'
>>>> fs/nfsd/nfs4proc.o: In function `nfsd4_copy':
>>>> nfs4proc.c:(.text+0x5d2a): undefined reference to
>>>> `nfs_sb_deactive'
>>>> fs/nfsd/nfs4proc.o: In function `nfsd4_do_async_copy':
>>>> nfs4proc.c:(.text+0x61d5): undefined reference to
>>>> `nfs42_ssc_open'
>>>> nfs4proc.c:(.text+0x6389): undefined reference to
>>>> `nfs_sb_deactive'
>>>>=20
>>>> The new inter-server copy code invokes client functions. Until
>>>> the
>>>> NFS server has infrastructure to load the appropriate NFS client
>>>> modules to handle inter-server copy requests, let's constrain the
>>>> way this feature is built.
>>>>=20
>>>> Reported-by: YueHaibing <yuehaibing@huawei.com>
>>>> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>> fs/nfsd/Kconfig |    2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>=20
>>>> Yue - does this work for you? The dependency is easier for me to
>>>> understand.
>>>=20
>>> It works for me.
>>>=20
>>> Tested-by: YueHaibing <yuehaibing@huawei.com> # build-tested
>>=20
>> Thanks, I've added this tag and pushed to nfsd-5.7-testing.
>>=20
>> Bruce and Olga, you can still veto this approach until I push into
>> linux-next. It will be a couple of weeks at least.
>>=20
>>=20
>>>> Bruce and Olga - OK with this temporary solution?
>>>>=20
>>>> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
>>>> index f368f3215f88..99d2cae91bd6 100644
>>>> --- a/fs/nfsd/Kconfig
>>>> +++ b/fs/nfsd/Kconfig
>>>> @@ -136,7 +136,7 @@ config NFSD_FLEXFILELAYOUT
>>>>=20
>>>> config NFSD_V4_2_INTER_SSC
>>>> 	bool "NFSv4.2 inter server to server COPY"
>>>> -	depends on NFSD_V4 && NFS_V4_1 && NFS_V4_2
>>>> +	depends on NFSD_V4 && NFS_V4_1 && NFS_V4_2 && NFS_FS=3Dy
>>>> 	help
>>>> 	  This option enables support for NFSv4.2 inter server to
>>>> 	  server copy where the destination server calls the NFSv4.2
>>=20
>=20
> I'd like to suggest that we do this differently.
>=20
> Let's add a structure
>=20
> struct ssc_client_ops {
>      struct file *(*open)(struct vfsmount *ss_mnt,
>                           struct nfs_fh *src_fh, nfs4_stateid
>                           *stateid);
>      void (*close)(struct file *filep);
> };
>=20
> and then allow the client to register that structure in
> fs/nfs/nfs_common when it is loaded (and unregister when it is
> unloaded). The 'open' and 'close' fields get set to be pointers to the
> functions nfs42_ssc_open and nfs42_ssc_close.
>=20
> We can then add functions in fs/nfs/nfs_common to access the functions
> stored in struct ssc_client_ops, and that can be called by the knfsd
> server.
>=20
> This would allow us to keep both the nfs client and server as modules.
> Only nfs_common needs to be compiled into the kernel (as is the case
> already today).

However perhaps we really want an upcall to do the copy. It could
manage module loading and a temporary mount point with infrastructure
that is already in place, and give a place to hook in policy choices.

No matter which approach is adopted, though, seems to me there is some
discussion and code development that is still needed. Unless someone
can provide such a patch in the next few days, I'd like to continue
with the Kconfig patch for v5.7. It is tested, ready now, and can be
backported easily. And, as this aspect of SSC is brand new, I don't
feel that we need to go to heroic efforts to make everything work
perfectly in v5.7.


--
Chuck Lever



