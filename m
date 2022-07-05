Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8934E567857
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jul 2022 22:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiGEU1a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jul 2022 16:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiGEU12 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jul 2022 16:27:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DFD19C04;
        Tue,  5 Jul 2022 13:27:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFC7AB8182D;
        Tue,  5 Jul 2022 20:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7352C341C8;
        Tue,  5 Jul 2022 20:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657052844;
        bh=hJBwfHY3NLsv45jOTmX0/Q84ZKqejyx5QD143ewRGAc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jDwZHe4Pt+B9R5GnfoNZh08uQuMgkGkeO+9dWu7qK0gn2ruPEyr8ZMhplyMVfLA00
         R7FXViK9N3jz/UvstIcQhyS5PL4/TE1AIph1ogWl4ytqrk9qqxspGNMaVjtCbuzeq7
         OStjp4GW+rcflKvsl73nzCs1g9WTAtEH/E4/jbOz2FAcezmZ/6KJkQs87lU3M7BNsf
         S0RhsT3t/9cHlaVhf6kJEWGZAJZn17QYV7QHImtR4wfmhffPQHsesIeVzKlyZUJdWE
         0+vWuD9HL8//G2U4Y0mITqcMZyiQa129bpoXYvhLtnPTgG79V6VdR10ZEavZr7Sy9t
         kLpQt05tsMBFg==
Received: by mail-qt1-f179.google.com with SMTP id r2so15443625qta.0;
        Tue, 05 Jul 2022 13:27:24 -0700 (PDT)
X-Gm-Message-State: AJIora9BXPu1FhbbipUmDYdzmQoj95oebEua3MHi86xvabXW9xvxK9d/
        tfQYd/hDJjbQKt65DCHB7hX+CCZ4O70eldrMrfk=
X-Google-Smtp-Source: AGRyM1sp+xRVwoaGxHQtp1Ncu7XT/PD30rY3iBTs6QILk/9CR6ELXk49Ms9KBP74smAkD/qOOlOymweZtHrZCs5q1CE=
X-Received: by 2002:a05:622a:174e:b0:319:5b72:173b with SMTP id
 l14-20020a05622a174e00b003195b72173bmr30279598qtk.13.1657052843621; Tue, 05
 Jul 2022 13:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <c09e1af7-7d1f-1bbf-5562-ead9a4d99562@oracle.com>
In-Reply-To: <c09e1af7-7d1f-1bbf-5562-ead9a4d99562@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 5 Jul 2022 21:26:47 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7Jm034yfVYJDzugWHPamvnKU=7XSb=38ey+-L_qdd=OA@mail.gmail.com>
Message-ID: <CAL3q7H7Jm034yfVYJDzugWHPamvnKU=7XSb=38ey+-L_qdd=OA@mail.gmail.com>
Subject: Re: bug in btrfs during low memory testing.
To:     dai.ngo@oracle.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, gniebler@suse.com,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 5, 2022 at 9:18 PM <dai.ngo@oracle.com> wrote:
>
> Hi,
>
> During my low memory testing with 5.19.0-rc4, I ran into this
> problem in btrfs where the thread tries to sleep on invalid
> context:
>
>
> Jul  3 04:08:44 nfsvmf24 kernel: BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> Jul  3 04:08:44 nfsvmf24 kernel: in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4308, name: nfsd
> Jul  3 04:08:44 nfsvmf24 kernel: preempt_count: 1, expected: 0
> Jul  3 04:08:44 nfsvmf24 kernel: RCU nest depth: 0, expected: 0
> Jul  3 04:08:44 nfsvmf24 kernel: 4 locks held by nfsd/4308:
> Jul  3 04:08:44 nfsvmf24 kernel: #0: ffff8881052d4438 (sb_writers#14){.+.+}-{0:0}, at: nfsd4_setattr+0x17f/0x3c0 [nfsd]
> Jul  3 04:08:44 nfsvmf24 kernel: #1: ffff888141e5aa50 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}, at:  nfsd_setattr+0x56a/0xe00 [nfsd]
> Jul  3 04:08:44 nfsvmf24 kernel: #2: ffff8881052d4628 (sb_internal#2){.+.+}-{0:0}, at: btrfs_dirty_inode+0xda/0x1d0
> Jul  3 04:08:44 nfsvmf24 kernel: #3: ffff888105ed6628 (&root->inode_lock){+.+.}-{2:2}, at: btrfs_get_or_create_delayed_node+0x27a/0x430
>
> Jul  3 04:08:44 nfsvmf24 kernel: Preemption disabled at:
> Jul  3 04:08:44 nfsvmf24 kernel: [<0000000000000000>] 0x0
> Jul  3 04:08:44 nfsvmf24 kernel: CPU: 0 PID: 4308 Comm: nfsd Kdump: loaded Not tainted 5.19.0-rc4+ #1
> Jul  3 04:08:44 nfsvmf24 kernel: Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> Jul  3 04:08:45 nfsvmf24 kernel: Call Trace:
> Jul  3 04:08:45 nfsvmf24 kernel: <TASK>
> Jul  3 04:08:45 nfsvmf24 kernel: dump_stack_lvl+0x57/0x7d
> Jul  3 04:08:45 nfsvmf24 kernel: __might_resched.cold+0x222/0x26b
> Jul  3 04:08:45 nfsvmf24 kernel: kmem_cache_alloc_lru+0x159/0x2c0
> Jul  3 04:08:45 nfsvmf24 kernel: __xas_nomem+0x1a5/0x5d0
> Jul  3 04:08:45 nfsvmf24 kernel: ? lock_acquire+0x1bb/0x500
> Jul  3 04:08:45 nfsvmf24 kernel: __xa_insert+0xff/0x1d0
> Jul  3 04:08:45 nfsvmf24 kernel: ? __xa_cmpxchg+0x1f0/0x1f0
> Jul  3 04:08:45 nfsvmf24 kernel: ? lockdep_init_map_type+0x2c3/0x7b0
> Jul  3 04:08:45 nfsvmf24 kernel: ? rwlock_bug.part.0+0x90/0x90
> Jul  3 04:08:45 nfsvmf24 kernel: btrfs_get_or_create_delayed_node+0x295/0x430
> Jul  3 04:08:45 nfsvmf24 kernel: btrfs_delayed_update_inode+0x24/0x670
> Jul  3 04:08:45 nfsvmf24 kernel: ? btrfs_check_and_init_root_item+0x1f0/0x1f0
> Jul  3 04:08:45 nfsvmf24 kernel: ? start_transaction+0x219/0x12d0
> Jul  3 04:08:45 nfsvmf24 kernel: btrfs_update_inode+0x1aa/0x430
> Jul  3 04:08:45 nfsvmf24 kernel: btrfs_dirty_inode+0xf7/0x1d0
> Jul  3 04:08:45 nfsvmf24 kernel: btrfs_setattr+0x928/0x1400
> Jul  3 04:08:45 nfsvmf24 kernel: ? mark_held_locks+0x9e/0xe0
> Jul  3 04:08:45 nfsvmf24 kernel: ? _raw_spin_unlock+0x29/0x40
> Jul  3 04:08:45 nfsvmf24 kernel: ? btrfs_cont_expand+0x9a0/0x9a0
> Jul  3 04:08:45 nfsvmf24 kernel: ? fh_update+0x1e0/0x1e0 [nfsd]
> Jul  3 04:08:45 nfsvmf24 kernel: ? current_time+0x88/0xd0
> Jul  3 04:08:45 nfsvmf24 kernel: ? timestamp_truncate+0x230/0x230
> Jul  3 04:08:45 nfsvmf24 kernel: notify_change+0x4b3/0xe40
> Jul  3 04:08:45 nfsvmf24 kernel: ? down_write_nested+0xd4/0x130
> Jul  3 04:08:45 nfsvmf24 kernel: ? nfsd_setattr+0x984/0xe00 [nfsd]
> Jul  3 04:08:45 nfsvmf24 kernel: nfsd_setattr+0x984/0xe00 [nfsd]
> Jul  3 04:08:45 nfsvmf24 kernel: ? lock_downgrade+0x680/0x680
> Jul  3 04:08:45 nfsvmf24 kernel: ? nfsd_permission+0x310/0x310 [nfsd]
> Jul  3 04:08:45 nfsvmf24 kernel: ? __mnt_want_write+0x192/0x270
> Jul  3 04:08:45 nfsvmf24 kernel: nfsd4_setattr+0x1df/0x3c0 [nfsd]
> Jul  3 04:08:45 nfsvmf24 kernel: ? percpu_counter_add_batch+0x79/0x130
> Jul  3 04:08:45 nfsvmf24 kernel: nfsd4_proc_compound+0xce8/0x23e0 [nfsd]
> Jul  3 04:08:45 nfsvmf24 kernel: nfsd_dispatch+0x4ed/0xc10 [nfsd]
> Jul  3 04:08:45 nfsvmf24 kernel: ? svc_reserve+0xb5/0x130 [sunrpc]
> Jul  3 04:08:45 nfsvmf24 kernel: svc_process_common+0xd3f/0x1b00 [sunrpc]
> Jul  3 04:08:45 nfsvmf24 kernel: ? svc_generic_rpcbind_set+0x4d0/0x4d0 [sunrpc]
> Jul  3 04:08:45 nfsvmf24 kernel: ? nfsd_svc+0xc50/0xc50 [nfsd]
> Jul  3 04:08:45 nfsvmf24 kernel: ? svc_sock_secure_port+0x37/0x50 [sunrpc]
> Jul  3 04:08:45 nfsvmf24 kernel: ? svc_recv+0x1096/0x2350 [sunrpc]
> Jul  3 04:08:45 nfsvmf24 kernel: svc_process+0x361/0x4f0 [sunrpc]
> Jul  3 04:08:45 nfsvmf24 kernel: nfsd+0x2d6/0x570 [nfsd]
> Jul  3 04:08:45 nfsvmf24 kernel: ? nfsd_shutdown_threads+0x2a0/0x2a0 [nfsd]
> Jul  3 04:08:45 nfsvmf24 kernel: kthread+0x2a1/0x340
> Jul  3 04:08:45 nfsvmf24 kernel: ? kthread_complete_and_exit+0x20/0x20
> Jul  3 04:08:45 nfsvmf24 kernel: ret_from_fork+0x22/0x30
> Jul  3 04:08:45 nfsvmf24 kernel: </TASK>
> Jul  3 04:08:45 nfsvmf24 kernel:
>
>
> I think the problem was introduced by commit 253bf57555e
> btrfs: turn delayed_nodes_tree into an XArray.
>
> The spin_lock(&root->inode_lock) was held while xa_insert tries
> to allocate memory and block.

Yep.

In this case we can actually call xa_insert() without holding that
spinlock, it's safe against other concurrent calls to
btrfs_get_or_create_delayed_node(), btrfs_get_delayed_node(),
btrfs_kill_delayed_inode_items(), etc.

However, looking at xa_insert() we have:

        xa_lock(xa);
        err = __xa_insert(xa, index, entry, gfp);
        xa_unlock(xa);

And xa_lock() is defined as:

        #define xa_lock(xa)             spin_lock(&(xa)->xa_lock)

So we'll always be under a spinlock even if we change btrfs to not
take the root->inode_lock spinlock.

This seems more like a general problem outside btrfs' control.
So CC'ing Willy to double check.

We have another place in btrfs that calls xa_insert() while holding some
btrfs spinlock too.

Thanks.

>
> -Dai
>
