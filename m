Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3285839AC06
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jun 2021 22:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFCUxU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 16:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCUxU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Jun 2021 16:53:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F4F760C3D;
        Thu,  3 Jun 2021 20:51:35 +0000 (UTC)
Subject: [PATCH 10/29] lockd: Update the NLMv1 SM_NOTIFY arguments decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 03 Jun 2021 16:51:34 -0400
Message-ID: <162275349441.32691.6246136814695884016.stgit@klimt.1015granger.net>
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
 fs/lockd/xdr.c |   39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 911b6377a6da..421613170e5f 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -313,6 +313,32 @@ nlmsvc_decode_res(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
+int
+nlmsvc_decode_reboot(struct svc_rqst *rqstp, __be32 *p)
+{
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
+	struct nlm_reboot *argp = rqstp->rq_argp;
+	u32 len;
+
+	if (xdr_stream_decode_u32(xdr, &len) < 0)
+		return 0;
+	if (len > SM_MAXSTRLEN)
+		return 0;
+	p = xdr_inline_decode(xdr, len);
+	if (!p)
+		return 0;
+	argp->len = len;
+	argp->mon = (char *)p;
+	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
+		return 0;
+	p = xdr_inline_decode(xdr, SM_PRIV_SIZE);
+	if (!p)
+		return 0;
+	memcpy(&argp->priv.data, p, sizeof(argp->priv.data));
+
+	return 1;
+}
+
 int
 nlmsvc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
 {
@@ -380,19 +406,6 @@ nlmsvc_decode_notify(struct svc_rqst *rqstp, __be32 *p)
 	return xdr_argsize_check(rqstp, p);
 }
 
-int
-nlmsvc_decode_reboot(struct svc_rqst *rqstp, __be32 *p)
-{
-	struct nlm_reboot *argp = rqstp->rq_argp;
-
-	if (!(p = xdr_decode_string_inplace(p, &argp->mon, &argp->len, SM_MAXSTRLEN)))
-		return 0;
-	argp->state = ntohl(*p++);
-	memcpy(&argp->priv.data, p, sizeof(argp->priv.data));
-	p += XDR_QUADLEN(SM_PRIV_SIZE);
-	return xdr_argsize_check(rqstp, p);
-}
-
 int
 nlmsvc_encode_void(struct svc_rqst *rqstp, __be32 *p)
 {


