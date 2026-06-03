Return-Path: <linux-nfs+bounces-22242-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r5fRCy1oIGrp2wAAu9opvQ
	(envelope-from <linux-nfs+bounces-22242-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 19:45:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6C563A3EF
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 19:45:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=fIrjrmRE;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22242-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22242-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDA083030116
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 17:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6412FC898;
	Wed,  3 Jun 2026 17:38:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B05F3E5EFB
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 17:38:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508299; cv=none; b=aeNZRwk++/MwZwni9bf2GPAMiym27oJFeHpdNBMr0nvD0NRQPOxyKGWM7c1vEPJ609SIQblxplGZeINby/Jaeu76TD2ZRH6YM3rhHYablpdyCGSpXpOSZOeqeKBDacrkU2Px8LU8PusK4Yax+Xsm1yCyd2vpVOHEjhThTyzE5D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508299; c=relaxed/simple;
	bh=/Lgj9HtEnqPpmq+rogy1Nun9KLEpuIEnHyzW//Qr03k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sm9pmh6oNJj0CWSzQI3OUyAJK/wwYy8YxEDpLbjCe5KX4wDuwJx0NhsRn3mNAjgkeEFvE3yNdY7jY+HewMnyd+3ZpryKleYTMkntxVKMp8Ogee3MnYUYbWCnrBcHcR54gZ4fsuYud+6PkeFNxbb35HS3Xxkvu8U3ZatIJXaQuVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fIrjrmRE; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso6255e9.0
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jun 2026 10:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780508293; x=1781113093; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mVCPWqSNKcww4dR+mNI3XTjBLMex/Kkq8cMFX9Pn86M=;
        b=fIrjrmRERXZZGx2aKTwfYHBDhksTNYr/gstglZtNq+vjUhQPcVmDwv5nb+7/ZGP1Sq
         aXULYHX9SM3ADPsNR77CeEYVKwM8p7M2WI987nK4WVpN3/ceJ8HduJ4JQg0j0l7nrHC2
         suQEmLxBGpLJ8fGl4NdC7BXJ69rmz6axDBS1EQO//Y4VQVK5kKsCHchtbOcosPXLpYaN
         2MpINMxa+oZNZtMsll5ocX6t1qA9E6UoJVVcYt7MCrc1y7fnWQoLtjAbE7Tr6cVxX+Zy
         19Itb6WkT2576q5NCFkFe0IX2ZwwtEUPwOU9pkenoQDjf5DI+YOfLtWrhE52uFCgYhwH
         VEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780508293; x=1781113093;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVCPWqSNKcww4dR+mNI3XTjBLMex/Kkq8cMFX9Pn86M=;
        b=GLVQltwsc9fHU8Gri+78oHbIDeb3w7LP2fx6dFag1UB66xn922X3Wem+XU70h6auJN
         KQTg3tMyJP/UN7ECkUKC+S6j+E2aYXVrT1r1glCp9hsSuUX/u4V23NSJOynMPRAMslYo
         fxofFi1n7Q7mb3ZPWejGs0AfmvojhJPkRu5LD5syCE/JBC5ZUqmQ9v4wGxjXqts1MD+h
         ZCFxvEIPOrTGPjJanFO7luiASVcSw6Fi6+BAyYSlkIUpu3z7n5JX+FvBka6Ww0tzENcr
         A8uG+6jS1Ai8pjzoOqutmJf6fbGeZU3Nogn7rNAszh9wun5Rfra2yj2/XmMFyi8iCZvh
         gK0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8A3P6nz9BCBIM7is13oQmf2DNaZFYeXSQP+meLD75en8ZtqpcqXwCDinmZhCrwUu/7Rjsw9h2OPs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/x0DLwnkcMXUSH9hcgT84RevWJOF9tc43lBil4u8iCLZb/u0z
	x2px1bPluaW2r6g9ehqtofQPAxFKxVqXmN5eYUNod6EP3/4xK4HqhTee0mqp6Yrgzw==
X-Gm-Gg: Acq92OG3ZEd/Tt6WMLnlx0h7g8wKg4xtOeeiRR+HYtUPN7si5P5zPmEeU0evquanKfi
	G/wIFa+e4q/FkbKh6WnFOqDyHNMAD26ggUsIjkG0T17B9yHnefKNwG4dtnAqdd6ziA72rwRTzbW
	ENQK5opbX8p91IpKm6REP9ShMqvrYXkVxmkbDcwwuF2BLgUxzTnxOyrOeUG+b/p6+Ky6SuZIX1i
	xxn+tPxaklN1uIdja7pdfhR3EPESsUWPsyiNWaebrCl5rl2gV0tIh5QZFsD7WHGqeo8d4sTq4I3
	RqNmeiHiQbNeXjd1AN9ZO0KrfQvyIn67JuqOeKnU/1SYq3//BHpsfGsRmaZnuLyfl89HOvytgJ+
	OVgExP2HBZ9M9PWUyM5mQEmdcdlJVK1qRzvFGLhE+F40IaQY7h8dTofVN9r+fAc71SjcxPl+Yhn
	My/XUzCmdMQP2lN33iU7h3U9zGKbtCY+0gSJycIK5nLSXxcdpUt2wl9SvC5ELdOJ+QQrUDw1mp
X-Received: by 2002:a05:600c:1912:b0:490:ab15:b9e8 with SMTP id 5b1f17b1804b1-490bca7445emr90855e9.2.1780508292385;
        Wed, 03 Jun 2026 10:38:12 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:ac5a:f71c:9e28:abca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc391aaasm9894005e9.1.2026.06.03.10.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:38:11 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Wed, 03 Jun 2026 19:38:06 +0200
Subject: [PATCH] fhandle: fix UAF due to unlocked ->mnt_ns read in
 may_decode_fh()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-vfs-fhandle-uaf-fix-v1-1-ff64ee367e4d@google.com>
X-B4-Tracking: v=1; b=H4sIAH5mIGoC/yWMywqDQAxFf0WyNjBGfNRfkS7UybSRojJRKYj/b
 myX517OOUA5Cis0yQGRd1GZJ4MsTWB4d9OLUbwxkKPSlS7HPSgGe/yHcesCBvliTlQ9fNFTVdR
 g5hLZ5l+1ff5Zt37kYb1TcJ4X/gcrkXcAAAA=
X-Change-ID: 20260603-vfs-fhandle-uaf-fix-32279d5b2758
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780508288; l=5636;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=/Lgj9HtEnqPpmq+rogy1Nun9KLEpuIEnHyzW//Qr03k=;
 b=QBYoxLJIwvpSnWQyglXtVqRr/pmqqfjrZYlk0p12HNcbNJYMSOj125PeA2qZCwy3jaXqTz89a
 dMYx1BW4O4FBeJgBIDlLdKs0YsZtaOaQAGK3bJEv2akyIrsqKOlChgZ
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22242-lists,linux-nfs=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jannh@google.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jannh@google.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D6C563A3EF

may_decode_fh() accesses mount::mnt_ns without holding any locks; that
means the mount can concurrently be unmounted, and the mnt_namespace can
concurrently be freed after an RCU grace period.

This race can happens as follows, assuming that the mount point was
created by open_tree(..., OPEN_TREE_CLONE):

thread 1            thread 2            RCU
                    __do_sys_open_by_handle_at
                      do_handle_open
                        handle_to_path
                          may_decode_fh
                            is_mounted
                              [mount::mnt_ns access]
                            [mount::mnt_ns access]
__do_sys_close
  fput_close_sync
    __fput
      dissolve_on_fput
        umount_tree
        class_namespace_excl_destructor
          namespace_unlock
            free_mnt_ns
              mnt_ns_tree_remove
                call_rcu(mnt_ns_release_rcu)
                                        mnt_ns_release_rcu
                                          mnt_ns_release
                                            kfree
                            [mnt_namespace::user_ns access] **UAF**

Fix it by taking rcu_read_lock() around the mount::mnt_ns access, like
in __prepend_path().
Additionally, document the semantics of mount::mnt_ns, and use WRITE_ONCE()
for writers that can race with lockless readers.

This bug is unreachable unless one of the following is set:

 - CONFIG_PREEMPTION
 - CONFIG_RCU_STRICT_GRACE_PERIOD

because it requires an RCU grace period to happen during a syscall without
an explicit preemption.

This doesn't seem to have interesting security impact; worst-case, it could
leak the result of an integer comparison to userspace (from the level
check in cap_capable()), cause an endless loop, or crash the kernel by
dereferencing an invalid address.

Fixes: 620c266f3949 ("fhandle: relax open_by_handle_at() permission checks")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
I used custom tooling to force this race condition to occur and check
that it leads to a KASAN splat - let me know if you want me to create a
kernel patch to force the race condition and a reproducer you can run.

I remember Christian asking me for feedback on the patch that introduced
the bug, and I missed the bug because I didn't realize what the semantics
of mount::mnt_ns are...
---
 fs/fhandle.c   | 16 ++++++++++++++--
 fs/mount.h     |  8 +++++++-
 fs/namespace.c |  6 +++---
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 642e3d569497..1ca7eb3a6cb5 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -285,6 +285,19 @@ static int do_handle_to_path(struct file_handle *handle, struct path *path,
 	return 0;
 }
 
+static bool capable_wrt_mount(struct mount *mount)
+{
+	struct mnt_namespace *mnt_ns;
+
+	/*
+	 * For ->mnt_ns access.
+	 * The following READ_ONCE() is semantically rcu_dereference().
+	 */
+	guard(rcu)();
+	mnt_ns = READ_ONCE(mount->mnt_ns);
+	return ns_capable(mnt_ns->user_ns, CAP_SYS_ADMIN);
+}
+
 static inline int may_decode_fh(struct handle_to_path_ctx *ctx,
 				unsigned int o_flags)
 {
@@ -320,8 +333,7 @@ static inline int may_decode_fh(struct handle_to_path_ctx *ctx,
 	if (ns_capable(root->mnt->mnt_sb->s_user_ns, CAP_SYS_ADMIN))
 		ctx->flags = HANDLE_CHECK_PERMS;
 	else if (is_mounted(root->mnt) &&
-		 ns_capable(real_mount(root->mnt)->mnt_ns->user_ns,
-			    CAP_SYS_ADMIN) &&
+		 capable_wrt_mount(real_mount(root->mnt)) &&
 		 !has_locked_children(real_mount(root->mnt), root->dentry))
 		ctx->flags = HANDLE_CHECK_PERMS | HANDLE_CHECK_SUBTREE;
 	else
diff --git a/fs/mount.h b/fs/mount.h
index e0816c11a198..f0af6d789bfc 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -71,7 +71,13 @@ struct mount {
 	struct hlist_head mnt_slave_list;/* list of slave mounts */
 	struct hlist_node mnt_slave;	/* slave list entry */
 	struct mount *mnt_master;	/* slave is on master->mnt_slave_list */
-	struct mnt_namespace *mnt_ns;	/* containing namespace */
+	/*
+	 * Containing namespace.
+	 * Normally protected by namespace_sem, but there are also lockless
+	 * readers (which must use RCU to guard against the namespace being
+	 * freed).
+	 */
+	struct mnt_namespace *mnt_ns;
 	struct mountpoint *mnt_mp;	/* where is it mounted */
 	union {
 		struct hlist_node mnt_mp_list;	/* list mounts with the same mountpoint */
diff --git a/fs/namespace.c b/fs/namespace.c
index fe919abd2f01..f5905f4ec560 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1079,7 +1079,7 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 	bool mnt_first_node = true, mnt_last_node = true;
 
 	WARN_ON(mnt_ns_attached(mnt));
-	mnt->mnt_ns = ns;
+	WRITE_ONCE(mnt->mnt_ns, ns);
 	while (*link) {
 		parent = *link;
 		if (mnt->mnt_id_unique < node_to_mount(parent)->mnt_id_unique) {
@@ -1434,7 +1434,7 @@ EXPORT_SYMBOL(mntget);
 void mnt_make_shortterm(struct vfsmount *mnt)
 {
 	if (mnt)
-		real_mount(mnt)->mnt_ns = NULL;
+		WRITE_ONCE(real_mount(mnt)->mnt_ns, NULL);
 }
 
 /**
@@ -1806,7 +1806,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 			ns->nr_mounts--;
 			__touch_mnt_namespace(ns);
 		}
-		p->mnt_ns = NULL;
+		WRITE_ONCE(p->mnt_ns, NULL);
 		if (how & UMOUNT_SYNC)
 			p->mnt.mnt_flags |= MNT_SYNC_UMOUNT;
 

---
base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
change-id: 20260603-vfs-fhandle-uaf-fix-32279d5b2758

Best regards,
--  
Jann Horn <jannh@google.com>


