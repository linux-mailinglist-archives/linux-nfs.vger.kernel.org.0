Return-Path: <linux-nfs+bounces-4215-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F718912B3F
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 18:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4293D1F2119D
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 16:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218BC15FA7F;
	Fri, 21 Jun 2024 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhK06wZ6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC53757F8
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986961; cv=none; b=AlPlhqhelbnnjjJdNoxI9gGi+T+eT7wE1El/TWT+QFPcyEzoaNlZa+wb1F/zh9ZC8QVabLSutHWpUBQLL1oUvF9UCbYmy5zu9IyplFk5qb9wWm5HCor+ctpW90t9moBL/MDgegUahEo0n151PRKxEw1QusAJYtuHvwKV5JVsmFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986961; c=relaxed/simple;
	bh=hb+AiKn9+TKWUPKlYqQM8pGzxVIPOzlpRxfwyvoutP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMcq2TQO255mNj3AhKQgqofDt/U6UQopPQMReMfYsOW1NF0ry51RH4HLMMINRl/PruzG7Bg4FDxhH6qNek+bOME+ej/SLg5LUaubsnbpt6PPCf4lQQ6RB41B81fGYCx9gM33YOtFE2numnGnASwAaksj5MZXpci17mMdOX9CuvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhK06wZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25430C2BBFC;
	Fri, 21 Jun 2024 16:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718986960;
	bh=hb+AiKn9+TKWUPKlYqQM8pGzxVIPOzlpRxfwyvoutP8=;
	h=From:To:Cc:Subject:Date:From;
	b=ZhK06wZ6zKT/2aYXYKIJoz9ZxXntU/qR2/Yrex3TPUQsQjd5d4jFuBIiL43ZPp1AS
	 EFQp3TY0AnUGnTEmQfUJ3IbK856yzi8n/v9BTtjXx6azTxUwYs/dmj8yhxAmyhxknd
	 wrCblUJKNCj0wu45xIfQwOwN7Ep8UWy5zLDkfoapHfplZhagm9OLjYwUBOy96sauwZ
	 h3BaZFwS4KuHnBT/SdEv7+jlVm/mUACQKEiNZy+c5RckdMFsyFIbUnSC6c0IgKoeqi
	 5R1PQML10MHAo4v2wQ011tv/TYcJMWRnLXCs2alGhf4tfvIX8gXRKxApmbV8Ts8t1S
	 nkNra13JoEjbA==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/4] Fixes for pNFS SCSI layout PR key registration
Date: Fri, 21 Jun 2024 12:22:28 -0400
Message-ID: <20240621162227.215412-6-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2797; i=chuck.lever@oracle.com; h=from:subject; bh=8ldAjhbTWAEuReLXZIAmlBo1d9BmOkR4OBCYZkutGZQ=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmdajD9GxXo94a0yWCb/c227pcTDqxwMu/SR/ea aeO3bWQ9J6JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZnWowwAKCRAzarMzb2Z/ lzWBD/0RyZZOWaIyStstj8StA6chTfIVVHab+OpaWotsVWJnlluMTsWO4Ma0RgrKJpLD9Z5kcZ+ OccpvWVNgc9xwJqyD3ZuYwmo714VSuzB5YM/Acexe8hoFDo1KEbltQGr7GnJV7CyiisL8m6IYrl hghl40xoY9zl8wYg4coh4ImuAsYP9XunxUb+HlWnGjMR5+3hHhaUVTtDJcQeT3ws7ObKKcBpb/2 wLpzOEM3vR4sXaiHS9QkbfT9BqbGhZbz2H8tUeGhN393YbEQX9Ao1l1oOsu7L89aPrrHUJEudx7 qbNUz62QjVKruJ0VQpYUNqJfq162vdOZDvAb+fi8+LIQR2+N2MZvDLjXt7sjrN4lu/D/Q67Rsae 4llyXEM2lCB5HMRCmHICCzGPCHEkhxFU8+ORa9mszpooPMKJnxa1dNK1HBhG8pUVqOApCgLjR+Q IKMheOcegvYrkhDBzO0FmGywjIVigxr2zrHtKGZYlgn15wssfsJKeCWNLy6HodcRQfyGi1xsmvu KNPUU3uQPJ416saBdGgYfPGOiKauMRB8UFQqpfHfW00DxakbEnAoQx7KiUsbd108WiQfnCJmN9P +8FuknhmZwSOF5xy4zEKe1lr0yIO91T3rF/FEbKT4fy3voJr2aRnWsirE7eVLk0Mo6P/K9MH1oe GNFz9mGp0OZpkaQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The double registration/unregistration I observed was actually the
registration and unregistration of two separate block devices: one
for /media/test and one for /media/scratch. So, that was a false
alarm.

The complete fstests run shows:

Failures: generic/126 generic/355 generic/450 generic/740

unknown: run fstests generic/108 at 2024-06-21 10:13:58
systemd[1]: Started fstests-generic-108.scope - /usr/bin/bash -c test -w /proc/self/oom_score_adj && echo 250 > /proc/self/oom_score_adj; exec ./tests/generic/108.
kernel: sd 6:0:0:1: reservation conflict
kernel: sd 6:0:0:1: [sdb] tag#30 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
kernel: sd 6:0:0:1: [sdb] tag#30 CDB: Read(10) 28 00 00 00 00 00 00 01 00 00
kernel: reservation conflict error, dev sdb, sector 0 op 0x0:(READ) flags 0x0 phys_seg 32 prio class 2
systemd[1]: fstests-generic-108.scope: Deactivated successfully.

These errors appear in the system journal only when the whole
fstests series is run. I can see the "block_rq_complete [-52]" in
the trace log. But the test output shows:

generic/108       [not run] require cel-nfsd:/export/nfs-pnfs-fs-s to be valid block disk

generic/450 is also failing:

generic/450       - output mismatch (see /data/fstests-install/xfstests/results/cel-nfs-pnfs/6.10.0-rc4-gd24c98202dbe/nfs_pnfs/generic/450.out.bad)
    --- tests/generic/450.out	2024-06-20 16:50:06.548035014 -0400
    +++ /data/fstests-install/xfstests/results/cel-nfs-pnfs/6.10.0-rc4-gd24c98202dbe/nfs_pnfs/generic/450.out.bad	2024-06-21 10:44:02.600634341 -0400
    @@ -8,4 +8,6 @@
     direct read the second block contains EOF
     direct read a sector at (after) EOF
     direct read the last sector past EOF
    +expect [2093056,4096,0], got [2093056,4096,4096]
     direct read at far away from EOF
    +expect [104857600,4096,0], got [104857600,4096,4096]
    ...

However this might be a bug that existed before this series.

The other three explicit test failures are usual for NFSv4.1.

---
Changes since RFC:
- series re-ordered to place fixes first
- address review comments as best I can

Chuck Lever (4):
  nfs/blocklayout: Fix premature PR key unregistration
  nfs/blocklayout: Use bulk page allocation APIs
  nfs/blocklayout: Report only when /no/ device is found
  nfs/blocklayout: SCSI layout trace points for reservation key
    reg/unreg

 fs/nfs/blocklayout/blocklayout.c | 13 ++++-
 fs/nfs/blocklayout/blocklayout.h |  8 ++-
 fs/nfs/blocklayout/dev.c         | 72 +++++++++++++++++---------
 fs/nfs/nfs4trace.c               |  7 +++
 fs/nfs/nfs4trace.h               | 88 ++++++++++++++++++++++++++++++++
 fs/nfs/pnfs_dev.c                | 15 +++---
 6 files changed, 166 insertions(+), 37 deletions(-)

-- 
2.45.1


