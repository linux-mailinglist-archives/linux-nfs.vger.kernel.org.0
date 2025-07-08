Return-Path: <linux-nfs+bounces-12937-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28043AFD079
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 18:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074041885DB6
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 16:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EC22E3AE6;
	Tue,  8 Jul 2025 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcwBrfE5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBCC2E266B
	for <linux-nfs@vger.kernel.org>; Tue,  8 Jul 2025 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991668; cv=none; b=bP7ppv988Eju4mAN8W11zp/TXDF5bohl5CRHQDfynbUP7nr7QEYgYpeWNVhNSQTaC6yhc+77uxkqQ0oyN3Y6K9tg9/FwJf1gerUj43Twk2PbHCwNJDDK+gHkoT874MnP9KHuinpnv8zb1Ra56dxKJwW4njn66Kay42oLBPuKNHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991668; c=relaxed/simple;
	bh=RswZhALhFqeW0crUIdbHyFrkqMzxaKmEeWHcNg04HbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwxzbD5fowLQFHAcuepEQFXHLIa4wDd40yENNZuN+L6b1ejDt6gmTkCHuZVE6fA17xMmTtoB9fYHD5HYXTacFrVVQ3zkqOo31KAGGdjhiRnNLQqPwVqSQXEhUnahAs32rmlyrNTh9mH4fA/C3qoo1t4eBk9FyKcHyMAGdgHXT4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcwBrfE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBDCC4CEED;
	Tue,  8 Jul 2025 16:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751991668;
	bh=RswZhALhFqeW0crUIdbHyFrkqMzxaKmEeWHcNg04HbA=;
	h=From:To:Cc:Subject:Date:From;
	b=HcwBrfE57W0AVLHn4fQAEC8M3dddR7HYz3CjsZohBFtuL9+Fficp3ESMg/8YGpuyv
	 dtcvXnk60FTwWjfcraCFhuCBMFOtXuPJlgFsAhZBKWDV7ZP/EwpSiRfJuxmDM6qAmF
	 SCzB3ijJDraFT2ckeujbiKGjjnMQe7zCwOI1LB+em14X2Stzv68ug2/Wp9VIINX5tK
	 jg0PT7W35yRg5Tg/bN8Ux+X8gBeyhMu3sy5Y5bgL2iU4QakqvAZ51RJskXKaRrkept
	 r3heqlajZEFr2C4BCNMa0tcB+Xywykmlkm4cGd/vhicGC/ex+6jnTXI2Wu34BexiDZ
	 CpRPfpx/NcsTw==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	snitzer@kernel.org
Subject: [RFC PATCH 0/6] NFS: LOCALIO improvements and support for misaligned O_DIRECT READs
Date: Tue,  8 Jul 2025 12:20:41 -0400
Message-ID: <20250708162047.65017-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset benefits from this NFSD patchset:
https://lore.kernel.org/linux-nfs/20250708160619.64800-1-snitzer@kernel.org/
(particularly due to patch 6 leaning heavily on NFSD's ability to
expand misaligned O_DIRECT READS to be DIO-aligned).

First 3 patches are general LOCALIO improvements.
Patches 4 - 6 added dio_alignment awareness to LOCALIO and make it
possible for LOCALIO to punt IO over to NFSD (via loopback network) so
that it can take advantage of NFSD's io_cache_read=2 to handle
misaligned O_DIRECT READs so that they are issued as DIO-aligned.

Thanks,
Mike

Mike Snitzer (6):
  nfs/localio: avoid bouncing LOCALIO if nfs_client_is_local()
  nfs/localio: add localio_async_probe modparm
  nfs/localio: make trace_nfs_local_open_fh more useful
  nfs/localio: add nfsd_file_dio_alignment
  nfs/localio: refactor iocb initialization
  nfs/localio: fallback to NFSD for misaligned O_DIRECT READs

 fs/nfs/flexfilelayout/flexfilelayout.c |   1 +
 fs/nfs/internal.h                      |   4 +-
 fs/nfs/localio.c                       | 232 ++++++++++++++++---------
 fs/nfs/nfstrace.h                      |   6 +-
 fs/nfs/pagelist.c                      |  15 +-
 fs/nfsd/localio.c                      |  11 ++
 include/linux/nfslocalio.h             |   2 +
 7 files changed, 178 insertions(+), 93 deletions(-)

-- 
2.44.0


