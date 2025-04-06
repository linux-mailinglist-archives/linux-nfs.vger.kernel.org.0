Return-Path: <linux-nfs+bounces-11011-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D10AEA7CD69
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Apr 2025 11:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC0E7A6326
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Apr 2025 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298BD1A00ED;
	Sun,  6 Apr 2025 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tT7Dia8L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04748380
	for <linux-nfs@vger.kernel.org>; Sun,  6 Apr 2025 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743930690; cv=none; b=EA91w8TTj1c0CInR4QfvjdEd0gyKfBeT4HvBiJZ81DBcOiBhUsZhwPt9fXpbXeSeKEYpozKXHy/Vthb1VcfaKbio4DmSuVHlJTwt1wRB86bnHWCEqEp8hajaNOR1cyNSKMs9MFitO+rEWHmGVFP/ju08czubjOsCiyereVcDYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743930690; c=relaxed/simple;
	bh=MA4ujoHEv4xRFCcYygkYKGMJBbRQVyuKO3Xk4aYN04U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3ZNhCCPOFVsIZo4/64tV9Hb+I59CHMSdCs6aexHTztv3LdpWjx7xHuyMR+ejr1qIkbtq4bgGryviWbOwAO3M1Neoe4wGiQgiy+js4/STJXC0Yi6jTBG0RjYvJttgOJbm1Cmp8+90VCtV0zZn37TVuh3mL4kfOn32iSv4tPVT8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tT7Dia8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C257BC4CEE3;
	Sun,  6 Apr 2025 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743930689;
	bh=MA4ujoHEv4xRFCcYygkYKGMJBbRQVyuKO3Xk4aYN04U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tT7Dia8LQ/Sk2GJeyONDcUh2vDiIJnS11M21RAzR1tanMyXxJIvTvOhyeeWrGT04L
	 uAIt7AbIBjX1ktAO5BfHeP+tN/16WyPozcacnH8EMAbOxqUyBzvP+0dicMgVD0PmgY
	 kFgU+7Pg807GW5Ml5NyqFdzHwSeQ08jTCSy0+ndJ6ZKl8MOtiw4bTvzYQRId9g42Go
	 ea5hqV+FbkKJzy4XJ7lQSbBgyE+ayG65r+iAX3M73XJQInWquIreNI+rC0xoc9mK4r
	 Hnmm7LFTds8IYZ3Mv8WTI9bg4OdVMGJqJlvScfe4VwcbyECMUzCsqaAQ3CMFyPazFh
	 O+SGP7xcJglig==
From: trondmy@kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv4/pnfs: Layoutreturn on close must handle fatal networking errors
Date: Sun,  6 Apr 2025 11:11:21 +0200
Message-ID: <cdb06dc8d5ab3e65db78a78a9ac5969453efe0b5.1743930506.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743930506.git.trond.myklebust@hammerspace.com>
References: <cover.1743930506.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we have a fatal ENETDOWN or ENETUNREACH error, then the layoutreturn
on close code should also handle that as fatal, and free the layouts.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 5f582713bf05..3554046b5bfc 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1659,8 +1659,16 @@ int pnfs_roc_done(struct rpc_task *task, struct nfs4_layoutreturn_args **argpp,
 		break;
 	case -NFS4ERR_NOMATCHING_LAYOUT:
 		/* Was there an RPC level error? If not, retry */
-		if (task->tk_rpc_status == 0)
+		if (task->tk_rpc_status == 0) {
+			if ((task->tk_rpc_status == -ENETDOWN ||
+			     task->tk_rpc_status == -ENETUNREACH) &&
+			    task->tk_flags & RPC_TASK_NETUNREACH_FATAL) {
+				*ret = 0;
+				(*respp)->lrs_present = 0;
+				retval = -EIO;
+			}
 			break;
+		}
 		/* If the call was not sent, let caller handle it */
 		if (!RPC_WAS_SENT(task))
 			return 0;
-- 
2.49.0


