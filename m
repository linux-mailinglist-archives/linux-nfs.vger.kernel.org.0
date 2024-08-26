Return-Path: <linux-nfs+bounces-5753-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4582995F218
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 14:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016E7283FD8
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 12:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FF718BBAC;
	Mon, 26 Aug 2024 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrLEccks"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F7718BB97;
	Mon, 26 Aug 2024 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676615; cv=none; b=jGQMuhCWdeoWKPoQmxPNtaEnV8wOYazXG4T4FNxghj4iinRRRUomqNt8ma3xBOpw9DhQXV5XLAdQDPgzxSyDOpWMoPi/9ZiD5LkFRkOR+u2U4CtYh/C+Zk6+5nDjBpd/AX8HlLfR+6wNYrnetGgQaRgWaCvYSOv+WFLABA6K674=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676615; c=relaxed/simple;
	bh=uX/vVKUZWx7C0IhR59T1sW5G6FbuARVCQ2QSeOWChrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oi5vDSH9fgpYgSefpVQuXtE7ieMp8vGzdYr/l9SbcOadrymoE7DN7n8LL6a5iUV9jhaVPIUKjvU1881w+BeffiZ3LZtH7wH56yJbjCWfENgnuZMxjxjBTi4e0PU/PzNYO483pYHEOEEV42LAZvG4lS80CscikTDtBq/3Ssu3p6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrLEccks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FFCC4FEF0;
	Mon, 26 Aug 2024 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724676615;
	bh=uX/vVKUZWx7C0IhR59T1sW5G6FbuARVCQ2QSeOWChrA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OrLEccksyqdhhi69bEerGQ6cSSpYqm7eyreWBeuo+LhEurso51M4OP7wGFaH/l+iM
	 Th8eujaI4goDs6kzgoef+a21p9z+wLGITMBJMjUwFxiDbQi2pV03+RRZW24ehofbTs
	 gn59HVUJwj4Iu4QrsDMviRhXB6GxnsCYtK1RItT5ES1lVQUso3X/HxEbZih24DXZZ5
	 TQ09Z0mOq0vdjIpHB4bGYJsa8kp6Frt0CxLMDrmhZxOvHBsT4pEQk5MzT9lt1wIctG
	 n1M6ocYKMA+ig4x/MqvQ3vJzJm8/IIkG2qzY2LdeRTSTVHQuGtn5gLvxWqNw3qov+p
	 qqp+4T9pZKJIA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 26 Aug 2024 08:50:11 -0400
Subject: [PATCH 1/3] nfsd: add more info to WARN_ON_ONCE on failed
 callbacks
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-nfsd-cb-v1-1-82d3a4e5913b@kernel.org>
References: <20240826-nfsd-cb-v1-0-82d3a4e5913b@kernel.org>
In-Reply-To: <20240826-nfsd-cb-v1-0-82d3a4e5913b@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=743; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=uX/vVKUZWx7C0IhR59T1sW5G6FbuARVCQ2QSeOWChrA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmzHoFDZVH1tpRPHbaIdVGOIdT5qpP/tPk5SDWx
 +GdrT5eJqOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZsx6BQAKCRAADmhBGVaC
 FWh5D/9+CM/Y3KA63VAgrlPq7Hv+Dh5GfwT6xbX0uQDetwXlgXCm8S2boR+tZ765rLtBpZ4y1y8
 NfhOm13EsRaI3vMWRl2OV+R4J7xjWcOHDoUTMmuuZ3ivFyRWoaDM8nknO7vI6V3A+/EO0hPZeph
 jIEpC9M1iSa55tP2W7kVzNmhRiCquh/ThACzAVMgPFbthw5xJxt8O3ERtEbMXstqWphe/XiuWID
 CxyroemAqArBwDovo2oY+bqtZIi7j1Ih7mtfSeRXDcfwGLSIc1jUEokZImsQ2pSfobw8Xl+4AaY
 L9X3HyZ8E//7aBB3gWEFmnRyNxYmpRSy6OWh/6QKQIhlAzpGWEYiWsCqMHS7wnzOeVbDW2X0RL7
 8kH8v9ZxzEFkVC9tb+FSdC+vV8mkbzXqMQ/QNB/RNPLgXZ1yG2l/icG4pHxT355wX4cT93lQTUd
 mkBSk4ND4sshtxGEnaLjD1XZXGGYJiPlRiNP4E5cei5mlEk50/yUNTtzWpJxfpTIW9jS/uJf1CF
 AzGtrgDnoVIU+4UrE9pRZbEXSOjE8Y5W1nFd6mBL1UCiA9R27bm4inB3K5JUdEmZjviKvr8Eoi0
 R+B35gV4ObmHWn7k8Xi5b9sG76Z6UTG8uIzASWAKUK6MLFTCubNwuFqdZafvdAIz1QZjA/OdbU9
 UK4YVl5mceLL8eA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently, you get the warning and stack trace, but nothing is printed
about the relevant error codes. Add that in.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index d756f443fc44..dee9477cc5b5 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1333,7 +1333,8 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 		return;
 
 	if (cb->cb_status) {
-		WARN_ON_ONCE(task->tk_status);
+		WARN_ONCE(task->tk_status, "cb_status=%d tk_status=%d",
+			  cb->cb_status, task->tk_status);
 		task->tk_status = cb->cb_status;
 	}
 

-- 
2.46.0


