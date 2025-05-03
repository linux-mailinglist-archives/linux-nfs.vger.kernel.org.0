Return-Path: <linux-nfs+bounces-11410-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ADAAA826F
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 22:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9051A17E19B
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 20:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F2227E7F5;
	Sat,  3 May 2025 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEUxO0kr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD24627F72B;
	Sat,  3 May 2025 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302385; cv=none; b=gH6QmdhajTgE6TBHK9tmH/Oa912zz3FdNuWBGYDNdaJGvcZOR/uRODCXOCiziNpbRTomK7ntkt1p+bk0gRhQJso3OpLBJrYj4XOF0slH5LTJEgg0wrFFErTHCFEA3rdBWRkAEj9plDSSVuykYHvqivtbPq25bnyOqyjzdv8Cfhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302385; c=relaxed/simple;
	bh=Y+vm8QBJf6x0L8SM/TRYAXig210shae3pkuCvvWKnRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phuB60c26xN1+/JPPwaiNa77lZfYvcE9zLXkGhLV0pzp1QRJPj5LWaob+IzMM0zkHFN7YYvVaO170AmgUGHxGrXQHQrZBLnSWU5aCKCTVKBLXUDWaTbO0nXcxeLew6APk8lVUHdzjPNIoe5TMBGSMI+CB6OcNMhI+x/HDs4OBwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEUxO0kr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8648AC4CEE9;
	Sat,  3 May 2025 19:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302383;
	bh=Y+vm8QBJf6x0L8SM/TRYAXig210shae3pkuCvvWKnRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hEUxO0kreuKGo27Yqz0p0SQoxv0dMu4BpqQI7E0qE+Bvvt/B6E6WAjOOIevZL/QTx
	 YIMoP7jtpJ40SvxKcQ3E8fFbC0NeccAn0eMq6/TONgUOY3H6rcBfYREr0BvOk0yCPd
	 5Xhs6VSZa3fdPZRINIVevJrFh8ggrGIKudKMm8pxNGmchztISfxkxhSbCPyXPKb7xZ
	 9GD369RaQizX1mC2YdBsHfq83pgDP0KD7+Q+7103gm+nkdSpf0z1TEAIs4d7QGfFBr
	 X5MbMRP5rxHzgVEaoWNJ12TPAAVQWQX187Q+eQeJbYu4iPcPGv5LI1y2m/g4AtMnj5
	 KkOICk1vNAdhw==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: sargun@sargun.me,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 02/18] NFSD: Add a Call equivalent to the NFSD_TRACE_PROC_RES macros
Date: Sat,  3 May 2025 15:59:20 -0400
Message-ID: <20250503195936.5083-3-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503195936.5083-1-cel@kernel.org>
References: <20250503195936.5083-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Introduce tracing helpers that can be used before the procedure
status code is known. These macros are similar to the
SVC_RQST_ENDPOINT helpers, but they can be modified to include
NFS-specific fields if that is needed later.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index f67ab3d1b506..fc373c4d5fdd 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -18,6 +18,23 @@
 #include "nfsfh.h"
 #include "xdr4.h"
 
+#define NFSD_TRACE_PROC_CALL_FIELDS(r) \
+		__field(unsigned int, netns_ino) \
+		__field(u32, xid) \
+		__sockaddr(server, (r)->rq_xprt->xpt_locallen) \
+		__sockaddr(client, (r)->rq_xprt->xpt_remotelen)
+
+#define NFSD_TRACE_PROC_CALL_ASSIGNMENTS(r) \
+		do { \
+			struct svc_xprt *xprt = (r)->rq_xprt; \
+			__entry->netns_ino = SVC_NET(r)->ns.inum; \
+			__entry->xid = be32_to_cpu((r)->rq_xid); \
+			__assign_sockaddr(server, &xprt->xpt_local, \
+					  xprt->xpt_locallen); \
+			__assign_sockaddr(client, &xprt->xpt_remote, \
+					  xprt->xpt_remotelen); \
+		} while (0)
+
 #define NFSD_TRACE_PROC_RES_FIELDS(r) \
 		__field(unsigned int, netns_ino) \
 		__field(u32, xid) \
-- 
2.49.0


