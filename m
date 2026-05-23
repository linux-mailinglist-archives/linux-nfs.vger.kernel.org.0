Return-Path: <linux-nfs+bounces-21859-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAWABRKeEWr1oAYAu9opvQ
	(envelope-from <linux-nfs+bounces-21859-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 14:31:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A465BEE26
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 14:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F2813015883
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 12:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A2F29B8E1;
	Sat, 23 May 2026 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU+LJbLB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E231E34A767
	for <linux-nfs@vger.kernel.org>; Sat, 23 May 2026 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779539469; cv=none; b=qEHTiHfCVRLexZhpkKpEi0qWUmVEcJ3foTipqPwEetLtzSkilOtDZtnSD73LluxNWWE3nV17taSj+xwLHhYY+cDrbQqDd2ONICWQggVdGXchVKRcsJlgNtkL7V0I4335nxbR1OFb3qukkGWgKcfDKRF6INjdkg5KmN/w09v4ndk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779539469; c=relaxed/simple;
	bh=lPfLsuEru7s7Zjp+c+Ro6vfvvRixGRxpQtLo7wbk/pA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JWZBLqHRaZQT6wfTTf86rxZm7OKRLsBTq1yWoVcO79SP1F23tAy7cDKKbLylr1kSKtw2M1+c2qF/I/5BGg6cjygVKBntX5rmTYSrhMuw7616Ex3kxPKa80K46BhhfCIajVfN/cr26v7F66DRzgkgWOLyHwVkJOvDs2Ciau1Dxp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU+LJbLB; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so149898246d6.2
        for <linux-nfs@vger.kernel.org>; Sat, 23 May 2026 05:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779539467; x=1780144267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x7dxo5nogsk0I0nc3SICs60+I3meZih1pCQB0Y6CwFM=;
        b=PU+LJbLBE/nFHaw57DAyQATmzdYwHg7s8yZyA/cagqSEPX+Vcf68Cwoc+rdAOOVYMC
         0yUriDIA58EpW4lce5wELO6cj+mluMIDNmxyuacvRmTeH6pJIuichtghwt8lAvSTHths
         B9hvpX0FVE0Y4H46NVzbHmqxJnWS02mAOvx79YBEW6rmxNyqDfN/+YCIxeMt9UL2IN+C
         w0+eLXGJyCd9nhWlO06CwwV3xDFGwyPEQnG1UL76DG1uMeWDqqqa1zgZ/AqJLtPkLenR
         ENlUPUy+cMgVGDTYp22NZmzdYuAmdfBWG+gF8puVNScKY9OC/cQX3fLQUCk8PIiRKTqF
         PAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779539467; x=1780144267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7dxo5nogsk0I0nc3SICs60+I3meZih1pCQB0Y6CwFM=;
        b=qWHyoFJYBQeluCg0NMevLuyH9UiZXKKGXFyFrOc7S14zPdYAbW8zVmEKQH3guTEkq6
         9g8A+lb/f5qMibECJu4Gx4i6iz+lVi1iL815GGmTQm0a+0+ddjQ7rDfHBvMZQ1zZJWSV
         Oxsl6pnye4ZaXf+s+1h90OprMVl8jRO+lFR0egas0dPGvkpXgY4X1BDzoEHjJDgTevEN
         VljBvwWzcXFVSPD8LMDW7dslcbbrGXq3nBNqH6TLc/cpv522Z5RVRN7zZF7vg+BUC7Lr
         Gi2N5MC0lYcuvXYCGE5/eIgAMPMgjoPue7iFjHfr3P6GvqPZqiBcnz+GEfmTaW88eq3H
         LjIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+z7H+/JlKfyrGccO+fYF7QN0+ybJEYmsIG8Mi666sLWnVSdVE1DBUvWq7OPxBfvq2Yb6Igo6cR96w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtH6iqyUhNQYHKVQTnPry7kTS6f/UHaHfT+U5RfUm0leUZX1YC
	P77v/2sstB+02pKuGPZxq6woCwyxnBKt4pn6hXoVQlaPdXITOJbZ2l1v
X-Gm-Gg: Acq92OHp9x4QsilX/I5Y4YwUb3TJrkuvzF7jEDLfomL7qSxW0RFPYN+qcf+8X52zPsQ
	Ia3cNBt40nbCE+dGvctOPhWBRVdcwkbKSWIkjdvuygjkjMbnnsYsBU9yzt4HQfZGgH9xap0glUr
	SNjIoqMuZqkCoMP+vCe5n6q7OSHNXxuBz3lLTtc7Ac9gEgHUEONiDfuuhN0D3pfC7a5JL0/OJmf
	x1fUxBaP6W00J1brztHSQOkU6s5qKKxu+jV54jP0XzqwjMMszn0UZ0OT8eI7RJgvOS3HazGGUeD
	BgGG65TJWGfpXTN2sVkLh+77E/PPnqJO/5ZXJHLhnYwSOSA5lJ3KaZYsFagmNWDcF6OUQk0zHfn
	LzyVCnYmVyQJHmW9ZODMM2D+ExzFL0h1qkDotrAJVLIkbUgXKHCGRX4hpBoqwPjzmR0V7q6ZaGX
	S4s+Wppf1TESV+Km0gr5yWDDElJEIRyIQx5d+BcqvwkVSHICfjtgk1A5oFNScWa3VzdfV/yCEHU
	8ErT9j0QhATPssq4+yJ
X-Received: by 2002:a05:6214:242c:b0:8cc:3546:260b with SMTP id 6a1803df08f44-8cc7b620d46mr126661786d6.14.1779539466787;
        Sat, 23 May 2026 05:31:06 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8132f780sm45564746d6.49.2026.05.23.05.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 05:31:06 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] lockd: pin next file across nlm_inspect_file lock-drop
Date: Sat, 23 May 2026 08:30:53 -0400
Message-ID: <20260523123053.3480369-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-21859-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 81A465BEE26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nlm_traverse_files() pins the current file with f_count++ across
a mutex_unlock for nlm_inspect_file(), but nothing pins the saved
next pointer.  A concurrent nlm_release_file() can kfree the next
file during the unlock window, and the iterator dereferences freed
memory on the next loop step.

Pin both current and next before the lock-drop.  Advance by
swapping the pinned cursors at the end of each iteration so next
is always held alive across the unlock.

Only call nlm_file_release() for files that matched the predicate
and were inspected.  Skipped files just get f_count-- to undo the
iteration pin; their f_locks is stale and must not drive cleanup.

Cc: stable@vger.kernel.org
Fixes: 01df9c5e918a ("LOCKD: Fix a deadlock in nlm_traverse_files()")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/lockd/svcsubs.c | 64 +++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 20 deletions(-)


Changes since v1:
 - Fixed premature kfree of non-matching files: nlm_file_release()
   is now called only for files that matched the predicate and were
   inspected.  Non-matching files just get f_count-- to undo the
   iteration pin.  (Spotted by sashiko.dev automated review.)

Reproduced under UML + KASAN with 768 concurrent POSIX holders and
parallel /proc/fs/nfsd/unlock_filesystem writes.

Stock kernel:

  BUG: KASAN: slab-use-after-free in nlm_traverse_files+0x71d/0x9d0

  Allocated by: nlm_lookup_file via nlm4svc_proc_lock
  Freed by:     another nlm_traverse_files instance

Patched v2 UML kernel ran the same harness silently.

diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index dd0214dcb6950..0b38125cf86ab 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -295,36 +295,60 @@ static void nlm_close_files(struct nlm_file *file)
 /*
  * Loop over all files in the file table.
  */
+static void nlm_file_release(struct nlm_file *file)
+{
+	if (list_empty(&file->f_blocks) && !file->f_locks
+	    && !file->f_shares && !file->f_count) {
+		hlist_del(&file->f_list);
+		nlm_close_files(file);
+		kfree(file);
+	}
+}
+
 static int
 nlm_traverse_files(void *data, nlm_host_match_fn_t match,
 		int (*is_failover_file)(void *data, struct nlm_file *file))
 {
-	struct hlist_node *next;
-	struct nlm_file	*file;
+	struct nlm_file *file, *next;
 	int i, ret = 0;
 
 	mutex_lock(&nlm_file_mutex);
 	for (i = 0; i < FILE_NRHASH; i++) {
-		hlist_for_each_entry_safe(file, next, &nlm_files[i], f_list) {
-			if (is_failover_file && !is_failover_file(data, file))
-				continue;
+		file = hlist_entry_safe(nlm_files[i].first,
+					struct nlm_file, f_list);
+		if (file)
 			file->f_count++;
-			mutex_unlock(&nlm_file_mutex);
-
-			/* Traverse locks, blocks and shares of this file
-			 * and update file->f_locks count */
-			if (nlm_inspect_file(data, file, match))
-				ret = 1;
-
-			mutex_lock(&nlm_file_mutex);
-			file->f_count--;
-			/* No more references to this file. Let go of it. */
-			if (list_empty(&file->f_blocks) && !file->f_locks
-			 && !file->f_shares && !file->f_count) {
-				hlist_del(&file->f_list);
-				nlm_close_files(file);
-				kfree(file);
+		while (file) {
+			/*
+			 * Pin the next neighbour before we drop the mutex
+			 * for nlm_inspect_file(); a concurrent
+			 * nlm_release_file() under the same mutex would
+			 * otherwise be free to unlink and kfree it during
+			 * the unlock window, leaving us to dereference a
+			 * freed slab when we walked to next afterwards.
+			 */
+			next = hlist_entry_safe(file->f_list.next,
+						struct nlm_file, f_list);
+			if (next)
+				next->f_count++;
+
+			if (!is_failover_file || is_failover_file(data, file)) {
+				mutex_unlock(&nlm_file_mutex);
+
+				/*
+				 * Traverse locks, blocks and shares of this
+				 * file and update file->f_locks count.
+				 */
+				if (nlm_inspect_file(data, file, match))
+					ret = 1;
+
+				mutex_lock(&nlm_file_mutex);
+				file->f_count--;
+				nlm_file_release(file);
+			} else {
+				file->f_count--;
 			}
+			file = next;
 		}
 	}
 	mutex_unlock(&nlm_file_mutex);
-- 
2.53.0


