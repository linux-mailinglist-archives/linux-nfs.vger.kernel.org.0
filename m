Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6645E28BACA
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Oct 2020 16:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388949AbgJLO0D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Oct 2020 10:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388589AbgJLO0D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Oct 2020 10:26:03 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA60C0613D0
        for <linux-nfs@vger.kernel.org>; Mon, 12 Oct 2020 07:26:03 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 56A0569C3; Mon, 12 Oct 2020 10:26:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 56A0569C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602512762;
        bh=144Dksaa4a1AAxl5YerLF0vhYfWkmyvtO0cPso2YxUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yvYR5P9SCmBtZKdo2pzAwp8lopVNT4drmB21qwh/PfT9b3GIE3aJ8xZQQUhlw6Vc9
         eBxpWOyEZ9/SmJ7KUEI8t0ZLyAuJPAPxQ3qctN0io3tN+nZaKU0pBjWFfXgUG20GyY
         Xt4x0hxcTKv3rzIMeelbSZZp6qbU9bjtKLEL6o18=
Date:   Mon, 12 Oct 2020 10:26:02 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: Kernel panic / list_add corruption when in nfsd4_run_cb_work
Message-ID: <20201012142602.GD26571@fieldses.org>
References: <20201011075913.GA8065@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011075913.GA8065@eldamar.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Oct 11, 2020 at 09:59:13AM +0200, Salvatore Bonaccorso wrote:
> Hi
> 
> On a system running 4.19.146-1 in Debian buster an issue got hit,
> while the server was under some slight load, but it does not seem
> easily reproducible, so asking if some more information can be
> provided to track/narrow this down. On the console the following was
> caught:

Worth checking git logs of fs/nfsd/nfs4state.c and
fs/nfsd/nfs4callback.c.  It might be
2bbfed98a4d82ac4e7abfcd4eba40bddfc670b1d "nfsd: Fix races between
nfsd4_cb_release() and nfsd4_shutdown_callback()" ?

--b.

> 
> [1002011.364398] list_add corruption. prev->next should be next (ffff9b9e875e6ea8), but was ffff9b9ec0a14140. (prev=ffff9b9ec0a14140).
> [1002011.376317] ------------[ cut here ]------------
> [1002011.381131] kernel BUG at lib/list_debug.c:28!
> [1002011.385781] invalid opcode: 0000 [#1] SMP PTI
> [1002011.390325] CPU: 13 PID: 25775 Comm: kworker/u40:0 Not tainted 4.19.0-11-amd64 #1 Debian 4.19.146-1
> [1002011.399562] Hardware name: DALCO AG S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> [1002011.409427] Workqueue: nfsd4_callbacks nfsd4_run_cb_work [nfsd]
> [1002011.415539] RIP: 0010:__list_add_valid.cold.0+0x26/0x28
> [1002011.420949] Code: 00 00 00 c3 48 89 d1 48 c7 c7 d0 a3 69 a3 48 89 c2 e8 50 6b d0 ff 0f 0b 48 89 c1 4c 89 c6 48 c7 c7 28 a4 69 a3 e8 3c 6b d0 ff <0f> 0b 48 89 fe 48 89 c2 48 c7 c7 b8 a4 69 a3 e8
>  28 6b d0 ff 0f 0b
> [1002011.439914] RSP: 0018:ffffbf14c6993e28 EFLAGS: 00010246
> [1002011.445329] RAX: 0000000000000075 RBX: ffff9b9ec0a14140 RCX: 0000000000000000
> [1002011.452656] RDX: 0000000000000000 RSI: ffff9baa8f7966b8 RDI: ffff9baa8f7966b8
> [1002011.459979] RBP: ffffbf14c6993e70 R08: 0000000000000559 R09: 0000000000aaaaaa
> [1002011.467301] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9b9e875e6e00
> [1002011.474627] R13: ffff9ba0341872a8 R14: ffff9ba034187278 R15: ffff9b9e875e6ea8
> [1002011.481948] FS:  0000000000000000(0000) GS:ffff9baa8f780000(0000) knlGS:0000000000000000
> [1002011.490228] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [1002011.496160] CR2: 00007fda6b5330a0 CR3: 000000079d60a002 CR4: 00000000007606e0
> [1002011.503487] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [1002011.510806] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [1002011.518132] PKRU: 55555554
> [1002011.521022] Call Trace:
> [1002011.523672]  nfsd4_cb_recall_prepare+0x2b8/0x310 [nfsd]
> [1002011.529089]  nfsd4_run_cb_work+0x7d/0xf0 [nfsd]
> [1002011.533818]  process_one_work+0x1a7/0x3a0
> [1002011.538015]  worker_thread+0x30/0x390
> [1002011.541861]  ? create_worker+0x1a0/0x1a0
> [1002011.545968]  kthread+0x112/0x130
> [1002011.549381]  ? kthread_bind+0x30/0x30
> [1002011.553232]  ret_from_fork+0x35/0x40
> [1002011.556992] Modules linked in: tcp_diag udp_diag raw_diag inet_diag unix_diag binfmt_misc rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache quota_v2 quota_tree bonding ipmi_ssif intel_rapl skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ast ttm ghash_clmulni_intel drm_kms_helper intel_cstate mei_me intel_uncore drm iTCO_wdt ioatdma intel_rapl_perf pcspkr evdev joydev pcc_cpufreq i2c_algo_bit sg iTCO_vendor_support mei ipmi_si dca ipmi_devintf wmi ipmi_msghandler acpi_pad acpi_power_meter button nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto ecb dm_mod raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1
> [1002011.627690]  raid0 multipath linear md_mod hid_generic usbhid hid sd_mod crc32c_intel xhci_pci ahci xhci_hcd aesni_intel libahci aes_x86_64 crypto_simd libata arcmsr cryptd usbcore i40e scsi_mod glue_helper lpc_ich i2c_i801 mfd_core usb_common
> [1002011.651077] ---[ end trace 465dc56412b98978 ]---
> [1002011.765289] RIP: 0010:__list_add_valid.cold.0+0x26/0x28
> [1002011.771502] Code: 00 00 00 c3 48 89 d1 48 c7 c7 d0 a3 69 a3 48 89 c2 e8 50 6b d0 ff 0f 0b 48 89 c1 4c 89 c6 48 c7 c7 28 a4 69 a3 e8 3c 6b d0 ff <0f> 0b 48 89 fe 48 89 c2 48 c7 c7 b8 a4 69 a3 e8 28 6b d0 ff 0f 0b
> [1002011.792067] RSP: 0018:ffffbf14c6993e28 EFLAGS: 00010246
> [1002011.798311] RAX: 0000000000000075 RBX: ffff9b9ec0a14140 RCX: 0000000000000000
> [1002011.806453] RDX: 0000000000000000 RSI: ffff9baa8f7966b8 RDI: ffff9baa8f7966b8
> [1002011.814572] RBP: ffffbf14c6993e70 R08: 0000000000000559 R09: 0000000000aaaaaa
> [1002011.822680] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9b9e875e6e00
> [1002011.830789] R13: ffff9ba0341872a8 R14: ffff9ba034187278 R15: ffff9b9e875e6ea8
> [1002011.838895] FS:  0000000000000000(0000) GS:ffff9baa8f780000(0000) knlGS:0000000000000000
> [1002011.847972] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [1002011.854694] CR2: 00007fda6b5330a0 CR3: 000000079d60a002 CR4: 00000000007606e0
> [1002011.862806] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [1002011.870904] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [1002011.878989] PKRU: 55555554
> [1002011.882636] Kernel panic - not syncing: Fatal exception
> [1002011.888846] Kernel Offset: 0x21800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> Kernel version is 4.19.146-1 as in the current Debian buster.
> 
> The exports are as:
> 
> /srv/exports/data-01
>                 node1(rw,wdelay,no_root_squash,no_subtree_check,sec=sys,rw,secure,no_root_squash,no_all_squash)
> /srv/exports/data-02
>                 node1(rw,wdelay,no_root_squash,no_subtree_check,sec=sys,rw,secure,no_root_squash,no_all_squash)
> /srv/exports/data-01
>                 @netgroup(rw,wdelay,root_squash,no_subtree_check,sec=sys,rw,secure,root_squash,no_all_squash)
> /srv/exports/data-02
>                 @netgroup(rw,wdelay,root_squash,no_subtree_check,sec=sys,rw,secure,root_squash,no_all_squash)
> 
> Clients mounting those are mixed systems running Debian buster on 4.19.146-1
> and Debian stretch systems running 4.9.228-1.
> 
> Versions of listed packages (maybe relevant) on the server:
> 
> acl: 2.2.53-4
> libgssapi-krb5-2: 1.17-3
> libevent-2.1-6: 2.1.8-stable-4
> nfs-utils: 1:1.3.4-2.5+deb10u1
> util-linux: 2.33.1-0.1
> 
> (note those are all the respective versions in Debian buster).
> 
> Is there anything one can try to provivde to possibly track this down
> or are we here simply out of luck?
> 
> Regards,
> Salvatore
