Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D0120D847
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2020 22:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbgF2Thx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 15:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387454AbgF2Tho (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 15:37:44 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E180C02F013;
        Mon, 29 Jun 2020 07:50:05 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g13so13006216qtv.8;
        Mon, 29 Jun 2020 07:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Xqol0YYHpEvswBoUVlP6v8tsfvVQp+w5nGY/v7Hvy2s=;
        b=GfpSf3j274MQbN6wKacSMHs3mq+lwatB1WxvTrVMlfHDXxXFZlcKXe1DqTLGqmE9zA
         Y0cG2ARBdR0WL3MdjpQz+S4/0lQVczgl/iat/9lcAvnC9OmQdfe0lZYRRm/qFtJIskT0
         TDe0TCVFTkpKsThMbO1A4lDn4NFTRn5O2abZ2Yy86wPprlMisokp+k7BqhVvgtBZucHq
         w2VHnZi5wuqj7+gvUYMAX7ggXdDuou4bwmZZmMKtDvWvQrypjRBPIWJgDRYl4f3A7z4R
         6UfwudChBT6GpV3+xbP5v2mb9qGD54+B8v+5vLo0qj6Ff0DrpjEmiZ+crjwELrARSnWF
         vR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Xqol0YYHpEvswBoUVlP6v8tsfvVQp+w5nGY/v7Hvy2s=;
        b=IYsNWlyOP0SE4VbcNrU4W5S8K0iSMZ5LQ97LiTHMVOrodYJv6H8jpR2NGqQuwvzpVW
         7eLjRapvkPrDU0sdoxR2YLL/spZtqu7FMshILmcSB9n7ywZGbWpaZgj3NHus7VASwoO4
         lpTjjILUDpZF2CdZxNgN5e+sE/RvTZVfrD/UNHRNR8F1MvceNWHCvopR0scikEH6ReRy
         VQ9alvHI/rBXbzje8kXaeSMC4o9Zk/cIdQIcYmXluyoWdtvlL//iwd11zXFb7koii2xe
         8NDSGW22lHQGK/T159EU6tnrsNCqHNOrUli8zEemjuZPpMSQTooR5qqYxuj41wVKt0y8
         JQxg==
X-Gm-Message-State: AOAM531TuXWDPmDJSnbu8BfySHNKj7xmcSPXCOM404F2OMBAKCd/vowP
        03m0GZnw2boJl3k+sTTEztKFBF3T
X-Google-Smtp-Source: ABdhPJyivBLhFQqyWungfUcgPb7+fQCgRWma10Cy63pDZE9RQlizbBc3+fJceAHi4Ot77kzbNqqOXg==
X-Received: by 2002:ac8:c4e:: with SMTP id l14mr736301qti.106.1593442204478;
        Mon, 29 Jun 2020 07:50:04 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 16sm31099qkv.48.2020.06.29.07.50.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:50:04 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TEo3R1006195;
        Mon, 29 Jun 2020 14:50:03 GMT
Subject: [PATCH v2 1/8] svcrdma: Fix page leak in svc_rdma_recv_read_chunk()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:50:03 -0400
Message-ID: <20200629145003.15024.82869.stgit@klimt.1015granger.net>
In-Reply-To: <20200629144802.15024.30635.stgit@klimt.1015granger.net>
References: <20200629144802.15024.30635.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit 07d0ff3b0cd2 ("svcrdma: Clean up Read chunk path") moved the
page saver logic so that it gets executed event when an error occurs.
In that case, the I/O is never posted, and those pages are then
leaked. Errors in this path, however, are quite rare.

Fixes: 07d0ff3b0cd2 ("svcrdma: Clean up Read chunk path")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 5eb35309ecef..83806fa94def 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -684,7 +684,6 @@ static int svc_rdma_build_read_chunk(struct svc_rqst *rqstp,
 				     struct svc_rdma_read_info *info,
 				     __be32 *p)
 {
-	unsigned int i;
 	int ret;
 
 	ret = -EINVAL;
@@ -707,12 +706,6 @@ static int svc_rdma_build_read_chunk(struct svc_rqst *rqstp,
 		info->ri_chunklen += rs_length;
 	}
 
-	/* Pages under I/O have been copied to head->rc_pages.
-	 * Prevent their premature release by svc_xprt_release() .
-	 */
-	for (i = 0; i < info->ri_readctxt->rc_page_count; i++)
-		rqstp->rq_pages[i] = NULL;
-
 	return ret;
 }
 
@@ -807,6 +800,26 @@ static int svc_rdma_build_pz_read_chunk(struct svc_rqst *rqstp,
 	return ret;
 }
 
+/* Pages under I/O have been copied to head->rc_pages. Ensure they
+ * are not released by svc_xprt_release() until the I/O is complete.
+ *
+ * This has to be done after all Read WRs are constructed to properly
+ * handle a page that is part of I/O on behalf of two different RDMA
+ * segments.
+ *
+ * Do this only if I/O has been posted. Otherwise, we do indeed want
+ * svc_xprt_release() to clean things up properly.
+ */
+static void svc_rdma_save_io_pages(struct svc_rqst *rqstp,
+				   const unsigned int start,
+				   const unsigned int num_pages)
+{
+	unsigned int i;
+
+	for (i = start; i < num_pages + start; i++)
+		rqstp->rq_pages[i] = NULL;
+}
+
 /**
  * svc_rdma_recv_read_chunk - Pull a Read chunk from the client
  * @rdma: controlling RDMA transport
@@ -860,6 +873,7 @@ int svc_rdma_recv_read_chunk(struct svcxprt_rdma *rdma, struct svc_rqst *rqstp,
 	ret = svc_rdma_post_chunk_ctxt(&info->ri_cc);
 	if (ret < 0)
 		goto out_err;
+	svc_rdma_save_io_pages(rqstp, 0, head->rc_page_count);
 	return 0;
 
 out_err:

