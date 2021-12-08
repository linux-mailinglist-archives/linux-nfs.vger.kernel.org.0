Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7001E46D8FC
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Dec 2021 17:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbhLHQ6F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Dec 2021 11:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbhLHQ6F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Dec 2021 11:58:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320AEC061746
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 08:54:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F067DB82192
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2542C00446
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:54:30 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/5] NFSD: Remove NFSD_PROC_ARGS_* macros
Date:   Wed,  8 Dec 2021 11:54:29 -0500
Message-Id:  <163898246933.1640.1670630616955821708.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <163898243636.1640.16855750027301323187.stgit@bazille.1015granger.net>
References:  <163898243636.1640.16855750027301323187.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2206; h=from:subject:message-id; bh=Cct/LOBqnmHkqbnyMm0Fo1BELuCRkhq17qZzpI7UZIc=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhsONFvipekzWYmfcFdVkzTEVc/2JnbxcrtssGutDf HHoPgwuJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYbDjRQAKCRAzarMzb2Z/lwBWEA C+jt7i3hB+A7l5+nZPDZ/nPyspEd3kxhdmMLdrOIOwx02xv7f5qLyp5s6WVrcctNAJvl+MLHn9I/hS XqwrdCCxgGze466JuVoqkI5OsOMQPpDwhW1jR9QT9hRGtwLlSIiGAfzLInoLXMvxWkpnW0XxgT0DbL X5m2RqvImogz+1YCQUeris3Gk4AMK26qvZ/Q8Bfjj3bi0c1Cpws9k6c3JT7ao819T5TacXuvC2w+4F 0PI0uJPj5iZ2p6LwjWyOWm5In6/ZYdFUzWhaC4ff3VCN8pI4rqQ3PWd0EefIWq1kqqvDSGwv2H2cFE VtKL0+F6PW4Ym4Uq7L5fEr61murbPwNN6+RuDBTUdaQf5Ut4k+Cx8GWQp7LztEYIi6dhgmZKaHE2Ak HC9RyYoLH2QsLti9/UktKcyzA8NHMk6y6kTvxrmmhqSES9EfC4ZgkowbEPrxmDvZJBf3fgcJfz4reG gMLMasq3B/eZtjhH3+E5V5WZ8u8Nxw0i3YINC0EoxE8BRx8pmQ/4T9Df4YxctAQE2AuFWDy40qW7q2 I7S/Or38qo5y5Ja53GWA53RwdrskAIPawRVdjpB08hR3sgYcPkuxsN/Lf+I+efLkqIinxcxSvNpQl/ kKu0tsdoet/yuloPY8c6gQytyPdu1B7zI5z1659XteunBWB+QufsBVZivIzg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up.

The PROC_ARGS macros were added when I thought that NFSD tracepoints
would be reporting endpoint information. However, tracepoints in the
RPC server now report transport endpoint information, so in general
there's no need for the upper layers to do that any more, and these
macros can be retired.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h |   28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 6afb32093104..ebfe2b878574 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -13,22 +13,6 @@
 #include "export.h"
 #include "nfsfh.h"
 
-#define NFSD_TRACE_PROC_ARG_FIELDS \
-		__field(unsigned int, netns_ino) \
-		__field(u32, xid) \
-		__array(unsigned char, server, sizeof(struct sockaddr_in6)) \
-		__array(unsigned char, client, sizeof(struct sockaddr_in6))
-
-#define NFSD_TRACE_PROC_ARG_ASSIGNMENTS \
-		do { \
-			__entry->netns_ino = SVC_NET(rqstp)->ns.inum; \
-			__entry->xid = be32_to_cpu(rqstp->rq_xid); \
-			memcpy(__entry->server, &rqstp->rq_xprt->xpt_local, \
-			       rqstp->rq_xprt->xpt_locallen); \
-			memcpy(__entry->client, &rqstp->rq_xprt->xpt_remote, \
-			       rqstp->rq_xprt->xpt_remotelen); \
-		} while (0);
-
 #define NFSD_TRACE_PROC_RES_FIELDS \
 		__field(unsigned int, netns_ino) \
 		__field(u32, xid) \
@@ -53,14 +37,20 @@ DECLARE_EVENT_CLASS(nfsd_xdr_err_class,
 	),
 	TP_ARGS(rqstp),
 	TP_STRUCT__entry(
-		NFSD_TRACE_PROC_ARG_FIELDS
-
+		__array(unsigned char, server, sizeof(struct sockaddr_in6))
+		__array(unsigned char, client, sizeof(struct sockaddr_in6))
+		__field(unsigned int, netns_ino)
+		__field(u32, xid)
 		__field(u32, vers)
 		__field(u32, proc)
 	),
 	TP_fast_assign(
-		NFSD_TRACE_PROC_ARG_ASSIGNMENTS
+		const struct svc_xprt *xprt = rqstp->rq_xprt;
 
+		memcpy(__entry->server, &xprt->xpt_local, xprt->xpt_locallen);
+		memcpy(__entry->client, &xprt->xpt_remote, xprt->xpt_remotelen);
+		__entry->netns_ino = xprt->xpt_net->ns.inum;
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
 		__entry->vers = rqstp->rq_vers;
 		__entry->proc = rqstp->rq_proc;
 	),

