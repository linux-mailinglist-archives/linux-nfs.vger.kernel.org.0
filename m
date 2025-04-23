Return-Path: <linux-nfs+bounces-11237-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED447A99216
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 17:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A834A1720
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCED2BE104;
	Wed, 23 Apr 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIpuDIUH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFDE2BE100
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421682; cv=none; b=Xvv1wNuA1O0Rbr6YIpEz11qtbhTiIllEfGg8QLbh192zBpJCzxlsEcgihkO9eEiufdfO/HeuSFwymKcV2eNDrJmSqRSUoP6qmRfTPv/+h+s9V3cb/hksqUfprnwi4+yxmn40sXafVjpMqedsNco/w1X6Zsh9og2uywFHWnDJoCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421682; c=relaxed/simple;
	bh=ms3TfLlwCJQk6aSL8rEnyLGEli2nEJ4lwU1S/skoGtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iH41CvqrT9cOROWEWbT+uGZVsl1ZkigOdy0oIBq+rBGOPXx0O2m3YAqqIvgpWoJbypotV2fohzsQ1pTCtBsE/wmCf3hw6DucqLn/NQSF4fqFCkk/UmHAGwQOa9QGDmYeqw+jmNVNpGKnJkdnTmZDXyRO3JTRzuM+hPYaU5CGlVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIpuDIUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E62C4CEED;
	Wed, 23 Apr 2025 15:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745421682;
	bh=ms3TfLlwCJQk6aSL8rEnyLGEli2nEJ4lwU1S/skoGtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIpuDIUHNSb76vKXcpOwyOos2g9Kk1F7Y1DarjeWDnt83EhRispxfdHM4sI7eqt0c
	 rHHJoPRHskjEruNl18kgcuR4S6Cil+ryrvY4vynbXHL055NC4xPZ1i9opDMzk/mnad
	 s8VBzucPuNS+Cxi16peDFlN2jn+aVVdW6JvkLiuXxZ6aOwNmCWMo36nNOsL/tmAJR+
	 1/G1Fd/ukswqWRJew6hHg1xm/zgnXBjo+ViPUPifBnfbYmU4N0hfYoX68e5CMVPh4U
	 06GbSVan1fsDs2jXlenNUCFmCUV9mb07nX5up96nas0Xn1+FMXr6rMwsbmwBSZkIPu
	 AAWGmVBL6cB6A==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 02/11] sunrpc: Add a helper to derive maxpages from sv_max_mesg
Date: Wed, 23 Apr 2025 11:21:08 -0400
Message-ID: <20250423152117.5418-3-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423152117.5418-1-cel@kernel.org>
References: <20250423152117.5418-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

This page count is to be used to allocate various arrays of pages,
bio_vecs, and kvecs, replacing the fixed RPCSVC_MAXPAGES value.

The documenting comment is somewhat stale -- of course NFSv4
COMPOUND procedures may have multiple payloads.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 74658cca0f38..e83ac14267e8 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -159,6 +159,23 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
 #define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
 				+ 2 + 1)
 
+/**
+ * svc_serv_maxpages - maximum pages/kvecs needed for one RPC message
+ * @serv: RPC service context
+ *
+ * Returns a count of pages or vectors that can hold the maximum
+ * size RPC message for @serv.
+ *
+ * Each request/reply pair can have at most one "payload", plus two
+ * pages, one for the request, and one for the reply.
+ * nfsd_splice_actor() might need an extra page when a READ payload
+ * is not page-aligned.
+ */
+static inline unsigned long svc_serv_maxpages(const struct svc_serv *serv)
+{
+	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1;
+}
+
 /*
  * The context of a single thread, including the request currently being
  * processed.
-- 
2.49.0


