Return-Path: <linux-nfs+bounces-16076-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B934FC372D9
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 18:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 636314E6851
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 17:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8173B325707;
	Wed,  5 Nov 2025 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWgnnGyt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDD1235072
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364532; cv=none; b=oTYX/XjPtKw3X5+16vF7EUZRvy2OmWQ8kY6LTCOp1gal0W9Rm1mrJHtutaGMF5QulU/nEae1Q38DxDuQXptmORgEAgotGaaAsfpiM+N+KFR4PYAiKGeAZtToJvRyLeBvzmLneCPpsPLY37XtY32qnv4K4H94SXWMzZzUi48RtEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364532; c=relaxed/simple;
	bh=F7N3S8K/mzHJLmdJL/OgCXL6NFZ6siOv97D4GWdFE4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vug1UdgX7ZLAHnLyQimMP6AzXrn0DbsihlGmBlzeXdrBwRNYIB/mGnqMflb7BnF/Rk5/cyevJVPJW9bz/dZvjX9ppUi3yDT5oejha6kEQ40o4qDXc+KN42Cz+oLEpP+43/V4BnhMeZRqG4EBnoBJKhTq71jHoopO2szzjKL2Blo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWgnnGyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D23DC4CEF5;
	Wed,  5 Nov 2025 17:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762364531;
	bh=F7N3S8K/mzHJLmdJL/OgCXL6NFZ6siOv97D4GWdFE4Y=;
	h=From:To:Cc:Subject:Date:From;
	b=FWgnnGytOEn818BtWX6ZTq9hjnMUwchos6GdeUoRsFBgW6XWxoUVDSXvmIoqCbkmW
	 TcuMcjNwVP8m7qS+yNAcpgGDBX1UxX5goNfNqYGU3Yomhz9tNiiV3EF2LlLQEmPP0J
	 T9EYswO8TqIOL26RiTyoHZaybzAginfQ8kkkz+0cr9AuRNMtAn2UVQmWYt/ycf7lbz
	 42cvozxn/y89wu1bHiV+KtLmLzXtZNeOc4EPobUv9CrQYf8xgJqclhpPeCVqn6Rj0U
	 CnEkgL5TfHO3mEJ2r/OaPAV/Ex08peBybsI2nhQfrrsZB3N7d5uCOqHHSW1NjbLbPV
	 kLVi/OCiaNyig==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 0/3] [PATCH 0/3] NFSD: additional NFSD Direct changes
Date: Wed,  5 Nov 2025 12:42:07 -0500
Message-ID: <20251105174210.54023-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series builds ontop of what has been staged in nfsd-testing for
NFSD Direct.

For now, I elected to use io_cache_write to expose control over
stable_how when NFSD Direct is used, rather than a per-export control
that can work with any NFSD IO mode. It seemed best to approach it
this way until/unless there is a clear associated win.

But the benchmarking of stable_how variants is still pending
(performance cluster that's required to do the benchmarking is tied up
with higher priority work at the moment, so will need to circle back
to that).

Thanks,
Mike

changes in v4:
- set flags_{buffered,direct} in nfsd_write_dio_iters_init()
- moving where flags_{buffered,direct} set exposed that
  nfsd_issue_dio_write should just be folded into nfsd_direct_write
- patch 2 was just rebased on patch 1
- patch 3 is unchanged

Mike Snitzer (3):
  NFSD: avoid DONTCACHE for misaligned ends of misaligned DIO WRITE
  NFSD: add new NFSD_IO_DIRECT variants that may override stable_how
  NFSD: update Documentation/filesystems/nfs/nfsd-io-modes.rst

 .../filesystems/nfs/nfsd-io-modes.rst         |  58 +++++-----
 fs/nfsd/debugfs.c                             |   7 +-
 fs/nfsd/nfsd.h                                |   2 +
 fs/nfsd/vfs.c                                 | 109 ++++++++++--------
 4 files changed, 100 insertions(+), 76 deletions(-)

-- 
2.44.0


