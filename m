Return-Path: <linux-nfs+bounces-21853-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOZuF/cFEWp+ggYAu9opvQ
	(envelope-from <linux-nfs+bounces-21853-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 03:42:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D754A5BC614
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 03:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33CF8301224B
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 01:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D390274B58;
	Sat, 23 May 2026 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYYwZH1A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB426CE39
	for <linux-nfs@vger.kernel.org>; Sat, 23 May 2026 01:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779500531; cv=none; b=GM7y1AHiVdJcnv4OmFwaXg0cS9CXTybnq8VHrewru0hjbKhaLT40caeqnKdnZlF5LCVs9OR1doJnwtPRo2aVvyNuJQV+LwrMJfg5JDdkpYnDFPXOrMkklT0RHuc8SS8Hbvvi0+fE3cDl1dFJzQwVqiH/fKWW2YQJMqdj+Kz6o3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779500531; c=relaxed/simple;
	bh=o2q4kvQvXzLlPBHCT1CFmRRF08gGuBL3GfqAu8UepH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cMNVpDmzFUsbVbph2/xiIaFC2ZUgJ0CpTGDF/WHhCOZdcEnudjSHzqEdG/xijKQb/2Du/qnnsXLkOZUnbUe3pQeNopSct5UY+7Ul9zTETHMyeJpQ9NR6KgmY7jcgY9Ghp5k9Gf58vLrS4Yrd6srmRbj7b/cUY0+8Yu0TToRrCjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYYwZH1A; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-914ae4101b4so258947385a.2
        for <linux-nfs@vger.kernel.org>; Fri, 22 May 2026 18:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779500529; x=1780105329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ojp1jufJnHXpy70948CVqK0ijPBwOg1yOqO14HsqH1o=;
        b=VYYwZH1AA8deo520tO6Y7c1OCyJIifRh3ZqoNDGJLRihyDTPmHNJ+9FtS+9H7cGyYo
         LjqcPrInEs/Rd84kZjJZGToyhocstZu3CtOoHeb0o7mA6SB2ORtBMSGaLGh669T0FA6M
         KrkdfuUVgElouCN6GNjQbWogYURzV+7WZCGKnQJR33EZ5JbzM0tjACyQmQahBBdbs6Vg
         Nin7VvBv5Pds1KCzGf5yTdahrJQz1ec5D0I6nxP4IvcBRtvJyrkPvobf/LbVZa6rTGEh
         CRsW5i0dmHvC9cCzfzS7K7DfWrGbnIQseimznOIRii8iS5MlwntCysvhWF61re2ZAD4c
         uuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779500529; x=1780105329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojp1jufJnHXpy70948CVqK0ijPBwOg1yOqO14HsqH1o=;
        b=tDxoh+U/M2XQVwqJMMoNabYsjXw6n0hwNPgA63aosbLubNqugb8gkhSkvjeIoa5lxe
         ssDyOev+9a5upbIDbq5haWdxralrAci5mwdhYDS2AYxH1Z21XnWH7TgstR9xNtIuCiKr
         zaCL8fTjcK4SVlzaUd8juqN9AgCDf+RPlXW6l4ExrpywJa+tzRsRCgIz3WnlneHvga+a
         KsYLnB0ljjyIUvXV4Au0Ix4A5fgFWRttjwkI9/3MHV+Sm3kD6uG3TxpdJmGt89tRZe77
         ai7498yWkndCy///qwCCcvbnTeQAElpbOMT6J3mBNNAtxKPP0SfGbwWAtQxNdb7YOc9y
         8dQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xCqNKZaO7dCAp0x+0fPPiV/WrEIIWAGEAseMDwbOCe7XgZtwxilxvnsMw7JUFQ1kSuPs3DgoUUJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpthk3EXwmshf1rfgpy5CIwqhrZ+CDqb5ZER61TreaArCqjj3H
	0KZq1k3Ku3JVLPIL9RxDJQhobpxf+HQC95Gmw/V0IYBPPX+gGTFUkuxR7bwF8AB40mI=
X-Gm-Gg: Acq92OHn/kT6zWYHOSs6M1AAoUGk9OoiogjQSZHOmRhgEIMeQlbKFCuZ8t/OJH45BXm
	rYPuwsoxTn0OgMn9BNQk6WHYTWLFreo4y7ANDiljw4M/NU+/XPw8b1FR8177iEY1yAHaF/DS118
	Z7tXm6CekaS8oQk87yEtH2NdqpJxctp6AzD3P9nbZ+j0y5Dx9SXp8tSrpqLMYF3E9dpCrANWS8E
	JzyqbgYzQHgEIkvIRsryvd+IpZ8gWhq5T4KO/QWqBlS4DhY3ZZ12rU5HUzHylA9WnTA8xmdMa4j
	P42w/PEme/9jATQ9pg/cdg334x+qhfg2R8u/whp2+MEJRlCp9dx6js1KfIVAT/I4ibGpVAY5jHF
	Hk084i4bkb8VVX2Txf/cCHeCzJwJhn4ckZkGEQNpO9GNkUFP3Yzg1uLt3Uca9L7rIm32eYd73AT
	CHGUVys/xDQ4XdiX8Sl1Ab1KVZwOKQ9hpTAhkIGjXJHlP1lBbdStVPLUtsCODqI79lqER7T8PAQ
	pb32hGsFNlpmFMBBgXX
X-Received: by 2002:a05:620a:649b:b0:914:c53f:4d51 with SMTP id af79cd13be357-914c53f5006mr189756285a.53.1779500528669;
        Fri, 22 May 2026 18:42:08 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8cd286sm283616985a.3.2026.05.22.18.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 18:42:08 -0700 (PDT)
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
Subject: [PATCH] lockd: pin next file across nlm_inspect_file lock-drop
Date: Fri, 22 May 2026 21:42:03 -0400
Message-ID: <20260523014203.2462827-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-21853-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D754A5BC614
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nlm_traverse_files() walks each nlm_files[] hash bucket with
hlist_for_each_entry_safe(file, next, ...). For each matching file
it bumps f_count, drops nlm_file_mutex to run nlm_inspect_file()
(which may sleep walking blocks, shares, and the inode lock list),
then reacquires the mutex and decrements f_count before continuing
to the saved next.

The f_count bump pins the current file across the lock-drop, but
nothing pins next. Any nlmsvc thread that holds the last reference
on the file at next will, during that window, call
nlm_release_file() -> nlm_delete_file() under nlm_file_mutex,
hlist_del() it from the bucket, and kfree() it. When
nlm_traverse_files() reacquires the mutex and the macro reads the
next entry's f_list.next on the following iteration, the read lands
in the freed slab.

A naive restart-on-action variant would deadlock-spin against an
nlm_release_file holder: nlm_inspect_file() does not always drain
the file (it can return 1 with an RPC still holding f_count above
the cleanup threshold), and the outer predicate is_failover_file()
matches static attributes of the file, so a restart can keep
re-finding the same un-cleanable file until the external RPC ref
drops.

Pin the neighbour explicitly instead. Walk the bucket with two
locally-pinned cursors at a time: file (current, pinned by the
prior iteration's next bump) and next (one ahead). Drop file's pin
at the end of each iteration, then advance to next, which is still
alive because we hold its f_count above zero across the unlock.
This bounds the walk at O(N) per bucket and never observes a freed
neighbour. Factor the f_count/list/share/lock cleanup into a
helper so the no-match path also drops a stale empty file rather
than leaving it in the table.

Cc: stable@vger.kernel.org
Fixes: 01df9c5e918a ("LOCKD: Fix a deadlock in nlm_traverse_files()")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/lockd/svcsubs.c | 61 +++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 19 deletions(-)

Reproduced under UML + KASAN with a loopback NFSv3 mount, 768
concurrent POSIX fcntl(F_SETLKW) holders, and parallel writes to
/proc/fs/nfsd/unlock_filesystem forcing nlmsvc_unlock_all_by_sb()
to walk the table while clients churn locks.

Stock kernel:

  BUG: KASAN: slab-use-after-free in nlm_traverse_files+0x71d/0x9d0
  Read of size 8 at addr 0000000070314800 by task nlm-init-...

  Allocated by: nlm_lookup_file via nlm4svc_proc_lock
  Freed by:     another nlm_traverse_files instance freeing a
                file whose f_count dropped to zero during the
                nlm_inspect_file() unlock window

Patched UML kernel ran the same harness silently.

Pin-next was chosen over restart-on-action because the latter can
livelock when nlm_inspect_file() returns 1 with an RPC reference
still holding the file above the cleanup threshold and the outer
is_failover_file() predicate matching static attributes.


diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index dd0214dcb6950..2bfa32207f10c 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -295,36 +295,59 @@ static void nlm_close_files(struct nlm_file *file)
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
+			}
 
-			mutex_lock(&nlm_file_mutex);
 			file->f_count--;
-			/* No more references to this file. Let go of it. */
-			if (list_empty(&file->f_blocks) && !file->f_locks
-			 && !file->f_shares && !file->f_count) {
-				hlist_del(&file->f_list);
-				nlm_close_files(file);
-				kfree(file);
-			}
+			nlm_file_release(file);
+			file = next;
 		}
 	}
 	mutex_unlock(&nlm_file_mutex);
-- 
2.53.0


