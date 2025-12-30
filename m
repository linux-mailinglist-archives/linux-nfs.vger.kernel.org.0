Return-Path: <linux-nfs+bounces-17354-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4003ACE9E84
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Dec 2025 15:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E84233014DE7
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Dec 2025 14:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573E5230BEC;
	Tue, 30 Dec 2025 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gywmgKIC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339E8230BDB
	for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767104324; cv=none; b=PztRTxJup90nvYSPAYz/b+swPo1D3bp2Pk3uDFkC9V35Si/y4Un8ndm2FJ/D5XGUrwfFcF3OwavdisQLwfAhRA0Ww9CCI342wS2QWpQ2aw1Rk7TcikvDfpairereQC7sTGKtzEN7ANWSyhUtO0zlfk5wM+6gIOBjumvgw7XzYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767104324; c=relaxed/simple;
	bh=79Or+k+dOheLXat25afFb+DDUvkdmuu+Uji8I2xy0I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M15ofwQJSXPwTbg6NY66TQPgjiVKV853ftG/eY1iB7UbL+cbdpkAIGodrhfqp8Mnrdvdb2t3FzaPtdWGZjhrsgzNWcho7yJIqDX7QYnrgtO9doi+uAMokmKrOJgRO2qxT7z6xnxejqCtG0rKTg2R4tANctMgtJmCv6pN+Mj+EhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gywmgKIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C32C116D0;
	Tue, 30 Dec 2025 14:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767104323;
	bh=79Or+k+dOheLXat25afFb+DDUvkdmuu+Uji8I2xy0I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gywmgKICcZ/FiHYSgjU8E8XxEzqFj/LhNN/FRmWIPc8+pAEFglUn5Y71MQjX+1gad
	 uoTCMpKs4qbOOgR9CQclOz8BiFryd+QfJ7rb+El1xLSvj1PC+bPxvAYcevQIREPeiK
	 X0ILF1lwd0VUnRasfqeedTEhVtB1Xz2CguiNQgaCau2HzktLiF4wSIh5rniIs/E3wj
	 I9aWR+dQqN2nbWjHD+U4gqjrDluehns0WTlU3RcovB5+9cgulM9RngrX6XkgeFTs1X
	 xiaH8zdX8zos/R2t+i9zGT+fB4SJcskvAdlYac7O5NCqn6cGbEif/PZFHkOaxMMLNy
	 eEjUgkcNGvbZQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 2/5] fs: export pin_insert and pin_remove for modular filesystems
Date: Tue, 30 Dec 2025 09:18:35 -0500
Message-ID: <20251230141838.2547848-3-cel@kernel.org>
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

Modular filesystems currently have no notification mechanism for
mount teardown. When an NFS export is unexported then unmounted,
NFSD cannot detect this event to revoke associated state, state
which holds open file references that pin the mount.

The existing fs_pin infrastructure provides unmount callbacks, but
pin_insert() and pin_remove() lack EXPORT_SYMBOL_GPL(), restricting
this facility to built-in subsystems. This restriction appears
historical rather than intentional; fs_pin.h is already a public
header, and the mechanism's purpose (coordinating mount lifetimes
with filesystem state) applies equally to modular subsystems.

Export both symbols with EXPORT_SYMBOL_GPL() to permit modular
filesystems to register fs_pin callbacks. NFSD requires this to
revoke NFSv4 delegations, layouts, and open state when the
underlying filesystem is unmounted, preventing use-after-free
conditions in the state tracking layer.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/fs_pin.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/fs_pin.c b/fs/fs_pin.c
index 47ef3c71ce90..972f34558b97 100644
--- a/fs/fs_pin.c
+++ b/fs/fs_pin.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/export.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -7,6 +8,15 @@
 
 static DEFINE_SPINLOCK(pin_lock);
 
+/**
+ * pin_remove - detach an fs_pin from its mount and superblock
+ * @pin: the pin to remove
+ *
+ * Removes @pin from the mount and superblock pin lists and marks it
+ * done. Must be called from the pin's kill callback before returning.
+ * The caller must keep @pin valid until this function returns; after
+ * that, VFS will not reference @pin again.
+ */
 void pin_remove(struct fs_pin *pin)
 {
 	spin_lock(&pin_lock);
@@ -18,7 +28,17 @@ void pin_remove(struct fs_pin *pin)
 	wake_up_locked(&pin->wait);
 	spin_unlock_irq(&pin->wait.lock);
 }
+EXPORT_SYMBOL_GPL(pin_remove);
 
+/**
+ * pin_insert - register an fs_pin for unmount notification
+ * @pin: the pin to register (must be initialized with init_fs_pin())
+ * @m: the vfsmount to monitor
+ *
+ * Registers @pin to receive notification when @m is unmounted. When
+ * unmount occurs, the pin's kill callback is invoked with the RCU
+ * read lock held. The callback must call pin_remove() before returning.
+ */
 void pin_insert(struct fs_pin *pin, struct vfsmount *m)
 {
 	spin_lock(&pin_lock);
@@ -26,6 +46,7 @@ void pin_insert(struct fs_pin *pin, struct vfsmount *m)
 	hlist_add_head(&pin->m_list, &real_mount(m)->mnt_pins);
 	spin_unlock(&pin_lock);
 }
+EXPORT_SYMBOL_GPL(pin_insert);
 
 void pin_kill(struct fs_pin *p)
 {
-- 
2.52.0


