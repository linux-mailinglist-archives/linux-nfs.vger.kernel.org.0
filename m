Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC4D13CBBD
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2020 19:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgAOSLY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jan 2020 13:11:24 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50380 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbgAOSLX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jan 2020 13:11:23 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FI9BBd110148;
        Wed, 15 Jan 2020 18:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=mn2RuKCTLeVIq1rCuOk76RB9NxKqCEgT54rBx/IoneI=;
 b=olJZu3N6MVrO3PHroSVw533MXr2zMuz7/Q/m5I/e9CZg1wqZUa/TjjQxL3Xp+ZbqZTXY
 DDQ91pI2q80bTQuVUuQbnsS2dZ2JUX1TjGwfpsy2lt+28K5Te40uB1gSNfPG8TqI5wko
 GHHAaMeRZfICPYv+VVJAYZNB65GVHmaIHLedB8zHeGVTuKi8vbBNgpv/p8MYZTVkX7WV
 ahIl6nusUVX0V0xfjBSkCiC54qLWJqLIdmbiv2v7BtZU/Gwu/XGikruEMOmJMESUJlUx
 Y1AQppQtXOVMPudT9tHvnsDz+SLrLwdvvPzWoiBeqWDlYHjO0ObPcbf1UdXyDqdpHzPB vQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xf74sdtfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 18:11:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FI9CIx079025;
        Wed, 15 Jan 2020 18:11:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2xj1prkwr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 18:11:18 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00FIBEeX007341;
        Wed, 15 Jan 2020 18:11:18 GMT
Received: from Macbooks-MacBook-Pro.local (/10.39.241.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 10:11:14 -0800
Subject: Re: 'ls -lrt' performance issue on large dir while dir is being
 modified
From:   Dai Ngo <dai.ngo@oracle.com>
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>
References: <e04baa28-2460-4ced-e387-618ea32d827c@oracle.com>
 <a41af3d6-8280-e315-fb65-a9285bad50ec@oracle.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Message-ID: <770937d3-9439-db4a-1f6e-59a59f2c08b9@oracle.com>
Date:   Wed, 15 Jan 2020 10:11:12 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <a41af3d6-8280-e315-fb65-a9285bad50ec@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001150139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001150139
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna, Trond,

Would you please let me know your opinion regarding reverting the change in
nfs_force_use_readdirplus to call nfs_zap_mapping instead of invalidate_mapping_pages.
This change is to prevent the cookie of the READDIRPLUS to be reset to 0 while
an instance of 'ls' is running and the directory is being modified.

> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c index 
> a73e2f8bd8ec..5d4a64555fa7 100644 --- a/fs/nfs/dir.c +++ 
> b/fs/nfs/dir.c @@ -444,7 +444,7 @@ void 
> nfs_force_use_readdirplus(struct inode *dir)      if 
> (nfs_server_capable(dir, NFS_CAP_READDIRPLUS) &&          
> !list_empty(&nfsi->open_files)) {          
> set_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags); -        
> invalidate_mapping_pages(dir->i_mapping, 0, -1); +        
> nfs_zap_mapping(dir, dir->i_mapping);      }  } 


Thanks,
-Dai

On 12/19/19 8:01 PM, Dai Ngo wrote:
> Hi Anna, Trond,
>
> I made a mistake with the 5.5 numbers. The VM that runs 5.5 has some
> problems. There is no regression with 5.5, here are the new numbers:
>
> Upstream Linux 5.5.0-rc1 [ORI] 93296: 3m10.917s  197891: 10m35.789s
> Upstream Linux 5.5.0-rc1 [MOD] 98614: 1m59.649s  192801: 3m55.003s
>
> My apologies for the mistake.
>
> Now there is no regression with 5.5, I'd like to get your opinion
> regarding the change to revert the call from invalidate_mapping_pages
> to nfs_zap_mapping in nfs_force_use_readdirplus to prevent the
> current 'ls' from restarting the READDIRPLUS3 from cookie 0. I'm
> not quite sure about the intention of the prior change from
> nfs_zap_mapping to invalidate_mapping_pages so that is why I'm
> seeking advise. Or do you have any suggestions to achieve the same?
>
> Thanks,
> -Dai
>
> On 12/17/19 4:34 PM, Dai Ngo wrote:
>> Hi,
>>
>> I'd like to report an issue with 'ls -lrt' on NFSv3 client takes
>> a very long time to display the content of a large directory
>> (100k - 200k files) while the directory is being modified by
>> another NFSv3 client.
>>
>> The problem can be reproduced using 3 systems. One system serves
>> as the NFS server, one system runs as the client that doing the
>> 'ls -lrt' and another system runs the client that creates files
>> on the server.
>>     Client1 creates files using this simple script:
>>
>>> #!/bin/sh
>>>
>>> if [ $# -lt 2 ]; then
>>>         echo "Usage: $0 number_of_files base_filename"
>>>         exit
>>> fi    nfiles=$1
>>> fname=$2
>>> echo "creating $nfiles files using filename[$fname]..."
>>> i=0         while [ i -lt $nfiles ] ;
>>> do            i=`expr $i + 1`
>>>         echo "xyz" > $fname$i
>>>         echo "$fname$i" done
>>
>> Client2 runs 'time ls -lrt /tmp/mnt/bd1 |wc -l' in a loop.
>>
>> The network traces and dtrace probes showed numerous READDIRPLUS3
>> requests restarting  from cookie 0 which seemed to indicate the
>> cached pages of the directory were invalidated causing the pages
>> to be refilled starting from cookie 0 until the current requested
>> cookie.  The cached page invalidation were tracked to
>> nfs_force_use_readdirplus().  To verify, I made the below
>> modification, ran the test for various kernel versions and
>> captured the results shown below.
>>
>> The modification is:
>>
>>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>>> index a73e2f8bd8ec..5d4a64555fa7 100644
>>> --- a/fs/nfs/dir.c
>>> +++ b/fs/nfs/dir.c
>>> @@ -444,7 +444,7 @@ void nfs_force_use_readdirplus(struct inode *dir)
>>>      if (nfs_server_capable(dir, NFS_CAP_READDIRPLUS) &&
>>>          !list_empty(&nfsi->open_files)) {
>>>          set_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags);
>>> -        invalidate_mapping_pages(dir->i_mapping, 0, -1);
>>> +        nfs_zap_mapping(dir, dir->i_mapping);
>>>      }
>>>  }
>>
>> Note that after this change, I did not see READDIRPLUS3 restarting
>> with cookie 0 anymore.
>>
>> Below are the summary results of 'ls -lrt'.  For each kernel version
>> to be compared, one row for the original kernel and one row for the
>> kernel with the above modification.
>>
>> I cloned dtrace-linux from here:
>> github.com/oracle/dtrace-linux-kernel
>>
>> dtrace-linux 5.1.0-rc4 [ORI] 89191: 2m59.32s   193071: 6m7.810s
>> dtrace-linux 5.1.0-rc4 [MOD] 98771: 1m55.900s  191322: 3m48.668s
>>
>> I cloned upstream Linux from here:
>> git.kernel.org/pub/scm/linux/kernel/git/tovards/linux.git
>>
>> Upstream Linux 5.5.0-rc1 [ORI] 87891: 5m11.089s  160974: 14m4.384s
>> Upstream Linux 5.5.0-rc1 [MOD] 87075: 5m2.057s   161421: 14m33.615s
>>
>> Please note that these are relative performance numbers and are used
>> to illustrate the issue only.
>>
>> For reference, on the original dtrace-linux it takes about 9s for
>> 'ls -ltr' to complete on a directory with 200k files if the directory
>> is not modified while 'ls' is running.
>>
>> The number of the original Upstream Linux is *really* bad, and the
>> modification did not seem to have any effect, not sure why...
>> it could be something else is going on here.
>>
>> The cache invalidation in nfs_force_use_readdirplus seems too
>> drastic and might need to be reviewed. Even though this change
>> helps but it did not get the 'ls' performance to where it's
>> expected to be. I think even though READDIRPLUS3 was used, the
>> attribute cache was invalidated due to the directory modification,
>> causing attribute cache misses resulting in the calls to
>> nfs_force_use_readdirplus as shown in this stack trace:
>>
>>   0  17586     page_cache_tree_delete:entry
>>               vmlinux`remove_mapping+0x14
>>               vmlinux`invalidate_inode_page+0x7c
>>               vmlinux`invalidate_mapping_pages+0x1dd
>>               nfs`nfs_force_use_readdirplus+0x47
>>               nfs`__dta_nfs_lookup_revalidate_478+0x5dd
>>               vmlinux`d_revalidate.part.24+0x10
>>               vmlinux`lookup_fast+0x254
>>               vmlinux`walk_component+0x49
>>               vmlinux`path_lookupat+0x79
>>               vmlinux`filename_lookup+0xaf
>>               vmlinux`user_path_at_empty+0x36
>>               vmlinux`vfs_statx+0x77
>>               vmlinux`SYSC_newlstat+0x3d
>>               vmlinux`SyS_newlstat+0xe
>>               vmlinux`do_syscall_64+0x79
>>               vmlinux`entry_SYSCALL_64+0x18d
>>
>> Besides the overhead of refilling the page caches from cookie 0,
>> I think the reason 'ls' still takes so long to compete because the
>> client has to send a bunch of additional LOOKUP/ACCESS requests
>> over the wire to service the stat(2) calls from 'ls' due to the
>> attribute cache misses.
>>
>> Please let me know you what you think and if there is any addition
>> information is needed.
>>
>> Thanks,
>> -Dai
>>
>>
