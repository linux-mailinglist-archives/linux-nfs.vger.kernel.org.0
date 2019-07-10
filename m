Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0292563F1F
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2019 04:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbfGJCMA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Jul 2019 22:12:00 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:42543 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGJCMA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Jul 2019 22:12:00 -0400
Received: by mail-io1-f44.google.com with SMTP id u19so1271021ior.9
        for <linux-nfs@vger.kernel.org>; Tue, 09 Jul 2019 19:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=gg78Yf25v9tikgS8a9b6AggyMr3GIiPHn8aBrwPE8/c=;
        b=bQVIUWL7BPfM3kaKFGhNTBZRM862GklnaDhHQs9E84BU5LYC5hf41LhiFJ54h06ian
         g4WI0dZL8TMqzGvGEvNWsLOpFijD2FN+f19L2ksao4s832eNx4mvK8abw4Usun9pAoi6
         QvZpXgsafNeghV5oIPwEVnZi8rWITnHBoG1xeXYJFOwNNDnS+HWM0SDya3guWJfvr8i0
         Jai6vS9wEAxYan6UM/2Jn4lEGoKtZqrTC4cOY06CzaQuOxaIWEOtjD2LB4J9dZWVd90d
         Wa9cMQvhIc48J26CVwTj7cdzAHS47B4crBy2D6PVmQ0oxLdr9o6dICVz6VvVfYSk1u+c
         kT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=gg78Yf25v9tikgS8a9b6AggyMr3GIiPHn8aBrwPE8/c=;
        b=hIfVPkxf7VLa1bvQKQVYnhZYpTJ5N0dIoNIpC50XgAPjUyRmZOsJ7XMPHl03A7Q5wc
         omJeclXwHvGARTKQkuy9DboFGlxg6620XnTGrLQl9HA7Dyu+e9wvKkFZNTEuemo4Wekx
         rW7m+GLQIqphLR/+o0JtnZkzTzI3PBWqbrjLh4OPxZXal5kgEogkHVM1YpuC0IHkZbAB
         8JFYm2dpr0m48bZY+KiK/mQJ5TOYloJykNBbB6Isbn6KG/3eF56rQUzvtn3lVZJ2rjky
         RArt/RzBsuANtbAK9m+DujThfQSmzwfDkKTirZK5CtnOoAg8z5mH8AqKq8CLhn0XoGL2
         2tFw==
X-Gm-Message-State: APjAAAVMXBF1Hps+VzVIpbbfQQ5Xe9mTVAlqkn9pynttIfq81NMyFam8
        MMjv85cQr3OJ672JjcMUVpAoMhfG
X-Google-Smtp-Source: APXvYqyKHER46ZLitI5cXfKUbyZmspicksX5xN7wXzBtMqiDYwb6duDRgeNiJUitG4wzCb6jAL46rw==
X-Received: by 2002:a05:6638:5:: with SMTP id z5mr32652712jao.58.1562724719196;
        Tue, 09 Jul 2019 19:11:59 -0700 (PDT)
Received: from [192.168.9.105] ([108.175.234.210])
        by smtp.gmail.com with ESMTPSA id j5sm412028iom.69.2019.07.09.19.11.58
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 19:11:58 -0700 (PDT)
From:   Etienne Lessard <elessard97@gmail.com>
Subject: Kernel Oops related to NFS client code ?
To:     linux-nfs@vger.kernel.org
Message-ID: <32da46d2-69e3-e0fb-1b74-33e95c96ecc3@gmail.com>
Date:   Tue, 9 Jul 2019 22:11:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi linux-nfs,

I’m looking for a bit of help on an issue. We’ve had 6 kernel Oops 
running on Linux 4.14.81 (CoreOS 1911.4.0) on 6 similar servers in a few 
  days apart, and we’re scratching our head a little on what could be 
the cause, because it happened all suddenly. All the Oops were the same:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000080
IP: _raw_spin_lock+0xc/0x20
PGD 800000180059b067 P4D 800000180059b067 PUD 16acf66067 PMD 0
Oops: 0002 [#1] SMP PTI
Modules linked in: tcp_diag udp_diag inet_diag ipt_REJECT nf_reject_ipv4 
xt_limit xt_set ip_set_hash_net ip_set ipt_MASQUERADE 
nf_nat_masquerade_ipv4 xt_comment xt_mark iptable_nat nf_conntrack_ipv4 
nf_defrag_ipv4 nf_nat_ipv4 veth nf_conntrack_netlink nfnetlink xfrm_user 
xfrm_algo iptable_filter xt_conntrack nf_nat nf_conntrack libcrc32c 
nfsv3 nfs_acl nfs lockd grace sunrpc fscache overlay 8021q garp mrp 
coretemp x86_pkg_temp_thermal ipmi_ssif kvm_intel iTCO_wdt 
iTCO_vendor_support kvm dcdbas irqbypass ipmi_si mei_me mousedev evdev 
i2c_i801 mei ipmi_devintf bridge stp llc ipmi_msghandler bonding 
pcc_cpufreq button sch_fq_codel nls_ascii nls_cp437 vfat fat dm_verity 
dm_bufio ext4 crc32c_generic crc16 mbcache jbd2 fscrypto hid_generic 
usbhid hid sd_mod crc32c_intel aesni_intel igb ixgbe ahci i2c_algo_bit 
xhci_pci aes_x86_64 libahci i2c_core crypto_simd xhci_hcd cryptd hwmon 
libata glue_helper ptp usbcore pps_core mdio scsi_mod usb_common 
dm_mirror dm_region_hash dm_log dm_mod dax
CPU: 34 PID: 40199 Comm: asterisk Not tainted 4.14.81-coreos #1 Hardware 
name: Dell Inc. PowerEdge R640/0W23H8, BIOS 1.3.7 02/08/2018
task: ffff9516d79a0000 task.stack: ffffad77a1b4c000
RIP: 0010:_raw_spin_lock+0xc/0x20
RSP: 0018:ffffad77a1b4fd08 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000080
RBP: 0000000000000030 R08: ffff950d91064800 R09: ffff950782a0b080
R10: ffff950d2cd174a0 R11: 0000000000000001 R12: ffff9507585f9720
R13: ffffd91fa16533c0 R14: ffff950782a0b0c0 R15: ffff950782a0b080
FS:  00007fdb38c25700(0000) GS:ffff950d91040000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000080 CR3: 0000001553a86005 CR4: 00000000007606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
  nfs_updatepage+0x6da/0x8e0 [nfs]
  ? nfs_flush_incompatible+0xf6/0x150 [nfs]
  nfs_lock+0x9de/0xd00 [nfs]
  ? iov_iter_copy_from_user_atomic+0xdf/0x2f0
  generic_perform_write+0xfc/0x1b0
  nfs_file_write+0xeb/0x340 [nfs]
  __vfs_write+0x101/0x160
  vfs_write+0xad/0x1a0
  SyS_write+0x52/0xc0
  do_syscall_64+0x67/0x120
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x7fdbd7196c1d
RSP: 002b:00007fdb38c22e10 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fdbd7196c1d
RDX: 0000000000000004 RSI: 00007fd92800dd50 RDI: 0000000000000072
RBP: 00007fd92800dd50 R08: 00007fd928031810 R09: 00007fdb38c22f8c
R10: 0000000000000038 R11: 0000000000000293 R12: 00007fd928031730
R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000000
Code: 66 0f 1f 44 00 00 31 c0 ba ff 00 00 00 f0 0f b1 17 85 c0 74 05 e8 
b5 23 aa ff 48 89 d8 5b c3 0f 1f 44 00 00 31 c0 ba 01 00 00 00 <f0> 0f 
b1 17 85 c0 75 02 f3 c3 89 c6 e8 b3 0b aa ff 66 90 c3 0f
RIP: _raw_spin_lock+0xc/0x20 RSP: ffffad77a1b4fd08
CR2: 0000000000000080
---[ end trace b0d4430dcc4c0aa0 ]---
Kernel panic - not syncing: Fatal exception
Kernel Offset: 0xb000000 from 0xffffffff81000000 (relocation range: 
0xffffffff80000000-0xffffffffbfffffff)

The “nfs_lock+0x9de” address is a bit misleading, it’s actually the 
nfs_write_end function being called here.

So we are still at the beginning of the troubleshooting, we haven’t been 
able to synthetically reproduce the issue yet. So I just wanted to asked 
if someone had some idea of what could be wrong here / if someone had 
already seen something similar, to help us troubleshooting in the right 
direction.

The NFS mount options used were: 
rw,nosuid,noatime,vers=3,rsize=32768,wsize=32768,namlen=255,soft,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=10.1.1.1,mountvers=3,mountport=42471,mountproto=tcp,local_lock=none,addr=10.1.1.1.

Thanks
