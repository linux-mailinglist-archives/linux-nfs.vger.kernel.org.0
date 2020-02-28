Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82EF6172D54
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 01:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgB1Abc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Feb 2020 19:31:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43461 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgB1Abb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Feb 2020 19:31:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id p11so489464plq.10;
        Thu, 27 Feb 2020 16:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JlXp/UrJNcRE29eMFkaSctlpVhJd/rHOgcmwyTldv80=;
        b=BTcc7nJ9v9S0yxYdj2pEqfn37kuTNISQHT0QSxgTJYATWIZFDoq900KoJVnVQQ52WR
         YDn5dpN2Q09fRErlTsoyOpwQhcvxKEIFdJHMJREXaSpSv4720TWmg72LFX1zm6gXgO30
         M399oPIHZd9TV0aC4Xrx9I6SXY91KOaO477K+5t0f8aeXaxavzoOcNRIUUMh82+db7R6
         CMBke5JwVyOM2vZ/X6wpOzf43sVCvj5UZhgCsXXUvql6IwdaGKYBmqbk5GsbjoslTa1d
         GDxCPN3Y3hE3jBkcXz+ywuNlUBC6OUXy7SkIB4RDbrwbvck3sxWVNKE6upKNpapLvbMa
         OazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=JlXp/UrJNcRE29eMFkaSctlpVhJd/rHOgcmwyTldv80=;
        b=uN3j1/ziz9QasAnY2HbAx/iDn3JtNv9mw0U2oSalqSEFPV2bCrqDhc3QTE/hNDa2ez
         Tez95MANTY7o7MzM9K+4ytGNc/SP8DspDPp8FmRABm/P8llYuwm08FHh8vKMu4eJ2QYc
         UmjVi+/LYGXILeKYxBweL+t8Bq+Qoi8+3MC7QQAfxTJcqyL5iQFjR49mpFJ76NuN8XhJ
         RfCHAQejFpXXe8jZ+5Ofv6IRFvaNKn5UQTwWpK/A9FJpoDUcgo+IltNpagxEEgpDVtmp
         draUBF0mBIMZJOdQjZ4jJQBXwUaTAQwfoSd9JQimq0orZHoHEed5U/8k2YkomaCY8fwN
         XnTw==
X-Gm-Message-State: APjAAAVPCY79V2V33UiBg3Gmyc7N1llSHxul6ixVuEHGPrnXFreywJrs
        raxnRLbGnhk4j0Er7x05OxFC4a21670=
X-Google-Smtp-Source: APXvYqyiZJnLyKkHFb83oQv298tbsfT0shCW9bG0hv0O6iqMb1O2OSyRzhNOqhwUzSsEXkJ/RTb+bg==
X-Received: by 2002:a17:90a:348a:: with SMTP id p10mr1713700pjb.120.1582849889179;
        Thu, 27 Feb 2020 16:31:29 -0800 (PST)
Received: from seurat29.1015granger.net (ip-184-250-247-225.sanjca.spcsdns.net. [184.250.247.225])
        by smtp.gmail.com with ESMTPSA id m12sm7685190pjf.25.2020.02.27.16.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:31:28 -0800 (PST)
Subject: [PATCH v1 09/16] svcrdma: Update synopsis of
 svc_rdma_send_reply_chunk()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 27 Feb 2020 19:31:27 -0500
Message-ID: <158284988744.38468.439479906974116037.stgit@seurat29.1015granger.net>
In-Reply-To: <158284930886.38468.17045380766660946827.stgit@seurat29.1015granger.net>
References: <158284930886.38468.17045380766660946827.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Preparing for subsequent patches, no behavior change expected.

Pass the RPC Call's svc_rdma_recv_ctxt deeper into the sendto()
path. This enables passing more information about Requester-
provided Write and Reply chunks into the lower-level send
functions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       |    2 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c     |   12 ++++++------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index e714e4d90ac5..42b68126cc60 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -179,7 +179,7 @@ extern int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 				     unsigned int offset,
 				     unsigned long length);
 extern int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
-				     __be32 *rp_ch, bool writelist,
+				     const struct svc_rdma_recv_ctxt *rctxt,
 				     struct xdr_buf *xdr);
 
 /* svc_rdma_sendto.c */
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index b0ac535c8728..9d854755d78d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -545,8 +545,7 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
 /**
  * svc_rdma_send_reply_chunk - Write all segments in the Reply chunk
  * @rdma: controlling RDMA transport
- * @rp_ch: Reply chunk provided by client
- * @writelist: true if client provided a Write list
+ * @rctxt: Write and Reply chunks from client
  * @xdr: xdr_buf containing an RPC Reply
  *
  * Returns a non-negative number of bytes the chunk consumed, or
@@ -556,13 +555,14 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma, __be32 *wr_ch,
  *	%-ENOTCONN if posting failed (connection is lost),
  *	%-EIO if rdma_rw initialization failed (DMA mapping, etc).
  */
-int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma, __be32 *rp_ch,
-			      bool writelist, struct xdr_buf *xdr)
+int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
+			      const struct svc_rdma_recv_ctxt *rctxt,
+			      struct xdr_buf *xdr)
 {
 	struct svc_rdma_write_info *info;
 	int consumed, ret;
 
-	info = svc_rdma_write_info_alloc(rdma, rp_ch);
+	info = svc_rdma_write_info_alloc(rdma, rctxt->rc_reply_chunk);
 	if (!info)
 		return -ENOMEM;
 
@@ -574,7 +574,7 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma, __be32 *rp_ch,
 	/* Send the page list in the Reply chunk only if the
 	 * client did not provide Write chunks.
 	 */
-	if (!writelist && xdr->page_len) {
+	if (!rctxt->rc_write_list && xdr->page_len) {
 		ret = svc_rdma_send_xdr_pagelist(info, xdr,
 						 xdr->head[0].iov_len,
 						 xdr->page_len);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 94895635c007..0b6ff55b1ab1 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -833,7 +833,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 		svc_rdma_xdr_encode_write_list(rdma_resp, wr_lst, ret);
 	}
 	if (rp_ch) {
-		ret = svc_rdma_send_reply_chunk(rdma, rp_ch, wr_lst, xdr);
+		ret = svc_rdma_send_reply_chunk(rdma, rctxt, &rqstp->rq_res);
 		if (ret < 0)
 			goto err2;
 		svc_rdma_xdr_encode_reply_chunk(rdma_resp, rp_ch, ret);

