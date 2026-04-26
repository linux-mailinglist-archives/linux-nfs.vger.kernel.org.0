Return-Path: <linux-nfs+bounces-21100-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CADLGL/97WndpgAAu9opvQ
	(envelope-from <linux-nfs+bounces-21100-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 13:57:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE410469AF7
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 13:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EA1B300C278
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 11:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B196346FA0;
	Sun, 26 Apr 2026 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkx2DBIS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E825417C211;
	Sun, 26 Apr 2026 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777204600; cv=none; b=VH69FmOjtYNLIgIMdcSFuUv6WzZ/oJI4XMqa7lvrPJCl2Vty8oGuVeNuvvk6pvfGzlv2UUMPCkqC5yavkLdUNomzXh2SVM6WcY477IJAWrRLU59hOLNu2ZHf9QI6ghNRnluT1iVPHVash6WggYx8XZAh7gE3w3qfdVXXaMH4QZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777204600; c=relaxed/simple;
	bh=bl3sJbVGz9TiGz2FlHfKChu0f4MKe8tz0T9GJRS1TBM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MisATrBZDwkFsDgurZJsXC7nUycQ/ImJ4AbcEXyRHLUskQqKUjaglcd0Aa0cw2pALM9O6bD8UsJ4mWsNE5bdZFnWrmWfR/VLIbEJOeJthr9Ke/hIOVc2Dn84k+16MAYDhaoS8dnLRdH9fDjR20SsUAELDYwkRhQKExLkK7jbYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkx2DBIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1221C2BCAF;
	Sun, 26 Apr 2026 11:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777204599;
	bh=bl3sJbVGz9TiGz2FlHfKChu0f4MKe8tz0T9GJRS1TBM=;
	h=From:Subject:Date:To:Cc:From;
	b=pkx2DBISHsaExlC7SN08Iq4EDDICnkycUtGnKY5GeLzk8p55eo/XF2fE6FkPsC9iy
	 2YSYKU9VVJUgVRZjhSzRouPan1R3RiuLGhnkPZIY5CGz0Do2h7RBJ77VAxOmMegNc1
	 YalwLgs8OOCjenA471qkhEhY15v5aFa2w/dQqXu15/MjQh3fr0lFyBwAJmnn379+JW
	 fYKUzigcRAIkhiWB+Vwy8uM/uJgC9Vtro3SuDh4rpsYdaRsRipqo7RyILqk4EPuPG3
	 AkP7YphApRU1F7aimgj7btwPdQFfB2czHxsU6kC9emKkUVe4ap+seJ6nGG/oMIXBuy
	 +Qd5XJzc5ae4Q==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 0/4] mm: improve write performance with RWF_DONTCACHE
Date: Sun, 26 Apr 2026 07:56:06 -0400
Message-Id: <20260426-dontcache-v3-0-79eb37da9547@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22MQQ6DIBQFr2L+ujSAKLar3qPpAuGjpA0YMKSN8
 e5FVzbpcl7ezAIJo8ME12qBiNklF3yB+lSBHpUfkDhTGDjlLRWUERP8rJUekTQdY2iNRGVrKP8
 ponXvvXV/FB5dmkP87OnMtvVfJTNCCbONFK1VvZDq9sTo8XUOcYAtk/lR7Y4qL+pFdAY1Q9m0/
 Y+6rusXm5JfjN4AAAA=
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
 Christoph Hellwig <hch@infradead.org>, Kairui Song <kasong@tencent.com>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3511; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=bl3sJbVGz9TiGz2FlHfKChu0f4MKe8tz0T9GJRS1TBM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp7f1qg1sKuyaOZKrn3qCqDk/uRJ3vfoQhHnBVM
 EQ/kc3F7cyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCae39agAKCRAADmhBGVaC
 FR0qEAC/tsTXxpbW9lpyK7ZFDMkpNcA2PMA93Bpgv7oLQI/LKg8aybErtMbgtFZ7vAElKL7BNoq
 cRmUU4BGOS5fBjpJL/ZmDCeAoQveWsDIncrUDoSshvPREODKr3urQywMntRtYzfr9Iq371l25EL
 KAXHyQmxQN2f3R4iVdyeuCm6ETxzFMdk1+zROdadqogg0GQ3uaZJb3YrxchmHrdXj3H9tSHZu5q
 27GD7c8hldvxxPWJyEk5G8mBcLj60cmO/muMgsIqliLi+us8QK7f/PjIV9xUvq4/EV2DZpd2coH
 hCiqe8mNgKw6er1ciK0t9Pn/2oSUZsEKriuXoLxdw64+cFlbHlwS5HKUJzIpecg+HXxoyGsZtEJ
 l8BT5J2UDXOtx+jN2pjMW6ZSXQ3Arw/w2jUZklH8Kt1WjMqriRhFAzoHf6RNftue2S8Z6c9vNT3
 MurJjnKgbO6fkZSdujKePC0mznbztbgXlYpys0xEbheGklBOzZTb/O75WD16J//Xc/CWF8FfrXq
 VqUv3/wJUoSJD+K3dZuWa1l82VnUbdePH9ISDV70KkPTEW6Nta5msHhN1rX45V9mCK0AcbmCphX
 tL2m7jvCf955HCF/Cp3zKczyVqnygTlch0z9rm0X83mBlpBIEWLte6ABk2wVjND3H28amFEPRpa
 92/1Z8RCTzeb00w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: CE410469AF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21100-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,linux-foundation.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com,tencent.com,linux.dev,goodmis.org,efficios.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This patch series attempts to improve write performance with
RWF_DONTCACHE. The main justification and benchmarks for the series are
in patch #2.

This version implements a scheme that Jan Kara and Christoph Hellwig
suggested during review of the earlier series: after a DONTCACHE write,
kick the flusher thread to do an amount of writeback proportional to the
amount written, but don't target any particular inode or pages when
doing writeback.

The second patch in the series has a summary of the benchmark results.
This seems to work as well or better than the earlier approaches.

The benchmarks I used are in the last two patches. I'm not sure if we
want to merge those into the tree as they are (mostly) AI slop. There
is probably a better tool for this out there.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
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
      mm: add NR_DONTCACHE_DIRTY node page counter
      mm: kick writeback flusher for IOCB_DONTCACHE with targeted dirty tracking
      testing: add nfsd-io-bench NFS server benchmark suite
      testing: add dontcache-bench local filesystem benchmark suite

 fs/fs-writeback.c                                  |  60 +++
 include/linux/backing-dev-defs.h                   |   2 +
 include/linux/fs.h                                 |   6 +-
 include/linux/mmzone.h                             |   1 +
 include/trace/events/writeback.h                   |   3 +-
 mm/filemap.c                                       |   6 +-
 mm/page-writeback.c                                |   7 +
 mm/vmstat.c                                        |   1 +
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
 27 files changed, 1989 insertions(+), 6 deletions(-)
---
base-commit: 27d128c1cff64c3b8012cc56dd5a1391bb4f1821
change-id: 20260401-dontcache-5811efd7eaf3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


