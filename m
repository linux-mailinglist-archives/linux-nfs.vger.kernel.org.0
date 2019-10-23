Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7C91E1D9E
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2019 16:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406302AbfJWOCR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 10:02:17 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:39599 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406301AbfJWOCQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 10:02:16 -0400
Received: by mail-il1-f195.google.com with SMTP id i12so8471546ils.6;
        Wed, 23 Oct 2019 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=BNSbq+2+9vAowhp9rev2KXzfkbxO3mbJYjdUCgXqjTQ=;
        b=FNHZVO0nm1/fj/xUOnTNI4jILtzHPJkISgd2O9inUQTZFZ24NbsMBxDynT51NvQ4sL
         RVA4J0pUY3bIcErrD2NvLFeCJe59kyaZjwNMfD8njovtwMcBTYoycsPxaCZrOj0ttbJj
         /gajbdY4QATVQ+xM3HU54FU2izXWoi1sqY/khlOsUMD9G+AYCT2jXH5crXbpwT9eetKg
         1H2c6SklP76ZZugcEfNbtzLc9qMI6zasgGTsvCuhs3tEloAXBI8uLbvAQGgZ7hYju1Gw
         PTDyT74b8uCOGDmVgtdNEtSUstXvRmOyatRjkpd6CqfBQy6IjyZzmjpNSjfjip7uSB77
         SZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=BNSbq+2+9vAowhp9rev2KXzfkbxO3mbJYjdUCgXqjTQ=;
        b=WYbfY31SjQUTyiizHyaWqsR3+dUee5EXzMUr1zPQqRhg3docpXQn6CIM/LPaSoyPGe
         4LDj1bITUgA5CAl9yb27Nd0j2dASbRFqsFKb9lYisUgrXALFIQk2Jp10g5jGhSJC6eNS
         yRDoO2cssxkA5LaWY/U8aEeTQOWxtwpKMQcfleDbZoMyZwWO1mV5HL9jkEiNs+4yV2St
         jKXJQR+ywGJ4mGhcXWVhwZ4OUFrRGZJ1zPMCl2Rfl/SBnSBMRHcHp/1r+Jia+h+QPqIp
         mA9ey0ltVrTXJP4XsxF4bJbr/gpLlgEved3AnROf92Lv/Kii+EvegNFg2WcbH+Hbiaop
         XIRw==
X-Gm-Message-State: APjAAAVitQB/0oRKPqMYZlVVyCf1RADCeK1eaH8xFI5wZBJ3UYTKMqx6
        YJJC+S8kJo4yIx0+c9sRb5fYFrOd
X-Google-Smtp-Source: APXvYqzE4FDFBeVsEOu58pes9j3a3ovxX0jODvxcoClU/ALHDGL4Sn9eyUZA8/14ckp812sGHdDNuw==
X-Received: by 2002:a92:ce11:: with SMTP id b17mr5204346ilo.119.1571839335971;
        Wed, 23 Oct 2019 07:02:15 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j6sm7694505ilr.2.2019.10.23.07.02.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 07:02:15 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x9NE2EWk012554;
        Wed, 23 Oct 2019 14:02:14 GMT
Subject: [PATCH v1 5/5] xprtrdma: Replace dprintk in xprt_rdma_set_port
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 23 Oct 2019 10:02:14 -0400
Message-ID: <20191023140214.3992.33197.stgit@manet.1015granger.net>
In-Reply-To: <20191023135907.3992.69010.stgit@manet.1015granger.net>
References: <20191023135907.3992.69010.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |    1 +
 net/sunrpc/xprtrdma/transport.c |    9 +++------
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 081831d..1879058 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -416,6 +416,7 @@
 DEFINE_RXPRT_EVENT(xprtrdma_reinsert);
 DEFINE_RXPRT_EVENT(xprtrdma_op_inject_dsc);
 DEFINE_RXPRT_EVENT(xprtrdma_op_close);
+DEFINE_RXPRT_EVENT(xprtrdma_op_setport);
 
 TRACE_EVENT(xprtrdma_op_connect,
 	TP_PROTO(
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index ce263e6..7395eb2 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -441,12 +441,6 @@ void xprt_rdma_close(struct rpc_xprt *xprt)
 	struct sockaddr *sap = (struct sockaddr *)&xprt->addr;
 	char buf[8];
 
-	dprintk("RPC:       %s: setting port for xprt %p (%s:%s) to %u\n",
-		__func__, xprt,
-		xprt->address_strings[RPC_DISPLAY_ADDR],
-		xprt->address_strings[RPC_DISPLAY_PORT],
-		port);
-
 	rpc_set_port(sap, port);
 
 	kfree(xprt->address_strings[RPC_DISPLAY_PORT]);
@@ -456,6 +450,9 @@ void xprt_rdma_close(struct rpc_xprt *xprt)
 	kfree(xprt->address_strings[RPC_DISPLAY_HEX_PORT]);
 	snprintf(buf, sizeof(buf), "%4hx", port);
 	xprt->address_strings[RPC_DISPLAY_HEX_PORT] = kstrdup(buf, GFP_KERNEL);
+
+	trace_xprtrdma_op_setport(container_of(xprt, struct rpcrdma_xprt,
+					       rx_xprt));
 }
 
 /**

