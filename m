Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96CA7B1E72
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Sep 2023 15:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjI1NcC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Sep 2023 09:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjI1NcB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Sep 2023 09:32:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09B6196
        for <linux-nfs@vger.kernel.org>; Thu, 28 Sep 2023 06:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695907874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YqcK4zhsvGvo34DoC12fZ566qKevAmMzV648aobP2ho=;
        b=T8F00qAYOsxTQf4vm9WeiptdC1foFeZG95Kq6b+HzmJjJZZ2Co0V0DWLTDMG4DRU1AVDrr
        pUrkqjcP43ee+Y1ZASRtUYQ1XWdaFYyFZKUnL/gcwtwrAnT0zI1R7gPHzkPw+uKoxJ8egS
        6hCcwf+fgj3PLYjCezhMf0xsGNXtIxs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-WHWM0_OgOBmUkWmPQeeKkw-1; Thu, 28 Sep 2023 09:31:09 -0400
X-MC-Unique: WHWM0_OgOBmUkWmPQeeKkw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED158185A797;
        Thu, 28 Sep 2023 13:31:08 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C08F1492C37;
        Thu, 28 Sep 2023 13:31:07 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>, anna@kernel.org,
        jlayton@kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: decrement nrequests counter before releasing the req
Date:   Thu, 28 Sep 2023 09:31:06 -0400
Message-ID: <0C77F0B3-9D42-4BE7-AD56-1BF7EDBF3729@redhat.com>
In-Reply-To: <3C9D081E-E698-4F8B-B2BB-8A1EC9C20871@redhat.com>
References: <20230919-nfs-fixes-v1-1-d22bf72e05ad@kernel.org>
 <69c748d58f834b80abda5dcd291ee29ea1cafaf7.camel@hammerspace.com>
 <ZRSbuY+mhgBqGdn3@aion> <3C9D081E-E698-4F8B-B2BB-8A1EC9C20871@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 28 Sep 2023, at 9:04, Benjamin Coddington wrote:

> On 27 Sep 2023, at 17:16, Scott Mayhew wrote:
>
>> On Wed, 27 Sep 2023, Trond Myklebust wrote:
>>
>>> On Tue, 2023-09-19 at 09:17 -0400, Jeff Layton wrote:
>>>> I hit this panic in testing:
>>>>
>>>> [ 6235.500016] run fstests generic/464 at 2023-09-18 22:51:24
>>>> [ 6288.410761] BUG: kernel NULL pointer dereference, address:
>>>> 0000000000000000
>>>> [ 6288.412174] #PF: supervisor read access in kernel mode
>>>> [ 6288.413160] #PF: error_code(0x0000) - not-present page
>>>> [ 6288.413992] PGD 0 P4D 0
>>>> [ 6288.414603] Oops: 0000 [#1] PREEMPT SMP PTI
>>>> [ 6288.415419] CPU: 0 PID: 340798 Comm: kworker/u18:8 Not tainted
>>>> 6.6.0-rc1-gdcf620ceebac #95
>>>> [ 6288.416538] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
>>>> BIOS 1.16.2-1.fc38 04/01/2014
>>>> [ 6288.417701] Workqueue: nfsiod rpc_async_release [sunrpc]
>>>> [ 6288.418676] RIP: 0010:nfs_inode_remove_request+0xc8/0x150 [nfs]
>>>> [ 6288.419836] Code: ff ff 48 8b 43 38 48 8b 7b 10 a8 04 74 5b 48 85=

>>>> ff 74 56 48 8b 07 a9 00 00 08 00 74 58 48 8b 07 f6 c4 10 74 50 e8 c8=

>>>> 44 b3 d5 <48> 8b 00 f0 48 ff 88 30 ff ff ff 5b 5d 41 5c c3 cc cc cc
>>>> cc 48 8b
>>>> [ 6288.422389] RSP: 0018:ffffbd618353bda8 EFLAGS: 00010246
>>>> [ 6288.423234] RAX: 0000000000000000 RBX: ffff9a29f9a25280 RCX:
>>>> 0000000000000000
>>>> [ 6288.424351] RDX: ffff9a29f9a252b4 RSI: 000000000000000b RDI:
>>>> ffffef41448e3840
>>>> [ 6288.425345] RBP: ffffef41448e3840 R08: 0000000000000038 R09:
>>>> ffffffffffffffff
>>>> [ 6288.426334] R10: 0000000000033f80 R11: ffff9a2a7fffa000 R12:
>>>> ffff9a29093f98c4
>>>> [ 6288.427353] R13: 0000000000000000 R14: ffff9a29230f62e0 R15:
>>>> ffff9a29230f62d0
>>>> [ 6288.428358] FS:=C2=A0 0000000000000000(0000) GS:ffff9a2a77c00000(=
0000)
>>>> knlGS:0000000000000000
>>>> [ 6288.429513] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
>>>> [ 6288.430427] CR2: 0000000000000000 CR3: 0000000264748002 CR4:
>>>> 0000000000770ef0
>>>> [ 6288.431553] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>>> 0000000000000000
>>>> [ 6288.432715] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>>>> 0000000000000400
>>>> [ 6288.433698] PKRU: 55555554
>>>> [ 6288.434196] Call Trace:
>>>> [ 6288.434667]=C2=A0 <TASK>
>>>> [ 6288.435132]=C2=A0 ? __die+0x1f/0x70
>>>> [ 6288.435723]=C2=A0 ? page_fault_oops+0x159/0x450
>>>> [ 6288.436389]=C2=A0 ? try_to_wake_up+0x98/0x5d0
>>>> [ 6288.437044]=C2=A0 ? do_user_addr_fault+0x65/0x660
>>>> [ 6288.437728]=C2=A0 ? exc_page_fault+0x7a/0x180
>>>> [ 6288.438368]=C2=A0 ? asm_exc_page_fault+0x22/0x30
>>>> [ 6288.439137]=C2=A0 ? nfs_inode_remove_request+0xc8/0x150 [nfs]
>>>> [ 6288.440112]=C2=A0 ? nfs_inode_remove_request+0xa0/0x150 [nfs]
>>>> [ 6288.440924]=C2=A0 nfs_commit_release_pages+0x16e/0x340 [nfs]
>>>> [ 6288.441700]=C2=A0 ? __pfx_call_transmit+0x10/0x10 [sunrpc]
>>>> [ 6288.442475]=C2=A0 ? _raw_spin_lock_irqsave+0x23/0x50
>>>> [ 6288.443161]=C2=A0 nfs_commit_release+0x15/0x40 [nfs]
>>>> [ 6288.443926]=C2=A0 rpc_free_task+0x36/0x60 [sunrpc]
>>>> [ 6288.444741]=C2=A0 rpc_async_release+0x29/0x40 [sunrpc]
>>>> [ 6288.445509]=C2=A0 process_one_work+0x171/0x340
>>>> [ 6288.446135]=C2=A0 worker_thread+0x277/0x3a0
>>>> [ 6288.446724]=C2=A0 ? __pfx_worker_thread+0x10/0x10
>>>> [ 6288.447376]=C2=A0 kthread+0xf0/0x120
>>>> [ 6288.447903]=C2=A0 ? __pfx_kthread+0x10/0x10
>>>> [ 6288.448500]=C2=A0 ret_from_fork+0x2d/0x50
>>>> [ 6288.449078]=C2=A0 ? __pfx_kthread+0x10/0x10
>>>> [ 6288.449665]=C2=A0 ret_from_fork_asm+0x1b/0x30
>>>> [ 6288.450283]=C2=A0 </TASK>
>>>> [ 6288.450688] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4
>>>> dns_resolver nfs lockd grace sunrpc nls_iso8859_1 nls_cp437 vfat fat=

>>>> 9p netfs ext4 kvm_intel crc16 mbcache jbd2 joydev kvm xfs irqbypass
>>>> virtio_net pcspkr net_failover psmouse failover 9pnet_virtio cirrus
>>>> drm_shmem_helper virtio_balloon drm_kms_helper button evdev drm loop=

>>>> dm_mod zram zsmalloc crct10dif_pclmul crc32_pclmul
>>>> ghash_clmulni_intel sha512_ssse3 sha512_generic virtio_blk nvme
>>>> aesni_intel crypto_simd cryptd nvme_core t10_pi i6300esb
>>>> crc64_rocksoft_generic crc64_rocksoft crc64 virtio_pci virtio
>>>> virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring serio_raw
>>>> btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel xor
>>>> raid6_pq autofs4
>>>> [ 6288.460211] CR2: 0000000000000000
>>>> [ 6288.460787] ---[ end trace 0000000000000000 ]---
>>>> [ 6288.461571] RIP: 0010:nfs_inode_remove_request+0xc8/0x150 [nfs]
>>>> [ 6288.462500] Code: ff ff 48 8b 43 38 48 8b 7b 10 a8 04 74 5b 48 85=

>>>> ff 74 56 48 8b 07 a9 00 00 08 00 74 58 48 8b 07 f6 c4 10 74 50 e8 c8=

>>>> 44 b3 d5 <48> 8b 00 f0 48 ff 88 30 ff ff ff 5b 5d 41 5c c3 cc cc cc
>>>> cc 48 8b
>>>> [ 6288.465136] RSP: 0018:ffffbd618353bda8 EFLAGS: 00010246
>>>> [ 6288.465963] RAX: 0000000000000000 RBX: ffff9a29f9a25280 RCX:
>>>> 0000000000000000
>>>> [ 6288.467035] RDX: ffff9a29f9a252b4 RSI: 000000000000000b RDI:
>>>> ffffef41448e3840
>>>> [ 6288.468093] RBP: ffffef41448e3840 R08: 0000000000000038 R09:
>>>> ffffffffffffffff
>>>> [ 6288.469121] R10: 0000000000033f80 R11: ffff9a2a7fffa000 R12:
>>>> ffff9a29093f98c4
>>>> [ 6288.470109] R13: 0000000000000000 R14: ffff9a29230f62e0 R15:
>>>> ffff9a29230f62d0
>>>> [ 6288.471106] FS:=C2=A0 0000000000000000(0000) GS:ffff9a2a77c00000(=
0000)
>>>> knlGS:0000000000000000
>>>> [ 6288.472216] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
>>>> [ 6288.473059] CR2: 0000000000000000 CR3: 0000000264748002 CR4:
>>>> 0000000000770ef0
>>>> [ 6288.474096] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>>> 0000000000000000
>>>> [ 6288.475097] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>>>> 0000000000000400
>>>> [ 6288.476148] PKRU: 55555554
>>>> [ 6288.476665] note: kworker/u18:8[340798] exited with irqs disabled=

>>>>
>>>> Once we've released "req", it's not safe to dereference it anymore.
>>>> Decrement the nrequests counter before dropping the reference.
>>>>
>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>> ---
>>>> I've only hit this once after a lot of testing, so I can't confirm
>>>> that
>>>> this fixes anything. It seems like the right thing to do, however.
>>>> ---
>>>> =C2=A0fs/nfs/write.c | 2 +-
>>>> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
>>>> index 8c1ee1a1a28f..7720b5e43014 100644
>>>> --- a/fs/nfs/write.c
>>>> +++ b/fs/nfs/write.c
>>>> @@ -802,8 +802,8 @@ static void nfs_inode_remove_request(struct
>>>> nfs_page *req)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>>> =C2=A0
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (test_and_clear_b=
it(PG_INODE_REF, &req->wb_flags)) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0nfs_release_request(req);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0atomic_long_dec(&NFS_I(nfs_page_to_inode(req))=
-
>>>>> nrequests);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0nfs_release_request(req);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>>> =C2=A0}
>>>>
>>>
>>> Isn't this the same issue that Scott Mayhew posted a patch ("NFS: Fix=

>>> potential oops in nfs_inode_remove_request()") on July 25th?
>>>
>>> At the time I argued for something like the above patch, but both Sco=
tt
>>> and you argued that it was insufficient to fix the problem.
>>>
>>> So which patch is the one we should apply?
>>
>> This one.  If there's a separate bug, I've had zero luck in
>> reproducing it.
>
> Would you say you've had zero luck reproducing this one too?
>
> I think your patch on July 25th fixes a real bug based on that vmcore w=
e
> have, but it's a pretty crazy race.   I'll try again to reproduce it.
>
> Ben

