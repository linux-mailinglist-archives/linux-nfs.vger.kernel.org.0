Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5A37A649E
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Sep 2023 15:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjISNRh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Sep 2023 09:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjISNRg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Sep 2023 09:17:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9C5F5;
        Tue, 19 Sep 2023 06:17:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B97C433C7;
        Tue, 19 Sep 2023 13:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695129450;
        bh=t2sVUmPLQjVYFiyDF2XzDhODU7D9KtD6ZJuqB23nYaQ=;
        h=From:Date:Subject:To:Cc:From;
        b=mhVVhs5mpvQl8aofalhBvnjB7B1Qz3xjvO+tOTNbdRds5O2EGJmoG8e7n0LyvCNyJ
         t0KenqKE/srwQ04feDWMYlvWvpPJ+Yh68EaUwO9EIIBN+2QGM2gzxX8p43otHI4sOM
         ug8xXaxsb0zkV50MkjRcqcfhiKIQrEPndooBMGsDakWPftsLtlWUaIlbtqMeRaFjvB
         22/lE+wZ6Tk9Lv6tU6FOamRnIoMYaJtaB52b564lcQIgh4vksNBjKIjar7VW1dzHmi
         5ZkWhddAjUrBYoFNcOyWoeHb6EGIC5TM3K+K6U6UyQJMJ+RCi25YcA35q8vdJu42ri
         T8D7m8SGrVB2w==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Tue, 19 Sep 2023 09:17:28 -0400
Subject: [PATCH] nfs: decrement nrequests counter before releasing the req
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-nfs-fixes-v1-1-d22bf72e05ad@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGefCWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDS0NL3by0Yt20zIrUYl3jVCOjpFQzc4NkA1MloPqColSwBFB5dGxtLQA
 re+ljWwAAAA==
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6015; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=t2sVUmPLQjVYFiyDF2XzDhODU7D9KtD6ZJuqB23nYaQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlCZ9pRarj7yhY1aCCyG5d5cVLoGDB6h/B/lGA+
 YbA96sMkpOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZQmfaQAKCRAADmhBGVaC
 FRvrEAC2MNjR1Eun0zrJ71w87HWPtOWj2GiLm0GPTzeueDcbfgKW0WMAQd2kwNSIhsuvESGZP3+
 OPyRIKkPgPX+jPP8/6IJcp9KBQBUdLmm+Kk7xZgp/3pzRbReFO79MZTqKb4cInQeRmqETMQUZ56
 5DXDlIsh6vEsbTEBo80qpDIOUeEoAufZpLYg/ZRtiVjpsxKFiyX9d1J6Vsp/py4oR94rSWFMWcx
 K9wv2+JvqggElcWe0GdNWTRkU7Lc/o1PM4Px5taV+BqjSINEuqjbFKum8IZ5zgmql71xAvcP5BD
 5af2NTvsC3EJY/RkZ2SQXWdgbcVSZqzSOfr6LB2IRYhj4KXw2vzncET91wZpkpoRPDx548ZwNdQ
 wR5+bMW+XdRXBvalh1G+NsV7XHW48K0b2Qryyvb4t3j4SYxATXm7TtBCPPccxcq4y+z5cDY3r3j
 FzykV3PjsrTMN90osmp8R6qIx+DTrpkW+ckDbV7VuC13xwZ0cVmpSLK7iUKuRm1lCOUq7WG8+6r
 KAjRmzFRtYOXDwBd3M+BuBpO3rxwHlQQL24ig3MX2juRwKq4EpxTxFKg3jfAj0XAObnU4ZzbbDK
 6CaYNAll7f7SSyQUeRCSwGxkPtNACyZ9UeTYB6WjqjbvghhEzVHCSfx+B3+8k8uuky+hMtwecd6
 hqJJuworDKSzJ0w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I hit this panic in testing:

[ 6235.500016] run fstests generic/464 at 2023-09-18 22:51:24
[ 6288.410761] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 6288.412174] #PF: supervisor read access in kernel mode
[ 6288.413160] #PF: error_code(0x0000) - not-present page
[ 6288.413992] PGD 0 P4D 0
[ 6288.414603] Oops: 0000 [#1] PREEMPT SMP PTI
[ 6288.415419] CPU: 0 PID: 340798 Comm: kworker/u18:8 Not tainted 6.6.0-rc1-gdcf620ceebac #95
[ 6288.416538] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
[ 6288.417701] Workqueue: nfsiod rpc_async_release [sunrpc]
[ 6288.418676] RIP: 0010:nfs_inode_remove_request+0xc8/0x150 [nfs]
[ 6288.419836] Code: ff ff 48 8b 43 38 48 8b 7b 10 a8 04 74 5b 48 85 ff 74 56 48 8b 07 a9 00 00 08 00 74 58 48 8b 07 f6 c4 10 74 50 e8 c8 44 b3 d5 <48> 8b 00 f0 48 ff 88 30 ff ff ff 5b 5d 41 5c c3 cc cc cc cc 48 8b
[ 6288.422389] RSP: 0018:ffffbd618353bda8 EFLAGS: 00010246
[ 6288.423234] RAX: 0000000000000000 RBX: ffff9a29f9a25280 RCX: 0000000000000000
[ 6288.424351] RDX: ffff9a29f9a252b4 RSI: 000000000000000b RDI: ffffef41448e3840
[ 6288.425345] RBP: ffffef41448e3840 R08: 0000000000000038 R09: ffffffffffffffff
[ 6288.426334] R10: 0000000000033f80 R11: ffff9a2a7fffa000 R12: ffff9a29093f98c4
[ 6288.427353] R13: 0000000000000000 R14: ffff9a29230f62e0 R15: ffff9a29230f62d0
[ 6288.428358] FS:  0000000000000000(0000) GS:ffff9a2a77c00000(0000) knlGS:0000000000000000
[ 6288.429513] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6288.430427] CR2: 0000000000000000 CR3: 0000000264748002 CR4: 0000000000770ef0
[ 6288.431553] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 6288.432715] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 6288.433698] PKRU: 55555554
[ 6288.434196] Call Trace:
[ 6288.434667]  <TASK>
[ 6288.435132]  ? __die+0x1f/0x70
[ 6288.435723]  ? page_fault_oops+0x159/0x450
[ 6288.436389]  ? try_to_wake_up+0x98/0x5d0
[ 6288.437044]  ? do_user_addr_fault+0x65/0x660
[ 6288.437728]  ? exc_page_fault+0x7a/0x180
[ 6288.438368]  ? asm_exc_page_fault+0x22/0x30
[ 6288.439137]  ? nfs_inode_remove_request+0xc8/0x150 [nfs]
[ 6288.440112]  ? nfs_inode_remove_request+0xa0/0x150 [nfs]
[ 6288.440924]  nfs_commit_release_pages+0x16e/0x340 [nfs]
[ 6288.441700]  ? __pfx_call_transmit+0x10/0x10 [sunrpc]
[ 6288.442475]  ? _raw_spin_lock_irqsave+0x23/0x50
[ 6288.443161]  nfs_commit_release+0x15/0x40 [nfs]
[ 6288.443926]  rpc_free_task+0x36/0x60 [sunrpc]
[ 6288.444741]  rpc_async_release+0x29/0x40 [sunrpc]
[ 6288.445509]  process_one_work+0x171/0x340
[ 6288.446135]  worker_thread+0x277/0x3a0
[ 6288.446724]  ? __pfx_worker_thread+0x10/0x10
[ 6288.447376]  kthread+0xf0/0x120
[ 6288.447903]  ? __pfx_kthread+0x10/0x10
[ 6288.448500]  ret_from_fork+0x2d/0x50
[ 6288.449078]  ? __pfx_kthread+0x10/0x10
[ 6288.449665]  ret_from_fork_asm+0x1b/0x30
[ 6288.450283]  </TASK>
[ 6288.450688] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace sunrpc nls_iso8859_1 nls_cp437 vfat fat 9p netfs ext4 kvm_intel crc16 mbcache jbd2 joydev kvm xfs irqbypass virtio_net pcspkr net_failover psmouse failover 9pnet_virtio cirrus drm_shmem_helper virtio_balloon drm_kms_helper button evdev drm loop dm_mod zram zsmalloc crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sha512_ssse3 sha512_generic virtio_blk nvme aesni_intel crypto_simd cryptd nvme_core t10_pi i6300esb crc64_rocksoft_generic crc64_rocksoft crc64 virtio_pci virtio virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring serio_raw btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel xor raid6_pq autofs4
[ 6288.460211] CR2: 0000000000000000
[ 6288.460787] ---[ end trace 0000000000000000 ]---
[ 6288.461571] RIP: 0010:nfs_inode_remove_request+0xc8/0x150 [nfs]
[ 6288.462500] Code: ff ff 48 8b 43 38 48 8b 7b 10 a8 04 74 5b 48 85 ff 74 56 48 8b 07 a9 00 00 08 00 74 58 48 8b 07 f6 c4 10 74 50 e8 c8 44 b3 d5 <48> 8b 00 f0 48 ff 88 30 ff ff ff 5b 5d 41 5c c3 cc cc cc cc 48 8b
[ 6288.465136] RSP: 0018:ffffbd618353bda8 EFLAGS: 00010246
[ 6288.465963] RAX: 0000000000000000 RBX: ffff9a29f9a25280 RCX: 0000000000000000
[ 6288.467035] RDX: ffff9a29f9a252b4 RSI: 000000000000000b RDI: ffffef41448e3840
[ 6288.468093] RBP: ffffef41448e3840 R08: 0000000000000038 R09: ffffffffffffffff
[ 6288.469121] R10: 0000000000033f80 R11: ffff9a2a7fffa000 R12: ffff9a29093f98c4
[ 6288.470109] R13: 0000000000000000 R14: ffff9a29230f62e0 R15: ffff9a29230f62d0
[ 6288.471106] FS:  0000000000000000(0000) GS:ffff9a2a77c00000(0000) knlGS:0000000000000000
[ 6288.472216] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6288.473059] CR2: 0000000000000000 CR3: 0000000264748002 CR4: 0000000000770ef0
[ 6288.474096] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 6288.475097] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 6288.476148] PKRU: 55555554
[ 6288.476665] note: kworker/u18:8[340798] exited with irqs disabled

Once we've released "req", it's not safe to dereference it anymore.
Decrement the nrequests counter before dropping the reference.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I've only hit this once after a lot of testing, so I can't confirm that
this fixes anything. It seems like the right thing to do, however.
---
 fs/nfs/write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 8c1ee1a1a28f..7720b5e43014 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -802,8 +802,8 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 	}
 
 	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
-		nfs_release_request(req);
 		atomic_long_dec(&NFS_I(nfs_page_to_inode(req))->nrequests);
+		nfs_release_request(req);
 	}
 }
 

---
base-commit: 29e400e3ea486bf942b214769fc9778098114113
change-id: 20230919-nfs-fixes-3e22be670c05

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

