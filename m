Return-Path: <linux-nfs+bounces-7260-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D24969A30A7
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 00:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9726928421A
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 22:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74801D54E9;
	Thu, 17 Oct 2024 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7xSXu+f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14671D79B0
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729203911; cv=none; b=RQChrhydDLJMkkK6PXVBWONpnClARZ+G9k9Fp8Voz+ERlm5MOGRw9FofjnHa9tkLxIErq/o+sLe/7g6td7KR6i0SB4+CIK6BSuo+jQ/0Ts/jmtMa3198g4qPImqA2AtJzyA6PwfblAc3trGf/XT/4NLbD6x+GFL3Q4LMiD6nP7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729203911; c=relaxed/simple;
	bh=aueGd+pZyC4HXeYLaSKR/c7uiDTm98IznAS/qsvrd2k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gjchzv5tYgqoNoHqM8f/RtpESnHMnAAxh8dVdHO/nADqe+92nVbbjBsSbD/6qF3yZFN6tfRLMkbmeeYy9kS3iD6bMhvUYYyjlfKwnj5fSgi2X8ZFR/KAAzNVTl5snOzxaauA2pRUUoRcd8kSOPkS28OUmLMr4QRRkk7wKmyePD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U7xSXu+f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729203907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=diFqHmGY/ODhNLWzJoOMwoqQ72kKJ/Ch735bs5aWSrI=;
	b=U7xSXu+fM1rZth2ZAKK4sWlFWQzy+c05CbLO6NSdrPdTAJ7rmYvtgkMlZCbp0Rdsa0GB60
	2IUINKQ5Yu/6dk75WdzwEaMgBYzihyBCl2nzaRHu1FRDYsIqvyGX3lVP9wXQOJ4UOCL0kd
	8d8GlKrEF9ysM9q+GqdqOLBUQnUFQ84=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-Lv-dvRE5PX6VOxHTKV83bA-1; Thu,
 17 Oct 2024 18:25:04 -0400
X-MC-Unique: Lv-dvRE5PX6VOxHTKV83bA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 253E81956088;
	Thu, 17 Oct 2024 22:25:03 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.65.1])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3EB71956086;
	Thu, 17 Oct 2024 22:25:01 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] nfsd: fix race between laundromat and free_stateid
Date: Thu, 17 Oct 2024 18:24:59 -0400
Message-Id: <20241017222459.79104-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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

This patch proposes a fix that's based on adding 2 new additional
stid's sc_status values that help coordinate between the laundromat
and other operations (nfsd4_free_stateid() and nfsd4_delegreturn()).

First to make sure, that once the stid is marked revoked, it is not
removed by the nfsd4_free_stateid(), the laundromat take a reference
on the stateid. Then, coordinating whether the stid has been put
on the cl_revoked list or we are processing FREE_STATEID and need to
make sure to remove it from the list, each check that state and act
accordingly. If laundromat has added to the cl_revoke list before
the arrival of FREE_STATEID, then nfsd4_free_stateid() knows to remove
it from the list. If nfsd4_free_stateid() finds that operations arrived
before laundromat has placed it on cl_revoke list, it marks the state
freed and then laundromat will no longer add it to the list.

Also, for nfsd4_delegreturn() when looking for the specified stid,
we need to access stid that are marked removed or freeable, it means
the laundromat has started processing it but hasn't finished and this
delegreturn needs to return nfserr_deleg_revoked and not
nfserr_bad_stateid. The latter will not trigger a FREE_STATEID and the
lack of it will leave this stid on the cl_revoked list indefinitely.

Fixes: 2d4a532d385f ("nfsd: ensure that clp->cl_revoked list is
protected by clp->cl_lock")
CC: stable@vger.kernel.org
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/nfsd/nfs4state.c | 15 ++++++++++++---
 fs/nfsd/state.h     |  2 ++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ac1859c7cc9d..cb989802e896 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1370,10 +1370,16 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 	if (dp->dl_stid.sc_status &
 	    (SC_STATUS_REVOKED | SC_STATUS_ADMIN_REVOKED)) {
 		spin_lock(&clp->cl_lock);
-		refcount_inc(&dp->dl_stid.sc_count);
+		if (dp->dl_stid.sc_status & SC_STATUS_FREED) {
+			list_del_init(&dp->dl_recall_lru);
+			spin_unlock(&clp->cl_lock);
+			goto out;
+		}
 		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
+		dp->dl_stid.sc_status |= SC_STATUS_FREEABLE;
 		spin_unlock(&clp->cl_lock);
 	}
+out:
 	destroy_unhashed_deleg(dp);
 }
 
@@ -6545,6 +6551,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		if (!state_expired(&lt, dp->dl_time))
 			break;
+		refcount_inc(&dp->dl_stid.sc_count);
 		unhash_delegation_locked(dp, SC_STATUS_REVOKED);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
@@ -7156,7 +7163,9 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		if (s->sc_status & SC_STATUS_REVOKED) {
 			spin_unlock(&s->sc_lock);
 			dp = delegstateid(s);
-			list_del_init(&dp->dl_recall_lru);
+			if (s->sc_status & SC_STATUS_FREEABLE)
+				list_del_init(&dp->dl_recall_lru);
+			s->sc_status |= SC_STATUS_FREED;
 			spin_unlock(&cl->cl_lock);
 			nfs4_put_stid(s);
 			ret = nfs_ok;
@@ -7486,7 +7495,7 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
 		return status;
 
-	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, 0, &s, nn);
+	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, SC_STATUS_REVOKED|SC_STATUS_FREEABLE, &s, nn);
 	if (status)
 		goto out;
 	dp = delegstateid(s);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 79c743c01a47..35b3564c065f 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -114,6 +114,8 @@ struct nfs4_stid {
 /* For a deleg stateid kept around only to process free_stateid's: */
 #define SC_STATUS_REVOKED	BIT(1)
 #define SC_STATUS_ADMIN_REVOKED	BIT(2)
+#define SC_STATUS_FREEABLE	BIT(3)
+#define SC_STATUS_FREED		BIT(4)
 	unsigned short		sc_status;
 
 	struct list_head	sc_cp_list;
-- 
2.43.5


