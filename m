Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB153717CC
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 17:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhECPYH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 May 2021 11:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230283AbhECPYG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 May 2021 11:24:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 111B161176
        for <linux-nfs@vger.kernel.org>; Mon,  3 May 2021 15:23:12 +0000 (UTC)
Subject: [PATCH v1 04/29] lockd: Update the NLMv1 void argument decoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 03 May 2021 11:23:12 -0400
Message-ID: <162005539220.23028.13117050828620463175.stgit@klimt.1015granger.net>
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
 fs/lockd/xdr.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 982629f7b120..8be42a23679e 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -19,6 +19,8 @@
 
 #include <uapi/linux/nfs2.h>
 
+#include "svcxdr.h"
+
 #define NLMDBG_FACILITY		NLMDBG_XDR
 
 
@@ -178,8 +180,15 @@ nlm_encode_testres(__be32 *p, struct nlm_res *resp)
 
 
 /*
- * First, the server side XDR functions
+ * Decode Call arguments
  */
+
+int
+nlmsvc_decode_void(struct svc_rqst *rqstp, __be32 *p)
+{
+	return 1;
+}
+
 int
 nlmsvc_decode_testargs(struct svc_rqst *rqstp, __be32 *p)
 {
@@ -339,12 +348,6 @@ nlmsvc_decode_res(struct svc_rqst *rqstp, __be32 *p)
 	return xdr_argsize_check(rqstp, p);
 }
 
-int
-nlmsvc_decode_void(struct svc_rqst *rqstp, __be32 *p)
-{
-	return xdr_argsize_check(rqstp, p);
-}
-
 int
 nlmsvc_encode_void(struct svc_rqst *rqstp, __be32 *p)
 {


