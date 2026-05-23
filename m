Return-Path: <linux-nfs+bounces-21852-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIR5AcEFEWp+ggYAu9opvQ
	(envelope-from <linux-nfs+bounces-21852-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 03:41:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7FC5BC5F3
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 03:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 960B4300A39D
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 01:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AE825B0BA;
	Sat, 23 May 2026 01:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivusw1vd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6899A264619
	for <linux-nfs@vger.kernel.org>; Sat, 23 May 2026 01:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779500476; cv=none; b=eFYIWnlKvmCAwbdSIE9w9lcGV4R7hV0BESciTEpd+d7qDuO9wIbbkfiIfMjFpkPW00i5/zADBG6jHfjqXA0tKn5y7gQi68sHNLc1wFkEyVBR4JdY91qnypMJl3uhQmXGpidtSQnzsROqncgbbrJYpN3EzixgaPXu4h8c6VT62yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779500476; c=relaxed/simple;
	bh=NKmTmNXZNUVsawrzyHgxo886ekn2OAXS4D0rn9JgprE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FPl7EwG8sC1gm0+gm+hGHbLjJx2+soXUaSc2cnZrcHQTqedjNvfxHh3aQ++yXCJxNwQGbLdoi0KHa/p++3DQcoLOKoi2a6vxIDEPSDVB0Up8m7/BIqbC8Ct8CQ1bFTfesB7EEXSYyH8YK+dkl6LqON0GHps7XLuh/L9t/f9/Wnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivusw1vd; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50e5bea4045so60741551cf.3
        for <linux-nfs@vger.kernel.org>; Fri, 22 May 2026 18:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779500474; x=1780105274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NznA/de/GNUvCfqwNzu7QISNK1Z1Xgcm290xHganHVE=;
        b=ivusw1vdQ5H+u5YVsniLG9/Z3lk6ixweGutLAPmpZFPTeKGnAaI8fnLH/SECIPcCg1
         MBtEj1OSrQS7on/laAe2GdQEtLcs2FVkEaoczNzTXsXjfaQsokYfEtIVsCy7YPin/q9Y
         vHPAQb2QJcqew5zeT7YYpZa7oOtikVsakMNxwlXyWDfHvJ6vZS5vdMGaZzPZEbZZobHD
         qr+lBf5iXM3VbsiBDZ4/Vd6fap2rQVct59IyciA+J+0N1myGcFQe/8zL6putrUUvFluY
         6RQFDUr4dOsIZN5hFPX2AmXZ7YjkzIOeqXABXy21Q+xNNmRIVqg3Lm+p1HuQfvns+Hqu
         ABSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779500474; x=1780105274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NznA/de/GNUvCfqwNzu7QISNK1Z1Xgcm290xHganHVE=;
        b=ZIUUA1Yl2lRymNw2Xb/Md/Obk7r89+KvPIsUc8tYL4c8Sl/4kbS68a/+ixkVOVRnpC
         8bJvy0Zk4P+6LE3srVz5QykAkZdyFAJ5MNzue92WfMggNhhez4XoxPP2E9kJDLa5OYFL
         RjV7uB1d9xcTprI4cVMEqsp29eS9nzRUHCJef8H5KNbkWH43EBQGLYySq9eFMa2F4P6m
         5zEeymvek3eHpQmrL0Jvqzlk6zyAa445bS4BSpSX2WUnMX7LJdifHrycbfX7ZFe5Qftt
         6X21/epugjlEFU5u81n+4EtvvtzbrL7n6o509Jp0pVtd6fAaE6mYzcBXwC2hz390zGxb
         T4gQ==
X-Forwarded-Encrypted: i=1; AFNElJ8BcYwVU0kGUJn6W/VmLf8PwrJbbjIpltTyUnuwjOacmfCTf3WMIKQa1oQM1ULVW7SuKnRDQHO5DaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb3HZu4IURk6Xd9uu2YnDzDH6wNEnyXfFbIs+ZHgNMxSXqqQ4U
	dCs+W/lzQuc6NoheGPuj1IYOlC2rloSK1N1pXzmdVMhU3yPqHlNkTO/y
X-Gm-Gg: Acq92OHsjRD1Ljv2sZ2jLU5fvXEPh8y1KMchCj/JdQy139vkcA1/WNgkgyFhXbWQ8Bd
	SXK/KEJP84mH+x0YFFHsNCGg90vs4QmREdtaDscYg9nFcOK2du6r0b+mCBYeRy1jtbtcYLNXyEO
	wYHdtmWdZMxrPM65Gr3ZSMdCiToPmfDR7/kwbktX6zFV3m0WvqTxCXMBm59mZegRaQtGlcPbCaw
	Rm9TDz4/6doGeggOLSkU5m/T63Mtvo3PpdyH5Eps5le3V+mEGt+xxQV2ccCv7UvFSoHlWBH3NI5
	EwDFmiTRG2HL1VIdSr4pQqmENX0PG3mybimusJa7Hp/BneHIyPyUk0y0aPX3L6nPVmmOWMkp0Is
	4wLjunL383ULNtFkpynpg6NAd10n3pqABAHQf+QV7D7yORG10qyu0qb/6xNJ04MssrAPu5/2wsi
	tZBYZjeHOjV4ld/xrk9TKf+SJdQstBgY6p/3VTUeykaJ3iPQi0WQ25Cq1PO9BLKyqD4m3oRSImV
	FFz5aMV3rpBtB8DKWY7GkEymMdZ+mU=
X-Received: by 2002:a05:622a:5906:b0:50f:b9e6:e058 with SMTP id d75a77b69052e-516d444cb4dmr90035591cf.25.1779500474184;
        Fri, 22 May 2026 18:41:14 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b24cecsm32445651cf.9.2026.05.22.18.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 18:41:13 -0700 (PDT)
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
Subject: [PATCH] NFSD: restart ssc_expire_umount walk after dropping nfsd_ssc_lock
Date: Fri, 22 May 2026 21:41:07 -0400
Message-ID: <20260523014107.2460863-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-21852-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5E7FC5BC5F3
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

Reachability: triggered by any authenticated NFSv4.2 client that
can issue OP_COPY with cna_src.nl4_type = NL4_SERVER to a destination
nfsd built with CONFIG_NFSD_V4_2_INTER_SSC=y and started with
inter_copy_offload_enable=Y.  The client chooses the source-server
netaddr and can pick one that fails vfs_kern_mount() (unreachable,
RST after EXCHANGE_ID, etc.) to drive nfsd4_ssc_cancel_dul() into
the laundromat's lock-drop window.  Default Linux nfsd ships with
inter_copy_offload_enable=N, so the bug is reachable only on servers
where the administrator has explicitly opted into inter-SSC offload.

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
 fs/nfsd/nfs4state.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

Reproduced under QEMU/KVM with KASAN, three nfsd network namespaces
on a single host so the kernel client treats them as distinct
servers, and Linux fault injection forcing vfs_kern_mount allocations
inside the destination nfsd to fail.  This drives nfsd4_ssc_cancel_dul
into a tight loop concurrent with the laundromat workqueue.

Stock kernel:

  BUG: KASAN: slab-use-after-free in laundromat_main+0x1756/0x1be0
  Read of size 8 at addr ffff88800ce9b200 by task kworker/u16:3
  Workqueue: nfsd4 laundromat_main

  Allocated by task 229:
   nfsd4_interssc_connect+0x3f5/0xd90    (nfsd4_ssc_setup_dul, inlined)
   nfsd4_copy+0x117d/0x1a30
   nfsd4_proc_compound+0xbe9/0x23f0

  Freed by task 229:
   kfree+0x18f/0x520
   nfsd4_interssc_connect+0xaff/0xd90    (nfsd4_ssc_cancel_dul, inlined)
   nfsd4_copy+0x117d/0x1a30

  The buggy address belongs to the cache kmalloc-128 of size 128.
  Kernel panic - not syncing: Fatal exception

Patched kernel ran the equivalent workload to completion with the
inter-SSC code path exercised 21-22 times per run and no KASAN
report.

The fault-injection knobs are standard Linux testing infrastructure
(see Documentation/fault-injection/) exercising the existing failure
path in nfsd; no kernel source was modified.  The same primitive
class was previously addressed by the OPEN-error path fix in
__nfs42_ssc_open(); this patch closes the corresponding hole in
the laundromat-driven delayed-unmount path.


diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6b9c399b89dfb..03582f15e3e7e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6728,30 +6728,37 @@ static void nfsd4_ssc_shutdown_umount(struct nfsd_net *nn)
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
+		 * The list_for_each_entry_safe() saved-next pointer was
+		 * not pinned across the spin_unlock() above: a concurrent
+		 * nfsd4_ssc_cancel_dul() can free the next item under the
+		 * same spinlock while mntput() runs.  Restart the walk
+		 * from the head so no stale next is dereferenced.
+		 */
+		spin_unlock(&nn->nfsd_ssc_lock);
+		goto restart;
 	}
 	if (do_wakeup)
 		wake_up_all(&nn->nfsd_ssc_waitq);
-- 
2.53.0


