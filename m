Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142C01DD006
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgEUOfs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgEUOfs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:35:48 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4F1C061A0E;
        Thu, 21 May 2020 07:35:46 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d7so7678549ioq.5;
        Thu, 21 May 2020 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=evqbXYcf6/+V1zpemgbj/MCtZRI2OaQ36IjfxbVRrtY=;
        b=BbSIYBJKmiFmP//XB3rxzcZwoyI3xtV6Li49d1nIjHhyRdtF4YRMGfSsqE0Y8y/21M
         0fWSdME+2vKCOtGSSxbjgW7+L5t1OJQ/ludSh+UaJiRV/E42K5dleBhCnwmlWBkZ/H1o
         hsCdBQfoSGeNt29uDJ9QH7fLdz7A4HHnqrWtUaNrfzMmCCDckX5mkibDj/rQBfXdXhZj
         36lw569odl+oJuIqJN9lfRi9p9Sk3sjT51ZpAGR/+hMFl8hJRGpsJ8ZS9AOJamn0NWla
         x3LlisGPDweyFLskdZ2Fa3T3f9inxECecM1Of9tzQxYBofaYSQ9x2wTbNcDwDrTlnZJ6
         yhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=evqbXYcf6/+V1zpemgbj/MCtZRI2OaQ36IjfxbVRrtY=;
        b=Jx0z4QczJb2KL7LkH5pNwh/dypf+3tnfQAk4wjCw0FihBhYsVvHTiA4t9JKqxlxXEE
         xyyc1PAfK/DnBKjwxn3Yvz3Y3Kh4YSbJlP+uV2AV1WljZam5E6+YBWaFv33Sk3kI6rjE
         cabM8ogF4iDGFSte1eUFbCKVTOlVtUg2LaRerZrh+P+KIdvyRfHk7A/D+mkR09Ytp4kE
         z2nCBLGKBr8DhEeVk8ZgWameyOwnHsfIm9DLHCwYlPpXqMsa2CsUwtENgMhBePIIuIEp
         p+QWMsvvrGOcpc/R8KHazze2VaOqS8PFE4Jp29Svlu30zl2ufXJoKG2XTzDu+0nImQUg
         pkhQ==
X-Gm-Message-State: AOAM530OoK3Cv0jN0x2RReK8x/AMxY9m5uYOqLFuSqCLSk/s1BPmd3iV
        5XsEPgZyunyj+53V3oZM/xpjaVsC
X-Google-Smtp-Source: ABdhPJxxTrAurkw4CIJoEQh+dPQUOlCLQAbrXHtdJTMo1JRtmfpafybIJOj9AcQn4iX1fL2aTAUQJg==
X-Received: by 2002:a02:84e4:: with SMTP id f91mr4104244jai.79.1590071746001;
        Thu, 21 May 2020 07:35:46 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q78sm3089267ilb.25.2020.05.21.07.35.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:35:45 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEZibt000901;
        Thu, 21 May 2020 14:35:44 GMT
Subject: [PATCH v3 23/32] SUNRPC: Clean up svc_release_skb() functions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:35:44 -0400
Message-ID: <20200521143544.3557.87703.stgit@klimt.1015granger.net>
In-Reply-To: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
References: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Rename these functions using the convention used for other xpo
method entry points.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 087e21b0f1bb..5b2981a0711c 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -109,10 +109,12 @@ static void svc_reclassify_socket(struct socket *sock)
 }
 #endif
 
-/*
- * Release an skbuff after use
+/**
+ * svc_tcp_release_rqst - Release transport-related resources
+ * @rqstp: request structure with resources to be released
+ *
  */
-static void svc_release_skb(struct svc_rqst *rqstp)
+static void svc_tcp_release_rqst(struct svc_rqst *rqstp)
 {
 	struct sk_buff *skb = rqstp->rq_xprt_ctxt;
 
@@ -125,7 +127,12 @@ static void svc_release_skb(struct svc_rqst *rqstp)
 	}
 }
 
-static void svc_release_udp_skb(struct svc_rqst *rqstp)
+/**
+ * svc_udp_release_rqst - Release transport-related resources
+ * @rqstp: request structure with resources to be released
+ *
+ */
+static void svc_udp_release_rqst(struct svc_rqst *rqstp)
 {
 	struct sk_buff *skb = rqstp->rq_xprt_ctxt;
 
@@ -521,7 +528,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 	unsigned int uninitialized_var(sent);
 	int err;
 
-	svc_release_udp_skb(rqstp);
+	svc_udp_release_rqst(rqstp);
 
 	svc_set_cmsg_data(rqstp, cmh);
 
@@ -590,7 +597,7 @@ static const struct svc_xprt_ops svc_udp_ops = {
 	.xpo_recvfrom = svc_udp_recvfrom,
 	.xpo_sendto = svc_udp_sendto,
 	.xpo_read_payload = svc_sock_read_payload,
-	.xpo_release_rqst = svc_release_udp_skb,
+	.xpo_release_rqst = svc_udp_release_rqst,
 	.xpo_detach = svc_sock_detach,
 	.xpo_free = svc_sock_free,
 	.xpo_has_wspace = svc_udp_has_wspace,
@@ -1053,7 +1060,7 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 	unsigned int uninitialized_var(sent);
 	int err;
 
-	svc_release_skb(rqstp);
+	svc_tcp_release_rqst(rqstp);
 
 	mutex_lock(&xprt->xpt_mutex);
 	if (svc_xprt_is_dead(xprt))
@@ -1093,7 +1100,7 @@ static const struct svc_xprt_ops svc_tcp_ops = {
 	.xpo_recvfrom = svc_tcp_recvfrom,
 	.xpo_sendto = svc_tcp_sendto,
 	.xpo_read_payload = svc_sock_read_payload,
-	.xpo_release_rqst = svc_release_skb,
+	.xpo_release_rqst = svc_tcp_release_rqst,
 	.xpo_detach = svc_tcp_sock_detach,
 	.xpo_free = svc_sock_free,
 	.xpo_has_wspace = svc_tcp_has_wspace,

