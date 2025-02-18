Return-Path: <linux-nfs+bounces-10168-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D349A3A182
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 16:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7485C3A903D
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 15:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A58D26B968;
	Tue, 18 Feb 2025 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCO6pJCU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5594526AA94
	for <linux-nfs@vger.kernel.org>; Tue, 18 Feb 2025 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893181; cv=none; b=noakCk50U6Ext1wIpT/+udWCUQP79jvEXH4zI9gP0JcJ01B6UlCFeSyQFR3R+27OZtQ2I8V6BUF5voM1atlBoSdPoNPsfsy9iDq66XBNUPqWlBIm7rzDxICXuUgnCyW/Qv+Ja9rUeHLc3kv0upmG0USK0AQ5/OD8wlXtkJxelEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893181; c=relaxed/simple;
	bh=zR3e1AZ47EV9n+kb1sm/DjAaXaFote+LIKmj7S1GaEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZUaEFEhzAi4q3j/qELiwEjEKfvIzOmSCEIE7XWRBOpMuEie1sobKOtSNJJfavM/Ob2yaOkEchFPPjBB2GecUGwbYWL8dGZnaEd/+EURRv95GjrxFymX2iw1Lkqp4+mx15GGwnNQNkYIqd/Y6cZoJaGVBZIrJUnUWvy43J3QDTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCO6pJCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E2EC4CEE2;
	Tue, 18 Feb 2025 15:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893180;
	bh=zR3e1AZ47EV9n+kb1sm/DjAaXaFote+LIKmj7S1GaEg=;
	h=From:To:Cc:Subject:Date:From;
	b=jCO6pJCU3Dcg3vVqv37CFk6PlVZdouMIa0f7QKPhvPka7t3Zgso5Esb18nN484ynJ
	 7CJhtLNE0SLduDl1uNKEj4C4CCE7eQx0h3Lgu22BAQIyrDm46oMDeJwXkpLkEHR3N6
	 umh55stV5JKQYZTu4VzNBo3YxsoYDkN6u4sxVzuGBH9D60MXDBlFkZPIdwMk2y0Xiq
	 1D/XxF56h5+JANVurTjF3BC3/lSq6hAJfyYniCaMvFhxd0bsxHLlkli3vwGy5M45y5
	 WhFBbnK/nPJDWCdM0BNZZ/mRnj6VJi/LW8vycxJJ/AC7o1J7b6gm1vGIjxt4mRmd5N
	 +SveDhtxe0qdA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/7] nfsd: filecache: various fixes
Date: Tue, 18 Feb 2025 10:39:30 -0500
Message-ID: <20250218153937.6125-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Redriving to continue review dialogue:

> following is my attempt to fix up shrinking and gc of the NFSv3 filecache entries.
> There series is against nfsd-next.

https://lore.kernel.org/linux-nfs/20250207051701.3467505-1-neilb@suse.de/


Changes since original posting:
- I've assumed the role of shepherd for this series
- Rebase on the public nfsd-testing branch
- Remove nfsd_file_laundrette() call from nfsd_file_put() earlier in
  the series
- Rework nfsd_file_gc_worker()
- Clarify one or two commit messages

Chuck Lever (1):
  NFSD: Re-organize nfsd_file_gc_worker()

NeilBrown (6):
  nfsd: filecache: remove race handling.
  nfsd: filecache: use nfsd_file_dispose_list() in
    nfsd_file_close_inode_sync()
  nfsd: filecache: use list_lru_walk_node() in nfsd_file_gc()
  nfsd: filecache: introduce NFSD_FILE_RECENT
  nfsd: filecache: don't repeatedly add/remove files on the lru list
  nfsd: filecache: drop the list_lru lock during lock gc scans

 fs/nfsd/filecache.c | 122 ++++++++++++++++++++++++--------------------
 fs/nfsd/filecache.h |   7 +++
 fs/nfsd/trace.h     |   3 ++
 3 files changed, 77 insertions(+), 55 deletions(-)

-- 
2.47.0


