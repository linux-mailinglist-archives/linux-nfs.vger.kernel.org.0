Return-Path: <linux-nfs+bounces-14105-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE3FB474F1
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 18:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08BC55851F1
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 16:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA3120E03F;
	Sat,  6 Sep 2025 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXD+WWdE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BEB143756
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757177298; cv=none; b=pjU8y6izdexrFtMm2CS+1LsDlqP4rZkXmhffUtglzU4FqUrYjum/J0o7WUzCTt4qWKdQrpOIr18NVOhvjJ3DIqcWACZ1vOHmTF6RgDNjY9ILYP5BtJq3uuOGqgh/r/Bgwg92S2NgFUoH0W87O+byUD/ZCj2v3zWmJ4XXIoA2ef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757177298; c=relaxed/simple;
	bh=56bS2ap0hJvXbN/99ydP9OC4SqQB/mSQtppLSgmKJc8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CN8LaYeFsfDuBDyPBgcXMG6ldrxQAmNCXyEfp1l6dI4NIDb2d1/vUKGDalaS6hhBmtPeiIOFlBhZA6aCtpiB74ksRhDxkDe58OzTV2ou546GSFvbBaaMRoizrEiP8ptwR+gIY+fHFrJezb/4176DDX1PAT4x3Bx/1JkpbpdmRYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXD+WWdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B63DC4CEE7
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757177298;
	bh=56bS2ap0hJvXbN/99ydP9OC4SqQB/mSQtppLSgmKJc8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MXD+WWdE4/eICIzBlspFUjN1DHBxdbUjo8tBRHjZBVG0MovzWDyM8LCp5RPTaRQ0F
	 1uBVHsfwqiF58vCNlQmqnmDccYBfD+qfkDAs5LseTqRBctwBnr5G0n5Ig8raaSK3Fv
	 ZQzfzJUPgLCpyhfoJJs/Iqx9aCKUW3h2NIwT7NsKGj1Lm0mX0T9xnlYB9eZl+I83j5
	 O72xdmzegJ+SI0VeLLHmUI+t6dOaCtrEEtut8cInYdcYNRm9WPp8qWHPjelyTyrgeP
	 hd5qST51UwaAbEd/MhXejsFwYoH0fuvt/LakdPW9bItCmW3oyjlhkFHp1k2mknmJJb
	 FoseSMqgFF+ig==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH v5 0/3] Initial NFS client support for RWF_DONTCACHE
Date: Sat,  6 Sep 2025 12:48:13 -0400
Message-ID: <cover.1757177140.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1755612705.git.trond.myklebust@hammerspace.com>
References: <cover.1755612705.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The main issue is allowing support on 2 stage writes (i.e. unstable
WRITE followed by a COMMIT) since those don't follow the current
assumption that the 'dropbehind' flag can be fulfilled as soon as the
writeback lock is dropped.

v2:
 - Make use of the new iocb parameter for nfs_write_begin()
v3:
 - Set/clear PG_DROPBEHIND on the head of the nfs_page group
 - Simplify helper folio_end_dropbehind
v4:
 - Replace filemap_end_dropbehind_write() with folio_end_dropbehind()
 - Add a helper to replace folio_end_writeback with an equivalent that
   does not attempt to interpret the dropbehind flag
 - Keep the folio dropbehind flag set until the NFS client is ready to
   call folio_end_dropbehind.
 - Don't try to do a read-modify-write in nfs_write_begin() if the folio
   has the dropbehind flag set.
v5:
 - Change helper function export types to EXPORT_SYMBOL_GPL

Trond Myklebust (3):
  filemap: Add a helper for filesystems implementing dropbehind
  filemap: Add a version of folio_end_writeback that ignores dropbehind
  NFS: Enable use of the RWF_DONTCACHE flag on the NFS client

 fs/nfs/file.c           |  9 +++++----
 fs/nfs/nfs4file.c       |  1 +
 fs/nfs/write.c          |  4 +++-
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 34 ++++++++++++++++++++++++++--------
 5 files changed, 37 insertions(+), 13 deletions(-)

-- 
2.51.0


