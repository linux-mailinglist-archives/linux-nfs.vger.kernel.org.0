Return-Path: <linux-nfs+bounces-12402-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA56AD7FA7
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 02:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6DA318941BA
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 00:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069DA1A3155;
	Fri, 13 Jun 2025 00:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5saMGnX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5399EEBA
	for <linux-nfs@vger.kernel.org>; Fri, 13 Jun 2025 00:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749775016; cv=none; b=TfpQaDfKnUshcOpxx/zFkfYfwxnMnkofRqhmY/hLjJUTrh9jreMRsjvas4HKWsCS2/Vqs2GNc2CM0JnNk8ZBnqqJwUrblaylk63cdaYc+DDRxA5dSPJruMxTNnPU5IVWBbkVSjNtOV4oFrBPjNUAwMN0jCIS8zXlmCb6zCdmXOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749775016; c=relaxed/simple;
	bh=p03mYlqQKFNEsk1t7tky9RFaLAV2kKVbc3rPwY03AHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7g12RDNKANCN17E4Gm/Dc+8rrwVwQIEa5TJMogwD0YdybE1yVIRWtFH9XmDA7/HOdqSdF2apwUucNY2ViQd9J1jaHeFFVWI1LmIYg/6rPBMxzZQP7Ql61cWfgO6qK6f+nSLf179ZoInNTveEjd3wNKGTT2Zx48uMdUO65GU8Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5saMGnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98594C4CEEA;
	Fri, 13 Jun 2025 00:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749775016;
	bh=p03mYlqQKFNEsk1t7tky9RFaLAV2kKVbc3rPwY03AHE=;
	h=From:To:Cc:Subject:Date:From;
	b=a5saMGnX1zab7csMXz3Z6yXhgSfsP2O4z7qkdi9dLGBRXVhzS8shTiytD+k01mwoR
	 tWhX/o//sARw+Na/Lf3uKadVp1hM9jpOPyPi/YjnxZcpJeKP/NkZ+qo3nlEBw3oZFQ
	 8Q6KfobzhuiBxiTWR1mcUpAjin/HfLvHfwWYm9wigmwDKkQsVCTFUf/YjhmeFxGnO3
	 oiIJUi3i65jnwNQEp8Q/9v8jfPz18eUga6aVdhEmRN/HbkkQMarcp0a15kOXzooqiV
	 lSbrkjMlvLZaNb0u9EGHVRZCvdpnM4R2SulYrCNCm/7pWY0ZHcN/L6yMLFZ0wfiMUF
	 mymvT2dAg+QoA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH] NFSD: Use vfs_iocb_iter_read()
Date: Thu, 12 Jun 2025 20:36:53 -0400
Message-ID: <20250613003653.532114-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Refactor: Enable the use of RWF_ flags to control individual I/O
operations.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index cd689df2ca5d..f20bacd9b224 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1086,10 +1086,18 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 {
 	unsigned long v, total;
 	struct iov_iter iter;
-	loff_t ppos = offset;
+	struct kiocb kiocb;
 	ssize_t host_err;
 	size_t len;
 
+	init_sync_kiocb(&kiocb, file);
+	host_err = kiocb_set_rw_flags(&kiocb, 0, READ);
+	if (host_err) {
+		*count = 0;
+		goto out;
+	}
+	kiocb.ki_pos = offset;
+
 	v = 0;
 	total = *count;
 	while (total) {
@@ -1104,7 +1112,8 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
 	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
-	host_err = vfs_iter_read(file, &iter, &ppos, 0);
+	host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
+out:
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
 
-- 
2.49.0


