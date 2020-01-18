Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07C33141594
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jan 2020 03:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgARC3v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 21:29:51 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34804 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgARC3v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jan 2020 21:29:51 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00I2O18E108187;
        Sat, 18 Jan 2020 02:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=M4ZUJ2xp7qR6SRaJDsc+H+xQSXT5t8Be4QHmeKnhuJs=;
 b=revwBFhYYPRzN5caYSV4qk5hXUKx64P3V1Lrl6bgZjfqKf89QJtKKNDW+NGRp8owpWNv
 nbL4KN3jXbhutz36Gi3S69YAfBvTQbv/2oROPebZps9pFPax+zPVC+R9e6Bswy++bMGz
 DfqIXEFq56d/bIhg3wziPkYlZAVk4OpslvMxUfIbiWXnoepnm+VEPetyhxf5uRFhzGkT
 0mO62yjg0eJgcCqR89FySpE5vLOUf5hlMlTtxg2syU2K4tBmFy8EMA7cI9AY+hSnUP7A
 GjHB/arC1JITxJImeWdiJwJ6MWj9uYUXOIxxLgKCgjRFu0xbecT7C8A2Rw64tmL4YaVZ dQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xf73ubt5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jan 2020 02:29:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00I2Nv3K086066;
        Sat, 18 Jan 2020 02:29:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2xk2363pjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jan 2020 02:29:45 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00I2TebA011067;
        Sat, 18 Jan 2020 02:29:44 GMT
Received: from dhcp-10-154-100-78.vpn.oracle.com (/10.154.100.78)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jan 2020 18:29:40 -0800
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
Message-ID: <8439e738-6c90-29d9-efc8-300420b096b1@oracle.com>
Date:   Fri, 17 Jan 2020 18:29:39 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <49bfa6104b6a65311594efd47592b5c2b25d905a.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001180019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001180019
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

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

If I understand your concern correctly that in NFSv3 the client must
maintain valid cookies and cookie verifiers when switching between
READDIR and READDIRPLUS, or vice sersa, then I think the current client
code handles this condition ok.

On the client, both READDIR and READDIRPLUS requests use the cookie values
from the same cached pages of the directory so I don't think they can be
out of sync when the client switches between READDIRPLUS and READDIR
requests for different nfs_readdir calls.

In fact, currently the first nfs_readdir uses READDIRPLUS's to fill read
the entries and if there is no LOOKUP/GETATTR on one of the directory
entries then the client reverts to READDIR's for subsequent nfs_readdir
calls without invalidating any cached pages of the directory. If there
are LOOKUP/GETATTR done on one of the directory entries then
nfs_advise_use_readdirplus is called which forces the client to use
READDIRPLUS again for the next nfs_readdir.
  
Unless the user mounts the export with 'nordirplus' option then the
client uses only READDIRs for all requests, no switching takes place.


Thanks,
-Dai

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
>
