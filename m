Return-Path: <linux-nfs+bounces-10934-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCD2A741BE
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 01:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4313B70AE
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 00:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68A114A639;
	Fri, 28 Mar 2025 00:24:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1F414A4E7
	for <linux-nfs@vger.kernel.org>; Fri, 28 Mar 2025 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743121442; cv=none; b=V/zUGvzUpIZcMUVEnVdLM5nN5mLu3PIU5KXVqFLo51ykhAuovJ15gctApsAkC9OWLNULQ2fqZzhw1vLvC9n/FoB83qts2FGT0KQaskG8e8vIFQwYCa4rLKppx8SkChACMw6Zl24tjLFAbhXLp0ZJWFiw45JHo/yu+s1ryGEeUV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743121442; c=relaxed/simple;
	bh=cCIjdBaF9xsy5BcIk+fdmpzG5/+RtMFz4l+gs6ZIRiM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=Be1wM5ap5LZEdVKuYYQp3aD6/QbrQoIUgT+DWQZXSwKHifKqc8Uyhi7tOtZfATegerjXm0bjdpy9W4VSyQTlUDnBEhzUn/KPFdxVNBFcc1EEka7MDuLMN9+JsDeaaNng7Di4TWJJIe4i8hCHIE2VFTpYvWjarFZwgRzsHuRPNes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1txxEV-001r38-O8;
	Fri, 28 Mar 2025 00:05:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject:
 [PATCH] nfsd: nfsd4_spo_must_allow() must check this is a v4 compound request
Date: Fri, 28 Mar 2025 11:05:59 +1100
Message-id: <174312035952.9342.9287917468081272195@noble.neil.brown.name>


If the request being processed is not a v4 compound request, then
examining the cstate can have undefined results.

This patch adds a check that the rpc procedure being execute
(rq_procinfo) is the NFSPROC4_COMPOUND procedure.

Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5860f3825be2..7295776b4ccb 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3768,7 +3768,8 @@ bool nfsd4_spo_must_allow(struct svc_rqst *rqstp)
 	struct nfs4_op_map *allow = &cstate->clp->cl_spo_must_allow;
 	u32 opiter;
 
-	if (!cstate->minorversion)
+	if (rqstp->rq_procinfo != &nfsd_version4.vs_proc[NFSPROC4_COMPOUND] ||
+	    cstate->minorversion == 0)
 		return false;
 
 	if (cstate->spo_must_allowed)
-- 
2.48.1


