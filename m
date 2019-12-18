Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 262D2123BA4
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 01:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfLRAeM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Dec 2019 19:34:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35802 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfLRAeM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Dec 2019 19:34:12 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBI0JZev189724
        for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2019 00:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : from : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=oBFhrgPPKrQ1c8LZtsNVAx6L0TsskOalFHhuYAlczRA=;
 b=HPZMHj3XuKOGps3/qlBbuyB8gzwWt061w6W6SDyp9Mv7cPUui23VfZZGeFnQzrBXKut/
 DCNwq4B1DxBXH5pqEsGT2UhVBZwP4r+TmM47nA7V8/vPUft+ekhVQp+dXdkecqY0KHNH
 9JZw5ugS6yLu/Mnvi4wvb+We2PKs80hSe34EF25oT58KNbV32PJkoZf4He8T6S1V57m3
 Rk6RIhcbFcLPVF6G+r8Nb0PpWyQV5HSuXRP/AUIIGC6yJ/WliDyI4XbdNw5bNMeMWAxw
 PYHmuhSbaFThR/LZZbv7QclLgWIdWGvNUL3T9ttjdF4VsXaNoODoevlNPuZNKdbtPY3K 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wvq5uj9uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2019 00:34:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBI0JETb086029
        for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2019 00:34:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wxm4wj8hd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2019 00:34:09 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBI0Y8EJ003393
        for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2019 00:34:08 GMT
Received: from Macbooks-MacBook-Pro.local (/10.39.208.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Dec 2019 16:34:08 -0800
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From:   Dai Ngo <dai.ngo@oracle.com>
Subject: 'ls -lrt' performance issue on large dir while dir is being modified
Message-ID: <e04baa28-2460-4ced-e387-618ea32d827c@oracle.com>
Date:   Tue, 17 Dec 2019 16:34:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912180001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912180001
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I'd like to report an issue with 'ls -lrt' on NFSv3 client takes
a very long time to display the content of a large directory
(100k - 200k files) while the directory is being modified by
another NFSv3 client.

The problem can be reproduced using 3 systems. One system serves
as the NFS server, one system runs as the client that doing the
'ls -lrt' and another system runs the client that creates files
on the server.
     
Client1 creates files using this simple script:

> #!/bin/sh
>
> if [ $# -lt 2 ]; then
>         echo "Usage: $0 number_of_files base_filename"
>         exit
> fi    
> nfiles=$1
> fname=$2
> echo "creating $nfiles files using filename[$fname]..."
> i=0   
>       
> while [ i -lt $nfiles ] ;
> do    
>         i=`expr $i + 1`
>         echo "xyz" > $fname$i
>         echo "$fname$i" 
> done

Client2 runs 'time ls -lrt /tmp/mnt/bd1 |wc -l' in a loop.

The network traces and dtrace probes showed numerous READDIRPLUS3
requests restarting  from cookie 0 which seemed to indicate the
cached pages of the directory were invalidated causing the pages
to be refilled starting from cookie 0 until the current requested
cookie.  The cached page invalidation were tracked to
nfs_force_use_readdirplus().  To verify, I made the below
modification, ran the test for various kernel versions and
captured the results shown below.

The modification is:

> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index a73e2f8bd8ec..5d4a64555fa7 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -444,7 +444,7 @@ void nfs_force_use_readdirplus(struct inode *dir)
>      if (nfs_server_capable(dir, NFS_CAP_READDIRPLUS) &&
>          !list_empty(&nfsi->open_files)) {
>          set_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags);
> -        invalidate_mapping_pages(dir->i_mapping, 0, -1);
> +        nfs_zap_mapping(dir, dir->i_mapping);
>      }
>  }

Note that after this change, I did not see READDIRPLUS3 restarting
with cookie 0 anymore.

Below are the summary results of 'ls -lrt'.  For each kernel version
to be compared, one row for the original kernel and one row for the
kernel with the above modification.

I cloned dtrace-linux from here:
github.com/oracle/dtrace-linux-kernel

dtrace-linux 5.1.0-rc4 [ORI] 89191: 2m59.32s   193071: 6m7.810s
dtrace-linux 5.1.0-rc4 [MOD] 98771: 1m55.900s  191322: 3m48.668s

I cloned upstream Linux from here:
git.kernel.org/pub/scm/linux/kernel/git/tovards/linux.git

Upstream Linux 5.5.0-rc1 [ORI] 87891: 5m11.089s  160974: 14m4.384s
Upstream Linux 5.5.0-rc1 [MOD] 87075: 5m2.057s   161421: 14m33.615s

Please note that these are relative performance numbers and are used
to illustrate the issue only.

For reference, on the original dtrace-linux it takes about 9s for
'ls -ltr' to complete on a directory with 200k files if the directory
is not modified while 'ls' is running.

The number of the original Upstream Linux is *really* bad, and the
modification did not seem to have any effect, not sure why...
it could be something else is going on here.

The cache invalidation in nfs_force_use_readdirplus seems too
drastic and might need to be reviewed. Even though this change
helps but it did not get the 'ls' performance to where it's
expected to be. I think even though READDIRPLUS3 was used, the
attribute cache was invalidated due to the directory modification,
causing attribute cache misses resulting in the calls to
nfs_force_use_readdirplus as shown in this stack trace:

   0  17586     page_cache_tree_delete:entry
               vmlinux`remove_mapping+0x14
               vmlinux`invalidate_inode_page+0x7c
               vmlinux`invalidate_mapping_pages+0x1dd
               nfs`nfs_force_use_readdirplus+0x47
               nfs`__dta_nfs_lookup_revalidate_478+0x5dd
               vmlinux`d_revalidate.part.24+0x10
               vmlinux`lookup_fast+0x254
               vmlinux`walk_component+0x49
               vmlinux`path_lookupat+0x79
               vmlinux`filename_lookup+0xaf
               vmlinux`user_path_at_empty+0x36
               vmlinux`vfs_statx+0x77
               vmlinux`SYSC_newlstat+0x3d
               vmlinux`SyS_newlstat+0xe
               vmlinux`do_syscall_64+0x79
               vmlinux`entry_SYSCALL_64+0x18d

Besides the overhead of refilling the page caches from cookie 0,
I think the reason 'ls' still takes so long to compete because the
client has to send a bunch of additional LOOKUP/ACCESS requests
over the wire to service the stat(2) calls from 'ls' due to the
attribute cache misses.

Please let me know you what you think and if there is any addition
information is needed.

Thanks,
-Dai


