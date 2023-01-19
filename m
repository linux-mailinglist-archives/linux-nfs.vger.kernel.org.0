Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8076742B2
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jan 2023 20:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjASTVw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Jan 2023 14:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjASTVb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Jan 2023 14:21:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F0E9F05D;
        Thu, 19 Jan 2023 11:20:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A76F9CE2539;
        Thu, 19 Jan 2023 19:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A81DC433EF;
        Thu, 19 Jan 2023 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674156024;
        bh=tX2/wDMuOtU4ud2JPo2T3K0gM7bEfnxM0ZoREVR+C+Y=;
        h=From:To:Cc:Subject:Date:From;
        b=pNfcjPMIVEPDT3ckU6HndgY1WnDT8/Cx56sKrTTx/2NTRPievlsIyGXbYMwVpL/7K
         rdMygJZ2qmGSNKA3u8H5i7ExrSqTseF3cjirkaI5LSyq8qDuaj6Y2JnuxEzQkQgIDF
         PuDi+6j9vx/0VD1t9IL09eKWPvbsTTqcep7Xa4OhDU0xHfFOo+LZ3tbzoLF8xIpJJh
         bXl/qYmLx87tjUw5+DlYyN5CLCRfyGmoVMGcP+/KRKNardlPgJi7WCjdlCKfV3QVRw
         EC1WQJCMH/ralwfQe8G+3OpYMjiA90Ig3No1LW60jVBDwA+QWi4Rx/m+JvwuGpm82G
         9WW8VcQV8txhQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Ruben Vestergaard <rubenv@drcmr.dk>,
        Torkil Svensgaard <torkil@drcmr.dk>,
        Shachar Kagan <skagan@nvidia.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: don't free files unconditionally in __nfsd_file_cache_purge
Date:   Thu, 19 Jan 2023 14:20:21 -0500
Message-Id: <20230119192021.83578-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd_file_cache_purge is called when the server is shutting down, in
which case, tearing things down is generally fine, but it also gets
called when the exports cache is flushed.

Instead of walking the cache and freeing everything unconditionally,
attempt to unhash each entry and get a reference to it, and then put
that reference. Only queue it to the dispose list if the refcount goes
to 0.

Fixes: ac3a2585f018 ("nfsd: rework refcounting in filecache")
Reported-by: Ruben Vestergaard <rubenv@drcmr.dk>
Reported-by: Torkil Svensgaard <torkil@drcmr.dk>
Reported-by: Shachar Kagan <skagan@nvidia.com>
Signed-off-by: Jeffrey Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

I was able to reproduce this today by running pynfs against the server
while running "exportfs -ra" in a loop. This one is a bit different in
that it happened in the open codepath, but that's probably just because
delegations are more likely to be long-lived. With this patch, the
server survives the run:

[  337.962027] ------------[ cut here ]------------
[  337.963823] refcount_t: underflow; use-after-free.
[  337.965502] WARNING: CPU: 6 PID: 3401 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
[  337.967999] Modules linked in: nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) sunrpc(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) ext4(E) crc16(E) cirrus(E) kvm_intel(E) 9p(E) mbcache(E) joydev(E) virtio_net(E) drm_shmem_helper(E) net_failover(E) kvm(E) jbd2(E) netfs(E) psmouse(E) evdev(E) pcspkr(E) failover(E) irqbypass(E) virtio_balloon(E) drm_kms_helper(E) 9pnet_virtio(E) button(E) drm(E) configfs(E) zram(E) zsmalloc(E) crct10dif_pclmul(E) crc32_pclmul(E) nvme(E) ghash_clmulni_intel(E) virtio_blk(E) sha512_ssse3(E) sha512_generic(E) nvme_core(E) t10_pi(E) virtio_pci(E) virtio(E) crc64_rocksoft_generic(E) aesni_intel(E) crypto_simd(E) crc64_rocksoft(E) virtio_pci_legacy_dev(E) i6300esb(E) cryptd(E) serio_raw(E) crc64(E) virtio_pci_modern_dev(E) virtio_ring(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_generic(E) crc32c_intel(E) autofs4(E)
[  337.992040] CPU: 6 PID: 3401 Comm: nfsd Tainted: G            E      6.2.0-rc3+ #11
[  337.994701] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.1-2.fc37 04/01/2014
[  337.998046] RIP: 0010:refcount_warn_saturate+0xba/0x110
[  337.999852] Code: 01 01 e8 83 e5 4f 00 0f 0b c3 cc cc cc cc 80 3d 60 f4 05 01 00 75 85 48 c7 c7 30 b5 e1 9d c6 05 50 f4 05 01 01 e8 60 e5 4f 00 <0f> 0b c3 cc cc cc cc 80 3d 3b f4 05 01 00 0f 85 5e ff ff ff 48 c7
[  338.005245] RSP: 0018:ffffa36802e4bd50 EFLAGS: 00010282
[  338.006621] RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000000
[  338.008273] RDX: 0000000000000001 RSI: ffffffff9de03ef5 RDI: 00000000ffffffff
[  338.009804] RBP: 0000000000000003 R08: 0000000000000000 R09: ffffa36802e4bc00
[  338.011719] R10: 0000000000000003 R11: ffffffff9e0bfdc8 R12: ffff9578da461b80
[  338.013533] R13: 0000000000000001 R14: ffff9578da422280 R15: ffff9578da461b80
[  338.015238] FS:  0000000000000000(0000) GS:ffff957a37d00000(0000) knlGS:0000000000000000
[  338.017179] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  338.018680] CR2: 00007f324c1e1c08 CR3: 000000020360a004 CR4: 0000000000060ee0
[  338.020377] Call Trace:
[  338.021190]  <TASK>
[  338.021956]  release_all_access+0x96/0x120 [nfsd]
[  338.023192]  ? _raw_spin_unlock+0x15/0x30
[  338.024192]  nfsd4_close+0x275/0x3d0 [nfsd]
[  338.025468]  ? fh_verify+0x45e/0x780 [nfsd]
[  338.027535]  ? __pfx_nfsd4_encode_noop+0x10/0x10 [nfsd]
[  338.028775]  ? nfsd4_encode_operation+0xae/0x280 [nfsd]
[  338.030593]  nfsd4_proc_compound+0x3ae/0x6f0 [nfsd]
[  338.032341]  nfsd_dispatch+0x16a/0x270 [nfsd]
[  338.034667]  svc_process_common+0x2eb/0x660 [sunrpc]
[  338.036614]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[  338.038827]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  338.040267]  svc_process+0xad/0x100 [sunrpc]
[  338.041981]  nfsd+0xd5/0x190 [nfsd]
[  338.043362]  kthread+0xe9/0x110
[  338.044680]  ? __pfx_kthread+0x10/0x10
[  338.046376]  ret_from_fork+0x2c/0x50
[  338.047892]  </TASK>
[  338.049067] ---[ end trace 0000000000000000 ]---
[  760.792789] BUG: kernel NULL pointer dereference, address: 0000000000000078
[  760.795933] #PF: supervisor read access in kernel mode
[  760.797477] #PF: error_code(0x0000) - not-present page
[  760.799120] PGD 0 P4D 0
[  760.800140] Oops: 0000 [#1] PREEMPT SMP PTI
[  760.801383] CPU: 2 PID: 3401 Comm: nfsd Tainted: G        W   E      6.2.0-rc3+ #11
[  760.803120] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.1-2.fc37 04/01/2014
[  760.805018] RIP: 0010:filp_close+0x23/0x70
[  760.806099] Code: 90 90 90 90 90 90 90 0f 1f 44 00 00 41 54 55 53 48 8b 47 38 48 85 c0 0f 84 41 e1 6d 00 48 8b 47 28 48 89 fb 48 89 f5 45 31 e4 <48> 8b 40 78 48 85 c0 74 08 e8 6f 70 72 00 41 89 c4 f6 43 45 40 75
[  760.809737] RSP: 0018:ffffa36802e4bc78 EFLAGS: 00010246
[  760.811084] RAX: 0000000000000000 RBX: ffff9578c7d4d600 RCX: 0000000000000000
[  760.812540] RDX: 000000000000098d RSI: 0000000000000000 RDI: ffff9578c7d4d600
[  760.814433] RBP: 0000000000000000 R08: 0000011335048e60 R09: ffff9578f82f1540
[  760.816089] R10: ffffa36802e4bcd0 R11: ffffa36802e4bcd8 R12: 0000000000000000
[  760.817529] R13: 0000000000000001 R14: dead000000000100 R15: ffff9578f82f1558
[  760.818982] FS:  0000000000000000(0000) GS:ffff957a37c80000(0000) knlGS:0000000000000000
[  760.820544] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  760.821734] CR2: 0000000000000078 CR3: 00000001565ce002 CR4: 0000000000060ee0
[  760.823141] Call Trace:
[  760.823808]  <TASK>
[  760.824419]  nfsd_file_free+0xe9/0x210 [nfsd]
[  760.825610]  release_all_access+0x96/0x120 [nfsd]
[  760.826680]  nfs4_free_ol_stateid+0x22/0x60 [nfsd]
[  760.827747]  free_ol_stateid_reaplist+0x61/0x90 [nfsd]
[  760.828858]  release_openowner+0x258/0x2a0 [nfsd]
[  760.829792]  __destroy_client+0x183/0x290 [nfsd]
[  760.830694]  nfsd4_setclientid_confirm+0x1a3/0x4f0 [nfsd]
[  760.831763]  nfsd4_proc_compound+0x3ae/0x6f0 [nfsd]
[  760.832717]  nfsd_dispatch+0x16a/0x270 [nfsd]
[  760.833576]  svc_process_common+0x2eb/0x660 [sunrpc]
[  760.834587]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[  760.835576]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  760.836462]  svc_process+0xad/0x100 [sunrpc]
[  760.837317]  nfsd+0xd5/0x190 [nfsd]
[  760.838133]  kthread+0xe9/0x110
[  760.838862]  ? __pfx_kthread+0x10/0x10
[  760.839755]  ret_from_fork+0x2c/0x50
[  760.840534]  </TASK>
[  760.841167] Modules linked in: nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) sunrpc(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) ext4(E) crc16(E) cirrus(E) kvm_intel(E) 9p(E) mbcache(E) joydev(E) virtio_net(E) drm_shmem_helper(E) net_failover(E) kvm(E) jbd2(E) netfs(E) psmouse(E) evdev(E) pcspkr(E) failover(E) irqbypass(E) virtio_balloon(E) drm_kms_helper(E) 9pnet_virtio(E) button(E) drm(E) configfs(E) zram(E) zsmalloc(E) crct10dif_pclmul(E) crc32_pclmul(E) nvme(E) ghash_clmulni_intel(E) virtio_blk(E) sha512_ssse3(E) sha512_generic(E) nvme_core(E) t10_pi(E) virtio_pci(E) virtio(E) crc64_rocksoft_generic(E) aesni_intel(E) crypto_simd(E) crc64_rocksoft(E) virtio_pci_legacy_dev(E) i6300esb(E) cryptd(E) serio_raw(E) crc64(E) virtio_pci_modern_dev(E) virtio_ring(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_generic(E) crc32c_intel(E) autofs4(E)
[  760.853527] CR2: 0000000000000078
[  760.854340] ---[ end trace 0000000000000000 ]---
[  760.855261] RIP: 0010:filp_close+0x23/0x70
[  760.856185] Code: 90 90 90 90 90 90 90 0f 1f 44 00 00 41 54 55 53 48 8b 47 38 48 85 c0 0f 84 41 e1 6d 00 48 8b 47 28 48 89 fb 48 89 f5 45 31 e4 <48> 8b 40 78 48 85 c0 74 08 e8 6f 70 72 00 41 89 c4 f6 43 45 40 75
[  760.859350] RSP: 0018:ffffa36802e4bc78 EFLAGS: 00010246
[  760.860356] RAX: 0000000000000000 RBX: ffff9578c7d4d600 RCX: 0000000000000000
[  760.861628] RDX: 000000000000098d RSI: 0000000000000000 RDI: ffff9578c7d4d600
[  760.862898] RBP: 0000000000000000 R08: 0000011335048e60 R09: ffff9578f82f1540
[  760.864172] R10: ffffa36802e4bcd0 R11: ffffa36802e4bcd8 R12: 0000000000000000
[  760.865438] R13: 0000000000000001 R14: dead000000000100 R15: ffff9578f82f1558
[  760.866692] FS:  0000000000000000(0000) GS:ffff957a37c80000(0000) knlGS:0000000000000000
[  760.868053] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  760.869102] CR2: 0000000000000078 CR3: 00000001565ce002 CR4: 0000000000060ee0

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 66449c41b19c..b9100707d347 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -908,9 +908,24 @@ __nfsd_file_cache_purge(struct net *net)
 		nf = rhashtable_walk_next(&iter);
 		while (!IS_ERR_OR_NULL(nf)) {
 			if (!net || nf->nf_net == net) {
-				nfsd_file_unhash(nf);
-				nfsd_file_lru_remove(nf);
-				list_add(&nf->nf_lru, &dispose);
+				/* Ignore it if it's no longer hashed */
+				if (!nfsd_file_unhash(nf))
+					continue;
+
+				/*
+				 * Try to claim the LRU ref (if any). If it's
+				 * not on the LRU, then try to take a ref. If that
+				 * fails, then we'll ignore it.
+				 */
+				if (!nfsd_file_lru_remove(nf))
+					nf = nfsd_file_get(nf);
+
+				/*
+				 * Now try to put the ref we hold. If that works
+				 * and it goes to zero, queue it to be freed.
+				 */
+				if (nf && refcount_dec_and_test(&nf->nf_ref))
+					list_add(&nf->nf_lru, &dispose);
 			}
 			nf = rhashtable_walk_next(&iter);
 		}
-- 
2.39.0

