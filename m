Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F69E5FFEF3
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Oct 2022 13:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJPLVf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Oct 2022 07:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJPLVb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 16 Oct 2022 07:21:31 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8128831344
        for <linux-nfs@vger.kernel.org>; Sun, 16 Oct 2022 04:21:28 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ok1hr-0007OE-BF; Sun, 16 Oct 2022 13:21:23 +0200
Message-ID: <8942d26d-1085-27f3-d15b-782d368e53b1@leemhuis.info>
Date:   Sun, 16 Oct 2022 13:21:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US, de-DE
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Daire Byrne <daire@dneg.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Bug 216582 - BUG: kernel NULL pointer dereference -
 nlmclnt_setlockargs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1665919288;b0637e82;
X-HE-SMSGID: 1ok1hr-0007OE-BF
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216582 :

>  Daire Byrne 2022-10-13 22:04:19 UTC
> 
> Hi,
> 
> I've started seeing this crash at least once or twice a week with our
> NFS re-export workloads (re-exporting a Linux NFsv3 server as
> NFSv3).
> 
> We have been stepping through kernel versions a bit on the server
> recently so it feels like something new introduced somewhere around
> v5.17 but I also can't rule out that our clients are doing something
> "different" with their workloads to stress this code in some new way.
> It still occurs in v6.0 too.
> 
> [106412.314663] BUG: kernel NULL pointer dereference, address: 0000000000000020
> [106412.321879] #PF: supervisor read access in kernel mode
> [106412.327237] #PF: error_code(0x0000) - not-present page
> [106412.332599] PGD 0 P4D 0 
> [106412.335353] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [106412.339935] CPU: 34 PID: 2382 Comm: lockd Tainted: G            E     5.18.10-1.dneg.x86_64 #1
> [106412.348773] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
> [106412.358223] RIP: 0010:nlmclnt_setlockargs+0x4a/0x100 [lockd]
> [106412.364116] Code: 00 00 49 81 c0 88 00 00 00 f0 0f c1 05 bf 06 01 00 83 c0 01 c7 47 30 04 00 00 00 48 8d 4f 44 48 8d 7f 4c 89 47 c4 48 8b 46 78 <48> 8b 40 20 48 8b 90 60 fe ff ff 48 8d b0 60 fe ff ff 48 89 57 f8
> [106412.383117] RSP: 0018:ffffb3db50cdfa80 EFLAGS: 00010202
> [106412.388569] RAX: 0000000000000000 RBX: ffff8a36749c9400 RCX: ffff8a36749c9444
> [106412.395924] RDX: ffff8a37f8696300 RSI: ffffb3db50cdfbd8 RDI: ffff8a36749c944c
> [106412.403277] RBP: ffffb3db50cdfa90 R08: ffff8a750b49bc88 R09: ffff8a37f8696300
> [106412.410634] R10: 0000000000000230 R11: ffffffffffffffff R12: ffffb3db50cdfbd8
> [106412.417984] R13: ffff8a7508beac00 R14: ffffb3db50cdfca0 R15: ffffb3db50cdfbd8
> [106412.425338] FS:  0000000000000000(0000) GS:ffff8a73ffa80000(0000) knlGS:0000000000000000
> [106412.433649] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [106412.439611] CR2: 0000000000000020 CR3: 00000001118e6006 CR4: 00000000003706e0
> [106412.446984] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [106412.454346] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [106412.461696] Call Trace:
> [106412.464361]  <TASK>
> [106412.466689]  nlmclnt_proc+0x1c6/0x5b0 [lockd]
> [106412.471272]  nfs3_proc_lock+0x33/0xb0 [nfsv3]
> [106412.475848]  ? nfs_put_lock_context+0x86/0x90 [nfs]
> [106412.481008]  do_unlk+0x8f/0xd0 [nfs]
> [106412.484837]  nfs_lock+0xcd/0x180 [nfs]
> [106412.488815]  ? nlmsvc_mark_host+0x30/0x30 [lockd]
> [106412.493752]  vfs_lock_file+0x1e/0x40
> [106412.497547]  nlm_unlock_files.isra.0+0x6d/0xc0 [lockd]
> [106412.502905]  nlm_traverse_files+0x163/0x2a0 [lockd]
> [106412.508020]  nlmsvc_free_host_resources+0x2b/0x40 [lockd]
> [106412.513648]  nlm_host_rebooted+0x2c/0x90 [lockd]
> [106412.518483]  nlmsvc_proc_sm_notify+0xc0/0x130 [lockd]
> [106412.523759]  ? nlmsvc_decode_reboot+0x7d/0xa0 [lockd]
> [106412.529027]  nlmsvc_dispatch+0x8e/0x1a0 [lockd]
> [106412.534312]  svc_process_common+0x484/0x620 [sunrpc]
> [106412.539521]  ? lockd+0x1d0/0x1d0 [lockd]
> [106412.543661]  ? set_grace_period+0xa0/0xa0 [lockd]
> [106412.548582]  svc_process+0xbc/0xf0 [sunrpc]
> [106412.553008]  lockd+0xd2/0x1d0 [lockd]
> [106412.556906]  ? set_grace_period+0xa0/0xa0 [lockd]
> [106412.561849]  kthread+0xee/0x120
> [106412.565228]  ? kthread_complete_and_exit+0x20/0x20
> [106412.570239]  ret_from_fork+0x1f/0x30
> [106412.574033]  </TASK>
> [106412.576436] Modules linked in: tcp_diag(E) inet_diag(E) nfsv3(E) nfs(E) cachefiles(E) fscache(E) netfs(E) ext4(E) mbcache(E) jbd2(E) intel_uncore_frequency_common(E) isst_if_common(E) sg(E) nfit(E) virtio_rng(E) rapl(E) i2c_piix4(E) input_leds(E) nfsd(E) sch_fq(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) tcp_bbr(E) binfmt_misc(E) ip_tables(E) xfs(E) libcrc32c(E) sd_mod(E) t10_pi(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) crc64(E) crct10dif_pclmul(E) crc32_pclmul(E) virtio_scsi(E) crc32c_intel(E) ghash_clmulni_intel(E) 8021q(E) garp(E) mrp(E) virtio_pci(E) scsi_transport_iscsi(E) virtio_pci_legacy_dev(E) aesni_intel(E) virtio_pci_modern_dev(E) crypto_simd(E) virtio_ring(E) cryptd(E) gve(E) serio_raw(E) virtio(E) sunrpc(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E) fuse(E)
> [106412.646242] CR2: 0000000000000020
> [106412.649780] ---[ end trace 0000000000000000 ]---
> [106412.654617] RIP: 0010:nlmclnt_setlockargs+0x4a/0x100 [lockd]
> [106412.660495] Code: 00 00 49 81 c0 88 00 00 00 f0 0f c1 05 bf 06 01 00 83 c0 01 c7 47 30 04 00 00 00 48 8d 4f 44 48 8d 7f 4c 89 47 c4 48 8b 46 78 <48> 8b 40 20 48 8b 90 60 fe ff ff 48 8d b0 60 fe ff ff 48 89 57 f8
> [106412.679481] RSP: 0018:ffffb3db50cdfa80 EFLAGS: 00010202
> [106412.684922] RAX: 0000000000000000 RBX: ffff8a36749c9400 RCX: ffff8a36749c9444
> [106412.692269] RDX: ffff8a37f8696300 RSI: ffffb3db50cdfbd8 RDI: ffff8a36749c944c
> [106412.699617] RBP: ffffb3db50cdfa90 R08: ffff8a750b49bc88 R09: ffff8a37f8696300
> [106412.706969] R10: 0000000000000230 R11: ffffffffffffffff R12: ffffb3db50cdfbd8
> [106412.714329] R13: ffff8a7508beac00 R14: ffffb3db50cdfca0 R15: ffffb3db50cdfbd8
> [106412.721676] FS:  0000000000000000(0000) GS:ffff8a73ffa80000(0000) knlGS:0000000000000000
> [106412.729981] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [106412.736472] CR2: 0000000000000020 CR3: 00000001118e6006 CR4: 00000000003706e0
> [106412.743821] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [106412.751171] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [106412.758520] Kernel panic - not syncing: Fatal exception
> [106412.764850] Kernel Offset: 0x30000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [106412.775850] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> 
> All I know is that I didn't notice this crash from v5.12 to v5.16 but
> I have not been able to test this qualitatively yet. The crash is
> rare enough that it makes A/B testing quite tricky.
> 
> It's somewhat similar to
> https://bugzilla.kernel.org/show_bug.cgi?id=213273 but that was for a
> NFv4.2 re-export of NFSv3 and this is for a NFSv3 re-export of NFSv3
> (for WAN caching).
> 
> We are using nfs-utils-2.5.4.
> 
> Daire

See the ticket for more details.

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v5.17..v5.18
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
