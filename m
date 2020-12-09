Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581912D3E0B
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 10:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgLIJAh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 04:00:37 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:58751 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728437AbgLIJAh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Dec 2020 04:00:37 -0500
X-IronPort-AV: E=Sophos;i="5.78,404,1599494400"; 
   d="scan'208";a="102217345"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Dec 2020 16:59:26 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 625AF4CE6014;
        Wed,  9 Dec 2020 16:59:26 +0800 (CST)
Received: from localhost.localdomain (10.167.226.82) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 9 Dec 2020 16:59:26 +0800
From:   Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Subject: generic/615 failed on virtiofs + nfsv4(ac)
To:     <fstests@vger.kernel.org>
CC:     <linux-nfs@vger.kernel.org>
Message-ID: <f5fdde28-a1a5-5453-709d-9e1bdcac41f2@cn.fujitsu.com>
Date:   Wed, 9 Dec 2020 16:59:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.167.226.82]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 625AF4CE6014.A818A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: liuyd.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi, all.


Recently i test xfstest virtiofs, i met below error

```

[root@localhost xfstests]# ./check -virtiofs generic/615
FSTYP         -- virtiofs
PLATFORM      -- Linux/aarch64 localhost 4.18.0-240.el8.aarch64 #1 SMP 
Wed Sep 23 05:09:38 EDT 2020
MKFS_OPTIONS  -- nfsmyfs1
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 nfsmyfs1 
/mnt/scratch

generic/615 37s ... - output mismatch (see 
/root/xfstests/results//generic/615.out.bad)
     --- tests/generic/615.out    2020-11-25 18:53:52.209183050 +0800
     +++ /root/xfstests/results//generic/615.out.bad    2020-11-26 
09:11:42.864359280 +0800
     @@ -1,3 +1,4 @@
      QA output created by 615
      Testing buffered writes
     +error: stat(2) reported zero blocks
      Testing direct IO writes
     ...
     (Run 'diff -u /root/xfstests/tests/generic/615.out 
/root/xfstests/results//generic/615.out.bad'  to see the entire diff)
Ran: generic/615
Failures: generic/615
Failed 1 of 1 tests

```


Env setting

```

Local NFS Server setting

# cat /etc/exports
  /home/nfs/share0 127.0.0.1(insecure,no_root_squash,rw,async)
  /home/nfs/share1 127.0.0.1(insecure,no_root_squash,rw,async)

Mount nfs option

# mount | grep nfs
[snip]
127.0.0.1:/home/nfs/share0 on /mnt/nfs/share0 type nfs4 
(rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=127.0.0.1,local_lock=none,addr=127.0.0.1)
127.0.0.1:/home/nfs/share1 on /mnt/nfs/share1 type nfs4 
(rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=127.0.0.1,local_lock=none,addr=127.0.0.1)

```

How to reproduce

1. start a guest with virtiofsd and mount host nfsdir

Please refer to my guest xml

```

     <filesystem type='mount' accessmode='passthrough'>
       <driver type='virtiofs'/>
       <binary path='/usr/libexec/virtiofsd'>
         <lock posix='off' flock='off'/>
       </binary>
       <source dir='/mnt/nfs/share0'/>
       <target dir='nfsmyfs0'/>
       <address type='pci' domain='0x0000' bus='0x0a' slot='0x00' 
function='0x0'/>
     </filesystem>
     <filesystem type='mount' accessmode='passthrough'>
       <driver type='virtiofs'/>
       <binary path='/usr/libexec/virtiofsd'>
         <lock posix='off' flock='off'/>
       </binary>
       <source dir='/mnt/nfs/share1'/>
       <target dir='nfsmyfs1'/>
       <address type='pci' domain='0x0000' bus='0x0b' slot='0x00' 
function='0x0'/>
     </filesystem>

```

2. Install xfstest and setup local.config

```

export TEST_DEV=nfsmyfs0
export TEST_DIR=/mnt/test
export SCRATCH_DEV=nfsmyfs1
export SCRATCH_MNT=/mnt/scratch
export FSX_AVOID="-E"

```

3. run cmd './check -virtiofs generic/615'



generic/615 test for non-zero used blocks while writing into a file,

this test keeps overwriting an entire file and use stat cmd to check 
zero blocks,
if zero-blocks exist, test failed.


nfsv4 cache feature is enabled by default, so i think cache feature may 
cause this failure.

When nfs cache files, write content will be temporarily placed in memory 
then write to disk.

There will be a delay before the write content is finally written to the 
file.


So when we first time use stat cmd, write content is under memory, file 
maybe empty, that is why test failed.

So i set nfsv4 noac option, test really passed.


But it is interesting that this test passed on nfsv3 without any special 
setting.

Anybody could help explain it?


Very appreciate and feel free to comment out if i am wrong. ;-)


-- 
Best Regards.
Liu Yiding



