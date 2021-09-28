Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCBB41A526
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Sep 2021 04:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbhI1CNp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 27 Sep 2021 22:13:45 -0400
Received: from [221.192.235.26] ([221.192.235.26]:54834 "EHLO gwm.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S238512AbhI1CNo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 27 Sep 2021 22:13:44 -0400
Received: from shnc5CD9394CM6 (unknown [10.52.249.198])
        by web2 (Coremail) with SMTP id DkeowAAXHWXTeVJhedaRAA--.35180S2;
        Tue, 28 Sep 2021 10:11:32 +0800 (CST)
From:   "Hong Jiu Jin" <hongjiujin@noboauto.com>
To:     <linux-nfs@vger.kernel.org>
Subject: nfs client deny execute access to QNX nfs server temperally
Date:   Tue, 28 Sep 2021 10:11:31 +0800
Message-ID: <038e01d7b40e$284f5ab0$78ee1010$@noboauto.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="gb2312"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Ade0DicrpfiXrSIWRaOYb/76zE7wJA==
Content-Language: zh-cn
X-CM-TRANSID: DkeowAAXHWXTeVJhedaRAA--.35180S2
X-Coremail-Antispam: 1UD129KBjvJXoW3ZFyrXr1kJr1kAF4UAFW5KFg_yoWDXF1Upr
        W8t3W0krWfKw1jkr1FkwnrW3WvgrWUKr4xXanIqF47C3W8Xrs7J34rtry5twnI93s5X3WD
        Xw4xGwn5Z34Y93DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUymb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjc
        xK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
        AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1j6r15MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
        cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
        8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOb18UUUUU=
X-CM-SenderInfo: pkrqwyplxmx0w6qru0pdxw0hhfrp/
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Guys,

We meet below issue which need all of you help. 

-Question
1、Recently We meet one confuse issue. Sometimes android java application
file.exsits will return false even ls -al can successflly list
/data/vendor/nfs/mount/DVR/media/dvr_sdcard0/nfs_ready.flag.file.
 file permission is -rw-rw-rw-
2、We use native C++ application access api to access that file, it can
successfully access file too.
  If restart device, the issue remains the same and can not recover. If
mannually chmod 777 to
/data/vendor/nfs/mount/DVR/media/dvr_sdcard0/nfs_ready.flag.file,
application will successfully access.
  If restart device again, nfs_ready.flag.file will restore to 666
(-rw-rw-rw-��and Java application can successfully access too. We feel
confused why it happened.
3、After add sunrpc debug to kernel, we found that nfs permission denied in
nfs_execute_ok(-EACCES). You can read trace log in below.

Java API File exisit:
sa8155_v35:/ # dmesg
[  168.383021] NFS call  access
[  168.383906] NFS: nfs_update_inode(0:30/2525216000 fh_crc=0x69ed2ad0 ct=2
info=0x27e7f)
[  168.383911] NFS reply access: 0
[  168.383916] NFS: permission(0:30/2525216000), mask=0x1, res=0
[  168.383939] NFS call  lookup media
[  168.384801] NFS: nfs_update_inode(0:30/2525216000 fh_crc=0x69ed2ad0 ct=2
info=0x27e7f)
[  168.384809] NFS reply lookup: 0
[  168.384814] NFS: nfs_update_inode(0:30/42757 fh_crc=0x9466d356 ct=1
info=0x27e7f)
[  168.384822] NFS: nfs_lookup_revalidate_done(/media) is valid
[  168.384829] NFS call  access
[  168.385694] NFS: nfs_update_inode(0:30/42757 fh_crc=0x9466d356 ct=1
info=0x27e7f)
[  168.385699] NFS reply access: 0
[  168.385703] NFS: permission(0:30/42757), mask=0x1, res=-13
[  168.578734] NFS: nfs_weak_revalidate: inode 2525216000 is valid

sa8155_v35:/ # ls -al
/data/vendor/nfs/mount/DVR/media/dvr_sdcard0/nfs_ready.flag.file

[  127.410222] NFS call  access
[  127.411278] NFS: nfs_update_inode(0:30/2525216000 fh_crc=0x69ed2ad0 ct=2
info=0x27e7f)
[  127.411283] NFS reply access: 0
[  127.411984] NFS: permission(0:30/2525216000), mask=0x1, res=0
[  127.412003] NFS: lookup(/media)
[  127.412008] NFS call  lookup media
[  127.412562] NFS: nfs_update_inode(0:30/2525216000 fh_crc=0x69ed2ad0 ct=2
info=0x27e7f)
[  127.412566] NFS reply lookup: 0
[  127.412576] NFS: nfs_fhget(0:30/42757 fh_crc=0x9466d356 ct=1)
[  127.412585] NFS call  access
[  127.423788] NFS: nfs_update_inode(0:30/42757 fh_crc=0x9466d356 ct=1
info=0x27e7f)
[  127.423794] NFS reply access: 0
[  127.423961] NFS: permission(0:30/42757), mask=0x1, res=0
[  127.423970] NFS: lookup(media/dvr_sdcard0)
[  127.423974] NFS call  lookup dvr_sdcard0
[  127.424645] NFS: nfs_update_inode(0:30/42757 fh_crc=0x9466d356 ct=1
info=0x27e7f)
[  127.424649] NFS reply lookup: 0
[  127.424659] NFS: nfs_fhget(0:30/128 fh_crc=0x8bcac245 ct=1)
[  127.424668] NFS call  lookup dvr_sdcard0
[  127.425141] NFS: nfs_update_inode(0:30/42757 fh_crc=0x9466d356 ct=1
info=0x27e7f)
[  127.425145] NFS reply lookup: 0
[  127.425160] --> nfs_xdev_mount()
[  127.425260] NFS call  fsinfo
[  127.425783] NFS reply fsinfo: 0
[  127.425788] NFS call  pathconf
[  127.426159] NFS reply pathconf: -521
[  127.428048] do_proc_get_root: call  fsinfo
[  127.428802] do_proc_get_root: reply fsinfo: 0
[  127.428814] NFS: nfs_fhget(0:31/128 fh_crc=0x8bcac245 ct=1)
[  127.428827] <-- nfs_xdev_mount() = 0
[  127.429219] NFS call  access
[  127.429890] NFS: nfs_update_inode(0:31/128 fh_crc=0x8bcac245 ct=2
info=0x27e7f)
[  127.429895] NFS reply access: 0
[  127.429900] NFS: permission(0:31/128), mask=0x1, res=0
[  127.429908] NFS: lookup(/nfs_ready.flag.file)
[  127.429912] NFS call  lookup nfs_ready.flag.file
[  127.432195] NFS: nfs_update_inode(0:31/128 fh_crc=0x8bcac245 ct=2
info=0x27e7f)
[  127.432201] NFS reply lookup: 0
[  127.432226] NFS: nfs_fhget(0:31/261 fh_crc=0xae0e68a5 ct=1)
[  127.432252] NFS: dentry_delete(/nfs_ready.flag.file, 40088c)
[  127.433273] ls (10174) used greatest stack depth: 10480 bytes left
[  128.260482] NFS: nfs_weak_revalidate: inode 2525216000 is valid
[  129.308862] NFS: nfs_weak_revalidate: inode 2525216000 is valid


HAL C++ File API:

[  285.296718] NFS call  fsstat
[  285.297643] NFS reply fsstat: 0
[  285.297670] NFS: permission(0:30/2525216000), mask=0x1, res=0
[  285.297676] NFS call  lookup media
[  285.298436] NFS: nfs_update_inode(0:30/2525216000 fh_crc=0x69ed2ad0 ct=2
info=0x27e7f)
[  285.298441] NFS reply lookup: 0
[  285.298445] NFS: nfs_update_inode(0:30/42757 fh_crc=0x9466d356 ct=1
info=0x27e7f)
[  285.298450] NFS: nfs_lookup_revalidate_done(/media) is valid
[  285.298455] NFS: permission(0:30/42757), mask=0x1, res=0
[  285.298461] NFS call  lookup dvr_sdcard0
[  285.299099] NFS: nfs_update_inode(0:30/42757 fh_crc=0x9466d356 ct=1
info=0x27e7f)
[  285.299103] NFS reply lookup: 0
[  285.299107] NFS: nfs_update_inode(0:30/128 fh_crc=0x8bcac245 ct=1
info=0x27e7f)
[  285.299111] NFS: nfs_lookup_revalidate_done(media/dvr_sdcard0) is valid
[  285.299117] NFS: nfs_weak_revalidate: inode 128 is valid
[  285.299137] NFS: permission(0:30/2525216000), mask=0x1, res=0
[  285.299141] NFS call  lookup media
[  285.299724] NFS: nfs_update_inode(0:30/2525216000 fh_crc=0x69ed2ad0 ct=2
info=0x27e7f)
[  285.299728] NFS reply lookup: 0
[  285.299732] NFS: nfs_update_inode(0:30/42757 fh_crc=0x9466d356 ct=1
info=0x27e7f)
[  285.299736] NFS: nfs_lookup_revalidate_done(/media) is valid
[  285.299741] NFS: permission(0:30/42757), mask=0x1, res=0
[  285.299746] NFS call  lookup dvr_sdcard0
[  285.300488] NFS: nfs_update_inode(0:30/42757 fh_crc=0x9466d356 ct=1
info=0x27e7f)
[  285.300492] NFS reply lookup: 0
[  285.300495] NFS: nfs_update_inode(0:30/128 fh_crc=0x8bcac245 ct=1
info=0x27e7f)
[  285.300499] NFS: nfs_lookup_revalidate_done(media/dvr_sdcard0) is valid
[  285.300504] NFS: nfs_weak_revalidate: inode 128 is valid
[  285.300511] NFS call  fsstat
[  285.302187] NFS reply fsstat: 0
[  285.327504] NFS: nfs_weak_revalidate: inode 2525216000 is valid
[  285.327556] NFS: nfs_weak_revalidate: inode 2525216000 is valid
[  285.327570] NFS call  fsstat
[  285.328683] NFS reply fsstat: 0
[  285.328734] NFS: permission(0:30/2525216000), mask=0x1, res=0
[  285.328764] NFS call  lookup media
[  285.329636] NFS: nfs_update_inode(0:30/2525216000 fh_crc=0x69ed2ad0 ct=2
info=0x27e7f)
[  285.329648] NFS reply lookup: 0
[  285.329658] NFS: nfs_update_inode(0:30/42757 fh_crc=0x9466d356 ct=1
info=0x27e7f)
[  285.329669] NFS: nfs_lookup_revalidate_done(/media) is valid
[  285.329681] NFS: permission(0:30/42757), mask=0x1, res=0
[  285.329694] NFS call  lookup dvr_sdcard0
[  285.331196] NFS: nfs_update_inode(0:30/42757 fh_crc=0x9466d356 ct=1
info=0x27e7f)
[  285.331209] NFS reply lookup: 0
[  285.331218] NFS: nfs_update_inode(0:30/128 fh_crc=0x8bcac245 ct=1
info=0x27e7f)
[  285.331231] NFS: nfs_lookup_revalidate_done(media/dvr_sdcard0) is valid
[  285.331246] NFS: nfs_weak_revalidate: inode 128 is valid
[  285.331301] NFS: permission(0:30/2525216000), mask=0x1, res=0
[  285.331333] NFS call  lookup media
[  285.332307] NFS: nfs_update_inode(0:30/2525216000 fh_crc=0x69ed2ad0 ct=2
info=0x27e7f)
[  285.332319] NFS reply lookup: 0
[  285.332327] NFS: nfs_update_inode(0:30/42757 fh_crc=0x9466d356 ct=1
info=0x27e7f)
[  285.332337] NFS: nfs_lookup_revalidate_done(/media) is valid
[  285.332348] NFS: permission(0:30/42757), mask=0x1, res=0
[  285.332361] NFS call  lookup dvr_sdcard0
[  285.333321] NFS: nfs_update_inode(0:30/42757 fh_crc=0x9466d356 ct=1
info=0x27e7f)
[  285.333331] NFS reply lookup: 0
[  285.333341] NFS: nfs_update_inode(0:30/128 fh_crc=0x8bcac245 ct=1
info=0x27e7f)
[  285.333353] NFS: nfs_lookup_revalidate_done(media/dvr_sdcard0) is valid
[  285.333365] NFS: nfs_weak_revalidate: inode 128 is valid
[  285.333379] NFS call  fsstat
[  285.336596] NFS reply fsstat: 0

==============================
Android9.0 
saxxx:/data/vendor/nfs/mount # ls -al
total 52
drwxrwxrwx 11 root root 4096 2020-01-01 00:00 .
drwxrwxrwx  4 root root 4096 1970-01-01 08:00 ..
drwxrwxrwx  2 root root 4096 2020-01-01 00:00 CHWM_V3
drwxrwxrwx  2 root root 4096 2020-01-01 00:11 DVR
drwxrwxrwx  2 root root 4096 2020-01-01 00:00 MINI
drwxrwxrwx  2 root root 4096 2020-01-01 00:00 bootanimation
drwxrwxrwx  2 root root 4096 2020-01-01 00:00 common
drwxrwxrwx  2 root root 4096 2020-01-01 00:00 coredump
drwxrwxrwx  3 root root 4096 2020-01-01 00:00 fota
drwxrwxrwx  3 root root 4096 2020-01-01 00:00 qlog
drwxrwxrwx  2 root root 4096 2020-01-01 00:00 themes

2、insert TF card to QNX USB Port
saxxx:/data/vendor/nfs/mount # ls -al DVR/
total 36
drwxrwxrwx  2 root root  4096 2020-01-01 00:01 .
drwxrwxrwx 11 root root  4096 2020-01-01 00:00 ..
-rw-r--r--  1 root root 24576 2020-01-01 00:01 .recordfile_front.db
dr-xr-xr-x  2 root root     0 2020-01-01 00:01 media

3、
saxxx:/data/vendor/nfs/mount # ls -al DVR/media/dvr_sdcard0/
total 2508
drwxrwxrwx 3 root root    4096 2020-01-01 00:01 .
dr-xr-xr-x 2 root root       0 2020-01-01 00:02 ..
drwxrwxrwx 6 root root    4096 2020-01-01 00:01 ExternalDVR
-rw-rw-rw- 1 root root 2560000 2020-01-01 00:01 check.dat
-rw-rw-rw- 1 root root       0 2020-01-01 00:07 nfs_ready.flag.file

QNX:
# mount
/dev/umass0x20 on /usr/nfs_share/DVR/media/dvr_sdcard0 type dos (fat32)

# cat /etc/exports
/usr/nfs_share/DVR/ -root=0 193.18.1.201


-Env/Platform
QNX:
SDP 7.0, QNX NFS Server V3
nfs root -> /usr/nfs_share/DVR, mount TF card(usb) to
/usr/nfs_share/DVR/media/dvr_sdcard0, Android can access dvr_sdcard from nfs
root.
Android:
9.0, Nfs client V3, Kernel 4.14.156


Best Regards
Hong Jiu Jin


