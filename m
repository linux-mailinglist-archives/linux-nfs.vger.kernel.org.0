Return-Path: <linux-nfs+bounces-16012-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD92C321C1
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 17:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224913AF0A3
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 16:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F992335085;
	Tue,  4 Nov 2025 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avwNBveD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A13346BC
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274551; cv=none; b=MPfI5olvIrI0tKqR8k+Coee9plc9THHuf7uYoMFh8lSrxjaoHfrSyaOu1Fr3uGKiqCDRzr4VoaMSWlQNUcT4JYG1FPzOfKPMTx22CR53kLZvKZCejlCZcJYf1QRBZto7+VOQuPGnDbPchuNWQqPZYBDw6/NGEXudRGKQ42+8scU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274551; c=relaxed/simple;
	bh=XGSTngEbP1TMqx4vkarqvvRZkuVhHBKFRvACseXOErM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mlp2K6d+MnM0GLEG2c71mA6hG5llZvx5nbwRlwnpdBuqr2UmL/gpUA2XnlSCOMOyWg/EEu7IraAuSTkAzF6+YeVZTA/3FrzfVYgSzjvochFjWoSnP/4hOn0OrXAy7gHSLRQhkuIDFdWfGdSVpowHE86Q4Z4fx2hVtTq78KmJ5rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avwNBveD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28262C4CEF8;
	Tue,  4 Nov 2025 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762274550;
	bh=XGSTngEbP1TMqx4vkarqvvRZkuVhHBKFRvACseXOErM=;
	h=From:To:Cc:Subject:Date:From;
	b=avwNBveD2fFaobmo5oCxEKusa8PhRAFohQd7xinJme0qYRZNcM7an7cU26625PWEN
	 DR0rDTOamT/vDm/SxUn1EFjfm8XJyrzqWKfNNyORskhYkok0jWBc6W7+AUtckKHuZS
	 RXF4P5LXG7DY9sukJQcxS+nlTyUUGNvxtVtjeKumZ/dytH4zxd8V/kXkgruBxEasKK
	 nyD8MWM4kZD52BbKPA7mQMywbiTe+1pCsow6R+lPKneZ5lxmdoHwDQP/YZDem6CPj5
	 SExduAwWD8NkEqLyhWaM5nchACZEoxo1EMw3Z/mf7X+dIMLwdO5RZBmrwyXPd87/C5
	 CBTT/C2abBXbA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] NFSD: additional NFSD Direct changes
Date: Tue,  4 Nov 2025 11:42:26 -0500
Message-ID: <20251104164229.43259-1-snitzer@kernel.org>
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

Mike Snitzer (3):
  nfsd: avoid using DONTCACHE for misaligned DIO's buffered IO fallback
  NFSD: add new NFSD_IO_DIRECT variants that may override stable_how
  NFSD: update Documentation/filesystems/nfs/nfsd-io-modes.rst

 .../filesystems/nfs/nfsd-io-modes.rst         | 58 ++++++++-------
 fs/nfsd/debugfs.c                             |  7 +-
 fs/nfsd/nfsd.h                                |  2 +
 fs/nfsd/vfs.c                                 | 74 ++++++++++++++-----
 4 files changed, 97 insertions(+), 44 deletions(-)

-- 
2.44.0


