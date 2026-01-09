Return-Path: <linux-nfs+bounces-17715-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C18D0C661
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 22:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 797D23010A86
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 21:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0548D31ED61;
	Fri,  9 Jan 2026 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWCRdB+7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EF222AE65
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 21:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767995776; cv=none; b=r9paNC7rZYzpVjvNiKXhdR/vZs6bVg1zFBFoGfb2lg3nwH/qFOQzVhqXlOVvnUp4eBkuB7HJrDkQzqc5r5Fklb0Sygd1UNjvRbnNFpSs8uUXPwHLenPvU7vCVBfV+yGlCkynkvA/sJqZHi67tVMji51+aMUbyky49NL7DV2zjA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767995776; c=relaxed/simple;
	bh=2p+ezHjGlW1vuxiEa4Kdg+bhTSSM2OT6Iub74JaMjLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=McwgaCoCxZC0+kd9vzAjDLgZzF057SGPiwL8tDLqF34pAoKAvaEuhS4MrgeC4UaY0Ou+eUtkE8Cm2PzpIrciuGOKdw/6Ajf2zdxehkBoq/NKtgCsgUj9UnPKpVxz9cEnmTxmLHHHhy786Iqffe7Jmll8J0Fa8ngHB44MperbMow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWCRdB+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A578EC4CEF1;
	Fri,  9 Jan 2026 21:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767995776;
	bh=2p+ezHjGlW1vuxiEa4Kdg+bhTSSM2OT6Iub74JaMjLw=;
	h=From:To:Cc:Subject:Date:From;
	b=fWCRdB+7thipQYjCX5NAl84+cceGsHn+wUVhyywnGgN7gsq7JyQq5HrkVTrnHthV2
	 FRVfhp64tEwul9UO8BCmNcGrp7KZBK6Gk6s40kA/GCVKKKAUb/SKsvB8HzEUZRWkZT
	 CxS5JIQn9Wsx0S5s29UsD//ONAL5a0avx1FnihwAV3qlrv7E/3Do2pIcsN4VMThSiT
	 vHLN0lvqs9vYmkgboIqAODu401e56N5EqgWXKkYvL5ZZsq5I8V5/x6CyYuJrFhyc0f
	 WG5XPFqiYIf6iBhh+u/wUyOMmdKj+VuyadgIfLRuNy9J9mc89HWLF9YJ6e0mK9KSQ4
	 5KCQ23r3mYhxQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v2] NFSD: Add asynchronous write throttling support for UNSTABLE WRITEs
Date: Fri,  9 Jan 2026 16:56:13 -0500
Message-ID: <20260109215613.25250-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

When memory pressure occurs during buffered writes, the traditional
approach is for balance_dirty_pages() to put the writing thread to
sleep until dirty pages are flushed. For NFSD, this means server
threads block waiting for I/O, reducing overall server throughput.

Add asynchronous write throttling for UNSTABLE writes using the
BDP_ASYNC flag to balance_dirty_pages_ratelimited_flags(). NFSD
checks memory pressure before attempting a buffered write. If the
call returns -EAGAIN (indicating memory exhaustion), NFSD returns
NFS4ERR_DELAY (or NFSERR_JUKEBOX for NFSv3) to the client instead
of blocking.

Clients then wait and retry, rather than tying up server memory with
a cached uncommitted write payload.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

Compile tested only.

Changes since RFC v1:
- Remove the experimental debugfs setting
- Enforce throttling specifically only for UNSTABLE WRITEs


diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 168d3ccc8155..c4550105234e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1458,6 +1458,30 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		}
 	}
 
+	/*
+	 * Throttle buffered writes under memory pressure. When dirty
+	 * page limits are exceeded, BDP_ASYNC causes -EAGAIN to be
+	 * returned rather than blocking the thread. This -EAGAIN
+	 * maps to nfserr_jukebox, signaling the client to back off
+	 * and retry rather than tying up a server thread during
+	 * writeback.
+	 *
+	 * NFSv2 writes commit to stable storage before reply; no
+	 * dirty pages accumulate, so throttling is unnecessary.
+	 * FILE_SYNC and DATA_SYNC writes flush immediately and do
+	 * not leave uncommitted dirty pages behind.
+	 * Direct I/O and DONTCACHE bypass the page cache entirely.
+	 */
+	if (rqstp->rq_vers > 2 &&
+	    stable == NFS_UNSTABLE &&
+	    nfsd_io_cache_write == NFSD_IO_BUFFERED) {
+		host_err =
+			balance_dirty_pages_ratelimited_flags(file->f_mapping,
+							      BDP_ASYNC);
+		if (host_err == -EAGAIN)
+			goto out_nfserr;
+	}
+
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
 
 	since = READ_ONCE(file->f_wb_err);
-- 
2.52.0


