Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078301DCFDA
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgEUOed (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbgEUOed (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:34:33 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D44C061A0E;
        Thu, 21 May 2020 07:34:33 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id 18so7294651iln.9;
        Thu, 21 May 2020 07:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WhwomO42XDAEJPW2/cr+MUt5RrB/mfN0Bet2spmrCJc=;
        b=uxKvdvg4Gkp+py3405Yp3zpc/eZdJN3tomSWdJbetmu/zxnqty8ebH2I4PrDONABbV
         1y2GjFA5L6V0tjAmcU90AG7kcSPUFp9ButZO+wi27o7ZN76Oj6tQk6lcbGy6vFgiv/Az
         1Rk8YBw/TOtD5+deX8mv9yd+vHvV/OoY4nnNk8e+3uaxlFQIed1fB2AM2GjSCDokcJS1
         dvG7yNuBH8b+kjw6jk2kmaqjPCqxwoBP89YgJ6UcXt+3dfghj8UpM7cpme1SPU9uZ7fF
         tdc+uCGuazdps+POvZZRZ5RnUFpGOe2+0fji7gQUpfKEpXjqMQB/4ywM+z8uCt87rPwh
         Gnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=WhwomO42XDAEJPW2/cr+MUt5RrB/mfN0Bet2spmrCJc=;
        b=LwRVSRtxY1C9plH3k7rr7PfK5/MDABV4teYt6mY5g5ammbmCpuXAB8zL3WBy4V4fa2
         xPxxaP87naxpVFPrZqGBicPPLiAXT1YJ/ZVu2ICeJucvLKb0NH1fdCCWh3vx12SlTlvw
         AGMBSSOHQpm1/nl4AOgg7VyD2EbKMrFnCQtzSDrzhXzfEk5wxxSpZXVDgh7ipEgdZ8Z+
         31ZFy2ICYG102Aq/6qit5ZSjzOodgudnMl0w1r2XIcWIV8GbhiT7782dpcNVYk/nqU2B
         aktCCNZF3kWrRa77+IYAG/YrCIKv/q+/qj0xfEn9gONf2L489BeWE+teZtbJGqGx73eo
         A6gQ==
X-Gm-Message-State: AOAM533DsM9ujUPjlVjkUaJh9UWhml9SYEw/DxA+XfEuPLweDbKhIDMH
        qsfl3BGrwcXkQp7mN5JMSJNyASNu
X-Google-Smtp-Source: ABdhPJyx2w3j+ULg/WvPOv1Le7KmgXlN4DSgH9zS0rLHhdsJdzcMpaPTSNJ+vNXI5VTJVsJany3C2w==
X-Received: by 2002:a05:6e02:1287:: with SMTP id y7mr8107068ilq.63.1590071672276;
        Thu, 21 May 2020 07:34:32 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w26sm3204889ill.19.2020.05.21.07.34.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:34:31 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEYV39000844;
        Thu, 21 May 2020 14:34:31 GMT
Subject: [PATCH v3 09/32] svcrdma: Remove the SVCRDMA_DEBUG macro
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:34:31 -0400
Message-ID: <20200521143430.3557.45150.stgit@klimt.1015granger.net>
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

Clean up: Commit d21b05f101ae ("rdma: SVCRMDA Header File")
introduced the SVCRDMA_DEBUG macro, but it doesn't seem to have been
used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 8518c3f37e56..7ed82625dc0b 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -48,7 +48,6 @@
 #include <linux/sunrpc/rpc_rdma.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/rdma_cm.h>
-#define SVCRDMA_DEBUG
 
 /* Default and maximum inline threshold sizes */
 enum {

