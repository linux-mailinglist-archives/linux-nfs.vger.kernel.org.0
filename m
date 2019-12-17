Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0D5123051
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2019 16:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfLQPaC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Dec 2019 10:30:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45324 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728118AbfLQP37 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Dec 2019 10:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576596597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=G55b3hLar2u1pjtU7+RJuPSzTzSS24D7W9VGk9bNX3Y=;
        b=T5j0lWEREKsZkTijnp0yuSAiN9f92dGd8S6evzKANCZaURROl2D+NWduTrFuFXlTaiLGkJ
        G0qDB8I4OryyHmvW1qnFWgUKIqdltk/61+ZkqAqOSKMtv+fEobG/ZGG9aXhN/KPo7qGwJw
        DzVffmVGRsU9Z/MIV3ZLw4mzhfh/53w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-WIPJ_Z6iOVOEY7mg1_hrAg-1; Tue, 17 Dec 2019 10:29:55 -0500
X-MC-Unique: WIPJ_Z6iOVOEY7mg1_hrAg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBE43593A0
        for <linux-nfs@vger.kernel.org>; Tue, 17 Dec 2019 15:29:54 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7704A68872
        for <linux-nfs@vger.kernel.org>; Tue, 17 Dec 2019 15:29:54 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: v5.4 wb_flags PG_UPTODATE warning on small rsize/wsize krb5p
Date:   Tue, 17 Dec 2019 10:29:53 -0500
Message-ID: <C64A88DD-8BDD-4D6B-B18B-09CFB12D5A6D@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've been bashing on cthon's ./special/bigfile -s 30 test on v3,krb5p 
mounts
this morning trying to find a regression (in RHEL) with 
rsize/wsize=1024,
and I just saw this WARN pop up on v5.4:

[518582.174722] ------------[ cut here ]------------
[518582.175648] WARNING: CPU: 2 PID: 15767 at fs/nfs/pagelist.c:449 
nfs_free_request+0x14e/0x180 [nfs]
[518582.177268] Modules linked in: nfsv3 rpcsec_gss_krb5 nfsv4 
dns_resolver nfs nfsd nfs_acl lockd grace ip6t_rpfilter ip6t_REJECT 
nf_reject_ipv6 xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute 
ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat 
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle 
iptable_raw iptable_security ebtable_filter ebtables ip6table_filter 
ip6_tables auth_rpcgss sunrpc virtio_net net_failover virtio_console 
virtio_balloon failover virtio_blk crct10dif_pclmul crc32_pclmul 
crc32c_intel ghash_clmulni_intel serio_raw i2c_piix4 virtio_pci 
virtio_ring virtio ata_generic pata_acpi
[518582.186909] CPU: 2 PID: 15767 Comm: kworker/2:0 Not tainted 
5.4.0.219d54332a #1
[518582.188171] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.10.2-2.fc27 04/01/2014
[518582.189746] Workqueue: nfsiod rpc_async_release [sunrpc]
[518582.190670] RIP: 0010:nfs_free_request+0x14e/0x180 [nfs]
[518582.191244] Code: 0b 48 8b 43 38 a8 40 0f 84 ef fe ff ff 0f 0b 48 8b 
43 38 a8 80 0f 84 ed fe ff ff 0f 0b 48 8b 43 38 f6 c4 01 0f 84 eb fe ff 
ff <0f> 0b 48 8b 43 38 f6 c4 02 0f 84 e9 fe ff ff 0f 0b e9 e2 fe ff ff
[518582.194004] RSP: 0000:ffffc90000853db8 EFLAGS: 00010202
[518582.194823] RAX: 0000000000000100 RBX: ffff8880074c1800 RCX: 
ffff888076e95a38
[518582.196088] RDX: ffff8880074c1800 RSI: 0000000000000006 RDI: 
ffff8880074c1800
[518582.197251] RBP: ffff888076e95500 R08: 0000000000000001 R09: 
0000000000000000
[518582.198393] R10: 0000000000000000 R11: ffff88806402d500 R12: 
ffff8880074c1800
[518582.199560] R13: ffff888046af4790 R14: 00000000fffffff3 R15: 
0000160000000000
[518582.200697] FS:  0000000000000000(0000) GS:ffff888078000000(0000) 
knlGS:0000000000000000
[518582.201948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[518582.202837] CR2: 00007fcdfe25a000 CR3: 000000007471e005 CR4: 
00000000001606e0
[518582.203950] Call Trace:
[518582.204356]  nfs_page_group_destroy+0x36/0x60 [nfs]
[518582.205118]  nfs_read_completion+0x99/0x1f0 [nfs]
[518582.205870]  rpc_free_task+0x39/0x80 [sunrpc]
[518582.206595]  rpc_async_release+0x29/0x40 [sunrpc]
[518582.207389]  process_one_work+0x23b/0x5e0
[518582.208029]  worker_thread+0x3c/0x390
[518582.208623]  ? process_one_work+0x5e0/0x5e0
[518582.209310]  kthread+0x121/0x140
[518582.209820]  ? kthread_park+0x90/0x90
[518582.210401]  ret_from_fork+0x3a/0x50
[518582.210974] irq event stamp: 0
[518582.211456] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[518582.212460] hardirqs last disabled at (0): [<ffffffff810dbf01>] 
copy_process+0x711/0x1dd0
[518582.213729] softirqs last  enabled at (0): [<ffffffff810dbf01>] 
copy_process+0x711/0x1dd0
[518582.214987] softirqs last disabled at (0): [<0000000000000000>] 0x0
[518582.215968] ---[ end trace 047c1aa3a444bd36 ]---

fs/nfs/pagelist.c+442:
   442 void nfs_free_request(struct nfs_page *req)
   443 {
   444     WARN_ON_ONCE(req->wb_this_page != req);
   445
   446     /* extra debug: make sure no sync bits are still set */
   447     WARN_ON_ONCE(test_bit(PG_TEARDOWN, &req->wb_flags));
   448     WARN_ON_ONCE(test_bit(PG_UNLOCKPAGE, &req->wb_flags));
->449     WARN_ON_ONCE(test_bit(PG_UPTODATE, &req->wb_flags));
   450     WARN_ON_ONCE(test_bit(PG_WB_END, &req->wb_flags));
   451     WARN_ON_ONCE(test_bit(PG_REMOVE, &req->wb_flags));

I thought it worth sending before I forget about it, and maybe to help 
me come
back and look more closely later.

The server (same machine) is also emitting a lot of:

[518648.721185] rpc-srv/tcp: nfsd: sent only 200 when sending 1252 bytes 
- shutting down socket
[518663.582960] rpc-srv/tcp: nfsd: got error -32 when sending 1252 bytes 
- shutting down socket
[518664.318436] rpc-srv/tcp: nfsd: sent only 200 when sending 1252 bytes 
- shutting down socket
[518712.010515] rpc-srv/tcp: nfsd: got error -32 when sending 1252 bytes 
- shutting down socket
[518746.910880] rpc-srv/tcp: nfsd: got error -32 when sending 236 bytes 
- shutting down socket
[518761.982340] rpc-srv/tcp: nfsd: got error -32 when sending 1252 bytes 
- shutting down socket
[518797.035589] rpc-srv/tcp: nfsd: got error -32 when sending 236 bytes 
- shutting down socket
[518825.775316] rpc-srv/tcp: nfsd: sent only 200 when sending 1252 bytes 
- shutting down socket
[518841.523617] rpc-srv/tcp: nfsd: got error -32 when sending 236 bytes 
- shutting down socket
[518860.940565] rpc-srv/tcp: nfsd: sent only 1224 when sending 1252 
bytes - shutting down socket
[518909.389433] rpc-srv/tcp: nfsd: got error -32 when sending 1252 bytes 
- shutting down socket
[518944.301803] rpc-srv/tcp: nfsd: sent only 200 when sending 1252 bytes 
- shutting down socket
[518960.488766] rpc-srv/tcp: nfsd: sent only 200 when sending 1252 bytes 
- shutting down socket
[518993.724302] rpc-srv/tcp: nfsd: got error -32 when sending 1252 bytes 
- shutting down socket

I already had a lockdep splat on this machine in XFS/reclaimer, though.  
Doubt that's related, but
just to be safe I am going to reboot it and see if this reproduces.

Ben

