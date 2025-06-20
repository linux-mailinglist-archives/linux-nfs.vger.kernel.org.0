Return-Path: <linux-nfs+bounces-12588-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0D4AE1AC6
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 14:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A9416BF72
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 12:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE5728B4FD;
	Fri, 20 Jun 2025 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhOhHl0L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6091B28B4EB;
	Fri, 20 Jun 2025 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421786; cv=none; b=q4qDI+2nfttve7UVRr28PsZuxgIL2NSFdFyLa8gcnvUhUVQhPEmSzN+1AWK5ZAKHpsyMzVlY7IfjINcr68pW9qFPH7F/R94tQ/9UJhFXq6OiCCueySWAwsVHtyeb+oUg4EPPVCqS2VRaLSWEWHpU31aIki+M9M2Jog3jJMYENZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421786; c=relaxed/simple;
	bh=z098PYiyfIazl40EKda1JH9sBsWrUnkCbFyKswmpC+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n/wPuI6OiRrr0kzC9ad29SPa0Ln/2Lic322nkpeh2h0lgyxHW82BtfUJp6ebWgld0yb0xT60ZkA98cxb77ZLNrCgfdr9dTshEa+zBQsZbkU0tKBtHQU5nvxNncl1KTPnffekNfWkmbob/UgBKJTn/fLjNBqPNG3twR24LdSnGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhOhHl0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2334EC4CEF1;
	Fri, 20 Jun 2025 12:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750421785;
	bh=z098PYiyfIazl40EKda1JH9sBsWrUnkCbFyKswmpC+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EhOhHl0LWwJZej3m61MHZuzPg4JpAI2bkVXVulWfd4QQVehXYVrfhlaNhro2tovc5
	 /jE+BB0TgdztUT48JjgnDRlEIu3NhJZ2GVT2x1nEQaVvEQA2vV+SUI4OqHI7EJFNct
	 4PYVtUtSXUGoH3GmRB9QRl4a/wGqReeGLEaeNTydTjUBQ1Folo5uklQ7n8Fj9zwKna
	 CNw9vkyir/IimkxXBbjXfJNIsvQXZqfbSCUC8EeECjkPuLRzbYMyUs/i6B9ypZp9zd
	 XLzaN/z9Uy3YFd9IUqmBwMrQB2XqKG7cga0RBEG7k40YV+mSMEjFRvyJC3Wd+3DHzs
	 JWQlgoZBBiJOA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 20 Jun 2025 08:16:02 -0400
Subject: [PATCH 2/6] sunrpc: remove SVC_SYSERR
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-rpc-6-17-v1-2-a309177d713b@kernel.org>
References: <20250620-rpc-6-17-v1-0-a309177d713b@kernel.org>
In-Reply-To: <20250620-rpc-6-17-v1-0-a309177d713b@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2250; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=z098PYiyfIazl40EKda1JH9sBsWrUnkCbFyKswmpC+E=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoVVEVFMNL4DJL4/b6ik7FbJ/ZuHz9hdYc7E3m+
 /haO0i8IuqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaFVRFQAKCRAADmhBGVaC
 FZnfEADLZsADpvh2Y74hvcpGU0+lADGZp/FXzT4mBOGgzIoH6aTDZaevFkpGRU1vci+JWz15Qfc
 w01d+B5tfzJVo67dcvzZGD65HnjQ0DDfGCkxOE8HU2GXnjQGpVH/DWGXlqn0GvAiw7/S3gaBCcc
 70UNHgpqIWVXGRc4g8Jt+6sFLiakviEvPKCnTkmrz+x5nhzc8fsMCUlugPImrsnI70ghp3qxY+t
 b3Q098hDjozguKPawxcYQQsd93Yf2yfdJcThPcvFGDs7SdxoDMNg13kH21NEAF5p7g/pmkvFAPY
 TvmovlKbTlexUZwGQtf/6z0HXxSUa3mI5sHFe9PvFYuLW2s9lEfRWuBRM30dx1TT+kRNesSx3CM
 BpIRun6OXZRkYX4OPeBIHyd2ezhjOSqgv/6RjTdZawR0Gv+BrWHvWDkkN4HaMGbvKU8sYE1wuK/
 tAQwIwJB6jSAiHV4L64MZuO2WUUWV0g41+JefZLVq73qjLTtU1esog/2K8nLZbjsSxs/uEdLog3
 BQ/opdxbU2o233tZQZMiaB/UuA8QiLVv1FMtEZ+eK1MEA9Eik2xOelLI3tNW92zZKbKHgdnTcu6
 ze8KbKuD/Lo70bCgVtGbgurhnWGwvuaHo0VVB/kMDmDh0CndI8hnVlu3QBxj6s+rQqfiIQEvSEy
 qxYIxFJiuSeiCwQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Nothing returns this error code.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/svcauth.h | 1 -
 include/trace/events/sunrpc.h  | 2 --
 net/sunrpc/svc.c               | 8 --------
 3 files changed, 11 deletions(-)

diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
index 2e111153f7cd2abde7a1ac7daa5b5b8c932a82cd..4b92fec23a490dc8246dc0532fbdd39244e233b0 100644
--- a/include/linux/sunrpc/svcauth.h
+++ b/include/linux/sunrpc/svcauth.h
@@ -86,7 +86,6 @@ struct auth_domain {
 
 enum svc_auth_status {
 	SVC_GARBAGE = 1,
-	SVC_SYSERR,
 	SVC_VALID,
 	SVC_NEGATIVE,
 	SVC_OK,
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index ff11fa07cbe3cd6863d281af4f6ed1d3684cf9f0..750ecce56930699e64956636cc0e7bb388596e87 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1691,7 +1691,6 @@ SVC_RQST_FLAG_LIST
 		__print_flags(flags, "|", SVC_RQST_FLAG_LIST)
 
 TRACE_DEFINE_ENUM(SVC_GARBAGE);
-TRACE_DEFINE_ENUM(SVC_SYSERR);
 TRACE_DEFINE_ENUM(SVC_VALID);
 TRACE_DEFINE_ENUM(SVC_NEGATIVE);
 TRACE_DEFINE_ENUM(SVC_OK);
@@ -1704,7 +1703,6 @@ TRACE_DEFINE_ENUM(SVC_COMPLETE);
 #define show_svc_auth_status(status)			\
 	__print_symbolic(status,			\
 		{ SVC_GARBAGE,	"SVC_GARBAGE" },	\
-		{ SVC_SYSERR,	"SVC_SYSERR" },		\
 		{ SVC_VALID,	"SVC_VALID" },		\
 		{ SVC_NEGATIVE,	"SVC_NEGATIVE" },	\
 		{ SVC_OK,	"SVC_OK" },		\
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 195fb0bea841451ad48717d7936992e0a850f703..c6ceacedae28e2aafd15edd170a27cdaa84ec47f 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1375,8 +1375,6 @@ svc_process_common(struct svc_rqst *rqstp)
 	case SVC_GARBAGE:
 		rqstp->rq_auth_stat = rpc_autherr_badcred;
 		goto err_bad_auth;
-	case SVC_SYSERR:
-		goto err_system_err;
 	case SVC_DENIED:
 		goto err_bad_auth;
 	case SVC_CLOSE:
@@ -1515,12 +1513,6 @@ svc_process_common(struct svc_rqst *rqstp)
 		serv->sv_stats->rpcbadfmt++;
 	*rqstp->rq_accept_statp = rpc_proc_unavail;
 	goto sendit;
-
-err_system_err:
-	if (serv->sv_stats)
-		serv->sv_stats->rpcbadfmt++;
-	*rqstp->rq_accept_statp = rpc_system_err;
-	goto sendit;
 }
 
 /*

-- 
2.49.0


