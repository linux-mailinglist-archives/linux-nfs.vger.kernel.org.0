Return-Path: <linux-nfs+bounces-17061-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F37ECB9F70
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 23:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D14130022CD
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 22:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6F32D9EE6;
	Fri, 12 Dec 2025 22:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfsBUhwD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A418D2C08DF;
	Fri, 12 Dec 2025 22:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579188; cv=none; b=WWTWWyScKQVb046BL8QSu2HXfyc29KdzLuBViODPbXFJRaI0JZvhexHv+nSu6OF/zGGK24ybkbRpRuFExdy0MCfLZC4d1ljuzi69mN7chPHZyu2aFAHYnENrefDLGNINGy3HrMTOmzS8o2Q3cT7zHfkWzfIoMCrKXxWiIRHgfTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579188; c=relaxed/simple;
	bh=PBKOld62qb3aIXy84QE4/Vk+CdaXTEqGox5SaOfThHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXqAxZsWDRXi3hQTunYLj7ifxC2vjW2yXiuRbt5FYn0F6bnWjMJY6iWEQJuvzCNarXjtTWlvk31pOZiqXr58Z1SmATCVqSVAD1Eo0gkvSq5vUI/S5ILG8iM2KtMhDO0SvufNLzHwC5cuUqvg5fYYn0yBaBXMO5BtMhP7Rj9VXTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfsBUhwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05152C4CEF5;
	Fri, 12 Dec 2025 22:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765579187;
	bh=PBKOld62qb3aIXy84QE4/Vk+CdaXTEqGox5SaOfThHc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mfsBUhwDIDqsp85o5x8bVDDKZO+7PN92uUjLWiNMZOYqOsq8x3qawibnc4cGhz/Qk
	 25jN+bc1qYuIT1RcVqdTQIAsYVZWYWS7yMZnBCfu4gRGKbcX44ZwOP2HK0kZIaXPtU
	 tSVpsOK2XcvXA1iJFphbUiZ2bMSx/YGy0hzuENhvAYlJHAQqJoZi/qtjl45x1KcOb8
	 q9H7GLaB02IRGYGefTceI/JIyjRpvYwJZgXGdjUYXigc3rXTQP3rDWpuLg/CdWX9mN
	 z1d1+8qt5Z1DA8Z4+JCa1Yq5FGx2VS4GT47xy1F7J59bdo/r6kUlKLLxJ05Ivo6Bze
	 tcD6tsNy0zNkQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 13 Dec 2025 07:39:15 +0900
Subject: [PATCH RFC 3/6] sunrpc: track the max number of requested threads
 in a pool
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251213-nfsd-dynathread-v1-3-de755e59cbc4@kernel.org>
References: <20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org>
In-Reply-To: <20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=PBKOld62qb3aIXy84QE4/Vk+CdaXTEqGox5SaOfThHc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpPJmoQYoeeQc4T9DkAvMsTkadnS0nwtEAyMVPF
 HTG+B5OFRCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaTyZqAAKCRAADmhBGVaC
 FSbmD/4lAqmiBjKc83UVvYOunR+6KzIz/U4Q5BBUxJ5jneRxcZdldc9qPNF82pmOM1ITjU0PfT6
 mY8ysicZDTWvABjbHBMGMsuhmzBaVHFTb423x5ig4Upau20HeXitgFe758zo1sXSNtfWW0NvKm9
 ERNBxV4mCr45CBgewHz3tqG0dzHOrE2RoAmTVPaWuupQcAIpZvZX9OVVdZiGFJgHDrtnM7E2MEF
 LkSIO/sXVIY0gOBohxsQr4ufTDs9AVOGjpq/FsUAQMPaNTVHHeLKnZyEphr1QLHYuIth2B5Wn4n
 CbzHTzDlUc6iB5O/KuPZafAiDpJbRjxX/pzZjG/DLdjJlFIRWYsc5agu6IXfxUYi/ePVFf8YFc6
 J36kUmBwNOw9/MaE1bo5BTwUm78W5xjyLdJmj4qbtqq3TaHRrUoBpQ5Qb1yXxvjR/78kniQhIxb
 XrOS1714N9F+VigcQLp4wie9MWX7hdU83d1HN6ltH3wLsSjbrVzqWIsNfmYuJL0nBbgjVfyBnP1
 lwTGTnt3VMKpKwhVDWrwA0kgmJH9tzMdiMHRpwQq+pR6D/HlyRaoEHF5kNu5FbCwp3v68/2+djo
 pa8JPCySYeFOBJ4y9cwmQfjFeNjtrNz2EKziTXBDROB9Uy0JG+Q2s9TcMfUeYQga4tNajJDfYz/
 DJ3Rh4IIjOqABVQ==
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
index dd5fbbf8b3d39df6c17a7624edf344557fffd32c..ee9260ca908c907f4373f4cfa471b272bc7bcc8c 100644
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
index 3484c587a108e6f34e5c23edaf8f3a3c169c9e4a..8cd45f62ef74af6e0826b8f13cc903b0962af5e0 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -836,6 +836,7 @@ svc_set_pool_threads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 	if (!pool)
 		return -EINVAL;
 
+	pool->sp_nrthrmax = nrservs;
 	nrservs -= pool->sp_nrthreads;
 
 	if (nrservs > 0)

-- 
2.52.0


