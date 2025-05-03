Return-Path: <linux-nfs+bounces-11391-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A341BAA8136
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 17:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56553B753D
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 15:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ED127978B;
	Sat,  3 May 2025 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBl24mET"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389E4279355;
	Sat,  3 May 2025 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285106; cv=none; b=GmqrU1/GOlUs3mMwIy8njz94nPA2VQ4eKTDmsx1CnyP0+G/G+CsV1mo5K/Ic4fywJFmsobkwZbprmVvbtJih4EvrfGcWSCExeHwbAtT7uezDC7433I1ra7MXawZzc8mGtXHh9JhN+TnK+4yrIWwJDIAzqlUanWPr1sNaQYZiEn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285106; c=relaxed/simple;
	bh=ijYwifvWJEjLfnj0SNILWg8XzNPfY641tVprLnJphLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YKqIQnATMnclN+b2jTWRE0Q6opeJcfPqCUOdi9pwf9MPDecK+Yp9MX5st22e0NjvYaOHZzf9KQ5TOTkNSUSNx3v2Wwn7vgrMW/NrkcWMcqcHqGAMPcFRET01rfjNHPZEu6IlsfmqPYspNYAwpES7YDR+lbZ0gkjbffWXmXyduOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBl24mET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBE5C4CEE7;
	Sat,  3 May 2025 15:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746285105;
	bh=ijYwifvWJEjLfnj0SNILWg8XzNPfY641tVprLnJphLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iBl24mETp2h9J8RUA9WYrY8Simxod++zw3TGB1pLSA2WkhRxHorZs5Pip43i83cLS
	 6AljzkUzK7fcUJr1Wfn+dEipl9tovo6vrORrAuvzvFIG0y8n7NLJhJ7c1MmiI1lqwc
	 c/B0/YJxE++TLEOWVc3NGYJlEmSsa9k4uL5CXEcvBk0kpoLx7PZ4bvmfaDPkHfBClN
	 zs4NdsFv50QlUCUYEsNDMdR+JMGM28AgaFnWfmdTvU7DdpywMRcIU53eeH8sSsmRiw
	 dvYtkjkZNVz9eOLtZ1+/Fan2cJacdUQvhZ0IXQcGlYuY2ahAe+PqJrFWx4jcccOENN
	 cJYG5NsFnnP9g==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 03 May 2025 11:11:17 -0400
Subject: [PATCH v3 01/17] sunrpc: move the SVC_RQST_EVENT_*() macros to
 common header
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-nfsd-tracepoints-v3-1-d89f445969af@kernel.org>
References: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
In-Reply-To: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2813; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ijYwifvWJEjLfnj0SNILWg8XzNPfY641tVprLnJphLs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoFjIsRrOonPSBcO8TNbNTJUXww9VK/ySGJrDbk
 Nv3cJJTzvmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBYyLAAKCRAADmhBGVaC
 FV2jEADCAXvNIFltlOPFv3bRAbA4Qks+xtDrCRK0cfdmecyHiyTZG3ci+Vf8ZMYGyfNXRKnAW96
 0PnIfwLvNAnW+fS7fIzxUPZdZJ0ZTRj1+SP1McvQz5M59Vo6H6W53HY3NFhtkWmOksbGgQYu6HF
 Hq33H1vozLShQdxBE6tCyt2fk5mrLLiD2q3DEENbIxpRchYZ/ZzSeOQrk5nKgfyJKlso7CFt7Xf
 jTjK1o9F3kop32PgdfnuCiF+t9S+pcCyTn6E1C1nmVNDfgd0mssGNORGcDLose6fXU52Zrbzvkb
 +jalQU99gg0x3AleLi1e5zvT++aOu1kJwAlsv9E/LTun9hIqfyikRZtXciZkKTdXFFZrFIKtlfy
 fOIvYHj5zfToI0FlS0ul2DbMEBOGe9MkDdZbl5IYXtQ7WWF6v3sz0Tql19ci1usnNqRbRWMy0cc
 OJSJSy5ANVWBwObMekBQzsMhsCDIss5bllG6Az/6vwhdsrpU16vVBa2a062oDTyS/2vYtImPGXa
 +Cx6Qn/W+fX3zyH/oCibWMPuIBh1v7u2vEtv6tSVftUTLHmMSafFXbg84hZbaa0J50YsM/3yTAG
 1HqLCsBSRjiQwiylQI1NXrzAhzixhloi/+cA1rJEVXt38HPxwB+h3B8bGzTYKOpU5/CSI8TkBAE
 pHi2/LJYpqa15Pg==
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
index 67db3f2953d5d64f2e8e455b218f7f6ecb7753ec..f945721e59e5eed5374bed9a2f70e28b1d2db136 100644
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


