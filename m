Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CB33717DB
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 17:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhECPZ1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 May 2021 11:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230122AbhECPZ0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 May 2021 11:25:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4347261208
        for <linux-nfs@vger.kernel.org>; Mon,  3 May 2021 15:24:33 +0000 (UTC)
Subject: [PATCH v1 17/29] lockd: Update the NLMv4 void arguments decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 03 May 2021 11:24:32 -0400
Message-ID: <162005547238.23028.2510600771756442851.stgit@klimt.1015granger.net>
In-Reply-To: <162005520101.23028.15766816408658851498.stgit@klimt.1015granger.net>
References: <162005520101.23028.15766816408658851498.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/xdr4.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 5fa9f48a9dba..d0960a8551f8 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -18,6 +18,8 @@
 #include <linux/sunrpc/stats.h>
 #include <linux/lockd/lockd.h>
 
+#include "svcxdr.h"
+
 #define NLMDBG_FACILITY		NLMDBG_XDR
 
 static inline loff_t
@@ -175,8 +177,15 @@ nlm4_encode_testres(__be32 *p, struct nlm_res *resp)
 
 
 /*
- * First, the server side XDR functions
+ * Decode Call arguments
  */
+
+int
+nlm4svc_decode_void(struct svc_rqst *rqstp, __be32 *p)
+{
+	return 1;
+}
+
 int
 nlm4svc_decode_testargs(struct svc_rqst *rqstp, __be32 *p)
 {
@@ -336,12 +345,6 @@ nlm4svc_decode_res(struct svc_rqst *rqstp, __be32 *p)
 	return xdr_argsize_check(rqstp, p);
 }
 
-int
-nlm4svc_decode_void(struct svc_rqst *rqstp, __be32 *p)
-{
-	return xdr_argsize_check(rqstp, p);
-}
-
 int
 nlm4svc_encode_void(struct svc_rqst *rqstp, __be32 *p)
 {


