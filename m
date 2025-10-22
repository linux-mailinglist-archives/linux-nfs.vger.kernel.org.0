Return-Path: <linux-nfs+bounces-15532-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 070E7BFE032
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 21:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92E6E4F18D1
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 19:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3FE340A67;
	Wed, 22 Oct 2025 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lm1Qk1gC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E233DEDB
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160937; cv=none; b=rzQYT06BZeL9EsuNc9/mK/l15XxtdvJZzPEb4Hh9MZGca1MednElyLG7I9cDjjMxi/AHDHsDzNJxM29sTNE7+9KiRzmkABPlACAbozKctD14MS7/2hDhiwZi4J1R8MjrxIHcD++E0XxExnDr3h2r9HoqRlESdsOFSw8dNa8QApk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160937; c=relaxed/simple;
	bh=UOnxQPAqQWHICO03USRyLFB/VXkT0HZZ6noC1w4lP2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpgqLjcW2zAD8ANy0s4mIMSGq3vg+TgjmXXEKGtaTM0zB0SCa0iu7nzyf5XTmYEBWatTBL4HB6qQAOE0+hGAoIHH+o4y/CFUUf0ce4sXTYICRLUgkiTzPGSfcsTwGI1rbx8bM3IUWbqOmQKLL2l28+PtnCQFgxsK2+1WiSwv2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lm1Qk1gC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218F4C113D0;
	Wed, 22 Oct 2025 19:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160937;
	bh=UOnxQPAqQWHICO03USRyLFB/VXkT0HZZ6noC1w4lP2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lm1Qk1gCTYDePW0blZMJpoxWpu2jHm8MUQDL/iRnqZIbr1UP8pXjvjR42ch8Fi5tV
	 8tRbgTWJlCAR0L8LEM9a4JrvoG+NMLDHCaAwabZrfyScMCh8xx0FUrQE2G423KreEO
	 q3aH7CPOw2sZrcQd7B4IECWwRgPI5Ac0AEZApGBxZwfRFH4vmhxQI4b512yhCSaQLv
	 +6bzqASxu1b3RaQTImZzse4nxW6vDdDKKd4+B12kRn/WL9FN/Ha6EPKzs/+bp4Inw8
	 keJxkBI6CgX1TBHG3bOtZrMw5rKd/WJevPGwwx4NmQcmjBbmc9EHN4YwK0Ss1D3aqc
	 6KACgdEcu8iZw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v6 1/5] NFSD: Make FILE_SYNC WRITEs comply with spec
Date: Wed, 22 Oct 2025 15:22:04 -0400
Message-ID: <20251022192208.1682-2-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022192208.1682-1-cel@kernel.org>
References: <20251022192208.1682-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Mike noted that when NFSD responds to an NFS_FILE_SYNC WRITE, it
does not also persist file time stamps. To wit, Section 18.32.3
of RFC 8881 mandates:

> The client specifies with the stable parameter the method of how
> the data is to be processed by the server. If stable is
> FILE_SYNC4, the server MUST commit the data written plus all file
> system metadata to stable storage before returning results. This
> corresponds to the NFSv2 protocol semantics. Any other behavior
> constitutes a protocol violation. If stable is DATA_SYNC4, then
> the server MUST commit all of the data to stable storage and
> enough of the metadata to retrieve the data before returning.

For many years, NFSD has used a "data sync only" optimization for
FILE_SYNC WRITEs, in violation of the above text (and previous
incarnations of the NFS standard). File time stamps haven't been
persisted as the mandate above requires.

The purpose of this behavior is that, back in the day, file systems
on rotational media were too slow to handle writes with time stamp
updates. With the advent of UNSTABLE WRITE, the time stamp update is
done by the COMMIT, which amortizes the cost of one time stamp
update over possibly many WRITE requests.

The impact of this change will be felt only when a client explicitly
requests a FILE_SYNC WRITE on a shared file system backed by slow
storage. UNSTABLE and DATA_SYNC WRITEs should not be affected.

Reported-by: Mike Snitzer <snitzer@kernel.org>
Closes: https://lore.kernel.org/linux-nfs/20251018005431.3403-1-cel@kernel.org/T/#t
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f537a7b4ee01..2c5d38f38454 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1315,7 +1315,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = offset;
 	if (stable && !fhp->fh_use_wgather)
-		kiocb.ki_flags |= IOCB_DSYNC;
+		kiocb.ki_flags |=
+			(stable == NFS_FILE_SYNC ? IOCB_SYNC : IOCB_DSYNC);
 
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
 	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
-- 
2.51.0


