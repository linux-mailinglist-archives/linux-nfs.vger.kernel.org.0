Return-Path: <linux-nfs+bounces-13380-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ADAB18650
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 19:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4BB3A5744
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DE91A23A6;
	Fri,  1 Aug 2025 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEwO1XKE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4646E6F2F2
	for <linux-nfs@vger.kernel.org>; Fri,  1 Aug 2025 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068251; cv=none; b=pBKJ/+cLCDq6H+QSh2wCt6AO31csL9kncO4Si7aqkW648+CEe+rkeZQZjWXbpe8lPbj0fYNms89DthiCnpjVFhrMd2OrvBKieDkvtZBdggSRxnGH2qALZ2vv9Dce4EFXdS2I6ifJjSi/uYpAohjsRfyIp//H6Wto0I+qBh7UJc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068251; c=relaxed/simple;
	bh=bem1kSUz4k+uYf8LZv1o2ZFfhW+CNqe8+P48d8GUzQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q2Xx0Jvj1qYcvtjoRwggqgdQz5b/ozJStvhqudsQbpoH9IoUns/nFo7j5y7uOTpXlCbaT61X2sOGgxnBMCf7rxh0g5rZWvctHBXQUiF/rlnlbQAQy2xeE92i+sP/5DsKKmF4Z4+qV5/AMFYo90dF2qyjjjbnTZuzUfYEs2la724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEwO1XKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AF1C4CEE7;
	Fri,  1 Aug 2025 17:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754068250;
	bh=bem1kSUz4k+uYf8LZv1o2ZFfhW+CNqe8+P48d8GUzQY=;
	h=From:To:Cc:Subject:Date:From;
	b=aEwO1XKETMh2qAsSEtAEIZdMv95mtUIH/0rdMUUsQLnvqBFLDWamIHHVqhQsf86+9
	 i6oFpp6S766Poeuyo6NuvcMUAMFEeVzgnnd0tSfcacJHk++tqNCy9R1SDsm+/fLFC2
	 MwQ9y/tTltAl+HDzCKxW8wFVncIkrgqpgswuTMSoMlHJY9qH+1WpYaiyQac7EWGOHB
	 YIm4EvGXYd+GNMpvfeV+Q5aEdgkfxjq+pQGeJKxFLLkZXwBLZU/ixn/QCcagGWKaIr
	 YEsGDPRJqg7e8NtcyskQRkfxjgaze184TLGzCw+PboYBJkdBlYw0ylRjtKFVbD8y3L
	 cYaNmF9NT/0cg==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v6 0/7] NFS DIRECT: align misaligned DIO for LOCALIO
Date: Fri,  1 Aug 2025 13:10:42 -0400
Message-ID: <20250801171049.94235-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

NFS and LOCALIO in particular benefit from avoiding the page cache for
workloads that have a working set that is significantly larger than
available system memory. Enter: NFS DIRECT, which makes it possible to
always enable LOCALIO to use O_DIRECT even if the IO is not
DIO-aligned.

Changes since v5:
- I split the NFS changes back out for v6 since the NFSD DIRECT
  changes have started to land in nfsd-testing
- With the benefit of having updated the NFSD trace points to use an
  EVENT_CLASS I have now updated NFS's equivalents to also use one.
- Updated patch headers.
- Patches 4 and 5, while not strictly needed, are "nice to have"
  because they evolve the NFS LOCALIO code to a better place.

All review appreciated, thanks.
Mike

Mike Snitzer (7):
  nfs/localio: avoid bouncing LOCALIO if nfs_client_is_local()
  nfs/localio: make trace_nfs_local_open_fh more useful
  nfs/localio: add nfsd_file_dio_alignment
  nfs/localio: refactor iocb initialization
  nfs/localio: fallback to NFSD for misaligned O_DIRECT READs
  nfs/direct: add misaligned READ handling
  nfs/direct: add misaligned WRITE handling

 fs/nfs/direct.c            | 258 ++++++++++++++++++++++++++++++++++---
 fs/nfs/internal.h          |  17 ++-
 fs/nfs/localio.c           | 230 +++++++++++++++++++++------------
 fs/nfs/nfstrace.h          |  64 ++++++++-
 fs/nfs/pagelist.c          |  22 +++-
 fs/nfsd/localio.c          |  11 ++
 include/linux/nfs_page.h   |   1 +
 include/linux/nfslocalio.h |   2 +
 8 files changed, 496 insertions(+), 109 deletions(-)

-- 
2.44.0


