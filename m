Return-Path: <linux-nfs+bounces-12928-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF9AAFD013
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 18:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7681AA0EFB
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 16:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20E41E412A;
	Tue,  8 Jul 2025 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvOJuL7Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3522E4242
	for <linux-nfs@vger.kernel.org>; Tue,  8 Jul 2025 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990796; cv=none; b=WXhtJmu/Ahguab9rufZJ3Lq5spkBG+w7j2Q5i1fUrK9qZXW6NEyccVVXHAGWzpDr8IWKbk/Iy0DgMfrgeV9mz+dZg9ORRae2187NtDH0DmSmBdeLY8+cHhfogIZPQ8XTanDCAv1ZkGSzSpm8TFvIpOpoUXvDG0p9gzNAaWBntVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990796; c=relaxed/simple;
	bh=/C5AFATkhKLQjaCvYFOvZcaMRX4Z+potuBz06onfoGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wmomg41t+ibfL3B/7jifAGfR5c7UNFbuw2tJ+r8nwR2JlBF/frnk+DqTX9xvIv47yRTOrsDZoHGcYTSmUsB5Oxj3uabyeYHieXV7HMptL+Dnr3JS9uD7FAlJNW73z+RjBnqE0AbCZ6/Dz+RoHT8pyWLkcDHBXgsGWd8JufZXfmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvOJuL7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5496BC4CEED;
	Tue,  8 Jul 2025 16:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990796;
	bh=/C5AFATkhKLQjaCvYFOvZcaMRX4Z+potuBz06onfoGc=;
	h=From:To:Cc:Subject:Date:From;
	b=KvOJuL7YhvkXRt8td+q5en0jtIzQ+498FxbHyViCiSptq/O/eXV1DF/5ogPNzasFN
	 0y3/7UNm7oRHGbUp/vcHeiT/W4Ut0X3KTxuSJwuV1oTTZ2HEox6crI6CELIqWaX7cA
	 sKwU2uJZUJYU58pXHFxS23d9hdwRTLt499I4KZi8Dxt9lz+8juhM+Sn7zxItmkihY6
	 G4xIGTARaF7txg+1Z7u4oJ9vZY/4KfFT5ZCS/dYnBfeUbl0mZDJc98sgFhkfAlK4FX
	 rwQFKHL++ZwvpTmTer1UjU/IuVS3o9wz9GNWXnociX7EydERAN+VCe8/DlyuwPKtjO
	 iOHUGFG7MOseg==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linus-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	snitzer@kernel.org
Subject: [RFC PATCH v2 0/8] NFSD: support DIO
Date: Tue,  8 Jul 2025 12:06:11 -0400
Message-ID: <20250708160619.64800-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The v1 thread had quite a bit of discussion, and here are some
highlights worth reading to provide background:
jeff's summary: https://lore.kernel.org/linux-nfs/b1accdad470f19614f9d3865bb3a4c69958e5800.camel@kernel.org/
performance: https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/

Changes since v1:
- Rebased ontop of Chuck's proposed fh_getattr movement (Chuck, I like
  it so went with it).
- NFSD's expanding of misaligned READ DIO to be DIO-aligned that
  resulted in 'start_extra' blocks being read into associated pages
  caused incorrect data to be returned from NFSD.  This was caught
  using the 'dt' utility.  See patch 8 for more details.
- This v2 patchset has been tested pretty extensively now.

I haven't time to explore Christoph's pagecache idea like I hoped:
https://lore.kernel.org/linux-nfs/aEqEQLumUp8Y7JR5@infradead.org/

Any help with hardening against page cache invalidation problems due
to mixing O_DIRECT and buffered IO appreciated. ;)

Thanks,
Mike

ps. I have a LOCALIO patchset that I'll be posting next that benefits
from this NFSD patchset.

Chuck Lever (2):
  NFSD: Relocate the fh_want_write() and fh_drop_write() helpers
  NFSD: Move the fh_getattr() helper

Mike Snitzer (6):
  NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
  lib/iov_iter: remove piecewise bvec length checking in iov_iter_aligned_bvec
  NFSD: pass nfsd_file to nfsd_iter_read()
  NFSD: add io_cache_read controls to debugfs interface
  NFSD: add io_cache_write controls to debugfs interface
  NFSD: issue READs using O_DIRECT even if IO is misaligned

 fs/nfsd/debugfs.c          |  94 ++++++++++++++++++++++
 fs/nfsd/filecache.c        |  32 ++++++++
 fs/nfsd/filecache.h        |   4 +
 fs/nfsd/nfs4xdr.c          |   8 +-
 fs/nfsd/nfsd.h             |   9 +++
 fs/nfsd/nfsfh.c            |  27 +++++++
 fs/nfsd/nfsfh.h            |  38 +++++++++
 fs/nfsd/trace.h            |  37 +++++++++
 fs/nfsd/vfs.c              | 154 ++++++++++++++++++++++++++++++++++---
 fs/nfsd/vfs.h              |  35 +--------
 include/linux/sunrpc/svc.h |   5 +-
 lib/iov_iter.c             |   5 +-
 12 files changed, 395 insertions(+), 53 deletions(-)

-- 
2.44.0


