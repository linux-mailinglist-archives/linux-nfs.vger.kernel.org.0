Return-Path: <linux-nfs+bounces-12277-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3D0AD3E39
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 18:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1A63A530E
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E347923A99D;
	Tue, 10 Jun 2025 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUPv4eFO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76523BD09
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571514; cv=none; b=r8WLuXDdQ51dh3QAtjLv1WFeP7Y0E2YavEKiZ7NluGoYfxjPqrijEiOlJVqEyEXHhrmdMgZLPTuPnnAWSDPI/IXGQrrxptA7VT3xMNm8Ap0trWrKCVgmtDKbu8l7f0XqPGujIX8dRD0+vCrjcaJmNOk03WFR6Rgs1GTtZ3iTV18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571514; c=relaxed/simple;
	bh=3rQkglNuhYqaT7SOADJzToohRjN573nD6ImNUp9Pu0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfWCeVkayzkIgiNbD9YchcO94hO3l7Wj6iA1rD90Ahha40vr39i5CwJQ4qTrf0azm/p/BXaAXItKkwT040kDUTXApPHtr4dx+qNf8wQn65hBN5KaB6aaG5UiTovfJFPdBNU8xrqxDJ6rCz65hrKhauduxSCpaqNDWHJntDeSg1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUPv4eFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5F8C4CEF2;
	Tue, 10 Jun 2025 16:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749571514;
	bh=3rQkglNuhYqaT7SOADJzToohRjN573nD6ImNUp9Pu0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JUPv4eFO0AKmXCv4amTMlyWsZ1Sh96FxBqWVqnXQD30u6eMUjDmxo0CMBuZycBIpg
	 2MUC/N1ygCie3CnDFUqHTDqUYuysWHzianXC7ExFupldHtZY7zzVH0vUXKkb3D+TD+
	 Ry2nYpABGXUcpr7lGeAoZkfRD9ENmS1CpZhljDxm2X8BNZtgl611/jA4IpjMvi/v64
	 2t3VT9WJoZCrYaS/tHUj+WJX5w6esXJ90tVlztDcyqDRT2OAcNhkOGCR3ZeJbx422Y
	 rvo1ANE1kkOUR/p2W89V7tNz3643yx+fCMzLN4bRHhs4NYohKOUI70SBizDqnjYN6Q
	 uIXMLXbCrmkVQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 2/3] NFSD: Make nfsd_genl_rqstp::rq_ops array best-effort
Date: Tue, 10 Jun 2025 12:05:08 -0400
Message-ID: <20250610160509.97599-3-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610160509.97599-1-cel@kernel.org>
References: <20250610160509.97599-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

To enable NFSD to handle NFSv4 COMPOUNDs of unrestricted size,
resize the array in struct nfsd_genl_rqstp so it saves only up to
16 operations per COMPOUND.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsctl.c | 3 ++-
 fs/nfsd/nfsd.h   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index b9b2189ce880..1e0ebcc3216c 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1569,7 +1569,8 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 				int j;
 
 				args = rqstp->rq_argp;
-				genl_rqstp.rq_opcnt = args->opcnt;
+				genl_rqstp.rq_opcnt = min_t(u32, args->opcnt,
+							    ARRAY_SIZE(genl_rqstp.rq_opnum));
 				for (j = 0; j < genl_rqstp.rq_opcnt; j++)
 					genl_rqstp.rq_opnum[j] =
 						args->ops[j].opnum;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 1bfd0b4e9af7..570065285e67 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -72,7 +72,7 @@ struct nfsd_genl_rqstp {
 
 	/* NFSv4 compound */
 	u32			rq_opcnt;
-	u32			rq_opnum[NFSD_MAX_OPS_PER_COMPOUND];
+	u32			rq_opnum[16];
 };
 
 extern struct svc_program	nfsd_programs[];
-- 
2.49.0


