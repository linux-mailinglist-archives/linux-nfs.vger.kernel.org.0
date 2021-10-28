Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AE443E8EF
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Oct 2021 21:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhJ1TUL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Oct 2021 15:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhJ1TUL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Oct 2021 15:20:11 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A67C061745
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 12:17:43 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id bm16so6887148qkb.11
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bUMmBDuvazjnRFzGmhl9mar6u+kQn+MoU5reptHpBck=;
        b=LfOcChOW4nIIXUWCNMvpWx4y7LQ7EJsLQTqZZh2nmZvsauFV4LJv9J0K+jfd6NzXnB
         xygDRH2UxhTbhrmYrGqOI+DwtpwzafvznKyKuaoGryNa/5pIkg8EhG9ODEttjGU0TFq0
         ILMenQVZWcEfmnz/bdpzeSSH7q18PGD9SLvHS2U1wmKTu8Ccu0VQj4+RfGyIutHpmjRC
         uP3LWDrYRLv8naye+YbvTGhjtx8JiV+bvpi5Zb0YCx8zIaP2sce1014UsTbwbME/UyUo
         tFnNZAxiJUqr8Ys+AbGVsikGKUkxJVxPpCgyAKP8Gsn+CLAJtoEJkDpM85PQz5nqrAIL
         cEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=bUMmBDuvazjnRFzGmhl9mar6u+kQn+MoU5reptHpBck=;
        b=yZZWOvz/TO4Z5i1pD/H4vrK4xq6ZWgQL1pFwgT4AIYJ2necesBBYKVwQKs1IZQh8gS
         wHEpC9nyaNjCbIB4fW8kBcDACBwm6rbqS5ofLIKQHWq3QIYCdDpA5Hz4ty060jhNQkHY
         c+CE9QAyU0cvpLZD/r6xdGcQ6+yDBRgJoillOyDBDI9KN54XjTvrcczul7fb3g1Oixfv
         bIf6XKsGBbha76hw0ouC9MBH9zglzjbR9GStPFCs2hD+7ac32+duMu5yS+fF4YtnpUyb
         cnJpBsgd5V8wHUsRAGZXoiV8iMHzd3rfbg8aLPDQRp32NnEgoA5emb3/7dCZJPL2vTY6
         2/dw==
X-Gm-Message-State: AOAM532xwmw41wS84tRv6nbCrfJ6NLmbVKHFnFxuALgi2jhX3Se9rMlo
        zjqpNL1qEg6vDxHYGINYMYzKs8lTOD8=
X-Google-Smtp-Source: ABdhPJzy0hCH6ie6ZgmiRBYnCCmW7hQmZ1YXcrXuY5ozHrX5ygrqJTKVVXSt8LfbrSDrW3gq5odZNA==
X-Received: by 2002:a05:620a:25c8:: with SMTP id y8mr5199276qko.42.1635448662946;
        Thu, 28 Oct 2021 12:17:42 -0700 (PDT)
Received: from gouda.nowheycreamery.com ([2601:401:100:a3a:aa6d:aaff:fe2e:8a6a])
        by smtp.gmail.com with ESMTPSA id j20sm2691985qtj.72.2021.10.28.12.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 12:17:42 -0700 (PDT)
Sender: Anna Schumaker <schumakeranna@gmail.com>
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2] SUNRPC: Check if the xprt is connected before handling sysfs reads
Date:   Thu, 28 Oct 2021 15:17:41 -0400
Message-Id: <20211028191741.167215-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

xprts don't immediately reconnect when changing the "dstaddr" property,
instead this gets handled the next time an operation uses the transport.
This could lead to NULL pointer dereferences when trying to read sysfs
files between the disconnect and reconnect operations. Fix this by
returning an error if the xprt is not connected.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
v2: Call xprt_put() on the xprt before returning
---
 net/sunrpc/sysfs.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 9a6f17e18f73..2766dd21935b 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -109,8 +109,10 @@ static ssize_t rpc_sysfs_xprt_srcaddr_show(struct kobject *kobj,
 	struct sock_xprt *sock;
 	ssize_t ret = -1;
 
-	if (!xprt)
-		return 0;
+	if (!xprt || !xprt_connected(xprt)) {
+		xprt_put(xprt);
+		return -ENOTCONN;
+	}
 
 	sock = container_of(xprt, struct sock_xprt, xprt);
 	if (kernel_getsockname(sock->sock, (struct sockaddr *)&saddr) < 0)
@@ -129,8 +131,10 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
 	ssize_t ret;
 
-	if (!xprt)
-		return 0;
+	if (!xprt || !xprt_connected(xprt)) {
+		xprt_put(xprt);
+		return -ENOTCONN;
+	}
 
 	ret = sprintf(buf, "last_used=%lu\ncur_cong=%lu\ncong_win=%lu\n"
 		       "max_num_slots=%u\nmin_num_slots=%u\nnum_reqs=%u\n"
-- 
2.33.1

