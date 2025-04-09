Return-Path: <linux-nfs+bounces-11053-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6FFA82804
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 16:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9488C39B5
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 14:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA21267395;
	Wed,  9 Apr 2025 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZWbz/vZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E125D908;
	Wed,  9 Apr 2025 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209184; cv=none; b=Z/PYi28/PPlzZ0OiJ5afY++2cE465mk7jaRzQH2TPsSioAJ1iGd4OHyTlBnVRf2jILWJdv1lWEWsXCEyIp/D3sKEHelSAiZD7TN49IdL9qod/ZNCdBRCTsbcOEEszzsXZ4b8ZAUXSFJYOgKgZzzNxBTgOYtUlUb3eK+DBAwD20A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209184; c=relaxed/simple;
	bh=qtP/lEMbnhd2gkH1zk45qxYiBAB1NtxDuCXd82B7bxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ONA6COg4HWaT8gfGwnOFRAFsknXWAZJL2HlzAG2Nhp250ZI2niE2/PXATzkSJ0wDCQXwsadnaxACBO1XPyoaioxbXQSmkLiS+YqGjGlZbvkY58UgMpqB+o9xbGChR4Ntz51dKRiSHVVng2DaXZiKRCqXi/y2Y9NGflRoVglWPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZWbz/vZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6961FC4CEE7;
	Wed,  9 Apr 2025 14:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209184;
	bh=qtP/lEMbnhd2gkH1zk45qxYiBAB1NtxDuCXd82B7bxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jZWbz/vZywra6n3AcUzJs7WxYaX8LzmOesKs4+9yv6yprTRFvhWVkV7a+BUOCffRZ
	 22qy55tECsohaZEPZS92aXa3eWwYJ5R+0vAKj+Ux3JHj7xySnbc2QGSHoPd3pmvnWa
	 eay3hrzmcuhejUs2jo8guc6tkZuuZ0erHXluijh6GRMH7v2bD3M3j/bt0zYR/7jepU
	 5mxkG4KTFDeVLsmKvVo+E0BU2Ry9givWRnpFw50ON/YW6A/yuI0DsBrmMAFm9Lt26+
	 Zfpo3Qb9RvFj8zDxnpS6m/32Ss0cRuxeQMIkPAbSW0WQCwOp21Whoetk4KMQXs4Ho+
	 N1HWwVKF8nvew==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 09 Apr 2025 10:32:25 -0400
Subject: [PATCH v2 03/12] sunrpc: move the SVC_RQST_EVENT_*() macros to
 common header
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-nfsd-tracepoints-v2-3-cf4e084fdd9c@kernel.org>
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
In-Reply-To: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2813; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qtP/lEMbnhd2gkH1zk45qxYiBAB1NtxDuCXd82B7bxQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn9oUaVdt2XMo6bj0z2gY+D/ck5B2tvMQOBF3tu
 vo3xjbiXkOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/aFGgAKCRAADmhBGVaC
 FXKtD/4kVfRm5bYCD1kdZlaLFlvcRPkPldyuqCC73f16ixZt2wwlS1ZnPYsS4k6YIf+tXF2WtCm
 mHvEuENgjwpiizjq8kWg8YibYbb2opui+XFERerxVMKxLFeXJjHfTHVkxmfmh82Piuyd6Os4xu2
 RFH4+XGyr6Vd9D3pjw718KRIpg85sTPj/SVluDyWNkvO+KkPwrIBN4hBo2D1nnXwyboudiGPqWw
 76GsbvM955YSYwjbj7zDXsFvbN2sh1kl3RrM3DH3lejlqjGj74Nru4oDl0uuIna49vW4Av5aysJ
 FUOY3BTkyr3JSWyMr2bWwW7bnXoswfmWfSROTIm8SCgg71obN8DcPmyGVlL7VeXtR2nliD2ImE5
 Aao0J9YuCl/1Lp46LFdqOnLQeV91iA9dm6OQxfMNmPvYmctIaxbi314iTu5Mke+ab87ZbqnYd6M
 AOyeDcRmJlbXDqW6iZMKyO/efPuovIxpav+5V7vjMRZKfmE4Y4+DpV7Zpn0kCBHpbML79P5gmbE
 WaaW7q3j6gDv3Ib6yDY9eKNsxFoz6k4rnL2FWgJnNIOcjTg9WuHbftAtaPyt0FGughBKtxMx2KD
 WFMw4XawzWUAyQ6c2Qd+loykWlsPUSM89w7fwQiFnZMFCXR/8egejxwwro8qCZhRCz3BFtY78YJ
 x9BmW/DxDgairHg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We need this for some of the nfsd tracepoints, so move them to the
common misc/sunrpc.h infrastructure.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/trace/events/sunrpc.h | 23 -----------------------
 include/trace/misc/sunrpc.h   | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index b5a0f0bc1a3b7cfd90ce0181a8a419db810988bb..bd6a1e3631c291c55bde37cb73d2086d9b15c5de 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1716,29 +1716,6 @@ TRACE_DEFINE_ENUM(SVC_COMPLETE);
 		{ SVC_PENDING,	"SVC_PENDING" },	\
 		{ SVC_COMPLETE,	"SVC_COMPLETE" })
 
-#define SVC_RQST_ENDPOINT_FIELDS(r) \
-		__sockaddr(server, (r)->rq_xprt->xpt_locallen) \
-		__sockaddr(client, (r)->rq_xprt->xpt_remotelen) \
-		__field(unsigned int, netns_ino) \
-		__field(u32, xid)
-
-#define SVC_RQST_ENDPOINT_ASSIGNMENTS(r) \
-		do { \
-			struct svc_xprt *xprt = (r)->rq_xprt; \
-			__assign_sockaddr(server, &xprt->xpt_local, \
-					  xprt->xpt_locallen); \
-			__assign_sockaddr(client, &xprt->xpt_remote, \
-					  xprt->xpt_remotelen); \
-			__entry->netns_ino = xprt->xpt_net->ns.inum; \
-			__entry->xid = be32_to_cpu((r)->rq_xid); \
-		} while (0)
-
-#define SVC_RQST_ENDPOINT_FORMAT \
-		"xid=0x%08x server=%pISpc client=%pISpc"
-
-#define SVC_RQST_ENDPOINT_VARARGS \
-		__entry->xid, __get_sockaddr(server), __get_sockaddr(client)
-
 TRACE_EVENT_CONDITION(svc_authenticate,
 	TP_PROTO(
 		const struct svc_rqst *rqst,
diff --git a/include/trace/misc/sunrpc.h b/include/trace/misc/sunrpc.h
index 588557d07ea820116219cf8ac7b049976a7d89b1..c3c8feede26087bad9b4c8dd0019606ee9982259 100644
--- a/include/trace/misc/sunrpc.h
+++ b/include/trace/misc/sunrpc.h
@@ -15,4 +15,27 @@
 #define SUNRPC_TRACE_TASK_SPECIFIER \
 	"task:" SUNRPC_TRACE_PID_SPECIFIER "@" SUNRPC_TRACE_CLID_SPECIFIER
 
+#define SVC_RQST_ENDPOINT_FIELDS(r) \
+		__sockaddr(server, (r)->rq_xprt->xpt_locallen) \
+		__sockaddr(client, (r)->rq_xprt->xpt_remotelen) \
+		__field(unsigned int, netns_ino) \
+		__field(u32, xid)
+
+#define SVC_RQST_ENDPOINT_ASSIGNMENTS(r) \
+		do { \
+			struct svc_xprt *xprt = (r)->rq_xprt; \
+			__assign_sockaddr(server, &xprt->xpt_local, \
+					  xprt->xpt_locallen); \
+			__assign_sockaddr(client, &xprt->xpt_remote, \
+					  xprt->xpt_remotelen); \
+			__entry->netns_ino = xprt->xpt_net->ns.inum; \
+			__entry->xid = be32_to_cpu((r)->rq_xid); \
+		} while (0)
+
+#define SVC_RQST_ENDPOINT_FORMAT \
+		"xid=0x%08x server=%pISpc client=%pISpc"
+
+#define SVC_RQST_ENDPOINT_VARARGS \
+		__entry->xid, __get_sockaddr(server), __get_sockaddr(client)
+
 #endif /* _TRACE_SUNRPC_BASE_H */

-- 
2.49.0


