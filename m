Return-Path: <linux-nfs+bounces-12009-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9DEACA5D4
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 02:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA29179F5F
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 00:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B7630FB3D;
	Sun,  1 Jun 2025 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnefh6ry"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6843630FB37;
	Sun,  1 Jun 2025 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821139; cv=none; b=YPqaXdMGbFur9JAm4NpE8mEM6MiXvzHZR48Ci3Sa1a3B9rcgBetMQ/uXqN8qQPOy1Zxt2FvAIJ6iuS5UKwaHdfZcyniNdU0Zi8tW5ZSVhEQlvA0sdGx/Rmv8rDQMC0hHkhgsH2WakqQwTzuEbed/HVYsxtqgMiLpKZs2NAYcn8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821139; c=relaxed/simple;
	bh=wVh88v7pQF73KC4iY1p6dTGalyDqKvbOLEg6xNauVWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqXbIgNoHP5/TJA9ucTOtxQwQSnJGgVpmx7kYxuCdkO0sghqr/MbPmjH9EtefG9F9krVEZVxGMdmeKWNBq/hA3k1CX2snOUq0PxRbQ91i1n8tnjvjJfKCBPSZ5pD4VQ+iGpttHjRgPIFJ4+UaRORtDtKo8MIsCc2kaITBwlvttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnefh6ry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC061C4CEEE;
	Sun,  1 Jun 2025 23:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821139;
	bh=wVh88v7pQF73KC4iY1p6dTGalyDqKvbOLEg6xNauVWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qnefh6ryN9LRfMk0tGA2tL6GMT17V0wwLl02owAZGMyKm2JxRZAyAPVPsr/OyNwre
	 hS16BjaXGuzWvTKqzFVqB5FKGOGDnWag0g5tZF144YqXMm+7fFk32iey4ZJzksXQps
	 sML2lwpwIzgZSUoqjBX9/1hI9B5Ae4D2rIVBayq92o47moPBsPbZsop4XzFz66qoHh
	 pCFTtuhv4xdgLq5hgjjuxa2Lha5deQ8Ss8tr4h9R6ln6bZtKkNH1LznNOcA2JOnaWV
	 4Wkr0M0cML/6p5Ngidk+sKHJ8VOvgKRROujB4LvfQsBM17yaypL8/sBm3mm50X4ZCo
	 ALjCXtlOZCVbw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Long Li <leo.lilong@huawei.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jlayton@kernel.org,
	trondmy@kernel.org,
	anna@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 31/66] sunrpc: fix race in cache cleanup causing stale nextcheck time
Date: Sun,  1 Jun 2025 19:37:08 -0400
Message-Id: <20250601233744.3514795-31-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601233744.3514795-1-sashal@kernel.org>
References: <20250601233744.3514795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.92
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Long Li <leo.lilong@huawei.com>

[ Upstream commit 2298abcbe11e9b553d03c0f1d084da786f7eff88 ]

When cache cleanup runs concurrently with cache entry removal, a race
condition can occur that leads to incorrect nextcheck times. This can
delay cache cleanup for the cache_detail by up to 1800 seconds:

1. cache_clean() sets nextcheck to current time plus 1800 seconds
2. While scanning a non-empty bucket, concurrent cache entry removal can
   empty that bucket
3. cache_clean() finds no cache entries in the now-empty bucket to update
   the nextcheck time
4. This maybe delays the next scan of the cache_detail by up to 1800
   seconds even when it should be scanned earlier based on remaining
   entries

Fix this by moving the hash_lock acquisition earlier in cache_clean().
This ensures bucket emptiness checks and nextcheck updates happen
atomically, preventing the race between cleanup and entry removal.

Signed-off-by: Long Li <leo.lilong@huawei.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Now let me analyze this commit in detail based on what I've learned:
**ANALYSIS:** **YES** - This commit should be backported to stable
kernel trees. ## Detailed Analysis: ### 1. **Bug Impact Assessment**
This commit fixes a **race condition** that can cause cache cleanup
delays of up to **1800 seconds (30 minutes)**. This is a significant
performance regression that affects the SUNRPC cache subsystem's ability
to clean expired entries in a timely manner. ### 2. **Root Cause
Analysis** The race condition occurs in the `cache_clean()` function
between these steps: - **Line 461**: `current_detail->nextcheck =
seconds_since_boot()+30*60;` (sets nextcheck to current time + 1800
seconds) - **Lines 466-469**: The code searches for non-empty buckets
**without holding hash_lock** - **Lines 479-496**: The code then
acquires `hash_lock` and processes entries, updating nextcheck based on
entry expiry times **The race window**: Between lines 466-469 and 479,
concurrent cache operations (like `sunrpc_cache_unhash()`) can remove
entries from buckets, making them empty. When `cache_clean()` later
acquires the hash_lock, it finds empty buckets and cannot update the
nextcheck time appropriately. ### 3. **Code Change Analysis** The fix is
**minimal and surgical**: ```c // BEFORE: hash_lock acquired late (line
479) if (current_detail && current_index < current_detail->hash_size) {
// ... variable declarations ... spin_lock(&current_detail->hash_lock);
// TOO LATE! // AFTER: hash_lock acquired early (before bucket search)
spin_lock(&current_detail->hash_lock); while (current_index <
current_detail->hash_size &&
hlist_empty(&current_detail->hash_table[current_index]))
current_index++; ``` This ensures that: 1. **Atomicity**: Bucket
emptiness checks and nextcheck updates happen atomically 2. **Race
prevention**: No concurrent entry removal can happen during bucket
scanning 3. **Correctness**: nextcheck times are updated based on the
actual state of buckets at scan time ### 4. **Risk Assessment** **Low
Risk**: - **Scope**: Changes only affect the locking order in
`cache_clean()` - **Backwards compatibility**: No API changes - **Side
effects**: Minimal - just holds the lock slightly longer, which is safe
- **Testing**: The change preserves existing logic while fixing the race
### 5. **Stable Tree Criteria Compliance** ✅ **Fixes important bug**:
30-minute cache cleanup delays significantly impact performance ✅
**Small and contained**: Only 12 lines changed in a single function ✅
**No architectural changes**: Just reorders lock acquisition ✅ **Minimal
regression risk**: The change is conservative and preserves existing
behavior ✅ **Clear side effects**: Only improves correctness, no
negative impacts ### 6. **Comparison with Similar Commits** Looking at
the historical examples: - **Similar to Commit #3 (YES)**: Fixes a race
condition with minimal code changes and clear correctness improvement -
**Unlike Commits #1,#2,#4,#5 (NO)**: Those were either reverted,
cosmetic, or changed behavior significantly ### 7. **Critical System
Impact** SUNRPC cache is used by: - **NFS client/server operations** -
**RPC authentication caching** - **Various network filesystem
operations** A 30-minute delay in cache cleanup can cause: - Memory
bloat from stale entries - Performance degradation - Potential service
disruptions **Conclusion**: This is a clear bug fix with minimal risk
that addresses a significant performance issue in a critical kernel
subsystem. It meets all criteria for stable tree backporting.

 net/sunrpc/cache.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 50013f0c9f2eb..0e0a2f46a7968 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -453,24 +453,21 @@ static int cache_clean(void)
 		}
 	}
 
+	spin_lock(&current_detail->hash_lock);
+
 	/* find a non-empty bucket in the table */
-	while (current_detail &&
-	       current_index < current_detail->hash_size &&
+	while (current_index < current_detail->hash_size &&
 	       hlist_empty(&current_detail->hash_table[current_index]))
 		current_index++;
 
 	/* find a cleanable entry in the bucket and clean it, or set to next bucket */
-
-	if (current_detail && current_index < current_detail->hash_size) {
+	if (current_index < current_detail->hash_size) {
 		struct cache_head *ch = NULL;
 		struct cache_detail *d;
 		struct hlist_head *head;
 		struct hlist_node *tmp;
 
-		spin_lock(&current_detail->hash_lock);
-
 		/* Ok, now to clean this strand */
-
 		head = &current_detail->hash_table[current_index];
 		hlist_for_each_entry_safe(ch, tmp, head, cache_list) {
 			if (current_detail->nextcheck > ch->expiry_time)
@@ -491,8 +488,10 @@ static int cache_clean(void)
 		spin_unlock(&cache_list_lock);
 		if (ch)
 			sunrpc_end_cache_remove_entry(ch, d);
-	} else
+	} else {
+		spin_unlock(&current_detail->hash_lock);
 		spin_unlock(&cache_list_lock);
+	}
 
 	return rv;
 }
-- 
2.39.5


