Return-Path: <linux-nfs+bounces-13798-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA2DB2DF58
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 16:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F16B1651D7
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24E12DEA61;
	Wed, 20 Aug 2025 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4K2FNL6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0DF2DE70B
	for <linux-nfs@vger.kernel.org>; Wed, 20 Aug 2025 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699938; cv=none; b=k/Q+/lI+icK8kcBTLO6H2tQwhNXodQCnOfy8c3H/n6k1AcyCSSU6n0c8agGfWw5lrOn7ghjQS6OIvq0H4dCSGJEoeIwmXAthjKCa0XdHL3WJf6U6E86S8GtP7JhDz2AmR+VVS0AoX8HddMMUQlSjT4OR3fTuTHEyEIX/UrWchpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699938; c=relaxed/simple;
	bh=rTtdsCkGlqi6v3CI2HvW2u469iTR6eeHLC5xk8ZyxSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJ2YbA+CkllJKDOQYfC2fStToHNPYVcmQ/cq8AXrwq4F9yZ6yJjlACw1qjEnjqnFZcWt61cYQwGp6IeQsOu2Q7LXueTLxccJfFoKH1I5KrrtxAZCsgrbkv+Vdg2uSvs9/f21+9I8sDnKBQOzxL+aN1dNz5PHOKDEb82fYmUT20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4K2FNL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935F1C113CF;
	Wed, 20 Aug 2025 14:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755699936;
	bh=rTtdsCkGlqi6v3CI2HvW2u469iTR6eeHLC5xk8ZyxSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S4K2FNL6Mw24ftfCGqD+iasnZ7CO1kC0YXwq2y7qk1Tyti4WD0vfX0yYvbLZWygrT
	 DRU/qEURM5xEqwjc7XQQ394s7/8ZMk4ARiSEz13m7lfLV+0jCBzAxEslQE6tPqQ7kb
	 NxKmVeaEadSNB+YYBR1MlVB+Jx0zoslbfs0fesUPolrLB1SWSSF3rMkRSdVYk0bMZe
	 kZg3P6NJvtkNuyimDqDPThR208660ObKiXCf/DHZomdP1LQkJLQ832UmPrNEEghoa4
	 RH0NT/BtJb23KJAe5lDWNt0ftAs+VlYnkFqTQGTJbm4SWgh+N/3BLh6K1Pjhp9IjVn
	 a+RvcrAa6Gk7A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 1/2] NFSD: Delay adding new entries to LRU
Date: Wed, 20 Aug 2025 10:25:31 -0400
Message-ID: <20250820142532.89623-2-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250820142532.89623-1-cel@kernel.org>
References: <20250820142532.89623-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Neil Brown observes:
> I would not include RC_INPROG entries in the lru at all - they are
> always ignored, and will be added when they are switched to
> RCU_DONE.

I also removed a stale comment.

Suggested-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index ba9d326b3de6..6c06cf24b5c7 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -237,10 +237,6 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
 
 }
 
-/*
- * Move cache entry to end of LRU list, and queue the cleaner to run if it's
- * not already scheduled.
- */
 static void
 lru_put_end(struct nfsd_drc_bucket *b, struct nfsd_cacherep *rp)
 {
@@ -453,8 +449,6 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct nfsd_cacherep *key,
 				nn->longest_chain_cachesize,
 				atomic_read(&nn->num_drc_entries));
 	}
-
-	lru_put_end(b, ret);
 	return ret;
 }
 
-- 
2.50.0


