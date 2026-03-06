Return-Path: <linux-nfs+bounces-19849-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HwOFcVNq2lYcAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19849-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 22:57:25 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3896228253
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 22:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 603FB30490F1
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 21:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577583ECBF8;
	Fri,  6 Mar 2026 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGF/5rmE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344A23ACEF3;
	Fri,  6 Mar 2026 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772834194; cv=none; b=bGXySnqu4xRBfEO8B+zyX//2Y6O5QCSzL9FZCegRPkzxTxO8r8ps8qo765yyrOT08KW30M4+PZ73DkFphNP0iUQccwkDOtXu5uVw53HQUJzEX6bFMpN7Lb28tWSh8PJP1vsY2o+NgoM7PChFvF0qRYun+yF3BHvde4nmnVUSpsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772834194; c=relaxed/simple;
	bh=JhNI3uLIe+HscvLElfDY7j7edv7/hA6m2Mcu+1L3lKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2deCUmXGK9FPTtRzJD6Zwpf8yayBR+GSFU78xSrOKnPHFhqjvNYTkov983G2LLR1+a0U/Qv2h0dQpxIvPiEXnXpjlphVHQbqFnzb/2RjmIeNLprYHKQLYy6mUf+BJ9FpHeWVeFYCjaEgcqQRIfNOLB47kp+hGNbKgYXkqrgIBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGF/5rmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4B2C2BCB0;
	Fri,  6 Mar 2026 21:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772834194;
	bh=JhNI3uLIe+HscvLElfDY7j7edv7/hA6m2Mcu+1L3lKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qGF/5rmEyf3+eozNE2UBLdDgOASoRpQW4MOKwlQ0dSSsyWPubkBZm+430XLnBiH2f
	 Air20mm4EZEBJRBh5mKGsmdQA1Dvk6pyMvNqzzasou6PvHtc9TW70laeHcCyFKXSQy
	 sHmbc5bOpMX4rNwS5hpdnSLhIA7VxqSSNKrACaa34LiIWg0avSSQcL9lvj6u3r27Le
	 /qdgbgciPYYjMD32HvYJTkYHFqN7PXR6OB9Uw6JzNPPpEiwjJtkCDM8sUw33h03c/p
	 bKxAXKrbyiiRK7gvmZap4DhFyJ5Zz8g/ZgjR83HpoBXcgN3rB3/2cfG9tpzgSl+jay
	 WYNa7m/ttoOCg==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	<linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 2/7] xprtrdma: Avoid 250 ms delay on backlog wakeup
Date: Fri,  6 Mar 2026 16:56:23 -0500
Message-ID: <20260306215620.3668-11-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306215620.3668-9-cel@kernel.org>
References: <20260306215620.3668-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=chuck.lever@oracle.com; h=from:subject; bh=6pyUQpuVLSBToOuVdJ5zWkakk4/utGhpsQKz929K/qI=; b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpq02MlrcWStJfY0WLXFrjBf/nqK/fWjn5VyDsm /UrIZ0W1PWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaatNjAAKCRAzarMzb2Z/ l5LcEACWrybvHNXZfml/9QPwYv4hq5XNRb0Zk1t2/P33UZbtamI8jENqcU8ojDV8QzdRzVMINWJ Vob1vE1Nm1ai8cQzu33YYMXDoIYgjeiBLyoumLSxXJ+71xh2i1+Scv/7/0QouD6utxTudU0mB58 HiLBhu4WDJWlGjcwDJ+Ul548kZF3iM5lpyilOpH5SLS+Reu+Tf5TPIvLXS9FgD888u1qIPf4ot0 mO/7QA27XzlFkfhFv2DRoO4zwvgw5q75ANX4uzP5F9u4v2/V4mA59EhQU1+JQdSW724KEnTyTV5 /OXGdT1iFtItoD2kidl68QRLWjIuCE2ZoWadnB5Duq3cR4C1OUlYztca+q2R81yLkD1rGOMWjpm mkfXetlV4JwJn/WsOyDlVofEHjFonp+chmZrij7fns2PCtrqZCKCU0CZvaCwyUybJY/ARkmpFRR rexTxnvEXkb2gvPZMg2qvgxV++Z/SRFfvxFxDk0twtLpjOuWH5gP0vzkb2eemhtF5QQCDySF74I RvDiHZQwaPIkGHpc+TLK0Q9ZKxt1a5lKr4uW2EtbbNJOX31F5Qv8EraZ6XVecJ1IsyEXmbq4X4l NF9eWn6j+VfJHpfCj6C4RgxfqdyivHXg42i5aoWyDM6nLO5XrTpNVwNVkB7m/77lRckp2UDs/0n agVKPKbEReI3Pbg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B3896228253
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19849-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.984];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Commit a721035477fb ("SUNRPC/xprt: async tasks mustn't block waiting
for memory") changed xprt_rdma_alloc_slot() to set tk_status to
-ENOMEM so that call_reserveresult() would sleep HZ/4 before
retrying.  That rationale applies to xprt_dynamic_alloc_slot(),
where an immediate retry under memory pressure wastes CPU, but not
to the RDMA backlog path: a task woken from the backlog has a slot
waiting for it, so the 250 ms rpc_delay adds latency without
benefit.

This also aligns the code with the existing kernel-doc for
xprt_rdma_alloc_slot(), which already documented %-EAGAIN.

Fixes: a721035477fb ("SUNRPC/xprt: async tasks mustn't block waiting for memory")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 9a8ce5df83ca..ca079439f9cc 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -510,7 +510,7 @@ xprt_rdma_alloc_slot(struct rpc_xprt *xprt, struct rpc_task *task)
 	return;
 
 out_sleep:
-	task->tk_status = -ENOMEM;
+	task->tk_status = -EAGAIN;
 	xprt_add_backlog(xprt, task);
 }
 
-- 
2.53.0


