Return-Path: <linux-nfs+bounces-5833-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FFD961B2B
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 02:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8121F2489F
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 00:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EE11CFB6;
	Wed, 28 Aug 2024 00:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVkXkJyl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051871CF93
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 00:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724805897; cv=none; b=coayWIcvvqqQYqLpf76MXlKLkIw6rJEDLfjAHxE96hkF1YFYNy9J+JuQ8/fNmqBtqY/A/VuAuR01/aHrE03EQFNxZ635L4k3HWLj13mGpM5pLLhDKT3FnOa4oDah1iu+qtZyMPcNiFohTJUBg8vEuJFrdbTVDp60lO7vwwrr2dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724805897; c=relaxed/simple;
	bh=VBy+JHbinWQ0xd2jq5yGIOcOnjx8lz7dIPmKPuWr71c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9HDXvvgF9Egom3KSf6F/ackDE9cmu01JIPsmkgMj7uxoadxYAQLFNUUMOlOQGOj8R09+Qa/s/nl3OFaxmIlQGQIiQVm4YdWHa5bDp962BmSaBfPc0d83ps2lFXoxhHd9dMczEzgKDqBEcGOl57CZNfqaDiTKCXR0NWqp1TL4o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVkXkJyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707EDC4DDED;
	Wed, 28 Aug 2024 00:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724805896;
	bh=VBy+JHbinWQ0xd2jq5yGIOcOnjx8lz7dIPmKPuWr71c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVkXkJylBcqqit0oWzFODSnbxLpQnDGjfPVjtgsxehXQg/+gmsCHOslE55X6dqohw
	 VPO/vXUQIzDbf7T7ur5/OSBa7b389SbCOx2FqUvmBXVUB1IfgROIDOrvGg1QFmvTau
	 l+HR1wKtNkOj0qEeD35/OtkKUfMRQMd3E2mJa3xLmLjk1vM3jm2VMDYhmVrvdZXT8b
	 asetJNIE/ns8IjIzoNbQitZsqgykxa+vzhSUdFt3msx2smvyER54pVlYWEGnF/sGxl
	 0wYcX+LYemYhDigpZhmGxhojDpzpPC24zLWyGJYUZN4iU7qRrtQ5pDaP+jlMQ2DNsz
	 lDMm1/9TBTFRQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Mike Snitzer <snitzer@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 4/6] NFSD: Short-circuit fh_verify tracepoints for LOCALIO
Date: Tue, 27 Aug 2024 20:44:43 -0400
Message-ID: <20240828004445.22634-5-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828004445.22634-1-cel@kernel.org>
References: <20240828004445.22634-1-cel@kernel.org>
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
2.45.2


