Return-Path: <linux-nfs+bounces-7411-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8538D9AD978
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 03:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6A61F21E5E
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Oct 2024 01:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920CC54279;
	Thu, 24 Oct 2024 01:55:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278C71BDDF;
	Thu, 24 Oct 2024 01:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729734932; cv=none; b=XBWAZ4jJLD5hx/7WHueH27WElU+glUTsFS64/wRYlqE+5yq9P+vUtNYj1EXXrnvRbZoATxtRZBvR5pEC+3eoixU1cfHoS5hCIhSI1N3o8B2nGs9KcJjrZo/velURBgJlKqXuWd59eYR8pZDP7h2btZ50jhiBEw1PqLBZRsZpwbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729734932; c=relaxed/simple;
	bh=ZFj4mUEuOcX5w4DA8ts0g9WAnUKoJnphHg4JubR5mow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cK1qukDpnGhS4YktW+XjmOltcXmDzVRCFaSJelxJG1OkjMXmlqtxzAm2Vxfm5DKH59NkJYO8axQgVzMKT80Ez3OfadkG4oeJ0bZe7R7SlMJ6tg+5rFUXAxGXPe40uTrcgoklGJwh83laRCIFMK+Dw2vF8mnPXb/mgCQoS284hjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XYprm6kXkz4f3lfk;
	Thu, 24 Oct 2024 09:55:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 35C1B1A07BA;
	Thu, 24 Oct 2024 09:55:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgDHR8QIqRlnEnfNEw--.48608S4;
	Thu, 24 Oct 2024 09:55:22 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	joel.granados@kernel.org,
	linux@weissschuh.net,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Cc: yebin10@huawei.com,
	zhangxiaoxu5@huawei.com
Subject: [PATCH] svcrdma: fix miss destroy percpu_counter in svc_rdma_proc_init()
Date: Thu, 24 Oct 2024 09:55:20 +0800
Message-Id: <20241024015520.1448198-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHR8QIqRlnEnfNEw--.48608S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZr43ZF43CFy5CFy3Jw4UXFb_yoW5Ary3pa
	43Kry5Jrs0krnakr43tws7uFyUAa18WF4Fg3Z7Cr1fZa1qkr98t3W0gayrJF97WrWfXryI
	qr1UW3Z8Ca98A3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0s2-5UUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

There's issue as follows:
RPC: Registered rdma transport module.
RPC: Registered rdma backchannel transport module.
RPC: Unregistered rdma transport module.
RPC: Unregistered rdma backchannel transport module.
BUG: unable to handle page fault for address: fffffbfff80c609a
PGD 123fee067 P4D 123fee067 PUD 123fea067 PMD 10c624067 PTE 0
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
RIP: 0010:percpu_counter_destroy_many+0xf7/0x2a0
Call Trace:
 <TASK>
 __die+0x1f/0x70
 page_fault_oops+0x2cd/0x860
 spurious_kernel_fault+0x36/0x450
 do_kern_addr_fault+0xca/0x100
 exc_page_fault+0x128/0x150
 asm_exc_page_fault+0x26/0x30
 percpu_counter_destroy_many+0xf7/0x2a0
 mmdrop+0x209/0x350
 finish_task_switch.isra.0+0x481/0x840
 schedule_tail+0xe/0xd0
 ret_from_fork+0x23/0x80
 ret_from_fork_asm+0x1a/0x30
 </TASK>

If register_sysctl() return NULL, then svc_rdma_proc_cleanup() will not
destroy the percpu counters which init in svc_rdma_proc_init().
If CONFIG_HOTPLUG_CPU is enabled, residual nodes may be in the
'percpu_counters' list. The above issue may occur once the module is
removed. If the CONFIG_HOTPLUG_CPU configuration is not enabled, memory
leakage occurs.
To solve above issue just destroy all percpu counters when
register_sysctl() return NULL.

Fixes: 1e7e55731628 ("svcrdma: Restore read and write stats")
Fixes: 22df5a22462e ("svcrdma: Convert rdma_stat_sq_starve to a per-CPU counter")
Fixes: df971cd853c0 ("svcrdma: Convert rdma_stat_recv to a per-CPU counter")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 net/sunrpc/xprtrdma/svc_rdma.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index 58ae6ec4f25b..11dff4d58195 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -233,25 +233,33 @@ static int svc_rdma_proc_init(void)
 
 	rc = percpu_counter_init(&svcrdma_stat_read, 0, GFP_KERNEL);
 	if (rc)
-		goto out_err;
+		goto err;
 	rc = percpu_counter_init(&svcrdma_stat_recv, 0, GFP_KERNEL);
 	if (rc)
-		goto out_err;
+		goto err_read;
 	rc = percpu_counter_init(&svcrdma_stat_sq_starve, 0, GFP_KERNEL);
 	if (rc)
-		goto out_err;
+		goto err_recv;
 	rc = percpu_counter_init(&svcrdma_stat_write, 0, GFP_KERNEL);
 	if (rc)
-		goto out_err;
+		goto err_sq;
 
 	svcrdma_table_header = register_sysctl("sunrpc/svc_rdma",
 					       svcrdma_parm_table);
+	if (!svcrdma_table_header)
+		goto err_write;
+
 	return 0;
 
-out_err:
+err_write:
+	percpu_counter_destroy(&svcrdma_stat_write);
+err_sq:
 	percpu_counter_destroy(&svcrdma_stat_sq_starve);
+err_recv:
 	percpu_counter_destroy(&svcrdma_stat_recv);
+err_read:
 	percpu_counter_destroy(&svcrdma_stat_read);
+err:
 	return rc;
 }
 
-- 
2.34.1


