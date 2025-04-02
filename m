Return-Path: <linux-nfs+bounces-10989-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F24FEA790B0
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 16:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53A416781F
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 14:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E61038DE1;
	Wed,  2 Apr 2025 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CSsOhzQl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE916F30F
	for <linux-nfs@vger.kernel.org>; Wed,  2 Apr 2025 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743602821; cv=none; b=ZYmO+wiO7+xG3k8T4wCzkOtvwKhQ9JaW4BnJMfX/GmfgMnWwvr/pEA/gAZtiar85SkqKfDFsxMbGreKr1C56nHE2LAgkLYRTiSLquxLN7c9WSH9KJDdCxBetK60cSzBvud8e+VrDFpstIZ9v1r0JduBJq0sHkfYzRAKeF+ohh6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743602821; c=relaxed/simple;
	bh=dwTkjYqjViihfGTq7cOcxq7GlftA2xvPm82XpD+Z41w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LSIoVK1CuVTGfAUUc6B01FlspFpBbeORZAaEGmSL27pCW2vcB7xk6QuedfXpY/3qvp1G7mjoSSgp9nq0K07318StSiBn+EZ5rp7gRmecfTqeSm7whb2ogNh6XzsqNEz65dKUZS4IGEaSclKxHIW8ZuukmoZeQttjY+VAFcSQ9fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CSsOhzQl; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743602816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=36VSrXrPsWrJgXejEw3hgPShvE9KNgtMK5/QdvgPX64=;
	b=CSsOhzQlQg0rJb7jlFlVb8KnE2eD89u+6e1zCrA4VLo7MHPM/okQRAWeklmh92bOQ0IXHL
	hjbfyz60DAOMNpZAbXTuOgKHWo7lwtDoma19keKvU+PJVzhKCf4rUCa+R0PZ7/2aFfybkc
	OZM4KPFKK7/TwSMarNF/ull7HKqZMYA=
From: Guoqing Jiang <guoqing.jiang@linux.dev>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: remove redundant WARN_ON_ONCE in nfsd4_write
Date: Wed,  2 Apr 2025 22:06:19 +0800
Message-Id: <20250402140619.16565-1-guoqing.jiang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

It can be removed since svc_fill_write_vector already has the
same WARN_ON_ONCE.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 fs/nfsd/nfs4proc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b397246dae7b..d1be58b557d1 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1228,7 +1228,6 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	write->wr_how_written = write->wr_stable_how;
 
 	nvecs = svc_fill_write_vector(rqstp, &write->wr_payload);
-	WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec));
 
 	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
 				write->wr_offset, rqstp->rq_vec, nvecs, &cnt,
-- 
2.35.3


