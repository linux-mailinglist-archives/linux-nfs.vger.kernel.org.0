Return-Path: <linux-nfs+bounces-9954-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1794A2D012
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 22:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA27188DA38
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 21:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1F91CF5E2;
	Fri,  7 Feb 2025 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM2Q3DaR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B111CAA8A;
	Fri,  7 Feb 2025 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965253; cv=none; b=uRpYlOV9SW9LRO4TYCzS6skMr97ldQuLKgdEC26PCDoDx4Ydwsv6dFsBrQG7Yck7fNIjC/AFFo06KZIf1kyTsqrf7wqsf5ZzXhcvWOG+bpCf9xdamXcSCQsAnjlZ/Z2dOP4QUq7+dSWTOnHKEx47kEHIVh6WKfZaYI5EecoibSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965253; c=relaxed/simple;
	bh=ebDzGzBR9ymwDefoCIAS8rZwgrFgMi9uVhnzOaYB/Ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GDvYeYaoSeT3SvJXaCLX4lTjqtTIKRqfVC7NViVqDikjJjNXQzvDCeHX+HVX8VqauU+cErzX6E1J5+KOVbDMSrsVb5x3Yb8vZxUmLbesIqHECSWIZ1bVF9PVhWnsVRgcx5516pxO0bjhH2Egx7x1U3CTX6Zk331gKli65rb2K6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM2Q3DaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDB5C4CEE2;
	Fri,  7 Feb 2025 21:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738965253;
	bh=ebDzGzBR9ymwDefoCIAS8rZwgrFgMi9uVhnzOaYB/Ks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DM2Q3DaRVnlAz0Jo04PhQ9wS8IoznOrMnU7ckq4prBgRZYlRavY0VLhQh73mMysOT
	 P8+31coYt9OPZETCBUBr8IP38cRyqcpqh3II/30ruG3xIygxulHLFpz78me/HSOV7P
	 mj2KX5J4NZlk/ObCrWDE20cSrfRnNAIyHPdtdvWq5tk/WzU8VTIX4wrAuxCEPNpX+i
	 lKL0HiRGw3C2ztcV7E0KcBgrfnZmn026HlGokd8/h8B2JmT0h+4NsqiPRrmBByAnNU
	 etwPY1fj1v86OtkGnCR93AbDYjJd9fN6ETe0Nh6ImLGDHJvKjLFYPUQpNYpL2R2PnB
	 ft72+i1CiXzUQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 07 Feb 2025 16:53:50 -0500
Subject: [PATCH v5 3/7] nfsd: only check RPC_SIGNALLED() when restarting
 rpc_task
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-nfsd-6-14-v5-3-f3b54fb60dc0@kernel.org>
References: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
In-Reply-To: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1908; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ebDzGzBR9ymwDefoCIAS8rZwgrFgMi9uVhnzOaYB/Ks=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnpoEA3ClMxUXuT5UxrKYb2FVYdAU9cfiaKCRZw
 GJVxE8h12yJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6aBAAAKCRAADmhBGVaC
 FaC1EACVjPoOrSwRxQUMysnEeXIzOK6kERemv2IsRrkMKOqssL1pHScTKaHlR5v5/OGKEVAc0BT
 12Q2BYpVws9OMjgKc1OEP0MuNSEpJmRq2IictkwMlKudEFvzRjIP2kBz1+hogsURxkUP+xdSdSA
 coTmMxGDZY1KR5+X0ad2qAyGMI6+2HLDhmFM0wkY7+ZHen2tgLkOaD8p3pJSHFyoxs76x2Jp0zq
 gfO0eftNxpezCq8HklVgQtCGew8yXpWXlC7nEe+tPUiMezXelZrSP+so1rUO68syR+CAmeJTNYL
 SntZ1FLxrMvJegoRKVjOdunpAYTal8gqHqlQtPAKlXMV6iNyloB0+ILgYOGKi5US9FGpaZwTmMY
 n9yCJK+uRT1SAmOajQJtOHvJkyYXh+4BKPhkahJY8BOO4EQSItqzAUgskVscF+RCFrdHxAMtayr
 hTZwKFda0qg3dzX8wL1DeUtauKTX/cHbRQttKoJcYwsTkm9B3iFP4XNNTjk3NcMXGAAT6SCXp+C
 jMffOO7x6ohFJAmsJQW2AMjYVXGD5AextdP6/gh7cMx3pnU/uuCG85yitf87QGPN+VJ4cP2nQ/V
 RMFpyj2t2zfurhEoZGMxGk2t4P4J5DSN6oh7RULpGcnPgwH72kaGAPiZUXPdMQ9y6mVXItwwz/G
 JhM59pcvEB9iQJw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

nfsd4_cb_sequence_done() currently checks RPC_SIGNALLED() when
processing the compound and releasing the slot. If RPC_SIGNALLED()
returns true, then that means that the client is going to be torn down.

Don't check RPC_SIGNALLED() after processing a successful reply.
Instead, only check that before restarting the rpc_task. If that returns
true, then requeue the callback.

Also, handle rpc_restart_call() and rpc_restart_call_prepare() failures
correctly, by requeueing the callback.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index bb5356e8713a8840bb714859618ff88130825efd..1e601075fac02bd5f01ff89d9252ab23d08c4fd9 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1385,8 +1385,8 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		goto requeue;
 	case -NFS4ERR_DELAY:
 		cb->cb_seq_status = 1;
-		if (!rpc_restart_call(task))
-			goto out;
+		if (RPC_SIGNALLED(task) || !rpc_restart_call(task))
+			goto requeue;
 		rpc_delay(task, 2 * HZ);
 		return false;
 	case -NFS4ERR_BADSLOT:
@@ -1402,14 +1402,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	}
 	trace_nfsd_cb_free_slot(task, cb);
 	nfsd41_cb_release_slot(cb);
-
-	if (RPC_SIGNALLED(task))
-		goto requeue;
-out:
 	return ret;
 retry_nowait:
-	rpc_restart_call_prepare(task);
-	goto out;
+	/*
+	 * RPC_SIGNALLED() means that the rpc_client is being torn down and
+	 * (possibly) recreated. Requeue the call in that case.
+	 */
+	if (!RPC_SIGNALLED(task)) {
+		if (rpc_restart_call_prepare(task))
+			return false;
+	}
 requeue:
 	nfsd41_cb_release_slot(cb);
 	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {

-- 
2.48.1


