Return-Path: <linux-nfs+bounces-311-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5823D803F3B
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 21:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9EC1F212C5
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 20:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557B735EE6;
	Mon,  4 Dec 2023 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrA7zzKC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382CB35EE2
	for <linux-nfs@vger.kernel.org>; Mon,  4 Dec 2023 20:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8A8C433C7;
	Mon,  4 Dec 2023 20:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701721517;
	bh=1+uLgjUj8mo3vcDuc2K/87whBVPRhQL7CjQQXZ8wM/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CrA7zzKCYDLJWMBtqXs2zAtvhPuyOlSGNkRkLlPjTTtXPCaK38LiLmbFU5H3MPpp6
	 C6wAostrl4ngClJaPDZO772blO+z9o88mYObou8ohDjfkKoKVZYB0Hvyec6H8K6Z+H
	 yWgz6wHv0jr8oINz85vLK0T6Xkk9XOX6OauGXnAA064SActP7ElXjyeo72VKDCqkqw
	 OG5oLfGBigpJ+lLvyDpLxYIoDBRb4DzR6j+RQaaPYvUoGx5KrkiRKSB8VKnvyS9ktJ
	 qQvgGv4PmB00x9q+RLaCaJiiOKHjbmWchDHcXS9bVa7OOftD8JDt0AjClD36L/RXVY
	 dYn7h7s78Yzmw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v2 4/4] SUNRPC: Fix a suspicious RCU usage warning
Date: Mon,  4 Dec 2023 15:25:12 -0500
Message-ID: <20231204202512.108047-5-anna@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204202512.108047-1-anna@kernel.org>
References: <20231204202512.108047-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

I received the following warning while running cthon against an ontap
server running pNFS:

[   57.202521] =============================
[   57.202522] WARNING: suspicious RCU usage
[   57.202523] 6.7.0-rc3-g2cc14f52aeb7 #41492 Not tainted
[   57.202525] -----------------------------
[   57.202525] net/sunrpc/xprtmultipath.c:349 RCU-list traversed in non-reader section!!
[   57.202527]
               other info that might help us debug this:

[   57.202528]
               rcu_scheduler_active = 2, debug_locks = 1
[   57.202529] no locks held by test5/3567.
[   57.202530]
               stack backtrace:
[   57.202532] CPU: 0 PID: 3567 Comm: test5 Not tainted 6.7.0-rc3-g2cc14f52aeb7 #41492 5b09971b4965c0aceba19f3eea324a4a806e227e
[   57.202534] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
[   57.202536] Call Trace:
[   57.202537]  <TASK>
[   57.202540]  dump_stack_lvl+0x77/0xb0
[   57.202551]  lockdep_rcu_suspicious+0x154/0x1a0
[   57.202556]  rpc_xprt_switch_has_addr+0x17c/0x190 [sunrpc ebe02571b9a8ceebf7d98e71675af20c19bdb1f6]
[   57.202596]  rpc_clnt_setup_test_and_add_xprt+0x50/0x180 [sunrpc ebe02571b9a8ceebf7d98e71675af20c19bdb1f6]
[   57.202621]  ? rpc_clnt_add_xprt+0x254/0x300 [sunrpc ebe02571b9a8ceebf7d98e71675af20c19bdb1f6]
[   57.202646]  rpc_clnt_add_xprt+0x27a/0x300 [sunrpc ebe02571b9a8ceebf7d98e71675af20c19bdb1f6]
[   57.202671]  ? __pfx_rpc_clnt_setup_test_and_add_xprt+0x10/0x10 [sunrpc ebe02571b9a8ceebf7d98e71675af20c19bdb1f6]
[   57.202696]  nfs4_pnfs_ds_connect+0x345/0x760 [nfsv4 c716d88496ded0ea6d289bbea684fa996f9b57a9]
[   57.202728]  ? __pfx_nfs4_test_session_trunk+0x10/0x10 [nfsv4 c716d88496ded0ea6d289bbea684fa996f9b57a9]
[   57.202754]  nfs4_fl_prepare_ds+0x75/0xc0 [nfs_layout_nfsv41_files e3a4187f18ae8a27b630f9feae6831b584a9360a]
[   57.202760]  filelayout_write_pagelist+0x4a/0x200 [nfs_layout_nfsv41_files e3a4187f18ae8a27b630f9feae6831b584a9360a]
[   57.202765]  pnfs_generic_pg_writepages+0xbe/0x230 [nfsv4 c716d88496ded0ea6d289bbea684fa996f9b57a9]
[   57.202788]  __nfs_pageio_add_request+0x3fd/0x520 [nfs 6c976fa593a7c2976f5a0aeb4965514a828e6902]
[   57.202813]  nfs_pageio_add_request+0x18b/0x390 [nfs 6c976fa593a7c2976f5a0aeb4965514a828e6902]
[   57.202831]  nfs_do_writepage+0x116/0x1e0 [nfs 6c976fa593a7c2976f5a0aeb4965514a828e6902]
[   57.202849]  nfs_writepages_callback+0x13/0x30 [nfs 6c976fa593a7c2976f5a0aeb4965514a828e6902]
[   57.202866]  write_cache_pages+0x265/0x450
[   57.202870]  ? __pfx_nfs_writepages_callback+0x10/0x10 [nfs 6c976fa593a7c2976f5a0aeb4965514a828e6902]
[   57.202891]  nfs_writepages+0x141/0x230 [nfs 6c976fa593a7c2976f5a0aeb4965514a828e6902]
[   57.202913]  do_writepages+0xd2/0x230
[   57.202917]  ? filemap_fdatawrite_wbc+0x5c/0x80
[   57.202921]  filemap_fdatawrite_wbc+0x67/0x80
[   57.202924]  filemap_write_and_wait_range+0xd9/0x170
[   57.202930]  nfs_wb_all+0x49/0x180 [nfs 6c976fa593a7c2976f5a0aeb4965514a828e6902]
[   57.202947]  nfs4_file_flush+0x72/0xb0 [nfsv4 c716d88496ded0ea6d289bbea684fa996f9b57a9]
[   57.202969]  __se_sys_close+0x46/0xd0
[   57.202972]  do_syscall_64+0x68/0x100
[   57.202975]  ? do_syscall_64+0x77/0x100
[   57.202976]  ? do_syscall_64+0x77/0x100
[   57.202979]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[   57.202982] RIP: 0033:0x7fe2b12e4a94
[   57.202985] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 80 3d d5 18 0e 00 00 74 13 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 44 c3 0f 1f 00 48 83 ec 18 89 7c 24 0c e8 c3
[   57.202987] RSP: 002b:00007ffe857ddb38 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
[   57.202989] RAX: ffffffffffffffda RBX: 00007ffe857dfd68 RCX: 00007fe2b12e4a94
[   57.202991] RDX: 0000000000002000 RSI: 00007ffe857ddc40 RDI: 0000000000000003
[   57.202992] RBP: 00007ffe857dfc50 R08: 7fffffffffffffff R09: 0000000065650f49
[   57.202993] R10: 00007fe2b11f8300 R11: 0000000000000202 R12: 0000000000000000
[   57.202994] R13: 00007ffe857dfd80 R14: 00007fe2b1445000 R15: 0000000000000000
[   57.202999]  </TASK>

The problem seems to be that two out of three callers aren't taking the
rcu_read_lock() before calling the list_for_each_entry_rcu() function in
rpc_xprt_switch_has_addr(). I fix this by having
rpc_xprt_switch_has_addr() unconditionaly take the rcu_read_lock(),
which is okay to do recursively in the case that the lock has already
been taken by a caller.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v2: Don't provide a function bypass to skip taking the rcu_read_lock()
---
 net/sunrpc/xprtmultipath.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 701250b305db..0706575d9392 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -336,8 +336,9 @@ struct rpc_xprt *xprt_iter_current_entry_offline(struct rpc_xprt_iter *xpi)
 			xprt_switch_find_current_entry_offline);
 }
 
-bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
-			      const struct sockaddr *sap)
+static
+bool __rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
+				const struct sockaddr *sap)
 {
 	struct list_head *head;
 	struct rpc_xprt *pos;
@@ -356,6 +357,18 @@ bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
 	return false;
 }
 
+bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
+			      const struct sockaddr *sap)
+{
+	bool res;
+
+	rcu_read_lock();
+	res = __rpc_xprt_switch_has_addr(xps, sap);
+	rcu_read_unlock();
+
+	return res;
+}
+
 static
 struct rpc_xprt *xprt_switch_find_next_entry(struct list_head *head,
 		const struct rpc_xprt *cur, bool check_active)
-- 
2.43.0


