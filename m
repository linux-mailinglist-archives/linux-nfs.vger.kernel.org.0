Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71D8495123
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfHSWtw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:49:52 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40453 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHSWtw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:49:52 -0400
Received: by mail-oi1-f196.google.com with SMTP id h21so2617442oie.7;
        Mon, 19 Aug 2019 15:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=sa44db4rf5pgBQCqMZ77sm8NvSn2T4kdYjbQifvbiGM=;
        b=CdgpGeLSgTnaWtglBd8rWGa1Nj6zfw6ULmn7Fc4I/TiF81OZHMDRZXrQjJ4/cySGSp
         50gF8p645rmHxVp5YtHSM4YLVfBK9sEtG6AU8oRGooBl6HazhsWPbQUzd2pMFydguVux
         yNTWBuNeXXcUCTvjoh5Q8OPdYTBFcsyZo/C+VFJQhKch09NJwxvxc+y6LcEUtrNx0FKH
         0f+h82gARixFh9NrKBd1UJjARMkFLO8h1WrJGYjEVfdo+gcLWLXTAKKPGL45yDp6pjds
         6VXF7mvNawJRmOkEwQI8vGuIj4PPTf2PYj9DbBqX9TrkidZKmODD4LwkSWoWgk0JG91s
         fffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=sa44db4rf5pgBQCqMZ77sm8NvSn2T4kdYjbQifvbiGM=;
        b=TjuxBs0IsrlAM5tDrvqVtbVqJQONk+gRZfhKimIfQWgq80AAlKH4RseJ+XdWpEWaAr
         2xt6TDN/xyW1n+luNwr2hJgYV07fLzhLAugg8Mp5xTLFy6zdYUd53dWepZyHCijfuK6C
         YnYwa5sqVJYzJdV3SnKtDtp5w5ZTz5dOW5y2UpkKeIEGz1kGHqHdt8AYxTXaHx1pkx/M
         MY1BdRlZjX65hr9aLlgs4+NGcf0Qs5OQSD2lf/FHHtNLnqU6DTWz/yEMbhM/+sJ2/MpJ
         U9g8qTrRbfpE/DOuzJM+ETcgACnyN1nJB2hTMNEDYedbDdZMeerG5WicH60wAmjRSvVW
         m+Mw==
X-Gm-Message-State: APjAAAWZALt6LttZjXYkTSK7+j67UIVKFT4Ol3vthr0XhReLUWv5WYJq
        W/ju+oNCe8RgWIIq2rlgn/AS0W/7
X-Google-Smtp-Source: APXvYqw6qZFPcALrR8AyC9WLJ0Lk3fSBFmBg1MajT4YBT2/MsKEaHThovtg81OXkFvBPwrskPGQjqQ==
X-Received: by 2002:aca:37c5:: with SMTP id e188mr14292607oia.66.1566254991522;
        Mon, 19 Aug 2019 15:49:51 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id t18sm5848187otk.73.2019.08.19.15.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:49:51 -0700 (PDT)
Subject: [PATCH v2 18/21] xprtrdma: Clean up xprt_rdma_set_connect_timeout()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:49:30 -0400
Message-ID: <156625495023.8161.16052575877778151008.stgit@seurat29.1015granger.net>
In-Reply-To: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
References: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
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
index f4763e8a6761..993b96ff6760 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -494,9 +494,9 @@ xprt_rdma_timer(struct rpc_xprt *xprt, struct rpc_task *task)
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
 
@@ -805,7 +805,7 @@ static const struct rpc_xprt_ops xprt_rdma_procs = {
 	.send_request		= xprt_rdma_send_request,
 	.close			= xprt_rdma_close,
 	.destroy		= xprt_rdma_destroy,
-	.set_connect_timeout	= xprt_rdma_tcp_set_connect_timeout,
+	.set_connect_timeout	= xprt_rdma_set_connect_timeout,
 	.print_stats		= xprt_rdma_print_stats,
 	.enable_swap		= xprt_rdma_enable_swap,
 	.disable_swap		= xprt_rdma_disable_swap,

