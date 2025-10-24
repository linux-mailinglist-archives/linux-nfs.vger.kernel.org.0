Return-Path: <linux-nfs+bounces-15589-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCF6C06BF6
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 16:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF611C07CB3
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 14:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7C2319615;
	Fri, 24 Oct 2025 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er/ZJTWh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4945B31B838
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316993; cv=none; b=WtDvqYyBAJAPhTQKXn7s+BZctp5I3IKuAGqQ2B42W4moxEAvncbzpCXmPp8NrS90EvPtncybWDi4KEk0FujzzNZmpRJJGjtdbNWBPva3yTAaNP+lHpAO+Qj6Kz5MnBO8wL/CzzKy7onPCGowl40xXCD3sozSsl0tcCqsWLUufMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316993; c=relaxed/simple;
	bh=0jjY44/We22WZXhDG2vMBQUsGnwThDwYTKAlzQDKSlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivSQPyFNjziyWPiQkOyW8QWrAxO9lYu0Ga6EqXJD6sP4xDUNLY+m/3MmJ2sKCQxIn51Krfp/9QDhQ8iHT4VAohLgIzGw4JPa4QRc32PhDclzUCT6S2VP3hb111fp0eHNORzoGhDQBZsSoEG2ZosxE3cROPiaAHJLfc6k/Dg2HG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er/ZJTWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4795EC4CEF5;
	Fri, 24 Oct 2025 14:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761316992;
	bh=0jjY44/We22WZXhDG2vMBQUsGnwThDwYTKAlzQDKSlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Er/ZJTWhjg/bc9+xG44GNND7BfFThGdLIvTIXFwiD+oeJLudGuaH1K4NkCx25qmAv
	 0oUhWnlmotIeQ5JS+54QXdQ58U+L51WDUNJlG2ozBrtMcQ4ijvALE5Fv5TrJLewuSw
	 ahbhi2p5aDaWhi378kGzBJWiRPV05FH2J0QqLdF2JAu3KHdgdodd8uk74sWWz5pPgK
	 F8p2dCH4H0RbSjcLyzd+jnIndYJJBPjzT3pk+0drob6cUBWp/qRDjXm6n5+yIbYoPB
	 Nar98TkCmCvUG+MXYAAg3XHkuC4Le1wGe4yCmhXGnhZsyc/Rfq34Y+WWfalM66IObe
	 GMHY3leP0vTxw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v7 05/14] NFSD: @stable for direct writes is always NFS_FILE_SYNC
Date: Fri, 24 Oct 2025 10:42:57 -0400
Message-ID: <20251024144306.35652-6-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024144306.35652-1-cel@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Clean up: The helpers in the nfsd_direct_write() code path don't set
stable_how to anything else but NFS_FILE_SYNC. All data writes in
this code path result in immediately durability.

Instead of passing it through the stack of functions, just set it
after the call is done.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2832a66cda5b..cd2c99e450fb 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1374,9 +1374,10 @@ nfsd_iocb_write(struct file *file, struct bio_vec *bvec, unsigned int nvecs,
 }
 
 static int
-nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
-		     u32 *stable_how, unsigned int nvecs, unsigned long *cnt,
-		     struct kiocb *kiocb, struct nfsd_write_dio *write_dio)
+nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		     struct nfsd_file *nf, unsigned int nvecs,
+		     unsigned long *cnt, struct kiocb *kiocb,
+		     struct nfsd_write_dio *write_dio)
 {
 	struct file *file = nf->nf_file;
 	bool iter_is_dio_aligned[3];
@@ -1399,10 +1400,8 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_fil
 	/*
 	 * Any buffered IO issued here will be misaligned, use
 	 * sync IO to ensure it has completed before returning.
-	 * Also update @stable_how to avoid need for COMMIT.
 	 */
 	kiocb->ki_flags |= IOCB_DSYNC;
-	*stable_how = NFS_FILE_SYNC;
 
 	*cnt = 0;
 	for (int i = 0; i < n_iters; i++) {
@@ -1442,7 +1441,7 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_fil
 
 static noinline_for_stack int
 nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		  struct nfsd_file *nf, u32 *stable_how, unsigned int nvecs,
+		  struct nfsd_file *nf, unsigned int nvecs,
 		  unsigned long *cnt, struct kiocb *kiocb)
 {
 	struct nfsd_write_dio write_dio;
@@ -1456,8 +1455,8 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		kiocb->ki_flags |= IOCB_DONTCACHE;
 
 	if (nfsd_is_write_dio_possible(kiocb->ki_pos, *cnt, nf, &write_dio))
-		return nfsd_issue_write_dio(rqstp, fhp, nf, stable_how, nvecs,
-					    cnt, kiocb, &write_dio);
+		return nfsd_issue_write_dio(rqstp, fhp, nf, nvecs, cnt, kiocb,
+					    &write_dio);
 
 	return nfsd_iocb_write(nf->nf_file, rqstp->rq_bvec, nvecs, cnt, kiocb);
 }
@@ -1539,9 +1538,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	switch (nfsd_io_cache_write) {
 	case NFSD_IO_DIRECT:
-		host_err = nfsd_direct_write(rqstp, fhp, nf, stable_how,
-					     nvecs, cnt, &kiocb);
-		stable = *stable_how;
+		host_err = nfsd_direct_write(rqstp, fhp, nf, nvecs, cnt,
+					     &kiocb);
+		stable = *stable_how = NFS_FILE_SYNC;
 		break;
 	case NFSD_IO_DONTCACHE:
 		if (file->f_op->fop_flags & FOP_DONTCACHE)
-- 
2.51.0


