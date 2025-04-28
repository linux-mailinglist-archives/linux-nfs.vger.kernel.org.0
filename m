Return-Path: <linux-nfs+bounces-11317-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4CBA9F9A3
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 21:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63BD93A6576
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 19:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95556297A4C;
	Mon, 28 Apr 2025 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMK3JXPg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5592973CF;
	Mon, 28 Apr 2025 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869028; cv=none; b=d/wsb3ewxN9C0J54k6ptyqkJmPd2vzOkA0rCOTCQiJ8YGTAg7MRhQ/rTLGZ4jqpNI9bteFrIbI1tOR/bx+bK/J5lEtebo0bdGavlIlJcOGLEqKZbXCVD4zyIlvhCaZQ+fc8yKbpCnTh9js3QXNN/bpZCnPB6Fl46deKJcSvm7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869028; c=relaxed/simple;
	bh=ms3TfLlwCJQk6aSL8rEnyLGEli2nEJ4lwU1S/skoGtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFb9t57jAKUsZEjH/IG/qL7LPJqzKPvTjdAcwyB9c406e8e9WhTIqWaFUyFf9DAnm8rjeTyjWxOst9ViUzF/+ve0WKMVvWnCtQh4wFg0j/WBUwW+ex8GSVhA0KnRUYMEZiSE+eZicuuJlmh789LbNc7V0gJptocfq4BbGdXhXKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMK3JXPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BE4C4CEE4;
	Mon, 28 Apr 2025 19:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745869027;
	bh=ms3TfLlwCJQk6aSL8rEnyLGEli2nEJ4lwU1S/skoGtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VMK3JXPguwaOKFz0vmSDcSYel16b5rrwOeWNxX6CWyzagA2HwY9E9ljrg51Y/6tjS
	 NQ2NTALU8oUC8/mqTPhN4GFRUSFQPXvxFpuiy9w5lvrwbbMouGxMgmmxsGpxg7TkmW
	 OE2cE1oQj4vnVw1PLbIAqsKpkI2bTlTdRP+YxwQAX9uKsYCy3J38CAvbjVVM51U+g4
	 n+kZAtscIOUjl6Xy7p3n/t6i4La3la0NvCEB/UnanjpZNOapZhH5Vg0PNuAfX4zGFI
	 bBI8Et2b53mKkMGUCP1fVXEtBmf16QM9MRExxrIaP1iXyC06wMWg+6yKCAJ1u1PUp9
	 giAMq4Y5I+Wtw==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 02/14] sunrpc: Add a helper to derive maxpages from sv_max_mesg
Date: Mon, 28 Apr 2025 15:36:50 -0400
Message-ID: <20250428193702.5186-3-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428193702.5186-1-cel@kernel.org>
References: <20250428193702.5186-1-cel@kernel.org>
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


