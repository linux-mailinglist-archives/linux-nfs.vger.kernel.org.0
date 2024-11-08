Return-Path: <linux-nfs+bounces-7789-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A845F9C275B
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 247E7B23001
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 22:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F691F26ED;
	Fri,  8 Nov 2024 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XenrAWbk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230B21F26DD
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731103988; cv=none; b=dc0wgzu0lIN056l7OuZzgChIs135EKfPxOcA/fVp7P4fFdKXlN/Um9KPWJjjDiw/wIQJrYr1AAtngycG4+cnE891+eJwxzE9vRxNaTplf1cFi3RGffG3d+rz+DO7an4cEFfyn1LtMO7GFn2/esYucMlFZJEnADwozlzSOnH30Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731103988; c=relaxed/simple;
	bh=Xtt7P8/TFaw+mClV10FcQQ/Lr/2pnOW7p0eTzPh9kAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjLiOC/nm7u1B4+badIUElq74XVjjV2dvtr5Er96FEFxCRK43pfc8dF1rVEStgaF35mC10r1IukXgPpQIXkIBf9rCxF0yaABke8qL2Y4Ut1kpGiXUo4BF7DPGGEvkwOS281qo7aZx9SHIW1DFKAvqQCO3FFj1nyRgIyS9//rgz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XenrAWbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA7FC4CED2;
	Fri,  8 Nov 2024 22:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731103987;
	bh=Xtt7P8/TFaw+mClV10FcQQ/Lr/2pnOW7p0eTzPh9kAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XenrAWbkoFrcmcmWzdVv/zUQMgB7BPdP/YhlpOixxrtb5k183UIqftG9HUFTavxqP
	 j31zPKEVuzTkC5g4efgEOMmxVeuy5rq+dH8F0bvIHtsufyhVKazRtrh4OSOgShFSif
	 kBJmbEC8YJaI1Z8TV8B6KFBeAuqOzuvUZYDl+EslHSKEByBTw1wu9r4lCzCf6AEcJF
	 rvtzDziSvCq9SD4Fnnct8RNcjshD+Wht+WFsu88+wiDS1sXVZUzenSyVC95eMXxTHa
	 9PebPC1SZoiw5PuezPyJzhqm3zPR3+h04+YJcjzMPQmZCx1xwSsulgXXkzTLKRJi/Z
	 dl8JVaB7j8FfQ==
From: trondmy@kernel.org
To: Yang Erkun <yangerkun@huawei.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv4.0: Fix a use-after-free problem in the asynchronous open()
Date: Fri,  8 Nov 2024 17:13:05 -0500
Message-ID: <e82e8f89d5449c947c7e81e2bfe9c7c4a980c0d8.1731103952.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <5527548df9be8ce76ed31ad0ea6520908533b4fe.1731103952.git.trond.myklebust@hammerspace.com>
References: <5527548df9be8ce76ed31ad0ea6520908533b4fe.1731103952.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Yang Erkun reports that when two threads are opening files at the same
time, and are forced to abort before a reply is seen, then the call to
nfs_release_seqid() in nfs4_opendata_free() can result in a
use-after-free of the pointer to the defunct rpc task of the other
thread.
The fix is to ensure that if the RPC call is aborted before the call to
nfs_wait_on_sequence() is complete, then we must call nfs_release_seqid()
in nfs4_open_release() before the rpc_task is freed.

Reported-by: Yang Erkun <yangerkun@huawei.com>
Fixes: 24ac23ab88df ("NFSv4: Convert open() into an asynchronous RPC call")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9d40319e063d..405f17e6e0b4 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2603,12 +2603,14 @@ static void nfs4_open_release(void *calldata)
 	struct nfs4_opendata *data = calldata;
 	struct nfs4_state *state = NULL;
 
+	/* In case of error, no cleanup! */
+	if (data->rpc_status != 0 || !data->rpc_done) {
+		nfs_release_seqid(data->o_arg.seqid);
+		goto out_free;
+	}
 	/* If this request hasn't been cancelled, do nothing */
 	if (!data->cancelled)
 		goto out_free;
-	/* In case of error, no cleanup! */
-	if (data->rpc_status != 0 || !data->rpc_done)
-		goto out_free;
 	/* In case we need an open_confirm, no cleanup! */
 	if (data->o_res.rflags & NFS4_OPEN_RESULT_CONFIRM)
 		goto out_free;
-- 
2.47.0


