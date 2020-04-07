Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C087F1A159E
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2020 21:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgDGTLF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Apr 2020 15:11:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:47039 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGTLF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Apr 2020 15:11:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id g74so510156qke.13;
        Tue, 07 Apr 2020 12:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=B89KhKI3dBPR7z9BrJ0Gc3y7hT1W0vJQLGSA4yPn/XM=;
        b=l2kF6juPKSTAmuhhzdaoWd8z3TXs7fPPDtA9rxxf3IFO/6jA4Gdf1m3Zvmf1wFkTAs
         YTqB2SXETsSpXSydGrEJQnzhZzuUd2Y8HlYQuCGxUQKHKWA3LwyXgdIOASfkERfRpIJ0
         MDxFDwLuOfE83fGf6+KvIJQIhqntX9mJpCVCf6UprrcgX6GOLeO/zp7ohULZ1Ktol4Rn
         90MtgV+1SVpbPxCLuwaUwL/1RUXrtH4WGDaairNULWxhSgFDYNEKScv+OFO0yGvPJG7y
         il3bhBbax0HBPofK/egwi8SoqsJpz8irtkFvt0p33KkZi7nv70yF0YDil3gjq7LKXacm
         XzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=B89KhKI3dBPR7z9BrJ0Gc3y7hT1W0vJQLGSA4yPn/XM=;
        b=C8fdPaBanY2Ry9xvS1VvM/8Q5mgMMJvHQhozOJm2qvMSW67cFwRYfDHO9xmnAf00z3
         6/7GfulOiiRfhDs8946FpjJNIoXTjyO5Szb1KhXtrXdc62J/CGmyiI/Rd6W2yrGwwHgY
         EUfnI7/byp/h/zmv3Kzz5NwsF3oV4qqjNXPoO1uD69bjWAWlEbRwVP0qbAIf8UhQ9bTV
         jC8jgQ64Fgomw9TEbP4/j5mf6wTudh8vQ+/8JgemGW2UtjWoxK8TLoqYB1Xk49GWDQ/n
         /xfWPQCtU03+kBUXjKVmYKBmlg1C8DrE8yEbQEUul7O6N4u4tCC+ZkQAPhAZkOLXpXT/
         gCnQ==
X-Gm-Message-State: AGi0PuYVa6r0lA6T/eQOn5zKzfhDQ8RtHwsx//YDe3fFJ6ZIHDDXmjn6
        NmGsPahT4T4E0Sdd7JCE/pTC82cb
X-Google-Smtp-Source: APiQypLwsgN3WNjIKtRIxIB/BHslu7LDPoajAVrAsv6qp0ZagttyuOF85jzagZy+gJqzOwikK6nidg==
X-Received: by 2002:a05:620a:48:: with SMTP id t8mr3840079qkt.21.1586286663354;
        Tue, 07 Apr 2020 12:11:03 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g63sm13384201qkb.89.2020.04.07.12.11.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 12:11:02 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 037JB1rb010261;
        Tue, 7 Apr 2020 19:11:01 GMT
Subject: [PATCH v1 2/3] SUNRPC: Remove naked ->xpo_release_rqst from
 svc_send()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 07 Apr 2020 15:11:01 -0400
Message-ID: <20200407191101.24045.10662.stgit@klimt.1015granger.net>
In-Reply-To: <20200407190938.24045.64947.stgit@klimt.1015granger.net>
References: <20200407190938.24045.64947.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-8-g198f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: Instead of making two transport method calls in
svc_send(), fold the ->xpo_release_rqst call into the
->xpo_sendto method of the two transports that need this extra
behavior.

Subsequently, svcrdma, which does not want or need the extra
->xpo_release_rqst call can then use ->xpo_release_rqst properly.

This patch does not fix commit 3a88092ee319 ("svcrdma: Preserve
Receive buffer until svc_rdma_sendto"), but is a prerequisite for
the next patch, which does fix that commit.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc_xprt.c |    3 ---
 net/sunrpc/svcsock.c  |    4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 92f2c08c67a5..2284ff038dad 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -908,9 +908,6 @@ int svc_send(struct svc_rqst *rqstp)
 	if (!xprt)
 		goto out;
 
-	/* release the receive skb before sending the reply */
-	xprt->xpt_ops->xpo_release_rqst(rqstp);
-
 	/* calculate over-all length */
 	xb = &rqstp->rq_res;
 	xb->len = xb->head[0].iov_len +
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 519cf9c4f8fd..023514e392b3 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -527,6 +527,8 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 	unsigned int uninitialized_var(sent);
 	int err;
 
+	svc_release_udp_skb(rqstp);
+
 	svc_set_cmsg_data(rqstp, cmh);
 
 	err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, 0, &sent);
@@ -1076,6 +1078,8 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 	unsigned int uninitialized_var(sent);
 	int err;
 
+	svc_release_skb(rqstp);
+
 	err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, marker, &sent);
 	xdr_free_bvec(xdr);
 	if (err < 0 || sent != (xdr->len + sizeof(marker)))

