Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D41CA1F49
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2019 17:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfH2Pdj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Aug 2019 11:33:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfH2Pdj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 29 Aug 2019 11:33:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A3A5230832EA;
        Thu, 29 Aug 2019 15:33:38 +0000 (UTC)
Received: from bcodding.csb (ovpn-112-84.rdu2.redhat.com [10.10.112.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51FB81001B13;
        Thu, 29 Aug 2019 15:33:38 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 608A3109C550; Thu, 29 Aug 2019 11:33:37 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v2] freezer,NFS: add an unsafe schedule_timeout_interruptable freezable helper for NFS
Date:   Thu, 29 Aug 2019 11:33:37 -0400
Message-Id: <5fbe3d2c1e83face5c916891ef2823376eec3808.1567092682.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 29 Aug 2019 15:33:38 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After commit 0688e64bc600 ("NFS: Allow signal interruption of NFS4ERR_DELAYed
operations") my NFS client dumps lockdep warnings:

	====================================
	WARNING: dir_create.sh/1911 still has locks held!
	5.3.0-rc6.47364e5cdc #1 Not tainted
	------------------------------------
	1 lock held by dir_create.sh/1911:
	 #0: 000000005345f559 (sb_writers#21){.+.+}, at: mnt_want_write+0x20/0x50

	stack backtrace:
	CPU: 1 PID: 1911 Comm: dir_create.sh Not tainted 5.3.0-rc6.47364e5cdc #1
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-2.fc27 04/01/2014
	Call Trace:
	 dump_stack+0x85/0xcb
	 nfs4_handle_exception+0x1df/0x250 [nfsv4]
	 nfs4_do_open+0x38b/0x850 [nfsv4]
	 ? __filemap_fdatawrite_range+0xc1/0x100
	 nfs4_atomic_open+0xe7/0x100 [nfsv4]
	 nfs4_file_open+0x103/0x260 [nfsv4]
	 ? nfs42_remap_file_range+0x220/0x220 [nfsv4]
	 do_dentry_open+0x205/0x3c0
	 path_openat+0x2ba/0xc80
	 do_filp_open+0x9b/0x110
	 ? kvm_sched_clock_read+0x14/0x30
	 ? sched_clock+0x5/0x10
	 ? sched_clock_cpu+0xc/0xc0
	 ? _raw_spin_unlock+0x24/0x30
	 ? do_sys_open+0x1bd/0x260
	 do_sys_open+0x1bd/0x260
	 do_syscall_64+0x75/0x320
	 ? trace_hardirqs_off_thunk+0x1a/0x20
	 entry_SYSCALL_64_after_hwframe+0x49/0xbe
	RIP: 0033:0x7fd49b2535ce

This patch follows prior art in commit 416ad3c9c006 ("freezer: add unsafe
versions of freezable helpers for NFS") to skip lock dependency checks for
NFS.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs4proc.c       |  2 +-
 include/linux/freezer.h | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 1406858bae6c..b9c46373da25 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -415,7 +415,7 @@ static int nfs4_delay_interruptible(long *timeout)
 {
 	might_sleep();
 
-	freezable_schedule_timeout_interruptible(nfs4_update_delay(timeout));
+	freezable_schedule_timeout_interruptible_unsafe(nfs4_update_delay(timeout));
 	if (!signal_pending(current))
 		return 0;
 	return __fatal_signal_pending(current) ? -EINTR :-ERESTARTSYS;
diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 21f5aa0b217f..cd795de81298 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -217,6 +217,16 @@ static inline long freezable_schedule_timeout_killable(long timeout)
 	return __retval;
 }
 
+/* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
+static inline long freezable_schedule_timeout_interruptible_unsafe(long timeout)
+{
+	long __retval;
+	freezer_do_not_count();
+	__retval = schedule_timeout_interruptible(timeout);
+	freezer_count_unsafe();
+	return __retval;
+}
+
 /* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
 static inline long freezable_schedule_timeout_killable_unsafe(long timeout)
 {
@@ -285,6 +295,9 @@ static inline void set_freezable(void) {}
 #define freezable_schedule_timeout_interruptible(timeout)		\
 	schedule_timeout_interruptible(timeout)
 
+#define freezable_schedule_timeout_interruptible_unsafe(timeout)	\
+	schedule_timeout_interruptible(timeout)
+
 #define freezable_schedule_timeout_killable(timeout)			\
 	schedule_timeout_killable(timeout)
 
-- 
2.20.1

