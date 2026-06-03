Return-Path: <linux-nfs+bounces-22258-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iSaMEDCCIGr64QAAu9opvQ
	(envelope-from <linux-nfs+bounces-22258-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 21:36:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC2E63AE55
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 21:36:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=YLFdbCai;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22258-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22258-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A45773031CF7
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 19:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817C2481248;
	Wed,  3 Jun 2026 19:32:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B0048BD59
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 19:32:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780515127; cv=none; b=rsXe2iG+nMkEnZydoddSdlUMCNlM3pLpKsnp43CCaI9IGdAiTJVEBkbEy7+7CJpt1AgEXIyvWSQY3HdZ+s2UBHg3wVJDOMFq3WIOfyoEn4Zh4Ri5Mrlyv8Jxk2piRXdxneXNvPqqn1hd0joX+jo+TCQTcAO5xZPJgyRQ33TehrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780515127; c=relaxed/simple;
	bh=TQxe3lxjnun8hagmZm/MNZUEw9/HolUDis/d92awEoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iezwn8kOHRWzVdpBTcj2FwtHuG5X9lsI2iCoWmC3O3uMG3wnFTkQvntQ9yekjMX2dhOzasJCQ52OqxLoEH5x84zhdCG33MxK1zNdN3aO2cojUQedVRVleyT6j6miD73sh9tuw/po0oez006cpvuvnqITebpc2Bm1zg4TDEz8JEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YLFdbCai; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso15705e9.0
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jun 2026 12:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780515124; x=1781119924; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WyYYbe9n0CflRt4VnvQU2N03ZiDpY3ZgwW7PfjETq5w=;
        b=YLFdbCaiajgSxtTu2+rCX/PlPlM0MAC4q4NHlEM/vQD2jLpBMcKIF81QQpbjXNChc6
         6aaBKrVwi9r+qR+8/de2fh9tBXepP2szaJrOlpclIHkM/XLmbldwkRUKM9d6AIobxq5R
         Qpr2UWbWHPfvNiNDVeY5N/DfyqcJZxPF7D217bc64rfwHhXJ50rfNqFnEKrc0OvYlHkY
         r7uxSP3Wv314cxrQFlj9J3EuFXhHwjXW0xim/YirWHwXIy5gCxnNcO9LGUiy1L3eF8GM
         pWUJzUr8aONDpl6lcJiAlrlkpJBGY9jUSJ4LgfKofeLcVB6YrO9KPLAM0EJBpP2kcexC
         GEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780515124; x=1781119924;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyYYbe9n0CflRt4VnvQU2N03ZiDpY3ZgwW7PfjETq5w=;
        b=shP4GxVZiaxRUj+mZXBAal8+2pP7lL0ZR4iiJLXMkRxC4GFfi4UdtIIwUT8zBPFbWo
         m1DlJyJqHkctbsMN2z24Ee9bT53BWof/FrC3SS5WY41mHF2eY4hclYVnKYQRubrW8kwI
         q2tHPoe7EBRMSPyYJDIv97LtHW6Zm3Tjtd16kzpgNp4uODTObQH8jgWLrPMnj7kPYuGs
         EFF8RBTudCs4/Zlj4bB5lAiwioxW4AyfhPJp7GMnNzAi9lMpRzbOMdt1e9g//xBpExOs
         1x9O/Mldu6Vr/O1wpPajLZ3mrpX+6MOURs+BpgmNlL9KtWZsg5MVXj35cCt3clJTz0Z9
         m3zA==
X-Forwarded-Encrypted: i=1; AFNElJ+vXSUnR0LbLvZDkH2D5MJ17B0OsGllZxZ11zybUTj2Q6MLfFqJO8t++8euxonbRgVVV2iZmjT2bGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Odl2wZahTxrdi4Pk7sl+Dg03xHuNBbEIFACeutTpAgEZ7zGf
	VUb14u5kAIFXXXq2EH8I6fLbjfn9hNxMymGRsPIqymXPj/xdSCOsG0Oqu2zLl4o2yA==
X-Gm-Gg: Acq92OF6ntvQnJp+zFGvrLhI3D0zqGeIAgDCLqr4wRIVKHMe1LqBe80nyqTuHlzz8+p
	1pFmBD9sem79UFnozRKPfcl3VL+ZkeEu1ikuqV0OZOJjZthKx1F26Ah1hG0fnKOZo3xoaZ3F4Sf
	hXKH+rugiKkcJbejHUWnMeq+D+Yj7UPIsluTqqwuO22/dzxtwSzNCF3kWokBtNi02krw0d7ibQC
	6gMUPjuIYkzf3e+8LnE4U0L547HnY1lYVdbx9wov+Dq9/lYJGlLivtmpt/rLYern7woTk4fOIbj
	oO12YnR5FTWxm8s+myMs0F9SHWahb7VFncetVDIFAiu3/iOpEUTb0CErzd1m1EsiBCpbooDdgAG
	XUY8P+DXfOsM7WMoehcW1G4tCoRKxyvhVRFV1mCPk+FcVDra8mP9QBOA2pqmp4Eirx8CffJvxAx
	oLMH4dOjlllzrXT/DwSTekY6Ek6LlXAD6EKmE1oFJhkEFW5TgYHdIKGw4r7i3PpA==
X-Received: by 2002:a05:600d:18:b0:490:b2ae:44e1 with SMTP id 5b1f17b1804b1-490bcbea733mr114005e9.5.1780515123978;
        Wed, 03 Jun 2026 12:32:03 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:ac5a:f71c:9e28:abca])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fd33sm10773167f8f.35.2026.06.03.12.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 12:32:03 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Wed, 03 Jun 2026 21:31:57 +0200
Subject: [PATCH v2] fhandle: fix UAF due to unlocked ->mnt_ns read in
 may_decode_fh()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-vfs-fhandle-uaf-fix-v2-1-d05db76a5084@google.com>
X-B4-Tracking: v=1; b=H4sIACyBIGoC/32NSw6CMBCGr0Jm7ZjSQlFW3sOwADqFGqSmhUZDu
 Lst7l1+/3MDT86QhzrbwFEw3tg5Aj9l0I/tPBAaFRk445JJJjBojzo6aiJcW43avFFwXl1V2fG
 qvEBsvhxF+Vi9Nz/2a/egfklTKTEav1j3OW5DnnL/H0KOOWotCyIhKyrUbbB2mOjc2yc0+75/A
 aB7oQrJAAAA
X-Change-ID: 20260603-vfs-fhandle-uaf-fix-32279d5b2758
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780515120; l=6036;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=TQxe3lxjnun8hagmZm/MNZUEw9/HolUDis/d92awEoY=;
 b=K+4of6TqNWTyWzKPNAp9t6KhlWoMPKZ8N6RslxyIcl5G/CVP0yN5DB2rP9fkDSdzg39pgsZDq
 Ga5TomOHFV0AbRGKlkO9Mss5adscN2S+yIo9aKIeptmxtyDNWKoGKXH
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22258-lists,linux-nfs=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jannh@google.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jannh@google.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DC2E63AE55

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
Changes in v2:
- improve comment on mnt_ns semantics based on discussion with viro@
- Link to v1: https://patch.msgid.link/20260603-vfs-fhandle-uaf-fix-v1-1-ff64ee367e4d@google.com
---
 fs/fhandle.c   | 16 ++++++++++++++--
 fs/mount.h     | 10 +++++++++-
 fs/namespace.c |  6 +++---
 3 files changed, 26 insertions(+), 6 deletions(-)

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
index e0816c11a198..5c120f8361bd 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -71,7 +71,15 @@ struct mount {
 	struct hlist_head mnt_slave_list;/* list of slave mounts */
 	struct hlist_node mnt_slave;	/* slave list entry */
 	struct mount *mnt_master;	/* slave is on master->mnt_slave_list */
-	struct mnt_namespace *mnt_ns;	/* containing namespace */
+	/*
+	 * Containing namespace (active or deactivating, non-refcounted).
+	 * Normally protected by namespace_sem.
+	 * Can also be accessed locklessly under RCU. RCU readers can't rely on
+	 * the namespace still being active, but implicitly hold a passive
+	 * reference (because an RCU delay happens between a namespace being
+	 * deactivated and the corresponding passive refcount drop).
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


