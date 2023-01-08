Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B2266142C
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 09:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjAHIv0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 03:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjAHIvZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 03:51:25 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE8A10A0
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 00:50:57 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pEROJ-0005my-Fr; Sun, 08 Jan 2023 09:50:55 +0100
Message-ID: <094d2d21-7a89-4368-09c2-4d84100598a1@leemhuis.info>
Date:   Sun, 8 Jan 2023 09:50:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: NFSD: refcount_t: underflow; use-after-free from nfsd_file_free
Content-Language: en-US, de-DE
To:     dai.ngo@oracle.com, Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@redhat.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <3c525b04-ef64-2bee-efc9-9a43069306f7@oracle.com>
 <830543ab-10e0-3a62-c683-8bd95292db4b@oracle.com>
From:   "Linux kernel regression tracking (#adding)" 
        <regressions@leemhuis.info>
Reply-To: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <830543ab-10e0-3a62-c683-8bd95292db4b@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673167857;57c082ae;
X-HE-SMSGID: 1pEROJ-0005my-Fr
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; all text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 07.01.23 23:04, dai.ngo@oracle.com wrote:
> Hi,
> 
> This is a regression in 6.2.0-rc1.
> 
> The problem can be reproduced with a simple test:
> . client mounts server's export using 4.1
> . client cats a file on server's export
> . on server stop nfs-server service
> 
> Bisect points to commit ac3a2585f018 (nfsd: rework refcounting in
> filecache)

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced ac3a2585f018
#regzbot title NFSD: refcount_t: underflow; use-after-free from
nfsd_file_free
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

> Jan  7 12:15:56 nfsvmf14 kernel: ------------[ cut here ]------------
> Jan  7 12:15:56 nfsvmf14 kernel: refcount_t: underflow; use-after-free.
> Jan  7 12:15:56 nfsvmf14 kernel: WARNING: CPU: 0 PID: 10420 at
> lib/refcount.c:28 refcount_warn_saturate+0xb3/0x100
> Jan  7 12:15:56 nfsvmf14 kernel: Modules linked in: rpcsec_gss_krb5
> btrfs blake2b_generic xor raid6_pq zstd_compress intel_powerclamp sg
> nfsd nfs_acl auth_rpcgss lockd grace sunrpc xfs dm_mirror dm_region_hash
> dm_log dm_mod
> Jan  7 12:15:56 nfsvmf14 kernel: CPU: 0 PID: 10420 Comm: rpc.nfsd Kdump:
> loaded Tainted: G        W          6.2.0-rc1 #1
> Jan  7 12:15:56 nfsvmf14 kernel: Hardware name: innotek GmbH
> VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> Jan  7 12:15:56 nfsvmf14 kernel: RIP:
> 0010:refcount_warn_saturate+0xb3/0x100
> Jan  7 12:15:56 nfsvmf14 kernel: Code: 01 01 e8 3f 21 65 00 0f 0b c3 cc
> cc cc cc 80 3d f5 d1 4a 01 00 75 5b 48 c7 c7 c3 4b 22 82 c6 05 e5 d1 4a
> 01 01 e8 1c 21 65 00 <0f> 0b c3 cc cc cc cc 80 3d d1 d1 4a 01 00 75 38
> 48 c7 c7 eb 4b 22
> Jan  7 12:15:56 nfsvmf14 kernel: RSP: 0018:ffffc9000078fc98 EFLAGS:
> 00010282
> Jan  7 12:15:56 nfsvmf14 kernel: RAX: 0000000000000000 RBX:
> ffff88810e8a9930 RCX: 0000000000000027
> Jan  7 12:15:56 nfsvmf14 kernel: RDX: 00000000ffff7fff RSI:
> 0000000000000003 RDI: ffff888217c1c640
> Jan  7 12:15:56 nfsvmf14 kernel: RBP: ffff88810cbd7870 R08:
> 0000000000000000 R09: ffffffff827d9f88
> Jan  7 12:15:56 nfsvmf14 kernel: R10: 00000000756f6366 R11:
> 0000000063666572 R12: ffff888111c9c000
> Jan  7 12:15:56 nfsvmf14 kernel: R13: ffff88810fb5fa00 R14:
> ffff88810f980058 R15: ffff88810e6d68b0
> Jan  7 12:15:56 nfsvmf14 kernel: FS:  00007fa614d16840(0000)
> GS:ffff888217c00000(0000) knlGS:0000000000000000
> Jan  7 12:15:56 nfsvmf14 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Jan  7 12:15:56 nfsvmf14 kernel: CR2: 0000559a53e66908 CR3:
> 0000000110c72000 CR4: 00000000000406f0
> Jan  7 12:15:56 nfsvmf14 kernel: Call Trace:
> Jan  7 12:15:56 nfsvmf14 kernel: <TASK>
> Jan  7 12:15:56 nfsvmf14 kernel:
> __refcount_sub_and_test.constprop.0+0x2b/0x36 [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: nfsd_file_free+0x119/0x182 [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: destroy_unhashed_deleg+0x65/0x8e [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: __destroy_client+0xc3/0x1ea [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: nfs4_state_shutdown_net+0x12c/0x236 [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: nfsd_shutdown_net+0x35/0x58 [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: nfsd_put+0xbf/0x117 [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: nfsd_svc+0x2d0/0x2f2 [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: write_threads+0x6d/0xb9 [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: ? write_versions+0x333/0x333 [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: nfsctl_transaction_write+0x4f/0x6b [nfsd]
> Jan  7 12:15:56 nfsvmf14 kernel: vfs_write+0xdb/0x1e5
> Jan  7 12:15:56 nfsvmf14 kernel: ? kmem_cache_free+0xf1/0x186
> Jan  7 12:15:56 nfsvmf14 kernel: ? do_sys_openat2+0xcd/0xf5
> Jan  7 12:15:56 nfsvmf14 kernel: ? __fget_light+0x2d/0x78
> Jan  7 12:15:56 nfsvmf14 kernel: ksys_write+0x76/0xc3
> Jan  7 12:15:56 nfsvmf14 kernel: do_syscall_64+0x56/0x71
> Jan  7 12:15:56 nfsvmf14 kernel: entry_SYSCALL_64_after_hwframe+0x63/0xcd
> Jan  7 12:15:56 nfsvmf14 kernel: RIP: 0033:0x7fa6142efa00
> Jan  7 12:15:56 nfsvmf14 kernel: Code: 73 01 c3 48 8b 0d 70 74 2d 00 f7
> d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d bd d5 2d 00 00 75 10
> b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ee cb
> 01 00 48 89 04 24
> Jan  7 12:15:56 nfsvmf14 kernel: RSP: 002b:00007ffc79bf4748 EFLAGS:
> 00000246 ORIG_RAX: 0000000000000001
> Jan  7 12:15:56 nfsvmf14 kernel: RAX: ffffffffffffffda RBX:
> 0000000000000003 RCX: 00007fa6142efa00
> Jan  7 12:15:56 nfsvmf14 kernel: RDX: 0000000000000002 RSI:
> 000055d4cb8093e0 RDI: 0000000000000003
> Jan  7 12:15:56 nfsvmf14 kernel: RBP: 000055d4cb8093e0 R08:
> 0000000000000000 R09: 00007fa61424d2cd
> Jan  7 12:15:56 nfsvmf14 kernel: R10: 0000000000000004 R11:
> 0000000000000246 R12: 0000000000000000
> Jan  7 12:15:56 nfsvmf14 kernel: R13: 0000000000000000 R14:
> 0000000000000000 R15: 000000000000001f
> Jan  7 12:15:56 nfsvmf14 kernel: </TASK>
> Jan  7 12:15:56 nfsvmf14 kernel: ---[ end trace 0000000000000000 ]---
> 
