Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEA539066E
	for <lists+linux-nfs@lfdr.de>; Tue, 25 May 2021 18:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhEYQTY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 May 2021 12:19:24 -0400
Received: from p-impout006aa.msg.pkvw.co.charter.net ([47.43.26.137]:33786
        "EHLO p-impout006.msg.pkvw.co.charter.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229989AbhEYQTY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 May 2021 12:19:24 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 May 2021 12:19:23 EDT
Received: from server.example.org ([76.181.116.208])
        by cmsmtp with ESMTP
        id lZh2l2ztTB5K5lZh3l0oAV; Tue, 25 May 2021 16:14:09 +0000
X-Authority-Analysis: v=2.4 cv=ZqIol/3G c=1 sm=1 tr=0 ts=60ad2251
 a=KaGAbI3NK5LSFXnSxylTDA==:117 a=KaGAbI3NK5LSFXnSxylTDA==:17
 a=IkcTkHD0fZMA:10 a=5FLXtPjwQuUA:10 a=dDymh7n3NiNWNMwGO1UA:9 a=QEXdDO2ut3YA:10
Received: from [192.168.1.31]
        by server.example.org with esmtps  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <scott.andrews@columbus.rr.com>)
        id 1llZh2-0000VL-Eh
        for linux-nfs@vger.kernel.org; Tue, 25 May 2021 12:14:08 -0400
From:   Scott Andrews <scott.andrews@columbus.rr.com>
Subject: mount.nfs: Stale file handle
To:     linux-nfs@vger.kernel.org
Message-ID: <82edf12a-a9fa-49a7-bdd0-1689c70a3a5f@columbus.rr.com>
Date:   Tue, 25 May 2021 12:14:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIkHaUazhEcyHW5y/tMTunLeeY3+ugjQ51BGO1JjSzqRqY+Lb2IWNfKBCkQAVtyzJlo9UYlYr3VIMI/cxOJoMvtWbT4v/gH12sQfp8UMiJJdIg4B8QCs
 J8I6OBoAvWns637R9jJpTHov8USDql4i3ye5R3HjJGOPm7OuT0ne4AmTpZc7i2W5FriO/cLHs4N4ZLyYZFybJJOwMHEoh/Lj+g4g3pxmdDkoz7k1LFIzP/UX
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Platform Raspberry pi 4

Scratch build linux system.

nfs-utils-2.4.1

./configure --prefix=/usr \
         --sysconfdir=/etc \
         --sbindir=/sbin \
         --disable-nfsv4

systemV init script

         start)  log_info_msg "Exporting NFS Filesystems..."
                 /sbin/exportfs -av 2>&1 > /dev/null
                 evaluate_retval
                 log_info_msg "Starting NFS mountd..."
                 start_daemon /sbin/rpc.mountd
                 evaluate_retval
                 log_info_msg "Starting NFS statd..."
                 start_daemon /sbin/rpc.statd --no-notify
                 evaluate_retval
                 log_info_msg "Starting NFS nfsd..."
                 start_daemon /sbin/rpc.nfsd 8
                 evaluate_retval


On the server to test.......

lsmod

nfsd                  442368  11


rpcinfo -p localhost

    program vers proto   port  service

     100000    4   tcp    111  portmapper
     100000    3   tcp    111  portmapper
     100000    2   tcp    111  portmapper
     100000    4   udp    111  portmapper
     100000    3   udp    111  portmapper
     100000    2   udp    111  portmapper
     100005    1   udp  35667  mountd
     100005    1   tcp  58403  mountd
     100005    2   udp  41019  mountd
     100005    2   tcp  52587  mountd
     100005    3   udp  51412  mountd
     100005    3   tcp  52519  mountd
     100024    1   udp  33165  status
     100024    1   tcp  56603  status
     100003    3   tcp   2049  nfs
     100003    4   tcp   2049  nfs
     100227    3   tcp   2049  nfs_acl
     100021    1   udp  47813  nlockmgr
     100021    3   udp  47813  nlockmgr
     100021    4   udp  47813  nlockmgr
     100021    1   tcp  36915  nlockmgr
     100021    3   tcp  36915  nlockmgr
     100021    4   tcp  36915  nlockmgr


root [ ~ ]# ps aux | grep rpc
root        62  0.0  0.0      0     0 ?        I<   11:12 0:00 [rpciod]
root       698  0.0  0.0   2320  1400 ?        Ss   11:12   0:00 
/sbin/rpcbind
root      1477  0.0  0.0   4316  3132 ?        Ss   11:28   0:00 
/sbin/rpc.mountd
nobody    1497  0.0  0.0   2992  2236 ?        Ss   11:28   0:00 
/sbin/rpc.statd --no-notify


ps aux | grep nfs
root        66  0.0  0.0      0     0 ?        I<   11:12 0:00 [nfsiod]
root      1518  0.0  0.0      0     0 ?        S    11:28   0:00 [nfsd]
root      1519  0.0  0.0      0     0 ?        S    11:28   0:00 [nfsd]
root      1520  0.0  0.0      0     0 ?        S    11:28   0:00 [nfsd]
root      1521  0.0  0.0      0     0 ?        S    11:28   0:00 [nfsd]
root      1522  0.0  0.0      0     0 ?        S    11:28   0:00 [nfsd]
root      1523  0.0  0.0      0     0 ?        S    11:28   0:00 [nfsd]
root      1524  0.0  0.0      0     0 ?        S    11:28   0:00 [nfsd]
root      1525  0.0  0.0      0     0 ?        S    11:28   0:00 [nfsd]


root [ ~ ]# cat /etc/exports
/home *(rw,no_root_squash,subtree_check)


root [ ~ ]# exportfs -v

/home 
<world>(sync,wdelay,hide,sec=sys,rw,secure,no_root_squash,no_all_squash)


root [ ~ ]# cat /proc/fs/nfs/exports

# Version 1.1
# Path Client(Flags) # IP

root [ ~ ]# mount -v -t nfs localhost:/home /mnt
mount.nfs: timeout set for Tue May 25 11:40:03 2021
mount.nfs: trying text-based options 
'vers=4.2,addr=127.0.0.1,clientaddr=127.0.0.1'
mount.nfs: mount(2): Stale file handle
mount.nfs: trying text-based options 
'vers=4.2,addr=127.0.0.1,clientaddr=127.0.0.1'
mount.nfs: mount(2): Stale file handle
mount.nfs: trying text-based options 
'vers=4.2,addr=127.0.0.1,clientaddr=127.0.0.1'
mount.nfs: mount(2): Stale file handle

cat /proc/fs/nfs/exports
# Version 1.1
# Path Client(Flags) # IPs
/ 
*(ro,no_root_squash,sync,no_wdelay,no_subtree_check,v4root,fsid=0,uuid=6b179096:b8b5495a:873908b5:a2b35faa,sec=390003:390004:390005:1)
/home 
*(rw,no_root_squash,sync,wdelay,uuid=6b179096:b8b5495a:873908b5:a2b35faa,sec=1)


Can someone help with this issue?

Thanks for any help/direction you may have
