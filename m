Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C0B42463D
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Oct 2021 20:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhJFSsd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Oct 2021 14:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhJFSsd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Oct 2021 14:48:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F273C061746
        for <linux-nfs@vger.kernel.org>; Wed,  6 Oct 2021 11:46:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g8so13422078edt.7
        for <linux-nfs@vger.kernel.org>; Wed, 06 Oct 2021 11:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QiVjFcT8BVEirIwtS9n80OnxIq8LLUqZ8rRR12pC3MY=;
        b=YpuDunzbgaNzP1hGoacIcurzulQ40NBz7Z3KunTstowRGi5UDMzl1ppydVdJXj10s3
         MiaSkTsY93u7TQZO1FbM5Vk+W2cOa1qMcASprB77cni60mgeHvG3/2OdsBDiEwpZCIu2
         hL0l3cUt9xeOa7GXo1PaW5u/Lbca2GD6hnZAzv0V53Vrre8nQTGwZTNMNnzfreJIjySy
         QAThIS1oy1vuoOVYfcorg7JwsjvVk0YJDkQXr1pB+mwVcAUrwF04rRbQCJWmY+kXmknW
         d1MikwPTv7I/n7BVKxtNAvIWwHVPD3SuEuSji1iSwLzSe+ewKCs6ZK34us+zQwwMP/1u
         UzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QiVjFcT8BVEirIwtS9n80OnxIq8LLUqZ8rRR12pC3MY=;
        b=5LIf3MyfDHEz9KRvJNSTpM3kuIOYnq9oubCFFo9aQNXT0LHDi2qgIwgmq284H5HY6D
         iNbJUywFnbdnlID1VgjfJprFV5rimfEaspgoNfsVResuLE6QFS77Xn3XxmkZj33l8h0P
         7zAWVK7U2VJR6PYs9bblOCUZCisR3G6OyqslNgVnmOZrjaYwjBdPhcgJlSxfFyK5we4o
         9C1JFVo0RXgWXkLBcHeP/fcOx+ywl54pfAXbz/YILfbZDDbuMc79JAFNdpkQHdOXzOEx
         aPqtwR8P//L9Ugb8/7GFZNrOj1n0qYQGF9nZOeS4onQUi2iWSzFcgL4ZtKMf70sSTtFb
         evjQ==
X-Gm-Message-State: AOAM533y7FnjmtSi/Uln7j+yejZJynhHtFuIhoH6ctw9BEvlsQATcFYA
        5Fk/Q+75s7BDZCQGTJ4wVQA=
X-Google-Smtp-Source: ABdhPJyl1jRoxXF47Of4VJKuz7dJBBgrytdxKIYoMb9kqkzHSLVtNZtjcR6hOjg1wPqrkr5Z69petg==
X-Received: by 2002:a05:6402:19ad:: with SMTP id o13mr36942796edz.109.1633545999065;
        Wed, 06 Oct 2021 11:46:39 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id ee13sm8244139edb.14.2021.10.06.11.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 11:46:38 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Wed, 6 Oct 2021 20:46:37 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Subject: Re: Kernel panic / list_add corruption when in nfsd4_run_cb_work
Message-ID: <YV3vDQOPVgxc/J99@eldamar.lan>
References: <20201011075913.GA8065@eldamar.lan>
 <20201012142602.GD26571@fieldses.org>
 <20201012154159.GA49819@eldamar.lan>
 <20201012163355.GF26571@fieldses.org>
 <20201018093903.GA364695@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201018093903.GA364695@eldamar.lan>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

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
> > > > > On a system running 4.19.146-1 in Debian buster an issue got hit,
> > > > > while the server was under some slight load, but it does not seem
> > > > > easily reproducible, so asking if some more information can be
> > > > > provided to track/narrow this down. On the console the following was
> > > > > caught:
> > > > 
> > > > Worth checking git logs of fs/nfsd/nfs4state.c and
> > > > fs/nfsd/nfs4callback.c.  It might be
> > > > 2bbfed98a4d82ac4e7abfcd4eba40bddfc670b1d "nfsd: Fix races between
> > > > nfsd4_cb_release() and nfsd4_shutdown_callback()" ?
> > > 
> > > That might be possible. As it was not possible to simply trigger the
> > > issue, do you know if it is possible to simply reproduce the issue
> > > fixed in the above?
> > 
> > I don't have a reproducer.
> 
> I stil could not find a way to controlled trigger the issue, but on
> the same server the following was caused as well, which might be
> releated as well (altough different backtrace, but maybe gives
> additional hints what can be looked for):
> 
> [ 4390.059004] ------------[ cut here ]------------
> [ 4390.063780] WARNING: CPU: 14 PID: 24184 at fs/nfsd/nfs4state.c:4778 laundromat_main.cold.125+0x31/0x7a [nfsd]
> [ 4390.073763] Modules linked in: tcp_diag udp_diag raw_diag inet_diag unix_diag binfmt_misc rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache quota_v2 quota_tree bonding intel_rapl skx_edac nfit libnv
> dimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass ipmi_ssif crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate ast ttm drm_kms_helper intel_uncore mei_me drm jo
> ydev iTCO_wdt evdev pcc_cpufreq pcspkr sg ioatdma intel_rapl_perf mei iTCO_vendor_support i2c_algo_bit dca ipmi_si wmi ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad button nfsd auth_rpcgss
> nfs_acl lockd grace sunrpc ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto ecb dm_mod raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc
> 32c_generic raid1
> [ 4390.144313]  raid0 multipath linear md_mod hid_generic usbhid hid sd_mod crc32c_intel aesni_intel ahci xhci_pci libahci aes_x86_64 xhci_hcd arcmsr crypto_simd libata cryptd i40e usbcore scsi_mod
> glue_helper lpc_ich i2c_i801 mfd_core usb_common
> [ 4390.165906] CPU: 14 PID: 24184 Comm: kworker/u42:2 Not tainted 4.19.0-11-amd64 #1 Debian 4.19.146-1
> [ 4390.174969] Hardware name: DALCO AG S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> [ 4390.184654] Workqueue: nfsd4 laundromat_main [nfsd]
> [ 4390.189550] RIP: 0010:laundromat_main.cold.125+0x31/0x7a [nfsd]
> [ 4390.195484] Code: f6 6b c0 e8 24 ae 62 d7 e9 6f 21 ff ff 48 c7 c7 38 f6 6b c0 e8 13 ae 62 d7 e9 1f 21 ff ff 48 c7 c7 40 f3 6b c0 e8 02 ae 62 d7 <0f> 0b e9 34 23 ff ff 48 c7 c7 40 f3 6b c0 e8 ef a
> d 62 d7 0f 0b e9
> [ 4390.214280] RSP: 0018:ffffb0568a6d7e20 EFLAGS: 00010246
> [ 4390.219523] RAX: 0000000000000024 RBX: ffffb0568a6d7e50 RCX: 0000000000000000
> [ 4390.226678] RDX: 0000000000000000 RSI: ffff9def8f8166b8 RDI: ffff9def8f8166b8
> [ 4390.233826] RBP: ffffb0568a6d7e50 R08: 0000000000000556 R09: 0000000000aaaaaa
> [ 4390.240976] R10: 0000000000000000 R11: 0000000000000001 R12: 000000005f8b6732
> [ 4390.248126] R13: ffff9de31d44c798 R14: 000000000000001c R15: ffffb0568a6d7e50
> [ 4390.255277] FS:  0000000000000000(0000) GS:ffff9def8f800000(0000) knlGS:0000000000000000
> [ 4390.263382] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4390.269147] CR2: 00007f50de60b7f8 CR3: 000000046740a006 CR4: 00000000007606e0
> [ 4390.276302] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 4390.283448] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 4390.290598] PKRU: 55555554
> [ 4390.293316] Call Trace:
> [ 4390.295790]  process_one_work+0x1a7/0x3a0
> [ 4390.299815]  worker_thread+0x30/0x390
> [ 4390.303487]  ? create_worker+0x1a0/0x1a0
> [ 4390.307422]  kthread+0x112/0x130
> [ 4390.310661]  ? kthread_bind+0x30/0x30
> [ 4390.314340]  ret_from_fork+0x35/0x40
> [ 4390.317936] ---[ end trace d0209d068f8583fd ]---
> [ 4390.322577] list_add double add: new=ffff9de31d44c798, prev=ffffb0568a6d7e50, next=ffff9de31d44c798.
> [ 4390.331736] ------------[ cut here ]------------
> [ 4390.336368] kernel BUG at lib/list_debug.c:31!
> [ 4390.340829] invalid opcode: 0000 [#1] SMP PTI
> [ 4390.345200] CPU: 14 PID: 24184 Comm: kworker/u42:2 Tainted: G        W         4.19.0-11-amd64 #1 Debian 4.19.146-1
> [ 4390.355648] Hardware name: DALCO AG S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> [ 4390.365327] Workqueue: nfsd4 laundromat_main [nfsd]
> [ 4390.371091] RIP: 0010:__list_add_valid+0x41/0x50
> [ 4390.376551] Code: 85 94 00 00 00 48 39 c7 74 0b 48 39 d7 74 06 b8 01 00 00 00 c3 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 80 a4 a9 98 e8 bd 6b d0 ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8b 07 48 8b 57 08
> [ 4390.397015] RSP: 0018:ffffb0568a6d7e18 EFLAGS: 00010246
> [ 4390.403077] RAX: 0000000000000058 RBX: ffff9de31d44c798 RCX: 0000000000000000
> [ 4390.411045] RDX: 0000000000000000 RSI: ffff9def8f8166b8 RDI: ffff9def8f8166b8
> [ 4390.418996] RBP: ffffb0568a6d7e50 R08: 0000000000000573 R09: 0000000000aaaaaa
> [ 4390.426937] R10: 0000000000000000 R11: 0000000000000001 R12: 000000005f8b6732
> [ 4390.434859] R13: ffff9de31d44c798 R14: 000000000000001c R15: ffffb0568a6d7e50
> [ 4390.442761] FS:  0000000000000000(0000) GS:ffff9def8f800000(0000) knlGS:0000000000000000
> [ 4390.451610] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4390.458100] CR2: 00007f50de60b7f8 CR3: 000000046740a006 CR4: 00000000007606e0
> [ 4390.465970] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 4390.473820] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 4390.481650] PKRU: 55555554
> [ 4390.485032] Call Trace:
> [ 4390.488145]  laundromat_main+0x27a/0x610 [nfsd]
> [ 4390.493333]  process_one_work+0x1a7/0x3a0
> [ 4390.497987]  worker_thread+0x30/0x390
> [ 4390.502276]  ? create_worker+0x1a0/0x1a0
> [ 4390.506808]  kthread+0x112/0x130
> [ 4390.510636]  ? kthread_bind+0x30/0x30
> [ 4390.514892]  ret_from_fork+0x35/0x40
> [ 4390.519056] Modules linked in: tcp_diag udp_diag raw_diag inet_diag unix_diag binfmt_misc rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache quota_v2 quota_tree bonding intel_rapl skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass ipmi_ssif crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate ast ttm drm_kms_helper intel_uncore mei_me drm joydev iTCO_wdt evdev pcc_cpufreq pcspkr sg ioatdma intel_rapl_perf mei iTCO_vendor_support i2c_algo_bit dca ipmi_si wmi ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad button nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 fscrypto ecb dm_mod raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1
> [ 4390.593983]  raid0 multipath linear md_mod hid_generic usbhid hid sd_mod crc32c_intel aesni_intel ahci xhci_pci libahci aes_x86_64 xhci_hcd arcmsr crypto_simd libata cryptd i40e usbcore scsi_mod glue_helper lpc_ich i2c_i801 mfd_core usb_common
> [ 4390.616982] ---[ end trace d0209d068f8583fe ]---
> [ 4390.704972] RIP: 0010:__list_add_valid+0x41/0x50
> [ 4390.710342] Code: 85 94 00 00 00 48 39 c7 74 0b 48 39 d7 74 06 b8 01 00 00 00 c3 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 80 a4 a9 98 e8 bd 6b d0 ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8b 07 48 8b 57 08
> [ 4390.730656] RSP: 0018:ffffb0568a6d7e18 EFLAGS: 00010246
> [ 4390.736676] RAX: 0000000000000058 RBX: ffff9de31d44c798 RCX: 0000000000000000
> [ 4390.744609] RDX: 0000000000000000 RSI: ffff9def8f8166b8 RDI: ffff9def8f8166b8
> [ 4390.752555] RBP: ffffb0568a6d7e50 R08: 0000000000000573 R09: 0000000000aaaaaa
> [ 4390.760497] R10: 0000000000000000 R11: 0000000000000001 R12: 000000005f8b6732
> [ 4390.768433] R13: ffff9de31d44c798 R14: 000000000000001c R15: ffffb0568a6d7e50
> [ 4390.776361] FS:  0000000000000000(0000) GS:ffff9def8f800000(0000) knlGS:0000000000000000
> [ 4390.785244] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4390.791789] CR2: 00007f50de60b7f8 CR3: 000000046740a006 CR4: 00000000007606e0
> [ 4390.799725] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 4390.807642] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 4390.815544] PKRU: 55555554
> [ 4390.819023] Kernel panic - not syncing: Fatal exception
> [ 4390.825022] Kernel Offset: 0x16c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> Thanks for your time in any case!

Waving back after almost one year. We started to see again those
crashes under load after during the year situation improved (when load
went down). I'm still quite lost in trying to either reproduce the
issue or pinpoint a possible cause.

Any hints from you upstream, or what you want me to provide? The host
is currently running 4.19.194 based kernel in Debian buster, but can
soonish update it to 4.19.208 as well to match almost the current
version in the 4.19.y series.

Regards,
Salvatore
