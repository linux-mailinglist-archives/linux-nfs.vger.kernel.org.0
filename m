Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD53F458B40
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Nov 2021 10:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhKVJ2L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 22 Nov 2021 04:28:11 -0500
Received: from jonte.lozere.bm-services.com ([37.58.154.99]:53231 "EHLO
        mail-out.bm-services.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhKVJ2J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Nov 2021 04:28:09 -0500
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Nov 2021 04:28:09 EST
Received: from localhost (localhost [127.0.0.1])
        by mail-out.bm-services.com (Postfix) with ESMTP id DB04971BB6;
        Mon, 22 Nov 2021 10:15:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at cerbere.infra.lan
Received: from mail-out.bm-services.com ([127.0.0.1])
        by localhost (mail-out.bm-services.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4ysGhCmq_oOD; Mon, 22 Nov 2021 10:15:39 +0100 (CET)
Received: from VOLT.BIENMANGER.LAN (volt.bienmanger.lan [10.48.5.222])
        by mail-out.bm-services.com (Postfix) with ESMTPS id 9440B71BB2;
        Mon, 22 Nov 2021 10:15:39 +0100 (CET)
Received: from VOLT.BIENMANGER.LAN (10.48.5.222) by VOLT.BIENMANGER.LAN
 (10.48.5.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 22 Nov
 2021 10:15:39 +0100
Received: from VOLT.BIENMANGER.LAN ([::1]) by VOLT.BIENMANGER.LAN ([::1]) with
 mapi id 15.02.0922.019; Mon, 22 Nov 2021 10:15:39 +0100
From:   Olivier Monaco <olivier@bm-services.com>
To:     Salvatore Bonaccorso <carnil@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     Chuck Lever <chuck.lever@oracle.com>,
        Olivier Monaco <olivier@bm-services.com>
Subject: RE: Kernel panic / list_add corruption when in nfsd4_run_cb_work
Thread-Topic: Kernel panic / list_add corruption when in nfsd4_run_cb_work
Thread-Index: AQFrawe3XDYC5relDPEmHK1VBjGWrAIVOc+bAjmqCx0BWIWb9wMEef1QAjaPHg+skRjW8A==
Date:   Mon, 22 Nov 2021 09:15:38 +0000
Message-ID: <3899037dd7d44e879d77bba67b3455ee@bm-services.com>
References: <20201011075913.GA8065@eldamar.lan>
 <20201012142602.GD26571@fieldses.org> <20201012154159.GA49819@eldamar.lan>
 <20201012163355.GF26571@fieldses.org> <20201018093903.GA364695@eldamar.lan>
 <YV3vDQOPVgxc/J99@eldamar.lan>
In-Reply-To: <YV3vDQOPVgxc/J99@eldamar.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.5.3]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I think my problem is related to this thread.

We are running a VMware vCenter platform running 9 groups of virtual machines. Each group includes a VM with NFS for file sharing and 3 VMs with NFS clients, so we are running 9 independent file servers.

Starting from April 21, we had sometimes a kernel bug with message like :
2021-05-04T02:28:21.101162+02:00 storage-t20 kernel: [1736623.971161] list_add corruption. prev->next should be next (ffff9c2d0875ecb8), but was ffff9c2c913a0fe8. (prev=ffff9c2c913a0fe8).
2021-05-04T02:28:21.101176+02:00 storage-t20 kernel: [1736623.971315] ------------[ cut here ]------------
2021-05-04T02:28:21.101177+02:00 storage-t20 kernel: [1736623.971317] kernel BUG at lib/list_debug.c:28!
2021-05-04T02:28:21.101178+02:00 storage-t20 kernel: [1736623.971362] invalid opcode: 0000 [#1] SMP NOPTI
2021-05-04T02:28:21.101178+02:00 storage-t20 kernel: [1736623.971402] CPU: 1 PID: 2435711 Comm: kworker/u256:5 Tainted: G        W         5.10.0-0.bpo.4-amd64 #1 Debian 5.10.19-1~bpo10+1
2021-05-04T02:28:21.101179+02:00 storage-t20 kernel: [1736623.971456] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 12/12/2018
2021-05-04T02:28:21.101180+02:00 storage-t20 kernel: [1736623.971499] Workqueue: nfsd4_callbacks nfsd4_run_cb_work [nfsd]
2021-05-04T02:28:21.101180+02:00 storage-t20 kernel: [1736623.971515] RIP: 0010:__list_add_valid.cold.0+0x26/0x28
2021-05-04T02:28:21.101181+02:00 storage-t20 kernel: [1736623.971527] Code: 7b 1c bf ff 48 89 d1 48 c7 c7 18 71 92 86 48 89 c2 e8 02 2a ff ff 0f 0b 48 89 c1 4c 89 c6 48 c7 c7 70 71 92 86 e8 ee 29 ff ff <0f> 0b 48 89 fe 48 89 c2 48 c7 c7 00 72 92 86 e8 da 29 ff ff 0f 0b
2021-05-04T02:28:21.101181+02:00 storage-t20 kernel: [1736623.971564] RSP: 0018:ffffb93f4075fe48 EFLAGS: 00010246
2021-05-04T02:28:21.101182+02:00 storage-t20 kernel: [1736623.971579] RAX: 0000000000000075 RBX: ffff9c2c913a0fe8 RCX: 0000000000000000
2021-05-04T02:28:21.101182+02:00 storage-t20 kernel: [1736623.971594] RDX: 0000000000000000 RSI: ffff9c2d39e58a00 RDI: ffff9c2d39e58a00
2021-05-04T02:28:21.101183+02:00 storage-t20 kernel: [1736623.971608] RBP: ffff9c2c913a1018 R08: 0000000000000000 R09: c0000000ffff7fff
2021-05-04T02:28:21.101183+02:00 storage-t20 kernel: [1736623.971623] R10: 0000000000000001 R11: ffffb93f4075fc58 R12: ffff9c2d0875ec00
2021-05-04T02:28:21.101183+02:00 storage-t20 kernel: [1736623.971637] R13: ffff9c2c913a0fe8 R14: ffff9c2d0875ecb8 R15: ffff9c2c913a1050
2021-05-04T02:28:21.101184+02:00 storage-t20 kernel: [1736623.971653] FS:  0000000000000000(0000) GS:ffff9c2d39e40000(0000) knlGS:0000000000000000
2021-05-04T02:28:21.101184+02:00 storage-t20 kernel: [1736623.971684] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2021-05-04T02:28:21.101184+02:00 storage-t20 kernel: [1736623.971735] CR2: 00007f8d98002698 CR3: 0000000103904005 CR4: 00000000007706e0
2021-05-04T02:28:21.101185+02:00 storage-t20 kernel: [1736623.971774] PKRU: 55555554
2021-05-04T02:28:21.101185+02:00 storage-t20 kernel: [1736623.971781] Call Trace:
2021-05-04T02:28:21.101186+02:00 storage-t20 kernel: [1736623.971805]  nfsd4_cb_recall_prepare+0x2aa/0x2f0 [nfsd]
2021-05-04T02:28:21.101186+02:00 storage-t20 kernel: [1736623.971829]  nfsd4_run_cb_work+0xe9/0x150 [nfsd]
2021-05-04T02:28:21.101186+02:00 storage-t20 kernel: [1736623.971843]  process_one_work+0x1aa/0x340
2021-05-04T02:28:21.101187+02:00 storage-t20 kernel: [1736623.971855]  ? create_worker+0x1a0/0x1a0
2021-05-04T02:28:21.101187+02:00 storage-t20 kernel: [1736623.971865]  worker_thread+0x30/0x390
2021-05-04T02:28:21.101188+02:00 storage-t20 kernel: [1736623.971875]  ? create_worker+0x1a0/0x1a0
2021-05-04T02:28:21.101188+02:00 storage-t20 kernel: [1736623.972279]  kthread+0x116/0x130
2021-05-04T02:28:21.101188+02:00 storage-t20 kernel: [1736623.972663]  ? kthread_park+0x80/0x80
2021-05-04T02:28:21.101189+02:00 storage-t20 kernel: [1736623.973043]  ret_from_fork+0x1f/0x30
2021-05-04T02:28:21.101189+02:00 storage-t20 kernel: [1736623.973411] Modules linked in: binfmt_misc vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock intel_rapl_msr intel_rapl_common nfit libnvdimm crc32_pclmul ghash_clmulni_intel aesni_intel libaes crypto_simd cryptd glue_helper rapl vmw_balloon vmwgfx joydev evdev serio_raw pcspkr ttm sg drm_kms_helper vmw_vmci cec ac button nfsd auth_rpcgss nfs_acl lockd grace drm sunrpc fuse configfs ip_tables x_tables autofs4 btrfs blake2b_generic xor raid6_pq libcrc32c crc32c_generic dm_mod sd_mod t10_pi crc_t10dif crct10dif_generic ata_generic crct10dif_pclmul crct10dif_common crc32c_intel psmouse vmxnet3 ata_piix libata vmw_pvscsi scsi_mod i2c_piix4
2021-05-04T02:28:21.101190+02:00 storage-t20 kernel: [1736623.976175] ---[ end trace f6e153631af275dd ]---

This problem occurs when server are under load but not during a load pick. There's no way to detect incoming failure. We tried to reproduce this issue without success.

Before the end of October, we were running Debian Buster with 5.10 kernel. This issue occurred at least 4 times before summer, none during the summer and started again at mid-October (3 times) when load on our infrastructure was increasing again.

We updated all our NFS servers at end of October to Debian Bullseye with kernel 5.14. This issues occurred for the first time then today on one of our servers:
2021-11-22T09:12:16.957103+01:00 storage-s10 kernel: [1930092.493512] list_add corruption. prev->next should be next (ffff9244023034b0), but was ffff92439f684c08. (prev=ffff92439f684c08).
2021-11-22T09:12:16.957118+01:00 storage-s10 kernel: [1930092.493693] ------------[ cut here ]------------
2021-11-22T09:12:16.957119+01:00 storage-s10 kernel: [1930092.493694] kernel BUG at lib/list_debug.c:26!
2021-11-22T09:12:16.957119+01:00 storage-s10 kernel: [1930092.493764] invalid opcode: 0000 [#1] SMP NOPTI
2021-11-22T09:12:16.957120+01:00 storage-s10 kernel: [1930092.493812] CPU: 0 PID: 2506486 Comm: kworker/u256:4 Tainted: G        W         5.14.0-0.bpo.2-amd64 #1  Debian 5.14.9-2~bpo11+1
2021-11-22T09:12:16.957121+01:00 storage-s10 kernel: [1930092.493861] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 12/12/2018
2021-11-22T09:12:16.957122+01:00 storage-s10 kernel: [1930092.493982] Workqueue: nfsd4_callbacks nfsd4_run_cb_work [nfsd]
2021-11-22T09:12:16.957126+01:00 storage-s10 kernel: [1930092.494135] RIP: 0010:__list_add_valid.cold+0x3d/0x3f
2021-11-22T09:12:16.957127+01:00 storage-s10 kernel: [1930092.494203] Code: f2 4c 89 c1 48 89 fe 48 c7 c7 08 53 15 a8 e8 f8 fe fe ff 0f 0b 48 89 d1 4c 89 c6 4c 89 ca 48 c7 c7 b0 52 15 a8 e8 e1 fe fe ff <0f> 0b 48 89 fe 48 c7 c7 40 53 15 a8 e8 d0 fe fe ff 0f 0b 48 c7 c7
2021-11-22T09:12:16.957128+01:00 storage-s10 kernel: [1930092.494288] RSP: 0018:ffffbd09c29b7e38 EFLAGS: 00010246
2021-11-22T09:12:16.957128+01:00 storage-s10 kernel: [1930092.494323] RAX: 0000000000000075 RBX: ffff92439f684c08 RCX: 0000000000000000
2021-11-22T09:12:16.957135+01:00 storage-s10 kernel: [1930092.494350] RDX: 0000000000000000 RSI: ffff924439e18880 RDI: ffff924439e18880
2021-11-22T09:12:16.957136+01:00 storage-s10 kernel: [1930092.494371] RBP: ffff9243087a2950 R08: 0000000000000000 R09: ffffbd09c29b7c68
2021-11-22T09:12:16.957136+01:00 storage-s10 kernel: [1930092.494391] R10: ffffbd09c29b7c60 R11: ffff92443fec48a8 R12: ffff924402303400
2021-11-22T09:12:16.957137+01:00 storage-s10 kernel: [1930092.494426] R13: ffff9243087a2920 R14: ffff9244023034b0 R15: 0000000000000006
2021-11-22T09:12:16.957137+01:00 storage-s10 kernel: [1930092.494447] FS:  0000000000000000(0000) GS:ffff924439e00000(0000) knlGS:0000000000000000
2021-11-22T09:12:16.957137+01:00 storage-s10 kernel: [1930092.494470] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2021-11-22T09:12:16.957139+01:00 storage-s10 kernel: [1930092.494488] CR2: 00007fb154911328 CR3: 000000010aabe005 CR4: 00000000007706f0
2021-11-22T09:12:16.957139+01:00 storage-s10 kernel: [1930092.494536] PKRU: 55555554
2021-11-22T09:12:16.957140+01:00 storage-s10 kernel: [1930092.494546] Call Trace:
2021-11-22T09:12:16.957140+01:00 storage-s10 kernel: [1930092.494578]  nfsd4_cb_recall_prepare+0x144/0x160 [nfsd]
2021-11-22T09:12:16.957140+01:00 storage-s10 kernel: [1930092.494626]  nfsd4_run_cb_work+0x8b/0x140 [nfsd]
2021-11-22T09:12:16.957141+01:00 storage-s10 kernel: [1930092.494659]  process_one_work+0x1e9/0x390
2021-11-22T09:12:16.957141+01:00 storage-s10 kernel: [1930092.494675]  worker_thread+0x53/0x3e0
2021-11-22T09:12:16.957143+01:00 storage-s10 kernel: [1930092.495301]  ? process_one_work+0x390/0x390
2021-11-22T09:12:16.957143+01:00 storage-s10 kernel: [1930092.495851]  kthread+0x124/0x150
2021-11-22T09:12:16.957143+01:00 storage-s10 kernel: [1930092.496396]  ? set_kthread_struct+0x40/0x40
2021-11-22T09:12:16.957144+01:00 storage-s10 kernel: [1930092.496926]  ret_from_fork+0x1f/0x30
2021-11-22T09:12:16.957144+01:00 storage-s10 kernel: [1930092.497450] Modules linked in: binfmt_misc vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock intel_rapl_msr intel_rapl_common nfit libnvdimm ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl vmwgfx vmw_balloon ttm evdev joydev serio_raw pcspkr drm_kms_helper vmw_vmci cec sg rc_core ac button nfsd auth_rpcgss nfs_acl lockd grace drm fuse sunrpc configfs ip_tables x_tables autofs4 btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c crc32c_generic dm_mod sd_mod t10_pi crc_t10dif crct10dif_generic ata_generic crct10dif_pclmul crct10dif_common crc32_pclmul crc32c_intel ata_piix vmw_pvscsi libata psmouse scsi_mod vmxnet3 i2c_piix4
2021-11-22T09:12:16.957146+01:00 storage-s10 kernel: [1930092.501328] ---[ end trace 1f8f8a420695731b ]---

This trace is followed by:
2021-11-22T09:12:16.957146+01:00 storage-s10 kernel: [1930092.501874] RIP: 0010:__list_add_valid.cold+0x3d/0x3f
2021-11-22T09:12:16.958925+01:00 storage-s10 kernel: [1930092.502423] Code: f2 4c 89 c1 48 89 fe 48 c7 c7 08 53 15 a8 e8 f8 fe fe ff 0f 0b 48 89 d1 4c 89 c6 4c 89 ca 48 c7 c7 b0 52 15 a8 e8 e1 fe fe ff <0f> 0b 48 89 fe 48 c7 c7 40 53 15 a8 e8 d0 fe fe ff 0f 0b 48 c7 c7
2021-11-22T09:12:16.958933+01:00 storage-s10 kernel: [1930092.504070] RSP: 0018:ffffbd09c29b7e38 EFLAGS: 00010246
2021-11-22T09:12:16.962117+01:00 storage-s10 kernel: [1930092.504608] RAX: 0000000000000075 RBX: ffff92439f684c08 RCX: 0000000000000000
2021-11-22T09:12:16.962124+01:00 storage-s10 kernel: [1930092.505150] RDX: 0000000000000000 RSI: ffff924439e18880 RDI: ffff924439e18880
2021-11-22T09:12:16.962124+01:00 storage-s10 kernel: [1930092.505685] RBP: ffff9243087a2950 R08: 0000000000000000 R09: ffffbd09c29b7c68
2021-11-22T09:12:16.962125+01:00 storage-s10 kernel: [1930092.506213] R10: ffffbd09c29b7c60 R11: ffff92443fec48a8 R12: ffff924402303400
2021-11-22T09:12:16.962125+01:00 storage-s10 kernel: [1930092.506729] R13: ffff9243087a2920 R14: ffff9244023034b0 R15: 0000000000000006
2021-11-22T09:12:16.962126+01:00 storage-s10 kernel: [1930092.507260] FS:  0000000000000000(0000) GS:ffff924439e00000(0000) knlGS:0000000000000000
2021-11-22T09:12:16.965880+01:00 storage-s10 kernel: [1930092.507783] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2021-11-22T09:12:16.965886+01:00 storage-s10 kernel: [1930092.508302] CR2: 00007fb154911328 CR3: 000000010aabe005 CR4: 00000000007706f0
2021-11-22T09:12:16.965887+01:00 storage-s10 kernel: [1930092.508854] PKRU: 55555554
2021-11-22T09:12:38.013111+01:00 storage-s10 kernel: [1930113.531463] rcu: INFO: rcu_sched self-detected stall on CPU
2021-11-22T09:12:38.013126+01:00 storage-s10 kernel: [1930113.532037] rcu: #0111-....: (1 GPs behind) idle=726/1/0x4000000000000000 softirq=433107463/433107464 fqs=2625 
2021-11-22T09:12:38.013128+01:00 storage-s10 kernel: [1930113.533150] #011(t=5251 jiffies g=411028473 q=326)
2021-11-22T09:12:38.013129+01:00 storage-s10 kernel: [1930113.533689] NMI backtrace for cpu 1
2021-11-22T09:12:38.013130+01:00 storage-s10 kernel: [1930113.534251] CPU: 1 PID: 702 Comm: nfsd Tainted: G      D W         5.14.0-0.bpo.2-amd64 #1  Debian 5.14.9-2~bpo11+1
2021-11-22T09:12:38.013130+01:00 storage-s10 kernel: [1930113.535361] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 12/12/2018
2021-11-22T09:12:38.013131+01:00 storage-s10 kernel: [1930113.536527] Call Trace:
2021-11-22T09:12:38.013131+01:00 storage-s10 kernel: [1930113.537119]  <IRQ>
2021-11-22T09:12:38.013132+01:00 storage-s10 kernel: [1930113.537790]  dump_stack_lvl+0x46/0x5a
2021-11-22T09:12:38.013132+01:00 storage-s10 kernel: [1930113.538470]  nmi_cpu_backtrace.cold+0x32/0x69
2021-11-22T09:12:38.013132+01:00 storage-s10 kernel: [1930113.539058]  ? lapic_can_unplug_cpu+0x80/0x80
2021-11-22T09:12:38.013133+01:00 storage-s10 kernel: [1930113.539660]  nmi_trigger_cpumask_backtrace+0xd7/0xe0
2021-11-22T09:12:38.013133+01:00 storage-s10 kernel: [1930113.540243]  rcu_dump_cpu_stacks+0xc1/0xef
2021-11-22T09:12:38.013134+01:00 storage-s10 kernel: [1930113.540810]  rcu_sched_clock_irq.cold+0xc7/0x1e9
2021-11-22T09:12:38.013134+01:00 storage-s10 kernel: [1930113.541342]  ? trigger_load_balance+0x60/0x2e0
2021-11-22T09:12:38.013134+01:00 storage-s10 kernel: [1930113.541886]  ? scheduler_tick+0xb8/0x220
2021-11-22T09:12:38.013135+01:00 storage-s10 kernel: [1930113.542398]  update_process_times+0x8c/0xc0
2021-11-22T09:12:38.013135+01:00 storage-s10 kernel: [1930113.542909]  tick_sched_handle+0x22/0x60
2021-11-22T09:12:38.013136+01:00 storage-s10 kernel: [1930113.543398]  tick_sched_timer+0x7a/0xd0
2021-11-22T09:12:38.013137+01:00 storage-s10 kernel: [1930113.543882]  ? tick_do_update_jiffies64.part.0+0xa0/0xa0
2021-11-22T09:12:38.013137+01:00 storage-s10 kernel: [1930113.544355]  __hrtimer_run_queues+0x127/0x270
2021-11-22T09:12:38.013138+01:00 storage-s10 kernel: [1930113.544817]  hrtimer_interrupt+0x110/0x2c0
2021-11-22T09:12:38.013138+01:00 storage-s10 kernel: [1930113.545288]  __sysvec_apic_timer_interrupt+0x59/0xd0
2021-11-22T09:12:38.013139+01:00 storage-s10 kernel: [1930113.545724]  sysvec_apic_timer_interrupt+0x6d/0x90
2021-11-22T09:12:38.013140+01:00 storage-s10 kernel: [1930113.546187]  </IRQ>
2021-11-22T09:12:38.013140+01:00 storage-s10 kernel: [1930113.546611]  asm_sysvec_apic_timer_interrupt+0x12/0x20
2021-11-22T09:12:38.013141+01:00 storage-s10 kernel: [1930113.547042] RIP: 0010:native_queued_spin_lock_slowpath+0xe/0x1d0
2021-11-22T09:12:38.013141+01:00 storage-s10 kernel: [1930113.547499] Code: 0f b1 38 48 85 c0 75 c5 4d 89 50 08 4c 89 c0 c3 0f 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 66 90 ba 01 00 00 00 8b 07 <85> c0 75 09 f0 0f b1 17 85 c0 75 f2 c3 f3 90 eb ed 81 fe 00 01 00
2021-11-22T09:12:38.013143+01:00 storage-s10 kernel: [1930113.548864] RSP: 0018:ffffbd09c2f2bce0 EFLAGS: 00000202
2021-11-22T09:12:38.013143+01:00 storage-s10 kernel: [1930113.549320] RAX: 0000000000000001 RBX: ffff924405db8900 RCX: 0000000000000038
2021-11-22T09:12:38.013144+01:00 storage-s10 kernel: [1930113.549791] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffffffc076fd00
2021-11-22T09:12:38.013144+01:00 storage-s10 kernel: [1930113.550268] RBP: ffffbd09c2f2bdc8 R08: ffff92437f8b9604 R09: ffffffffa8653b40
2021-11-22T09:12:38.013144+01:00 storage-s10 kernel: [1930113.550714] R10: ffff92430d001d08 R11: 000945fa00000000 R12: 0000000000000000
2021-11-22T09:12:38.013145+01:00 storage-s10 kernel: [1930113.551187] R13: 00000000000000e0 R14: ffff924405610000 R15: ffff9243ba930980
2021-11-22T09:12:38.013155+01:00 storage-s10 kernel: [1930113.551636]  _raw_spin_lock+0x1a/0x20
2021-11-22T09:12:38.013155+01:00 storage-s10 kernel: [1930113.552087]  nfsd4_process_open2+0x6d8/0x1690 [nfsd]
2021-11-22T09:12:38.013155+01:00 storage-s10 kernel: [1930113.552568]  ? nfsd_permission+0x6a/0x100 [nfsd]
2021-11-22T09:12:38.013156+01:00 storage-s10 kernel: [1930113.553012]  ? fh_verify+0x1b1/0x6c0 [nfsd]
2021-11-22T09:12:38.013156+01:00 storage-s10 kernel: [1930113.553473]  ? nfsd_lookup+0xab/0x150 [nfsd]
2021-11-22T09:12:38.013156+01:00 storage-s10 kernel: [1930113.553893]  nfsd4_open+0x614/0x6f0 [nfsd]
2021-11-22T09:12:38.013157+01:00 storage-s10 kernel: [1930113.554305]  nfsd4_proc_compound+0x393/0x630 [nfsd]
2021-11-22T09:12:38.013158+01:00 storage-s10 kernel: [1930113.554737]  nfsd_dispatch+0x147/0x230 [nfsd]
2021-11-22T09:12:38.013159+01:00 storage-s10 kernel: [1930113.555143]  svc_process_common+0x3d1/0x6d0 [sunrpc]
2021-11-22T09:12:38.013159+01:00 storage-s10 kernel: [1930113.555593]  ? nfsd_svc+0x350/0x350 [nfsd]
2021-11-22T09:12:38.013159+01:00 storage-s10 kernel: [1930113.556004]  svc_process+0xb7/0xf0 [sunrpc]
2021-11-22T09:12:38.013160+01:00 storage-s10 kernel: [1930113.556440]  nfsd+0xe8/0x140 [nfsd]
2021-11-22T09:12:38.013160+01:00 storage-s10 kernel: [1930113.556866]  ? nfsd_shutdown_threads+0x80/0x80 [nfsd]
2021-11-22T09:12:38.013162+01:00 storage-s10 kernel: [1930113.557282]  kthread+0x124/0x150
2021-11-22T09:12:38.013162+01:00 storage-s10 kernel: [1930113.557689]  ? set_kthread_struct+0x40/0x40
2021-11-22T09:12:38.013162+01:00 storage-s10 kernel: [1930113.558105]  ret_from_fork+0x1f/0x30
...
2021-11-22T09:13:05.616901+01:00 storage-s10 kernel: [1930141.140062] watchdog: BUG: soft lockup - CPU#1 stuck for 49s! [nfsd:702]
2021-11-22T09:13:05.616916+01:00 storage-s10 kernel: [1930141.140654] Modules linked in: binfmt_misc vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock intel_rapl_msr intel_rapl_common nfit libnvdimm ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl vmwgfx vmw_balloon ttm evdev joydev serio_raw pcspkr drm_kms_helper vmw_vmci cec sg rc_core ac button nfsd auth_rpcgss nfs_acl lockd grace drm fuse sunrpc configfs ip_tables x_tables autofs4 btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c crc32c_generic dm_mod sd_mod t10_pi crc_t10dif crct10dif_generic ata_generic crct10dif_pclmul crct10dif_common crc32_pclmul crc32c_intel ata_piix vmw_pvscsi libata psmouse scsi_mod vmxnet3 i2c_piix4
2021-11-22T09:13:05.616917+01:00 storage-s10 kernel: [1930141.143948] CPU: 1 PID: 702 Comm: nfsd Tainted: G      D W         5.14.0-0.bpo.2-amd64 #1  Debian 5.14.9-2~bpo11+1
2021-11-22T09:13:05.616918+01:00 storage-s10 kernel: [1930141.144966] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 12/12/2018

If it can be relevant, we try to set /proc/sys/kernel/panic to 20 for enforce a reboot on kernel bug but it did not work.

Our groups of servers are used to host websites, some with only one website, some with many. For now, this issue only occurred on NFS servers part of a group with many websites. But one of the most load NFS server is also used only for one website and has never had this issue. May be this issue occurs only when the NFS server is serving many different files.

Regards,

Olivier

-----Message d'origine-----
De : Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com> De la part de Salvatore Bonaccorso
Envoyé : mercredi 6 octobre 2021 20:47
À : J. Bruce Fields <bfields@fieldses.org>; linux-nfs@vger.kernel.org
Cc : Chuck Lever <chuck.lever@oracle.com>
Objet : Re: Kernel panic / list_add corruption when in nfsd4_run_cb_work

Hi,

On Sun, Oct 18, 2020 at 11:39:03AM +0200, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Mon, Oct 12, 2020 at 12:33:55PM -0400, J. Bruce Fields wrote:
> > On Mon, Oct 12, 2020 at 05:41:59PM +0200, Salvatore Bonaccorso wrote:
> > > Hi Bruce,
> > > 
> > > Thanks a lot for your reply, much appreciated.
> > > 
> > > On Mon, Oct 12, 2020 at 10:26:02AM -0400, J. Bruce Fields wrote:
> > > > On Sun, Oct 11, 2020 at 09:59:13AM +0200, Salvatore Bonaccorso wrote:
> > > > > Hi
> > > > > 
> > > > > On a system running 4.19.146-1 in Debian buster an issue got 
> > > > > hit, while the server was under some slight load, but it does 
> > > > > not seem easily reproducible, so asking if some more 
> > > > > information can be provided to track/narrow this down. On the 
> > > > > console the following was
> > > > > caught:
> > > > 
> > > > Worth checking git logs of fs/nfsd/nfs4state.c and 
> > > > fs/nfsd/nfs4callback.c.  It might be 
> > > > 2bbfed98a4d82ac4e7abfcd4eba40bddfc670b1d "nfsd: Fix races 
> > > > between
> > > > nfsd4_cb_release() and nfsd4_shutdown_callback()" ?
> > > 
> > > That might be possible. As it was not possible to simply trigger 
> > > the issue, do you know if it is possible to simply reproduce the 
> > > issue fixed in the above?
> > 
> > I don't have a reproducer.
> 
> I stil could not find a way to controlled trigger the issue, but on 
> the same server the following was caused as well, which might be 
> releated as well (altough different backtrace, but maybe gives 
> additional hints what can be looked for):
> 
> [ 4390.059004] ------------[ cut here ]------------ [ 4390.063780] 
> WARNING: CPU: 14 PID: 24184 at fs/nfsd/nfs4state.c:4778 
> laundromat_main.cold.125+0x31/0x7a [nfsd] [ 4390.073763] Modules 
> linked in: tcp_diag udp_diag raw_diag inet_diag unix_diag binfmt_misc 
> rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache quota_v2 quota_tree 
> bonding intel_rapl skx_edac nfit libnv dimm x86_pkg_temp_thermal 
> intel_powerclamp coretemp kvm_intel kvm irqbypass ipmi_ssif 
> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate ast ttm 
> drm_kms_helper intel_uncore mei_me drm jo ydev iTCO_wdt evdev 
> pcc_cpufreq pcspkr sg ioatdma intel_rapl_perf mei iTCO_vendor_support 
> i2c_algo_bit dca ipmi_si wmi ipmi_devintf ipmi_msghandler 
> acpi_power_meter acpi_pad button nfsd auth_rpcgss nfs_acl lockd grace 
> sunrpc ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto ecb 
> dm_mod raid10 raid456 async_raid6_recov async_memcpy async_pq 
> async_xor async_tx xor raid6_pq libcrc32c crc 32c_generic raid1 [ 
> 4390.144313]  raid0 multipath linear md_mod hid_generic usbhid hid 
> sd_mod crc32c_intel aesni_intel ahci xhci_pci libahci aes_x86_64 
> xhci_hcd arcmsr crypto_simd libata cryptd i40e usbcore scsi_mod 
> glue_helper lpc_ich i2c_i801 mfd_core usb_common [ 4390.165906] CPU: 
> 14 PID: 24184 Comm: kworker/u42:2 Not tainted 4.19.0-11-amd64 #1 
> Debian 4.19.146-1 [ 4390.174969] Hardware name: DALCO AG 
> S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019 
> [ 4390.184654] Workqueue: nfsd4 laundromat_main [nfsd] [ 4390.189550] 
> RIP: 0010:laundromat_main.cold.125+0x31/0x7a [nfsd] [ 4390.195484] 
> Code: f6 6b c0 e8 24 ae 62 d7 e9 6f 21 ff ff 48 c7 c7 38 f6 6b c0 e8 
> 13 ae 62 d7 e9 1f 21 ff ff 48 c7 c7 40 f3 6b c0 e8 02 ae 62 d7 <0f> 0b 
> e9 34 23 ff ff 48 c7 c7 40 f3 6b c0 e8 ef a d 62 d7 0f 0b e9 [ 
> 4390.214280] RSP: 0018:ffffb0568a6d7e20 EFLAGS: 00010246 [ 4390.219523] RAX: 0000000000000024 RBX: ffffb0568a6d7e50 RCX: 0000000000000000 [ 4390.226678] RDX: 0000000000000000 RSI: ffff9def8f8166b8 RDI: ffff9def8f8166b8 [ 4390.233826] RBP: ffffb0568a6d7e50 R08: 0000000000000556 R09: 0000000000aaaaaa [ 4390.240976] R10: 0000000000000000 R11: 0000000000000001 R12: 000000005f8b6732 [ 4390.248126] R13: ffff9de31d44c798 R14: 000000000000001c R15: ffffb0568a6d7e50 [ 4390.255277] FS:  0000000000000000(0000) GS:ffff9def8f800000(0000) knlGS:0000000000000000 [ 4390.263382] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 4390.269147] CR2: 00007f50de60b7f8 CR3: 000000046740a006 CR4: 00000000007606e0 [ 4390.276302] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 [ 4390.283448] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 [ 4390.290598] PKRU: 55555554 [ 4390.293316] Call Trace:
> [ 4390.295790]  process_one_work+0x1a7/0x3a0 [ 4390.299815]  
> worker_thread+0x30/0x390 [ 4390.303487]  ? create_worker+0x1a0/0x1a0 [ 
> 4390.307422]  kthread+0x112/0x130 [ 4390.310661]  ? 
> kthread_bind+0x30/0x30 [ 4390.314340]  ret_from_fork+0x35/0x40 [ 
> 4390.317936] ---[ end trace d0209d068f8583fd ]--- [ 4390.322577] 
> list_add double add: new=ffff9de31d44c798, prev=ffffb0568a6d7e50, next=ffff9de31d44c798.
> [ 4390.331736] ------------[ cut here ]------------ [ 4390.336368] 
> kernel BUG at lib/list_debug.c:31!
> [ 4390.340829] invalid opcode: 0000 [#1] SMP PTI
> [ 4390.345200] CPU: 14 PID: 24184 Comm: kworker/u42:2 Tainted: G        W         4.19.0-11-amd64 #1 Debian 4.19.146-1
> [ 4390.355648] Hardware name: DALCO AG S2600WFT/S2600WFT, BIOS 
> SE5C620.86B.02.01.0008.031920191559 03/19/2019 [ 4390.365327] 
> Workqueue: nfsd4 laundromat_main [nfsd] [ 4390.371091] RIP: 
> 0010:__list_add_valid+0x41/0x50 [ 4390.376551] Code: 85 94 00 00 00 48 
> 39 c7 74 0b 48 39 d7 74 06 b8 01 00 00 00 c3 48 89 f2 4c 89 c1 48 89 
> fe 48 c7 c7 80 a4 a9 98 e8 bd 6b d0 ff <0f> 0b 66 66 2e 0f 1f 84 00 00 
> 00 00 00 66 90 48 8b 07 48 8b 57 08 [ 4390.397015] RSP: 
> 0018:ffffb0568a6d7e18 EFLAGS: 00010246 [ 4390.403077] RAX: 
> 0000000000000058 RBX: ffff9de31d44c798 RCX: 0000000000000000 [ 
> 4390.411045] RDX: 0000000000000000 RSI: ffff9def8f8166b8 RDI: 
> ffff9def8f8166b8 [ 4390.418996] RBP: ffffb0568a6d7e50 R08: 
> 0000000000000573 R09: 0000000000aaaaaa [ 4390.426937] R10: 
> 0000000000000000 R11: 0000000000000001 R12: 000000005f8b6732 [ 
> 4390.434859] R13: ffff9de31d44c798 R14: 000000000000001c R15: 
> ffffb0568a6d7e50 [ 4390.442761] FS:  0000000000000000(0000) 
> GS:ffff9def8f800000(0000) knlGS:0000000000000000 [ 4390.451610] CS:  
> 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 4390.458100] CR2: 00007f50de60b7f8 CR3: 000000046740a006 CR4: 00000000007606e0 [ 4390.465970] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 [ 4390.473820] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 [ 4390.481650] PKRU: 55555554 [ 4390.485032] Call Trace:
> [ 4390.488145]  laundromat_main+0x27a/0x610 [nfsd] [ 4390.493333]  
> process_one_work+0x1a7/0x3a0 [ 4390.497987]  worker_thread+0x30/0x390 
> [ 4390.502276]  ? create_worker+0x1a0/0x1a0 [ 4390.506808]  
> kthread+0x112/0x130 [ 4390.510636]  ? kthread_bind+0x30/0x30 [ 
> 4390.514892]  ret_from_fork+0x35/0x40 [ 4390.519056] Modules linked 
> in: tcp_diag udp_diag raw_diag inet_diag unix_diag binfmt_misc 
> rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache quota_v2 quota_tree 
> bonding intel_rapl skx_edac nfit libnvdimm x86_pkg_temp_thermal 
> intel_powerclamp coretemp kvm_intel kvm irqbypass ipmi_ssif 
> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate ast ttm 
> drm_kms_helper intel_uncore mei_me drm joydev iTCO_wdt evdev 
> pcc_cpufreq pcspkr sg ioatdma intel_rapl_perf mei iTCO_vendor_support 
> i2c_algo_bit dca ipmi_si wmi ipmi_devintf ipmi_msghandler 
> acpi_power_meter acpi_pad button nfsd auth_rpcgss nfs_acl lockd grace 
> sunrpc ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto ecb 
> dm_mod raid10 raid456 async_raid6_recov async_memcpy async_pq 
> async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 [ 
> 4390.593983]  raid0 multipath linear md_mod hid_generic usbhid hid 
> sd_mod crc32c_intel aesni_intel ahci xhci_pci libahci aes_x86_64 
> xhci_hcd arcmsr crypto_simd libata cryptd i40e usbcore scsi_mod 
> glue_helper lpc_ich i2c_i801 mfd_core usb_common [ 4390.616982] ---[ 
> end trace d0209d068f8583fe ]--- [ 4390.704972] RIP: 
> 0010:__list_add_valid+0x41/0x50 [ 4390.710342] Code: 85 94 00 00 00 48 
> 39 c7 74 0b 48 39 d7 74 06 b8 01 00 00 00 c3 48 89 f2 4c 89 c1 48 89 
> fe 48 c7 c7 80 a4 a9 98 e8 bd 6b d0 ff <0f> 0b 66 66 2e 0f 1f 84 00 00 
> 00 00 00 66 90 48 8b 07 48 8b 57 08 [ 4390.730656] RSP: 
> 0018:ffffb0568a6d7e18 EFLAGS: 00010246 [ 4390.736676] RAX: 
> 0000000000000058 RBX: ffff9de31d44c798 RCX: 0000000000000000 [ 
> 4390.744609] RDX: 0000000000000000 RSI: ffff9def8f8166b8 RDI: 
> ffff9def8f8166b8 [ 4390.752555] RBP: ffffb0568a6d7e50 R08: 
> 0000000000000573 R09: 0000000000aaaaaa [ 4390.760497] R10: 
> 0000000000000000 R11: 0000000000000001 R12: 000000005f8b6732 [ 
> 4390.768433] R13: ffff9de31d44c798 R14: 000000000000001c R15: 
> ffffb0568a6d7e50 [ 4390.776361] FS:  0000000000000000(0000) 
> GS:ffff9def8f800000(0000) knlGS:0000000000000000 [ 4390.785244] CS:  
> 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 4390.791789] CR2: 
> 00007f50de60b7f8 CR3: 000000046740a006 CR4: 00000000007606e0 [ 
> 4390.799725] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000 [ 4390.807642] DR3: 0000000000000000 DR6: 
> 00000000fffe0ff0 DR7: 0000000000000400 [ 4390.815544] PKRU: 55555554 [ 
> 4390.819023] Kernel panic - not syncing: Fatal exception [ 
> 4390.825022] Kernel Offset: 0x16c00000 from 0xffffffff81000000 
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> Thanks for your time in any case!

Waving back after almost one year. We started to see again those crashes under load after during the year situation improved (when load went down). I'm still quite lost in trying to either reproduce the issue or pinpoint a possible cause.

Any hints from you upstream, or what you want me to provide? The host is currently running 4.19.194 based kernel in Debian buster, but can soonish update it to 4.19.208 as well to match almost the current version in the 4.19.y series.

Regards,
Salvatore

