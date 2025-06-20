Return-Path: <linux-nfs+bounces-12587-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C0EAE1AC4
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 14:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D7F1BC79B1
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 12:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B33228A71D;
	Fri, 20 Jun 2025 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzTUBPAc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B3128A708;
	Fri, 20 Jun 2025 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421785; cv=none; b=JzZIVcivFKRFq8GgWegXbgCXSa6A4aQLSq00kfM9iqsAcGXjnYz1TxVfxyAFQvbf33Nq73rYgByrzACQnQBle7XxPKQpeHcRWw4tMow5I0cAmbNHgoUI00xgcWTrJpmQ6gy6z+dfASAHhbobSIPw2QydDVLhuxDbmhIYwfYZrzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421785; c=relaxed/simple;
	bh=IF42cJs4MpkxNJaOlRvE38Bf4YnfgCEoIGhaNqdYM1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FTqk/g4eTfO/ItarLg1U8F8lN6lf8pISJQP60IXpKsNlOz6RCmI4j04VLMb0EB3P13LlxzlVR3WFJTK/oRlJwWUCJmXILQFsgiubSjo3qVX68K7M4gg5xiIJgl0OSTa+bQEcAwiEgsN/45lW4+HlJlsj0SUlVaWweT33j/muN0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzTUBPAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280A9C4CEEF;
	Fri, 20 Jun 2025 12:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750421784;
	bh=IF42cJs4MpkxNJaOlRvE38Bf4YnfgCEoIGhaNqdYM1c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lzTUBPAcPmgowy09KaNRfEDWQsZOSfFh3Mx7dxyjaNuDHxQOvRer9+naOTQ+BfrOJ
	 Q+444dxfGkL+XS72mUoP50f3Hbpoa7VaffxID0gQmnCuKvA75XuZtwnw4hUcONSuiv
	 bFq6r9znkcbpNboLxEv3A1lS5yK4tRimoCJIylldgHY55Xnzol7cLOIc4Zgts1lQ7Y
	 X8R6AakrK2Jm+ykIV+s3FUVDNc2nlKVyTJL4NU37jaxFd8yhH5iY7rwvQ2ig2WVeXG
	 KAKqZVPgFEGLSmp3IUNhLfIOq41qTFFryMobiVcGwo5DXGaTCKqFQq4RLLRMqt3iHM
	 Mog/280FIE8vA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 20 Jun 2025 08:16:01 -0400
Subject: [PATCH 1/6] sunrpc: fix handling of unknown auth status codes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-rpc-6-17-v1-1-a309177d713b@kernel.org>
References: <20250620-rpc-6-17-v1-0-a309177d713b@kernel.org>
In-Reply-To: <20250620-rpc-6-17-v1-0-a309177d713b@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2925; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=IF42cJs4MpkxNJaOlRvE38Bf4YnfgCEoIGhaNqdYM1c=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoVVEVvvpIAEQO5lCfWNBwJe9R34e2PT+so9jUm
 Cu3j0gleJWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaFVRFQAKCRAADmhBGVaC
 FcV0D/0ZDpZ+30hMQqCnHD49j0iVgPsIhEkt1dhp80pnrffQmqkn/0vfx+KAD7PMqIpJU05jfQs
 rLZ72ZOH8hmgtzPytt3RsoduhyB6zk8hlKThPI0gEnHbBxF4lHSNvhVcPIy3wXUtU/2RRU4FcZj
 kw69dWbHVtSATg8iHVhC296Tt3yO7I0P4+VA45hr9AroEayniBp0f/KjFMQ13+vfCkTJYM2dJG+
 rYwwz/FqKxJOcQywl+ZFPR58sUfmD23bzw+mLJ96GCpGn2VQeD2bveYVSCBhBDiRdycK645/vzU
 TYWsb3vgjJH6avrEWAyuIPc1p3ouwT14xYCBpjcQhDFKBEctOvvOz3aBluWLubtUv8Q3EJBZOYo
 6EzbRyO5wPP2co/tladL0YLojhuKmGr/9U3q1BVcaa4gUMEtDLEVatWtD1oo/OPMiwKwGNW6+pn
 AX35SH1zVMeCx5kulKehPSWwAzYQQECzZwpxIY5wODUm/I38/Jmvx3EhfQIpPNsVPAea5VEuKZ1
 XVPJiSyj2s8VOHkqhEgp8FqAe+HFZH/61G8dbZZTI0Q/zstgMty1sO+MHihH5N/0LOFohHgUFqp
 d/Ayb40pWw+q9udR/C4x1SMAjhtGxISvhBDh5KFN1Pm6jExYUtwm4PWq6JKORok7ZgJJXallZtn
 z+IcszEj0cdo77g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In the case of an unknown error code from svc_authenticate or
pg_authenticate, return AUTH_ERROR with a status of AUTH_FAILED. Also
add the other auth_stat value from RFC 5531, and document all the status
codes.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/msg_prot.h | 18 ++++++++++--------
 include/linux/sunrpc/xdr.h      |  2 ++
 net/sunrpc/svc.c                |  3 ++-
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/linux/sunrpc/msg_prot.h b/include/linux/sunrpc/msg_prot.h
index c4b0eb2b2f040887d05b3951c9322c7175dd9329..ada17b57ca44ab65d0e4efc4cc1f71b03f47412d 100644
--- a/include/linux/sunrpc/msg_prot.h
+++ b/include/linux/sunrpc/msg_prot.h
@@ -69,15 +69,17 @@ enum rpc_reject_stat {
 };
 
 enum rpc_auth_stat {
-	RPC_AUTH_OK = 0,
-	RPC_AUTH_BADCRED = 1,
-	RPC_AUTH_REJECTEDCRED = 2,
-	RPC_AUTH_BADVERF = 3,
-	RPC_AUTH_REJECTEDVERF = 4,
-	RPC_AUTH_TOOWEAK = 5,
+	RPC_AUTH_OK = 0,		/* success */
+	RPC_AUTH_BADCRED = 1,		/* bad credential (seal broken) */
+	RPC_AUTH_REJECTEDCRED = 2,	/* client must begin new session */
+	RPC_AUTH_BADVERF = 3,		/* bad verifier (seal broken) */
+	RPC_AUTH_REJECTEDVERF = 4,	/* verifier expired or replayed */
+	RPC_AUTH_TOOWEAK = 5,		/* rejected for security reasons */
+	RPC_AUTH_INVALIDRESP = 6,	/* bogus response verifier */
+	RPC_AUTH_FAILED = 7,		/* reason unknown */
 	/* RPCSEC_GSS errors */
-	RPCSEC_GSS_CREDPROBLEM = 13,
-	RPCSEC_GSS_CTXPROBLEM = 14
+	RPCSEC_GSS_CREDPROBLEM = 13,	/* no credentials for user */
+	RPCSEC_GSS_CTXPROBLEM = 14	/* problem with context */
 };
 
 #define RPC_MAXNETNAMELEN	256
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 29d3a7659727dacc0f7cc2f4f18c589a524323c4..e3358c630ba18b0af13bc5ff8e1ab2f884125da7 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -119,6 +119,8 @@ xdr_buf_init(struct xdr_buf *buf, void *start, size_t len)
 #define	rpc_autherr_badverf	cpu_to_be32(RPC_AUTH_BADVERF)
 #define	rpc_autherr_rejectedverf cpu_to_be32(RPC_AUTH_REJECTEDVERF)
 #define	rpc_autherr_tooweak	cpu_to_be32(RPC_AUTH_TOOWEAK)
+#define	rpc_autherr_invalidresp	cpu_to_be32(RPC_AUTH_INVALIDRESP)
+#define	rpc_autherr_failed	cpu_to_be32(RPC_AUTH_FAILED)
 #define	rpcsec_gsserr_credproblem	cpu_to_be32(RPCSEC_GSS_CREDPROBLEM)
 #define	rpcsec_gsserr_ctxproblem	cpu_to_be32(RPCSEC_GSS_CTXPROBLEM)
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 9abdbcbf247323207cba13546173b8fd28a15e24..195fb0bea841451ad48717d7936992e0a850f703 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1387,7 +1387,8 @@ svc_process_common(struct svc_rqst *rqstp)
 		goto sendit;
 	default:
 		pr_warn_once("Unexpected svc_auth_status (%d)\n", auth_res);
-		goto err_system_err;
+		rqstp->rq_auth_stat = rpc_autherr_failed;
+		goto err_bad_auth;
 	}
 
 	if (progp == NULL)

-- 
2.49.0


