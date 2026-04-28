Return-Path: <linux-nfs+bounces-21249-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPVQCxiS8GlvVAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21249-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 12:55:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1F84830F8
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 12:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CE44304C7FF
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 10:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A646E3FE666;
	Tue, 28 Apr 2026 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxT/JqEl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2D3FE669;
	Tue, 28 Apr 2026 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372937; cv=none; b=GnO4ZscVZV6JtrovB2qasxE7JoPHzFQsN0sm8yMYJLPvkwwxO9nf/mdRg1AOvlBr9IXsqbaSVS76N/nOzWS7kWsqjU/oSURZjacGxfiDhJ+zRnPisN2YV2wtohbghka0nLsvgR66l/dWph78JoKPIcEdFSScu7oEShSeF0lxiiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372937; c=relaxed/simple;
	bh=QKMXF6HsS2rrDkVh5b2vhTRRTqO74YR2YzRVrVHL6nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YebM/ysdz6L16LQ8flXxk6we2/kpcLopRDizbN/UGFEhbMKZBbp8+Rp7bc1bt1kFi/au7iksr2MLAVsMnWWcjgLwmn9GvrNVzATCn4Zp7dwyJLM6FqYDD3EVCiOz+HbuyTMKo9BsxJWT7T8GBXrrzWkqik5qySi2lkIHrpEgZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxT/JqEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F27C2BCB7;
	Tue, 28 Apr 2026 10:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777372937;
	bh=QKMXF6HsS2rrDkVh5b2vhTRRTqO74YR2YzRVrVHL6nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TxT/JqElCakHPHG9XDtFfJ6ZjV7GYw55xWM4V7/xZliJYu6vR/wo0ad8wc/HMoLI+
	 /+WiDzmkTVHOGsMevhWEXprdAmPzQRphGGSmCi1OmeerqdlOlBtysofyVBey+htOfU
	 UC1Gpr4xp9YoQTaACzuv7Uscnu7MDECty8uJW269kHU/A2sPmYgbk6mdvVQjGbg9r3
	 J03Fz9Hrl6KQSHn7fukb3WXuN5mWvYoY/lGdIVFS7uvcoczSbeei56hLmI8Y66miaS
	 WmqbRDgygPl425sg/6mC8x3kKEDAG2tHFeMudojh/Oz+ofMNCzx/NaImapYIBHw9g4
	 Rv/2b7cYfsjkQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0] NFS: fix writeback in presence of errors
Date: Tue, 28 Apr 2026 06:40:42 -0400
Message-ID: <20260428104133.2858589-31-sashal@kernel.org>
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
X-Rspamd-Queue-Id: 9C1F84830F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21249-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]

From: Olga Kornievskaia <okorniev@redhat.com>

[ Upstream commit 5d3869a41f3608101c00ff9c9c7c2364c555fa65 ]

After running xfstest generic/751, in certain conditions, can have
a writeback IO stuck while experiencing one of the two patterns.

Pattern#1: writeback IO experiences ENOSPC on an offset smaller
than the filesize. Example,
write offset=0 len=4096 how=unstable OK
write offset=8192 len=4096 how=unstable OK
write offset=12288 len=4096 how=unstable ENOSPC
write offset=4096 len=4096 how=unstable ENOSPC
client sends a commit and receives a verifier which is different
from the last successful write. It marks pages dirty and writeback
retries. But it again send writes unstable and gets into the same
pattern, running into the ENOSPC error and sending a commit because
writes were sent at unstable.

Pattern#2: an unstable write followed by a short write and ENOSPC.
write offset=0 len=4096 how=unstable OK
write offset=4096 len=4096 how=unstable returns OK but count=100
write offset=4197 len=3996 how=stable returns ENOSPC
client send a commit and receives a verifier different from
the last unstable write. The same behaviour is retried in a loop.

Instead, this patch proposes to identify those conditions and mark
requests to be done synchronously instead. Previous solution tried
to mark it in the nfs_page, however that's not persistent thus
instead mark it in the nfs_open_context.

Furthermore, the same problem occurs during localio code path so
recognize that IO needs to be done sync in that case as well.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have enough information to provide the full analysis.

---

# Analysis: NFS: fix writeback in presence of errors

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: Subject Line**
- Subsystem prefix: `NFS:`
- Action verb: `fix`
- Record: NFS / fix / writeback gets stuck in a loop in presence of
  errors (ENOSPC, short writes, verifier mismatches).

**Step 1.2: Tags**
- Signed-off-by: Olga Kornievskaia <okorniev@redhat.com> (Red Hat NFS
  developer, frequent NFS contributor)
- Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com> (NFS
  subsystem maintainer)
- NO `Fixes:` tag
- NO `Cc: stable@vger.kernel.org`
- NO `Reported-by:` (the bug was found internally via xfstests
  generic/751)
- NO `Tested-by:` / `Reviewed-by:` / `Acked-by:`
- NO `Link:` to lore/syzkaller/bugzilla
- Record: Two SOBs (author + maintainer). Absence of stable/Fixes tags
  is exactly why this is in the review pipeline. No reviewer trailers
  but maintainer has SOB indicating he applied it.

**Step 1.3: Commit Body**
- Bug description: Writeback IO gets stuck in an endless retry loop in
  two patterns:
  - Pattern #1: Unstable write → ENOSPC → COMMIT → verifier mismatch →
    mark pages dirty → retry as unstable → loop.
  - Pattern #2: Unstable write returning short (count=100) → stable
    write at offset 4197 → ENOSPC → COMMIT → verifier mismatch → loop.
- Reproduction: `xfstest generic/751`.
- Mechanism explained: After short write/ENOSPC/verifier mismatch, mark
  `nfs_open_context` so subsequent writes are forced to `NFS_FILE_SYNC`
  (stable). v1 used a per-page `PG_SYNC` flag, which doesn't survive
  page reallocation, so design moved to per-open-context flag.
- Record: Author clearly understands root cause; reproduction via
  standard xfstests test; same problem in localio path is also fixed.

**Step 1.4: Hidden Bug Fix Detection**
- Verb is "fix", not disguised. Ports of this clearly fix a hang.
- Record: This is an explicit bug fix (writeback livelock).

## PHASE 2: DIFF ANALYSIS

**Step 2.1: Inventory**
- `fs/nfs/localio.c`: +14 / -1 (in `nfs_local_call_write`,
  `nfs_local_do_write`)
- `fs/nfs/pagelist.c`: +3 (in `__nfs_pageio_add_request`)
- `fs/nfs/write.c`: +9 (in `nfs_write_completion`,
  `nfs_writeback_result`, `nfs_commit_release_pages`)
- `include/linux/nfs_fs.h`: +1 (new `NFS_CONTEXT_WRITE_SYNC` flag)
- Total: 27 insertions, 1 deletion across 4 files. Surgical, single-
  subsystem.
- Record: Small, contained, NFS-only changes touching only error-
  handling paths.

**Step 2.2: Code Flow Change**
- `nfs_writeback_result` (write.c): on short write, set
  `NFS_CONTEXT_WRITE_SYNC` on the open context.
- `nfs_commit_release_pages` (write.c): on verifier mismatch (server
  lost data), set the flag.
- `nfs_local_call_write` (localio.c): on short write in localio path,
  set the flag.
- `nfs_write_completion` (write.c): clear flag when an unstable write
  succeeds and needs commit.
- `__nfs_pageio_add_request` (pagelist.c): when flag set, OR
  `FLUSH_STABLE` into `pg_ioflags` so future writes go stable.
- `nfs_local_do_write` (localio.c): when flag set, set `hdr->args.stable
  = NFS_FILE_SYNC`.
- Record: Adds a sticky "force stable writes" flag set on error paths
  and consulted on submission.

**Step 2.3: Bug Mechanism Class**
- Logic / liveness fix (livelock / infinite retry loop in NFS error
  recovery), with synchronization/state-machine corrective. Not a
  UAF/leak/race classic.
- Trigger: server ENOSPC during unstable write OR verifier mismatch on
  commit (e.g., server crash/reboot or storage commit failure).
- Record: Liveness/livelock fix in NFS write recovery state machine.

**Step 2.4: Fix Quality**
- Reasoning is sound: forcing FILE_SYNC after error eliminates the
  unstable-write→commit→verifier-mismatch retry cycle.
- One subtle concern: the flag is per-open-context and is only cleared
  when `nfs_write_need_commit(hdr)` is true after a write completion.
  Once the flag is set, all writes go stable; stable writes don't need
  commit, so they don't clear the flag. The flag effectively persists
  until a successful unstable write (which only happens if flag is
  cleared first). This means after a single short-write event, the open
  context becomes permanently sync. That's intentional fail-safe
  behavior, but is a behavior change.
- No locking/memory-management concerns; no new allocations; no API
  change visible to userspace.
- Record: Logic appears correct; small regression risk = sustained sync
  writes after a transient short-write (perf cost only, not
  correctness).

## PHASE 3: GIT HISTORY INVESTIGATION

**Step 3.1: Blame**
- The general `nfs_writeback_result` short-write handling has been
  present since `6c75dc0d498c` ("NFS: merge _full and _partial write
  rpc_ops", 2012, v3.5). The buggy retry loop is therefore in
  essentially every stable kernel.
- Record: Bug present since 2012/v3.5. Affects all current LTS trees
  (5.10 through 6.12+).

**Step 3.2: Fixes Tag**
- This commit has no `Fixes:` tag.
- The closely related predecessor `3a06bac55bf56` ("NFS: improve 'Server
  wrote zero bytes' error") has `Fixes: 6c75dc0d498c` (2012). That
  predecessor is the change the candidate's diff context (the `&&
  !list_empty(&hdr->pages)` line) depends on.
- Record: No Fixes tag. Bug origin best matches `6c75dc0d498c` (2012)
  per related commit.

**Step 3.3: File History / Series**
- `git log fs-next -- fs/nfs/write.c` shows the immediate predecessors:
  `3a06bac55bf56` (Feb 2026, "NFS: improve 'Server wrote zero bytes'
  error") then `5d3869a41f360` (this commit, Apr 2026).
- The diff shown in the candidate uses the post-`3a06bac` context (`if
  (resp->count < argp->count && !list_empty(&hdr->pages))`). For a clean
  apply on stable, `3a06bac55bf56` should also land (it has Fixes: 2012,
  so likely already auto-selected).
- Standalone? Mostly. Localio bits depend on localio existing (v6.12+).
- Record: One reasonable prerequisite (`3a06bac55bf56`) for a clean
  context match; not a hard logical dependency though - the actual hunk
  additions only need pre-existing structure.

**Step 3.4: Author / Maintainer**
- Olga Kornievskaia: long-standing NFS client developer at Red Hat, many
  commits in `fs/nfs/`.
- Trond Myklebust: NFS subsystem maintainer; he applied and signed off.
- Record: High-trust authorship.

**Step 3.5: Dependencies**
- Required field `NFS_CONTEXT_FILE_OPEN` was added in 2021 (commit
  `e97bc66377bca`, Trond Myklebust); confirmed present in stable 5.15
  and later.
- `fs/nfs/localio.c` only exists in v6.12+ (added by `70ba381e1a431` for
  v6.12).
- Record: Pre-6.12 stable trees can take only the
  `write.c`+`pagelist.c`+`nfs_fs.h` portions; `localio.c` portion does
  not apply there.

## PHASE 4: MAILING LIST RESEARCH

**Step 4.1: b4 dig**
- `b4 dig -c 5d3869a41f360`: matched submission at
  https://patch.msgid.link/20260413222423.90089-1-okorniev@redhat.com
  (v3).
- `b4 dig -c 5d3869a41f360 -a`: three series found:
  - v1 (RFC) 2026-03-12:
    https://patch.msgid.link/20260312171526.85759-1-okorniev@redhat.com
  - v2 2026-03-25:
    https://patch.msgid.link/20260325180050.55186-1-okorniev@redhat.com
  - v3 2026-04-13: applied version
- `b4 am` for v3 thread: `Analyzing 1 messages in the thread` /
  `Analyzing 0 code-review messages` — no public review feedback, no
  reviewer-suggested `Cc: stable`.
- Major design change between v1 and v2: v1 used a per-page `PG_SYNC`
  bit; v2/v3 moved to per-open-context `NFS_CONTEXT_WRITE_SYNC` (because
  per-page flag is not persistent through page recycling) and added the
  localio path.
- v2 → v3 was a minor cleanup (compute `iov_iter_count` once into
  `icount` variable).
- Record: Three revisions; significant design rework v1→v2; v3
  essentially same as v2 with small refactor; no reviewer feedback
  visible on lore.

**Step 4.2: b4 dig -w (Recipients)**
- To: trondmy@kernel.org, anna@kernel.org. Cc: linux-
  nfs@vger.kernel.org.
- Both NFS maintainers (Trond Myklebust, Anna Schumaker) and the NFS
  list were addressed.
- Record: Correct maintainer audience; Trond's SOB shows he
  reviewed/applied.

**Step 4.3 / 4.4 / 4.5: Bug report / Series / Stable history**
- No external bug report / Reported-by / Link tags.
- Standalone fix; no patch series.
- Could not reach lore.kernel.org search interactively (Anubis bot
  protection). Relying on b4 dig output.
- Record: No external bug report references; no public stable discussion
  located.

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1: Modified Functions**
- `nfs_local_call_write`, `nfs_local_do_write` (localio path)
- `__nfs_pageio_add_request` (write submission/coalescing path)
- `nfs_write_completion`, `nfs_writeback_result`,
  `nfs_commit_release_pages` (write/commit completion)

**Step 5.2: Callers / Reachability**
- `nfs_writeback_result` is invoked as `rw_result` in `nfs_rw_write_ops`
  — runs on every NFS WRITE RPC completion. Universal NFS write path.
- `nfs_commit_release_pages` runs on every NFS COMMIT completion.
- `nfs_write_completion` runs on completion of a `nfs_pgio_header` group
  of writes.
- `__nfs_pageio_add_request` runs on every page added to a pageio
  descriptor — the core write submission coalescer.
- `nfs_local_call_write` runs in the localio (loopback NFS-on-same-host)
  write path.
- Record: All hot paths in NFS write submission and completion.
  Reachable on every NFS write from userspace.

**Step 5.3 / 5.4: Reachability**
- Trigger: NFS server returns ENOSPC, short write, or different verifier
  on commit. All are realistic in production (filling disk, quota,
  server reboot).
- Record: Reachable from any unprivileged write(2) over NFS once disk
  fills up.

**Step 5.5: Similar Patterns**
- The flag is consulted in two places (pagelist + localio); set in three
  places (writeback_result, commit_release_pages, local_call_write);
  cleared in one place (write_completion). Consistent design.
- Record: No other writeback retry logic relies on the same pattern;
  this is a fresh mechanism.

## PHASE 6: STABLE TREE ANALYSIS

**Step 6.1: Code in stable trees?**
- `nfs_writeback_result` and the unstable-write retry logic exist in
  essentially all currently-supported LTS (5.10, 5.15, 6.1, 6.6, 6.12+).
  Verified for v6.1 and v6.6 directly.
- The bug pattern (server ENOSPC + verifier mismatch loop) thus exists
  in all of them.
- `NFS_CONTEXT_FILE_OPEN` exists from v5.15+ — adding
  `NFS_CONTEXT_WRITE_SYNC` next to it is safe.
- Record: Bug present in 5.10 onward; flag header location compatible
  with 5.15+; for 5.10 a manual placement check would be needed.

**Step 6.2: Backport Difficulty**
- 6.12+ trees: Should mostly apply; the `nfs_writeback_result` hunk has
  a context dependency on `3a06bac55bf56` (also a stable candidate, has
  its own Fixes tag). Either land both, or fuzz/adapt one line of
  context.
- Pre-6.12 trees: No `fs/nfs/localio.c` — the localio hunks must be
  dropped. Core fix in `write.c`/`pagelist.c`/`nfs_fs.h` still applies.
- Record: Minor adjustment needed; not a clean-apply for all trees but
  conceptually portable.

**Step 6.3: Already in stable?**
- Not in any stable backport branch (`for-greg/*`); `git branch --all
  --contains 5d3869a41f360` returns only origin/master (mainline) and
  the upstream repo.
- Record: Not yet backported.

## PHASE 7: SUBSYSTEM CONTEXT

**Step 7.1: Subsystem Criticality**
- `fs/nfs/` (NFS client) — IMPORTANT: very widely used (every distro,
  enterprise, container/cloud workloads with NFS storage).
- Record: IMPORTANT / widespread use.

**Step 7.2: Activity**
- NFS client is actively maintained; Olga and Trond have been pushing
  many fixes recently.
- Record: Active subsystem.

## PHASE 8: IMPACT AND RISK

**Step 8.1: Affected Users**
- Any NFS client user where the server can return ENOSPC, short writes,
  or replays a different verifier (server reboot/crash mid-commit). That
  is essentially all production NFS deployments.
- Record: NFS users — broad.

**Step 8.2: Trigger Conditions**
- Server-side disk full, quota hit, or NFS server reboot/commit-retry.
  Common in real environments. Reproducer: xfstests generic/751.
- Triggered by unprivileged user writes.
- Record: Realistic and triggerable by any NFS user.

**Step 8.3: Severity**
- Failure mode: writeback `kworker` enters infinite retry loop. This
  means: dirty pages never clear, fsync(2) never returns, eventually the
  system exhibits hang task warnings, dirty memory accumulates,
  balance_dirty_pages-style throttling stalls all writers, application-
  level data is never reported back to userspace as failed.
- Severity: HIGH (effective hang of writeback, eventual OOM-class
  behavior, application data loss/incorrect error semantics; no kernel
  oops but a livelock that operators notice as a hung NFS).
- Record: HIGH severity (livelock in writeback / data loss-class
  symptoms).

**Step 8.4: Risk vs Benefit**
- BENEFIT: Eliminates a real, reproducible writeback livelock affecting
  all NFS users hitting ENOSPC or commit-verifier mismatch — high
  benefit.
- RISK:
  - Scope is medium (4 files / ~27 lines).
  - Touches hot paths (every NFS write/commit completion).
  - Behavior change: once a short-write/verifier-mismatch event happens
    on a file, the open context becomes "sticky-sync" until a successful
    unstable write+commit happens (which by construction can't happen
    until the flag is cleared, so realistically until the file is
    reopened). This is a permanent perf regression for the lifetime of
    that open fd after a single transient error.
  - The patch went through 3 iterations with a notable design change
    v1→v2 — author had to redesign once. v3 vs v2 is trivial.
  - No `Reviewed-by`/`Tested-by` from external parties on lore (only
    maintainer SOB).
- Net: Benefit clearly outweighs risk: livelock is severe; perf
  regression after error is acceptable; mechanism is contained to error
  paths.
- Record: HIGH benefit, LOW–MEDIUM risk, ratio favors backport.

## PHASE 9: SYNTHESIS

**Step 9.1: Evidence**

FOR:
- Real, severe, reproducible bug (xfstests generic/751).
- Concrete two-pattern description with offsets/lengths/return codes.
- Maintainer (Trond Myklebust) signed off and applied directly.
- Bug exists in essentially all current stable trees (logic since 2012).
- Authoritative author/maintainer pair.
- Single subsystem; small line count.

AGAINST:
- No `Fixes:` tag.
- No `Cc: stable` tag.
- No public reviewer trailers / Tested-by.
- v1→v2 design change indicates the design space was non-trivial.
- The flag is sticky-sync once set (intentional but a behavior change).
- Localio portion only relevant for v6.12+; pre-6.12 needs manual trim.
- One contextual prerequisite (`3a06bac55bf56`) for mechanical clean-
  apply on the `write.c` hunk near `nfs_writeback_result` — that
  prerequisite has its own `Fixes:` tag and is itself a likely stable
  candidate.

**Step 9.2: Stable Rules Checklist**
1. Obviously correct? Mostly — design is straightforward; no public
   review evidence to confirm "obvious", but maintainer applied it.
   Acceptable.
2. Real bug? YES — xfstests generic/751 reproducer.
3. Important? YES — writeback livelock, applies to NFS users hitting
   ENOSPC / server commit failures (= many production NFS users).
4. Small/contained? YES — 27 insertions / 1 deletion across 4 files in
   one subsystem.
5. No new features/APIs? No userspace API; adds an internal-only flag
   bit (NFS_CONTEXT_WRITE_SYNC). Acceptable.
6. Applies to stable? Mostly — needs context fuzz / drop of localio
   hunks for pre-6.12.

**Step 9.3: Exception Categories** Not applicable (not device ID, quirk,
DT, build, or doc fix).

**Step 9.4: Decision**

This is a real fix for a serious, reproducible NFS writeback livelock
that has existed for years in all current stable kernels. The change is
bounded to NFS error-handling paths, comes from the NFS subsystem
maintainer, and has a clear root-cause explanation tied to a standard
xfstests reproducer. The principal downsides — sticky sync after an
error, multi-revision design history, no Fixes/stable tag — are real but
do not outweigh the benefit of breaking an infinite writeback retry loop
for end users. Pre-6.12 backports require dropping the localio hunks;
otherwise the core fix is portable.

## Verification

- [Phase 1] Parsed subject/body from the commit message provided and
  from `git show 5d3869a41f360` — confirmed reproducer is xfstests
  generic/751; two failure patterns with offsets/return codes; author =
  Olga Kornievskaia, applied by Trond Myklebust. No Fixes/Cc-
  stable/Reported-by/Tested-by/Reviewed-by/Link tags.
- [Phase 2] Diff inventory verified via `git show 5d3869a41f360 --stat`:
  `fs/nfs/localio.c | 15 ++++++++++++++- ; fs/nfs/pagelist.c | 3 +++ ;
  fs/nfs/write.c | 9 +++++++++ ; include/linux/nfs_fs.h | 1 + ; 4 files
  changed, 27 insertions(+), 1 deletion(-)`.
- [Phase 2] Read current `fs/nfs/write.c` (lines 909–946 and 1545–1596)
  and `fs/nfs/localio.c` (lines 848–920) to confirm pre-patch behavior
  and where each hunk lands.
- [Phase 3] `git log master --oneline 5d3869a41f360 -2` confirms
  predecessor `3a06bac55bf56` ("NFS: improve 'Server wrote zero bytes'
  error"). `git show 3a06bac55bf56` shows it adds `&&
  !list_empty(&hdr->pages)` and has `Fixes: 6c75dc0d498c` (2012, v3.5).
- [Phase 3] `git tag --contains e97bc66377bca` shows
  `NFS_CONTEXT_FILE_OPEN` is in v5.15+ (and corresponding p-* internal
  tags).
- [Phase 3] `git tag --contains 70ba381e1a431` shows `fs/nfs/localio.c`
  was added in v6.12 only.
- [Phase 3] `git branch --all --contains 5d3869a41f360` shows the commit
  is only on origin/master and stable/master (mainline) — not in any
  backport branch.
- [Phase 4] `b4 dig -c 5d3869a41f360` returned the v3 lore URL:
  https://patch.msgid.link/20260413222423.90089-1-okorniev@redhat.com.
- [Phase 4] `b4 dig -c 5d3869a41f360 -a` returned three series (v1 RFC
  2026-03-12, v2 2026-03-25, v3 2026-04-13).
- [Phase 4] `b4 dig -c 5d3869a41f360 -w` confirmed To:
  trondmy@kernel.org, anna@kernel.org; Cc: linux-nfs@vger.kernel.org.
- [Phase 4] Read v1 mbox (`/tmp/analysis/v1/...`) — uses `PG_SYNC` per-
  page bit, no localio handling.
- [Phase 4] Read v2 mbox (`/tmp/analysis/v2/...`) — uses
  `NFS_CONTEXT_WRITE_SYNC`, includes localio handling. v2→v3 only
  difference is computing `iov_iter_count` into `icount` once.
- [Phase 4] `b4 am` of v3: 0 code-review messages on lore. Could not
  browse lore directly (Anubis bot wall) — relied on b4's mbox fetch.
- [Phase 5] Hunks inspected directly in `fs/nfs/write.c`,
  `fs/nfs/pagelist.c`, `fs/nfs/localio.c`; confirmed
  `nfs_writeback_result` is the standard `rw_result` callback for NFS
  write RPC completion (universal write path).
- [Phase 6] `git show v6.6:fs/nfs/write.c` and `git show
  v6.1:fs/nfs/write.c` confirm `nfs_writeback_result` and
  `nfs_commit_release_pages` use the same pattern as mainline (so the
  bug exists there).
- [Phase 6] `git show v6.6:fs/nfs/pagelist.c` confirms
  `__nfs_pageio_add_request` is structurally the same in v6.6.
- [Phase 6] `git log for-greg/7.0-200 --oneline -- fs/nfs/write.c` does
  not include `5d3869a41f360` or `3a06bac55bf56` — neither has been
  backported yet.
- [Phase 8] Severity assessment: livelock in writeback is verified by
  the reproducer described in the commit (xfstests generic/751) and by
  reading the loop logic in `nfs_writeback_result` /
  `nfs_commit_release_pages` showing how the retry path returns to the
  same state.
- UNVERIFIED: I could not directly confirm a public Tested-by
  (lore.kernel.org Anubis blocked manual browsing). b4 dig found no
  review trailers, but I cannot rule out off-list/Hammerspace internal
  testing. This does not drive my decision either way.
- UNVERIFIED: I did not separately verify that `3a06bac55bf56` will be
  selected for stable; that affects only the cleanness of context match,
  not correctness of the candidate's logic.

The fix addresses a serious writeback livelock with a concrete
reproducer, comes from the NFS maintainer, is bounded to the NFS
subsystem, and the bug exists across current stable trees. Risks are
modest (modest perf cost after errors, minor backport adjustments for
pre-6.12). On balance, this is appropriate stable material.

**YES**

 fs/nfs/localio.c       | 15 ++++++++++++++-
 fs/nfs/pagelist.c      |  3 +++
 fs/nfs/write.c         |  9 +++++++++
 include/linux/nfs_fs.h |  1 +
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 4c7d16a99ed61..e55c5977fcc3a 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -865,6 +865,8 @@ static void nfs_local_call_write(struct work_struct *work)
 	file_start_write(filp);
 	n_iters = atomic_read(&iocb->n_iters);
 	for (int i = 0; i < n_iters ; i++) {
+		size_t icount;
+
 		if (iocb->iter_is_dio_aligned[i]) {
 			iocb->kiocb.ki_flags |= IOCB_DIRECT;
 			/* Only use AIO completion if DIO-aligned segment is last */
@@ -881,8 +883,16 @@ static void nfs_local_call_write(struct work_struct *work)
 		if (status == -EIOCBQUEUED)
 			continue;
 		/* Break on completion, errors, or short writes */
+		icount = iov_iter_count(&iocb->iters[i]);
 		if (nfs_local_pgio_done(iocb, status) || status < 0 ||
-		    (size_t)status < iov_iter_count(&iocb->iters[i])) {
+		    (size_t)status < icount) {
+			if ((size_t)status < icount) {
+				struct nfs_lock_context *ctx =
+					iocb->hdr->req->wb_lock_context;
+
+				set_bit(NFS_CONTEXT_WRITE_SYNC,
+					&ctx->open_context->flags);
+			}
 			nfs_local_write_iocb_done(iocb);
 			break;
 		}
@@ -901,6 +911,9 @@ static void nfs_local_do_write(struct nfs_local_kiocb *iocb,
 		__func__, hdr->args.count, hdr->args.offset,
 		(hdr->args.stable == NFS_UNSTABLE) ?  "unstable" : "stable");
 
+	if (test_bit(NFS_CONTEXT_WRITE_SYNC,
+		     &hdr->req->wb_lock_context->open_context->flags))
+		hdr->args.stable = NFS_FILE_SYNC;
 	switch (hdr->args.stable) {
 	default:
 		break;
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index a9373de891c98..4a87b2fdb2e6e 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1186,6 +1186,9 @@ static int __nfs_pageio_add_request(struct nfs_pageio_descriptor *desc,
 
 	nfs_page_group_lock(req);
 
+	if (test_bit(NFS_CONTEXT_WRITE_SYNC,
+		     &req->wb_lock_context->open_context->flags))
+		desc->pg_ioflags |= FLUSH_STABLE;
 	subreq = req;
 	subreq_size = subreq->wb_bytes;
 	for(;;) {
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 1ed4b3590b1ac..ddae197d2d3f9 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -927,9 +927,13 @@ static void nfs_write_completion(struct nfs_pgio_header *hdr)
 			goto remove_req;
 		}
 		if (nfs_write_need_commit(hdr)) {
+			struct nfs_open_context *ctx =
+				hdr->req->wb_lock_context->open_context;
+
 			/* Reset wb_nio, since the write was successful. */
 			req->wb_nio = 0;
 			memcpy(&req->wb_verf, &hdr->verf.verifier, sizeof(req->wb_verf));
+			clear_bit(NFS_CONTEXT_WRITE_SYNC, &ctx->flags);
 			nfs_mark_request_commit(req, hdr->lseg, &cinfo,
 				hdr->ds_commit_idx);
 			goto next;
@@ -1553,7 +1557,10 @@ static void nfs_writeback_result(struct rpc_task *task,
 
 	if (resp->count < argp->count) {
 		static unsigned long    complain;
+		struct nfs_open_context *ctx =
+			hdr->req->wb_lock_context->open_context;
 
+		set_bit(NFS_CONTEXT_WRITE_SYNC, &ctx->flags);
 		/* This a short write! */
 		nfs_inc_stats(hdr->inode, NFSIOS_SHORTWRITE);
 
@@ -1837,6 +1844,8 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 		/* We have a mismatch. Write the page again */
 		dprintk(" mismatch\n");
 		nfs_mark_request_dirty(req);
+		set_bit(NFS_CONTEXT_WRITE_SYNC,
+			&req->wb_lock_context->open_context->flags);
 		atomic_long_inc(&NFS_I(data->inode)->redirtied_pages);
 	next:
 		nfs_unlock_and_release_request(req);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 8dd79a3f3d662..4623262da3c09 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -109,6 +109,7 @@ struct nfs_open_context {
 #define NFS_CONTEXT_BAD			(2)
 #define NFS_CONTEXT_UNLOCK	(3)
 #define NFS_CONTEXT_FILE_OPEN		(4)
+#define NFS_CONTEXT_WRITE_SYNC		(5)
 
 	struct nfs4_threshold	*mdsthreshold;
 	struct list_head list;
-- 
2.53.0


