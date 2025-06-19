Return-Path: <linux-nfs+bounces-12572-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C50C4AE023D
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jun 2025 12:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53709189DA15
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jun 2025 10:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEBB221725;
	Thu, 19 Jun 2025 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjfjdPwW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86421FF46;
	Thu, 19 Jun 2025 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750327321; cv=none; b=eZ8zu01lpIL2K32resoSPDVvGwPR84SxP4uUEjd3VSqNsXUs8h9efE1LlD1sxNQ22IFbWJWkmRUksF5Djst6E1N9p3P5rtK1dbgxFP5z99008ltThlM56n7lbVhMZutyguozZJzAuoPZ19sHjNTLpDNAkgInUDrJjA+KDTQm8ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750327321; c=relaxed/simple;
	bh=ST7t5hzEmHpR1U7XOZYCbUQ0PiUyXNCZEROguPp1Y5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R3KUX7/KClhRbxgw3hFvpCurS3oKeST1YGSN38wascw/7qtp9Vdb5zrXvYolCvK6dlnTxZ585P4OE2zZJEYq0+mU6i26QI7GvBd8nl1l8M14p5WmDvzzXPQ0E9Efk1wgBMDt9zVcIphvLrKB7zjeKCNXNg+zZw+xcsZxs5GAkO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjfjdPwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED462C4CEEA;
	Thu, 19 Jun 2025 10:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750327320;
	bh=ST7t5hzEmHpR1U7XOZYCbUQ0PiUyXNCZEROguPp1Y5I=;
	h=From:Date:Subject:To:Cc:From;
	b=CjfjdPwWXxGaNBeJ+CX9Mue6JIDQMzvchdJgrnAxR7QPmL6c4joD61endYe3543Ik
	 gpA5VvwnIdHpqG/QkiDs62n49i2HzE9fq3/HHeMcD36tihJO8/72n+4nYMked5AMU2
	 GSXUGVOOhqtrPB2O44zz6PrX11Mbzl6jOeSBSITkGQERXO/woAp5uskR9iLExkuUmQ
	 grAER8HkUrz0P1AyGF3uZYiI2PntiCvU/n3XMo+DPfiUDOoLjeDtH+l4VXWZPA/YFf
	 cUTvTkoNANYCqn+Z93LUcrE4rvjCYKPT9XI8Ayu6jEuw3JNRYAw1jOKZp60uQ+MamN
	 vOCOb/v713Brg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 19 Jun 2025 06:01:55 -0400
Subject: [PATCH] sunrpc: handle SVC_GARBAGE during svc auth processing as
 auth error
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-rpc-6-16-v1-1-9fd5e01637d3@kernel.org>
X-B4-Tracking: v=1; b=H4sIABLgU2gC/3WMQQ6CMBBFr0Jm7Rim1hZYeQ/jAsoAjQbI1DQaw
 t0t7Ex0+X7+ewsEFs8BqmwB4eiDn8YEdMjADfXYM/o2MahcnXNDFmV2aJAMOmdrdeLSlYYg3Wf
 hzr/21PWWePDhOcl7L0fa1h+RSEiYk2bdFG1NbC93lpEfx0l62CpR/TNVMkutLZumK0jpL3Nd1
 w91wdWO2wAAAA==
X-Change-ID: 20250617-rpc-6-16-cc7a23e9c961
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: tianshuo han <hantianshuo233@gmail.com>, 
 Linus Torvalds <torvalds@linuxfoundation.org>, security@kernel.org, 
 yuxuanzhe@outlook.com, Jiri Slaby <jirislaby@kernel.org>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2580; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ST7t5hzEmHpR1U7XOZYCbUQ0PiUyXNCZEROguPp1Y5I=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoU+AWlnSJkXb6un5sNyYXhumRHc2/lPyes8pY0
 UiTMCUN1+eJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaFPgFgAKCRAADmhBGVaC
 FW/WD/wJNfu2nSoAIJzPaPpZzuPwhmrgUqYxxqvRPbq98C3XExKSG140sg2rK8O0nTAbD5Ba1bb
 S/zrVIvZGMzkGyKRyVd9pbCVGisn0yeZfUbdFHHJAUJ4poxzhpu7s5PHz/qbnelRgUIqKUxWuhb
 sHtY2/0mXYB3c+tGPQGQtkVnRP/zMTK4jlQPHpTeu9zCQ+iYrTNCI4TfeSwUMCXrLav0Z8lf0OZ
 kFg9XpcASsaASZXMmxzS2n1weEEjqe9kklz9RumM3RLKTbnl1Lfc0fg3KnCYk/0Poucmr/ibcMq
 ScwilME5he3bc13qohoNLfjkke4VIHqywJnmMj2pBag6E+U5CZORCa1wJwpyvVpSE7663XlWxje
 0DceA/A8j3G9p2TWkGbNghx6m39vLJdZ839S27SbO0BURRVwRmI+ayp0+e87F/tuaiPqIQ+0Acd
 dU3X3o8txF7wnb/N0Vj9kRnJeK4ofH086YeIK6NaeLumlYffeu9ihsNeUON3TgXH35RDfJuXpoi
 MvFFQ5q/EY+V4it5d2nHUpOsmsX0xNmWMsaA2wLDBf3REyYQW/NnwQeTrRTMq5qrwSs7pBY82jJ
 MezH6QMhjI1aOQqf2LxpgB5ptaItfHMvo1dE+H/AYvnMWEK2lxe005ZR7Iqf9N8IG84z7gvNjgf
 UbWdD2zC9s0q1ew==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

tianshuo han reported a remotely-triggerable crash if the client sends a
kernel RPC server a specially crafted packet. If decoding the RPC reply
fails in such a way that SVC_GARBAGE is returned without setting the
rq_accept_statp pointer, then that pointer can be dereferenced and a
value stored there.

If it's the first time the thread has processed an RPC, then that
pointer will be set to NULL and the kernel will crash. In other cases,
it could create a memory scribble.

The server sunrpc code treats a SVC_GARBAGE return from svc_authenticate
or pg_authenticate as if it should send a GARBAGE_ARGS reply. RFC 5531
says that if authentication fails that the RPC should be rejected
instead with a status of AUTH_ERR.

Handle a SVC_GARBAGE return as an AUTH_ERROR, with a reason of
AUTH_BADCRED instead of returning GARBAGE_ARGS in that case. This
sidesteps the whole problem of touching the rpc_accept_statp pointer in
this situation and avoids the crash.

Cc: stable@vger.kernel.org
Fixes: 29cd2927fb91 ("SUNRPC: Fix encoding of accepted but unsuccessful RPC replies")
Reported-by: tianshuo han <hantianshuo233@gmail.com>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This should be more correct. Unfortunately, I don't know of any
testcases for low-level RPC error handling. That seems like something
that would be nice to do with pynfs or similar though.
---
 net/sunrpc/svc.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 939b6239df8ab6229ce34836d77d3a6b983fbbb7..99050ab1435148ac5d52b697ab1a771b9e948143 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1375,7 +1375,8 @@ svc_process_common(struct svc_rqst *rqstp)
 	case SVC_OK:
 		break;
 	case SVC_GARBAGE:
-		goto err_garbage_args;
+		rqstp->rq_auth_stat = rpc_autherr_badcred;
+		goto err_bad_auth;
 	case SVC_SYSERR:
 		goto err_system_err;
 	case SVC_DENIED:
@@ -1516,14 +1517,6 @@ svc_process_common(struct svc_rqst *rqstp)
 	*rqstp->rq_accept_statp = rpc_proc_unavail;
 	goto sendit;
 
-err_garbage_args:
-	svc_printk(rqstp, "failed to decode RPC header\n");
-
-	if (serv->sv_stats)
-		serv->sv_stats->rpcbadfmt++;
-	*rqstp->rq_accept_statp = rpc_garbage_args;
-	goto sendit;
-
 err_system_err:
 	if (serv->sv_stats)
 		serv->sv_stats->rpcbadfmt++;

---
base-commit: 9afe652958c3ee88f24df1e4a97f298afce89407
change-id: 20250617-rpc-6-16-cc7a23e9c961

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


