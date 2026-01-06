Return-Path: <linux-nfs+bounces-17510-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4B3CFA6D4
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 20:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 994D3306305B
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 19:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AADE3491E8;
	Tue,  6 Jan 2026 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+QVc/VM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AD9311979;
	Tue,  6 Jan 2026 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767726010; cv=none; b=Y/eo96LMkIRA9IfqcuB3NPdGB718qNmwFXaSQaM7HZuDtURC3yN7DJGe4MM13gT/K7SZrv+lSul1Q683jYfzdENt4OZOtCAQKWSDm0qA338KGHOBb0qvi8pRSOgyaP5c7YGSOeEy5UWqU468+qgNBTxhqP3x0bm1MI6jHBckxAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767726010; c=relaxed/simple;
	bh=vkR4Lv0xih9xUoTlN5Xdz17Eso+qM+yd5777fHh4ssk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cf1uhzzg/nGMqIctzWJ/ZTC5+mx5Yg9FWS5ndFG8SuBnetf8iHaY09C7MDfYy5aKDEWvcjDdS9s/11tFjq/ZS7+FGFklpuKtdmCLJnXgcODP1VoHJeID6JOquHIkghSHONcIn/6BIi7zPJpaH9bIapuHUEbYO62N361SjYFQHhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+QVc/VM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58A0C19423;
	Tue,  6 Jan 2026 19:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767726009;
	bh=vkR4Lv0xih9xUoTlN5Xdz17Eso+qM+yd5777fHh4ssk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c+QVc/VME2W5sg/VBnVEUWf4+kI6gwhilNZJWtfXYov8juPbSw9pvTX5A4Guuy9t4
	 f2EMxEflF/jLxYHBlXdFWsxPwB6d5GpcnrqNWbS9b6l3XPXd3QqoLQ/RdkBjk+Dnei
	 WNaEqdafT9cOzN/SEMcuHnaKlBYSG5+aFydDuvGlBRE2sBgjlJJDOIn+T+i0qwjlvc
	 VGKsMC6e97Cdvk2xMzS8HNQ0tY6jdsHPSWF0zCfMiC/yT3Mv18QPd/VmybKraFqq6u
	 SV56y19WG5Q2fj8iEEZqj1DzvbhJUfzLbv6grQiW/HpMx6/2w662eaZ1UmVRBTYzta
	 LESDqmyf4dTVg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 06 Jan 2026 13:59:45 -0500
Subject: [PATCH v2 3/8] sunrpc: track the max number of requested threads
 in a pool
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-nfsd-dynathread-v2-3-416e5f27b2b6@kernel.org>
References: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
In-Reply-To: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vkR4Lv0xih9xUoTlN5Xdz17Eso+qM+yd5777fHh4ssk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpXVuzUUtl7H4j9RDi9s3TvD/DJimQrrasTpwgu
 CuZ/hw04mKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV1bswAKCRAADmhBGVaC
 FUtAD/0Ytz4T91VgSsroJMMDCUeyw4XGSGRmITR7dOvZ9EadWB7+petB6mTplU+sddikoxS7hWN
 2QVXDMbj1zD9JXbSN7jhyZ6Ma5yRmeahZ2yMvKXccDiPAJpIYbHs6TYJSvdtHhQJFm4P9HJIP8o
 lkOug9K/UTmMK15UlIkN2eQa5bRsbhwnhn7ujGh8e9wmt5yZLPGylvwXImNQps8EOcz05KnDibf
 xvee5tb2Kxm/M8XYvC/DIfPL/t7drcmDup8IWmsqPS34ITo0AMROlNqT++hRwrkRskGsQuhFBUS
 LRwbdNcOGKRxF9MZuhYL+94+SF92PQ+YMQj7yZR3sWSRMnoQPYUvD/mA60aE2zJ87K71Yxt3l/4
 JhJl8x81W8AutsZ7P7U3PIbBzDo6hcQVGqzVSmrjhz/e8onC/8s6/c4JofBQIF148XdXOtkHEV4
 kUVgG02Ix9eHHcHJp0O7nlaSHeUpRw3xOMn03hrh0GTRUeLegifljJ0A5S96DcUkKIJHOW9HrzK
 OyejLHnLtGqc+4udf0Y7hQcfUsaV2uir9fNGC/1cU1qkGWhCLZW57sNX9TI2IAF6vjISKmQ5YIN
 qiDZ0QKX8x0bkwkge/oWhEtYc92I/PzzUZJT1kTHqnfxSP3j+B1/dJUbeoorAuFg0Orxr1cf6gT
 hl7Ae10M7BLgNpQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The kernel currently tracks the number of threads running in a pool in
the "sp_nrthreads" field. In the future, where threads are dynamically
spun up and down, it'll be necessary to keep track of the maximum number
of requested threads separately from the actual number running.

Add a pool->sp_nrthrmax parameter to track this. When userland changes
the number of threads in a pool, update that value accordingly.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/svc.h | 3 ++-
 net/sunrpc/svc.c           | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 2676bf276d6ba43772ecee65b94207b438168679..ec2b6ef5482352e61a9861a19f0ae4a610985ae9 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -35,8 +35,9 @@
  */
 struct svc_pool {
 	unsigned int		sp_id;		/* pool id; also node id on NUMA */
+	unsigned int		sp_nrthreads;	/* # of threads currently running in pool */
+	unsigned int		sp_nrthrmax;	/* Max requested number of threads in pool */
 	struct lwq		sp_xprts;	/* pending transports */
-	unsigned int		sp_nrthreads;	/* # of threads in pool */
 	struct list_head	sp_all_threads;	/* all server threads */
 	struct llist_head	sp_idle_threads; /* idle server threads */
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index fd52ebec0655f2289d792f4aac02859d90d290fd..1f6c0da4b7da0acf8db88dc60e790c955d200c96 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -839,6 +839,7 @@ svc_set_pool_threads(struct svc_serv *serv, struct svc_pool *pool,
 	if (!pool)
 		return -EINVAL;
 
+	pool->sp_nrthrmax = nrservs;
 	delta -= pool->sp_nrthreads;
 
 	if (delta > 0)

-- 
2.52.0


