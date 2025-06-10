Return-Path: <linux-nfs+bounces-12276-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C46AD3E36
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 18:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4CA9162F9F
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 16:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C0323C4F9;
	Tue, 10 Jun 2025 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLHpvXM+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D5523C4E7
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571514; cv=none; b=ViEeuvm2Myri9ZzaodDP1t3+bg07xGc/blyCYagcItEsbGM0V1bJ2PcLl4F+OdDWchK552snbGThrjjkVATRcszVi1S7vr2hpTqABD1N7sOGo4hYR73tUzJauWwUHgJlwdmBI4bAwqPdQgTww++DJlTYkEBmM4qDRGB4zsVIZeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571514; c=relaxed/simple;
	bh=ixqmKJrGP67tIGIrPodIkJOxLWJDRwz+RPbMS4bVNXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/XBpuVKmXjUxYihLGpuLMtR/ZnITrIO1ND9lIG0KFgxWR/8QICiGZvHd7juxHsZ0rVRc0ySDN25dr4gqaCIVPNHY2Hkes2BDY9XtygVWsnLCk3FGT/5oWTvAB1MoHEAeIrh/sKSwu0tHFu10pqE1ypw49VftYVxaEYjKBd71Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLHpvXM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4676C4CEF0;
	Tue, 10 Jun 2025 16:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749571513;
	bh=ixqmKJrGP67tIGIrPodIkJOxLWJDRwz+RPbMS4bVNXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XLHpvXM+0spFS0lu7dIZ6y5S6Etn/uzsavnm6NR0YpTYWMl3BPguSpbgIDHnPQTOx
	 0oZKhMnWNNhwRQilOpFDLgqlSNf+jb4AR7oIwYlimZpIAtJQCpqJebUMJkhqfVoZ+J
	 Sw/fCnwNzV76sTLh0qKa87YLcr0gPpebx2uYpdFFdlILqN0CHyc0b1gAtYtixHtDnq
	 evJJNsRk/YM6UlyV1n3lMqJPG3JFEoRgr6lBUnYiRsXbgKahtXYGCJMVBO/FJuCG6+
	 LJMfksMV7dQypbNV0BhBNnUvwM/S9cM7Ot4WfxN1Evf4aGhuzUWYEQCz7Uk4saI/l/
	 eVJeYHI2+xLPw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/3] NFSD: Rename a function parameter
Date: Tue, 10 Jun 2025 12:05:07 -0400
Message-ID: <20250610160509.97599-2-cel@kernel.org>
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

Clean up: A function parameter called "rqstp" typically refers to an
object of type "struct svc_rqst", so it's confusing when such an
parameter refers to a different struct type with field names that are
very similar to svc_rqst.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsctl.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3f3e9f6c4250..b9b2189ce880 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1436,7 +1436,7 @@ unsigned int nfsd_net_id;
 
 static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 					    struct netlink_callback *cb,
-					    struct nfsd_genl_rqstp *rqstp)
+					    struct nfsd_genl_rqstp *genl_rqstp)
 {
 	void *hdr;
 	u32 i;
@@ -1446,22 +1446,22 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 	if (!hdr)
 		return -ENOBUFS;
 
-	if (nla_put_be32(skb, NFSD_A_RPC_STATUS_XID, rqstp->rq_xid) ||
-	    nla_put_u32(skb, NFSD_A_RPC_STATUS_FLAGS, rqstp->rq_flags) ||
-	    nla_put_u32(skb, NFSD_A_RPC_STATUS_PROG, rqstp->rq_prog) ||
-	    nla_put_u32(skb, NFSD_A_RPC_STATUS_PROC, rqstp->rq_proc) ||
-	    nla_put_u8(skb, NFSD_A_RPC_STATUS_VERSION, rqstp->rq_vers) ||
+	if (nla_put_be32(skb, NFSD_A_RPC_STATUS_XID, genl_rqstp->rq_xid) ||
+	    nla_put_u32(skb, NFSD_A_RPC_STATUS_FLAGS, genl_rqstp->rq_flags) ||
+	    nla_put_u32(skb, NFSD_A_RPC_STATUS_PROG, genl_rqstp->rq_prog) ||
+	    nla_put_u32(skb, NFSD_A_RPC_STATUS_PROC, genl_rqstp->rq_proc) ||
+	    nla_put_u8(skb, NFSD_A_RPC_STATUS_VERSION, genl_rqstp->rq_vers) ||
 	    nla_put_s64(skb, NFSD_A_RPC_STATUS_SERVICE_TIME,
-			ktime_to_us(rqstp->rq_stime),
+			ktime_to_us(genl_rqstp->rq_stime),
 			NFSD_A_RPC_STATUS_PAD))
 		return -ENOBUFS;
 
-	switch (rqstp->rq_saddr.sa_family) {
+	switch (genl_rqstp->rq_saddr.sa_family) {
 	case AF_INET: {
 		const struct sockaddr_in *s_in, *d_in;
 
-		s_in = (const struct sockaddr_in *)&rqstp->rq_saddr;
-		d_in = (const struct sockaddr_in *)&rqstp->rq_daddr;
+		s_in = (const struct sockaddr_in *)&genl_rqstp->rq_saddr;
+		d_in = (const struct sockaddr_in *)&genl_rqstp->rq_daddr;
 		if (nla_put_in_addr(skb, NFSD_A_RPC_STATUS_SADDR4,
 				    s_in->sin_addr.s_addr) ||
 		    nla_put_in_addr(skb, NFSD_A_RPC_STATUS_DADDR4,
@@ -1476,8 +1476,8 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 	case AF_INET6: {
 		const struct sockaddr_in6 *s_in, *d_in;
 
-		s_in = (const struct sockaddr_in6 *)&rqstp->rq_saddr;
-		d_in = (const struct sockaddr_in6 *)&rqstp->rq_daddr;
+		s_in = (const struct sockaddr_in6 *)&genl_rqstp->rq_saddr;
+		d_in = (const struct sockaddr_in6 *)&genl_rqstp->rq_daddr;
 		if (nla_put_in6_addr(skb, NFSD_A_RPC_STATUS_SADDR6,
 				     &s_in->sin6_addr) ||
 		    nla_put_in6_addr(skb, NFSD_A_RPC_STATUS_DADDR6,
@@ -1491,9 +1491,9 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 	}
 	}
 
-	for (i = 0; i < rqstp->rq_opcnt; i++)
+	for (i = 0; i < genl_rqstp->rq_opcnt; i++)
 		if (nla_put_u32(skb, NFSD_A_RPC_STATUS_COMPOUND_OPS,
-				rqstp->rq_opnum[i]))
+				genl_rqstp->rq_opnum[i]))
 			return -ENOBUFS;
 
 	genlmsg_end(skb, hdr);
-- 
2.49.0


