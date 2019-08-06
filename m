Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4542835EC
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbfHFPzI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:55:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33075 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732048AbfHFPzI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:55:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id q20so93589680otl.0;
        Tue, 06 Aug 2019 08:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=KMCsTKnjDC0yhs5pGeYjUP1ynU13DMy9E9+Qqa84ti4=;
        b=EEU+3/rv8tn3+/z+WH8q8Rl23ERXjJWfAVRTCX/omy6vwAyF3d8schY9wZ/TqINytJ
         KAZPXWmMlglGMSgTR9kFyFaSp4POuTVuVp2OMp7JG41kyoCMhUqYsjIwHGkWxqRNZJ08
         g9fxPa7hknjIx6mvHuqh7sz2Te478mNptsIDWhQ3ZSXjm/Tur/ZOGiZXsdSSxxztuCJF
         /uNONgjdcXmxZ6QlW2M5+p+OuVke2BiM5wipFcZcRf5W/oakGhZYmRVb63bxl1x1c1kd
         kZbtfGNsQBjlizkoAwlGTLkH2To8Ch28PGBXXYFer2evzm4+pFVE3zoqpMlEFQJXh7yt
         xCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=KMCsTKnjDC0yhs5pGeYjUP1ynU13DMy9E9+Qqa84ti4=;
        b=bNFa3RoDcZeZVojkGaXdZ/AamGDuS3VgViY8xPBvqZpG4ohY+NwLR/K3kZH/8/sKUX
         CpdSWP0XKbbSU+MSnsSPjxLFtHnP1GAUKRLVWqR1ty5h2OIqoWD+7YzQlPtr5BsXqFWU
         jLP0JoI2C6c40zNJCtgTJtlmeeOHG4E+L/C6oaLdyTFLq1H5Vf1KeCW2u7IBtMzVYtWF
         GK+enm9iW7U7Y3n1akJ6ZC2oXZXC/zpJmcITOBoV/HTagJJMJRdOAN+gjwSwiymjUq1U
         8Znf28b9cOMcDKCIk1SjH95X2rjZ8sKYiJ05v5SRX7PICHvG2IvQRn8vLo+LZuiJ8Aiy
         LSIw==
X-Gm-Message-State: APjAAAUNZbWlxYFcQfrJ+7VUJGwc56U4P/S8PE0YRAuAKgoIQCPP4UJX
        T5K81o0a8AwcdTBpUQFpZ9DfwHgF
X-Google-Smtp-Source: APXvYqwECAB7MDbSMDtSJQ8HZaTGUvM5h+c62mPcb1yOMcAgc0gK0kqlT7Ae/TcYjYYRvNO7/PQU+Q==
X-Received: by 2002:a6b:6b02:: with SMTP id g2mr4380662ioc.13.1565106907371;
        Tue, 06 Aug 2019 08:55:07 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b3sm73442582iot.23.2019.08.06.08.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:55:06 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76Ft6Wt011556;
        Tue, 6 Aug 2019 15:55:06 GMT
Subject: [PATCH v1 15/18] xprtrdma: Clean up xprt_rdma_set_connect_timeout()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:55:06 -0400
Message-ID: <20190806155506.9529.9998.stgit@manet.1015granger.net>
In-Reply-To: <20190806155246.9529.14571.stgit@manet.1015granger.net>
References: <20190806155246.9529.14571.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: The function name should match the documenting comment.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/transport.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index f4763e8..993b96f 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -494,9 +494,9 @@ void xprt_rdma_close(struct rpc_xprt *xprt)
  * @reconnect_timeout: reconnect timeout after server disconnects
  *
  */
-static void xprt_rdma_tcp_set_connect_timeout(struct rpc_xprt *xprt,
-					      unsigned long connect_timeout,
-					      unsigned long reconnect_timeout)
+static void xprt_rdma_set_connect_timeout(struct rpc_xprt *xprt,
+					  unsigned long connect_timeout,
+					  unsigned long reconnect_timeout)
 {
 	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
 
@@ -805,7 +805,7 @@ void xprt_rdma_print_stats(struct rpc_xprt *xprt, struct seq_file *seq)
 	.send_request		= xprt_rdma_send_request,
 	.close			= xprt_rdma_close,
 	.destroy		= xprt_rdma_destroy,
-	.set_connect_timeout	= xprt_rdma_tcp_set_connect_timeout,
+	.set_connect_timeout	= xprt_rdma_set_connect_timeout,
 	.print_stats		= xprt_rdma_print_stats,
 	.enable_swap		= xprt_rdma_enable_swap,
 	.disable_swap		= xprt_rdma_disable_swap,

