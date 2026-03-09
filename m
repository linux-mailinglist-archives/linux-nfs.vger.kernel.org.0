Return-Path: <linux-nfs+bounces-19876-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNbxBCetrmntHQIAu9opvQ
	(envelope-from <linux-nfs+bounces-19876-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 12:21:11 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CB1237D27
	for <lists+linux-nfs@lfdr.de>; Mon, 09 Mar 2026 12:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C03FA300FEF7
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Mar 2026 11:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B8739A80A;
	Mon,  9 Mar 2026 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBXh9ums"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AC439B4B6
	for <linux-nfs@vger.kernel.org>; Mon,  9 Mar 2026 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055255; cv=none; b=oylaIVH5TpqKufl3NfswNONiR4UBj8GFLwklw+2yNJJ9JuxL2hRVAemYwOl8w+Yvl94jm/bzhIMHlBEMod4PWzaV2EPQh4QoHAbtyKNAZzNDn4I0DHhh6wOEvTXBeK+yrqxY+nflf/GSbxCnsJiO84mSn96vLBpvsmsIjOwHdt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055255; c=relaxed/simple;
	bh=wN87b0sS2HrldoFpqiLcr4k18HQojyR3aP0M3cEjZJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NAjJ+hY/XK8AJGlQd8AQodn/vVFsrCK/v5uZyd0pzt27J33Tb1I4cdlnyEEfkNHaosUQQEuCkGW68WAbvzN0MxriSiHN4fWfprBsCCoPcWhm+xFZZm2BgeET+FtmLkXew5RmcxhxrlibfxMlzt5YwOEL93SxNoQ5foxK7McHJLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBXh9ums; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c7059b9df33so4411788a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Mar 2026 04:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773055253; x=1773660053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sRo4gUuuqXEPBk2ckCAhWMzcsGZEb+oY+1jP8WL93Bs=;
        b=OBXh9umsauk2ijJkMN4iX7F5RKiwSuzpPMFcC6IM749Ov0z4oZWL+6y1Ja5k4oMnlP
         PccGA2qG7ZRHAFyKzl3TvBL5HEZtVnaF2GYilWnRY7ngBSmPnUIOO7Fp6NYfiQMGjsVC
         sC+UyE7TWuL6zXI6I2v63Lodmg/xEBqA5oLOpumyNI08+LtBS8p5ObYQml8i2+3Fecim
         7ht2/1EaAprf5wIxwDwDC0cBUSQP09s2CiZdDREJStg/wU4fSkVyZXBtg9gEZuAxDt11
         V+X7G3lonQAgOdCXlSIA4ybbs/gxV3sdbWFZNSZouKxSrjgERyM+PGvngNy7tccv2VHM
         7GeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773055253; x=1773660053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRo4gUuuqXEPBk2ckCAhWMzcsGZEb+oY+1jP8WL93Bs=;
        b=G6PaaoeU41C2OwlZ3hHO37eOkRmrlAJB8IKhANUUeX1XF9lRMzYIv+ctEjnqYIvAOU
         ZDGPP7M8OrGGkoP9AYubI3cNlCIUkEkOM63D3aSFbOw0vUbnBJ88UwMKrBfhg5ymPKrI
         gOcO0WVr+pt0ZhsxUV+CW6WEOWy+4oYPPv0ShLH523ZDS08k57yg9iRxYsHwePWPOjUM
         3c/LAUTqf9pD+ZFWPR5B4wrkQ1LzYW32LdQYuYKrRmUbBKi8ZQSVgm28UUJ+JubLdDP4
         VsLorsLAPgT1rq++73qBW+0915SouivmCa2XCO6Xy2VHsPWOVRiGWrxWXdz3GURqlb+G
         dhkQ==
X-Gm-Message-State: AOJu0Yx4wbW9tUtnmiPi/u9uRkg+udWRI3ZnSzOEFmsQGAys9N+Mk5CU
	7zeEhE4+sFDZ1FsZUEih+dN/yFwUsPmgooXvupmp5s7cshGDg+LQS15Bg27j1+912mob2Q==
X-Gm-Gg: ATEYQzzFT6KZcShq4OvNbO53hh/WB4aoK5bkhln9eEkMykUz0m4nJYMoVuBinSBpGIH
	LjeLMRlQGyOO3NIP39pfSlDCbppHlwSjbEOBxJfBJspdzNiTDunnrdzbYCeWE78QGBO3yzKZi30
	/Xg1/03eHPHjXQbL5gB7tn9bLLHXkNDuHHfqBkImYkC3HeRf1ue48wamYFEZLoU6y7uoGZKPYRb
	Vz4vtoO96mp+aRJz/w+a1FZtS1t6csEv6TvUvYCNAR8iHf6F1KK672Ao8bczNCShOZNdWAMHzWF
	eWiSot2bdJPDSHIXcVN3+On7HXyjXHSt75bcGlB1sxJW/0pXUpP7OK0VmAFM7WwV0cB4R6GgBA5
	GAST2cbiC1TSgwY4QV2nwrRIoul+Lx0InRNSOVDHGGGCNcn8pY8cKVSMGeqcYJadOWjCFj4+HWh
	ZqUETAha1iKj1xAhYHv5WbumlYJpS1J0kvYlRh6zEiwAVDbboOneA2fkDino2NKuLeMBKo8A==
X-Received: by 2002:a05:6a21:7182:b0:398:69a7:ba3a with SMTP id adf61e73a8af0-39869a7bcfcmr6577283637.16.1773055252848;
        Mon, 09 Mar 2026 04:20:52 -0700 (PDT)
Received: from henry-machine.taileee5f2.ts.net ([2408:8606:18c1:c673:8291:e4d6:2556:af63])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e16cebbsm8740234a12.16.2026.03.09.04.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:20:52 -0700 (PDT)
From: bsdhenrymartin@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] sunrpc: fix TLS connect_worker rpc_clnt lifetime UAF
Date: Mon,  9 Mar 2026 19:19:53 +0800
Message-ID: <20260309112041.1336519-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 22CB1237D27
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,redhat.com,talpey.com,davemloft.net,google.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-19876-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bsdhenrymartin@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.984];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Henry Martin <bsdhenrymartin@gmail.com>

In xs_connect(), transport->clnt is assigned from task->tk_client
without taking a reference when a TLS connect worker is queued.

If the RPC task finishes before connect_worker runs, tk_client can be
released and its cl_cred can be freed. Later, xs_tcp_tls_setup_socket()
dereferences upper_clnt->cl_cred and passes it to rpc_create(), where
rpc_new_client() calls get_cred() and triggers a slab-use-after-free.

[   93.358371] ==================================================================
[   93.359597] BUG: KASAN: slab-use-after-free in rpc_new_client+0x387/0xdcc
[   93.360748] Write of size 4 at addr ffff88810d67bfa8 by task kworker/u4:4/44
[   93.361919] 
[   93.362225] CPU: 0 UID: 0 PID: 44 Comm: kworker/u4:4 Tainted: G                 N  7.0.0-rc3 #2 PREEMPT(full) 
[   93.362297] Tainted: [N]=TEST
[   93.362313] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   93.362348] Workqueue: xprtiod xs_tcp_tls_setup_socket
[   93.362433] Call Trace:
[   93.362447]  <TASK>
[   93.362462]  dump_stack_lvl+0xad/0xf9
[   93.362513]  ? rpc_new_client+0x387/0xdcc
[   93.362574]  print_report+0x171/0x4d6
[   93.362653]  ? __virt_addr_valid+0x353/0x364
[   93.362719]  ? srso_alias_return_thunk+0x5/0xfbef5
[   93.362784]  ? kmem_cache_debug_flags+0x11/0x26
[   93.362839]  ? srso_alias_return_thunk+0x5/0xfbef5
[   93.362913]  ? srso_alias_return_thunk+0x5/0xfbef5
[   93.362978]  ? kasan_complete_mode_report_info+0x1c2/0x1d1
[   93.363057]  ? rpc_new_client+0x387/0xdcc
[   93.363122]  kasan_report+0xb3/0xe2
[   93.363202]  ? rpc_new_client+0x387/0xdcc
[   93.363266]  __asan_report_store4_noabort+0x1b/0x21
[   93.363339]  rpc_new_client+0x387/0xdcc
[   93.363399]  ? __sanitizer_cov_trace_pc+0x24/0x5a
[   93.363451]  rpc_create_xprt+0x1ac/0x3b4
[   93.363519]  rpc_create+0x5f9/0x703
[   93.363588]  ? __pfx_rpc_create+0x10/0x10
[   93.363654]  ? __sanitizer_cov_trace_pc+0x24/0x5a
[   93.363706]  ? __pfx_default_wake_function+0x10/0x10
[   93.363808]  ? __dequeue_entity+0x5d2/0x6c3
[   93.363887]  ? srso_alias_return_thunk+0x5/0xfbef5
[   93.363952]  ? srso_alias_return_thunk+0x5/0xfbef5
[   93.364016]  ? write_comp_data+0x2e/0x8e
[   93.364063]  xs_tcp_tls_setup_socket+0x476/0xff0
[   93.364151]  ? srso_alias_return_thunk+0x5/0xfbef5
[   93.364217]  ? __pfx_xs_tcp_tls_setup_socket+0x10/0x10
[   93.364315]  ? srso_alias_return_thunk+0x5/0xfbef5
[   93.364386]  ? __kasan_check_write+0x18/0x1e
[   93.364468]  ? srso_alias_return_thunk+0x5/0xfbef5
[   93.364540]  ? set_work_data+0x70/0x9c
[   93.364603]  process_scheduled_works+0x66c/0xa15
[   93.364699]  ? __sanitizer_cov_trace_pc+0x24/0x5a
[   93.364763]  worker_thread+0x440/0x547
[   93.364867]  ? srso_alias_return_thunk+0x5/0xfbef5
[   93.364937]  ? __pfx_worker_thread+0x10/0x10
[   93.365024]  kthread+0x375/0x38a
[   93.365097]  ? __pfx_kthread+0x10/0x10
[   93.365185]  ret_from_fork+0xa8/0x872
[   93.365247]  ? __pfx_ret_from_fork+0x10/0x10
[   93.365309]  ? __sanitizer_cov_trace_pc+0x24/0x5a
[   93.365364]  ? srso_alias_return_thunk+0x5/0xfbef5
[   93.365428]  ? __switch_to+0xc44/0xc5a
[   93.365509]  ? __pfx_kthread+0x10/0x10
[   93.365593]  ret_from_fork_asm+0x1a/0x30
[   93.365684]  </TASK>
[   93.365701] 
[   93.405276] Allocated by task 392:
[   93.405852]  kasan_save_stack+0x3c/0x5e
[   93.406581]  kasan_save_track+0x18/0x32
[   93.407230]  kasan_save_alloc_info+0x3b/0x49
[   93.407932]  __kasan_slab_alloc+0x52/0x62
[   93.408606]  kmem_cache_alloc_noprof+0x266/0x304
[   93.409359]  prepare_creds+0x32/0x338
[   93.409965]  copy_creds+0x188/0x425
[   93.410545]  copy_process+0x1022/0x5320
[   93.411208]  kernel_clone+0x23d/0x61a
[   93.411870]  __do_sys_clone+0xf8/0x139
[   93.412530]  __x64_sys_clone+0xde/0xed
[   93.413192]  x64_sys_call+0x33f/0x2105
[   93.413883]  do_syscall_64+0x1b3/0x420
[   93.414588]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   93.416895] 
[   93.417169] Freed by task 396:
[   93.417673]  kasan_save_stack+0x3c/0x5e
[   93.418321]  kasan_save_track+0x18/0x32
[   93.418972]  kasan_save_free_info+0x43/0x52
[   93.419652]  poison_slab_object+0x33/0x3c
[   93.420315]  __kasan_slab_free+0x25/0x4a
[   93.420973]  kmem_cache_free+0x1e5/0x2e4
[   93.421616]  put_cred_rcu+0x2e7/0x2f4
[   93.422219]  rcu_do_batch+0x5b6/0xa82
[   93.422833]  rcu_core+0x264/0x298
[   93.423475]  rcu_core_si+0x12/0x18
[   93.424086]  handle_softirqs+0x21c/0x488
[   93.424750]  __do_softirq+0x14/0x1a
[   93.425346] 
[   93.425612] Last potentially related work creation:
[   93.426358]  kasan_save_stack+0x3c/0x5e
[   93.427024]  kasan_record_aux_stack+0x92/0x9e
[   93.427739]  call_rcu+0xe4/0xb2b
[   93.428337]  __put_cred+0x13e/0x14c
[   93.428937]  put_cred_many+0x50/0x5e
[   93.429530]  exit_creds+0x95/0xbc
[   93.430099]  __put_task_struct+0x173/0x26a
[   93.430770]  __put_task_struct_rcu_cb+0x22/0x29
[   93.431513]  rcu_do_batch+0x5b6/0xa82
[   93.432144]  rcu_core+0x264/0x298
[   93.432737]  rcu_core_si+0x12/0x18
[   93.433345]  handle_softirqs+0x21c/0x488
[   93.434030]  __do_softirq+0x14/0x1a
[   93.434632] 
[   93.434910] The buggy address belongs to the object at ffff88810d67bf00
[   93.434910]  which belongs to the cache cred of size 184
[   93.436720] The buggy address is located 168 bytes inside of
[   93.436720]  freed 184-byte region [ffff88810d67bf00, ffff88810d67bfb8)
[   93.438582] 
[   93.438868] The buggy address belongs to the physical page:
[   93.439734] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10d67b
[   93.440982] memcg:ffff88810d67b0c9
[   93.441546] flags: 0x200000000000000(node=0|zone=2)
[   93.442327] page_type: f5(slab)
[   93.442878] raw: 0200000000000000 ffff88810088d140 dead000000000122 0000000000000000
[   93.444091] raw: 0000000000000000 0000010000100010 00000000f5000000 ffff88810d67b0c9
[   93.445365] page dumped because: kasan: bad access detected
[   93.446334] 
[   93.446638] Memory state around the buggy address:
[   93.447505]  ffff88810d67be80: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
[   93.448748]  ffff88810d67bf00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   93.449973] >ffff88810d67bf80: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
[   93.451147]                                   ^
[   93.452039]  ffff88810d67c000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   93.453227]  ffff88810d67c080: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
[   93.454455] ==================================================================
[   93.577640] Disabling lock debugging due to kernel taint
[ 1206.114037] kworker/u4:1 (26) used greatest stack depth: 24168 bytes left

Fix this by taking a client reference when queuing a TLS connect worker
and dropping that reference when the worker exits. Also release any
still-pinned client in xs_destroy() after cancel_delayed_work_sync() to
cover the case where queued work is canceled before execution.

Fixes: 75eb6af7acdf ("SUNRPC: Add a TCP-with-TLS RPC transport class")
Cc: stable@vger.kernel.org # 6.5+
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/sunrpc/xprtsock.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 2e1fe6013361..6bf1cf20a86e 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1362,6 +1362,10 @@ static void xs_destroy(struct rpc_xprt *xprt)
 	dprintk("RPC:       xs_destroy xprt %p\n", xprt);
 
 	cancel_delayed_work_sync(&transport->connect_worker);
+	if (transport->clnt != NULL) {
+		rpc_release_client(transport->clnt);
+		transport->clnt = NULL;
+	}
 	xs_close(xprt);
 	cancel_work_sync(&transport->recv_worker);
 	cancel_work_sync(&transport->error_worker);
@@ -2758,6 +2762,8 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
 out_unlock:
 	current_restore_flags(pflags, PF_MEMALLOC);
 	upper_transport->clnt = NULL;
+	if (upper_clnt != NULL)
+		rpc_release_client(upper_clnt);
 	xprt_unlock_connect(upper_xprt, upper_transport);
 	return;
 
@@ -2805,7 +2811,11 @@ static void xs_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 	} else
 		dprintk("RPC:       xs_connect scheduled xprt %p\n", xprt);
 
-	transport->clnt = task->tk_client;
+	if (transport->connect_worker.work.func == xs_tcp_tls_setup_socket) {
+		WARN_ON_ONCE(transport->clnt != NULL);
+		refcount_inc(&task->tk_client->cl_count);
+		transport->clnt = task->tk_client;
+	}
 	queue_delayed_work(xprtiod_workqueue,
 			&transport->connect_worker,
 			delay);
-- 
2.43.0

