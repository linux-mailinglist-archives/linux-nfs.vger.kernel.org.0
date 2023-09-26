Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1F77AF90D
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Sep 2023 06:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjI0ELY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Sep 2023 00:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjI0EKH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Sep 2023 00:10:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1AA1B39A
        for <linux-nfs@vger.kernel.org>; Tue, 26 Sep 2023 15:22:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BC1C43391;
        Tue, 26 Sep 2023 21:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695762204;
        bh=/bYn9JDMH9oYtwGY70SFheNTbWCaWp3c2FRVfiwQXwo=;
        h=From:To:Cc:Subject:Date:From;
        b=lNMouH5e3Fa8Ih2rosIFYtzDtBSOixil2lgaOgvagQlrfR4NlYi1x7HTbjsUREM+L
         2JtIyFWkND12F+An+wEfIJKgnSyHYUgHwsakiZi/s2G8t5VTdKe5q1w7fgrD8G3Kze
         WkxJOReif3Zrvx6FzZ9j+ARYYwGb8ruMglZpFqwEPwfsz9lJGSo96pusBlfgWwfhdO
         A/pMfDY6LyWlQmBJGO9fJ0RsdqbyyjSc7T0F2gUYLVdOCER8e+7HU0n7WQnuOyvBKo
         2vbPnXWTviUTuCV+12cuZO4SNzgSYTSGolg+aOzixe0Dw6Q2lhwEHkUZF03GWH6yq5
         cGq36R3/pZPfg==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com
Cc:     anna@kernel.org
Subject: [PATCH] SUNRPC/TLS: Lock the lower_xprt during the tls handshake
Date:   Tue, 26 Sep 2023 17:03:22 -0400
Message-ID: <20230926210322.184335-1-anna@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Otherwise we run the risk of having the lower_xprt freed from underneath
us, causing an oops that looks like this:

[  224.150698] BUG: kernel NULL pointer dereference, address: 0000000000000018
[  224.150951] #PF: supervisor read access in kernel mode
[  224.151117] #PF: error_code(0x0000) - not-present page
[  224.151278] PGD 0 P4D 0
[  224.151361] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  224.151499] CPU: 2 PID: 99 Comm: kworker/u10:6 Not tainted 6.6.0-rc3-g6465e260f487 #41264 a00b0960990fb7bc6d6a330ee03588b67f08a47b
[  224.151977] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
[  224.152216] Workqueue: xprtiod xs_tcp_tls_setup_socket [sunrpc]
[  224.152434] RIP: 0010:xs_tcp_tls_setup_socket+0x3cc/0x7e0 [sunrpc]
[  224.152643] Code: 00 00 48 8b 7c 24 08 e9 f3 01 00 00 48 83 7b c0 00 0f 85 d2 01 00 00 49 8d 84 24 f8 05 00 00 48 89 44 24 10 48 8b 00 48 89 c5 <4c> 8b 68 18 66 41 83 3f 0a 75 71 45 31 ff 4c 89 ef 31 f6 e8 5c 76
[  224.153246] RSP: 0018:ffffb00ec060fd18 EFLAGS: 00010246
[  224.153427] RAX: 0000000000000000 RBX: ffff8c06c2e53e40 RCX: 0000000000000001
[  224.153652] RDX: ffff8c073bca2408 RSI: 0000000000000282 RDI: ffff8c06c259ee00
[  224.153868] RBP: 0000000000000000 R08: ffffffff9da55aa0 R09: 0000000000000001
[  224.154084] R10: 00000034306c30f1 R11: 0000000000000002 R12: ffff8c06c2e51800
[  224.154300] R13: ffff8c06c355d400 R14: 0000000004208160 R15: ffff8c06c2e53820
[  224.154521] FS:  0000000000000000(0000) GS:ffff8c073bd00000(0000) knlGS:0000000000000000
[  224.154763] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  224.154940] CR2: 0000000000000018 CR3: 0000000062c1e000 CR4: 0000000000750ee0
[  224.155157] PKRU: 55555554
[  224.155244] Call Trace:
[  224.155325]  <TASK>
[  224.155395]  ? __die_body+0x68/0xb0
[  224.155507]  ? page_fault_oops+0x34c/0x3a0
[  224.155635]  ? _raw_spin_unlock_irqrestore+0xe/0x40
[  224.155793]  ? exc_page_fault+0x7a/0x1b0
[  224.155916]  ? asm_exc_page_fault+0x26/0x30
[  224.156047]  ? xs_tcp_tls_setup_socket+0x3cc/0x7e0 [sunrpc ae3a15912ae37fd51dafbdbc2dbd069117f8f5c8]
[  224.156367]  ? xs_tcp_tls_setup_socket+0x2fe/0x7e0 [sunrpc ae3a15912ae37fd51dafbdbc2dbd069117f8f5c8]
[  224.156697]  ? __pfx_xs_tls_handshake_done+0x10/0x10 [sunrpc ae3a15912ae37fd51dafbdbc2dbd069117f8f5c8]
[  224.157013]  process_scheduled_works+0x24e/0x450
[  224.157158]  worker_thread+0x21c/0x2d0
[  224.157275]  ? __pfx_worker_thread+0x10/0x10
[  224.157409]  kthread+0xe8/0x110
[  224.157510]  ? __pfx_kthread+0x10/0x10
[  224.157628]  ret_from_fork+0x37/0x50
[  224.157741]  ? __pfx_kthread+0x10/0x10
[  224.157859]  ret_from_fork_asm+0x1b/0x30
[  224.157983]  </TASK>

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 net/sunrpc/xprtsock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 71cd916e384f..a15bf2ede89b 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2672,6 +2672,10 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
 	rcu_read_lock();
 	lower_xprt = rcu_dereference(lower_clnt->cl_xprt);
 	rcu_read_unlock();
+
+	if (wait_on_bit_lock(&lower_xprt->state, XPRT_LOCKED, TASK_KILLABLE))
+		goto out_unlock;
+
 	status = xs_tls_handshake_sync(lower_xprt, &upper_xprt->xprtsec);
 	if (status) {
 		trace_rpc_tls_not_started(upper_clnt, upper_xprt);
@@ -2681,6 +2685,7 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
 	status = xs_tcp_tls_finish_connecting(lower_xprt, upper_transport);
 	if (status)
 		goto out_close;
+	xprt_release_write(lower_xprt, NULL);
 
 	trace_rpc_socket_connect(upper_xprt, upper_transport->sock, 0);
 	if (!xprt_test_and_set_connected(upper_xprt)) {
@@ -2702,6 +2707,7 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
 	return;
 
 out_close:
+	xprt_release_write(lower_xprt, NULL);
 	rpc_shutdown_client(lower_clnt);
 
 	/* xprt_force_disconnect() wakes tasks with a fixed tk_status code.
-- 
2.42.0

