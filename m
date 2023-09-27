Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D187B0C79
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Sep 2023 21:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjI0TZf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Sep 2023 15:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjI0TZe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Sep 2023 15:25:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A368DD;
        Wed, 27 Sep 2023 12:25:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C707C433C8;
        Wed, 27 Sep 2023 19:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695842732;
        bh=0GOLssQsX/3eU3TpQaInVoVKgf9m/1g7lmT9pGTykdc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RyfbZC9GN/EwlNDBVqow24OIEA7IFXtfkAG7b2EZGfb22ejD4remkztWZg0TMathd
         OGxCOdUVjV0HT4n/9Mga/Dq32+gFuuliT5imbG3ylEaBhmqBxA3NhI6H8jYzWxDBSm
         +GQTcS8mObBehjiHkKc1GPoffq4I2wGpXAMlp8zHUDTYIONjyVdWbGUz6An5WvlnNS
         Ext5VUAhTIfDIv/QdQ5pxEsDA6ODNjRPxuHCDxO/ipU8BXPb9Q9fWRX/svP6syJHuG
         U7c5gEQLVlCm55pSE0YmI+hj81DJsb/CY00e7yo4im37rvJdNuH2ilZRwblyNtipuL
         HdgWUJVULIoCw==
Message-ID: <b574d3d6afd8eec6b13ca3b3928d8194b8c405e2.camel@kernel.org>
Subject: Re: [PATCH] nfs: decrement nrequests counter before releasing the
 req
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Sep 2023 15:25:30 -0400
In-Reply-To: <69c748d58f834b80abda5dcd291ee29ea1cafaf7.camel@hammerspace.com>
References: <20230919-nfs-fixes-v1-1-d22bf72e05ad@kernel.org>
         <69c748d58f834b80abda5dcd291ee29ea1cafaf7.camel@hammerspace.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-09-27 at 19:13 +0000, Trond Myklebust wrote:
> On Tue, 2023-09-19 at 09:17 -0400, Jeff Layton wrote:
> > I hit this panic in testing:
> >=20
> > [ 6235.500016] run fstests generic/464 at 2023-09-18 22:51:24
> > [ 6288.410761] BUG: kernel NULL pointer dereference, address:
> > 0000000000000000
> > [ 6288.412174] #PF: supervisor read access in kernel mode
> > [ 6288.413160] #PF: error_code(0x0000) - not-present page
> > [ 6288.413992] PGD 0 P4D 0
> > [ 6288.414603] Oops: 0000 [#1] PREEMPT SMP PTI
> > [ 6288.415419] CPU: 0 PID: 340798 Comm: kworker/u18:8 Not tainted
> > 6.6.0-rc1-gdcf620ceebac #95
> > [ 6288.416538] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS 1.16.2-1.fc38 04/01/2014
> > [ 6288.417701] Workqueue: nfsiod rpc_async_release [sunrpc]
> > [ 6288.418676] RIP: 0010:nfs_inode_remove_request+0xc8/0x150 [nfs]
> > [ 6288.419836] Code: ff ff 48 8b 43 38 48 8b 7b 10 a8 04 74 5b 48 85
> > ff 74 56 48 8b 07 a9 00 00 08 00 74 58 48 8b 07 f6 c4 10 74 50 e8 c8
> > 44 b3 d5 <48> 8b 00 f0 48 ff 88 30 ff ff ff 5b 5d 41 5c c3 cc cc cc
> > cc 48 8b
> > [ 6288.422389] RSP: 0018:ffffbd618353bda8 EFLAGS: 00010246
> > [ 6288.423234] RAX: 0000000000000000 RBX: ffff9a29f9a25280 RCX:
> > 0000000000000000
> > [ 6288.424351] RDX: ffff9a29f9a252b4 RSI: 000000000000000b RDI:
> > ffffef41448e3840
> > [ 6288.425345] RBP: ffffef41448e3840 R08: 0000000000000038 R09:
> > ffffffffffffffff
> > [ 6288.426334] R10: 0000000000033f80 R11: ffff9a2a7fffa000 R12:
> > ffff9a29093f98c4
> > [ 6288.427353] R13: 0000000000000000 R14: ffff9a29230f62e0 R15:
> > ffff9a29230f62d0
> > [ 6288.428358] FS:=A0 0000000000000000(0000) GS:ffff9a2a77c00000(0000)
> > knlGS:0000000000000000
> > [ 6288.429513] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 6288.430427] CR2: 0000000000000000 CR3: 0000000264748002 CR4:
> > 0000000000770ef0
> > [ 6288.431553] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > [ 6288.432715] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > 0000000000000400
> > [ 6288.433698] PKRU: 55555554
> > [ 6288.434196] Call Trace:
> > [ 6288.434667]=A0 <TASK>
> > [ 6288.435132]=A0 ? __die+0x1f/0x70
> > [ 6288.435723]=A0 ? page_fault_oops+0x159/0x450
> > [ 6288.436389]=A0 ? try_to_wake_up+0x98/0x5d0
> > [ 6288.437044]=A0 ? do_user_addr_fault+0x65/0x660
> > [ 6288.437728]=A0 ? exc_page_fault+0x7a/0x180
> > [ 6288.438368]=A0 ? asm_exc_page_fault+0x22/0x30
> > [ 6288.439137]=A0 ? nfs_inode_remove_request+0xc8/0x150 [nfs]
> > [ 6288.440112]=A0 ? nfs_inode_remove_request+0xa0/0x150 [nfs]
> > [ 6288.440924]=A0 nfs_commit_release_pages+0x16e/0x340 [nfs]
> > [ 6288.441700]=A0 ? __pfx_call_transmit+0x10/0x10 [sunrpc]
> > [ 6288.442475]=A0 ? _raw_spin_lock_irqsave+0x23/0x50
> > [ 6288.443161]=A0 nfs_commit_release+0x15/0x40 [nfs]
> > [ 6288.443926]=A0 rpc_free_task+0x36/0x60 [sunrpc]
> > [ 6288.444741]=A0 rpc_async_release+0x29/0x40 [sunrpc]
> > [ 6288.445509]=A0 process_one_work+0x171/0x340
> > [ 6288.446135]=A0 worker_thread+0x277/0x3a0
> > [ 6288.446724]=A0 ? __pfx_worker_thread+0x10/0x10
> > [ 6288.447376]=A0 kthread+0xf0/0x120
> > [ 6288.447903]=A0 ? __pfx_kthread+0x10/0x10
> > [ 6288.448500]=A0 ret_from_fork+0x2d/0x50
> > [ 6288.449078]=A0 ? __pfx_kthread+0x10/0x10
> > [ 6288.449665]=A0 ret_from_fork_asm+0x1b/0x30
> > [ 6288.450283]=A0 </TASK>
> > [ 6288.450688] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4
> > dns_resolver nfs lockd grace sunrpc nls_iso8859_1 nls_cp437 vfat fat
> > 9p netfs ext4 kvm_intel crc16 mbcache jbd2 joydev kvm xfs irqbypass
> > virtio_net pcspkr net_failover psmouse failover 9pnet_virtio cirrus
> > drm_shmem_helper virtio_balloon drm_kms_helper button evdev drm loop
> > dm_mod zram zsmalloc crct10dif_pclmul crc32_pclmul
> > ghash_clmulni_intel sha512_ssse3 sha512_generic virtio_blk nvme
> > aesni_intel crypto_simd cryptd nvme_core t10_pi i6300esb
> > crc64_rocksoft_generic crc64_rocksoft crc64 virtio_pci virtio
> > virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring serio_raw
> > btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel xor
> > raid6_pq autofs4
> > [ 6288.460211] CR2: 0000000000000000
> > [ 6288.460787] ---[ end trace 0000000000000000 ]---
> > [ 6288.461571] RIP: 0010:nfs_inode_remove_request+0xc8/0x150 [nfs]
> > [ 6288.462500] Code: ff ff 48 8b 43 38 48 8b 7b 10 a8 04 74 5b 48 85
> > ff 74 56 48 8b 07 a9 00 00 08 00 74 58 48 8b 07 f6 c4 10 74 50 e8 c8
> > 44 b3 d5 <48> 8b 00 f0 48 ff 88 30 ff ff ff 5b 5d 41 5c c3 cc cc cc
> > cc 48 8b
> > [ 6288.465136] RSP: 0018:ffffbd618353bda8 EFLAGS: 00010246
> > [ 6288.465963] RAX: 0000000000000000 RBX: ffff9a29f9a25280 RCX:
> > 0000000000000000
> > [ 6288.467035] RDX: ffff9a29f9a252b4 RSI: 000000000000000b RDI:
> > ffffef41448e3840
> > [ 6288.468093] RBP: ffffef41448e3840 R08: 0000000000000038 R09:
> > ffffffffffffffff
> > [ 6288.469121] R10: 0000000000033f80 R11: ffff9a2a7fffa000 R12:
> > ffff9a29093f98c4
> > [ 6288.470109] R13: 0000000000000000 R14: ffff9a29230f62e0 R15:
> > ffff9a29230f62d0
> > [ 6288.471106] FS:=A0 0000000000000000(0000) GS:ffff9a2a77c00000(0000)
> > knlGS:0000000000000000
> > [ 6288.472216] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 6288.473059] CR2: 0000000000000000 CR3: 0000000264748002 CR4:
> > 0000000000770ef0
> > [ 6288.474096] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > [ 6288.475097] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > 0000000000000400
> > [ 6288.476148] PKRU: 55555554
> > [ 6288.476665] note: kworker/u18:8[340798] exited with irqs disabled
> >=20
> > Once we've released "req", it's not safe to dereference it anymore.
> > Decrement the nrequests counter before dropping the reference.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > I've only hit this once after a lot of testing, so I can't confirm
> > that
> > this fixes anything. It seems like the right thing to do, however.
> > ---
> > =A0fs/nfs/write.c | 2 +-
> > =A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > index 8c1ee1a1a28f..7720b5e43014 100644
> > --- a/fs/nfs/write.c
> > +++ b/fs/nfs/write.c
> > @@ -802,8 +802,8 @@ static void nfs_inode_remove_request(struct
> > nfs_page *req)
> > =A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0if (test_and_clear_bit(PG_INODE_REF, &req->wb_f=
lags)) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0nfs_release_request(req);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0atomic_long_dec(&NFS_I(=
nfs_page_to_inode(req))-
> > > nrequests);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0nfs_release_request(req);
> > =A0=A0=A0=A0=A0=A0=A0=A0}
> > =A0}
> >=20
>=20
> Isn't this the same issue that Scott Mayhew posted a patch ("NFS: Fix
> potential oops in nfs_inode_remove_request()") on July 25th?
>=20
> At the time I argued for something like the above patch, but both Scott
> and you argued that it was insufficient to fix the problem.
>=20
> So which patch is the one we should apply?
>=20

It is the same bug, I had paged that discussion out, and forgotten about
it when I sent the patch (though it did seem vaguely familiar). Now that
I've looked over the code more, I think you're correct and that that is
the best solution. It's possible that there may be some other bug
involved here too, but it seems clearly wrong to be referencing the req
after releasing it.
--=20
Jeff Layton <jlayton@kernel.org>
