Return-Path: <linux-nfs+bounces-17355-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23782CE9E96
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Dec 2025 15:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 064723028F58
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Dec 2025 14:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E5D24336D;
	Tue, 30 Dec 2025 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vA/tJUFA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F60230BDB
	for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767104325; cv=none; b=ESxUO3DRHXZjV6f/Xpksw+nTxK7E5S3UOx8dH5gNc8eP3RJcD09KurvJNF6PYDCr0hMDU7cm3218vIWVdhLLlB2BuR8tLstcJYPWdrQFxPi0D1NVsIGuGZGKSqRY5bZDZkn/qoxQwI7ApjVajLZ7lr9pi1oUtxORq0c08sBK3Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767104325; c=relaxed/simple;
	bh=GkCIWyAGPnQ5Ht4v+phWhnJgU2RBvY1Q4OlGYXygOjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dk4gwwxyuYv1v9BbFZUzlMy2fKUwj9dS9I0XQxIu2m+S9xhjHvdlvKQREILLGXQc2ERQ6uvCiQBXpCFmqnyWQHoGG9zQfKL1ylTjczwWf9shhbITLEvoOhCipwGh7+o9Zwr/5wX2FbMF0DtE2S6lC87F4Md7oPBfSawk2T4H2gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vA/tJUFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05724C116C6;
	Tue, 30 Dec 2025 14:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767104324;
	bh=GkCIWyAGPnQ5Ht4v+phWhnJgU2RBvY1Q4OlGYXygOjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vA/tJUFAGhHLW8wBweY6Xc8JiewhRaCffUBdvIjGFJldDdWnpnN72KeWYf1gPltJr
	 0bS9CXXW3LcFg2d8MV5P4SxRD6hXD3Az6URjfiEWD6rdX6DhepMbVPqk6ha6UweuCd
	 yc4vSLO2mcwj6QNW90far/5IqOcVqfpAB1Vl0VbacBg3PPqumS1i5jWaAwJZ7ltTK3
	 zn6kLftOXPDMUnx5vqXqsWGD9oZLBNgaKoMaM1VsI0gy2HN85o2RvjQlHPQy3u5Rn5
	 IXjnr+38dOwiKsoFVidkob0bGXoc82lBZM7AGgGMlXuUt/Ht/ByL21Q338wkRQJE2D
	 J+teT8t/cMlag==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 3/5] fs: add pin_insert_group() for superblock-only pins
Date: Tue, 30 Dec 2025 09:18:36 -0500
Message-ID: <20251230141838.2547848-4-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230141838.2547848-1-cel@kernel.org>
References: <20251230141838.2547848-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Filesystems using fs_pin currently receive callbacks from both
group_pin_kill() (during remount read-only) and mnt_pin_kill()
(during mount teardown). Some filesystems require callbacks only
from the former.

NFSD maintains NFSv4 client state associated with the superblocks
of exported filesystems. Revoking this state during unmount requires
lock ordering that conflicts with mnt_pin_kill() context:
mnt_pin_kill() runs during cleanup_mnt() with namespace locks held,
but NFSD's state revocation path acquires these same locks for mount
table lookups, creating AB-BA deadlock potential.

Add pin_insert_group() to register pins on the superblock's s_pins
list only. The function name derives from group_pin_kill(), which
iterates s_pins during remount read-only. Pins registered this way
do not receive mnt_pin_kill() callbacks during mount teardown.

After pin insertion, checking SB_ACTIVE detects racing unmounts.
When the superblock remains active, normal unmount cleanup occurs
through the subsystem's own shutdown path (outside the problematic
locking context) without pin callbacks.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/fs_pin.c            | 29 +++++++++++++++++++++++++++++
 include/linux/fs_pin.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/fs/fs_pin.c b/fs/fs_pin.c
index 972f34558b97..93da2e710abc 100644
--- a/fs/fs_pin.c
+++ b/fs/fs_pin.c
@@ -48,6 +48,35 @@ void pin_insert(struct fs_pin *pin, struct vfsmount *m)
 }
 EXPORT_SYMBOL_GPL(pin_insert);
 
+/**
+ * pin_insert_group - register an fs_pin for superblock-only notification
+ * @pin: the pin to register (must be initialized with init_fs_pin())
+ * @m: the vfsmount whose superblock to monitor
+ *
+ * Registers @pin on the superblock's s_pins list only. Callbacks arrive
+ * only from group_pin_kill() (invoked during remount read-only), not
+ * from mnt_pin_kill() (invoked during mount namespace teardown).
+ *
+ * Use this instead of pin_insert() when mnt_pin_kill() callbacks would
+ * execute in problematic locking contexts. Because mnt_pin_kill() runs
+ * during cleanup_mnt(), callbacks cannot acquire locks also taken during
+ * mount table operations without risking AB-BA deadlock.
+ *
+ * After insertion, check SB_ACTIVE to detect racing unmounts. If clear,
+ * call pin_remove() and abort. Normal unmount cleanup then occurs through
+ * subsystem-specific shutdown paths without pin callback involvement.
+ *
+ * The callback must call pin_remove() before returning. Callbacks execute
+ * with the RCU read lock held.
+ */
+void pin_insert_group(struct fs_pin *pin, struct vfsmount *m)
+{
+	spin_lock(&pin_lock);
+	hlist_add_head(&pin->s_list, &m->mnt_sb->s_pins);
+	spin_unlock(&pin_lock);
+}
+EXPORT_SYMBOL_GPL(pin_insert_group);
+
 void pin_kill(struct fs_pin *p)
 {
 	wait_queue_entry_t wait;
diff --git a/include/linux/fs_pin.h b/include/linux/fs_pin.h
index bdd09fd2520c..379e13bc72db 100644
--- a/include/linux/fs_pin.h
+++ b/include/linux/fs_pin.h
@@ -21,4 +21,5 @@ static inline void init_fs_pin(struct fs_pin *p, void (*kill)(struct fs_pin *))
 
 void pin_remove(struct fs_pin *);
 void pin_insert(struct fs_pin *, struct vfsmount *);
+void pin_insert_group(struct fs_pin *, struct vfsmount *);
 void pin_kill(struct fs_pin *);
-- 
2.52.0


