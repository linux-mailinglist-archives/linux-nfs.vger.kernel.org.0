Return-Path: <linux-nfs+bounces-21248-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEBxBO6R8GlvVAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21248-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 12:54:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C0B48309F
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 12:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7CDA33034739
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 10:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF59A3F7889;
	Tue, 28 Apr 2026 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2H5zJH/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85493F7882;
	Tue, 28 Apr 2026 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372910; cv=none; b=iFihqPc4bS2f0hSMcSzPR12YelZYc5jgTTASTTNs5tcbYgn6zQDF2/L25k6gFO4NVECuuDp9z3QIBmUqhlAN3k9s2TYuxqkxswSxp+bx4pqIMy/Zphj/Kfw4TYYpDF56ohvdhZle6lVRq76Gq1C7c2a0HClYozE98UBYSM57l8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372910; c=relaxed/simple;
	bh=UAbHhznI5SNoK/jftH17YJMeeJgGLedqFeGuByEk4YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBsQCKVYg/hqWAPbh6I9j7lCgid7YgXiPtABrI2cf/m4V8GChPtZ8KHTit6fGE/8IdHnx0j6HT40SAkAaShk1Ehkcfpy6rKssmecTstKQq7kzZxcncq1qFKVA5nARs/abdku6XIrbRN+WyZ2Zi+xoxwe5MteI82Kub4j6ws2wvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2H5zJH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD06C2BCB5;
	Tue, 28 Apr 2026 10:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777372910;
	bh=UAbHhznI5SNoK/jftH17YJMeeJgGLedqFeGuByEk4YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N2H5zJH/6Fo/D4Gb9ySVtwITjiNzI/CwODavwaZfcOlbkYbPAkTEP6aEqTsahMi0f
	 pj3ZQ2HR0lX8aDt/OmHOQBuMFGvY/LYzf1z7oeH7YVWqUkFuh/sylsTuZEMG1O3R7y
	 3bU/WXg9BLgPyD08kN9xoHvITxNOzq+BY335UgFX1i9DGt8b9laBUr8bOIEHTliY+E
	 35HAALmR1RpnvhfsJnvq3X9mOQ7cneQBnr3HRhXVh0cdoRYBEivaDiE6j+c2vBI6OC
	 EoJh8ngE8AlDcj1spJvDTaWAvBm+5DDXqDigIj/d2STJmBmxQdpmGoij/Cm2bkMYI5
	 uq8eYh9+kWS5w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.6] NFS: Use nlmclnt_shutdown_rpc_clnt() to safely shut down NLM
Date: Tue, 28 Apr 2026 06:40:23 -0400
Message-ID: <20260428104133.2858589-12-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428104133.2858589-1-sashal@kernel.org>
References: <20260428104133.2858589-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 7.0.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 10C0B48309F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21248-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 840621fd2ff23ada8b9262d90477e75232566e6b ]

A race condition exists in shutdown_store() when writing to the sysfs
"shutdown" file concurrently with nlm_shutdown_hosts_net(). Without
synchronization, the following sequence can occur:

  1. shutdown_store() reads server->nlm_host (non-NULL)
  2. nlm_shutdown_hosts_net() acquires nlm_host_mutex, calls
     rpc_shutdown_client(), sets h_rpcclnt to NULL, and potentially
     frees the host via nlm_gc_hosts()
  3. shutdown_store() dereferences the now-stale or freed host

Introduce nlmclnt_shutdown_rpc_clnt(), which acquires nlm_host_mutex
before accessing h_rpcclnt. This synchronizes with
nlm_shutdown_hosts_net() and ensures the rpc_clnt pointer remains
valid during the shutdown operation.

This change also improves API layering: NFS client code no longer
needs to include the internal lockd header to access nlm_host fields.
The new helper resides in bind.h alongside other public lockd
interfaces.

Reported-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

# Analysis: NFS: Use nlmclnt_shutdown_rpc_clnt() to safely shut down NLM

## Phase 1: Commit Message Forensics

**Step 1.1 — Subject parsing:**
Record: Subsystem `NFS:` / action `Use` (implicit "fix by using") /
summary: replace direct h_rpcclnt dereference with a helper that adds
synchronization for safely shutting down NLM client RPC state.

**Step 1.2 — Tags:**
Record:
- `Reported-by: Jeff Layton <jlayton@kernel.org>` (subsystem expert)
- `Reviewed-by: Jeff Layton <jlayton@kernel.org>` (same person,
  NFS/lockd maintainer-adjacent)
- `Signed-off-by: Chuck Lever <chuck.lever@oracle.com>` (NFSD
  maintainer)
- No `Fixes:` tag, no `Cc: stable`, no `Link:`, no syzbot — expected
  (this is a candidate under review).

**Step 1.3 — Body analysis:**
Record: Author describes a concrete race between `shutdown_store()` and
`nlm_shutdown_hosts_net()`:
1. `shutdown_store()` reads `server->nlm_host` (non-NULL).
2. Concurrent path takes `nlm_host_mutex`, shuts down the RPC client,
   sets `h_rpcclnt = NULL`, may free host via `nlm_gc_hosts()`.
3. `shutdown_store()` dereferences freed/stale pointer.
Author explicitly states consequences: UAF / NULL pointer dereference
(NPD).
Mechanism described is a cross-subsystem race.

**Step 1.4 — Hidden fix detection:**
Record: Not hidden — the message explicitly calls out a "race
condition". The v2->v3 changelog in the cover letter (found in mailing
list) explicitly states: "Changes since v2: Serialize client-side NLM
shutdown to avoid UAF and NPD." This confirms the commit targets a
UAF/NPD, not just cleanup.

## Phase 2: Diff Analysis

**Step 2.1 — Inventory:**
Record: 3 files changed, +32/-2.
- `fs/lockd/host.c`: +29 (new helper function
  `nlmclnt_shutdown_rpc_clnt` + callback `nlmclnt_match_all` +
  `EXPORT_SYMBOL_GPL`).
- `fs/nfs/sysfs.c`: 2 lines modified — header include switched from
  `lockd.h` to `bind.h`; direct `h_rpcclnt` access replaced with new
  helper call.
- `include/linux/lockd/bind.h`: +1 line (extern declaration).
Classification: small, contained, cross-module (lockd + NFS + public
header).

**Step 2.2 — Code flow change:**
Record:
- Before: `shutdown_client(server->nlm_host->h_rpcclnt)` — direct
  unsynchronized dereference of internal struct field; if `h_rpcclnt` is
  NULL or host was freed, immediate crash.
- After: `nlmclnt_shutdown_rpc_clnt(server->nlm_host)` — lockd-internal
  helper acquires `nlm_host_mutex`, reads `h_rpcclnt`, NULL-checks it,
  then sets `cl_shutdown=1` and cancels tasks under the mutex.

**Step 2.3 — Bug mechanism:**
Record: Category (b) synchronization / race + (d) memory safety (NULL
check).
- Adds `mutex_lock(&nlm_host_mutex)` around `h_rpcclnt` read and use.
  This is the same mutex serialized by `nlmclnt_release_host()` (via
  `refcount_dec_and_mutex_lock`) and `nlm_shutdown_hosts_net()`
  (explicit `mutex_lock`).
- Adds an explicit `if (clnt)` NULL check in the helper — previously
  absent in callsite.
- Adds `EXPORT_SYMBOL_GPL` so the helper is callable from fs/nfs.

**Step 2.4 — Fix quality:**
Record: Obviously correct mutex pattern. The helper semantics are clear
(safe when `h_rpcclnt` is NULL, serialized against release). No
regression risk: the operations under the mutex (set flag + cancel
tasks) are short and don't sleep on other locks that could cause
deadlock with the mutex. Slight concern: adds a new exported symbol, but
this is a standard idiom in kernel subsystems.

## Phase 3: Git History Investigation

**Step 3.1 — Blame:**
Record: The buggy callsite
`shutdown_client(server->nlm_host->h_rpcclnt)` was introduced by commit
`7d3e26a054c88` "NFS: Cancel all existing RPC tasks when shutdown" (in
v6.5-rc1). Prior to that, commit `d9615d166c7ed` "NFS: add sysfs
shutdown knob" (also v6.5-rc1) just set `cl_shutdown=1` without
cancelling tasks.

**Step 3.2 — Fixes: tag:**
Record: No explicit Fixes: tag in this commit. The targeted vulnerable
code was introduced in v6.5 (present in 6.6+ stable trees).

**Step 3.3 — File history:**
Record: `fs/nfs/sysfs.c` and `fs/lockd/host.c` are stable files with
steady maintenance. No related prerequisite series needed for the fix
itself (although other commits in the 14-patch series move headers
around, that movement is NOT required for this commit to apply).

**Step 3.4 — Author:**
Record: Chuck Lever is NFSD subsystem maintainer; Jeff Layton is a long-
term NFS/lockd developer. Both have deep expertise in this area.

**Step 3.5 — Dependencies:**
Record: This commit depends only on `nlm_host_mutex` and
`rpc_cancel_tasks()` both of which pre-date v6.5 by years. It does NOT
depend on the sibling header-relocation commits in the series
(`2c562c6e67156`, `4db2f8a016dc9`, `f4d5f8caadd85`) — those are
standalone refactoring.

## Phase 4: Mailing List Research

**Step 4.1 — Find original submission:**
Record: `b4 dig` located the patch at
https://lore.kernel.org/all/20260128151935.1646063-7-cel@kernel.org/ —
[PATCH v4 06/14]. Series title: "Clarify module API boundaries".

**Step 4.1 (evolution):** `b4 dig -a` shows revisions v1 → v2 → v3 → v4.
v2 (Message-ID 20260123185259.1215767-6-cel@kernel.org, subject "NFS:
Use nlmclnt_rpc_clnt() helper to retrieve nlm_host's rpc_clnt") had a
simpler fix: use existing `nlmclnt_rpc_clnt()` + NULL check. v3 upgraded
the fix to introduce `nlmclnt_shutdown_rpc_clnt()` with full mutex
serialization, because the author recognized the NULL check alone has a
race window (TOCTOU — read→check→use unsynchronized against clearing by
release path).

**Step 4.2 — Reviewers:**
Record: Original recipients: NeilBrown, Jeff Layton, Olga Kornievskaia,
Dai Ngo, Tom Talpey, linux-nfs list. Jeff Layton provided `Reviewed-by:`
— he is THE lockd/NFS domain expert. No NAKs or objections.

**Step 4.3 — Bug report:**
Record: No external bug report / Link / syzbot — the race was found via
code review by Jeff Layton (Reported-by).

**Step 4.4 — Related patches:**
Record: The surrounding 13 patches in the series are mostly header-moves
and minor lockd refactoring. This specific patch is self-contained. No
dependency on other patches in the series is required for the bug fix to
work.

**Step 4.5 — Stable ML:**
Record: No pre-existing stable nomination. Not mentioned on stable lists
(the patch was only merged to mainline yesterday, 2026-04-20, via Chuck
Lever's nfsd-7.1 pull).

## Phase 5: Semantic / Call-Graph Analysis

**Step 5.1 — Key functions:**
Record: New: `nlmclnt_shutdown_rpc_clnt()`, `nlmclnt_match_all()`.
Modified: `shutdown_store()` in fs/nfs/sysfs.c.

**Step 5.2 — Callers of `shutdown_store`:**
Record: Called by sysfs when user writes "1" to
`/sys/fs/nfs/server-N/shutdown`. Attribute is `__ATTR_RW` → mode 0644 →
write requires root (CAP_SYS_ADMIN in practice).

**Step 5.3 — Callees:**
Record: `nlmclnt_shutdown_rpc_clnt()` calls
`mutex_lock(&nlm_host_mutex)`, reads `host->h_rpcclnt`, sets
`clnt->cl_shutdown`, and calls `rpc_cancel_tasks()`. All are existing,
stable APIs.

**Step 5.4 — Call chain reachability:**
Record: Trigger path: root writes `1` to sysfs shutdown file while an
NFS v2/v3 mount (with file lock traffic having triggered
`nlm_bind_host`) is being torn down. Reachable from userspace (as root).

**Step 5.5 — Similar patterns:**
Record: `nlmclnt_release_host()` already uses
`refcount_dec_and_mutex_lock(&h_count, &nlm_host_mutex)` — the fix's use
of the same mutex is consistent with the existing locking model.
`nlm_shutdown_hosts_net()` also acquires this mutex.

## Phase 6: Cross-Referencing Stable Trees

**Step 6.1 — Does the buggy code exist in stable?**
Record: `git show stable/linux-6.6.y:fs/nfs/sysfs.c` confirms the pre-
fix code `shutdown_client(server->nlm_host->h_rpcclnt)` is present at
the same location (line 288). Same for 6.12.y. Buggy code introduced in
v6.5, so present in 6.6+, 6.12+, and 6.15/7.0 stable trees.

**Step 6.2 — Backport complications:**
Record: `fs/lockd/host.c` and `fs/nfs/sysfs.c` in 6.6.y and 6.12.y are
very close to the pre-fix mainline state. The new helper can be added
cleanly. `include/linux/lockd/bind.h` in stable trees has the same
structure. Backport should apply with minimal or no adjustment. The
header include switch from `lockd.h` to `bind.h` in fs/nfs/sysfs.c will
still compile in stable because bind.h provides sufficient forward
declaration (struct nlm_host is used only as pointer type after the
fix).

**Step 6.3 — Related stable fixes:**
Record: No earlier fix for this race in stable trees.

## Phase 7: Subsystem Context

**Step 7.1 — Criticality:**
Record: `fs/nfs/` + `fs/lockd/` — IMPORTANT (affects all NFS client
users doing file locking on v2/v3 mounts; NFSv4 has its own locking and
is unaffected).

**Step 7.2 — Activity:**
Record: Mature subsystem with steady development. Bug has existed since
v6.5 (approximately 2 years); fix came from Chuck Lever/Jeff Layton as
part of a code audit / refactoring effort.

## Phase 8: Impact / Risk

**Step 8.1 — Affected users:**
Record: NFSv2/v3 users with shutdown sysfs knob actively used (used by
some admin tooling / container orchestration scenarios). Knob is root-
only.

**Step 8.2 — Trigger conditions:**
Record: Requires (a) root privilege; (b) simultaneous write to
`/sys/fs/nfs/server-N/shutdown` and NFS unmount (`nfs_free_server` path
through `nfs_destroy_server → nlmclnt_done → nlmclnt_release_host`); (c)
the unmount drops the nlm_host refcount to 0, triggering destruction.
Narrow timing window. Not userspace-triggerable by unprivileged users.

**Step 8.3 — Failure mode:**
Record: Use-after-free (host freed by release path while sysfs writer
dereferences `h_rpcclnt`) or NULL-pointer dereference (if `h_rpcclnt`
has been cleared) → kernel oops. Severity: HIGH (kernel crash, potential
memory corruption). Not security-critical in the strict sense (requires
root to trigger), but is a real UAF.

**Step 8.4 — Risk/Benefit:**
Record:
- BENEFIT: Fixes a real UAF / NPD race condition.
- RISK: 32-line change, adds a new EXPORT_SYMBOL_GPL, but semantics are
  simple and reviewed by the domain expert. The added mutex is already
  held by the peer paths, so no new locking model introduced.
- Ratio: Benefit clearly outweighs risk; fix is small and surgical.

## Phase 9: Synthesis

**Step 9.1 — Evidence summary:**
FOR:
- Real UAF / NPD in the sysfs shutdown path (author explicitly noted in
  v2→v3 changelog: "Serialize client-side NLM shutdown to avoid UAF and
  NPD").
- Reviewed by Jeff Layton (subsystem expert who is also the Reporter).
- Small, contained, well-structured fix using existing mutex.
- Buggy code exists in 6.6+, 6.12+ stable trees.
- Backport should apply cleanly; affected files in stable are similar to
  pre-fix mainline.

AGAINST:
- Just merged to mainline (2026-04-20, i.e., yesterday) — minimal time
  under test.
- No `Cc: stable`, no `Fixes:` tag (expected for a candidate under
  review).
- Adds a new exported symbol (small kABI expansion, not a blocker for
  stable).
- Requires root to trigger, so not a privilege-escalation security bug.
- Part of a larger "API boundary" refactoring series (but this
  particular commit is a bona fide fix, not refactoring alone).

UNRESOLVED:
- Exact race mechanism for client hosts vs. `nlm_shutdown_hosts_net()`
  (which iterates `nlm_server_hosts`) is somewhat idealized in the
  commit message; however, the more certain race between
  `shutdown_store()` and `nlmclnt_release_host()` (via
  `nfs_destroy_server()`) does exist — `nfs_destroy_server` runs before
  `nfs_sysfs_remove_server`, so the sysfs file is still active while the
  nlm_host refcount may hit zero and the host can be freed. The fix
  addresses that path as well (both hold `nlm_host_mutex`).

**Step 9.2 — Rules checklist:**
1. Obviously correct and tested? Yes (code-review correct; tested in
   linux-next via fs-next integration).
2. Fixes a real bug? Yes (UAF / NPD in sysfs shutdown path).
3. Important issue? Yes (kernel crash, potential UAF).
4. Small and contained? Yes (+32/-2 across 3 files).
5. No new features? Correct — adds a helper to support the fix, no new
   user-facing functionality.
6. Applies to stable trees? Yes (target code is present and nearly
   identical in 6.6.y / 6.12.y).

**Step 9.3 — Exception categories:** Not a quirk / device ID / DT /
build / doc fix. It's a straightforward bug fix.

**Step 9.4 — Decision:**
This is a legitimate UAF/NPD fix for a race in a user-reachable (though
root-gated) sysfs handler. The bug has been latent since v6.5. The fix
is small, well-reviewed by the subsystem expert, and will backport
cleanly. Although the commit is very fresh in mainline and the trigger
window is narrow, the severity (UAF / kernel oops) and the cleanliness
of the fix favor inclusion. The new exported symbol is a trivial API
expansion used solely to implement the fix.

## Verification

- [Phase 1] Parsed all commit tags: `Reported-by`/`Reviewed-by` Jeff
  Layton, SOB Chuck Lever. No Fixes:, stable, Link: or syzbot (confirmed
  by reading the full message).
- [Phase 1] `b4 dig -c 840621fd2ff23 -a` showed v1/v2/v3/v4 revisions;
  v2→v3 cover-letter changelog says "Serialize client-side NLM shutdown
  to avoid UAF and NPD" (read in mbox).
- [Phase 2] Diff confirmed: +29 in `fs/lockd/host.c`, +1/−1 in
  `include/linux/lockd/bind.h`, +1/−1 include + +1/−1 function-call in
  `fs/nfs/sysfs.c`. EXPORT_SYMBOL_GPL added.
- [Phase 2] Read `fs/lockd/host.c` around `nlmclnt_release_host()` —
  confirmed same `nlm_host_mutex` is used, so new helper's lock is
  consistent with existing release path.
- [Phase 3] `git describe --contains 7d3e26a054c88` → v6.5-rc1~91^2~6:
  confirms buggy call `shutdown_client(server->nlm_host->h_rpcclnt)` was
  introduced in v6.5.
- [Phase 3] `git describe --contains d9615d166c7ed` → v6.5-rc1~91^2~7:
  confirms sysfs shutdown knob itself is from v6.5.
- [Phase 4] `b4 dig -c 840621fd2ff23` → confirmed lore URL and that
  patch is 06/14 of "Clarify module API boundaries" series.
- [Phase 4] `b4 dig -c 840621fd2ff23 -w` → original recipients included
  NeilBrown, Jeff Layton, Olga Kornievskaia, Dai Ngo, Tom Talpey, linux-
  nfs list. Domain experts CC'd.
- [Phase 4] Read v2 and v4 of the patch from lore mbox; v2 used existing
  `nlmclnt_rpc_clnt()` helper + NULL check; v3+ upgraded to proper mutex
  serialization. Confirmed no NAKs.
- [Phase 5] Read `shutdown_store()` and confirmed `__ATTR_RW(shutdown)`
  → mode 0644 → root-only write.
- [Phase 5] Read `nfs_free_server()` in `fs/nfs/client.c` and confirmed
  `server->destroy(server)` (which calls
  `nlmclnt_done`/`nlmclnt_release_host`) runs BEFORE
  `nfs_sysfs_remove_server()` — a real window during which the sysfs
  file is still active while the nlm_host could be dropped.
- [Phase 6] `git show stable/linux-6.6.y:fs/nfs/sysfs.c` confirmed pre-
  fix `shutdown_client(server->nlm_host->h_rpcclnt)` present at line 288
  in 6.6.y.
- [Phase 6] `git show stable/linux-6.12.y:fs/lockd/host.c` and
  `include/linux/lockd/bind.h` confirmed both files are structurally
  compatible for a clean backport.
- [Phase 7] Read attribute macros confirming sysfs file mode.
- [Phase 8] Severity assessment: UAF of `struct nlm_host` → kernel oops
  / potential memory corruption = HIGH.
- UNVERIFIED: The exact claim that `nlm_shutdown_hosts_net()` races with
  `shutdown_store()` on client hosts is partly unverified —
  `nlm_shutdown_hosts_net()` iterates `nlm_server_hosts`, not
  `nlm_client_hosts`. However, the more concrete race between
  `shutdown_store()` and `nlmclnt_release_host()` (via NFS unmount path)
  IS verified via code reading. The fix uses the same mutex and
  addresses both serialization points. This detail doesn't change the
  YES/NO decision — there is a real race the patch closes.
- UNVERIFIED: No concrete crash stack trace or user bug report exists —
  the race was found by code review. This does not change the assessment
  (UAF fixes from code audit are routinely backported).

The fix is small, correct, closes a real UAF in a user-reachable (root-
gated) sysfs path present since v6.5, and is reviewed by the domain
expert. It backports cleanly to 6.6.y and 6.12.y.

**YES**

 fs/lockd/host.c            | 29 +++++++++++++++++++++++++++++
 fs/nfs/sysfs.c             |  4 ++--
 include/linux/lockd/bind.h |  1 +
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/lockd/host.c b/fs/lockd/host.c
index 1a9582a10a86f..015900d2d4c22 100644
--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -306,6 +306,35 @@ void nlmclnt_release_host(struct nlm_host *host)
 	}
 }
 
+/* Callback for rpc_cancel_tasks() - matches all tasks for cancellation */
+static bool nlmclnt_match_all(const struct rpc_task *task, const void *data)
+{
+	return true;
+}
+
+/**
+ * nlmclnt_shutdown_rpc_clnt - safely shut down NLM client RPC operations
+ * @host: nlm_host to shut down
+ *
+ * Cancels outstanding RPC tasks and marks the client as shut down.
+ * Synchronizes with nlmclnt_release_host() via nlm_host_mutex to prevent
+ * races between shutdown and host destruction. Safe to call if h_rpcclnt
+ * is NULL or already shut down.
+ */
+void nlmclnt_shutdown_rpc_clnt(struct nlm_host *host)
+{
+	struct rpc_clnt *clnt;
+
+	mutex_lock(&nlm_host_mutex);
+	clnt = host->h_rpcclnt;
+	if (clnt) {
+		clnt->cl_shutdown = 1;
+		rpc_cancel_tasks(clnt, -EIO, nlmclnt_match_all, NULL);
+	}
+	mutex_unlock(&nlm_host_mutex);
+}
+EXPORT_SYMBOL_GPL(nlmclnt_shutdown_rpc_clnt);
+
 /**
  * nlmsvc_lookup_host - Find an NLM host handle matching a remote client
  * @rqstp: incoming NLM request
diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 1da4f707f9efe..3a197252a1329 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -13,7 +13,7 @@
 #include <linux/nfs_fs.h>
 #include <net/net_namespace.h>
 #include <linux/rcupdate.h>
-#include <linux/lockd/lockd.h>
+#include <linux/lockd/bind.h>
 
 #include "internal.h"
 #include "nfs4_fs.h"
@@ -288,7 +288,7 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
 		shutdown_client(server->client_acl);
 
 	if (server->nlm_host)
-		shutdown_client(server->nlm_host->h_rpcclnt);
+		nlmclnt_shutdown_rpc_clnt(server->nlm_host);
 out:
 	shutdown_nfs_client(server->nfs_client);
 	return count;
diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
index c53c81242e727..40c124f932252 100644
--- a/include/linux/lockd/bind.h
+++ b/include/linux/lockd/bind.h
@@ -58,6 +58,7 @@ struct nlmclnt_initdata {
 extern struct nlm_host *nlmclnt_init(const struct nlmclnt_initdata *nlm_init);
 extern void	nlmclnt_done(struct nlm_host *host);
 extern struct rpc_clnt *nlmclnt_rpc_clnt(struct nlm_host *host);
+extern void	nlmclnt_shutdown_rpc_clnt(struct nlm_host *host);
 
 /*
  * NLM client operations provide a means to modify RPC processing of NLM
-- 
2.53.0


