Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2578C3717D7
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 17:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhECPZD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 May 2021 11:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230122AbhECPZC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 May 2021 11:25:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 926AA61176
        for <linux-nfs@vger.kernel.org>; Mon,  3 May 2021 15:24:08 +0000 (UTC)
Subject: [PATCH v1 13/29] lockd: Update the NLMv1 void results encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 03 May 2021 11:24:07 -0400
Message-ID: <162005544769.23028.14271181146877774876.stgit@klimt.1015granger.net>
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
 fs/lockd/xdr.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 091c8c463ab4..840fa8ff8426 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -331,6 +331,17 @@ nlmsvc_decode_notify(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
+
+/*
+ * Encode Reply results
+ */
+
+int
+nlmsvc_encode_void(struct svc_rqst *rqstp, __be32 *p)
+{
+	return 1;
+}
+
 int
 nlmsvc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
 {
@@ -363,9 +374,3 @@ nlmsvc_encode_res(struct svc_rqst *rqstp, __be32 *p)
 	*p++ = resp->status;
 	return xdr_ressize_check(rqstp, p);
 }
-
-int
-nlmsvc_encode_void(struct svc_rqst *rqstp, __be32 *p)
-{
-	return xdr_ressize_check(rqstp, p);
-}


