Return-Path: <linux-nfs+bounces-15717-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7543C1236B
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 01:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D009564CC7
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 00:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175901F8BD6;
	Tue, 28 Oct 2025 00:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYWzFr5F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0051BBBE5;
	Tue, 28 Oct 2025 00:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761611985; cv=none; b=Tg2NRE3e1ly/eY+A/nKrP3NqaJhhYcJIqiz4oOg7DHeJx+iRxlq5OeB+MPeiJ/7Cfzf2ciXNGHthFYKtAY2XdA269U4vjxmsgNqqddmcbg9p9g5LC8+ixHF43Wc1g2LuPJM4ZmV5lCNoEcxv4snkcdNtKwkhfPZSjGz5UlJDWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761611985; c=relaxed/simple;
	bh=ZVXaPhzmEw0ZPzgy15ZACehDC+fhT4VJvZoXinvQZWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+/fSH5g6Dkh7D0EtaC1bjWVFJzO/iYbdmg2k13Hfo6RVjqkQAsIfNlvT0cBDXw+XmAOANSWN0VV93wCFuxSXIKPBHfltFxWT9SQlztANXKnbGnsooezZP2W9qk5mnzq6dtJ7wv/uTktKCnH1WmpiKX8xiTxtO2aT36efsjmkcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYWzFr5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B56C4CEFB;
	Tue, 28 Oct 2025 00:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761611984;
	bh=ZVXaPhzmEw0ZPzgy15ZACehDC+fhT4VJvZoXinvQZWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OYWzFr5FwTZeqyPQm+8LFJr2fFnfmTGXaPXmRjLyu8MbKRnSO8RN3pzzN5nquaU9O
	 ibAFHPEqTMEcHYVsmFaF9+9Vb5rcsaA7OnCUWO1ACh7RfZM8qiofzvEo8z68lXdWAk
	 i+vuIh8OF9Mzv9Ny1pYSXrBscpWPGYO3zDBN/oJzOuRO/Vf2a839kZ6yd3z3O3j+fK
	 8JpM3lBVyGAmGoMOXpSygSl2NanrJRR8WOtEqrC3yWQ5iksyc2BPWU94vbPC5YSKmi
	 pBkRm1/3a1Bxv3dWcQG4QCGwnofOqYZPrQUmqVVevfwK//vVMyTWXl8TcROI6FzhHb
	 hMQc1QpAEBlag==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Joshua Watt <jpewhacker@gmail.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.4] NFS4: Fix state renewals missing after boot
Date: Mon, 27 Oct 2025 20:38:46 -0400
Message-ID: <20251028003940.884625-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028003940.884625-1-sashal@kernel.org>
References: <20251028003940.884625-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Joshua Watt <jpewhacker@gmail.com>

[ Upstream commit 9bb3baa9d1604cd20f49ae7dac9306b4037a0e7a ]

Since the last renewal time was initialized to 0 and jiffies start
counting at -5 minutes, any clients connected in the first 5 minutes
after a reboot would have their renewal timer set to a very long
interval. If the connection was idle, this would result in the client
state timing out on the server and the next call to the server would
return NFS4ERR_BADSESSION.

Fix this by initializing the last renewal time to the current jiffies
instead of 0.

Signed-off-by: Joshua Watt <jpewhacker@gmail.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my comprehensive analysis using semantic code analysis tools
and repository examination, here is my assessment:

## **ANSWER: YES**

This commit should **DEFINITELY** be backported to stable kernel trees.

---

## **DETAILED ANALYSIS**

### **1. Semantic Code Analysis Performed**

I used the following tools to analyze this commit:

- **mcp__semcode__find_function**: Located `nfs4_alloc_client` function
  definition and structure
- **mcp__semcode__find_type**: Examined the `nfs_client` struct to
  understand the `cl_last_renewal` field
- **mcp__semcode__find_callers**: Found that
  `nfs4_schedule_state_renewal` is called by 5 functions
- **mcp__semcode__grep_functions**: Identified all 5 functions that use
  `cl_last_renewal` field
- **Git analysis**: Traced the field's history back to 2006 (kernel
  v2.6.19)

### **2. Code Changes Analysis**

The fix is a **single line addition** in `fs/nfs/nfs4client.c:224`:
```c
clp->cl_last_renewal = jiffies;
```

This initialization occurs in `nfs4_alloc_client()`, which is called
indirectly through the function pointer `.alloc_client` in the
`nfs_subversion` operations structure (found at
`fs/nfs/nfs4proc.c:11032`).

### **3. Bug Impact Assessment**

**How cl_last_renewal is Used:**

The field is critical in `nfs4_schedule_state_renewal()`
(fs/nfs/nfs4renewd.c:119-120):
```c
timeout = (2 * clp->cl_lease_time) / 3 + (long)clp->cl_last_renewal -
(long)jiffies;
```

**The Bug:**
- `jiffies` starts at `INITIAL_JIFFIES` (approximately -300*HZ, or -5
  minutes)
- `cl_last_renewal` was initialized to 0 (implicit, never explicitly
  set)
- During the first 5 minutes after boot: `timeout = (2*lease_time)/3 + 0
  - (-300*HZ)`
- This **adds an extra 5 minutes** to the renewal timeout

**User Impact:**
- Affects **all NFSv4 clients** created in the first 5 minutes after
  system boot
- If the connection is idle during this period, the client state **times
  out on the server**
- Next NFS operation returns **NFS4ERR_BADSESSION**
- Users experience connection failures requiring session re-
  establishment

### **4. Scope and Risk Analysis**

**Scope:**
- **Extremely contained**: One line, one function, one subsystem
- **No dependencies**: Doesn't rely on any new kernel features
- **No API changes**: Internal field initialization only
- **Pattern-consistent**: `nfs4_init_ds_session`
  (fs/nfs/nfs4session.c:643) already uses the same initialization
  pattern

**Risk:**
- **Minimal regression risk**: Just initializing a timestamp field
  correctly
- **Well-tested pattern**: Same initialization exists elsewhere in the
  codebase

### **5. Historical Context**

- **Bug age**: Present since **2006** (kernel v2.6.19-rc1, commit
  24c8dbbb5f777)
- **Affects**: Nearly **20 years** of kernel releases
- **Precedent**: Similar NFSv4 renewal bugs have been backported (e.g.,
  commit 2c9d556d14bc8 from 2014 addressing another state renewal
  regression)
- **Missing tags**: No "Fixes:" or "Cc: stable@vger.kernel.org" tags
  suggest the maintainer may not have considered stable backporting

### **6. Stable Tree Compliance**

✅ **Bug fix** (not a new feature)
✅ **Important** (causes user-facing failures)
✅ **Small and contained** (one line)
✅ **No architectural changes**
✅ **Low regression risk**
✅ **Widely used subsystem** (NFSv4 is critical in enterprise
environments)
✅ **Long-standing bug** (affects many LTS kernels)

---

## **CONCLUSION**

This is a **textbook example** of a commit that should be backported:
- Fixes a real, user-facing bug (NFS4ERR_BADSESSION errors)
- Extremely simple one-line fix with no dependencies
- Affects a critical subsystem (NFSv4 client)
- Bug has existed for ~20 years, affecting many stable releases
- Minimal risk of regression
- Follows established initialization patterns in the codebase

The lack of explicit stable tags appears to be an oversight rather than
an intentional decision to exclude it from stable trees.

 fs/nfs/nfs4client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 6fddf43d729c8..5998d6bd8a4f4 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -222,6 +222,7 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_state = 1 << NFS4CLNT_LEASE_EXPIRED;
 	clp->cl_mvops = nfs_v4_minor_ops[cl_init->minorversion];
 	clp->cl_mig_gen = 1;
+	clp->cl_last_renewal = jiffies;
 #if IS_ENABLED(CONFIG_NFS_V4_1)
 	init_waitqueue_head(&clp->cl_lock_waitq);
 #endif
-- 
2.51.0


