Return-Path: <linux-nfs+bounces-15590-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A9EC06C0E
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 16:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873173B361D
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 14:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DD731B838;
	Fri, 24 Oct 2025 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yc/RRmrL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F038C319866
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316994; cv=none; b=pbZ+K8RG+1r4ztWiSmUezQaFS+Ll/2vbIlPBeTDvepY9lbDz4R5zv2o8rqbIP/3SUVTy5ZM7g8V0J3ySxhTXDt9WwI4thIG9ar0haqkwOui6ee/0XgnoijsVadra9th+l7bRO0V9hef3m/P/4DtmsdoEI51uEeLzLGZRhKHijto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316994; c=relaxed/simple;
	bh=C7dEIjITLsj8gNNbqN0StBUxzofsslYUGQbYKTXLXZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grc0omX6aLS8zwRy8pFdBA07R/guPibuUkDPDbdAKtJ9573PAQJU7VpaEHZXDxfR82lY5d8i84kTNxzF6knjseDd5Htj0LVBBSns4ByilUvv4nO4BBdT2/kZJhhZjL6rhfFSxihIPEpa2L60iB1V+DMMqfaRRAFHTZWjT3XmJFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yc/RRmrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1ACC4CEF1;
	Fri, 24 Oct 2025 14:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761316993;
	bh=C7dEIjITLsj8gNNbqN0StBUxzofsslYUGQbYKTXLXZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yc/RRmrLITkt9Jfjb2ox0o5mlo04qmA9mighrrak1Ub5XPb2N88E5TbFkoOcL8mIt
	 c5zYyg1tEbfAOJCS8/Yyg37WMUijBD/FxgRie4+qDMmt6MD2EQpUUy67d00OtNWcs+
	 1EekEE6kTvYYKIIVI7FFp2kts3lOSp36ZYSE5EiJD/GTNEQlmEzvSxrtnOZ9DyGic4
	 5trrvL2GnOug/lu4mF/WapnWgkcxMbLS2t1g5pTDJTT4CnNBpQWZvpieJix823IlGy
	 NuOH3wxqQdzUMiaHO2uZuIBlEjTgc5bXS1HhVa6rMX4dtiiYDizfrTLa5LrdIQl8d6
	 4FUH/raeXO25Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v7 06/14] NFSD: Always set IOCB_SYNC in direct write path
Date: Fri, 24 Oct 2025 10:42:58 -0400
Message-ID: <20251024144306.35652-7-cel@kernel.org>
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

The NFS specs mandate that an NFS_FILE_SYNC write means that file
metadata (eg time stamps) are durable before the server sends the
response.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index cd2c99e450fb..74fcb12bf19c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1397,12 +1397,6 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	trace_nfsd_write_direct(rqstp, fhp, in_offset, in_count);
 
-	/*
-	 * Any buffered IO issued here will be misaligned, use
-	 * sync IO to ensure it has completed before returning.
-	 */
-	kiocb->ki_flags |= IOCB_DSYNC;
-
 	*cnt = 0;
 	for (int i = 0; i < n_iters; i++) {
 		if (iter_is_dio_aligned[i])
@@ -1454,6 +1448,17 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
 		kiocb->ki_flags |= IOCB_DONTCACHE;
 
+	/*
+	 * IOCB_SYNC + IOCB_DIRECT requests that iter_write should persist
+	 * both written data and dirty time stamps.
+	 *
+	 * When falling back to buffered I/O or handling the unaligned
+	 * first and last segments, the data and time stamps must be
+	 * durable before nfsd_vfs_write() returns to its caller, matching
+	 * the behavior of direct I/O.
+	 */
+	kiocb->ki_flags |= IOCB_SYNC | IOCB_DSYNC;
+
 	if (nfsd_is_write_dio_possible(kiocb->ki_pos, *cnt, nf, &write_dio))
 		return nfsd_issue_write_dio(rqstp, fhp, nf, nvecs, cnt, kiocb,
 					    &write_dio);
-- 
2.51.0


