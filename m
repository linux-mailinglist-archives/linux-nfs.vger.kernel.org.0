Return-Path: <linux-nfs+bounces-9552-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA54BA1AB3E
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 21:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86D0F7A2142
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 20:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D0E1CAA95;
	Thu, 23 Jan 2025 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpVdgqlU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA461CAA8B;
	Thu, 23 Jan 2025 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663937; cv=none; b=iaYyY6wGbnp/qrirH9WNs9jHZPW+JN+wDRwsu6a2WPlPaA/Jd1Kk2EUw+jeVW0Fmf90EV51XwSYXISn3cfOps/+kWHh12alNm16SAf4NFZqOJ86PfVvTdI3WiiMt5eGJPFMSp42AWKY1jhQE9MoO6rKFKS+N8xXoMBTofacs8/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663937; c=relaxed/simple;
	bh=hSh7vdyXNyj5bYW6UhG0vRfyOLvJnGoh+PR/1QnbffE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Htt5HJIKCcORgroHvFqWuhiNkzRCo+1qicQJEen98Po25bMCgjigVYXV2Ks164qcEPxd4Ii2nTN0nDeAV6cYkUEmw2EeI6tCUcH4dGxmn3stFH8IJkke6QLr0/XwBUWeGwiyuIG5svPKssfv6udKqnRR3L5M29aEvfjg4AJzRIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpVdgqlU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEC6C4CEE3;
	Thu, 23 Jan 2025 20:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737663936;
	bh=hSh7vdyXNyj5bYW6UhG0vRfyOLvJnGoh+PR/1QnbffE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZpVdgqlUbTrVd1aIwkjRYEizZCzI/WdDB0aBPptb/he8rS1yULUMW5oaDqyut4Q5x
	 QC5cAJPjU+TMAK6JC5zi1ipQYkL7USGoH9gx9e4OSpJ/cXdd5lXB2NAo/3KNrcdEFi
	 iNqCMUsWz3N390qgp4UsQXDhgljIz2SwQ0UbAMvu3x3qeVJ4Km8uV6G5pf6NwYgbkF
	 +W3i/CiPhoVgRp1NqjJYL1MNffpX0S4Uy+a6HeAKLkGqM156AFyDkwEMXRF/VBHgLI
	 63ipwrWSEmeqasSxMWmlBChhKd2dH4RuN/mKQ+UkHOoJI5jYQl4BTES3s2CHh26wOY
	 DdBeAQojWeCnA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 23 Jan 2025 15:25:18 -0500
Subject: [PATCH 1/8] nfsd: don't restart v4.1+ callback when RPC_SIGNALLED
 is set
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-nfsd-6-14-v1-1-c1137a4fa2ae@kernel.org>
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
In-Reply-To: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Kinglong Mee <kinglongmee@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=hSh7vdyXNyj5bYW6UhG0vRfyOLvJnGoh+PR/1QnbffE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnkqW7SDyn7TBlzz79U9X+S1z1CofRlMnQ0dL+r
 MQsr4n9ejyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5KluwAKCRAADmhBGVaC
 FYzAD/0bAzcCczROFMOHRqXNmFmnIPIHJAUHUnShmKOF/JwuVNKO/d1IyCB79RZuCtEJ69oXyIV
 wSFUiqP4mNk4inTqfpJi2y+3NpOqAHjbilZ+BXsgRYjiR716NfeP60T4yGMKi2qXBW4LNY9XrZw
 NtkTTRsiWK4Kguz/loqPXD/Al3Qp5akRpi6rNHm/rogPPWGWMhZZE2MAZA3VrW0gfaI/Ue2t4VU
 382u1aJFeqWK28Q6bO3ZdI0rAMwDuUMqkm26cUxXTLsH5eDHcVRt9GD8nV8NKTe3TzUVg3Egrj2
 +1SSFk1h8jNyVYd1GNP/yFLKTVdrj8vxwx7umQuIvfxALKHKZvHpk5U0gd/2/Svmuc11ChYJzkV
 W+tOZDQ+DZ2DPH75GJx+Eq3TKZ5i+xhe2YuEjcGA3Cr4nP7pohI2V7zNhk4vqsTgmOBvKJsg2mE
 wtMJsplmuKLveky0N+w7D4Lb7YJahN6gn0ZqFUFX/47SwcH9dq5q27FLya6ImeP3quC9jRwqL7t
 KHQLusFwxjhDMjZhPc54inC7z3WN1/FgJdv9JttTJ1YKE/pz+AQX+aZLVbTsk54WC/E3sfAAyPK
 fpyH9UAYsy3QBE4yCHbrtIywlt8UMEzWd+ukkSH+T30Gm/HrNiSBP1tdPyoaVMYfNVJNEW6EY5X
 /eqmA6ihXy2C+gA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This is problematic, since the RPC might have been entirely successful.
There is no point in restarting a v4.1+ callback just because
RPC_SIGNALLED is true. The v4.1+ error handling has other mechanisms for
detecting when it should retransmit the RPC.

Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() for processing more cb errors")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 50e468bdb8d4838b5217346dcc2bd0fec1765c1a..e12205ef16ca932ffbcc86d67b0817aec2436c89 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1403,9 +1403,6 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	}
 	trace_nfsd_cb_free_slot(task, cb);
 	nfsd41_cb_release_slot(cb);
-
-	if (RPC_SIGNALLED(task))
-		goto need_restart;
 out:
 	return ret;
 retry_nowait:

-- 
2.48.1


