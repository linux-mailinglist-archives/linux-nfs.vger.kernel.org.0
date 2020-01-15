Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D40F613CD1A
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2020 20:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgAOT34 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jan 2020 14:29:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41250 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAOT34 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jan 2020 14:29:56 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FJS3pZ176217;
        Wed, 15 Jan 2020 19:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=BEJENXdV2A+/FGc/y4aR7MLksTMX99BwOP/NccHtgRY=;
 b=iQ9CfwKn/bPyl6pzcyJPT+WlynJb8Ow3BTv3eWArgs18nUFe2rk/jl3ohMUk1M+wrf7X
 UpW/eq2QvW0vorMv3gnPwAAjjr+TpzWdTJwzH0Z7w4h8LpVI9mPAIikVu+NU/v4Itys2
 HMSGgkM5WXI5c5hC8eE/CfDnvNxnIoxf1vmYCjkeVrLySQAUHiJeoLuonFO6e5W0ro+t
 S0od2ShR/wQugWPCjvEWTymLYgGtgDIJdKNoU42FPObziD/Z0fygSHOdVgUDxIQGMOsr
 Y7AfnkG2L0yrF6YL8AvfqmgO+/l+C26CVLFIHmw9R57t3kBWoVgSLPACcJ4Ax7XSP50t ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xf74se89e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 19:29:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FJTcF4170059;
        Wed, 15 Jan 2020 19:29:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xj61k9rs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 19:29:46 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00FJSf0j012442;
        Wed, 15 Jan 2020 19:28:41 GMT
Received: from Macbooks-MacBook-Pro.local (/68.4.198.220)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 11:28:40 -0800
Subject: Re: 'ls -lrt' performance issue on large dir while dir is being
 modified
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <e04baa28-2460-4ced-e387-618ea32d827c@oracle.com>
 <a41af3d6-8280-e315-fb65-a9285bad50ec@oracle.com>
 <770937d3-9439-db4a-1f6e-59a59f2c08b9@oracle.com>
 <9fdf37ffe4b3f7016a60e3a61c2087a825348b28.camel@hammerspace.com>
 <49bfa6104b6a65311594efd47592b5c2b25d905a.camel@hammerspace.com>
From:   Dai Ngo <dai.ngo@oracle.com>
Message-ID: <d39d4a6b-165b-7fe3-5e9f-896e1c787438@oracle.com>
Date:   Wed, 15 Jan 2020 11:28:39 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <49bfa6104b6a65311594efd47592b5c2b25d905a.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001150149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001150149
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 1/15/20 11:06 AM, Trond Myklebust wrote:
> On Wed, 2020-01-15 at 18:54 +0000, Trond Myklebust wrote:
>> On Wed, 2020-01-15 at 10:11 -0800, Dai Ngo wrote:
>>> Hi Anna, Trond,
>>>
>>> Would you please let me know your opinion regarding reverting the
>>> change in
>>> nfs_force_use_readdirplus to call nfs_zap_mapping instead of
>>> invalidate_mapping_pages.
>>> This change is to prevent the cookie of the READDIRPLUS to be reset
>>> to 0 while
>>> an instance of 'ls' is running and the directory is being modified.
>>>
>>>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c index
>>>> a73e2f8bd8ec..5d4a64555fa7 100644 --- a/fs/nfs/dir.c +++
>>>> b/fs/nfs/dir.c @@ -444,7 +444,7 @@ void
>>>> nfs_force_use_readdirplus(struct inode *dir)      if
>>>> (nfs_server_capable(dir, NFS_CAP_READDIRPLUS) &&
>>>> !list_empty(&nfsi->open_files)) {
>>>> set_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags); -
>>>> invalidate_mapping_pages(dir->i_mapping, 0, -1); +
>>>> nfs_zap_mapping(dir, dir->i_mapping);      }  }
>>> Thanks,
>>> -Dai
>>>
>>> On 12/19/19 8:01 PM, Dai Ngo wrote:
>>>> Hi Anna, Trond,
>>>>
>>>> I made a mistake with the 5.5 numbers. The VM that runs 5.5 has
>>>> some
>>>> problems. There is no regression with 5.5, here are the new
>>>> numbers:
>>>>
>>>> Upstream Linux 5.5.0-rc1 [ORI] 93296: 3m10.917s  197891:
>>>> 10m35.789s
>>>> Upstream Linux 5.5.0-rc1 [MOD] 98614: 1m59.649s  192801:
>>>> 3m55.003s
>>>>
>>>> My apologies for the mistake.
>>>>
>>>> Now there is no regression with 5.5, I'd like to get your opinion
>>>> regarding the change to revert the call from
>>>> invalidate_mapping_pages
>>>> to nfs_zap_mapping in nfs_force_use_readdirplus to prevent the
>>>> current 'ls' from restarting the READDIRPLUS3 from cookie 0. I'm
>>>> not quite sure about the intention of the prior change from
>>>> nfs_zap_mapping to invalidate_mapping_pages so that is why I'm
>>>> seeking advise. Or do you have any suggestions to achieve the
>>>> same?
>>>>
>>>> Thanks,
>>>> -Dai
>>>>
>>>> On 12/17/19 4:34 PM, Dai Ngo wrote:
>>>>> Hi,
>>>>>
>>>>> I'd like to report an issue with 'ls -lrt' on NFSv3 client
>>>>> takes
>>>>> a very long time to display the content of a large directory
>>>>> (100k - 200k files) while the directory is being modified by
>>>>> another NFSv3 client.
>>>>>
>>>>> The problem can be reproduced using 3 systems. One system
>>>>> serves
>>>>> as the NFS server, one system runs as the client that doing the
>>>>> 'ls -lrt' and another system runs the client that creates files
>>>>> on the server.
>>>>>      Client1 creates files using this simple script:
>>>>>
>>>>>> #!/bin/sh
>>>>>>
>>>>>> if [ $# -lt 2 ]; then
>>>>>>          echo "Usage: $0 number_of_files base_filename"
>>>>>>          exit
>>>>>> fi    nfiles=$1
>>>>>> fname=$2
>>>>>> echo "creating $nfiles files using filename[$fname]..."
>>>>>> i=0         while [ i -lt $nfiles ] ;
>>>>>> do            i=`expr $i + 1`
>>>>>>          echo "xyz" > $fname$i
>>>>>>          echo "$fname$i" done
>>>>> Client2 runs 'time ls -lrt /tmp/mnt/bd1 |wc -l' in a loop.
>>>>>
>>>>> The network traces and dtrace probes showed numerous
>>>>> READDIRPLUS3
>>>>> requests restarting  from cookie 0 which seemed to indicate the
>>>>> cached pages of the directory were invalidated causing the
>>>>> pages
>>>>> to be refilled starting from cookie 0 until the current
>>>>> requested
>>>>> cookie.  The cached page invalidation were tracked to
>>>>> nfs_force_use_readdirplus().  To verify, I made the below
>>>>> modification, ran the test for various kernel versions and
>>>>> captured the results shown below.
>>>>>
>>>>> The modification is:
>>>>>
>>>>>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>>>>>> index a73e2f8bd8ec..5d4a64555fa7 100644
>>>>>> --- a/fs/nfs/dir.c
>>>>>> +++ b/fs/nfs/dir.c
>>>>>> @@ -444,7 +444,7 @@ void nfs_force_use_readdirplus(struct
>>>>>> inode
>>>>>> *dir)
>>>>>>       if (nfs_server_capable(dir, NFS_CAP_READDIRPLUS) &&
>>>>>>           !list_empty(&nfsi->open_files)) {
>>>>>>           set_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags);
>>>>>> -        invalidate_mapping_pages(dir->i_mapping, 0, -1);
>>>>>> +        nfs_zap_mapping(dir, dir->i_mapping);
>>>>>>       }
>>>>>>   }
>> This change is only reverting part of commit 79f687a3de9e. My problem
>> with that is as follows:
>>
>> RFC1813 states that NFSv3 READDIRPLUS cookies and verifiers must
>> match
>> those returned by previous READDIRPLUS calls, and READDIR cookies and
>> verifiers must match those returned by previous READDIR calls. It
>> says
>> nothing about being able to assume cookies from READDIR and
>> READDIRPLUS
>> calls are interchangeable. So the only reason I can see for the
>> invalidate_mapping_pages() is to ensure that we do separate the two
>> cookie caches.
>>
>> OTOH, for NFSv4, there is no separate READDIRPLUS function, so there
>> really does not appear to be any reason to clear the page cache at
>> all
>> as we're switching between requesting attributes or not.
>>
> Sorry... To spell out my objection to this change more clearly: The
> call to nfs_zap_mapping() makes no sense in either case.
>   * It defers the cache invalidation until the next call to
>     rewinddir()/opendir(), so it does not address the NFSv3 concern.
>   * It would appear to be entirely superfluous for the NFSv4 case.
>
> So a change that might be acceptable would be to keep the existing call
> to invalidate_mapping_pages() for NFSv3, but to remove it for NFSv4.

Thank you Trond, I'll make your suggested change, test it and resubmit.
     
-Dai

>
