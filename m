Return-Path: <linux-nfs+bounces-7041-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5C5999505
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 00:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D62A284879
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 22:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F851BC9F3;
	Thu, 10 Oct 2024 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vgulp5UF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA94319A2A3
	for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2024 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598694; cv=none; b=Go44yZnxojjj8hIlvWPyUq/e2mVC5isLBC7AjpAdy+SMkSDCZZzPTD4gw6qc5pxnFT9gbjA4/dmZPpjutvrgmEQKfHrb5Y/7UkUV3Ey6ihKWa8bueBHFfnu0K4/XAXoaJ9DbCDGEQQ4WYrOYy71Uv6+rAOG0h6ydyEnMBUBl8aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598694; c=relaxed/simple;
	bh=phDctVoaQKKmWkHaNwpjsri0tJhHdhRLoqZQvyOpS8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RfOd44nBVB7iAmRixr7Agg3cJ7H2ozCX2unpxM2kYEOLxicf1lEgkv6z7PqCy17/oFAM7sO9lii+bgyPDmJVyCZe7QbZCxqqlFzwTv2SrYxhBS+/Xr7SnYcuBZuMDnamZmKKrwZhv6RRryqzZaDr7qYvJdPHykusQ0uWzczI6ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vgulp5UF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728598692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qwA4fcS+JqUCUJrMfiDWqWg8B+PDm6yXbIYXG90psRA=;
	b=Vgulp5UFs2fPAnebMAZtI5DMx+0ZFSHYn4gBM24ZRU59H0OJFBh2rdnU1AOGnRLIT4NeVA
	Hj2EvzrQa3kKEHn7/uxvdiDYXTqpyzR4uGUjAvy4yYKhKj2MFB3JcEP7fv4gtepII2AnOh
	ReJCpk09l/kUkpwVoZ3usG4Vmzof0Sk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-L-rG0HEwOEmneWCC3e2sPg-1; Thu,
 10 Oct 2024 18:18:07 -0400
X-MC-Unique: L-rG0HEwOEmneWCC3e2sPg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8253195608B;
	Thu, 10 Oct 2024 22:18:06 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.17.53])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 647CB19560A2;
	Thu, 10 Oct 2024 22:18:05 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] nfsd: fix race between laundromat and free_stateid
Date: Thu, 10 Oct 2024 18:18:01 -0400
Message-Id: <20241010221801.35462-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

There is a race between laundromat handling of revoked delegations
and a client sending free_stateid operation. Laundromat thread
finds that delegation has expired and needs to be revoked so it
marks the delegation stid revoked and it puts it on a reaper list
but then it unlock the state lock and the actual delegation revocation
happens without the lock. Once the stid is marked revoked a racing
free_stateid processing thread does the following (1) it calls
list_del_init() which removes it from the reaper list and (2) frees
the delegation stid structure. The laundromat thread ends up not
calling the revoke_delegation() function for this particular delegation
but that means it will no release the lock lease that exists on
the file.

Now, a new open for this file comes in and ends up finding that
lease list isn't empty and calls nfsd_breaker_owns_lease() which ends
up trying to derefence a freed delegation stateid. Leading to the
followint use-after-free KASAN warning:

kernel: ==================================================================
kernel: BUG: KASAN: slab-use-after-free in nfsd_breaker_owns_lease+0x140/0x160 [nfsd]
kernel: Read of size 8 at addr ffff0000e73cd0c8 by task nfsd/6205
kernel:
kernel: CPU: 2 UID: 0 PID: 6205 Comm: nfsd Kdump: loaded Not tainted 6.11.0-rc7+ #9
kernel: Hardware name: Apple Inc. Apple Virtualization Generic Platform, BIOS 2069.0.0.0.0 08/03/2024
kernel: Call trace:
kernel: dump_backtrace+0x98/0x120
kernel: show_stack+0x1c/0x30
kernel: dump_stack_lvl+0x80/0xe8
kernel: print_address_description.constprop.0+0x84/0x390
kernel: print_report+0xa4/0x268
kernel: kasan_report+0xb4/0xf8
kernel: __asan_report_load8_noabort+0x1c/0x28
kernel: nfsd_breaker_owns_lease+0x140/0x160 [nfsd]
kernel: leases_conflict+0x68/0x370
kernel: __break_lease+0x204/0xc38
kernel: nfsd_open_break_lease+0x8c/0xf0 [nfsd]
kernel: nfsd_file_do_acquire+0xb3c/0x11d0 [nfsd]
kernel: nfsd_file_acquire_opened+0x84/0x110 [nfsd]
kernel: nfs4_get_vfs_file+0x634/0x958 [nfsd]
kernel: nfsd4_process_open2+0xa40/0x1a40 [nfsd]
kernel: nfsd4_open+0xa08/0xe80 [nfsd]
kernel: nfsd4_proc_compound+0xb8c/0x2130 [nfsd]
kernel: nfsd_dispatch+0x22c/0x718 [nfsd]
kernel: svc_process_common+0x8e8/0x1960 [sunrpc]
kernel: svc_process+0x3d4/0x7e0 [sunrpc]
kernel: svc_handle_xprt+0x828/0xe10 [sunrpc]
kernel: svc_recv+0x2cc/0x6a8 [sunrpc]
kernel: nfsd+0x270/0x400 [nfsd]
kernel: kthread+0x288/0x310
kernel: ret_from_fork+0x10/0x20

Proposing to have laundromat thread hold the state_lock over both
marking thru revoking the delegation as well as making free_stateid
acquire state_lock before accessing the list. Making sure that
revoke_delegation() (ie kernel_setlease(unlock)) is called for
every delegation that was revoked and added to the reaper list.

CC: stable@vger.kernel.org
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>

--- I can't figure out the Fixes: tag. Laundromat's behaviour has
been like that forever. But the free_stateid bits wont apply before
the 1e3577a4521e ("SUNRPC: discard sv_refcnt, and svc_get/svc_put").
But we used that fixes tag already with a previous fix for a different
problem.
---
 fs/nfsd/nfs4state.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9c2b1d251ab3..c97907d7fb38 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6605,13 +6605,13 @@ nfs4_laundromat(struct nfsd_net *nn)
 		unhash_delegation_locked(dp, SC_STATUS_REVOKED);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
-	spin_unlock(&state_lock);
 	while (!list_empty(&reaplist)) {
 		dp = list_first_entry(&reaplist, struct nfs4_delegation,
 					dl_recall_lru);
 		list_del_init(&dp->dl_recall_lru);
 		revoke_delegation(dp);
 	}
+	spin_unlock(&state_lock);
 
 	spin_lock(&nn->client_lock);
 	while (!list_empty(&nn->close_lru)) {
@@ -7213,7 +7213,9 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		if (s->sc_status & SC_STATUS_REVOKED) {
 			spin_unlock(&s->sc_lock);
 			dp = delegstateid(s);
+			spin_lock(&state_lock);
 			list_del_init(&dp->dl_recall_lru);
+			spin_unlock(&state_lock);
 			spin_unlock(&cl->cl_lock);
 			nfs4_put_stid(s);
 			ret = nfs_ok;
-- 
2.43.5


