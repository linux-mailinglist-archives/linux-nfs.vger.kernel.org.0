Return-Path: <linux-nfs+bounces-6266-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3C396E2CC
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 21:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09ABC287410
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 19:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09A318D650;
	Thu,  5 Sep 2024 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZiu+ask"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3E518D627
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563422; cv=none; b=UrHmq4T0QkUwCa5r5xycUspws1lEajuPPA9Cd+6d/YjfOWlnWYOrNUA1iouOY8ExsxfHCA9YH8t0oZCsNM+t/Z8RThNldF0k3tKnmoPUMBmOMwnn7TMq4q3/+0y3w5U/MWZJfw05S0BJKF6l81+lZWauKlWTa1k/9P9oqMDfNPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563422; c=relaxed/simple;
	bh=2mDmKEgelrdr8lqSo1yVD1z4WY4Dct67Rh8DMbAy3d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RX6zXGCE+GSnusi1KNe76d4cSPyVd4AliGlOpfjyR4xTfYWzsuDRUQZnWlyybIeBbtpMvNttODqP2FtW2JnwABqMU+/qE0H5olS6HZlsOZZBS/tUqcjdFv2uiXzvP9B45gvLFOpFjj28f89XHk0zDzuBiW1ltjC8r6SIocoF7U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZiu+ask; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4551FC4CEC3;
	Thu,  5 Sep 2024 19:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725563422;
	bh=2mDmKEgelrdr8lqSo1yVD1z4WY4Dct67Rh8DMbAy3d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZiu+askm5DoWRESyxfFOQxK2z/J+hfaqPXq7Iwe3q4K+YbI8sQw9fmfx/rzI9SR/
	 CoOkrTRSik4fNV0UxGLzB0L0TJ5LVS3IOo6i/24QY2E3z0N0J0zKinbKbL1VslVwl4
	 f7gYXf9I4wV4RyfIH8f08G8YFJ9M08LAbE0wT7HcPtc3u3imD1FbMKnRC7bAFxwo0g
	 gClUDzWvOV7RIKJZupUCQ0H3UuhDyUfvHFqXWtzgJ8dm1OSbQG7Xm+TrGvDiePQKx1
	 maAHxyr1sFCqGTT4acRR0U9nzGMLExF78q+0mS6JT68mCFe9ecPBhht9K6YwtcJO2L
	 YTSNuRXkh/zTQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>
Subject: [PATCH v16 07/26] NFSD: Short-circuit fh_verify tracepoints for LOCALIO
Date: Thu,  5 Sep 2024 15:09:41 -0400
Message-ID: <20240905191011.41650-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240905191011.41650-1-snitzer@kernel.org>
References: <20240905191011.41650-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

LOCALIO will be able to call fh_verify() with a NULL rqstp. In this
case, the existing trace points need to be skipped because they
want to dereference the address fields in the passed-in rqstp.

Temporarily make these trace points conditional to avoid a seg
fault in this case. Putting the "rqstp != NULL" check in the trace
points themselves makes the check more efficient.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Acked-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/trace.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 77bbd23aa150..d22027e23761 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -193,7 +193,7 @@ TRACE_EVENT(nfsd_compound_encode_err,
 		{ S_IFIFO,		"FIFO" }, \
 		{ S_IFSOCK,		"SOCK" })
 
-TRACE_EVENT(nfsd_fh_verify,
+TRACE_EVENT_CONDITION(nfsd_fh_verify,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,
 		const struct svc_fh *fhp,
@@ -201,6 +201,7 @@ TRACE_EVENT(nfsd_fh_verify,
 		int access
 	),
 	TP_ARGS(rqstp, fhp, type, access),
+	TP_CONDITION(rqstp != NULL),
 	TP_STRUCT__entry(
 		__field(unsigned int, netns_ino)
 		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
@@ -239,7 +240,7 @@ TRACE_EVENT_CONDITION(nfsd_fh_verify_err,
 		__be32 error
 	),
 	TP_ARGS(rqstp, fhp, type, access, error),
-	TP_CONDITION(error),
+	TP_CONDITION(rqstp != NULL && error),
 	TP_STRUCT__entry(
 		__field(unsigned int, netns_ino)
 		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
@@ -295,12 +296,13 @@ DECLARE_EVENT_CLASS(nfsd_fh_err_class,
 		  __entry->status)
 )
 
-#define DEFINE_NFSD_FH_ERR_EVENT(name)		\
-DEFINE_EVENT(nfsd_fh_err_class, nfsd_##name,	\
-	TP_PROTO(struct svc_rqst *rqstp,	\
-		 struct svc_fh	*fhp,		\
-		 int		status),	\
-	TP_ARGS(rqstp, fhp, status))
+#define DEFINE_NFSD_FH_ERR_EVENT(name)			\
+DEFINE_EVENT_CONDITION(nfsd_fh_err_class, nfsd_##name,	\
+	TP_PROTO(struct svc_rqst *rqstp,		\
+		 struct svc_fh	*fhp,			\
+		 int		status),		\
+	TP_ARGS(rqstp, fhp, status),			\
+	TP_CONDITION(rqstp != NULL))
 
 DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badexport);
 DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badhandle);
-- 
2.44.0


