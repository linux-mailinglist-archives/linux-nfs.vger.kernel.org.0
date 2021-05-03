Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F973717E6
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 17:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhECP00 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 May 2021 11:26:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230382AbhECP0W (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 May 2021 11:26:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98A0461278
        for <linux-nfs@vger.kernel.org>; Mon,  3 May 2021 15:25:28 +0000 (UTC)
Subject: [PATCH v1 26/29] lockd: Update the NLMv4 void results encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 03 May 2021 11:25:27 -0400
Message-ID: <162005552776.23028.12171687493528540779.stgit@klimt.1015granger.net>
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


