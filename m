Return-Path: <linux-nfs+bounces-13440-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC4CB1BA6B
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 20:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A743D174217
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 18:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE833293C44;
	Tue,  5 Aug 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A270rrSa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8DD25394C
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419469; cv=none; b=aYzLNnMLxobmf1BMPoZgV6YPNqR0pwVt7G0aj254REOjVsxP3+GFcP2ZUSDrfHpYgEnoxyBigAo8Gt7wR7OuivsdQ1oExhV4WMumHa+c49qzLM4j0Us8eQIO048dhhqOEc0HiEV1Vv+4JFKVwWyyySIr12dDt+6jyy2ZkQ/QFlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419469; c=relaxed/simple;
	bh=DmYR5WgjBJMCN0Dccty4nZiAKgd2ZTteLFxIUP2qwow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e742G8ur+BhdChGyAvBR1/7JicBnguXYITSzM2GmcblblCxlQtLDmH/wOa8LuhkQUMbJa1lwUwbNdScDwY3fgqEgaKgh9+Il46u0v3/4PJabkXWlzey9EgWM6q+e8mERzVfo2dZG4z+9gY06pr4WJvVgtCebGcNGqxMJ/Wz+1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A270rrSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB17C4CEF0;
	Tue,  5 Aug 2025 18:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754419469;
	bh=DmYR5WgjBJMCN0Dccty4nZiAKgd2ZTteLFxIUP2qwow=;
	h=From:To:Cc:Subject:Date:From;
	b=A270rrSaOAEsKtQv5Xi9/iZhv+uqmSPLm7U4v/EmEG+Z5LCrrYNd8Lu1fnYVV22SU
	 Z/pR44emdd+yzuc6fU5/y2YqtR0UP2gngqXXdO0gvRk6K5hc5J/OB16dSE2Go9KN7J
	 b2hauL0WiBxva/bdH9lxpHgWXpA+EGizHFE2q0XQM+DTJUjZbLVzZ76ADOGaYZ6Uk6
	 cSWBzx0FliSH1mXWqIbeh/HfkJnAlIqezYquDbgly9P3zNKaPLYNOJdcLR3XsVfA8l
	 PQSOwszdVRsQ3fJ59mMxUa/kivXZU8zimLDoZIgRgtcD2/3NGNyg3+lbWxsT/oVyUi
	 x9uWJ0OBXGmIw==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 0/4] NFSD DIRECT: misaligned READs fixup, add handling for misaligned WRITEs
Date: Tue,  5 Aug 2025 14:44:24 -0400
Message-ID: <20250805184428.5848-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series builds on what has been staged in the nfsd-testing branch.

This code has proven to work well during my testing.  Any suggestions
for further refinement are welcome.

Changes since v3:
- fixed nfsd_vfs_write() so work that only needs to happen once, after
  IO is submitted, isn't performed each iteration of the for loop,
  thanks for catching this Chuck.
- updated NFSD's misaligned READ and WRITE handling to not use
  iov_iter_is_aligned() because it will soon be removed upstream.
  - Chuck, provided both you and Jeff agree with patch 1's incremental
    changes, patch 1 should be folded into what you already have in your
    nfsd-testing branch (more justification in patch 1's header)
- dropped the NFSD misaligned DIO NFS reexport patch in favor of
  adding STATX_DIOALIGN support to NFS (the patch to add support will
  be provided in the next NFS DIRECT v7 patchset that I'll post soon).

Changes since v2:
- fixed patch 2 by moving redundant work out of nfsd_vfs_write()'s for
  loop, thanks to Jeff's review.
- added Jeff's Reviewed-by to patches 1-3.
- Left patch 4 in the series because it is pragmatic, but feel free to
  drop it if you'd prefer to see this cat skinned a different way.

Changes since v1:
- switched to using an EVENT_CLASS to create nfsd_analyze_{read,write}_dio
- added 4th patch, if user configured use of NFSD_IO_DIRECT then NFS
  reexports should use it too (in future, with per-export controls
  we'll have the benefit of finer-grained control; but until then we'd
  do well to offer comprehensive use of NFSD_IO_DIRECT if it enabled).

Thanks,
Mike

Mike Snitzer (4):
  NFSD: avoid using iov_iter_is_aligned() in nfsd_iter_read()
  NFSD: refactor nfsd_read_vector_dio to EVENT_CLASS useful for READ and WRITE
  NFSD: prepare nfsd_vfs_write() to use O_DIRECT on misaligned WRITEs
  NFSD: issue WRITEs using O_DIRECT even if IO is misaligned

 fs/nfsd/trace.h |  52 +++++++++----
 fs/nfsd/vfs.c   | 199 +++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 202 insertions(+), 49 deletions(-)

-- 
2.44.0


