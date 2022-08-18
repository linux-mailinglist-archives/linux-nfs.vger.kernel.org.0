Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D335598B54
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Aug 2022 20:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiHRSjF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Aug 2022 14:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbiHRSjE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Aug 2022 14:39:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D980696CA
        for <linux-nfs@vger.kernel.org>; Thu, 18 Aug 2022 11:39:01 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gk3so4811841ejb.8
        for <linux-nfs@vger.kernel.org>; Thu, 18 Aug 2022 11:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=cXetT0Bf2OixtNh/mQyPp7Zfz8aI+Iq0bVKTs6TYlQU=;
        b=B1tRRm2sdQYbGYEI35RwkS1eeIrART6siHwF6ZDpSIIO9fKMBdhfO1tBjx1rXPkzBX
         GbBZpAJJhlhfIrULY9NXds42kgB55RvjSFIIO3pDn75zxRztADPu4i/T+2BnX7rDHX9t
         SCZPVa55aEUq5d018umEyDemJ76u75eqcglZ0FD5iI4u1qLkahk1KdAkCMGClZ4spM0T
         yJzZqVtRU2ulsmfdPkH5cZTs8+hKF2EQOBZFhY2Ns24GjWHD0RU3r/63oWNRc+PBeJs7
         54rA/PFT9y9ZZi7JaEvnLCQGtApILaqcbMapF4TXPyEuV6ESVqhP4APOih5avvjiHldE
         il3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cXetT0Bf2OixtNh/mQyPp7Zfz8aI+Iq0bVKTs6TYlQU=;
        b=iPnWyz5VK6XdWmmxD15yJVCPDEpC21RVT3fHIOXOFn+GPYjdT0Iy83fGBIRR+7nwFW
         zbnDpUwIGA3yYNCx/yEP47tAyAmyc76oF/9t74KiAz6H4sKKzay4EA7BWpYXuIZ7nAAD
         b9y/waW0Lx/fi/CUESHvZ2C2SSsZeNL0Nr9DHCjgRs5QVZqWWBut6agLciNAMRwdO8yX
         Llsh7rSaOl4vQ3qnQ7tN53Gvv3tzCs7mvfyfB+aSF0SIHVEhiYy3t9HRSoJleMlbXP4m
         Me0mudKjGbnsNGvXo1qiRWWzlBkt5uk015ZQHVL3Ql5opfFlGblbyZH36fEow6WPtkV9
         u0gg==
X-Gm-Message-State: ACgBeo0g+bc4pshJ0Mct+RUPdIVDDUxGNDHUJ4MGP7q8uEAyyTtwp6qz
        OaDNPDBJ5qv80yj/rXs5jHttbHtljLweq0NObWG4VUaY
X-Google-Smtp-Source: AA6agR66oItjo23sFMs4sAthsx7LR6T1VJMnmP2ITG8KSLyzXI6vqzIv10ycpCTgf5HTAYRdujtmfLAmdrhagzcS8jw=
X-Received: by 2002:a17:907:288a:b0:730:7f77:9550 with SMTP id
 em10-20020a170907288a00b007307f779550mr2603118ejc.216.1660847939982; Thu, 18
 Aug 2022 11:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <7634.1660728564@jrobl> <166079133167.5425.16635199337074058478@noble.neil.brown.name>
 <9451.1660793491@jrobl>
In-Reply-To: <9451.1660793491@jrobl>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 18 Aug 2022 14:38:48 -0400
Message-ID: <CAN-5tyFgJMc9O0ff=qtyg8NHF16YbkmTCH6rpVFTBs7mKBiRKA@mail.gmail.com>
Subject: Re: NFS, two d_delete() calls in nfs_unlink()
To:     hooanon05g@gmail.com
Cc:     NeilBrown <neilb@suse.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 17, 2022 at 11:47 PM <hooanon05g@gmail.com> wrote:
>
> "NeilBrown":
> > Thanks for the report.
> > This possibility of calling d_delete() twice has been present
> > since  9019fb391de0 in v5.16.
>
> I don't think 9019fb391de0 is a problem.
> Before v6.0-rc1, the target dentry was unhashed by __d_drop() call in
> nfs_unlink(), and nfs_dentry_handle_enoent() skipped calling d_delete()
> by simple_positive(). d_delete() was called only once via
> nfs_dentry_remove_handle_error().
>
> In v6.0-rc1, the dentry is not unhashed and nfs_dentry_handle_enoent()
> doesn't skip calling d_delete().
>
>
> > How did you discover this bug, and why do you think my patch
> > caused it?
>
> I met this problem during a stress test aiming a filesystem I am
> developing.
> And I think unhashing causes nfs_dentry_handle_enoent() to call
> d_delete().
>
>

Hello folks,

Just to add my 2cents. Netapp testing is hitting this consistently. It
seems like it's the same thing. Client's kernel is based of Trond's
tree with the whatever is going into 6.0
commit 3fa5cbdc44de190f2c5605ba7db015ae0d26f668 (HEAD ->
08122022.1550-linux-next, tag: nfs-for-5.20-1, origin/linux-nex

I've then reverted Neil's patch and things went back to normal. Again
I'm not implying that the patch causes it but just stating this is hit
every time compared to before.

Aug 18 13:37:23 localhost kernel:
==================================================================
Aug 18 13:37:23 localhost kernel: BUG: KASAN: null-ptr-deref in
_raw_spin_lock+0x78/0xe0
Aug 18 13:37:23 localhost kernel: Write of size 4 at addr
0000000000000088 by task dt/12703
Aug 18 13:37:23 localhost kernel:
Aug 18 13:37:23 localhost kernel: CPU: 5 PID: 12703 Comm: dt Tainted:
G S                5.19.0-rc6+ #18
Aug 18 13:37:23 localhost kernel: Hardware name: Supermicro
SYS-5028R-WR/X10SRW-F, BIOS 3.2 11/22/2019
Aug 18 13:37:23 localhost kernel: Call Trace:
Aug 18 13:37:23 localhost kernel: <TASK>
Aug 18 13:37:23 localhost kernel: dump_stack_lvl+0x33/0x42
Aug 18 13:37:23 localhost kernel: ? _raw_spin_lock+0x78/0xe0
Aug 18 13:37:23 localhost kernel: print_report.cold.17+0x493/0x6b3
Aug 18 13:37:23 localhost kernel: ? start_report.constprop.11+0xdc/0x180
Aug 18 13:37:23 localhost kernel: ? _raw_spin_lock+0x78/0xe0
Aug 18 13:37:23 localhost kernel: kasan_report+0x83/0x100
Aug 18 13:37:23 localhost kernel: ? _raw_spin_lock+0x78/0xe0
Aug 18 13:37:23 localhost kernel: kasan_check_range+0x183/0x1e0
Aug 18 13:37:23 localhost kernel: _raw_spin_lock+0x78/0xe0
Aug 18 13:37:23 localhost kernel: BUG: kernel NULL pointer
dereference, address: 0000000000000088
Aug 18 13:37:23 localhost kernel: ? _raw_spin_lock_irqsave+0xf0/0xf0
Aug 18 13:37:23 localhost kernel: #PF: supervisor write access in kernel mode
Aug 18 13:37:23 localhost kernel: ? _raw_spin_lock_irqsave+0xf0/0xf0
Aug 18 13:37:23 localhost kernel: #PF: error_code(0x0002) - not-present page
Aug 18 13:37:23 localhost kernel: ? _atomic_dec_and_lock+0x1a/0x60
Aug 18 13:37:23 localhost kernel: PGD 8000000202253067 P4D 8000000202253067
Aug 18 13:37:23 localhost kernel: d_delete+0x2c/0x90
Aug 18 13:37:23 localhost kernel: PUD 202b67067 PMD 0
Aug 18 13:37:23 localhost kernel: nfs_dentry_remove_handle_error+0x21/0x60 [nfs]
Aug 18 13:37:23 localhost kernel: Oops: 0002 [#1] PREEMPT SMP KASAN PTI
Aug 18 13:37:23 localhost kernel: nfs_unlink+0x1c4/0x4a0 [nfs]
Aug 18 13:37:23 localhost kernel: CPU: 25 PID: 12182 Comm: dt Tainted:
G S                5.19.0-rc6+ #18
Aug 18 13:37:23 localhost kernel: vfs_unlink+0x1af/0x410
Aug 18 13:37:23 localhost kernel: Hardware name: Supermicro
SYS-5028R-WR/X10SRW-F, BIOS 3.2 11/22/2019
Aug 18 13:37:23 localhost kernel: ? __lookup_hash+0x1f/0xd0
Aug 18 13:37:23 localhost kernel: RIP: 0010:_raw_spin_lock+0x90/0xe0
Aug 18 13:37:23 localhost kernel: do_unlinkat+0x2c9/0x410
Aug 18 13:37:23 localhost kernel: Code: 00 00 48 89 df c7 44 24 20 00
00 00 00 e8 18 8f 42 ff be 04 00 00 00 48 8d 7c 24 20 e8 09 8f 42 ff
ba 01 00 00 00 8b 44 24 20 <f0> 0f b1 13 75 2a 48 b8 00 00 00 00 00 fc
ff df 48 c7 44 05 00 00
Aug 18 13:37:23 localhost kernel: ? __x64_sys_rmdir+0x30/0x30
Aug 18 13:37:23 localhost kernel: RSP: 0018:ffff888462f5fc88 EFLAGS: 00010297
Aug 18 13:37:23 localhost kernel: ? xfd_validate_state+0x34/0xb0
Aug 18 13:37:23 localhost kernel: RAX: 0000000000000000 RBX:
0000000000000088 RCX: ffffffff8cabd117
Aug 18 13:37:23 localhost kernel: ? __virt_addr_valid+0xd8/0x170
Aug 18 13:37:23 localhost kernel: RDX: 0000000000000001 RSI:
0000000000000004 RDI: ffff888462f5fca8
Aug 18 13:37:23 localhost kernel: ? __check_object_size+0x1b3/0x380
Aug 18 13:37:23 localhost kernel: RBP: 1ffff1108c5ebf91 R08:
0000000000000004 R09: ffffed108c5ebf95
Aug 18 13:37:23 localhost kernel: ? strncpy_from_user+0x178/0x1b0
Aug 18 13:37:23 localhost kernel: R10: 0000000000000003 R11:
ffffed108c5ebf95 R12: ffff8881803fac58
Aug 18 13:37:23 localhost kernel: ? getname_flags+0x10d/0x2a0
Aug 18 13:37:23 localhost kernel: R13: ffff88812b20e6b8 R14:
ffff88812b20e6b8 R15: ffff8881803fac30
Aug 18 13:37:23 localhost kernel: __x64_sys_unlink+0x2c/0x30
Aug 18 13:37:23 localhost kernel: FS:  00007fdb273f3700(0000)
GS:ffff889bff280000(0000) knlGS:0000000000000000
Aug 18 13:37:23 localhost kernel: do_syscall_64+0x3a/0x80
Aug 18 13:37:23 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Aug 18 13:37:23 localhost kernel: entry_SYSCALL_64_after_hwframe+0x46/0xb0
Aug 18 13:37:23 localhost kernel: CR2: 0000000000000088 CR3:
00000001ab930002 CR4: 00000000003706e0
Aug 18 13:37:23 localhost kernel: RIP: 0033:0x7f279543960b
Aug 18 13:37:23 localhost kernel: DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Aug 18 13:37:23 localhost kernel: Code: f0 ff ff 73 01 c3 48 8b 0d 7a
58 38 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f
1e fa b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4d 58
38 00 f7 d8 64 89 01 48
Aug 18 13:37:23 localhost kernel: DR3: 0000000000000000 DR6:
00000000fffe0ff0 DR7: 0000000000000400
Aug 18 13:37:23 localhost kernel: RSP: 002b:00007f2794ef9df8 EFLAGS: 00000202
Aug 18 13:37:23 localhost kernel: Call Trace:
Aug 18 13:37:23 localhost kernel: ORIG_RAX: 0000000000000057
Aug 18 13:37:23 localhost kernel: RAX: ffffffffffffffda RBX:
0000000001add1d8 RCX: 00007f279543960b
Aug 18 13:37:23 localhost kernel: <TASK>
Aug 18 13:37:23 localhost kernel: RDX: 000000000048433d RSI:
000000000048433d RDI: 00007f272c000d30
Aug 18 13:37:23 localhost kernel: ? _raw_spin_lock_irqsave+0xf0/0xf0
Aug 18 13:37:23 localhost kernel: RBP: 0000000001ad6890 R08:
0000000000000000 R09: 00007f2794ef9ba6
Aug 18 13:37:23 localhost kernel: ? _raw_spin_lock_irqsave+0xf0/0xf0
Aug 18 13:37:23 localhost kernel: R10: 0000000000000000 R11:
0000000000000202 R12: 000000000000001a
Aug 18 13:37:23 localhost kernel: ? _atomic_dec_and_lock+0x1a/0x60
Aug 18 13:37:23 localhost kernel: R13: 000000000000001a R14:
00007f272c000b90 R15: 00007f272c000d30
Aug 18 13:37:23 localhost kernel: d_delete+0x2c/0x90
Aug 18 13:37:23 localhost kernel: </TASK>
Aug 18 13:37:23 localhost kernel: nfs_dentry_remove_handle_error+0x21/0x60 [nfs]
Aug 18 13:37:23 localhost kernel:
==================================================================
Aug 18 13:37:23 localhost kernel: nfs_unlink+0x1c4/0x4a0 [nfs]
Aug 18 13:37:23 localhost kernel: vfs_unlink+0x1af/0x410
