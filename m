Return-Path: <linux-nfs+bounces-13011-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52433B034D2
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 05:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1A43B334D
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 03:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CB035280;
	Mon, 14 Jul 2025 03:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/NXKkci"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D81B2E3713
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 03:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752462841; cv=none; b=nVFswaa0GKwqnSYVN2nt87onWDH1wG3GrXXoevn4DuctnLrETzZY2cvX8J6XD1Lc84Kv0rB+Zrxu47uyw2kTa1Lk//MTioZCojrH6eV5FE3JthMkjZKbDFKLk4fDJJ3fsOcI+O1EvowI3OuI614veLjIturfFqlliP3uxDIY4s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752462841; c=relaxed/simple;
	bh=1FM4Y+kFwlAEmtWmigThrM4KvD9uCltsgZu+WgRyjMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+tP7R1jxSrb7RZZhLQLlLH3wGYbo4bpWK6XKO400LwUAWaZnsnQatAW3T26Hee8zfbmTNXdf2RTkIQtOadmLvWxa7vCt+LW+ViVXkZhvUTKWjKCx9zM9dJZySr65yw2SNbtxia1eDiOsnkuzeSXd4JhXCyoBzG9emk7E1kWuQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/NXKkci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DE3C4CEF1;
	Mon, 14 Jul 2025 03:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752462840;
	bh=1FM4Y+kFwlAEmtWmigThrM4KvD9uCltsgZu+WgRyjMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A/NXKkci/A0sxh3eyF2mSBLQ8CbT2DhUHkOzBZX/YGIhKhc1CVSFOjjsRymmbRvsz
	 xCxhH8Rd0mHDei4CI/wXPSjKkx7yQ1WZOKEC0hKAAGOXTMXcADU3pYreR+U99b08xK
	 iTQe4FH7MGOMb2HRmlrv4oFPDk0Hxtbv4JZAfvDqLeGEQf3JNo/I+P20KhBHKljKNd
	 7eNOczrIzPMFd5lhblWI5x22TKH8zkf5crvTNsRzNI0inO6vwVWWPyH8uLLdqLeb0X
	 AoySkXTtn0ha0UOLtvYqXiDew7N5PJ8bfM/77WlZ8i9niiqNpOAvLgSHqgsVA2aDt0
	 8oXBX2zb+2CBw==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>
Cc: linux-nfs@vger.kernel.org
Subject: [for-6.16-final PATCH 0/9] NFSD/NFS/LOCALIO: stable fixes and revert 6.16 LOCALIO changes
Date: Sun, 13 Jul 2025 23:13:50 -0400
Message-ID: <20250714031359.10192-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <aG0pJXVtApZ9C5vy@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Apologies for so many words...]

Hi,

I wanted to get this on all the NFS and NFSD maintainers' radar ASAP.

I realize the timing of this is not great due to how late we are in
the 6.16 release cycle (v6.16-rc7).  But I feel it prudent to make it
clear that the LOCALIO changes that went upstream during the 6.16 merge
window are unstable under load.  So this week we'll need to make a
call on how to handle this for v6.16 final.

And just FYI: I unfortunately don't have time this week to assist with
developing/testing a smaller fix to solve this situation.  The window
for extensive testing (by myself and others at Hammerspace) was late
last week.  At this point, given we are short on time, reverting is
the sane thing to do.

Also, the 6.16-rc7 release's LOCALIO changes put it on something of an
island relative to more enterprise production kernels I am helping to
maintain (both the RHEL10 kernel and Oracle's OCI kernel, which is
actually an Ubuntu kernel, both have NFS LOCALIO that is 6.14 based).

All that said:

The past few weeks I had to assist with an HPC benchmarking effort
that generates heavy load using the "MLperf" benchmark suite. Testing
was done on 10 enterprise grade NVMe storage systems (each with 48
CPUs, and 8 NVMe devices) that depend on LOCALIO to "just work
_well_" to achieve a favorable score.  Unfortunately LOCALIO didn't,
so I got to reverting. I started with this partial revert patch but it
wasn't enough (it just made the problem harder to hit), labeling this
previous revert proposal as "RFC" rather than "URGENT" was a mistake:
https://lore.kernel.org/linux-nfs/aG0pJXVtApZ9C5vy@kernel.org/
(which is very similar to patch 2 in this series)

It wasn't until I did a full revert of 6.16's LOCALIO changes that
LOCALIO stopped having resource leaks (nfsd_file in particular) that
prevented proper NFSD shutdown and the inability to unload nfsd.ko.ko
(which I had to do a lot of while developing other NFS and NFSD
changes that were unrelated to LOCALIO).

Neil, I value the work you did to try to address the lingering
complaints about RCU related compiler errors in LOCALIO (but when you
posted your changes months ago I didn't have time to review, and then
they went upstream; so I assumed they were ready and made sure to
include them in Hammerspace's more recent kernels so that I could gain
"production" confidence in the changes even though I still hadn't had
time to review them properly.. ugh).  Glad "we" did this heavy load
testing because otherwise we'd be oblivious about LOCALIO changes
merged for 6.16 causing regression. (I'm sending this later on my
Sunday evening in the hopes that you being in Australia enables us to
not lose a day of communication on this situation).

Patch 2 gets into how simple it is to trigger the nfsd_file leaks
resulting from running fio followed by NFSD shutdown and nfsd.ko
module removal.

Regards,
Mike

Mike Snitzer (9):
  Revert "NFSD: Clean up kdoc for nfsd_open_local_fh()"
  Revert "nfs_localio: change nfsd_file_put_local() to take a pointer to __rcu pointer"
  Revert "nfs_localio: protect race between nfs_uuid_put() and nfs_close_local_fh()"
  Revert "nfs_localio: duplicate nfs_close_local_fh()"
  Revert "nfs_localio: simplify interface to nfsd for getting nfsd_file"
  Revert "nfs_localio: always hold nfsd net ref with nfsd_file ref"
  Revert "nfs_localio: use cmpxchg() to install new nfs_file_localio"
  nfs/localio: avoid bouncing LOCALIO if nfs_client_is_local()
  nfs/localio: add localio_async_probe modparm

 fs/nfs/localio.c           | 64 ++++++++++++++++--------
 fs/nfs_common/nfslocalio.c | 99 +++++++++++++-------------------------
 fs/nfsd/filecache.c        | 34 ++-----------
 fs/nfsd/filecache.h        |  3 +-
 fs/nfsd/localio.c          | 44 ++---------------
 include/linux/nfslocalio.h | 26 +++++-----
 6 files changed, 100 insertions(+), 170 deletions(-)

-- 
2.44.0


