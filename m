Return-Path: <linux-nfs+bounces-22910-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CNeJO/txRWqgAQsAu9opvQ
	(envelope-from <linux-nfs+bounces-22910-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 22:01:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7983F6F138A
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 22:00:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mi2Mjriz;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22910-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22910-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AC4930989BB
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2026 19:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE9038F93B;
	Wed,  1 Jul 2026 19:57:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4997348C5A;
	Wed,  1 Jul 2026 19:57:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935833; cv=none; b=QEZ1utBsodWeehoPh5Uz2HHIEXqv0t4LanYXOZt5EGw/zo2BLFyI1C3KCK5qbLwLWZrRkwMzJQKqfZC3KUt20OKZSSIjMSpGlpy2dXlohqxrLjqqIWnpGtQNw9OHj6CQGZKg7YGARa1IpHORM/YSGpjTYB/rUrIWi2yZnZPDaDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935833; c=relaxed/simple;
	bh=mDDQQFYiSv11Qo1XF/EgiJgTEdlvx/mVT1MBEhwz92I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UGBGKqx+7R0KcYr5HRiNmPQOKhqM6ZloxuA4iWIQ5S6SRnu/eZXa454fOMyOWv+ZAdkFxLZ6oVNusgqw9GK+yG74XG/1iKhIKwSnVGh9ms3WvSeOqNBcMBnNtn12RebIzRYE5JRzDxhDnLqyBLZM42w2RyFqsSBB+uhfkcStTMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi2Mjriz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CECF1F00A3A;
	Wed,  1 Jul 2026 19:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782935832;
	bh=ulF3Qt5D45+POJ71NlJ2SkChEKGLmNvr8KisLQGGIoY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mi2Mjriz9mL4KbdcRmXqIOopz1TiM3krrMJpMP0J+td5D5ZFceH8KHTO4/bd4d2z+
	 wiuSupJufIS1JfSk6rVRnLq4fJvLukWpsdRiRUSJbPWUUQT6QicK91lXl2ddWbBuZg
	 EeJUGcdaoECSRx/Wt/oAUm1VSXLAK5z6wI8gK818JkVprPfBf05vV3DqfEiLvPh7o9
	 Gzoyc29V3oPWd6Gz9+0RIRt404rf0UlPtSGBH9fGyIslsBqn0ZUr+D4l3O6ek5W9Nc
	 M+IfphdGaoJC3jz7v61QitBbgUOiGfIigKQVK2Jf8vZqCfxdPmQnBZG+4KxlSD7uhG
	 7pcc3TB0jGvvA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 01 Jul 2026 15:56:56 -0400
Subject: [PATCH v4 1/4] sunrpc: route to a populated pool in
 svc_pool_for_cpu()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-sunrpc-pool-mode-v4-1-b3d867e4c8f9@kernel.org>
References: <20260701-sunrpc-pool-mode-v4-0-b3d867e4c8f9@kernel.org>
In-Reply-To: <20260701-sunrpc-pool-mode-v4-0-b3d867e4c8f9@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2803; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mDDQQFYiSv11Qo1XF/EgiJgTEdlvx/mVT1MBEhwz92I=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqRXEV5R6z/BK8eJt8uv/JJ57PjxydWazwx8QqX
 c3KxIiSnaWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCakVxFQAKCRAADmhBGVaC
 FS7eEAC65j0Tmk93IPVFgGslvORDAVbymdedXSysnIhTbGt/UmzZP2BptWHPmFZvEeU0H2mGbCB
 DWge7S598t6+y/3TfD6+4bgHbt2QYeW+VQMHTCmIMBgNex/YFP90BY/wwt794eeos7T/hO82X+W
 D4keh9CLZ/sSHZD5XeHLM8b4vw7JKgdHoJPUknBhG3nxH5KI385DpPLjoIEBD5+U7L2ixr3Nles
 i28zshme7ELU21oFe8ItzoVavvHGbt7STIP+FXQhZTW7L8eM9S7WePQZOqKjzKiJZxFJuFRFZmo
 tdY8yc+e7K94jFvyXb8075ciSWg+p533KRoIfva25j1VAcw79Vcry8fthojg9t8rD1pQ4A6mMzZ
 zUwSVHRRr4BuImOtuOlJuz8EnLt4MguXj95m7qcOqyHFl42eFwx8jSx3LB89vfBVJH1BYCM4uSz
 kAVfpkRbNB9fA3DjFfjSLRWRJCagIJeIptSDM7tskFFI1YVgWMBzi/YtSrrnHCf4SjOiadhJNt8
 nF0ENU8CA8A34VqggVA7vViOPr2217hwsdSPRHiQeyHTNwNmlOQbCQkualIKBNj2E0xI6Nk4IKE
 9zW2iZtNhGhOikeuyFLaKQWLH08dSDl0OTE1xwJFhfytAjxqlqU1qFmqCTqx9yD6fEfuZHocp56
 PnL+AF1W93HqbPA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22910-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7983F6F138A

svc_set_num_threads() spreads the requested threads evenly across the
service's pools (base = nrservs / sv_nrpools).  When a service runs
fewer threads than it has pools -- e.g. an nfsd configured with fewer
threads than the host has NUMA nodes while running in "pernode" or
"percpu" mode -- the trailing pools are left with no threads at all.

svc_xprt_enqueue() selects a pool from the CPU servicing the transport,
queues the transport on that pool's sp_xprts, and only wakes a thread
from the same pool.  Each thread services exclusively its own pool, so a
transport that lands on a threadless pool is enqueued on sp_xprts and
never picked up: the connection hangs indefinitely.

Have svc_pool_for_cpu() skip pools that currently have no threads,
falling back to the next populated pool.  This trades NUMA locality for
a guarantee that the work is actually serviced.  sp_nrthreads is only
updated under the service mutex; the lockless read here is a best-effort
routing hint, so annotate it with data_race().

Fixes: 0f0257eaa5d2 ("svc: Move the xprt independent code to the svc_xprt.c file")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/svc.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index dd80a2eaaa74..82fb7faf563f 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -402,6 +402,7 @@ struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
 	struct svc_pool_map *m = &svc_pool_map;
 	int cpu = raw_smp_processor_id();
 	unsigned int pidx = 0;
+	unsigned int i;
 
 	if (serv->sv_nrpools <= 1)
 		return serv->sv_pools;
@@ -414,8 +415,31 @@ struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
 		pidx = m->to_pool[cpu_to_node(cpu)];
 		break;
 	}
+	pidx %= serv->sv_nrpools;
+
+	/*
+	 * Threads are spread evenly across the pools, but when there are
+	 * fewer threads than pools some pools can end up with none. A
+	 * transport enqueued on a threadless pool would never be picked
+	 * up, since each thread only services its own pool. Fall back to
+	 * the next populated pool, trading NUMA locality for a guarantee
+	 * that the transport is serviced.
+	 */
+	for (i = 0; i < serv->sv_nrpools; i++) {
+		struct svc_pool *pool = &serv->sv_pools[pidx];
+
+		/* This is set under the sp_mutex and rarely ever changes. A
+		 * data race here is harmless.
+		 */
+		if (data_race(pool->sp_nrthreads))
+			return pool;
+
+		if (++pidx >= serv->sv_nrpools)
+			pidx = 0;
+	}
 
-	return &serv->sv_pools[pidx % serv->sv_nrpools];
+	/* No pool has any threads; nothing can service the transport. */
+	return &serv->sv_pools[pidx];
 }
 
 static int svc_rpcb_setup(struct svc_serv *serv, struct net *net)

-- 
2.54.0


