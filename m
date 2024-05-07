Return-Path: <linux-nfs+bounces-3193-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A26248BE47B
	for <lists+linux-nfs@lfdr.de>; Tue,  7 May 2024 15:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35684288A33
	for <lists+linux-nfs@lfdr.de>; Tue,  7 May 2024 13:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C6415F41D;
	Tue,  7 May 2024 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDVAX2dq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9559815ECDF
	for <linux-nfs@vger.kernel.org>; Tue,  7 May 2024 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089039; cv=none; b=aAH8cKFQA9EGfv1tkGyex0GiwFcnc4MZJ/oVbv+wEIdBcYiwEoQuTJRl7B2RXXWGaZycDJ/waF7zM8/Y25Fc4ZljH43i667zp+6Kbxrkf3Ny80SFBG3qZwEyunX5ETfobJ4loHclo/EaH6UpGeYgEqUUSNzQRmtKJ/lieXdv8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089039; c=relaxed/simple;
	bh=nByYgoBIMycAxa9sC/RgBtxji3TOXppnB1SU7lic2mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TSB+FJ9OLqn2nf6XZECOWyTuVkLGGu1w7enurM1Km8llzCx6h7su1fkqz5V594JXEYMxkb2bUov9RVqJZPHRtzes3EPqklx2dO8uXeBUHFJna/3HrSX8juXEoR8PUWu+ng3hqduLgLAxfYptb9r52ShIzjii+bBFLtg+o9GQ1CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDVAX2dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF50C2BBFC;
	Tue,  7 May 2024 13:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715089038;
	bh=nByYgoBIMycAxa9sC/RgBtxji3TOXppnB1SU7lic2mQ=;
	h=From:To:Cc:Subject:Date:From;
	b=sDVAX2dq2EIGtBZuUUc9dStmLXOvW1eIMkfW40LAChz7Qrq3wuQp+ZgsOyzoVet6U
	 lff7RT+VhPk3XFNBaFEJvWNO2qp/+Tqg1Luqp8aw4Ub06mzfZ0TM3ItyITZG7RYEhN
	 zdolYbno/8DoqrNp1uGOs1QQ2woL5uTzOGGFr4FNAsUri31BYHGTRi3yaJMosRL1uo
	 QlFF+7bBzZeAqk89DjC0aS+gCu5vU46buzgm3Mq/9hninyQE2XqjePlDPRtPGOig/u
	 S5Lyjm+k0m/9IwlICKqbN7lmKT4MXdZjnDW1MsFdzHDPkyjo4DjzH81jQUkThz4Yyk
	 m+U/AvtDHS3Fw==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2] NFSD: Force all NFSv4.2 COPY requests to be synchronous
Date: Tue,  7 May 2024 09:37:14 -0400
Message-ID: <20240507133714.9732-1-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

We've discovered that delivering a CB_OFFLOAD operation can be
unreliable in some pretty unremarkable situations. Examples
include:

 - The server dropped the connection because it lost a forechannel
   NFSv4 request and wishes to force the client to retransmit
 - The GSS sequence number window under-flowed
 - A network partition occurred

When that happens, all pending callback operations, including
CB_OFFLOAD, are lost. NFSD does not retransmit them.

Moreover, the Linux NFS client does not yet support sending an
OFFLOAD_STATUS operation to probe whether an asynchronous COPY
operation has finished. Thus, on Linux NFS clients, when a
CB_OFFLOAD is lost, asynchronous COPY can hang until manually
interrupted.

I've tried a couple of remedies, but so far the side-effects are
worse than the disease and they have had to be reverted. So
temporarily force COPY operations to be synchronous so that the use
of CB_OFFLOAD is avoided entirely. This is a fix that can easily be
backported to LTS kernels. I am working on client patches that
introduce an implementation of OFFLOAD_STATUS.

Note that NFSD arbitrarily limits the size of a copy_file_range
to 4MB to avoid indefinitely blocking an nfsd thread. A short
COPY result is returned in that case, and the client can present
a fresh COPY request for the remainder.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 7 +++++++
 1 file changed, 7 insertions(+)

Changes since v1:
- Clarify that this patch is for backporting, and a longer-term
  fix is in the works for subsequent upstream kernels
- Note that synchronous COPY operations don't indefinitely block
  nfsd threads

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ea3cc3e870a7..46bd20fe5c0f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1807,6 +1807,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd4_copy *async_copy = NULL;
 
+	/*
+	 * Currently, async COPY is not reliable. Force all COPY
+	 * requests to be synchronous to avoid client application
+	 * hangs waiting for COPY completion.
+	 */
+	nfsd4_copy_set_sync(copy, true);
+
 	copy->cp_clp = cstate->clp;
 	if (nfsd4_ssc_is_inter(copy)) {
 		trace_nfsd_copy_inter(copy);

base-commit: 939cb14d51a150e3c12ef7a8ce0ba04ce6131bd2
-- 
2.44.0


