Return-Path: <linux-nfs+bounces-7724-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E659BF3C4
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 17:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098382829FA
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 16:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCBA205137;
	Wed,  6 Nov 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSiwrZvq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B71A84039
	for <linux-nfs@vger.kernel.org>; Wed,  6 Nov 2024 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912241; cv=none; b=KN3+dDSQw/f+SDLEEfHCweho0gs3QenMvAZ6UstQhsHY8CdmpNUiHVwmXH30jYXCWpajX23ADzdHhq2wx0G1Fn+FrkquCTuyrl21WTpp7+HKCM8nDvBe3JgcV3aaRXeAcu28LNysBQlcO8xxLfdugNYVPII9cIxSPOfOPHjOde0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912241; c=relaxed/simple;
	bh=M8MvDkBriGpXTDGmLKvs2Esr2a0E7M7fIPU7d0np2BM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l80kXZKjdmBeQx6Y1gKR5VjX6DrPS1dSdjfYQGqlDykW22RxccUHxoW5NPuqyu3Bc1wfwaB8e2jFZbY8z9PqrNf+wBuhbNdlEW/LugATwbjaahjKfOdPoGnTjfqdzDkC3bYI+u0Q6oLufbTP6WUpRUfpWZTuT/uSPK/yPkON0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSiwrZvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B67C4CEC6;
	Wed,  6 Nov 2024 16:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730912239;
	bh=M8MvDkBriGpXTDGmLKvs2Esr2a0E7M7fIPU7d0np2BM=;
	h=From:To:Cc:Subject:Date:From;
	b=PSiwrZvq5VllK8ndv9t2+qlVlQv2uzVKuqTqZIjDrGfKypzlw7sKV22IzQ7o/Xyn2
	 u479ULC7ZiLZe3085fAdLGQFaPtceNHZC99jwTYVy/E8aNhXsF6HciOQnpD+tAaHMS
	 FrfTv2W1ygJwwEUyovIZlEpqvlSLA5yHXy27wosHdZzXNpioJA179UYbwP/7OzR9DW
	 9Rz4BUIDLoma+UOcxMthPV7iD98l8h0reQO39eGs0eeAY67qhjMGbovDtP8ft/6hPr
	 pljudss1n73ljJnF3OSwpZe5A31mJ8m+0w1Zf1+zT1SBfztUU3p2Ao2WK46RBxiOH8
	 F7BGe8/DxvpEQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/2] Add a "file_sync" export option
Date: Wed,  6 Nov 2024 11:57:14 -0500
Message-ID: <20241106165716.109681-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

This is a quick-and-dirty prototype of an idea we discussed briefly
during the recent NFS bake-a-thon.

tmpfs exports don't need clients to send a COMMIT because they are
not backed by persistent storage. NFSD can change all NFS WRITE
operations to FILE_SYNC to signal to clients that COMMIT is not
necessary.

The theory behind this is that waiting for the COMMIT adds latency.
Without the COMMIT, applications should observe lower latency on
write(2) and close(2).

We could make this an internal export flag that tmpfs sets, but
there are other cases where a separate COMMIT might not be a benefit
because the underlying storage device is faster than the network.

This patch aims to give administrators the ability to make that call
for a whole export -- tmpfs, RAM disk-backed file systems, and file
systems backed by NVMe might all benefit.

I've tested this patch (with a sibling patch to nfs-utils) and found
that it doesn't make any difference on fast networks. Someone else
might find it helps them, so I'm posting it here for others to try.

Chuck Lever (2):
  NFSD: Return the actual stable_how value to clients
  NFSD: Add a "file_sync" export option

 fs/nfsd/export.c                 |  1 +
 fs/nfsd/nfs3proc.c               |  2 +-
 fs/nfsd/nfs4proc.c               |  3 +-
 fs/nfsd/nfsproc.c                |  3 +-
 fs/nfsd/vfs.c                    | 54 ++++++++++++++++++++++++--------
 fs/nfsd/vfs.h                    |  8 ++---
 fs/nfsd/xdr3.h                   |  2 +-
 include/uapi/linux/nfsd/export.h |  3 +-
 8 files changed, 54 insertions(+), 22 deletions(-)

-- 
2.47.0


