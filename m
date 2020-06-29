Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4457F20D8FF
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2020 22:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbgF2TnL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jun 2020 15:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387987AbgF2Tmo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jun 2020 15:42:44 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DAAC02F01E;
        Mon, 29 Jun 2020 07:53:35 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h23so13078965qtr.0;
        Mon, 29 Jun 2020 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=wFVwyNCgjV5GfknDobkswqyylZf/i/Wgt7cXVz0sdAs=;
        b=n+Vq4WmF5masHdlZJDHwcKXKjE6AQcb+ozsTWP4EUyO0xXvRcDdpG+SwWxWaXpbGxX
         dCCe8sIwBEnV5//tmUzL1d297DYvgVrGnGdE2RJe1/VjONBJJmMiBqEeQrFmnZthUwyF
         yY4+hcyOpE1IDG+n2G+f+s7yHj1sZ/S9GrfAuE3XCmH33ZB0SFVyySwUlXM2AP/WLsw6
         fXtmEMEEcRR7v/HpeqoMpaBKJEweQWi8JuLYRM8tiHVIQDmMqwlQaHp50pTvnReRHlcL
         Pqy102iTqNaR/VaEs5i1TkDadVu7gM6eCRuVp7xlPaMyl+7e8AiMUDtn2r5pUcV17A3S
         PTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=wFVwyNCgjV5GfknDobkswqyylZf/i/Wgt7cXVz0sdAs=;
        b=KvaYTSdcgooBgz+AJ0A9JwmaqPhvYudsKf5i0QBTmFLUInKUmfG4S+stT97e9V8DSc
         XNuEem4Rcsgf44c6owtQ3QeU+yfx5/y+yX9dtTa7+VJHSY1Bs9VXNESaJdn0z0boxpNh
         AFBaAGacVYjknLLn3P8Aqmw32JxkaU6pNKXwPcbvGnxM6Jizd/IIceI9BZfdYi/rB5gf
         YSuFcWX1sGUhvSX0WL70brkwrhgsjzLKVtGZA5ghsxuZ5fkkpVVlwfcUVSA4wwaKjiPR
         En5XQTDAKHnYBbPSCg9c0+pPo++iI19zbq54fG9ZpCuYE/23BhD0htPkjFXoJHFHqPP9
         SHKg==
X-Gm-Message-State: AOAM532xTtZQQHzLpG3KJuVSahBTB2IvUhds0jLrYdhiF2DiQKqMzgCK
        dt/Pc3zPrLad21MnRPmydFJjsCzO
X-Google-Smtp-Source: ABdhPJxaiXFOg39RYKPyGgnyqHtpd8BZQZr8J5+b5H2gVbeA2ATl/3ln2xLALo/m6rzT+U1S5Hr1Yg==
X-Received: by 2002:aed:2b82:: with SMTP id e2mr16209605qtd.143.1593442414504;
        Mon, 29 Jun 2020 07:53:34 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q18sm51232qkq.20.2020.06.29.07.53.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 07:53:34 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05TErXN0006224;
        Mon, 29 Jun 2020 14:53:33 GMT
Subject: [PATCH v1 1/4] svcrdma: Remove declarations for functions long
 removed
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jun 2020 10:53:33 -0400
Message-ID: <20200629145333.15063.42265.stgit@klimt.1015granger.net>
In-Reply-To: <20200629145150.15063.29447.stgit@klimt.1015granger.net>
References: <20200629145150.15063.29447.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Pavane pour une infante défunte.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 1579f7a14ab4..d28ca1b6f2eb 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -204,10 +204,6 @@ extern int svc_rdma_read_payload(struct svc_rqst *rqstp, unsigned int offset,
 				 unsigned int length);
 
 /* svc_rdma_transport.c */
-extern int svc_rdma_create_listen(struct svc_serv *, int, struct sockaddr *);
-extern void svc_sq_reap(struct svcxprt_rdma *);
-extern void svc_rq_reap(struct svcxprt_rdma *);
-
 extern struct svc_xprt_class svc_rdma_class;
 #ifdef CONFIG_SUNRPC_BACKCHANNEL
 extern struct svc_xprt_class svc_rdma_bc_class;

