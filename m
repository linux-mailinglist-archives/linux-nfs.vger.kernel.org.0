Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5795A3717E1
	for <lists+linux-nfs@lfdr.de>; Mon,  3 May 2021 17:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhECP0I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 May 2021 11:26:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhECP0E (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 May 2021 11:26:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E091611CE
        for <linux-nfs@vger.kernel.org>; Mon,  3 May 2021 15:25:10 +0000 (UTC)
Subject: [PATCH v1 23/29] lockd: Update the NLMv4 SM_NOTIFY arguments decoder
 to use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 03 May 2021 11:25:09 -0400
Message-ID: <162005550931.23028.6218799373703118043.stgit@klimt.1015granger.net>
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
 fs/lockd/xdr4.c |   39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 6bd3bfb69ed7..2dbf82c2726b 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -309,6 +309,32 @@ nlm4svc_decode_res(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
+int
+nlm4svc_decode_reboot(struct svc_rqst *rqstp, __be32 *p)
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
 nlm4svc_encode_testres(struct svc_rqst *rqstp, __be32 *p)
 {
@@ -376,19 +402,6 @@ nlm4svc_decode_notify(struct svc_rqst *rqstp, __be32 *p)
 	return xdr_argsize_check(rqstp, p);
 }
 
-int
-nlm4svc_decode_reboot(struct svc_rqst *rqstp, __be32 *p)
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
 nlm4svc_encode_void(struct svc_rqst *rqstp, __be32 *p)
 {


