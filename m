Return-Path: <linux-nfs+bounces-20753-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKZWMBZm1mnIEwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20753-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 16:28:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E523BDA64
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 16:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27AEB300D6AE
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 14:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C313451A9;
	Wed,  8 Apr 2026 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZZs7UeD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2AA2BD030;
	Wed,  8 Apr 2026 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658338; cv=none; b=HCSVyGDfH5185tr6mPX65qh+DsPAXMgbD/k3Nx8FrvQB6TTT9WPEz9h7B4y7mVQX8X4tzaUoVZCBQb1DkICYU5+9AXajlBLu2pGNYahgwRpzBgkyKRqdZqH+Ii7j6lRWS8eKtvnFcOUGuNPoDKEoH5PIEia1yOlr1+48DWIJVWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658338; c=relaxed/simple;
	bh=LaU4lymwRqUzsrSYFwTvQRe3EwpBxyvxlWtQa0zSRIc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RPgsaoI+evHFEiF1EtFb6xe+SXF6ieJQtjjPC1+8XfhY2EvIp2SWUsWjAtz9ny0YbUu246joV42AvY1zTWZF39NPDFFfPCDyh7P6WmVucR+NkJqClBsSVvG+mLF9DZ8vVcnT09ljHni9ZM8KvFxitu5dGNGohCZRE17GPdqqPAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZZs7UeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2672C19421;
	Wed,  8 Apr 2026 14:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775658337;
	bh=LaU4lymwRqUzsrSYFwTvQRe3EwpBxyvxlWtQa0zSRIc=;
	h=From:Subject:Date:To:Cc:From;
	b=SZZs7UeDTuG4bF+ARiTMg6dN7DxKteaRFQtIohk0CQkZLiA75Mj8jGOxRF4ENFJFd
	 sFAVUJ/teb994zqqMgnXwgJXTy3NhwirFO4CZnkNr8CN92ZXrEUhPlQAtRn9H9/1oc
	 96QpgV0NLbOXnDU/UTszNW0QgEjCg/LHeSHxdzaEmNeeuJHtEFp8gxuOAvptUlLutD
	 6Tc0LK53WICYsRHdia1skGc7BF7TeiER/eukkp0Cet+hg9Jt/ZKBbbYTJl0DjlRpIM
	 sYBQzzVGYbW4aMK5EDz8oV60MrV2qvk6zJLto5udsicYk9tXVFaZPcsYkLg7Ls6Q8h
	 EmW1OG9t3X2vg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/3] mm: improve write performance with RWF_DONTCACHE
Date: Wed, 08 Apr 2026 10:25:20 -0400
Message-Id: <20260408-dontcache-v2-0-948dec1e756b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23MQQ7CIBCF4as0sxYDSItx5T1MFwhDmWjAQEM0D
 XcXu3b5v7x8GxTMhAUuwwYZKxVKsYc8DGCDiQsycr1BcjlxxQVzKa7W2IBsPAuB3mk0/gT9/8r
 o6b1bt7l3oLKm/NnpKn7rP6UKxpnwo1aTN3elzfWBOeLzmPICc2vtC+SWJyyjAAAA
X-Change-ID: 20260401-dontcache-5811efd7eaf3
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5441; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=LaU4lymwRqUzsrSYFwTvQRe3EwpBxyvxlWtQa0zSRIc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1mVaxLtjU2EQznuRQuIYxnmVa95wrmsHC/V7q
 UlgBI4HwbqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadZlWgAKCRAADmhBGVaC
 FWYVD/4z69kvHMYeNYgH04n3YtWn+9xJfCLt7Z50lfVF8XnEsgLlcoXPo7o/0di0i1JTam56Mqg
 yHpus74D71ygMPvJRgn/dNt10PFXwhfg1OWujD/nt3zN5xTKuSWPW41aFdvCSs2WjBIzaU1NEtD
 Dz3WHMD96TtsjZR3n2KugNx+rSU5aHiaOu1mpX8UQUvUG971iKvdmxwQ+PhNVk0zKCWbDqdQtIZ
 QsYoTu5w7xR8U5cOTPtFcI1yCesYaybctqyfts+y8RQJtrf0a4aZ+KmlJiorVokdyOZEWBHHngo
 OnzAowI+Bt6wTvTTg4uJBqpuQnakawp0Fvfn8X21YenlYVSqM5WY6ArCKCbePd5f323vAouXQhN
 sXpGxlHzr/c9m3FuDtV+zORiWoQUQdSBn4JBC/YKSyZkUqipr6n9d1fXtqQTr65tMg+/PA4NsN2
 N4trEUIxIht2+0c+DPWXR4WPOah96ZpmSv63X4jYyJ7ajDZEDGiJAInD6CHcxWIkh3BLLAcdTxw
 oVlb6XU8l+uk0Fz8rqZObxFoCm1epmGfQVbbs8fTucKsfC2WsjqIxImMR5RVi5V9n/nnQs3Biw5
 w2KDyeOOcaC//EnpAvaxxvmeak5Ozy9bH+9wOTl14Cimnk8jhNVXwH5DXbJyJXWbBbgGF76KHMf
 PQ50VyqwXEWlJpA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20753-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,markdownpastebin.com:url]
X-Rspamd-Queue-Id: 23E523BDA64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This version adopts Christoph's suggest to have generic_write_sync()
kick the flusher thread for the superblock instead of initiating
writeback directly. This seems to perform as well or better in most
cases than doing the writeback directly.

Here are results on XFS, both local and exported via knfsd:

    nfsd: https://markdownpastebin.com/?id=1884b9487c404ff4b7094ed41cc48f05
    xfs: https://markdownpastebin.com/?id=3c6b262182184b25b7d58fb211374475

Ritesh had also asked about getting perf lock traces to confirm the
source of the contention. I did that (and I can post them if you like),
but the results from the unpatched dontcache runs didn't point out any
specific lock contention. That leads me to believe that the bottlenecks
were from normal queueing work, and not contention for the xa_lock after
all.

Kicking the writeback thread seems to be a clear improvement over the
status quo in my testing, but I do wonder if having dontcache writes
spamming writeback for the whole bdi is the best idea.

I'm benchmarking out a patch that has the flusher do a
writeback_single_inode() for the work. I don't expect it to perform
measurably better in this testing, but it would better isolate the
DONTCACHE writeback behavior to just those inodes touched by DONTCACHE
writes.

Assuming that looks OK, I'll probably send a v3. Original cover letter
from v1 follows:

-----------------------------------8<------------------------------------

Recently, we've added controls that allow nfsd to use different IO modes
for reads and writes. There are currently 3 different settings for each:

- buffered: traditional buffered reads and writes (this is the default)
- dontcache: set the RWF_DONTCACHE flag on the read or write
- direct: use direct I/O

One of my goals for this half of the year was to do some benchmarking of
these different modes with different workloads to see if we can come
up with some guidance about what should be used and when.

I had Claude cook up a set of benchmarks that used fio's libnfs backend
and started testing the different modes. The initial results weren't
terribly surprising, but one thing that really stood out was how badly
RWF_DONTCACHE performed with write-heavy workloads. This turned out to
be the case on a local xfs with io_uring as well as with nfsd.

The nice thing about these new debugfs controls for nfsd is that it
makes it easy to experiement with different IO modes for nfsd. After
testing several different approaches, I think this patchset represents a
fairly clear improvement. The first two patches alleviate the flush
contention when RWF_DONTCACHE is used with heavy write activity.

The last two patches add the performance benchmarking scripts. I don't
expect us to merge those, but I wanted to include them to make it clear
how this was tested.  The results of my testing with all 4 modes
(buffered, direct, patched and unpatched dontcache) along with Claude's
analysis are at the links below:

nfsd results: https://markdownpastebin.com/?id=0eaf694bd54046b584a8572895abcec2
xfs results: https://markdownpastebin.com/?id=96249deb897a401ba32acbce05312dcc

I can also send them inline if people don't want to chase links.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- kick flusher thread instead of initiatin writeback inline
- add mechanism to run 'perf lock' around the testcases
- Link to v1: https://lore.kernel.org/r/20260401-dontcache-v1-0-1f5746fab47a@kernel.org

---
Jeff Layton (3):
      mm: kick writeback flusher instead of inline flush for IOCB_DONTCACHE
      testing: add nfsd-io-bench NFS server benchmark suite
      testing: add dontcache-bench local filesystem benchmark suite

 fs/fs-writeback.c                                  |  14 +
 include/linux/backing-dev-defs.h                   |   1 +
 include/linux/fs.h                                 |   6 +-
 include/trace/events/writeback.h                   |   3 +-
 .../dontcache-bench/fio-jobs/lat-reader.fio        |  12 +
 .../dontcache-bench/fio-jobs/multi-write.fio       |   9 +
 .../dontcache-bench/fio-jobs/noisy-writer.fio      |  12 +
 .../testing/dontcache-bench/fio-jobs/rand-read.fio |  13 +
 .../dontcache-bench/fio-jobs/rand-write.fio        |  13 +
 .../testing/dontcache-bench/fio-jobs/seq-read.fio  |  13 +
 .../testing/dontcache-bench/fio-jobs/seq-write.fio |  13 +
 .../dontcache-bench/scripts/parse-results.sh       | 238 +++++++++
 .../dontcache-bench/scripts/run-benchmarks.sh      | 562 ++++++++++++++++++++
 .../testing/nfsd-io-bench/fio-jobs/lat-reader.fio  |  15 +
 .../testing/nfsd-io-bench/fio-jobs/multi-write.fio |  14 +
 .../nfsd-io-bench/fio-jobs/noisy-writer.fio        |  14 +
 tools/testing/nfsd-io-bench/fio-jobs/rand-read.fio |  15 +
 .../testing/nfsd-io-bench/fio-jobs/rand-write.fio  |  15 +
 tools/testing/nfsd-io-bench/fio-jobs/seq-read.fio  |  14 +
 tools/testing/nfsd-io-bench/fio-jobs/seq-write.fio |  14 +
 .../testing/nfsd-io-bench/scripts/parse-results.sh | 238 +++++++++
 .../nfsd-io-bench/scripts/run-benchmarks.sh        | 591 +++++++++++++++++++++
 .../testing/nfsd-io-bench/scripts/setup-server.sh  |  94 ++++
 23 files changed, 1928 insertions(+), 5 deletions(-)
---
base-commit: 9147566d801602c9e7fc7f85e989735735bf38ba
change-id: 20260401-dontcache-5811efd7eaf3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


