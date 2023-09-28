Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A527B222E
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Sep 2023 18:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjI1QYQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Sep 2023 12:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjI1QYP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Sep 2023 12:24:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601B4D6;
        Thu, 28 Sep 2023 09:24:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029FFC433C9;
        Thu, 28 Sep 2023 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695918253;
        bh=nSsFg9gBOgHo6K+o4FY180uPOYofhuhXZxdExYGTrcU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DmKfGNrnvpamclpaC1d53OHY3HsVNEM28fV5Zs3o5ZA+EppQqT9dsFre5u6TKy77c
         2RWnxmSaqk+kkQxNZ4a1aja+BHn19iTie4c/fWLavvJnkNjrWi2q9sKlvCec51dPNT
         N/riB64XUqPFc8xxghQ+MmIjcXWnuXwkF8mKcqCFLSf7MrG9bdPCxf6ofxS47aY7rE
         RWm7L5VRb503+oXw4FaMtyNNgLODznmo9SRevG7tJzElwh6eTTx7hF0SQRjRWliasW
         cZoDFLZz1LWdZrR+l8Go/xnd97vpdIbIU8aPSAqm4t9tKp0dOO2litQpmlSyIcM2JP
         8SDvZ1bzcsKyw==
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7740cedd4baso878046585a.2;
        Thu, 28 Sep 2023 09:24:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YxZm/tD3f4mW3irRS8Bzq+YqHqT7m060oZrT/ywtL38fHYi7ix0
        mgoXJZwqJDGoSitunivGQA4JzDXDIWzOEXKFHj8=
X-Google-Smtp-Source: AGHT+IEqiddpvIHbjeYiL54gHAf2GS3kQ/TkS+7758IcTgNs+1QAkfiqsTlj2A/AevTwoCpuhFMAGhaq7OdYxrqVreg=
X-Received: by 2002:ac8:5fc5:0:b0:417:a095:60ab with SMTP id
 k5-20020ac85fc5000000b00417a09560abmr2039453qta.50.1695918252184; Thu, 28 Sep
 2023 09:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230919-nfs-fixes-v1-1-d22bf72e05ad@kernel.org>
 <69c748d58f834b80abda5dcd291ee29ea1cafaf7.camel@hammerspace.com>
 <ZRSbuY+mhgBqGdn3@aion> <3C9D081E-E698-4F8B-B2BB-8A1EC9C20871@redhat.com> <0C77F0B3-9D42-4BE7-AD56-1BF7EDBF3729@redhat.com>
In-Reply-To: <0C77F0B3-9D42-4BE7-AD56-1BF7EDBF3729@redhat.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Thu, 28 Sep 2023 12:23:56 -0400
X-Gmail-Original-Message-ID: <CAFX2JfkE8yhBm8kkm5u74q7grFEg8+YSfdhokTn4K=zXPHHowg@mail.gmail.com>
Message-ID: <CAFX2JfkE8yhBm8kkm5u74q7grFEg8+YSfdhokTn4K=zXPHHowg@mail.gmail.com>
Subject: Re: [PATCH] nfs: decrement nrequests counter before releasing the req
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Scott Mayhew <smayhew@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 28, 2023 at 9:31=E2=80=AFAM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 28 Sep 2023, at 9:04, Benjamin Coddington wrote:
>
> > On 27 Sep 2023, at 17:16, Scott Mayhew wrote:
> >
> >> On Wed, 27 Sep 2023, Trond Myklebust wrote:
> >>
> >>> On Tue, 2023-09-19 at 09:17 -0400, Jeff Layton wrote:
> >>>> I hit this panic in testing:
> >>>>
> >>>> [ 6235.500016] run fstests generic/464 at 2023-09-18 22:51:24
> >>>> [ 6288.410761] BUG: kernel NULL pointer dereference, address:
> >>>> 0000000000000000
> >>>> [ 6288.412174] #PF: supervisor read access in kernel mode
> >>>> [ 6288.413160] #PF: error_code(0x0000) - not-present page
> >>>> [ 6288.413992] PGD 0 P4D 0
> >>>> [ 6288.414603] Oops: 0000 [#1] PREEMPT SMP PTI
> >>>> [ 6288.415419] CPU: 0 PID: 340798 Comm: kworker/u18:8 Not tainted
> >>>> 6.6.0-rc1-gdcf620ceebac #95
> >>>> [ 6288.416538] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> >>>> BIOS 1.16.2-1.fc38 04/01/2014
> >>>> [ 6288.417701] Workqueue: nfsiod rpc_async_release [sunrpc]
> >>>> [ 6288.418676] RIP: 0010:nfs_inode_remove_request+0xc8/0x150 [nfs]
> >>>> [ 6288.419836] Code: ff ff 48 8b 43 38 48 8b 7b 10 a8 04 74 5b 48 85
> >>>> ff 74 56 48 8b 07 a9 00 00 08 00 74 58 48 8b 07 f6 c4 10 74 50 e8 c8
> >>>> 44 b3 d5 <48> 8b 00 f0 48 ff 88 30 ff ff ff 5b 5d 41 5c c3 cc cc cc
> >>>> cc 48 8b
> >>>> [ 6288.422389] RSP: 0018:ffffbd618353bda8 EFLAGS: 00010246
> >>>> [ 6288.423234] RAX: 0000000000000000 RBX: ffff9a29f9a25280 RCX:
> >>>> 0000000000000000
> >>>> [ 6288.424351] RDX: ffff9a29f9a252b4 RSI: 000000000000000b RDI:
> >>>> ffffef41448e3840
> >>>> [ 6288.425345] RBP: ffffef41448e3840 R08: 0000000000000038 R09:
> >>>> ffffffffffffffff
> >>>> [ 6288.426334] R10: 0000000000033f80 R11: ffff9a2a7fffa000 R12:
> >>>> ffff9a29093f98c4
> >>>> [ 6288.427353] R13: 0000000000000000 R14: ffff9a29230f62e0 R15:
> >>>> ffff9a29230f62d0
> >>>> [ 6288.428358] FS:  0000000000000000(0000) GS:ffff9a2a77c00000(0000)
> >>>> knlGS:0000000000000000
> >>>> [ 6288.429513] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>> [ 6288.430427] CR2: 0000000000000000 CR3: 0000000264748002 CR4:
> >>>> 0000000000770ef0
> >>>> [ 6288.431553] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> >>>> 0000000000000000
> >>>> [ 6288.432715] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> >>>> 0000000000000400
> >>>> [ 6288.433698] PKRU: 55555554
> >>>> [ 6288.434196] Call Trace:
> >>>> [ 6288.434667]  <TASK>
> >>>> [ 6288.435132]  ? __die+0x1f/0x70
> >>>> [ 6288.435723]  ? page_fault_oops+0x159/0x450
> >>>> [ 6288.436389]  ? try_to_wake_up+0x98/0x5d0
> >>>> [ 6288.437044]  ? do_user_addr_fault+0x65/0x660
> >>>> [ 6288.437728]  ? exc_page_fault+0x7a/0x180
> >>>> [ 6288.438368]  ? asm_exc_page_fault+0x22/0x30
> >>>> [ 6288.439137]  ? nfs_inode_remove_request+0xc8/0x150 [nfs]
> >>>> [ 6288.440112]  ? nfs_inode_remove_request+0xa0/0x150 [nfs]
> >>>> [ 6288.440924]  nfs_commit_release_pages+0x16e/0x340 [nfs]
> >>>> [ 6288.441700]  ? __pfx_call_transmit+0x10/0x10 [sunrpc]
> >>>> [ 6288.442475]  ? _raw_spin_lock_irqsave+0x23/0x50
> >>>> [ 6288.443161]  nfs_commit_release+0x15/0x40 [nfs]
> >>>> [ 6288.443926]  rpc_free_task+0x36/0x60 [sunrpc]
> >>>> [ 6288.444741]  rpc_async_release+0x29/0x40 [sunrpc]
> >>>> [ 6288.445509]  process_one_work+0x171/0x340
> >>>> [ 6288.446135]  worker_thread+0x277/0x3a0
> >>>> [ 6288.446724]  ? __pfx_worker_thread+0x10/0x10
> >>>> [ 6288.447376]  kthread+0xf0/0x120
> >>>> [ 6288.447903]  ? __pfx_kthread+0x10/0x10
> >>>> [ 6288.448500]  ret_from_fork+0x2d/0x50
> >>>> [ 6288.449078]  ? __pfx_kthread+0x10/0x10
> >>>> [ 6288.449665]  ret_from_fork_asm+0x1b/0x30
> >>>> [ 6288.450283]  </TASK>
> >>>> [ 6288.450688] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4
> >>>> dns_resolver nfs lockd grace sunrpc nls_iso8859_1 nls_cp437 vfat fat
> >>>> 9p netfs ext4 kvm_intel crc16 mbcache jbd2 joydev kvm xfs irqbypass
> >>>> virtio_net pcspkr net_failover psmouse failover 9pnet_virtio cirrus
> >>>> drm_shmem_helper virtio_balloon drm_kms_helper button evdev drm loop
> >>>> dm_mod zram zsmalloc crct10dif_pclmul crc32_pclmul
> >>>> ghash_clmulni_intel sha512_ssse3 sha512_generic virtio_blk nvme
> >>>> aesni_intel crypto_simd cryptd nvme_core t10_pi i6300esb
> >>>> crc64_rocksoft_generic crc64_rocksoft crc64 virtio_pci virtio
> >>>> virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring serio_raw
> >>>> btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel xor
> >>>> raid6_pq autofs4
> >>>> [ 6288.460211] CR2: 0000000000000000
> >>>> [ 6288.460787] ---[ end trace 0000000000000000 ]---
> >>>> [ 6288.461571] RIP: 0010:nfs_inode_remove_request+0xc8/0x150 [nfs]
> >>>> [ 6288.462500] Code: ff ff 48 8b 43 38 48 8b 7b 10 a8 04 74 5b 48 85
> >>>> ff 74 56 48 8b 07 a9 00 00 08 00 74 58 48 8b 07 f6 c4 10 74 50 e8 c8
> >>>> 44 b3 d5 <48> 8b 00 f0 48 ff 88 30 ff ff ff 5b 5d 41 5c c3 cc cc cc
> >>>> cc 48 8b
> >>>> [ 6288.465136] RSP: 0018:ffffbd618353bda8 EFLAGS: 00010246
> >>>> [ 6288.465963] RAX: 0000000000000000 RBX: ffff9a29f9a25280 RCX:
> >>>> 0000000000000000
> >>>> [ 6288.467035] RDX: ffff9a29f9a252b4 RSI: 000000000000000b RDI:
> >>>> ffffef41448e3840
> >>>> [ 6288.468093] RBP: ffffef41448e3840 R08: 0000000000000038 R09:
> >>>> ffffffffffffffff
> >>>> [ 6288.469121] R10: 0000000000033f80 R11: ffff9a2a7fffa000 R12:
> >>>> ffff9a29093f98c4
> >>>> [ 6288.470109] R13: 0000000000000000 R14: ffff9a29230f62e0 R15:
> >>>> ffff9a29230f62d0
> >>>> [ 6288.471106] FS:  0000000000000000(0000) GS:ffff9a2a77c00000(0000)
> >>>> knlGS:0000000000000000
> >>>> [ 6288.472216] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>> [ 6288.473059] CR2: 0000000000000000 CR3: 0000000264748002 CR4:
> >>>> 0000000000770ef0
> >>>> [ 6288.474096] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> >>>> 0000000000000000
> >>>> [ 6288.475097] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> >>>> 0000000000000400
> >>>> [ 6288.476148] PKRU: 55555554
> >>>> [ 6288.476665] note: kworker/u18:8[340798] exited with irqs disabled
> >>>>
> >>>> Once we've released "req", it's not safe to dereference it anymore.
> >>>> Decrement the nrequests counter before dropping the reference.
> >>>>
> >>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >>>> ---
> >>>> I've only hit this once after a lot of testing, so I can't confirm
> >>>> that
> >>>> this fixes anything. It seems like the right thing to do, however.
> >>>> ---
> >>>>  fs/nfs/write.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> >>>> index 8c1ee1a1a28f..7720b5e43014 100644
> >>>> --- a/fs/nfs/write.c
> >>>> +++ b/fs/nfs/write.c
> >>>> @@ -802,8 +802,8 @@ static void nfs_inode_remove_request(struct
> >>>> nfs_page *req)
> >>>>         }
> >>>>
> >>>>         if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
> >>>> -               nfs_release_request(req);
> >>>>                 atomic_long_dec(&NFS_I(nfs_page_to_inode(req))-
> >>>>> nrequests);
> >>>> +               nfs_release_request(req);
> >>>>         }
> >>>>  }
> >>>>
> >>>
> >>> Isn't this the same issue that Scott Mayhew posted a patch ("NFS: Fix
> >>> potential oops in nfs_inode_remove_request()") on July 25th?
> >>>
> >>> At the time I argued for something like the above patch, but both Sco=
tt
> >>> and you argued that it was insufficient to fix the problem.
> >>>
> >>> So which patch is the one we should apply?
> >>
> >> This one.  If there's a separate bug, I've had zero luck in
> >> reproducing it.
> >
> > Would you say you've had zero luck reproducing this one too?
> >
> > I think your patch on July 25th fixes a real bug based on that vmcore w=
e
> > have, but it's a pretty crazy race.   I'll try again to reproduce it.
> >
> > Ben

Okay, I'll plan on taking this patch for 6.6-rc now and if we
determine there is still a bug we can add an additional patch on top.

Anna

>
