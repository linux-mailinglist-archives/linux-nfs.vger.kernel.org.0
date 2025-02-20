Return-Path: <linux-nfs+bounces-10217-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAF4A3E21B
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 18:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32DC425380
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 17:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505412135CE;
	Thu, 20 Feb 2025 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0OcLUNk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEAF212B22
	for <linux-nfs@vger.kernel.org>; Thu, 20 Feb 2025 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071527; cv=none; b=FnUQMSMO5Ex/RgNTOKex0kmC01RVjaHdBLV2uqZU9Oo2G4fVPA1nhJiRV0nCqvgYDisbin8/8ago45lW2m8QY5WcOztp9Fb+pHLGbBsHG2kcN0PccYNYUCoCEMeycGCvudYCWqbaa85PoPdB7jZq9M1lr2LMAkEQ4ISuTCQfyk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071527; c=relaxed/simple;
	bh=VpagqmWkewm2vE6JV7/i4AqA2oU/vYJQZThAsTX1zQE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UgJkvUbP/LdrJR+4jBdcQmk223GAwobTCdkP+QVb7q6zQv4oK0M7BBgXwpFr70ZZev10DU3cQ2ONuwmrZG3QDcaboWQb9Rjh7jEsC14L4tToKRnB/Qosx2YV2fl67Vh28pwLEJEm8MsaqbBgFPpA7Zbbt8DILeJjvQjuIsH5hIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0OcLUNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFBAC4CEDD;
	Thu, 20 Feb 2025 17:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740071526;
	bh=VpagqmWkewm2vE6JV7/i4AqA2oU/vYJQZThAsTX1zQE=;
	h=From:To:Subject:Date:From;
	b=K0OcLUNkzoQY1/J7mVa/c7gOcxzmg7UHvrkTTRaIzbYYcFMP9pE2O0Tc6JwPxt4NI
	 2/Zw+kTn3zT45r/rRLz4acBHrJHCFllSLcHNfuQD9EIl0zzBZs8vZ3UJ9kXek1+5P1
	 blhbp0Y1iYmUvFupaCf18kHYvrZAy5I6/wwOpZuTw+UOsWEZHncLE9E3yEkCHjuo1G
	 9mWxiYaHa8gsdFuqmc7eiytsHU5e87W6MVkRQj3WdSihh7pklNG5hjmiHgNqUkeahn
	 +gEzcoWZR41Lb1RY0q4zPpDHnuNYGnYMUVWSC4JaJOorOR+A6BoKJrVAlvzMN1LlJe
	 vNMIzIWFISiHg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: add the ability to enable use of RWF_DONTCACHE for all nfsd IO
Date: Thu, 20 Feb 2025 12:12:05 -0500
Message-ID: <20250220171205.12092-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nfsd 'nfsd_dontcache' modparam so that "Any data read or written
by nfsd will be removed from the page cache upon completion."

nfsd_dontcache is disabled by default.  It may be enabled with:
  echo Y > /sys/module/nfsd/parameters/nfsd_dontcache

FOP_DONTCACHE must be advertised as supported by the underlying
filesystem (e.g. XFS), otherwise if/when 'nfsd_dontcache' is enabled
all IO will fail with -EOPNOTSUPP.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/vfs.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 29cb7b812d71..d7e49004e93d 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -955,6 +955,11 @@ nfsd_open_verified(struct svc_fh *fhp, int may_flags, struct file **filp)
 	return __nfsd_open(fhp, S_IFREG, may_flags, filp);
 }
 
+static bool nfsd_dontcache __read_mostly = false;
+module_param(nfsd_dontcache, bool, 0644);
+MODULE_PARM_DESC(nfsd_dontcache,
+		 "Any data read or written by nfsd will be removed from the page cache upon completion.");
+
 /*
  * Grab and keep cached pages associated with a file in the svc_rqst
  * so that they can be passed to the network sendmsg routines
@@ -1084,6 +1089,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	loff_t ppos = offset;
 	struct page *page;
 	ssize_t host_err;
+	rwf_t flags = 0;
 
 	v = 0;
 	total = *count;
@@ -1097,9 +1103,12 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 	WARN_ON_ONCE(v > ARRAY_SIZE(rqstp->rq_vec));
 
+	if (nfsd_dontcache)
+		flags |= RWF_DONTCACHE;
+
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
 	iov_iter_kvec(&iter, ITER_DEST, rqstp->rq_vec, v, *count);
-	host_err = vfs_iter_read(file, &iter, &ppos, 0);
+	host_err = vfs_iter_read(file, &iter, &ppos, flags);
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
 
@@ -1186,6 +1195,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	if (stable && !fhp->fh_use_wgather)
 		flags |= RWF_SYNC;
 
+	if (nfsd_dontcache)
+		flags |= RWF_DONTCACHE;
+
 	iov_iter_kvec(&iter, ITER_SOURCE, vec, vlen, *cnt);
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
@@ -1237,6 +1249,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
  */
 bool nfsd_read_splice_ok(struct svc_rqst *rqstp)
 {
+	if (nfsd_dontcache) /* force the use of vfs_iter_read for reads */
+		return false;
+
 	switch (svc_auth_flavor(rqstp)) {
 	case RPC_AUTH_GSS_KRB5I:
 	case RPC_AUTH_GSS_KRB5P:
-- 
2.44.0


