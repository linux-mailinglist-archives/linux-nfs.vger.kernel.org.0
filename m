Return-Path: <linux-nfs+bounces-13060-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B90B04AF0
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 00:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001524A6654
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 22:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE16230BE3;
	Mon, 14 Jul 2025 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQgFjWm/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287895103F
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532938; cv=none; b=e3hSJitAK0Md3ruN3H/jkCFMq5fpPZ2ocSKBADEmJ/gKb2iciDEWO4SbrevwPCX/fnouJ9r9BHSnp6237qFXOyuW/VQK1JpLmQUk+84NdB74FLYqp8fSAJN0NlNZHGDNI6KGBjxF5+kQ2XdsZu1MBTSoWunRXypvia3YEDbTmhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532938; c=relaxed/simple;
	bh=yYaG5qf8cHGz0hFZ2MIz8wpU6QbGwmCqAUQRBvxgm/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6I1r5KI+FXWGaOaetaUndoZtYPCbtLwAQ5mUzVBVCsSLTO4/BERr6vO8hZ4nGgPbr/PSQMdWCZC9Q/rXEzfq1dkC6jpyJ6/T1G813RmBOQTYFW+IMwHzmpKT/d7JAs7I9+ldiApsejuJPLkmNJPsbC4Wc3a/S4EjkL2tcO6wlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQgFjWm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E66C4CEED;
	Mon, 14 Jul 2025 22:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752532937;
	bh=yYaG5qf8cHGz0hFZ2MIz8wpU6QbGwmCqAUQRBvxgm/k=;
	h=From:To:Cc:Subject:Date:From;
	b=gQgFjWm/hpAyrkS1OyOORhdgpKTbVWVVv5HvkQ4fvw/Tq03QaYXvDSQ3X5+0dDHsC
	 d89+wS5DNkd0aENAXkrwkI4JAySEvhG/2NVHR2+sw2mG+va6aNoUxBb5YFmoFVeV4p
	 YaVHwRhBklcvIoz4gwEyr4ZmIzqmI5oHHKj7wm6p2sh7L4ZlegIdpWinjQkl8u88xA
	 IJ9l1lyyopEqlkAe5NZqT1VXSE3ZUdmYer7lvB1ZpXwUzXlMG7aZ1bnBGm41vW4D1V
	 J+uJGOt4Z7zME1QRN9IeWm78wrrFbQu+VlgU7TIS0TEPIB4OpO7J8SVAwQrOEqqbRE
	 ogKjvWjfhA4BQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/5] NFSD: add "NFSD DIRECT" and "NFSD DONTCACHE" IO modes
Date: Mon, 14 Jul 2025 18:42:11 -0400
Message-ID: <20250714224216.14329-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Summary (by Jeff Layton [0]):
"The basic problem is that the pagecache is pretty useless for
satisfying READs from nfsd. Most NFS workloads don't involve I/O to
the same files from multiple clients. The client ends up having most
of the data in its cache already and only very rarely do we need to
revisit the data on the server. 

At the same time, it's really easy to overwhelm the storage with
pagecache writeback with modern memory sizes. Having nfsd bypass the
pagecache altogether is potentially a huge performance win, if it can
be made to work safely."

The performance win associated with using NFSD DIRECT was previously
summarized here:
https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
This picture offers a nice summary of performance gains:
https://original.art/NFSD_direct_vs_buffered_IO.jpg

This v3 series was developed ontop of Chuck's nfsd_testing which has 2
patches that saw fh_getattr() moved, etc (v2 of this series included
those patches but since they got review during v2 and Chuck already
has them staged in nfsd-testing I didn't think it made sense to keep
them included in this v3).

Changes since v2 include:
- explored suggestion to use string based interface (e.g. "direct"
  instead of 3) but debugfs seems to only supports numeric values.
- shifted numeric values for debugfs interface from 0-2 to 1-3 and
  made 0 UNSPECIFIED (which is the default)
- if user specifies io_cache_read or io_cache_write mode other than 1,
  2 or 3 (via debugfs) they will get an error message
- pass a data structure to nfsd_analyze_read_dio rather than so many
  in/out params
- improved comments as requested (e.g. "Must remove first
  start_extra_page from rqstp->rq_bvec" was reworked)
- use memmove instead of opencoded shift in
  nfsd_complete_misaligned_read_dio
- dropped the still very important "lib/iov_iter: remove piecewise
  bvec length checking in iov_iter_aligned_bvec" patch because it
  needs to be handled separately.
- various other changes to improve code

Thanks,
Mike

[0]: https://lore.kernel.org/linux-nfs/b1accdad470f19614f9d3865bb3a4c69958e5800.camel@kernel.org/

Mike Snitzer (5):
  NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
  NFSD: pass nfsd_file to nfsd_iter_read()
  NFSD: add io_cache_read controls to debugfs interface
  NFSD: add io_cache_write controls to debugfs interface
  NFSD: issue READs using O_DIRECT even if IO is misaligned

 fs/nfsd/debugfs.c          | 102 +++++++++++++++++++
 fs/nfsd/filecache.c        |  32 ++++++
 fs/nfsd/filecache.h        |   4 +
 fs/nfsd/nfs4xdr.c          |   8 +-
 fs/nfsd/nfsd.h             |  10 ++
 fs/nfsd/nfsfh.c            |   4 +
 fs/nfsd/trace.h            |  37 +++++++
 fs/nfsd/vfs.c              | 197 ++++++++++++++++++++++++++++++++++---
 fs/nfsd/vfs.h              |   2 +-
 include/linux/sunrpc/svc.h |   5 +-
 10 files changed, 383 insertions(+), 18 deletions(-)

-- 
2.44.0


