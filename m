Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD3F9143B16
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2020 11:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgAUKgP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jan 2020 05:36:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55263 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727220AbgAUKgP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Jan 2020 05:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579602974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=M2kuuOeXMyMLr2zuizkBTPrFYP9x8G/QKoyyYmmYDqQ=;
        b=g9ldwPqPAs7hJ2+tAGajcdF+gld/g8u6XLPhltJGE0E/brYsxTg9D9mE3nY/Fj5guTprt5
        Ey0AdilF/bqoo3066dVA2Wmr12OMUJsOFzKouh3M6ioo+zYW9YZCIittfH9tKxobGZaUSO
        7aRKF5HAEx5/x1Qkc+/2DAf7OU0Ebx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-5rJ9OBsCNWq6A9dNMWKMcA-1; Tue, 21 Jan 2020 05:36:12 -0500
X-MC-Unique: 5rJ9OBsCNWq6A9dNMWKMcA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0D21800D4E
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jan 2020 10:36:11 +0000 (UTC)
Received: from yoyang-pc.usersys.redhat.com (dhcp-12-152.nay.redhat.com [10.66.12.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66FAE1CB;
        Tue, 21 Jan 2020 10:36:10 +0000 (UTC)
Date:   Tue, 21 Jan 2020 18:36:06 +0800
From:   Yongcheng Yang <yoyang@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     bfields@redhat.com, xzhou@redhat.com, bxue@redhat.com
Subject: [Problem in 5.5.0-rc6+] write file larger than avail in nfs mp hangs
 but it should return ENOSPC
Message-ID: <20200121103606.GA1983@yoyang-pc.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

I have just hit a problem that a process writing a large file (bigger than
available) in nfs mountpoint hangs forever (even after it's full).

It might loop in read()/write() when checked by `ltrace`.

Please does anyone hit this problem?  And do we need to fix it?


Thanks,
Yongcheng


Steps:
~~~~~~~~~~~~
- NFS server
1. Prepare a partition with arbitrary size (e.g., 4G).
2. Format the partition as xfs or ext4.
3. Mount the partition and then exports the directory via nfs.

- NFS client
1. Mount the NFS server's directory.
2. Execute dd command to the directory's file which should hit the
   size limit and it should return "No space left on device".
   # dd if=/dev/zero of=/mnt/nfs/file bs=100K count=4G


For examples (I just test in single host):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[root ~]# truncate --size 4G /tmp/test.img
[root ~]# losetup -f
/dev/loop0
[root ~]# losetup /dev/loop0 /tmp/test.img
[root ~]# mkdir /export_test /mnt/mnt_test
[root ~]# mkfs.ext4 /dev/loop0
mke2fs 1.44.6 (5-Mar-2019)
Discarding device blocks: done
Creating filesystem with 1048576 4k blocks and 262144 inodes
Filesystem UUID: c3bd7b89-b134-4930-82f3-7489baa76849
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done

[root ~]# echo $?
0
[root ~]# mount -t ext4 /dev/loop0 /export_test/
[root ~]# systemctl start nfs-server
[root ~]# exportfs -o rw,no_root_squash *:/export_test/
[root ~]# mount -t nfs $HOSTNAME:/export_test /mnt/mnt_test
[root ~]# dd if=/dev/random of=/mnt/mnt_test/testfile bs=100K count=4G
...
# hang
...


[root ~]# umount /mnt/mnt_test/
[root ~]# 
[root ~]# systemctl stop nfs-server
[root ~]# 
[root ~]# umount /export_test/
[root ~]# mount | grep loop
[root ~]# wipefs -a /dev/loop0 
/dev/loop0: 2 bytes were erased at offset 0x00000438 (ext4): 53 ef
[root ~]# 
[root ~]# 
[root ~]# mkfs.xfs /dev/loop0 
meta-data=/dev/loop0             isize=512    agcount=4, agsize=262144 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1 
data     =                       bsize=4096   blocks=1048576, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
[root ~]# 
[root ~]# mount -t xfs /dev/loop0 /export_test/
[root ~]# systemctl start nfs-server
[root ~]# exportfs -o rw,no_root_squash *:/export_test/
[root ~]# mount -t nfs $HOSTNAME:/export_test /mnt/mnt_test
[root ~]# dd if=/dev/zero of=/mnt/mnt_test/testfile count=4G
...
# hang
...

#
# debug from another terminal
#

[root temp]# nfsstat -m
/mnt/mnt_test from nfsserver.redhat.com:/export_test
 Flags: rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.73.4.183,local_lock=none,addr=10.73.4.183

[root temp]# df -h /mnt/mnt_test/
Filesystem                         Size  Used Avail Use% Mounted on
nfsserver.redhat.com:/export_test  4.0G  4.0G  1.0M 100% /mnt/mnt_test
[root temp]# ps aux | grep -v grep | grep -w dd
root      5569 97.5  0.0   4792  1700 pts/0    R+   03:10 132:13 dd if=/dev/zero of=/mnt/mnt_test/testfile count=4G
[root temp]# ltrace -p 5569
memcpy(0x56179886d000, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512)                      = 0x56179886d000
write(1, "", 512)                                                                                                       = 512
read(0, "", 512)                                                                                                        = 512
memcpy(0x56179886d000, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512)                      = 0x56179886d000
write(1, "", 512)                                                                                                       = 512
read(0, "", 512)                                                                                                        = 512
memcpy(0x56179886d000, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512)                      = 0x56179886d000
write(1, "", 512)                                                                                                       = 512
read(0, "", 512)                                                                                                        = 512
...
...
...
...

