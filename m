Return-Path: <linux-nfs+bounces-21326-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGUrOJJ39Gk7BgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21326-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 11:51:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ADA4AB635
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 11:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38157300B47E
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2026 09:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD40136826E;
	Fri,  1 May 2026 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AE9kxXYN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892CC350D7D;
	Fri,  1 May 2026 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777629015; cv=none; b=s4z1eTLadkmQ9xf2B+YBnS9rsQpfS1MoqLEdx/EXAG9GwdwKVUWW0i3tVyDGHMuabYAcAtbwLALNfjfSbGMyo7hHRP2ABgwnc2jWxtM1aDQNtxTvMQgWAqBjYIr+vYsRSXXWtZcATT+dIKEDrYoQ3b04ld/9Gilma1r3C0y5gH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777629015; c=relaxed/simple;
	bh=mP+fXN+cyH0QE8nS6Oz/OpXZk5m+VMXyOKE7LaxfOhU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KPZe4kxvYnG5lViZd+mS/qh9QIOXaMfThLerV0kqYwGfZgTFOledl7NVqYxsU0oj/COPunjrwueNd0IkLfdLw6s5JzGr6zZup7qwYdXyvZEsyLb7MntGT2Y2G776CDQzRPf8zc2lBbFeKlbBK3yDIpH1yrXPSim2qrf04V1CnEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AE9kxXYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72166C2BCB4;
	Fri,  1 May 2026 09:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777629015;
	bh=mP+fXN+cyH0QE8nS6Oz/OpXZk5m+VMXyOKE7LaxfOhU=;
	h=From:Subject:Date:To:Cc:From;
	b=AE9kxXYN20in1PQFB2FIpDD/FJhdX3b0QIsQhWSW/y+KVKeacFOn77Kb5GLGO4scX
	 oPEOSW0E6fkR7txGW6BEfT8w1rFqRrIizIjWxqqGfGfYsc6rBwf/xRzCfv5s51lOkg
	 JeSCM5r/0Cmoz3Xlq/lcu8q5AF6qf3wzeXmpJ0WATmoogcxXvzOeH5VcaSmZfMvncF
	 QTR+VwLGUQFOTB4mS5Cj9ZIypNANkJUvY4kpxsm5pFTYxvBKuAqzVKADw67m6soE0p
	 tKDFjSqChmG2h+NhIjYIMhFLmoWvOyh0qK/aEVy5uYTuzpTQMKjqY+eiTe0MkHnUwU
	 fpnG7OfavuC3A==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 0/4] mm: improve write performance with RWF_DONTCACHE
Date: Fri, 01 May 2026 10:49:34 +0100
Message-Id: <20260501-dontcache-v4-0-5d5e6dc71cb3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23MTQ7CIBCG4asY1mKA8tO68h7GBYWhJRow0DSap
 neXdoXR5TeZ511QhuQho/NhQQlmn30MZfDjAZlRhwGwt2UjRpgknFBsY5iMNiNg0VIKzirQrkH
 l/5nA+dfeut7KHn2eYnrv6Zlu13+VmWKCqROKS6d7rvTlDinA4xTTgLbMzGra1pQV2vHWgqGgh
 Ox/aFNRJmvaFKo66BtldSe4+qLrun4AkWURtRkBAAA=
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
 Ritesh Harjani <ritesh.list@gmail.com>, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3840; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mP+fXN+cyH0QE8nS6Oz/OpXZk5m+VMXyOKE7LaxfOhU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp9HdOa0u0OLd8ip7GlOCc1ttZzER5B1Il5CNrT
 xGtvmsi4EGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafR3TgAKCRAADmhBGVaC
 FRLQEADXbJsWzNf6xlledXUOy4FvUKU8SNZY54YjBCf4Tqyat3f9Aqy3BEgKo6q7+9sMAYmLriK
 IcCUN8Mxxc1XGR4srl6uTf4vveaNzepzTMonBen210IBhm6zmDL92iiCj8AOKBNgtidBze0Nfg7
 XMwsdicxH66RXnSM/y3bdrcJRUAHk7M6t6r9LZ12CfgApcCGXPqW6NwzAg/88A962tDl2/oep6B
 3AoHavnSpi0gYi/cW5IJIKQ8g/M93LMGBTBR8x+VjawVyAkG2+gb56ByCAdgUXSRSdzHZ3BG2KA
 bTNHgPx2Y2O/aRQ7wzNg9HxrHVBLqwEG12Iq2cDTwkd0p+KV+05CmEFCcWUQRxCukhf14wzbP/P
 gGDBiUf33lezTJldqtLhyzYaM/hsP/r9RgwvRMNzxR/pKrqSd1Erras6As2sPPoy2tfcJAEWqe1
 udk6X9zFA/aZxWdvomoVRtCyjBQ61mMDXGl9EdqiG6Xijms0CxVKS+gjhu4+cLRBMRihWt1Zq7O
 Ue78ljy0nFc70iCld6I06SO9cMgCMmHKgUPtLOtHeS9xGwmERx5aveG2jYpk7+NnRmijs2I2B9y
 peFUXvIYZIO5daBqodbpTUSmHwa3QhPF749nVazDzaEO2YXrYC/QAIRNRPZe42Nmc0N/4zfUBvY
 Fz+6DJkvsj8mJoA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 51ADA4AB635
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21326-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,linux-foundation.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Here's a new version for everyone to contemplate while traveling!

This patch series attempts to improve write performance with
RWF_DONTCACHE. The main justification and benchmarks for the series are
in patch #2.

This version implements a scheme that Jan Kara and Christoph Hellwig
suggested during review of the earlier series: after a DONTCACHE write,
kick the flusher thread to do an amount of writeback proportional to the
amount written, but don't target any particular inode or pages when
doing writeback.

The second patch in the series has a summary of the benchmark results.
This seems to markedly improve RWF_DONTCACHE write performance in all
the benchmarks I tested.

The benchmarks I used are in the last two patches. I'm not sure if we
want to merge those into the tree as they are (mostly) AI slop. There
is probably a better tool for this out there.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v4:
- Track DONTCACHE dirty pages per bdi_writeback
- New benchmark for competing buffered and dontcache writers
- New benchmark replicating Jens' original 32 concurrent writer test
- Link to v3: https://lore.kernel.org/r/20260426-dontcache-v3-0-79eb37da9547@kernel.org

Changes in v3:
- Track dirty DONTCACHE pages in the VM
- Have flusher write back a proportional number of pages after DONTCACHE write
- Link to v2: https://lore.kernel.org/r/20260408-dontcache-v2-0-948dec1e756b@kernel.org

Changes in v2:
- kick flusher thread instead of initiating writeback inline
- add mechanism to run 'perf lock' around the testcases
- Link to v1: https://lore.kernel.org/r/20260401-dontcache-v1-0-1f5746fab47a@kernel.org

---
Jeff Layton (4):
      mm: track DONTCACHE dirty pages per bdi_writeback
      mm: kick writeback flusher for IOCB_DONTCACHE with targeted dirty tracking
      testing: add nfsd-io-bench NFS server benchmark suite
      testing: add dontcache-bench local filesystem benchmark suite

 fs/fs-writeback.c                                  |  60 ++
 include/linux/backing-dev-defs.h                   |   3 +
 include/linux/fs.h                                 |   6 +-
 include/trace/events/writeback.h                   |   3 +-
 mm/filemap.c                                       |  13 +-
 mm/page-writeback.c                                |   6 +
 .../dontcache-bench/fio-jobs/axboe-write.fio       |  14 +
 .../dontcache-bench/fio-jobs/lat-reader.fio        |  12 +
 .../dontcache-bench/fio-jobs/multi-write.fio       |  11 +
 .../dontcache-bench/fio-jobs/noisy-writer.fio      |  12 +
 .../testing/dontcache-bench/fio-jobs/rand-read.fio |  13 +
 .../dontcache-bench/fio-jobs/rand-write.fio        |  13 +
 .../testing/dontcache-bench/fio-jobs/seq-read.fio  |  13 +
 .../testing/dontcache-bench/fio-jobs/seq-write.fio |  13 +
 .../dontcache-bench/scripts/parse-results.sh       | 346 +++++++++++
 .../dontcache-bench/scripts/run-benchmarks.sh      | 643 +++++++++++++++++++++
 .../testing/nfsd-io-bench/fio-jobs/lat-reader.fio  |  15 +
 .../testing/nfsd-io-bench/fio-jobs/multi-write.fio |  14 +
 .../nfsd-io-bench/fio-jobs/noisy-writer.fio        |  14 +
 tools/testing/nfsd-io-bench/fio-jobs/rand-read.fio |  15 +
 .../testing/nfsd-io-bench/fio-jobs/rand-write.fio  |  15 +
 tools/testing/nfsd-io-bench/fio-jobs/seq-read.fio  |  14 +
 tools/testing/nfsd-io-bench/fio-jobs/seq-write.fio |  14 +
 .../testing/nfsd-io-bench/scripts/parse-results.sh | 238 ++++++++
 .../nfsd-io-bench/scripts/run-benchmarks.sh        | 591 +++++++++++++++++++
 .../testing/nfsd-io-bench/scripts/setup-server.sh  |  94 +++
 26 files changed, 2199 insertions(+), 6 deletions(-)
---
base-commit: 26fd6bff2c050196005312d1d306889220952a99
change-id: 20260401-dontcache-5811efd7eaf3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


