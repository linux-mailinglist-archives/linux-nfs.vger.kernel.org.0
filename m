Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A776132FDC7
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Mar 2021 23:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhCFWbH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Mar 2021 17:31:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhCFWai (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 6 Mar 2021 17:30:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8DFA6509D
        for <linux-nfs@vger.kernel.org>; Sat,  6 Mar 2021 22:30:37 +0000 (UTC)
Subject: [PATCH v2 14/43] NFSD: Update the NFSv3 PATHCONF3res encoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 06 Mar 2021 17:30:36 -0500
Message-ID: <161506983694.4312.6437537867812179836.stgit@klimt.1015granger.net>
In-Reply-To: <161506956174.4312.17478383686779759287.stgit@klimt.1015granger.net>
References: <161506956174.4312.17478383686779759287.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c          |   44 +++++++++++++++++++++++++++++++++-----------
 include/linux/sunrpc/xdr.h |   18 ++++++++++++++++--
 2 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 514f53ad7302..1467bba02e18 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -1501,25 +1501,47 @@ nfs3svc_encode_fsinfores(struct svc_rqst *rqstp, __be32 *p)
 	return 1;
 }
 
+static bool
+svcxdr_encode_pathconf3resok(struct xdr_stream *xdr,
+			     const struct nfsd3_pathconfres *resp)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, XDR_UNIT * 6);
+	if (!p)
+		return false;
+	*p++ = cpu_to_be32(resp->p_link_max);
+	*p++ = cpu_to_be32(resp->p_name_max);
+	p = xdr_encode_bool(p, resp->p_no_trunc);
+	p = xdr_encode_bool(p, resp->p_chown_restricted);
+	p = xdr_encode_bool(p, resp->p_case_insensitive);
+	xdr_encode_bool(p, resp->p_case_preserving);
+
+	return true;
+}
+
 /* PATHCONF */
 int
 nfs3svc_encode_pathconfres(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_res_stream;
 	struct nfsd3_pathconfres *resp = rqstp->rq_resp;
 
-	*p++ = resp->status;
-	*p++ = xdr_zero;	/* no post_op_attr */
-
-	if (resp->status == 0) {
-		*p++ = htonl(resp->p_link_max);
-		*p++ = htonl(resp->p_name_max);
-		*p++ = htonl(resp->p_no_trunc);
-		*p++ = htonl(resp->p_chown_restricted);
-		*p++ = htonl(resp->p_case_insensitive);
-		*p++ = htonl(resp->p_case_preserving);
+	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
+		return 0;
+	switch (resp->status) {
+	case nfs_ok:
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
+			return 0;
+		if (!svcxdr_encode_pathconf3resok(xdr, resp))
+			return 0;
+		break;
+	default:
+		if (!svcxdr_encode_post_op_attr(rqstp, xdr, &nfs3svc_null_fh))
+			return 0;
 	}
 
-	return xdr_ressize_check(rqstp, p);
+	return 1;
 }
 
 /* COMMIT */
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 9dda7171b7b4..a965cbc136ad 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -395,7 +395,21 @@ static inline int xdr_stream_encode_item_absent(struct xdr_stream *xdr)
 }
 
 /**
- * xdr_stream_encode_bool - Encode a "not present" list item
+ * xdr_encode_bool - Encode a boolean item
+ * @p: address in a buffer into which to encode
+ * @n: boolean value to encode
+ *
+ * Return value:
+ *   Address of item following the encoded boolean
+ */
+static inline __be32 *xdr_encode_bool(__be32 *p, u32 n)
+{
+	*p = n ? xdr_one : xdr_zero;
+	return p++;
+}
+
+/**
+ * xdr_stream_encode_bool - Encode a boolean item
  * @xdr: pointer to xdr_stream
  * @n: boolean value to encode
  *
@@ -410,7 +424,7 @@ static inline int xdr_stream_encode_bool(struct xdr_stream *xdr, __u32 n)
 
 	if (unlikely(!p))
 		return -EMSGSIZE;
-	*p = n ? xdr_one : xdr_zero;
+	xdr_encode_bool(p, n);
 	return len;
 }
 


