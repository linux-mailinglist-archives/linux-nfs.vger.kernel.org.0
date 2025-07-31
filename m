Return-Path: <linux-nfs+bounces-13364-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4652FB17940
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 01:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A9A3B0A8D
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 23:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A0C279DAE;
	Thu, 31 Jul 2025 23:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBETMp+T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D12B153598
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 23:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754003199; cv=none; b=e3zANlgPi4NjJZLkgFUCdV4i4lYKWDP2NGhSezc19vUYOTT2vTR+0Fclge4gbookQfDWKe0buQiiZ6dS82QCQcTOCreIIll4d99GV0yU9G95QYxUpN0P0D3sHrK+AHGF8MpMHd8XnN4HXmvf+K2RsVIvKvjxK5Fr3cE6vWW9BBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754003199; c=relaxed/simple;
	bh=K8bX0udbl6WXWT2tsgZqp+paDYkysvo8YZXWdjZyCzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3CPTkA+gOMnqCWahNv29YVT+pJubZ4vLeaK3bGs79zEycJq4dVNA7XmjK/TuorWWmt2eGmj6Anz8+vtyvfnwiFpoVd08BEhyzQM3XrAVW6tII0GaG8x/aTIc0COG+12kOd8LoZl46G2fKS+5vz+b98VUCCaAklvkblAY9BeOxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBETMp+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A2CC4CEEF;
	Thu, 31 Jul 2025 23:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754003194;
	bh=K8bX0udbl6WXWT2tsgZqp+paDYkysvo8YZXWdjZyCzU=;
	h=From:To:Cc:Subject:Date:From;
	b=fBETMp+Tkrt3a+4KqDS5in3LJwpMf234uZqWmXhaO3kNydslsEl5Ta7QIIK+vIrhs
	 5umE15lCytJHGRNNanktOJMZL51torTuu5d9Iqs/HnVOSQkDsovg9ZHbxRE9IV1MmT
	 uXfrmhACXL17aXEz6bydrmSdwBIhDEhy7pEmNA0alO3SzcqKVwbhZlfJ3qq9TUQfBS
	 TG2VoQE2mpXe1E2+l2EF5kyFkmfBYPki3awn4l8GNL4FMCYRSNfSRMhRLL460G+MmK
	 7khiY3N7J/rgtmjF+KpQwKh0e5vyVK8LeVKXU2gscQIe8JENhZ/WTWvy8pzjFGBeS4
	 ALZiZjlCbVkOg==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/4] NFSD DIRECT: add handling for misaligned WRITEs
Date: Thu, 31 Jul 2025 19:06:29 -0400
Message-ID: <20250731230633.89983-1-snitzer@kernel.org>
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
  NFSD: refactor nfsd_read_vector_dio to EVENT_CLASS useful for READ and WRITE
  NFSD: prepare nfsd_vfs_write() to use O_DIRECT on misaligned WRITEs
  NFSD: issue WRITEs using O_DIRECT even if IO is misaligned
  NFSD: handle unaligned DIO for NFS reexport

 fs/nfs/export.c          |   3 +-
 fs/nfsd/filecache.c      |  11 +++
 fs/nfsd/trace.h          |  52 ++++++++---
 fs/nfsd/vfs.c            | 183 ++++++++++++++++++++++++++++++++-------
 include/linux/exportfs.h |  13 +++
 5 files changed, 217 insertions(+), 45 deletions(-)

-- 
2.44.0


