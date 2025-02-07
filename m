Return-Path: <linux-nfs+bounces-9953-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD61A2D011
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 22:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0AA188CD0D
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 21:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E611C6FED;
	Fri,  7 Feb 2025 21:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDeCWKjU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9827D1C6FE3;
	Fri,  7 Feb 2025 21:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965252; cv=none; b=e6+ITlmXsvIs5TLwyJKpadeNaisj9mWqx/c1W5kdl5/ja+L5EovcR/eqXTcjM/rtUM7YDIhutJTpLCYEgH/2iM6Gd3J+Rp6dFxcQcyBzOyb7eyMEalVgHoKwnxCdI8PxzrmyJy90aqBHEt+DOUw7XJZsyTkeFiYXQ7kB0cxnJ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965252; c=relaxed/simple;
	bh=rYE4tMKbZCuJ2rA0LApyDiYeYob5TLUFY8D5uTiHLxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MC/z6p9QYfC55Z+kUx6KdZYtDTnq4xfrtbKaMmbnOn/2mZaofslDMTuleBKiC2+IK0pDICDxC3it0n2LPig2mODnkN0EJRHwQ1vUwhxOOsdjTqKFiEXC92oYIwbWrF8DOQN9HDQBd/hzn75NXqxNI0nrKii1a/VJfbH7274NFmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDeCWKjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398A9C4CEEA;
	Fri,  7 Feb 2025 21:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738965252;
	bh=rYE4tMKbZCuJ2rA0LApyDiYeYob5TLUFY8D5uTiHLxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pDeCWKjUUxRak9aQhP977kJN5vCDcUAqusO2SbFqUypksUB7BKG3oV3MGO/PULRdK
	 knOYPjUXPJgyZQNxGAqc3WKJhoUR1FBw8GYEXmKY0GzVpi6ejtEsptfGOb74CqonCy
	 kRtuYZ017JOyoe9NZqhBUAI51v7xCckk+Hi4k0C8KCu7a46k7ReNlDWxMHvmRlZtfN
	 XHicle2XqZUiti0X5CIbBTUjk8rOWO1LNkFksvf5hHjOF2C63lWsoPtZIKG1U7t5ND
	 fVyOECNvZ09HDw/KscON2ZH99RvLalPvW0QQ2UsjVgZzHIMH/niTS/wJp9MJsxixtA
	 Ot8xcRjMsdjSg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 07 Feb 2025 16:53:49 -0500
Subject: [PATCH v5 2/7] nfsd: always release slot when requeueing callback
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-nfsd-6-14-v5-2-f3b54fb60dc0@kernel.org>
References: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
In-Reply-To: <20250207-nfsd-6-14-v5-0-f3b54fb60dc0@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=851; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rYE4tMKbZCuJ2rA0LApyDiYeYob5TLUFY8D5uTiHLxw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnpoD/LVLzAB0xbkqJvMrCMkDu31EnQPMS2VWoR
 hkX0SeavpGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6aA/wAKCRAADmhBGVaC
 FW0KEADFmws4QYmEHY864MGTRyco6si6KjYIc1y+9qBmxwObmBbspi+GIZnySKb4Dz3wvMMTvWN
 O9zAV19oo5U9ZKj22fo+7ez9xwmKbnUmiB7R4XJ2w3TyApbPvy5fyvv5W3BCbGFlDUrYR+T4iI5
 TiYMvOeM4sQNHRsZYgNJ8nrUnFHEFcuSqRTKmLj78XFffPty/EiQGPmz+KESFUgE3LCld761up0
 pafRCo6LXqlIbmoZUjhQEPhLaQYQGphPyFoRLHo15V5Nm1R/a32osU5hLbXO4GwccyT5zmqb1Ko
 j6EtPJonKJhiXUPLoXHoeiSuRBkWyw0X44PNcrD/IXtrap7hs0QpeZtNFEmGkTmhiWa4RDp+tdV
 yuAGWzKPSofmyYB1ApyJPl87JTWUkfQo/JDnF+wA4hgHFD8bYeJWvfN3TLrb9YMt3DNUgmDJ3g/
 GjII/BJ1qk2BsWp4RW+Wr0o2RcfsUf4ui/3wfpbeV2TzEB0ZnjCoQzdC8DOnDFG+1HpkQqoRmID
 CADX8EZ8IXvp8LVNahAs1F9Rs/0DONDB2JuBrrqQdBKmxpDGTMram3Zm2/8STMTyrFFegpmCWTT
 sADFIm2cvGTDvxXdrIMnUW18o9GbMfXbN+8zVoNZ48C3VbN9DjhOHD+rFfMUvhUlHf2n8SYtqCo
 fwFHsYJC5XfmfXA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

If the callback is going to be requeued to the workqueue, then release
the slot. The callback client and session could change and the slot may
no longer be valid after that point.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 79abc981e6416a88d9a81497e03e12faa3ce6d0e..bb5356e8713a8840bb714859618ff88130825efd 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1411,6 +1411,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	rpc_restart_call_prepare(task);
 	goto out;
 requeue:
+	nfsd41_cb_release_slot(cb);
 	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
 		trace_nfsd_cb_restart(clp, cb);
 		task->tk_status = 0;

-- 
2.48.1


