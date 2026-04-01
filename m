Return-Path: <linux-nfs+bounces-20595-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIhpO9htzWnvdQYAu9opvQ
	(envelope-from <linux-nfs+bounces-20595-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 21:11:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9358D37FAFA
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 21:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3EFF30186A0
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2026 19:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F94A33F8C3;
	Wed,  1 Apr 2026 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJ9aigXR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C39C33E374;
	Wed,  1 Apr 2026 19:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070678; cv=none; b=V/Rs5y1F3CHimMY3S0Z1zhz/nwEOmX9bC7pVFHTOR6oYZT5h6eLBeKNewqLnrIxWa2kHFk28t7TYNpOX6rc1DVTslNAtpnh7cL8vyBPDo/UlA5qAPVkoYPx076HWMM6YJrZUq+12uIWUun+64HyTYPmkrKdX44vbbZo7Ie9P76M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070678; c=relaxed/simple;
	bh=W3khz0/FaDX409Tx7kW5G/eq7tLBZqNVTt0R4QEcmc4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ryscpNUR3a8nXbNUeMR6EX70zCdXP4QF/ihPMFlj4RlYdJSUuN1zlwnWGwiI2ZItsqkkpAX5Aep2LKmNZC7AdV+Ks1KgYWLfi22UupuQWdxj96g2va9SmnA2jl4apmhdW+EOYLTrzrhdxA0doiZ9zguLixz7ygN8sBol5FD0wMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJ9aigXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3611DC4CEF7;
	Wed,  1 Apr 2026 19:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775070677;
	bh=W3khz0/FaDX409Tx7kW5G/eq7tLBZqNVTt0R4QEcmc4=;
	h=From:Subject:Date:To:Cc:From;
	b=OJ9aigXRAGsDNqFn8owwPTH2MRIk2E0Odqvpz3JrGPCAsqxuZr7mIDw81EiavEAS1
	 0SBni5EJ8H3RBe3NHbIT9l5agNPnYcT2AleXiaAMRrLj1kfJ0Hc5XggpEmRQMxtiHS
	 GtrT0udiGe7PcmETaij+CRFcKW5wvgdcUefQzGY5pyt/R6tb5yIKUpEk4Kmvy3AVP2
	 h9SEXfTF+b8cGCm10iDYRnOc9B7axg7HhFJiY+Qa4WbVMr5ZR1PQMzHYOyu746zkdO
	 IChVH4yBM49oUyFYQ29DH4JPi02H8wgNHFxVYn6JVrxE61gQI+YMItDqz1TxWcuO8p
	 lbqaA3RLm20bw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/4] mm: improve write performance with RWF_DONTCACHE
Date: Wed, 01 Apr 2026 15:10:57 -0400
Message-Id: <20260401-dontcache-v1-0-1f5746fab47a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwND3ZT8vJLkxOSMVF1TC0PD1LQU89TENGMloPqCotS0zAqwWdGxtbU
 AYtJmkFsAAAA=
X-Change-ID: 20260401-dontcache-5811efd7eaf3
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Snitzer <msnitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3732; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=W3khz0/FaDX409Tx7kW5G/eq7tLBZqNVTt0R4QEcmc4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpzW3OqVuSS1iD8Mwo5RMtTr77fM7U7mAokbsi5
 OgJEe0DwK2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCac1tzgAKCRAADmhBGVaC
 FTC/EACC/RtmsGbID3jfaAwUx2faSaic4UxAkejxoMPme/+/EXKCuFne4g2GircdkYunzZ3Dp84
 FR9CvgXFybwNdt34x7Cb4kZEtr6Mpu8M/FotZSN1ja3LQh4d+svvL4/8WmF+ZfH97oVFmsdl4U8
 ewj6GfMvH+vRgGUWrFnawi/MnbCwZgTEUqqfXAI+jdec1gAdDd0NHrYk/QATNxTElX4T2eQt9Xv
 TXa6JPgNBQhYGMeX8/xFMUWsb4A/NWURIlbnChKL1r371kHRilrzl8ZftksYyFHnon5qlw0Q4rW
 MK9tn1KOxorZIcyvPsPdxhVhksMKA+S0w6x5+GJ/oFEYHGLh6BEbszXGnTHoKsBAMcsDGLS+y0U
 gLuxSRGhV2WI5Cnb10L0eWS9EknpJ8iuruvLSF1kKBhOQI9f4szdiWOfAzaY5gZAGgXHDZ7PBJn
 3CKl42UKOlzm/D4x4Vdb8Qdkw9oatzqA5B0DrnJFlMQL/+uCr6tsfjfNzgH2vBFIR1z9oMJVZtt
 GvYGgUh45wLltmyRmdc5OaInTf68VN7XFJaD1APvPsZyQYN2OpMol8iSCmADt4GJvMAdrc3lZRp
 5M9qEvrkxoUq+fnpZeAOwLgzl0onerUD3FglU769z/BG9su1LIXJhcXii4XsosUWcfYYCGP6qGS
 hmD+5VZP50aQIBg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20595-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9358D37FAFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Jeff Layton (4):
      mm: fix IOCB_DONTCACHE write performance with rate-limited writeback
      mm: add atomic flush guard for IOCB_DONTCACHE writeback
      testing: add nfsd-io-bench NFS server benchmark suite
      testing: add dontcache-bench local filesystem benchmark suite

 include/linux/fs.h                                 |   7 +-
 include/linux/pagemap.h                            |   1 +
 mm/filemap.c                                       |  51 ++
 .../dontcache-bench/fio-jobs/lat-reader.fio        |  12 +
 .../dontcache-bench/fio-jobs/multi-write.fio       |   9 +
 .../dontcache-bench/fio-jobs/noisy-writer.fio      |  12 +
 .../testing/dontcache-bench/fio-jobs/rand-read.fio |  13 +
 .../dontcache-bench/fio-jobs/rand-write.fio        |  13 +
 .../testing/dontcache-bench/fio-jobs/seq-read.fio  |  13 +
 .../testing/dontcache-bench/fio-jobs/seq-write.fio |  13 +
 .../dontcache-bench/scripts/parse-results.sh       | 238 +++++++++
 .../dontcache-bench/scripts/run-benchmarks.sh      | 518 ++++++++++++++++++++
 .../testing/nfsd-io-bench/fio-jobs/lat-reader.fio  |  15 +
 .../testing/nfsd-io-bench/fio-jobs/multi-write.fio |  14 +
 .../nfsd-io-bench/fio-jobs/noisy-writer.fio        |  14 +
 tools/testing/nfsd-io-bench/fio-jobs/rand-read.fio |  15 +
 .../testing/nfsd-io-bench/fio-jobs/rand-write.fio  |  15 +
 tools/testing/nfsd-io-bench/fio-jobs/seq-read.fio  |  14 +
 tools/testing/nfsd-io-bench/fio-jobs/seq-write.fio |  14 +
 .../testing/nfsd-io-bench/scripts/parse-results.sh | 238 +++++++++
 .../nfsd-io-bench/scripts/run-benchmarks.sh        | 543 +++++++++++++++++++++
 .../testing/nfsd-io-bench/scripts/setup-server.sh  |  94 ++++
 22 files changed, 1874 insertions(+), 2 deletions(-)
---
base-commit: 9147566d801602c9e7fc7f85e989735735bf38ba
change-id: 20260401-dontcache-5811efd7eaf3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


