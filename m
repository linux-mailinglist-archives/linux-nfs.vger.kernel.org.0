Return-Path: <linux-nfs+bounces-7632-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35039BA858
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Nov 2024 22:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FC5281594
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Nov 2024 21:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F7518B467;
	Sun,  3 Nov 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPkEgR8S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F84E189BA3
	for <linux-nfs@vger.kernel.org>; Sun,  3 Nov 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730669864; cv=none; b=Wnz/B0Z4ONBldoh3ko8OJz/mvXaJyZGfa7x1VTMqzT4Of2ochky+GPDWv2xFWa/u8in/xa6WCemefHHGjUpiNv/6NwDqVqfoMH21LvTMdgCQjj4xLrqco+va5Yozsfez7eiIaNujAEaCJ5QJOCaQTl+pLRZWmYp+hOCK8xDjHsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730669864; c=relaxed/simple;
	bh=zuzJU0sc17p7/pyCbRqEwZ+485R79m/ttdQyxYxRyQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZ9/vZ/SQzKzbPxFWMVdHD9tZ5Ame/SQS6t84MjWshjZKc1u0yqfNNTtmU/BTX5Ag3/rrH9vSCe4My2dFT+AiI9M61LpVy04BaQHI0k/gFzNvSWmlAMDxBPzHlUGQM1eN3xHRxVQKViazDIKIAwtpxLH9I/RF40Jw5Nd5OrzVMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPkEgR8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462DDC4CECD;
	Sun,  3 Nov 2024 21:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730669864;
	bh=zuzJU0sc17p7/pyCbRqEwZ+485R79m/ttdQyxYxRyQk=;
	h=From:To:Cc:Subject:Date:From;
	b=KPkEgR8SACb/JWkhmhZrlwJTPieTd59574dRh1Vm3oGrZjU9Sb+1Ah9j1wVh+QnRY
	 cMVr/WG5A6+9FGuKbHcTcs4m63cAyOHeb9zW5t4T7Z+622066lRdwPsDFh/hZvBEKF
	 W3U49MRt9k7bmNXeu4dvX6XbyNcGv+1LiY2xCGZdWdbo1HyW6K5zj13Ejj3n4iWbem
	 Sn155fRv/bNH9+5hXPGNMphu41Dq0FaCQDFLnfoJR7wE8FZVMsGDu8J9LuCs0jn0Ev
	 YCyfwYC/0rthX8alX952XjBOGcswFvl/9LNAOkn3483lGQGcfmbgw3RBPoKGfDUzrn
	 qDXWIovBLtUjQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH] NFSD: Fix READDIR on NFSv3 mounts of ext4 exports
Date: Sun,  3 Nov 2024 16:37:32 -0500
Message-ID: <20241103213731.85803-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2729; i=chuck.lever@oracle.com; h=from:subject; bh=l+FuklmEy0CCyMGRPJJLOZgLE86R8DCUU4m/rhKJP+A=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnJ+0cDyGX5m+d5z/VplEVdkbnm0aA2EFsmPNcz l1qWGHeHbeJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZyftHAAKCRAzarMzb2Z/ l0kBD/oCsPvBvW0E1RWQbUUyjMa6tJdSU4PCP/5y9Dw0EpQBJiSujsm/X7z5iFkYa7t1WHTPMzB NoriWYYWHG5mID9/DyituUJm4oCkiYiOdnGj2x2wXju/WplC1P0UffrRlOCJpEk/nAhIrOTu4MY 9hRCXYoYeVPUEwtAiiNm3Z++GxQ1Cf1WuLW50vBUaFH73xYc1QOARBNj/NIhulg+gsmruiYLfVj VivU1CdEWcwVMPWiDgNxSzu2S4rOL+oJmpW8r75SPOc/MRUbev4TRONKjzkaDeSKP2lyzTPuTxv 90GquPd+2EGNDTpiFegG4PuL9QGZ4C79/mTuyDHlnB4uORTAV/76nwcmzW7afLerWhN+qerXImD MiR/HclegTNuj02W3l8aumt5b/M/ODX29fiOH7t9s8RlmX6drCK79+Ny3bskT+fT3tECVhpOtLN PMKtf/6qH4j93kKPcZmJCCUHewXtoEwPRoWkA+Lc7PaZE+iPgC83ytO++agL3Jv6wH1dhrMFTv7 wyJAeYvUAkEx3lzptxSweP+pOA1kvq6Cmp7zmD519FEX7qVtqYJJReRkyNe2PP2yAHuNT2GoUmG PqdGZ2Xi0cnjgL+wSUwx03uAM73+Thq/zlEKSUZz8XE14f9TTC5B7E7iEcwLsbSU3FdTKQXq+Ez q7LiL1iR9Klok5w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I noticed that recently, simple operations like "make" started
failing on NFSv3 mounts of ext4 exports. Network capture shows that
READDIRPLUS operated correctly but READDIR failed with
NFS3ERR_INVAL. The vfs_llseek() call returned EINVAL when it is
passed a non-zero starting directory cookie.

I bisected to commit c689bdd3bffa ("nfsd: further centralize
protocol version checks.").

Turns out that nfsd3_proc_readdir() does not call fh_verify() before
it calls nfsd_readdir(), so the new fhp->fh_64bit_cookies boolean is
not set properly. This leaves the NFSD_MAY_64BIT_COOKIE unset when
the directory is opened.

For ext4, this causes the wrong "max file size" value to be used
when sanity checking the incoming directory cookie (which is a seek
offset value).

Both NFSv2 and NFSv3 READDIR need to call fh_verify() now to ensure
the new boolean fields are properly initialized.

There is a risk that these procedures might now return a status code
that is not valid (by spec), or that operations that are currently
allowed might no longer be.

Fixes: c689bdd3bffa ("nfsd: further centralize protocol version checks.")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c | 6 ++++++
 fs/nfsd/nfsproc.c  | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index dfcc957e460d..48bcdc96b867 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -592,6 +592,11 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 	resp->cookie_offset = 0;
 	resp->rqstp = rqstp;
 	offset = argp->cookie;
+
+	resp->status = fh_verify(rqstp, &resp->fh, S_IFDIR, NFSD_MAY_NOP);
+	if (resp->status != nfs_ok)
+		goto out;
+
 	resp->status = nfsd_readdir(rqstp, &resp->fh, &offset,
 				    &resp->common, nfs3svc_encode_entry3);
 	memcpy(resp->verf, argp->verf, 8);
@@ -600,6 +605,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 	/* Recycle only pages that were part of the reply */
 	rqstp->rq_next_page = resp->xdr.page_ptr + 1;
 
+out:
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 97aab34593ef..ebe8fd3c9ddd 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -586,11 +586,17 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
 	resp->common.err = nfs_ok;
 	resp->cookie_offset = 0;
 	offset = argp->cookie;
+
+	resp->status = fh_verify(rqstp, &resp->fh, S_IFDIR, NFSD_MAY_NOP);
+	if (resp->status != nfs_ok)
+		goto out;
+
 	resp->status = nfsd_readdir(rqstp, &argp->fh, &offset,
 				    &resp->common, nfssvc_encode_entry);
 	nfssvc_encode_nfscookie(resp, offset);
-
 	fh_put(&argp->fh);
+
+out:
 	return rpc_success;
 }
 
-- 
2.47.0


