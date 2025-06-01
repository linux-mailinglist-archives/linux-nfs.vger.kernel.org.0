Return-Path: <linux-nfs+bounces-12002-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14264ACA14E
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 01:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7A41891F0B
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Jun 2025 23:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E12625A322;
	Sun,  1 Jun 2025 23:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/Pcb+1C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2654C25A2CF;
	Sun,  1 Jun 2025 23:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820295; cv=none; b=XxZho6l7lmbHLfMOErIJnyuZBeUalQur/oCr4geaowToXBVIdBBR5xwO+D245q/j0Uq9iVvdJlQ/HaIx1H1WPtL7cSsReeuikIslqospaTJSd2k5UZfuu7FCy8ztPYmZ8bYSYD9zpps6x9pcZiB+VTiaQq6SGVKeS/ElkF2sSAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820295; c=relaxed/simple;
	bh=3bkWV+zePza3ilN9VzWxZXyowwsJzz6V6pzRAqDmjWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F2/0Kj3SLvbvFWEwzC0wjQfNNCBU0oUgGoAkuam05p1WZjP7zmvyB70jJR50H4mvjZYkT8U64kPFqSqCjbRLPv/R8abLuZ9KtWdMsSNcOq6UJ8wBpIUflkANkj8FHE4reQBbGlfW2JyWPa96+IAyAMvXg2YWXT73V75cacJfx+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/Pcb+1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61120C4CEEE;
	Sun,  1 Jun 2025 23:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820295;
	bh=3bkWV+zePza3ilN9VzWxZXyowwsJzz6V6pzRAqDmjWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/Pcb+1CWaqcHm0sMfSVFxBohV8sp4Rmfl0xVm78upPAbitd9Cld7yNe8JRuoC4ZH
	 OSHYdZSZK8pCbUASiqKns+79kRED9nBU94UsFI6VYXNFiwQ5OldpTAGW0vGUYD9VT5
	 YomKlBySY3+NqIXcQat9Wa7L9GGtCvl8q166adaBEqRhdocKekTqc40FCxR+8XKqEL
	 8C1ZPsTEjHOIQyKJf6wob67WCG9Zw7Q5w2Bq83vSZNwkxg8fnQVL4DNRnQIlCQB8s/
	 8gqY8GrotBJvfQaroXPRPzkPZPOLT1SWVfQydtzXfUc78gMzd0gD3UdVsn0fXg4pmv
	 3rC0WgBXfQ34g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Long Li <leo.lilong@huawei.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	jlayton@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 007/110] sunrpc: update nextcheck time when adding new cache entries
Date: Sun,  1 Jun 2025 19:22:49 -0400
Message-Id: <20250601232435.3507697-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232435.3507697-1-sashal@kernel.org>
References: <20250601232435.3507697-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Transfer-Encoding: 8bit

From: Long Li <leo.lilong@huawei.com>

[ Upstream commit 5ca00634c8bbb2979c73465588f486b9632f5ed5 ]

The cache_detail structure uses a "nextcheck" field to control hash table
scanning intervals. When a table scan begins, nextcheck is set to current
time plus 1800 seconds. During scanning, if cache_detail is not empty and
a cache entry's expiry time is earlier than the current nextcheck, the
nextcheck is updated to that expiry time.

This mechanism ensures that:
1) Empty cache_details are scanned every 1800 seconds to avoid unnecessary
   scans
2) Non-empty cache_details are scanned based on the earliest expiry time
   found

However, when adding a new cache entry to an empty cache_detail, the
nextcheck time was not being updated, remaining at 1800 seconds. This
could delay cache cleanup for up to 1800 seconds, potentially blocking
threads(such as nfsd) that are waiting for cache cleanup.

Fix this by updating the nextcheck time whenever a new cache entry is
added.

Signed-off-by: Long Li <leo.lilong@huawei.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit, the code changes, and the kernel
repository context, here is my assessment: **YES** This commit should be
backported to stable kernel trees. Here's my extensive analysis: ##
Analysis of the Problem The commit addresses a specific cache management
issue in the SUNRPC subsystem that can cause significant delays (up to
1800 seconds/30 minutes) in cache cleanup operations. The problem occurs
when: 1. A cache_detail starts empty, with nextcheck set to current time
+ 1800 seconds 2. A new cache entry is added to this empty cache_detail
3. The nextcheck time is NOT updated to reflect the new entry's expiry
time 4. This means cache cleanup won't occur until the original
1800-second timeout expires 5. During this delay, threads like nfsd that
depend on cache cleanup can be blocked ## Code Change Analysis The fix
is minimal and surgical: ```c + if (detail->nextcheck >
new->expiry_time) + detail->nextcheck = new->expiry_time + 1; ``` This
2-line addition in `sunrpc_cache_add_entry()` ensures that when a new
cache entry is added, if its expiry time is earlier than the current
nextcheck time, nextcheck is updated to trigger cleanup at the
appropriate time. ## Why This Qualifies for Stable Backporting **1. Bug
Fix Nature**: This clearly fixes a bug where cache cleanup could be
inappropriately delayed, affecting system functionality. **2. Minimal
Risk**: The change is extremely small and contained. It only adds a
simple conditional check that makes the cache cleanup more responsive.
There's no architectural change or complex logic. **3. Critical
Subsystem Impact**: The SUNRPC cache affects NFS operations, which are
critical for many production systems. A 1800-second delay in cache
cleanup can severely impact NFS server responsiveness. **4. Clear User
Impact**: The commit message explicitly mentions that this can block
threads like nfsd, which directly affects users experiencing NFS service
delays or hangs. **5. Historical Context**: Looking at the similar
commits provided as reference, this fix is actually addressing a more
fundamental timing issue than some of the other cache-related changes
that were marked as "NO" for backporting. Those commits dealt with
interface behavior changes or feature additions, while this fixes a
clear performance/delay bug. **6. Low Complexity**: The fix doesn't
introduce new features, change APIs, or modify behavioral contracts. It
simply ensures that cache cleanup happens when it should happen. **7.
Contained Scope**: The change is isolated to a single function
(`sunrpc_cache_add_entry`) and only affects the timing of cache cleanup,
not the cleanup logic itself. ## Comparison with Reference Commits
Unlike the reference commits marked "NO" which involved: - Interface
behavior changes (flush interface semantics) - Feature additions (new
cache operations) - Complex timing logic modifications - Architectural
changes This commit simply fixes a timing bug with a minimal, obvious
correction that ensures cache cleanup occurs at the appropriate time
rather than being unnecessarily delayed. The fix follows the stable tree
rules perfectly: it's an important bugfix with minimal risk that
addresses a clear user-visible issue in a critical kernel subsystem.

 net/sunrpc/cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 7ce5e28a6c031..bbaa77d7bbc81 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -135,6 +135,8 @@ static struct cache_head *sunrpc_cache_add_entry(struct cache_detail *detail,
 
 	hlist_add_head_rcu(&new->cache_list, head);
 	detail->entries++;
+	if (detail->nextcheck > new->expiry_time)
+		detail->nextcheck = new->expiry_time + 1;
 	cache_get(new);
 	spin_unlock(&detail->hash_lock);
 
-- 
2.39.5


