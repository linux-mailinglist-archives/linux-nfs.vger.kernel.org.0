Return-Path: <linux-nfs+bounces-10635-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94697A65FEF
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 22:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F58F3ABCDF
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 21:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3A02040BE;
	Mon, 17 Mar 2025 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of15iLVt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4AA204588;
	Mon, 17 Mar 2025 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245211; cv=none; b=Tgp6jXOVk+4gtF4fhTRtazWSKy3FB0vthkuPqBZFMPdbzxvhSTMuQ/PjEe50g8b+z3ZYrFey8K4taa7ux1531hOPIafAkEfD6rMwfJ5qmgn3Iy/gPUcWAs9SRsMJqwu3yGGEl9weP8TjkEU88uv3hHZjKeLNqKGde7Pnx75v2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245211; c=relaxed/simple;
	bh=Ns96+RGe273nraJ8gzjQKb0+xRtXkPKEmkrCxe31bqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ssH440yc/orWZaTyuMET2QEZyJ2NnLOdB6RnEnDlUPkt/vMNiYc0Kb1g1QooF9OJb6fMxh1b2p9/+CwnZKHQEYDZsi4MW6Kp2Wodl1D7WzLFbOfSKu2aPWJtL6HUkb87bLqCufIpEMF+/Cf2DK+mSqtz3YxOOCw/1oGli6LmabE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of15iLVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91375C4CEE3;
	Mon, 17 Mar 2025 21:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742245211;
	bh=Ns96+RGe273nraJ8gzjQKb0+xRtXkPKEmkrCxe31bqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Of15iLVtGgr69R2qx28PpV27sB0uz95koGBw/lW0QlinSb6F9Q93Y1kpF6O+S+IoW
	 zYpp82zROcbYybjcEJSc44CWxs94ssKvbXY3F6vjO4AXawQ4J64v2zvTqeftbNnDxd
	 +77igDWSQGtHUEgTHS5y0JV2XMKD7OO4d13jhk2PoviYjJvTo61kcxi69uciEB31xP
	 UGieJyI5PJPMsaVe6GxqX3Hg5qssJW8Jev6FeqPSN1a0JNinRmW11EAgN4dNPg8JP0
	 p6ZpIY+MJxk5R7UykWif/aQlsglgT//4UvRfeM0L+qbnxli+JaaLW4JgdCRnavZMUb
	 pdL7+t0F3nMwQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 17 Mar 2025 16:59:54 -0400
Subject: [PATCH RFC 2/9] lockd: add a helper to shut down rpc_clnt in
 nlm_host
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rpc-shutdown-v1-2-85ba8e20b75d@kernel.org>
References: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
In-Reply-To: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, 
 Benjamin Coddington <bcodding@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1812; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Ns96+RGe273nraJ8gzjQKb0+xRtXkPKEmkrCxe31bqU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn2I1UTR7ayWfZAPvYwSItpsKRM5A3zab+g8/Za
 0503n0vxfmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ9iNVAAKCRAADmhBGVaC
 FQeDD/4gNSL2p+8sfejzjr1xgyiVgmM0MswB4DtzBmLzO9ZuxMPBoaBbuwwLTg8wqdNaY9581le
 xAUlmV3x7pQyJJoY3KHHWeZqlcjWtU9/gvnEp80kzGC0BBLGLUvcHKrW52OYlNxwtSTSZIOfS/G
 3EPYdFNQHdSnuFZkMtUOznVKMIr9GT7l4FYF/cHbM4DO4nOD0DAR1tsQy8nvQ6TI1B3wY0cGtGn
 xgYQVG0CYp8NyTzJeakV6fFSuONPdxGtGtsd5hs0tjh/qvtqkP9n0vC+2nZ/6qzmZYGKNR+XQ46
 O94gyG3CdjYaSbwRqNpCkswLuJY1buI5mHDy72BGzTuYjx0Ngau1RgYCcD4WZd141zyvrTR4sAZ
 j119lU/Kq6gBu47kUgeEipXxcuyEAFjg0LopkpgNXNAIxcSLR1Pd2YI+sHrYnQkqw76v7gqblr3
 sgs0aI7t+BvZA3qxRK19KJpjIJThMIcUEen4xlZG3SP+4valqPY7mmlETcobhWk/pxeCfUR3fN8
 rSuYnoDEfAg1kw1TDQQ3eN+XE9QYQiLFfSS48LkGcx/Iz2IkxTSQp8YtIU3uDnumHKOjVshsWCD
 qwZ7YK2ozNVjBtc3F5pjiaCsr/jXfHdzVfZP38HebxnSL8m231pr3dAaZ2upIwaW5gSNGdEccap
 wSaKdKkCfV1ryaQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

NFS reaching into struct nlm_host is at least a minor layering
violation. Make an exported helper function and have nfs call that
instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/host.c             | 7 +++++++
 fs/nfs/sysfs.c              | 2 +-
 include/linux/lockd/lockd.h | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/lockd/host.c b/fs/lockd/host.c
index 5e6877c37f7303e7141fbb96bc278a207c8e5ddc..ed88c102eca0f999a9c5351467d823b806c30962 100644
--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -692,3 +692,10 @@ nlm_gc_hosts(struct net *net)
 		ln->next_gc = jiffies + NLM_HOST_COLLECT;
 	}
 }
+
+void
+nlm_host_shutdown_rpc(struct nlm_host *host)
+{
+	rpc_clnt_shutdown(host->h_rpcclnt);
+}
+EXPORT_SYMBOL_GPL(nlm_host_shutdown_rpc);
diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index c29c5fd639554461bdcd9ff612726194910d85b5..c0bfe6df53b51c0fcc541c33ab7590813114d7ec 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -254,7 +254,7 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
 		rpc_clnt_shutdown(server->client_acl);
 
 	if (server->nlm_host)
-		rpc_clnt_shutdown(server->nlm_host->h_rpcclnt);
+		nlm_host_shutdown_rpc(server->nlm_host);
 out:
 	return count;
 }
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index c8f0f9458f2cc035fd9161f8f2486ba76084abf1..6b8c912f443c3b4130f49b8170070d0b794abb94 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -248,6 +248,7 @@ void		  nlm_shutdown_hosts(void);
 void		  nlm_shutdown_hosts_net(struct net *net);
 void		  nlm_host_rebooted(const struct net *net,
 					const struct nlm_reboot *);
+void		  nlm_host_shutdown_rpc(struct nlm_host *host);
 
 /*
  * Host monitoring

-- 
2.48.1


