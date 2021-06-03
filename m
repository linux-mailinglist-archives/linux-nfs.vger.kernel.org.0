Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A811D39AC1A
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jun 2021 22:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFCUy5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 16:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhFCUy4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Jun 2021 16:54:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2885613E4;
        Thu,  3 Jun 2021 20:53:11 +0000 (UTC)
Subject: [PATCH 26/29] lockd: Update the NLMv4 void results encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 03 Jun 2021 16:53:11 -0400
Message-ID: <162275359102.32691.16856338951909824271.stgit@klimt.1015granger.net>
In-Reply-To: <162275337584.32691.3943139351165347555.stgit@klimt.1015granger.net>
References: <162275337584.32691.3943139351165347555.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/xdr4.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 6c5383bef2bf..0db142e203d2 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -324,6 +324,17 @@ nlm4svc_decode_notify(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
+
+/*
+ * Encode Reply results
+ */
+
+int
+nlm4svc_encode_void(struct svc_rqst *rqstp, __be32 *p)
+{
+	return 1;
+}
+
 int
 nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
 {
@@ -356,9 +367,3 @@ nlm4svc_encode_res(struct svc_rqst *rqstp, __be32 *p)
 	*p++ = resp->status;
 	return xdr_ressize_check(rqstp, p);
 }
-
-int
-nlm4svc_encode_void(struct svc_rqst *rqstp, __be32 *p)
-{
-	return xdr_ressize_check(rqstp, p);
-}


