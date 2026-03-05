Return-Path: <linux-nfs+bounces-19801-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGCNLeOZqWm7AgEAu9opvQ
	(envelope-from <linux-nfs+bounces-19801-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 15:57:39 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A44C0213FAD
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 15:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D84C53067AD5
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4933ACA46;
	Thu,  5 Mar 2026 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZrOJCQl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FEF3A9D9E;
	Thu,  5 Mar 2026 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722269; cv=none; b=Os/YoLsXIAd33yU63YPh1yfPOAnN+gqGXV6HN6AkC8Upa4N/QjTD0Q0tPiZsisTW/lACsfOMfHAVhJYsjoiOOoBkgOUnNLR//AMCrasng0f0RlYp4UbBH/D7bIkLSxWW+O7L321iJt9U1SMauGKGEP1XUDZ1w7SKAAoJ8IU9Gq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722269; c=relaxed/simple;
	bh=JhNI3uLIe+HscvLElfDY7j7edv7/hA6m2Mcu+1L3lKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ifj5NJSF4mDlRwr1Lfp1XcTRzGHCJ8YktGQ1+uSoO8JsX4JBzTo7yDU9PLpBtwpYVMjX93Or8Gpd1rOXFBSES0QRkZ2BtCVfnasCYqtPrYc9Zj6bJaA4Tf/RoqlLjXHapQlaCNzK4WGrv8HR3cqhaJ87W50OS8/vVEBeVHjePoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZrOJCQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF47EC19423;
	Thu,  5 Mar 2026 14:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772722269;
	bh=JhNI3uLIe+HscvLElfDY7j7edv7/hA6m2Mcu+1L3lKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WZrOJCQlZ9x8kpIzig6LcQ/2bbLN+jmbANNSTxaAhGtBKqyCprD0V2r1WsJUVgIAc
	 HzDIjXvuLD2Xi+enyTFuPLJwe4eNS/1w6C8sLVTwSXhVoylpSryC7qZysuFsatkHi9
	 vKZmffdLUsoCg41XPazGoRKmCtems+P1kg3PaeRNi7BcHheOjKowQUqU/QrgLdo6PV
	 kRpBRflWphpouyB5/v4v99E/gbqnyo8ys9p36Wmhn98zc9HrJG4FjG5992qinKDkMU
	 5lQu7dQaCUTMqvVAxc/v1n0TRXGtnoRmqaGU1VEiuxqKKKIExMlwkmGeGJkWjJY2Ii
	 QVYYHEnaUJlmw==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	<linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 3/8] xprtrdma: Avoid 250 ms delay on backlog wakeup
Date: Thu,  5 Mar 2026 09:50:58 -0500
Message-ID: <20260305145054.7096-13-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305145054.7096-10-cel@kernel.org>
References: <20260305145054.7096-10-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=chuck.lever@oracle.com; h=from:subject; bh=6pyUQpuVLSBToOuVdJ5zWkakk4/utGhpsQKz929K/qI=; b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpqZhWlrcWStJfY0WLXFrjBf/nqK/fWjn5VyDsm /UrIZ0W1PWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaamYVgAKCRAzarMzb2Z/ lwULD/0XariwHfphPw8zxolWuduY3JKC4f+UI0vPT44olFrLAdQACuiCPozoHn8TG2OVQfwq/Zx /YfovpvX095bhM7phIc7G9skA3Ip4OcgJlDsxbG7J9d9e23RWdohuDSP+PfHA9oj8zShIGMdvBy BEnQgU2yNuUqI9GHVi1s9hgh2p52YaKcq/qtF5urTv4CITDyPX+HtsqYU0dNCnbRr/2C8SlFdC4 QApI+NmbVhdqC95uE8NWrpZGpQSYsWvy+tbH+AnUGYGJWIYk/m1hGVrXuDVFx7xPRRwZzymrO0h TwwBSfqjEVTTRmkIyTEfy7yrAgG0k89+NK2fl6O7UzoijZjytACUzL8B4JDmLJWWO3uPgVu0/Vd VIlIRDp81L93/wAL5Lg20s4nkF0BATQNDNI6QsypHs+G0TZuy5gO48mGFNI09KYo9V+KH/Jobh8 IO9DThqMNARSKUIkKQkdkmQbKdIDuuJZpCyl90ajOja5R842cWSAOuV7y9h9cVHuU43LeiBWd9k bJ+ByDoM0zInNpTqCg1fmDHpH2iSWi0Sb9Fhk2PxXhTHRjAseLlzbr7Hl3n+FIApun2plwECuP+ GJULeQAy+k23tGtGbYu3lt6v2tXNQsK5OKmM9jiq+3ksLSVaKJJwFr/VRF7MBkCOxHEbE3/YVgX q9lH0V65Wp8dqEQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A44C0213FAD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19801-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oracle.com:email]
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


