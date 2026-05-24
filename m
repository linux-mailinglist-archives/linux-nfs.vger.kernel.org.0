Return-Path: <linux-nfs+bounces-21903-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKjzMT/4Emob5wYAu9opvQ
	(envelope-from <linux-nfs+bounces-21903-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 24 May 2026 15:08:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8935C2786
	for <lists+linux-nfs@lfdr.de>; Sun, 24 May 2026 15:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C0873009898
	for <lists+linux-nfs@lfdr.de>; Sun, 24 May 2026 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58379395AF5;
	Sun, 24 May 2026 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFT1mcaB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFD8396D2C
	for <linux-nfs@vger.kernel.org>; Sun, 24 May 2026 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779628033; cv=none; b=m+lF+x3JqpotFp/1LofZEdOZ3CZMiToa5o1kjfQyNpd7kHXSvAx81QAgYi8eQ/au6LWn3Xcgj0hoX4tC1OHE1WG4+hrak09bYLjLVJGbIw6KKBdhC7GMQncl3JqdLnwm4gvRKAqer4YkGaBheCF+4aIhbvM3aTPq16BUfUvobak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779628033; c=relaxed/simple;
	bh=whGDVgr9DaXIVCL7I9QLzspFILVLDI6f7xiyqYli2N8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tT1BAjWbG7auJ4NySOZdJj96Kxq0/RkLNSKjOLqeZ44T95RX9gqIRo/sgO4SbKNj8SpcXo00AySyZke4zLOofRzO0SWqQF1GfRQ7Ary0OriSP5FAbOJ3c69kXULg9lBby5TzasFVrHzB1O6rRkeCLudD8wG3WClDhk0OI0xT/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFT1mcaB; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-914bbfc2464so173721285a.1
        for <linux-nfs@vger.kernel.org>; Sun, 24 May 2026 06:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779628031; x=1780232831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDUj+XtKVNzBDF85yQS5JKEq71LY2fdGuiqbA9Dq4O8=;
        b=cFT1mcaBOPEIM862F7eTf21DbE0DPTiI8kP55Vh6Ac7oM6LFlsp0/d3SE48w8FW6TX
         UMPwC62yy6xQXXAIGzQWxoJmQbXE9TrE/Wueo16J7V3CTcwS+aqdg3tqecjtTT97pK3n
         f75KLUxRdKkVShXaNYqhVmT8WgUK9txSD/Piw5KUM+k1SiKvnJucdKq/VDWam8E+Whjo
         Rhbtexal+1srMsQ1TdTHPVEeozAKqgU/hSCaB1Fbm0Nil1TnsGWRcdPakVyd4MIUPcYJ
         tasNC1aH256jAu5uLQwHiKv2eobsAr4SdxqXy/EK9Oh23Dpb4jSJISk3bTnMfl0l00zm
         jwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779628031; x=1780232831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDUj+XtKVNzBDF85yQS5JKEq71LY2fdGuiqbA9Dq4O8=;
        b=MbCB0mSOnjUlVSNEidP1kARVOUyyHAaMvEKyJhuunehzGafAI6XMPJFXK2B1uCfLwN
         DE3RhIPTVW1b8u8ggYDY495mdfZORWL1T+nQeeAiB40K3kKY8JTOtcLe9p7tRnQS15yu
         78M7nVq9QwZ05ZkYsSSW8QWeo4usdskb4SmRMg5fHXSn9nV7H3AVAo/sf9Kd4NumKuaF
         AA19AaUZyHaJjzsDRNLtQYVZGRJMR6xj6EhyE4iQmK6xNAqSfGsMjf2kXScpmvAMIwdk
         8Jjvl9VHPfB/RaI0fkMin2WQ7rcVgKHN0xGKMoXwhBkKzzQqHCJ2sCiUgYfIqCj1iRSf
         y5ng==
X-Forwarded-Encrypted: i=1; AFNElJ/Z8CZi274GIzfYpZgaAuSdvNfsJuggDNbMIJjcSwUqELPcxGQiHxbtrT2pUFERM7dq+856f3vkCD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl7LCPtR+l6okD2D5zskUvuOtPHR6OsMCd7p92p6TBFr22gcMP
	5aPmf/45SPAZaTz0N3YXs5BUEZ6CVImVjSSuyIJvtCORMSnclT9skr2E
X-Gm-Gg: Acq92OFdSsVAB9VoX60dcrcng8O4hhfTsYbRTfwePfrxmh02LcXtfEFg8IShd7qnPEk
	4c0e1sBZgofqVCu7roT9VxJ+8BCn0yotbC49ncGrG1JukAMLJ6XBRgm2mxA4JtoG2x2pK8ZdkiY
	XsgGDZfTrdekKHWWjRER2ZL7CjuwP4u32xwtIFSKnXFnyz7GOA5IaLPCMAOdLNOgFSgwnse48Om
	edtD6aSYHCalXFpyrQULms8jNA3L1s4mlf3gf2/wBZmYmxmDyY+/Xe2ODSmlPTOMD0c4IrTZCr/
	6WLLk+1MzcN3/bILfsboKzFvN/SlIgnVff1mjgb5iL+3JKL3t3lLr/w6hTDN/aLdSubA163fmNA
	J2jwzmU9lz+X/t6nHtlA+zDZwx8pwcIt0YJE540e2mch7dmbTw2MsInh+xYhvF8E3dxzrAO+aOn
	F7zvtip0n+D7QVlN5qcohG1e2d2EEQASOZlGyen2ohPV/P88yMW6RUo8K4mvbd1WM57vTYGJaWh
	ul0xiMTtimrf+0TwGTV
X-Received: by 2002:a05:620a:6504:b0:8cf:c272:9721 with SMTP id af79cd13be357-914b48b4d38mr1503642085a.6.1779628030696;
        Sun, 24 May 2026 06:07:10 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb905677sm817575885a.18.2026.05.24.06.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 06:07:09 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] NFSD: restart ssc_expire_umount walk after dropping nfsd_ssc_lock
Date: Sun, 24 May 2026 09:06:54 -0400
Message-ID: <20260524130654.1924556-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21903-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 6D8935C2786
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd4_ssc_expire_umount() walks nn->nfsd_ssc_mount_list with
list_for_each_entry_safe(ni, tmp, ...).  For each expired entry it
sets nsui_busy = true, drops nfsd_ssc_lock to run mntput() on the
source vfsmount, then reacquires the lock to list_del + kfree the
entry and continue iterating via the macro's saved tmp pointer.

The nsui_busy flag protects the current ni from concurrent
nfsd4_ssc_setup_dul() finders during the lock-drop window, but it
does not pin tmp.  Another nfsd RPC thread that fails its source-
server mount and reaches nfsd4_ssc_cancel_dul() will, during that
same window, take nfsd_ssc_lock, list_del + kfree its own ssc_umount
item, and release the lock.  If that item is the saved tmp of the
expire walk, the next iteration dereferences a freed
nfsd4_ssc_umount_item.

Restart the walk from the head after the mntput() unlock window so
no saved next pointer survives the lock-drop.  The list is bounded
by the number of active inter-server source mounts (typically small)
and the expire delayed-work runs periodically rather than per-IO,
so the restart is cheap.

Cc: stable@vger.kernel.org
Fixes: f4e44b393389 ("NFSD: delay unmount source's export after inter-server copy completed.")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/nfsd/nfs4state.c | 44 +++++++++++++++++++++++++-------------------

Changes since v1:
 - Rewrote the in-code comment above goto-restart to describe the
   current code (concurrent cancel_dul can free any list item while
   the lock is dropped) rather than referencing the removed
   list_for_each_entry_safe() iterator.  (Chuck Lever.)
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6b9c399b89dfb..33f72fcf65458 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6728,30 +6728,36 @@ static void nfsd4_ssc_shutdown_umount(struct nfsd_net *nn)
 static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
 {
 	bool do_wakeup = false;
-	struct nfsd4_ssc_umount_item *ni = NULL;
-	struct nfsd4_ssc_umount_item *tmp;
+	struct nfsd4_ssc_umount_item *ni;
 
+restart:
 	spin_lock(&nn->nfsd_ssc_lock);
-	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
-		if (time_after(jiffies, ni->nsui_expire)) {
-			if (refcount_read(&ni->nsui_refcnt) > 1)
-				continue;
+	list_for_each_entry(ni, &nn->nfsd_ssc_mount_list, nsui_list) {
+		if (!time_after(jiffies, ni->nsui_expire))
+			break;
+		if (refcount_read(&ni->nsui_refcnt) > 1)
+			continue;
 
-			/* mark being unmount */
-			ni->nsui_busy = true;
-			spin_unlock(&nn->nfsd_ssc_lock);
-			mntput(ni->nsui_vfsmount);
-			spin_lock(&nn->nfsd_ssc_lock);
+		/* mark being unmount */
+		ni->nsui_busy = true;
+		spin_unlock(&nn->nfsd_ssc_lock);
+		mntput(ni->nsui_vfsmount);
+		spin_lock(&nn->nfsd_ssc_lock);
 
-			/* waiters need to start from begin of list */
-			list_del(&ni->nsui_list);
-			kfree(ni);
+		/* waiters need to start from begin of list */
+		list_del(&ni->nsui_list);
+		kfree(ni);
 
-			/* wakeup ssc_connect waiters */
-			do_wakeup = true;
-			continue;
-		}
-		break;
+		/* wakeup ssc_connect waiters */
+		do_wakeup = true;
+		/*
+		 * Concurrent nfsd4_ssc_cancel_dul() can free any item
+		 * on the list under nfsd_ssc_lock while mntput() runs
+		 * above.  Restart from the head; the list is short and
+		 * the expire worker is periodic, so this is cheap.
+		 */
+		spin_unlock(&nn->nfsd_ssc_lock);
+		goto restart;
 	}
 	if (do_wakeup)
 		wake_up_all(&nn->nfsd_ssc_waitq);
-- 
2.53.0


