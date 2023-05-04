Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D666F7763
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 22:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjEDUtI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 16:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjEDUsi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 16:48:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41325A246
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 13:48:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84C91639EF
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 20:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0059C4339B;
        Thu,  4 May 2023 20:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683233235;
        bh=LkyZsGEk0IVqS4b6sAkmOfQ9+/+05DvGiOEGldodzp8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=l8QnJy/RzZo9eGK9BtFMRmB/7+OyQ2eSDhxpJBchsloVKXqB52b6C7PYBxwuFIeA+
         MQyJNSS+VR+TThvbtQgurJI7UzFe0WfuDVcaxLBS7PAUEi7xDMQ8leFmwHxCwwbGr2
         tCag17TGE6ww3zdTA1f6ZXnIEc2hB0aQeTV+SncD/hAl/SNeMfKHfOeVJ842Qi+ImI
         72Hu8oMF0JyUZlyMzGbdr8G0CYNLToC4Quzf5dHeM+L9MpgzBaVdwJlZL6yY4inQRr
         BeYYRY4E3Ti2b20cXJovcVWR0IjUkIZEY1smLBCOUamKKw2/UFxKgN8PsR2zbeP3/W
         KUHhDHDklNqfA==
From:   Anna Schumaker <anna@kernel.org>
Date:   Thu, 04 May 2023 16:47:12 -0400
Subject: [PATCH 2/6] NFSv4.2: Clean up: move decode_*xattr() functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230504-xattr-ctime-v1-2-ac3fc5a00942@Netapp.com>
References: <20230504-xattr-ctime-v1-0-ac3fc5a00942@Netapp.com>
In-Reply-To: <20230504-xattr-ctime-v1-0-ac3fc5a00942@Netapp.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8473;
 i=Anna.Schumaker@Netapp.com; h=from:subject:message-id;
 bh=6VF3ae9Wbii4Me0VD/bZve2+nZAkzGxF7h2GbljRgDo=;
 b=owEBbQKS/ZANAwAIAdfLVL+wpUDrAcsmYgBkVBnQsKUzVBPkWluHaDmnQRM80ruSjFt2VqMhY
 OApmWY6a1mJAjMEAAEIAB0WIQSdnkxBOlHtwtTsoSnXy1S/sKVA6wUCZFQZ0AAKCRDXy1S/sKVA
 61sjD/9ayfZMW6w2U5bYLNbfG/sYNt/q/Dhiub2Tj1NZsnm1reTR7uh5FXB9bVgUCklvNs7C3Qj
 JSToiryKJvjwt2WuwjD2hD2oJxD9eAwzmB/VyJ54uAKHfugbhgh1W7nX9CuY7BM7ZqA95sVIDFF
 PokFzjj3ViPnu+KkJYxDmXCirlVYBhCxiwBec3JA75XArkJfAO5nRwGEn7tkDzpUy2WsT3uyAEL
 kloHQEjIOKKa2be5iPXUjXRhQXi+GnbhYK5WcTb66u+ffWt8n6rESaP1IK9QAOjzz5UOKN5lT8T
 7kBQyxRtBMW1BkfhEwg5n5zYr1u9ywSslh5ITjTPQYyazulFSbAQ49lQgZNJpYo5CE7wBqyrfOJ
 RPNJhJMZEij3t3s9Nk2x01G3RHNJ4OF1aXDTjPFJVykrGazorn7fFNSQkdW/yVFLX/w0n1ivdQ/
 EN8HLFPdAX0ZH45Dcs4qTM1yBU2Cj4rTJITC9s8QojoaDm0JWd0v29e0fAXPhI8FlEGg1JWGupy
 dRM36wa7qIxRdip4+CkWpXOPoqKSudhjTQUD+JD3YDLl91SGLXYUwZZ8v673deygGlYnJfPdwPM
 MzD9JrPi5LaEX7ebmxgevpOMBvDdCDufMOBHHjPz0gM5qGMpIEbnvg6dwZI/Vnx8AAitoxDlPle
 P+I8x+pabwrzOHQ==
X-Developer-Key: i=Anna.Schumaker@Netapp.com; a=openpgp;
 fpr=9D9E4C413A51EDC2D4ECA129D7CB54BFB0A540EB
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Move them out of the encode_*() section and into the decode_*() section
where it belongs.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 326 +++++++++++++++++++++++++++---------------------------
 1 file changed, 162 insertions(+), 164 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index dfac3f62c7ed..09e735bcee09 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -464,20 +464,6 @@ static void encode_setxattr(struct xdr_stream *xdr,
 		xdr_write_pages(xdr, arg->xattr_pages, 0, arg->xattr_len);
 }
 
-static int decode_setxattr(struct xdr_stream *xdr,
-			   struct nfs4_change_info *cinfo)
-{
-	int status;
-
-	status = decode_op_hdr(xdr, OP_SETXATTR);
-	if (status)
-		goto out;
-	status = decode_change_info(xdr, cinfo);
-out:
-	return status;
-}
-
-
 static void encode_getxattr(struct xdr_stream *xdr, const char *name,
 			    struct compound_hdr *hdr)
 {
@@ -485,43 +471,6 @@ static void encode_getxattr(struct xdr_stream *xdr, const char *name,
 	encode_string(xdr, strlen(name), name);
 }
 
-static int decode_getxattr(struct xdr_stream *xdr,
-			   struct nfs42_getxattrres *res,
-			   struct rpc_rqst *req)
-{
-	int status;
-	__be32 *p;
-	u32 len, rdlen;
-
-	status = decode_op_hdr(xdr, OP_GETXATTR);
-	if (status)
-		return status;
-
-	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(!p))
-		return -EIO;
-
-	len = be32_to_cpup(p);
-
-	/*
-	 * Only check against the page length here. The actual
-	 * requested length may be smaller, but that is only
-	 * checked against after possibly caching a valid reply.
-	 */
-	if (len > req->rq_rcv_buf.page_len)
-		return -ERANGE;
-
-	res->xattr_len = len;
-
-	if (len > 0) {
-		rdlen = xdr_read_pages(xdr, len);
-		if (rdlen < len)
-			return -EIO;
-	}
-
-	return 0;
-}
-
 static void encode_removexattr(struct xdr_stream *xdr, const char *name,
 			       struct compound_hdr *hdr)
 {
@@ -529,21 +478,6 @@ static void encode_removexattr(struct xdr_stream *xdr, const char *name,
 	encode_string(xdr, strlen(name), name);
 }
 
-
-static int decode_removexattr(struct xdr_stream *xdr,
-			   struct nfs4_change_info *cinfo)
-{
-	int status;
-
-	status = decode_op_hdr(xdr, OP_REMOVEXATTR);
-	if (status)
-		goto out;
-
-	status = decode_change_info(xdr, cinfo);
-out:
-	return status;
-}
-
 static void encode_listxattrs(struct xdr_stream *xdr,
 			     const struct nfs42_listxattrsargs *arg,
 			     struct compound_hdr *hdr)
@@ -565,104 +499,6 @@ static void encode_listxattrs(struct xdr_stream *xdr,
 	*p = cpu_to_be32(arg->count + 8 + 4);
 }
 
-static int decode_listxattrs(struct xdr_stream *xdr,
-			    struct nfs42_listxattrsres *res)
-{
-	int status;
-	__be32 *p;
-	u32 count, len, ulen;
-	size_t left, copied;
-	char *buf;
-
-	status = decode_op_hdr(xdr, OP_LISTXATTRS);
-	if (status) {
-		/*
-		 * Special case: for LISTXATTRS, NFS4ERR_TOOSMALL
-		 * should be translated to ERANGE.
-		 */
-		if (status == -ETOOSMALL)
-			status = -ERANGE;
-		/*
-		 * Special case: for LISTXATTRS, NFS4ERR_NOXATTR
-		 * should be translated to success with zero-length reply.
-		 */
-		if (status == -ENODATA) {
-			res->eof = true;
-			status = 0;
-		}
-		goto out;
-	}
-
-	p = xdr_inline_decode(xdr, 8);
-	if (unlikely(!p))
-		return -EIO;
-
-	xdr_decode_hyper(p, &res->cookie);
-
-	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(!p))
-		return -EIO;
-
-	left = res->xattr_len;
-	buf = res->xattr_buf;
-
-	count = be32_to_cpup(p);
-	copied = 0;
-
-	/*
-	 * We have asked for enough room to encode the maximum number
-	 * of possible attribute names, so everything should fit.
-	 *
-	 * But, don't rely on that assumption. Just decode entries
-	 * until they don't fit anymore, just in case the server did
-	 * something odd.
-	 */
-	while (count--) {
-		p = xdr_inline_decode(xdr, 4);
-		if (unlikely(!p))
-			return -EIO;
-
-		len = be32_to_cpup(p);
-		if (len > (XATTR_NAME_MAX - XATTR_USER_PREFIX_LEN)) {
-			status = -ERANGE;
-			goto out;
-		}
-
-		p = xdr_inline_decode(xdr, len);
-		if (unlikely(!p))
-			return -EIO;
-
-		ulen = len + XATTR_USER_PREFIX_LEN + 1;
-		if (buf) {
-			if (ulen > left) {
-				status = -ERANGE;
-				goto out;
-			}
-
-			memcpy(buf, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN);
-			memcpy(buf + XATTR_USER_PREFIX_LEN, p, len);
-
-			buf[ulen - 1] = 0;
-			buf += ulen;
-			left -= ulen;
-		}
-		copied += ulen;
-	}
-
-	p = xdr_inline_decode(xdr, 4);
-	if (unlikely(!p))
-		return -EIO;
-
-	res->eof = be32_to_cpup(p);
-	res->copied = copied;
-
-out:
-	if (status == -ERANGE && res->xattr_len == XATTR_LIST_MAX)
-		status = -E2BIG;
-
-	return status;
-}
-
 /*
  * Encode ALLOCATE request
  */
@@ -1192,6 +1028,168 @@ static int decode_layouterror(struct xdr_stream *xdr)
 	return decode_op_hdr(xdr, OP_LAYOUTERROR);
 }
 
+static int decode_setxattr(struct xdr_stream *xdr,
+			   struct nfs4_change_info *cinfo)
+{
+	int status;
+
+	status = decode_op_hdr(xdr, OP_SETXATTR);
+	if (status)
+		goto out;
+	status = decode_change_info(xdr, cinfo);
+out:
+	return status;
+}
+
+static int decode_getxattr(struct xdr_stream *xdr,
+			   struct nfs42_getxattrres *res,
+			   struct rpc_rqst *req)
+{
+	int status;
+	__be32 *p;
+	u32 len, rdlen;
+
+	status = decode_op_hdr(xdr, OP_GETXATTR);
+	if (status)
+		return status;
+
+	p = xdr_inline_decode(xdr, 4);
+	if (unlikely(!p))
+		return -EIO;
+
+	len = be32_to_cpup(p);
+
+	/*
+	 * Only check against the page length here. The actual
+	 * requested length may be smaller, but that is only
+	 * checked against after possibly caching a valid reply.
+	 */
+	if (len > req->rq_rcv_buf.page_len)
+		return -ERANGE;
+
+	res->xattr_len = len;
+
+	if (len > 0) {
+		rdlen = xdr_read_pages(xdr, len);
+		if (rdlen < len)
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static int decode_removexattr(struct xdr_stream *xdr,
+			   struct nfs4_change_info *cinfo)
+{
+	int status;
+
+	status = decode_op_hdr(xdr, OP_REMOVEXATTR);
+	if (status)
+		goto out;
+
+	status = decode_change_info(xdr, cinfo);
+out:
+	return status;
+}
+
+static int decode_listxattrs(struct xdr_stream *xdr,
+			    struct nfs42_listxattrsres *res)
+{
+	int status;
+	__be32 *p;
+	u32 count, len, ulen;
+	size_t left, copied;
+	char *buf;
+
+	status = decode_op_hdr(xdr, OP_LISTXATTRS);
+	if (status) {
+		/*
+		 * Special case: for LISTXATTRS, NFS4ERR_TOOSMALL
+		 * should be translated to ERANGE.
+		 */
+		if (status == -ETOOSMALL)
+			status = -ERANGE;
+		/*
+		 * Special case: for LISTXATTRS, NFS4ERR_NOXATTR
+		 * should be translated to success with zero-length reply.
+		 */
+		if (status == -ENODATA) {
+			res->eof = true;
+			status = 0;
+		}
+		goto out;
+	}
+
+	p = xdr_inline_decode(xdr, 8);
+	if (unlikely(!p))
+		return -EIO;
+
+	xdr_decode_hyper(p, &res->cookie);
+
+	p = xdr_inline_decode(xdr, 4);
+	if (unlikely(!p))
+		return -EIO;
+
+	left = res->xattr_len;
+	buf = res->xattr_buf;
+
+	count = be32_to_cpup(p);
+	copied = 0;
+
+	/*
+	 * We have asked for enough room to encode the maximum number
+	 * of possible attribute names, so everything should fit.
+	 *
+	 * But, don't rely on that assumption. Just decode entries
+	 * until they don't fit anymore, just in case the server did
+	 * something odd.
+	 */
+	while (count--) {
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
+
+		len = be32_to_cpup(p);
+		if (len > (XATTR_NAME_MAX - XATTR_USER_PREFIX_LEN)) {
+			status = -ERANGE;
+			goto out;
+		}
+
+		p = xdr_inline_decode(xdr, len);
+		if (unlikely(!p))
+			return -EIO;
+
+		ulen = len + XATTR_USER_PREFIX_LEN + 1;
+		if (buf) {
+			if (ulen > left) {
+				status = -ERANGE;
+				goto out;
+			}
+
+			memcpy(buf, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN);
+			memcpy(buf + XATTR_USER_PREFIX_LEN, p, len);
+
+			buf[ulen - 1] = 0;
+			buf += ulen;
+			left -= ulen;
+		}
+		copied += ulen;
+	}
+
+	p = xdr_inline_decode(xdr, 4);
+	if (unlikely(!p))
+		return -EIO;
+
+	res->eof = be32_to_cpup(p);
+	res->copied = copied;
+
+out:
+	if (status == -ERANGE && res->xattr_len == XATTR_LIST_MAX)
+		status = -E2BIG;
+
+	return status;
+}
+
 /*
  * Decode ALLOCATE request
  */

-- 
2.40.1

