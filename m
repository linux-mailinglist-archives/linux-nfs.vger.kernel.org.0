Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D709921550D
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2020 11:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgGFJ5X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jul 2020 05:57:23 -0400
Received: from mail5.windriver.com ([192.103.53.11]:58812 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727973AbgGFJ5W (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 6 Jul 2020 05:57:22 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 0669tDiw002399
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 6 Jul 2020 02:55:34 -0700
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Mon, 6 Jul 2020 02:55:12 -0700
From:   <zhe.he@windriver.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <rjw@rjwysocki.net>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <zhe.he@windriver.com>
Subject: [PATCH] freezer: Add unsafe versions of freezable_schedule_timeout_interruptible for NFS
Date:   Mon, 6 Jul 2020 17:52:24 +0800
Message-ID: <20200706095224.2285480-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

commit 0688e64bc600 ("NFS: Allow signal interruption of NFS4ERR_DELAYed operations")
introduces nfs4_delay_interruptible which also needs an _unsafe version to
avoid the following call trace for the same reason explained in
commit 416ad3c9c006 ("freezer: add unsafe versions of freezable helpers for NFS")

CPU: 4 PID: 3968 Comm: rm Tainted: G W 5.8.0-rc4 #1
Hardware name: Marvell OcteonTX CN96XX board (DT)
Call trace:
dump_backtrace+0x0/0x1dc
show_stack+0x20/0x30
dump_stack+0xdc/0x150
debug_check_no_locks_held+0x98/0xa0
nfs4_delay_interruptible+0xd8/0x120
nfs4_handle_exception+0x130/0x170
nfs4_proc_rmdir+0x8c/0x220
nfs_rmdir+0xa4/0x360
vfs_rmdir.part.0+0x6c/0x1b0
do_rmdir+0x18c/0x210
__arm64_sys_unlinkat+0x64/0x7c
el0_svc_common.constprop.0+0x7c/0x110
do_el0_svc+0x24/0xa0
el0_sync_handler+0x13c/0x1b8
el0_sync+0x158/0x180

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 fs/nfs/nfs4proc.c       |  2 +-
 include/linux/freezer.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e32717fd1169..15ecfa474e37 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -414,7 +414,7 @@ static int nfs4_delay_interruptible(long *timeout)
 {
 	might_sleep();
 
-	freezable_schedule_timeout_interruptible(nfs4_update_delay(timeout));
+	freezable_schedule_timeout_interruptible_unsafe(nfs4_update_delay(timeout));
 	if (!signal_pending(current))
 		return 0;
 	return __fatal_signal_pending(current) ? -EINTR :-ERESTARTSYS;
diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 21f5aa0b217f..27828145ca09 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -207,6 +207,17 @@ static inline long freezable_schedule_timeout_interruptible(long timeout)
 	return __retval;
 }
 
+/* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
+static inline long freezable_schedule_timeout_interruptible_unsafe(long timeout)
+{
+	long __retval;
+
+	freezer_do_not_count();
+	__retval = schedule_timeout_interruptible(timeout);
+	freezer_count_unsafe();
+	return __retval;
+}
+
 /* Like schedule_timeout_killable(), but should not block the freezer. */
 static inline long freezable_schedule_timeout_killable(long timeout)
 {
@@ -285,6 +296,9 @@ static inline void set_freezable(void) {}
 #define freezable_schedule_timeout_interruptible(timeout)		\
 	schedule_timeout_interruptible(timeout)
 
+#define freezable_schedule_timeout_interruptible_unsafe(timeout)	\
+	schedule_timeout_interruptible(timeout)
+
 #define freezable_schedule_timeout_killable(timeout)			\
 	schedule_timeout_killable(timeout)
 
-- 
2.17.1

