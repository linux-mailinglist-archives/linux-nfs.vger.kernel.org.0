Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F46204250
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2020 23:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgFVVBI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Jun 2020 17:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbgFVVBH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Jun 2020 17:01:07 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9299DC061573;
        Mon, 22 Jun 2020 14:01:07 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id u8so1599025qvj.12;
        Mon, 22 Jun 2020 14:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Xqol0YYHpEvswBoUVlP6v8tsfvVQp+w5nGY/v7Hvy2s=;
        b=ExLEv35MNMsw8UbV3X40MXkpBk0iE1XQEej76A7Jh2C0die6PCERb5maLCyePmxLbM
         fCMUXpFBvNoLUn5s/b71vbulfopgLek+1FbahMPpTkKaQaFT7dPeDCooltdK/dD2bOnG
         fJp2DhiQiZ+8rIkOrn2eo07mrxVsmcl/kUUCezK9W3vYUHil3mF6j3OT9fyI+FUV4SJ0
         w/eze16uqMm6kQFf8V4gW45eslKaiQZ3JrsirTLswI50fOAtOmg8YAcQfyLC3a26+zC6
         08SlnnR28ylGxDNhQGNckNNJrHggaXXIFqaupN0mGXxSM3XcNuYe/sNPdr3MA5Pz0bdd
         IPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Xqol0YYHpEvswBoUVlP6v8tsfvVQp+w5nGY/v7Hvy2s=;
        b=fiJeilv/7OibkNVSim9NE5aWBUKixGl+AIjsEYC7AtmyFjkLGRBwBy2M/f8mwhMNOS
         OMqmO/HhWaRwptXVZ90kyVLvqeUAa2xAoke0TEfapYZDSJBtDOfWMxWhdU0L9MTEvBnF
         ad2+tnp80kEPVGrQQO9pEbj/jACCm4uEaMiXEo/V+1u+aH+b/w7G7VdE6KOjsRTFGXEq
         foGFLgiVjbZJAHV/VvP59PGuSljSl80L+mZinMygbOstPWSHqbgMThksVTNNunfoitOC
         9vwNLgS9gHZ8DpYZpgoU0mOFlp30IhkfLok63FGmWtgnW6Tsf90c1hdjGzyMY9Zi/yPY
         kyog==
X-Gm-Message-State: AOAM5339NT2DTceHodzYz5fLKfSaq7luhb2Uq1HijpmwonBJJXnoSm7J
        93ioCIJZG9nQgCZQhn37I1mXeZhI
X-Google-Smtp-Source: ABdhPJzVbg9n2ESXM1FuwWOYYmeCUjiy7C54nmCXusxXpTVhdHo9LJVbwgPpcZIdf4HMPYMzD9C1TQ==
X-Received: by 2002:a0c:dc8c:: with SMTP id n12mr8081862qvk.221.1592859666523;
        Mon, 22 Jun 2020 14:01:06 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w204sm14980202qka.41.2020.06.22.14.01.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 14:01:06 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05ML15cQ018822;
        Mon, 22 Jun 2020 21:01:05 GMT
Subject: [PATCH v1 1/6] svcrdma: Fix page leak in svc_rdma_recv_read_chunk()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 22 Jun 2020 17:01:05 -0400
Message-ID: <20200622210105.2144.36726.stgit@klimt.1015granger.net>
In-Reply-To: <20200622205906.2144.43930.stgit@klimt.1015granger.net>
References: <20200622205906.2144.43930.stgit@klimt.1015granger.net>
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

