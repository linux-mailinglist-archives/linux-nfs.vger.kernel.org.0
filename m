Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676561E91A7
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgE3NaN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbgE3NaM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:30:12 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF36C03E969;
        Sat, 30 May 2020 06:30:12 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id o5so2279690iow.8;
        Sat, 30 May 2020 06:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=evqbXYcf6/+V1zpemgbj/MCtZRI2OaQ36IjfxbVRrtY=;
        b=oz1uf6kr7oNg270Gm1k2S6JpZoCnOeunupVE7l/S3zonOmouy+BgGH+wGc+6jlSKkR
         Y6BsPQ0Z6SngZXRi+uVHbU4rj9dUGiuNRJ+1hWKs7XXVdnIAidRiAQqIhxQI19ZrZ0d4
         3HkPtDRlOZ+TPuCRSK1Hxpw7SgELyVQrpxenX1WD47Vytd+8mdAc6Tm3qcNmRX1xJcSl
         XgUfCUbWyeQy/B36zKeazjMlCW7LMoF5KX/b4kpyH6Ed3uTD3t7pYhtHW3Mki1e3dYxl
         s+nxWkzV24ZLv449XxZJVgdUfr01AMyBeaWL+B8ujgh3fHrXJJFQKyo1oLTOaw8VV+yg
         y+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=evqbXYcf6/+V1zpemgbj/MCtZRI2OaQ36IjfxbVRrtY=;
        b=c8W8lsCtas2U9jRgQnt+U9DzX4EDhcK7H3oIp+npuZJZJm5UZQpc+Hz/d5ihUZPqY2
         EPsaSbEBBIyrEbXv+FhVvsMq9Y+u8GfptABppRQOQufatNHh13kEnDQcJ81hJkISILsn
         vTbL+bXHGh676Pd73PisfDMAy6AUPiXMQdRqnNB5iP+TyVQs4Lcz2qvl9A3jdL5iUUes
         b2rjT4Jui/7dTnpbofgxmwX8fWWYfb1cL66jRMalj3oKNYpa8dKgzwEZHh36ruI9UtJT
         dQSCfL4/9dF+WvRoECuOKP/cS+qBoDwqunanHH6S62v85LPDwpFca4SncJK3Szsdm0fl
         Xj+Q==
X-Gm-Message-State: AOAM532jEb6T9EgVnduDqZ15yPkgBKHEJiukKhVA76NLqWNpQBEBxrJN
        FtGnZmLnsunPQWV0gIr4vIBGr9kV
X-Google-Smtp-Source: ABdhPJxiNMi/WGtRQehst2ea9ZkrMbRjc7QfPympcRhoRpd76HnoxIaYkqEpA/tHpsld5+Fo1nSgIg==
X-Received: by 2002:a05:6602:2fcb:: with SMTP id v11mr11140696iow.121.1590845411925;
        Sat, 30 May 2020 06:30:11 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r9sm6278587ilm.10.2020.05.30.06.30.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:30:11 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDUAmi001465;
        Sat, 30 May 2020 13:30:10 GMT
Subject: [PATCH v4 24/33] SUNRPC: Clean up svc_release_skb() functions
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:30:10 -0400
Message-ID: <20200530133010.10117.37921.stgit@klimt.1015granger.net>
In-Reply-To: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
References: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
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

