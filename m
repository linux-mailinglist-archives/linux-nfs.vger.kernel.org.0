Return-Path: <linux-nfs+bounces-3711-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 982F09062FC
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9889B1C22389
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376AD132123;
	Thu, 13 Jun 2024 04:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA6VltYf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F62A1C5
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252264; cv=none; b=r1QIRNlz/IJTewAs4F5L30jSgwfOUkIygOkMsH1e3SRFI5hDRCzcbsMvHfqLfKaerTRKBBQFHfmS6LeSsNpoUXizc0CCIc7RboAlcaaes59wHt4QKwxFIYdrvR6ctlzyCcD+yLuzzxtWvPtJpmuSX5GOTzzDe8Oc3SMYasvM0k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252264; c=relaxed/simple;
	bh=gTOKXyK0Mh8jlToZGiyHSrwvoFpsRLJlcw3/myGohH8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+XwTDLrNU17vGJJJQJu1VV/i7cNKYojKXBlksG1gaJ0HS8ct23uHbAfmTaRiJQ1PWRePlDwlpDU1Wdz9OrRzBj8yNTRj00bCwxLmzdHlO6H3FlUV/FtUXatCLx+JuKMeiRCwQMiYF27gn4lJuE6JyWgXE8Z5JWxIYmdG4UrgSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iA6VltYf; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b065d12dc6so3206846d6.0
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252261; x=1718857061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVG1hooISUIjolQvzpMxZSslS3Wph3h8y/hMHfcV0Ns=;
        b=iA6VltYfk2Wd0f4kuiGvj7416bKNNR/lSJwsdHorj486FqlBMNgQGfXEvMddwfzQbH
         dRq6KERFpQSr884FqYinRPwP44Bd/EvEbcQodAgNaQj9QtZc+J+PfTYCCqpNHuDV0zry
         8mRH8UO2cLrClbSwE6qr45F2zBbuXAx0gfTLeANcCvjk+AQAg8k9++1+TxGZ0StqldEM
         ++Z/Jyy5x0w9l9CcceU2UeonpWaX68wdkHz5/bkjyY0p3X7OnOb6yMTjJEsSQMy0k3Yy
         cTR6y5w+QGybLpKFrXzVxI72M7ixmtOoZgny+PYWxIatglZFyWZ1QZMjKrWraBRBMjEc
         Fktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252261; x=1718857061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVG1hooISUIjolQvzpMxZSslS3Wph3h8y/hMHfcV0Ns=;
        b=vqI/JNgqvlVML1df2Bj2O3ZXuQ2pAEK3QceYRCDOkP16nbNojZ1kTVn6UCaMgpjAFS
         0HXhNICffpgbAPrN3CuafFLy2Y5cqrx65uWRIo7vXgCIyLBBvbWxMt4vdVu3F0/YUbYV
         JzFfL5/XwuhFqQyayStIZjMFqpD3mBv4GaaTpON/lw03uLj8LVrRR8VstooGBGmgDpBg
         q6Z+zNas/pfkeDtDh4GclFoqblI4tprG7fwSMHO3ReNtbBZ3tP20y/Me3juJqik5eARd
         rgqMHEezcQSsZf/zpUlN60mY5tQus7Rn+ziTXIW4f9foSeic+rl/kzLFlM6pjzPL1wqH
         6HnA==
X-Gm-Message-State: AOJu0YyUMJZcXVGNhgnD/BmLJtdzrILbzkzLGIIZEggWRJDV1swBFF8P
	9Xm1dM/vJ3BnEoeYr48PXs01cZOE4IcWo8BNnd69y9h4R2rf2QulZdKE
X-Google-Smtp-Source: AGHT+IF7PjOKBPRnlYHKc9QQyYK4o7dbSWt4RuI4M8wmZkoXuL1GpG9m1MaYhvhrs6LzbTqFqGXxig==
X-Received: by 2002:a05:6214:2f01:b0:6b0:6c40:ccf0 with SMTP id 6a1803df08f44-6b192028c43mr49259196d6.20.1718252261099;
        Wed, 12 Jun 2024 21:17:41 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.40
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:40 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 02/19] NFSv4: Refactor nfs4_opendata_check_deleg()
Date: Thu, 13 Jun 2024 00:11:19 -0400
Message-ID: <20240613041136.506908-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613041136.506908-2-trond.myklebust@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <20240613041136.506908-2-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

Modify it to no longer depend directly on the struct opendata.
This will enable sharing with WANT_DELEGATION.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 66 +++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d3781ce7e0a5..639f075e01e9 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1954,51 +1954,39 @@ static struct nfs4_state *nfs4_try_open_cached(struct nfs4_opendata *opendata)
 }
 
 static void
-nfs4_opendata_check_deleg(struct nfs4_opendata *data, struct nfs4_state *state)
+nfs4_process_delegation(struct inode *inode, const struct cred *cred,
+			enum open_claim_type4 claim,
+			const struct nfs4_open_delegation *delegation)
 {
-	struct nfs_client *clp = NFS_SERVER(state->inode)->nfs_client;
-	struct nfs_delegation *delegation;
-	int delegation_flags = 0;
-
-	switch (data->o_res.delegation.open_delegation_type) {
+	switch (delegation->open_delegation_type) {
 	case NFS4_OPEN_DELEGATE_READ:
 	case NFS4_OPEN_DELEGATE_WRITE:
 		break;
 	default:
 		return;
-	};
-	rcu_read_lock();
-	delegation = rcu_dereference(NFS_I(state->inode)->delegation);
-	if (delegation)
-		delegation_flags = delegation->flags;
-	rcu_read_unlock();
-	switch (data->o_arg.claim) {
-	default:
-		break;
+	}
+	switch (claim) {
 	case NFS4_OPEN_CLAIM_DELEGATE_CUR:
 	case NFS4_OPEN_CLAIM_DELEG_CUR_FH:
 		pr_err_ratelimited("NFS: Broken NFSv4 server %s is "
 				   "returning a delegation for "
 				   "OPEN(CLAIM_DELEGATE_CUR)\n",
-				   clp->cl_hostname);
-		return;
+				   NFS_SERVER(inode)->nfs_client->cl_hostname);
+		break;
+	case NFS4_OPEN_CLAIM_PREVIOUS:
+		nfs_inode_reclaim_delegation(inode, cred,
+				delegation->type,
+				&delegation->stateid,
+				delegation->pagemod_limit);
+		break;
+	default:
+		nfs_inode_set_delegation(inode, cred,
+				delegation->type,
+				&delegation->stateid,
+				delegation->pagemod_limit);
 	}
-	if ((delegation_flags & 1UL<<NFS_DELEGATION_NEED_RECLAIM) == 0)
-		nfs_inode_set_delegation(state->inode,
-				data->owner->so_cred,
-				data->o_res.delegation.type,
-				&data->o_res.delegation.stateid,
-				data->o_res.delegation.pagemod_limit);
-	else
-		nfs_inode_reclaim_delegation(state->inode,
-				data->owner->so_cred,
-				data->o_res.delegation.type,
-				&data->o_res.delegation.stateid,
-				data->o_res.delegation.pagemod_limit);
-
-	if (data->o_res.delegation.do_recall)
-		nfs_async_inode_return_delegation(state->inode,
-						  &data->o_res.delegation.stateid);
+	if (delegation->do_recall)
+		nfs_async_inode_return_delegation(inode, &delegation->stateid);
 }
 
 /*
@@ -2022,7 +2010,10 @@ _nfs4_opendata_reclaim_to_nfs4_state(struct nfs4_opendata *data)
 	if (ret)
 		return ERR_PTR(ret);
 
-	nfs4_opendata_check_deleg(data, state);
+	nfs4_process_delegation(state->inode,
+				data->owner->so_cred,
+				data->o_arg.claim,
+				&data->o_res.delegation);
 
 	if (!update_open_stateid(state, &data->o_res.stateid,
 				NULL, data->o_arg.fmode))
@@ -2089,8 +2080,11 @@ _nfs4_opendata_to_nfs4_state(struct nfs4_opendata *data)
 	if (IS_ERR(state))
 		goto out;
 
-	if (data->o_res.delegation.type != 0)
-		nfs4_opendata_check_deleg(data, state);
+	nfs4_process_delegation(state->inode,
+				data->owner->so_cred,
+				data->o_arg.claim,
+				&data->o_res.delegation);
+
 	if (!update_open_stateid(state, &data->o_res.stateid,
 				NULL, data->o_arg.fmode)) {
 		nfs4_put_open_state(state);
-- 
2.45.2


